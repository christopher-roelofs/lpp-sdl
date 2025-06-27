/*----------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#------  This File is Part Of : ----------------------------------------------------------------------------------------#
#------- _  -------------------  ______   _   --------------------------------------------------------------------------#
#------ | | ------------------- (_____ \ | |  --------------------------------------------------------------------------#
#------ | | ---  _   _   ____    _____) )| |  ____  _   _   ____   ____   ----------------------------------------------#
#------ | | --- | | | | / _  |  |  ____/ | | / _  || | | | / _  ) / ___)  ----------------------------------------------#
#------ | |_____| |_| |( ( | |  | |      | |( ( | || |_| |( (/ / | |  --------------------------------------------------#
#------ |_______)\____| \_||_|  |_|      |_| \_||_| \__  | \____)|_|  --------------------------------------------------#
#------------------------------------------------- (____/  -------------------------------------------------------------#
#------------------------   ______   _   -------------------------------------------------------------------------------#
#------------------------  (_____ \ | |  -------------------------------------------------------------------------------#
#------------------------   _____) )| | _   _   ___   ------------------------------------------------------------------#
#------------------------  |  ____/ | || | | | /___)  ------------------------------------------------------------------#
#------------------------  | |      | || |_| ||___ |  ------------------------------------------------------------------#
#------------------------  |_|      |_| \____|(___/   ------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#- Licensed under the GPL License --------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#- Copyright (c) Nanni <lpp.nanni@gmail.com> ---------------------------------------------------------------------------#
#- Copyright (c) Rinnegatamante <rinnegatamante@gmail.com> -------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#- SDL Port: Sound Module - Fully implemented with SDL_mixer ----------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------*/

#include <stdlib.h>
#include <string.h>
#include <SDL.h>
#include <SDL_mixer.h>
#include <unordered_map>
#include <vector>
#include <string>
#include <cstring>
#include <algorithm>
#include <mpg123.h>
extern "C" {
#include <libavformat/avformat.h>
#include <libavutil/dict.h>
}
#include "luaplayer.h"
#include "include/audiodec/audio_decoder.h"

#define stringify(str) #str
#define VariableRegister(lua, value) do { lua_pushinteger(lua, value); lua_setglobal (lua, stringify(value)); } while(0)

// SDL_mixer configuration
#define AUDIO_FREQUENCY 44100
#define AUDIO_FORMAT MIX_DEFAULT_FORMAT
#define AUDIO_CHANNELS 2
#define AUDIO_CHUNK_SIZE 2048
#define MAX_SOUND_CHANNELS 8
#define DEFAULT_VOLUME 128

// Sound constants
enum {
	NO_LOOP = 0,
	LOOP = 1
};

// SDL_mixer sound structure - replaces DecodedMusic for SDL port
struct SDLDecodedMusic {
	Mix_Chunk* chunk;          // SDL_mixer chunk for sound effects
	Mix_Music* music;          // SDL_mixer music for background music
	int channel;               // SDL_mixer channel (-1 if not playing)
	bool isPlaying;            // Playback state
	bool loop;                 // Loop flag
	bool pauseTrigger;         // Pause trigger
	int volume;                // Volume (0-128 for SDL_mixer)
	std::string filepath;      // File path
	std::string title;         // Metadata: title
	std::string author;        // Metadata: author
	bool isMusic;              // True if this is music (vs sound effect)
	uint32_t id;               // Unique identifier
};

// Global sound management
static std::unordered_map<uint32_t, SDLDecodedMusic*> soundMap;
static uint32_t nextSoundId = 1;
static bool sdlMixerInitialized = false;

// Helper functions for SDL_mixer implementation

// Initialize SDL_mixer
static bool initSDLMixer() {
	if (sdlMixerInitialized) {
		return true;
	}
	
	// Initialize SDL audio if not already done
	if (SDL_Init(SDL_INIT_AUDIO) < 0) {
		return false;
	}
	
	// Initialize SDL_mixer
	if (Mix_OpenAudio(AUDIO_FREQUENCY, AUDIO_FORMAT, AUDIO_CHANNELS, AUDIO_CHUNK_SIZE) < 0) {
		return false;
	}
	
	// Allocate mixing channels
	Mix_AllocateChannels(MAX_SOUND_CHANNELS);
	
	// Set default volume
	Mix_Volume(-1, DEFAULT_VOLUME);
	Mix_VolumeMusic(DEFAULT_VOLUME);
	
	sdlMixerInitialized = true;
	return true;
}

// Cleanup SDL_mixer
static void cleanupSDLMixer() {
	if (!sdlMixerInitialized) {
		return;
	}
	
	// Stop all sounds and music
	Mix_HaltChannel(-1);
	Mix_HaltMusic();
	
	// Clean up all loaded sounds
	for (auto& pair : soundMap) {
		SDLDecodedMusic* sound = pair.second;
		if (sound->chunk) {
			Mix_FreeChunk(sound->chunk);
		}
		if (sound->music) {
			Mix_FreeMusic(sound->music);
		}
		delete sound;
	}
	soundMap.clear();
	
	// Close SDL_mixer
	Mix_CloseAudio();
	SDL_QuitSubSystem(SDL_INIT_AUDIO);
	
	sdlMixerInitialized = false;
}

// Determine if file should be loaded as music or sound effect
static bool shouldLoadAsMusic(const std::string& filepath) {
	// Get filename without path
	std::string filename = filepath;
	size_t lastSlash = filename.find_last_of("/\\");
	if (lastSlash != std::string::npos) {
		filename = filename.substr(lastSlash + 1);
	}
	
	// Convert filename to lowercase for comparison
	std::string lowerFilename = filename;
	for (char& c : lowerFilename) {
		c = tolower(c);
	}
	
	// Sound effects (should be loaded as chunks for multi-channel playback)
	if (lowerFilename.find("click") != std::string::npos ||
	    lowerFilename.find("beep") != std::string::npos ||
	    lowerFilename.find("sound") != std::string::npos ||
	    lowerFilename.find("effect") != std::string::npos ||
	    lowerFilename.find("sfx") != std::string::npos) {
		return false; // Load as sound effect (chunk)
	}
	
	// Music tracks (should be loaded as music for streaming)
	if (lowerFilename.find("bgm") != std::string::npos ||
	    lowerFilename.find("music") != std::string::npos ||
	    lowerFilename.find("theme") != std::string::npos ||
	    lowerFilename.find("background") != std::string::npos) {
		return true; // Load as music (streaming)
	}
	
	// Default: use file extension as fallback
	size_t dotPos = filepath.find_last_of('.');
	if (dotPos == std::string::npos) {
		return false;
	}
	
	std::string ext = filepath.substr(dotPos + 1);
	for (char& c : ext) {
		c = tolower(c);
	}
	
	// For ambiguous extensions, prefer sound effects (chunks) for better compatibility
	// Only these specific formats will be treated as music by default
	return (ext == "mp3" || ext == "mod" || ext == "it" || ext == "xm" || ext == "s3m");
}

// Helper function to safely copy strings with length limits
static void safeCopyString(std::string& dest, const char* src, size_t maxLen = 256) {
	if (src && strlen(src) > 0) {
		dest = std::string(src, std::min(strlen(src), maxLen));
	}
}

// Extract MP3 metadata using mpg123
static bool extractMP3Metadata(const char* filepath, std::string& title, std::string& artist) {
	static bool mpg123_initialized = false;
	if (!mpg123_initialized) {
		if (mpg123_init() != MPG123_OK) {
			printf("Failed to initialize mpg123\n");
			return false;
		}
		mpg123_initialized = true;
	}
	
	mpg123_handle* handle = mpg123_new(NULL, NULL);
	if (!handle) {
		printf("Failed to create mpg123 handle\n");
		return false;
	}
	
	if (mpg123_open(handle, filepath) != MPG123_OK) {
		printf("Failed to open MP3 file for metadata: %s\n", filepath);
		mpg123_delete(handle);
		return false;
	}
	
	// Scan for metadata
	mpg123_scan(handle);
	
	mpg123_id3v1* v1 = NULL;
	mpg123_id3v2* v2 = NULL;
	
	if (mpg123_id3(handle, &v1, &v2) == MPG123_OK) {
		// Prefer ID3v2 over ID3v1
		if (v2 && v2->title && v2->title->fill > 0) {
			safeCopyString(title, v2->title->p);
		} else if (v1 && strlen(v1->title) > 0) {
			safeCopyString(title, v1->title);
		}
		
		if (v2 && v2->artist && v2->artist->fill > 0) {
			safeCopyString(artist, v2->artist->p);
		} else if (v1 && strlen(v1->artist) > 0) {
			safeCopyString(artist, v1->artist);
		}
	}
	
	mpg123_close(handle);
	mpg123_delete(handle);
	
	return !title.empty() || !artist.empty();
}

// Extract metadata using FFmpeg (works for OGG, FLAC, MP4, etc.)
static bool extractFFmpegMetadata(const char* filepath, std::string& title, std::string& artist) {
	// av_register_all() is deprecated and not needed in newer FFmpeg versions
	static bool ffmpeg_initialized = false;
	if (!ffmpeg_initialized) {
		ffmpeg_initialized = true;
	}
	
	AVFormatContext* formatCtx = NULL;
	if (avformat_open_input(&formatCtx, filepath, NULL, NULL) != 0) {
		printf("Failed to open file for metadata: %s\n", filepath);
		return false;
	}
	
	if (avformat_find_stream_info(formatCtx, NULL) < 0) {
		printf("Failed to find stream info for: %s\n", filepath);
		avformat_close_input(&formatCtx);
		return false;
	}
	
	// Extract metadata from format context
	AVDictionaryEntry* tag = NULL;
	
	// Get title
	tag = av_dict_get(formatCtx->metadata, "title", NULL, AV_DICT_IGNORE_SUFFIX);
	if (tag) {
		safeCopyString(title, tag->value);
	}
	
	// Get artist
	tag = av_dict_get(formatCtx->metadata, "artist", NULL, AV_DICT_IGNORE_SUFFIX);
	if (tag) {
		safeCopyString(artist, tag->value);
	}
	
	// Try alternative keys if standard ones don't work
	if (artist.empty()) {
		tag = av_dict_get(formatCtx->metadata, "album_artist", NULL, AV_DICT_IGNORE_SUFFIX);
		if (tag) {
			safeCopyString(artist, tag->value);
		}
	}
	
	avformat_close_input(&formatCtx);
	
	return !title.empty() || !artist.empty();
}

// Extract WAV metadata from LIST INFO chunks (basic implementation)
static bool extractWAVMetadata(const char* filepath, std::string& title, std::string& artist) {
	FILE* file = fopen(filepath, "rb");
	if (!file) {
		return false;
	}
	
	// Read RIFF header
	char header[12];
	if (fread(header, 1, 12, file) != 12) {
		fclose(file);
		return false;
	}
	
	// Check if it's a valid RIFF/WAVE file
	if (memcmp(header, "RIFF", 4) != 0 || memcmp(header + 8, "WAVE", 4) != 0) {
		fclose(file);
		return false;
	}
	
	// Look for LIST INFO chunk
	uint32_t chunkId, chunkSize;
	bool found = false;
	
	while (fread(&chunkId, 4, 1, file) == 1 && fread(&chunkSize, 4, 1, file) == 1) {
		if (chunkId == 0x5453494C) { // "LIST"
			uint32_t listType;
			if (fread(&listType, 4, 1, file) == 1 && listType == 0x4F464E49) { // "INFO"
				found = true;
				chunkSize -= 4; // Subtract the list type size
				
				// Read INFO chunk contents
				uint32_t pos = 0;
				while (pos < chunkSize) {
					uint32_t infoId, infoSize;
					if (fread(&infoId, 4, 1, file) != 1 || fread(&infoSize, 4, 1, file) != 1) {
						break;
					}
					
					if (infoSize > 256) infoSize = 256; // Safety limit
					
					char* buffer = new char[infoSize + 1];
					if (fread(buffer, 1, infoSize, file) == infoSize) {
						buffer[infoSize] = '\0';
						
						if (infoId == 0x4D414E49) { // "INAM" - title
							title = std::string(buffer);
						} else if (infoId == 0x54524149) { // "IART" - artist
							artist = std::string(buffer);
						}
					}
					delete[] buffer;
					
					pos += 8 + infoSize;
					if (infoSize % 2) { // Skip padding byte if odd size
						fseek(file, 1, SEEK_CUR);
						pos++;
					}
				}
				break;
			} else {
				fseek(file, chunkSize - 4, SEEK_CUR);
			}
		} else {
			fseek(file, chunkSize, SEEK_CUR);
		}
		
		// Align to word boundary
		if (chunkSize % 2) {
			fseek(file, 1, SEEK_CUR);
		}
	}
	
	fclose(file);
	return found && (!title.empty() || !artist.empty());
}

// Enhanced metadata extraction function
static void extractMetadata(SDLDecodedMusic* sound) {
	std::string title, artist;
	bool extracted = false;
	
	// Get file extension
	std::string filepath = sound->filepath;
	std::string ext;
	size_t dotPos = filepath.find_last_of('.');
	if (dotPos != std::string::npos) {
		ext = filepath.substr(dotPos + 1);
		std::transform(ext.begin(), ext.end(), ext.begin(), ::tolower);
	}
	
	// Try format-specific extraction
	if (ext == "mp3") {
		extracted = extractMP3Metadata(sound->filepath.c_str(), title, artist);
		printf("MP3 metadata extraction: %s (title: %s, artist: %s)\n", 
			   extracted ? "success" : "failed", title.c_str(), artist.c_str());
	} else if (ext == "ogg" || ext == "oga" || ext == "flac" || ext == "m4a" || ext == "mp4") {
		extracted = extractFFmpegMetadata(sound->filepath.c_str(), title, artist);
		printf("FFmpeg metadata extraction: %s (title: %s, artist: %s)\n", 
			   extracted ? "success" : "failed", title.c_str(), artist.c_str());
	} else if (ext == "wav" || ext == "wave") {
		extracted = extractWAVMetadata(sound->filepath.c_str(), title, artist);
		printf("WAV metadata extraction: %s (title: %s, artist: %s)\n", 
			   extracted ? "success" : "failed", title.c_str(), artist.c_str());
	}
	
	// Fallback to filename if no metadata found
	if (title.empty()) {
		std::string filename = filepath;
		size_t lastSlash = filename.find_last_of("/\\");
		if (lastSlash != std::string::npos) {
			filename = filename.substr(lastSlash + 1);
		}
		
		// Remove extension
		if (dotPos != std::string::npos) {
			size_t filenameDot = filename.find_last_of('.');
			if (filenameDot != std::string::npos) {
				filename = filename.substr(0, filenameDot);
			}
		}
		
		title = filename;
	}
	
	if (artist.empty()) {
		artist = "Unknown Artist";
	}
	
	// Store the extracted metadata
	sound->title = title;
	sound->author = artist;
	
	printf("Final metadata - Title: '%s', Artist: '%s'\n", title.c_str(), artist.c_str());
}

// Function to decode GSM WAV to PCM data that SDL_mixer can use
static Mix_Chunk* decodeGsmWavToChunk(const char* filepath) {
	printf("Opening GSM WAV file: %s\n", filepath);
	FILE* file = fopen(filepath, "rb");
	if (!file) {
		printf("Failed to open GSM WAV file: %s\n", filepath);
		return nullptr;
	}
	
	// Try to create an audio decoder for the file
	printf("Creating audio decoder for: %s\n", filepath);
	std::unique_ptr<AudioDecoder> decoder = AudioDecoder::Create(file, filepath);
	if (!decoder) {
		printf("Failed to create audio decoder for: %s\n", filepath);
		return nullptr;
	}
	
	// Check if it's actually a GSM format
	if (decoder->GetType() != "gsm") {
		printf("File is not GSM format: %s (type: %s)\n", filepath, decoder->GetType().c_str());
		return nullptr;
	}
	
	// Get audio format info
	int frequency, channels;
	AudioDecoder::Format format;
	decoder->GetFormat(frequency, format, channels);
	
	printf("Decoding GSM WAV: %d Hz, %d channels, format %d\n", frequency, channels, (int)format);
	
	// Decode the entire file to a buffer
	std::vector<uint8_t> pcmBuffer;
	const int bufferSize = 4096;
	uint8_t tempBuffer[bufferSize];
	int iterationCount = 0;
	const int maxIterations = 10000; // Prevent infinite loops
	
	printf("Starting GSM decoding loop...\n");
	while (!decoder->IsFinished() && iterationCount < maxIterations) {
		int bytesRead = decoder->Decode(tempBuffer, bufferSize);
		printf("Iteration %d: decoded %d bytes, finished=%d\n", iterationCount, bytesRead, decoder->IsFinished());
		
		if (bytesRead > 0) {
			pcmBuffer.insert(pcmBuffer.end(), tempBuffer, tempBuffer + bytesRead);
		} else if (bytesRead < 0) {
			printf("Error decoding GSM WAV: %s\n", filepath);
			return nullptr;
		} else if (bytesRead == 0) {
			// No data read, but not finished - possible infinite loop
			printf("Warning: No data read but decoder not finished. Breaking to prevent hang.\n");
			break;
		}
		iterationCount++;
	}
	
	if (iterationCount >= maxIterations) {
		printf("Error: GSM decoding exceeded maximum iterations, possible infinite loop\n");
		return nullptr;
	}
	
	printf("GSM decoding completed after %d iterations\n", iterationCount);
	
	if (pcmBuffer.empty()) {
		printf("No data decoded from GSM WAV: %s\n", filepath);
		return nullptr;
	}
	
	printf("Decoded %zu bytes of PCM data from GSM WAV\n", pcmBuffer.size());
	
	// Create WAV header for the PCM data
	struct WavHeader {
		char riff[4] = {'R', 'I', 'F', 'F'};
		uint32_t chunkSize;
		char wave[4] = {'W', 'A', 'V', 'E'};
		char fmt[4] = {'f', 'm', 't', ' '};
		uint32_t fmtSize = 16;
		uint16_t audioFormat = 1; // PCM
		uint16_t numChannels;
		uint32_t sampleRate;
		uint32_t byteRate;
		uint16_t blockAlign;
		uint16_t bitsPerSample = 16;
		char data[4] = {'d', 'a', 't', 'a'};
		uint32_t dataSize;
	} __attribute__((packed));
	
	WavHeader header;
	header.numChannels = channels;
	header.sampleRate = frequency;
	header.bitsPerSample = (format == AudioDecoder::Format::S16) ? 16 : 8;
	header.byteRate = header.sampleRate * header.numChannels * (header.bitsPerSample / 8);
	header.blockAlign = header.numChannels * (header.bitsPerSample / 8);
	header.dataSize = pcmBuffer.size();
	header.chunkSize = 36 + header.dataSize;
	
	// Create a complete WAV file in memory
	std::vector<uint8_t> wavData;
	wavData.resize(sizeof(WavHeader) + pcmBuffer.size());
	memcpy(wavData.data(), &header, sizeof(WavHeader));
	memcpy(wavData.data() + sizeof(WavHeader), pcmBuffer.data(), pcmBuffer.size());
	
	// Load the WAV data using SDL_mixer
	SDL_RWops* rw = SDL_RWFromMem(wavData.data(), wavData.size());
	if (!rw) {
		printf("Failed to create SDL_RWops for GSM WAV data\n");
		return nullptr;
	}
	
	Mix_Chunk* chunk = Mix_LoadWAV_RW(rw, 1); // 1 = free RW when done
	if (!chunk) {
		printf("Failed to load decoded GSM WAV data: %s\n", Mix_GetError());
		return nullptr;
	}
	
	printf("Successfully created Mix_Chunk from GSM WAV file\n");
	return chunk;
}

// SDL_mixer implementation functions

static int lua_init(lua_State *L) {
	if (initSDLMixer()) {
		return 0;
	} else {
		return luaL_error(L, "Failed to initialize SDL_mixer");
	}
}

static int lua_openMusic(lua_State *L) {
	const char* filepath = luaL_checkstring(L, 1);
	
	if (!initSDLMixer()) {
		return luaL_error(L, "Failed to initialize SDL_mixer");
	}
	
	// Create new sound structure
	SDLDecodedMusic* sound = new SDLDecodedMusic();
	sound->chunk = nullptr;
	sound->music = nullptr;
	sound->channel = -1;
	sound->isPlaying = false;
	sound->loop = false;
	sound->pauseTrigger = false;
	sound->volume = DEFAULT_VOLUME;
	sound->filepath = filepath;
	sound->title = "";
	sound->author = "";
	sound->id = nextSoundId++;
	
	// Determine if this should be loaded as music or sound effect
	// Force click.ogg to be treated as sound effect to prevent looping issues
	if (strstr(filepath, "click") != nullptr) {
		sound->isMusic = false;
	} else {
		sound->isMusic = shouldLoadAsMusic(filepath);
	}
	
	if (sound->isMusic) {
		// Load as music (streaming)
		sound->music = Mix_LoadMUS(filepath);
		if (!sound->music) {
			delete sound;
			return luaL_error(L, "Failed to load music file: %s", Mix_GetError());
		}
	} else {
		// Load as sound effect (chunk)
		sound->chunk = Mix_LoadWAV(filepath);
		if (!sound->chunk) {
			// Check if this is a GSM WAV file that we can decode
			printf("Standard loading failed for %s: %s\n", filepath, Mix_GetError());
			printf("Attempting GSM WAV decoding...\n");
			
			sound->chunk = decodeGsmWavToChunk(filepath);
			if (!sound->chunk) {
				// For truly unsupported formats, create a silent/dummy sound to prevent crashes
				printf("Warning: Unsupported audio format for %s: %s\n", filepath, Mix_GetError());
				printf("Creating silent placeholder sound for compatibility\n");
				
				// Create a proper silent WAV file in memory
				// WAV header + minimal 16-bit PCM data
				static const Uint8 silentWav[] = {
					// RIFF header
					'R', 'I', 'F', 'F',
					36, 0, 0, 0,  // File size - 8
					'W', 'A', 'V', 'E',
					// fmt chunk
					'f', 'm', 't', ' ',
					16, 0, 0, 0,  // fmt chunk size
					1, 0,         // PCM format
					1, 0,         // mono
					44, 172, 0, 0, // 44100 Hz
					88, 88, 1, 0,  // byte rate
					2, 0,         // block align
					16, 0,        // 16 bits per sample
					// data chunk
					'd', 'a', 't', 'a',
					4, 0, 0, 0,   // data size
					0, 0, 0, 0    // 2 samples of silence
				};
				
				SDL_RWops* rw = SDL_RWFromConstMem(silentWav, sizeof(silentWav));
				if (rw) {
					sound->chunk = Mix_LoadWAV_RW(rw, 1); // 1 = free RW when done
					if (!sound->chunk) {
						delete sound;
						return luaL_error(L, "Failed to create fallback sound: %s", Mix_GetError());
					}
				} else {
					delete sound;
					return luaL_error(L, "Failed to create silent WAV data");
				}
			}
		}
	}
	
	// Extract basic metadata
	extractMetadata(sound);
	
	// Store in map
	soundMap[sound->id] = sound;
	
	// Return sound ID as light userdata
	lua_pushlightuserdata(L, (void*)(uintptr_t)sound->id);
	return 1;
}

static int lua_openSound(lua_State *L) {
	// For compatibility, use the same implementation as openMusic
	// SDL_mixer will handle the distinction automatically
	return lua_openMusic(L);
}

static int lua_play(lua_State *L) {
	void* soundPtr = lua_touserdata(L, 1);
	bool loop = false;
	if (lua_gettop(L) > 1) {
		int loopParam = lua_tointeger(L, 2);
		loop = (loopParam != NO_LOOP);  // Only NO_LOOP (0) should be false, everything else true
		// Debug output
		printf("DEBUG: Sound.play called with loop parameter: %d (converted to bool: %s)\n", 
			   loopParam, loop ? "true" : "false");
	}
	
	if (!soundPtr) {
		return luaL_error(L, "Invalid sound object");
	}
	
	uint32_t soundId = (uint32_t)(uintptr_t)soundPtr;
	auto it = soundMap.find(soundId);
	if (it == soundMap.end()) {
		return luaL_error(L, "Sound not found");
	}
	
	SDLDecodedMusic* sound = it->second;
	sound->loop = loop;
	
	if (sound->isMusic) {
		// Play music
		printf("DEBUG: Playing as MUSIC with loop=%s\n", loop ? "true" : "false");
		if (Mix_PlayMusic(sound->music, loop ? -1 : 0) == -1) {
			return luaL_error(L, "Failed to play music: %s", Mix_GetError());
		}
		sound->channel = -1; // Music doesn't use channels
	} else {
		// Play sound effect
		printf("DEBUG: Playing as SOUND EFFECT with loop=%s (SDL param: %d)\n", 
			   loop ? "true" : "false", loop ? -1 : 0);
		int channel = Mix_PlayChannel(-1, sound->chunk, loop ? -1 : 0);
		if (channel == -1) {
			return luaL_error(L, "Failed to play sound: %s", Mix_GetError());
		}
		sound->channel = channel;
	}
	
	sound->isPlaying = true;
	sound->pauseTrigger = false;
	return 0;
}

static int lua_playWav(lua_State *L) {
	// playWav(sound, loop, channel) - compatibility wrapper for Vita games
	// Channel parameter is ignored in SDL implementation as SDL_mixer handles allocation
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc < 2 || argc > 3)
		return luaL_error(L, "wrong number of arguments");
#endif
	
	// Keep only first 2 parameters and call existing play function
	lua_settop(L, 2);
	return lua_play(L);
}

static int lua_pause(lua_State *L) {
	void* soundPtr = lua_touserdata(L, 1);
	if (!soundPtr) {
		return luaL_error(L, "Invalid sound object");
	}
	
	uint32_t soundId = (uint32_t)(uintptr_t)soundPtr;
	auto it = soundMap.find(soundId);
	if (it == soundMap.end()) {
		return luaL_error(L, "Sound not found");
	}
	
	SDLDecodedMusic* sound = it->second;
	if (sound->isMusic) {
		Mix_PauseMusic();
	} else if (sound->channel != -1) {
		Mix_Pause(sound->channel);
	}
	
	sound->pauseTrigger = true;
	return 0;
}

static int lua_resume(lua_State *L) {
	void* soundPtr = lua_touserdata(L, 1);
	if (!soundPtr) {
		return luaL_error(L, "Invalid sound object");
	}
	
	uint32_t soundId = (uint32_t)(uintptr_t)soundPtr;
	auto it = soundMap.find(soundId);
	if (it == soundMap.end()) {
		return luaL_error(L, "Sound not found");
	}
	
	SDLDecodedMusic* sound = it->second;
	if (sound->isMusic) {
		Mix_ResumeMusic();
	} else if (sound->channel != -1) {
		Mix_Resume(sound->channel);
	}
	
	sound->pauseTrigger = false;
	return 0;
}

static int lua_stop(lua_State *L) {
	void* soundPtr = lua_touserdata(L, 1);
	if (!soundPtr) {
		return luaL_error(L, "Invalid sound object");
	}
	
	uint32_t soundId = (uint32_t)(uintptr_t)soundPtr;
	auto it = soundMap.find(soundId);
	if (it == soundMap.end()) {
		return luaL_error(L, "Sound not found");
	}
	
	SDLDecodedMusic* sound = it->second;
	if (sound->isMusic) {
		Mix_HaltMusic();
	} else if (sound->channel != -1) {
		Mix_HaltChannel(sound->channel);
	}
	
	sound->isPlaying = false;
	sound->channel = -1;
	return 0;
}

static int lua_sound_close(lua_State *L) {
	void* soundPtr = lua_touserdata(L, 1);
	if (!soundPtr) {
		return luaL_error(L, "Invalid sound object");
	}
	
	uint32_t soundId = (uint32_t)(uintptr_t)soundPtr;
	auto it = soundMap.find(soundId);
	if (it == soundMap.end()) {
		return 0; // Already closed or invalid
	}
	
	SDLDecodedMusic* sound = it->second;
	
	// Stop playback first
	if (sound->isMusic) {
		Mix_HaltMusic();
	} else if (sound->channel != -1) {
		Mix_HaltChannel(sound->channel);
	}
	
	// Free resources
	if (sound->chunk) {
		Mix_FreeChunk(sound->chunk);
	}
	if (sound->music) {
		Mix_FreeMusic(sound->music);
	}
	
	// Remove from map and delete
	soundMap.erase(it);
	delete sound;
	
	return 0;
}

static int lua_isPlaying(lua_State *L) {
	void* soundPtr = lua_touserdata(L, 1);
	if (!soundPtr) {
		lua_pushboolean(L, 0);
		return 1;
	}
	
	uint32_t soundId = (uint32_t)(uintptr_t)soundPtr;
	auto it = soundMap.find(soundId);
	if (it == soundMap.end()) {
		lua_pushboolean(L, 0);
		return 1;
	}
	
	SDLDecodedMusic* sound = it->second;
	bool playing = false;
	
	if (sound->isMusic) {
		playing = Mix_PlayingMusic() && !Mix_PausedMusic();
	} else if (sound->channel != -1) {
		playing = Mix_Playing(sound->channel) && !Mix_Paused(sound->channel);
	}
	
	sound->isPlaying = playing;
	lua_pushboolean(L, playing);
	return 1;
}

static int lua_setVolume(lua_State *L) {
	void* soundPtr = lua_touserdata(L, 1);
	int volume = luaL_checkinteger(L, 2);
	
	if (!soundPtr) {
		return luaL_error(L, "Invalid sound object");
	}
	
	// Convert from Vita volume range (0-32767) to SDL_mixer range (0-128)
	int sdlVolume = (volume * 128) / 32767;
	sdlVolume = (sdlVolume > 128) ? 128 : ((sdlVolume < 0) ? 0 : sdlVolume);
	
	uint32_t soundId = (uint32_t)(uintptr_t)soundPtr;
	auto it = soundMap.find(soundId);
	if (it == soundMap.end()) {
		return luaL_error(L, "Sound not found");
	}
	
	SDLDecodedMusic* sound = it->second;
	sound->volume = sdlVolume;
	
	if (sound->isMusic) {
		Mix_VolumeMusic(sdlVolume);
	} else if (sound->chunk) {
		Mix_VolumeChunk(sound->chunk, sdlVolume);
	}
	
	return 0;
}

static int lua_getVolume(lua_State *L) {
	void* soundPtr = lua_touserdata(L, 1);
	if (!soundPtr) {
		lua_pushinteger(L, 0);
		return 1;
	}
	
	uint32_t soundId = (uint32_t)(uintptr_t)soundPtr;
	auto it = soundMap.find(soundId);
	if (it == soundMap.end()) {
		lua_pushinteger(L, 0);
		return 1;
	}
	
	SDLDecodedMusic* sound = it->second;
	// Convert from SDL_mixer range (0-128) to Vita range (0-32767)
	int vitaVolume = (sound->volume * 32767) / 128;
	lua_pushinteger(L, vitaVolume);
	return 1;
}

static int lua_getTitle(lua_State *L) {
	void* soundPtr = lua_touserdata(L, 1);
	if (!soundPtr) {
		lua_pushstring(L, "");
		return 1;
	}
	
	uint32_t soundId = (uint32_t)(uintptr_t)soundPtr;
	auto it = soundMap.find(soundId);
	if (it == soundMap.end()) {
		lua_pushstring(L, "");
		return 1;
	}
	
	SDLDecodedMusic* sound = it->second;
	lua_pushstring(L, sound->title.c_str());
	return 1;
}

static int lua_getAuthor(lua_State *L) {
	void* soundPtr = lua_touserdata(L, 1);
	if (!soundPtr) {
		lua_pushstring(L, "");
		return 1;
	}
	
	uint32_t soundId = (uint32_t)(uintptr_t)soundPtr;
	auto it = soundMap.find(soundId);
	if (it == soundMap.end()) {
		lua_pushstring(L, "");
		return 1;
	}
	
	SDLDecodedMusic* sound = it->second;
	lua_pushstring(L, sound->author.c_str());
	return 1;
}

static int lua_term(lua_State *L) {
	cleanupSDLMixer();
	return 0;
}

//Register our Sound Functions
static const luaL_Reg Sound_functions[] = {
  {"init",          lua_init},
  {"term",          lua_term},
  {"open",          lua_openMusic},
  {"openMusic",     lua_openMusic},
  {"openOgg",       lua_openSound},
  {"openWav",       lua_openSound},
  {"play",          lua_play},
  {"playWav",       lua_playWav},
  {"pause",         lua_pause},
  {"resume",        lua_resume},
  {"stop",          lua_stop},
  {"close",         lua_sound_close},
  {"isPlaying",     lua_isPlaying},
  {"setVolume",     lua_setVolume},
  {"getVolume",     lua_getVolume},
  {"getTitle",      lua_getTitle},
  {"getAuthor",     lua_getAuthor},
  {0, 0}
};

void luaSound_init(lua_State *L) {
	lua_newtable(L);
	luaL_setfuncs(L, Sound_functions, 0);
	lua_setglobal(L, "Sound");
	VariableRegister(L, NO_LOOP);
	VariableRegister(L, LOOP);
}