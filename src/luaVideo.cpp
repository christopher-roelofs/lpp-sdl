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
#- SDL Port: Video Module with FFmpeg Implementation -------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unordered_map>
#include <string>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <chrono>
#include <atomic>
#include <fstream>
#include <sstream>
#include <vector>
#include <regex>
#include <algorithm>
#include <cctype>

extern "C" {
#include <libavformat/avformat.h>
#include <libavcodec/avcodec.h>
#include <libavutil/imgutils.h>
#include <libswscale/swscale.h>
}

#include <SDL.h>
#include "luaplayer.h"

#define stringify(str) #str
#define VariableRegister(lua, value) do { lua_pushinteger(lua, value); lua_setglobal (lua, stringify(value)); } while(0)

// Forward declaration for texture integration
extern SDL_Renderer* g_renderer; // Should be defined in main SDL module

// Subtitle entry structure
struct SubtitleEntry {
    int64_t startTime; // in milliseconds
    int64_t endTime;   // in milliseconds
    std::string text;
    
    SubtitleEntry(int64_t start, int64_t end, const std::string& txt) 
        : startTime(start), endTime(end), text(txt) {}
};

// Video player state
struct VideoPlayer {
    AVFormatContext* formatContext;
    AVCodecContext* codecContext;
    AVStream* videoStream;
    AVStream* audioStream;
    AVCodecContext* audioCodecContext;
    struct SwsContext* swsContext;
    
    // Audio playback
    SDL_AudioDeviceID audioDevice;
    SDL_AudioSpec audioSpec;
    bool audioInitialized;
    AVFrame* frame;
    AVFrame* frameRGB;
    uint8_t* buffer;
    SDL_Texture* texture;
    lpp_texture* lppTexture; // LPP-compatible texture wrapper
    
    // Playback state
    std::atomic<bool> isPlaying;
    std::atomic<bool> isPaused;
    std::atomic<bool> shouldStop;
    std::atomic<int64_t> currentPTS;
    std::atomic<int> playbackSpeed; // 100 = normal, 200 = 2x, etc.
    
    // Threading
    std::thread decodingThread;
    std::mutex frameMutex;
    std::condition_variable frameCV;
    bool frameReady;
    
    // Subtitles
    std::string subtitleText;
    std::mutex subtitleMutex;
    std::vector<SubtitleEntry> subtitles;
    
    // Dimensions
    int width;
    int height;
    
    VideoPlayer() : formatContext(nullptr), codecContext(nullptr), videoStream(nullptr),
                   audioStream(nullptr), audioCodecContext(nullptr), swsContext(nullptr), 
                   audioDevice(0), audioInitialized(false), frame(nullptr), frameRGB(nullptr), buffer(nullptr),
                   texture(nullptr), lppTexture(nullptr), isPlaying(false), isPaused(false),
                   shouldStop(false), currentPTS(0), playbackSpeed(100), frameReady(false),
                   width(0), height(0) {}
                   
    ~VideoPlayer() {
        cleanup();
    }
    
    void cleanup() {
        shouldStop = true;
        
        if (decodingThread.joinable()) {
            decodingThread.join();
        }
        
        if (texture) {
            SDL_DestroyTexture(texture);
            texture = nullptr;
        }
        
        if (lppTexture) {
            delete lppTexture;
            lppTexture = nullptr;
        }
        
        if (buffer) {
            av_free(buffer);
            buffer = nullptr;
        }
        
        if (frameRGB) {
            av_frame_free(&frameRGB);
        }
        
        if (frame) {
            av_frame_free(&frame);
        }
        
        if (swsContext) {
            sws_freeContext(swsContext);
            swsContext = nullptr;
        }
        
        if (codecContext) {
            avcodec_free_context(&codecContext);
        }
        
        if (audioCodecContext) {
            avcodec_free_context(&audioCodecContext);
        }
        
        if (audioInitialized && audioDevice > 0) {
            SDL_CloseAudioDevice(audioDevice);
            audioInitialized = false;
        }
        
        if (formatContext) {
            avformat_close_input(&formatContext);
        }
    }
};

static VideoPlayer* g_videoPlayer = nullptr;
static std::mutex g_playerMutex;
static bool g_ffmpegInitialized = false;

// Helper function to get current time in microseconds
static int64_t getCurrentTimeMicros() {
    auto now = std::chrono::high_resolution_clock::now();
    auto duration = now.time_since_epoch();
    return std::chrono::duration_cast<std::chrono::microseconds>(duration).count();
}

// Parse VTT timestamp (mm:ss.mmm or hh:mm:ss.mmm) to milliseconds
static int64_t parseVTTTimestamp(const std::string& timestamp) {
    std::regex timeRegex(R"((?:(\d+):)?(\d+):(\d+)\.(\d+))");
    std::smatch matches;
    
    if (std::regex_match(timestamp, matches, timeRegex)) {
        int64_t hours = 0;
        int64_t minutes = 0;
        int64_t seconds = 0;
        int64_t milliseconds = 0;
        
        if (matches[1].matched) {
            // hh:mm:ss.mmm format
            hours = std::stoll(matches[1].str());
            minutes = std::stoll(matches[2].str());
            seconds = std::stoll(matches[3].str());
            milliseconds = std::stoll(matches[4].str());
        } else {
            // mm:ss.mmm format
            minutes = std::stoll(matches[2].str());
            seconds = std::stoll(matches[3].str());
            milliseconds = std::stoll(matches[4].str());
        }
        
        return hours * 3600000 + minutes * 60000 + seconds * 1000 + milliseconds;
    }
    
    return 0;
}

// Parse SRT timestamp (hh:mm:ss,mmm) to milliseconds
static int64_t parseSRTTimestamp(const std::string& timestamp) {
    std::regex timeRegex(R"((\d+):(\d+):(\d+),(\d+))");
    std::smatch matches;
    
    if (std::regex_match(timestamp, matches, timeRegex)) {
        int64_t hours = std::stoll(matches[1].str());
        int64_t minutes = std::stoll(matches[2].str());
        int64_t seconds = std::stoll(matches[3].str());
        int64_t milliseconds = std::stoll(matches[4].str());
        
        return hours * 3600000 + minutes * 60000 + seconds * 1000 + milliseconds;
    }
    
    return 0;
}

// Parse VTT subtitle file
static bool parseVTTFile(const std::string& filepath, std::vector<SubtitleEntry>& subtitles) {
    std::ifstream file(filepath);
    if (!file.is_open()) {
        printf("Failed to open subtitle file: %s\n", filepath.c_str());
        return false;
    }
    
    std::string line;
    bool isWebVTT = false;
    
    // Check for WEBVTT header
    if (std::getline(file, line)) {
        if (line.find("WEBVTT") != std::string::npos) {
            isWebVTT = true;
            printf("Parsing WebVTT subtitle file\n");
        } else {
            printf("Invalid VTT file format\n");
            return false;
        }
    }
    
    std::regex timingRegex(R"((\d+:\d+\.\d+)\s*-->\s*(\d+:\d+\.\d+))");
    
    while (std::getline(file, line)) {
        // Skip empty lines
        if (line.empty()) continue;
        
        std::smatch matches;
        if (std::regex_search(line, matches, timingRegex)) {
            // Found timing line
            std::string startTimeStr = matches[1].str();
            std::string endTimeStr = matches[2].str();
            
            int64_t startTime = parseVTTTimestamp(startTimeStr);
            int64_t endTime = parseVTTTimestamp(endTimeStr);
            
            // Read subtitle text (may be multiple lines)
            std::string subtitleText;
            while (std::getline(file, line) && !line.empty()) {
                if (!subtitleText.empty()) {
                    subtitleText += "\n";
                }
                subtitleText += line;
            }
            
            if (!subtitleText.empty()) {
                subtitles.emplace_back(startTime, endTime, subtitleText);
                printf("Subtitle: %s -> %s: %s\n", startTimeStr.c_str(), endTimeStr.c_str(), subtitleText.c_str());
            }
        }
    }
    
    printf("Loaded %zu subtitle entries\n", subtitles.size());
    return true;
}

// Helper function to trim whitespace and carriage returns
static std::string trim(const std::string& str) {
    size_t start = str.find_first_not_of(" \t\r\n");
    if (start == std::string::npos) return "";
    size_t end = str.find_last_not_of(" \t\r\n");
    return str.substr(start, end - start + 1);
}

// Parse SRT subtitle file
static bool parseSRTFile(const std::string& filepath, std::vector<SubtitleEntry>& subtitles) {
    std::ifstream file(filepath);
    if (!file.is_open()) {
        printf("Failed to open subtitle file: %s\n", filepath.c_str());
        return false;
    }
    
    std::string line;
    printf("Parsing SRT subtitle file\n");
    
    std::regex timingRegex(R"((\d+:\d+:\d+,\d+)\s*-->\s*(\d+:\d+:\d+,\d+))");
    
    while (std::getline(file, line)) {
        line = trim(line);
        
        // Skip empty lines
        if (line.empty()) continue;
        
        // Check if this line is a subtitle number (just digits)
        if (std::regex_match(line, std::regex(R"(\d+)"))) {
            // This is a subtitle number, read the next line for timing
            if (std::getline(file, line)) {
                line = trim(line);
                std::smatch matches;
                if (std::regex_search(line, matches, timingRegex)) {
                    // Found timing line
                    std::string startTimeStr = matches[1].str();
                    std::string endTimeStr = matches[2].str();
                    
                    int64_t startTime = parseSRTTimestamp(startTimeStr);
                    int64_t endTime = parseSRTTimestamp(endTimeStr);
                    
                    // Read subtitle text (may be multiple lines)
                    std::string subtitleText;
                    while (std::getline(file, line)) {
                        line = trim(line);
                        if (line.empty()) break; // Empty line ends the subtitle
                        
                        if (!subtitleText.empty()) {
                            subtitleText += "\n";
                        }
                        subtitleText += line;
                    }
                    
                    if (!subtitleText.empty()) {
                        subtitles.emplace_back(startTime, endTime, subtitleText);
                        printf("Subtitle: %s -> %s: %s\n", startTimeStr.c_str(), endTimeStr.c_str(), subtitleText.c_str());
                    }
                }
            }
        }
    }
    
    printf("Loaded %zu subtitle entries\n", subtitles.size());
    return true;
}

// Update current subtitle based on video time
static void updateCurrentSubtitle(VideoPlayer* player, int64_t currentTimeMs) {
    std::lock_guard<std::mutex> lock(player->subtitleMutex);
    
    // Find current subtitle
    std::string newSubtitle = "";
    for (const auto& sub : player->subtitles) {
        if (currentTimeMs >= sub.startTime && currentTimeMs <= sub.endTime) {
            newSubtitle = sub.text;
            break;
        }
    }
    
    // Only update if subtitle changed to avoid unnecessary updates
    if (player->subtitleText != newSubtitle) {
        player->subtitleText = newSubtitle;
    }
}

// Convert AVFrame to RGB buffer (thread-safe, no SDL texture access)
static void frameToRGBBuffer(VideoPlayer* player) {
    if (!player->frame || !player->frameRGB || !player->swsContext) return;
    
    sws_scale(player->swsContext, 
              (const uint8_t* const*)player->frame->data, player->frame->linesize, 
              0, player->height,
              player->frameRGB->data, player->frameRGB->linesize);
}

// Update SDL texture from RGB buffer (main thread only)
static void updateSDLTexture(VideoPlayer* player) {
    if (!player->frameRGB || !player->texture) return;
    
    void* pixels;
    int pitch;
    if (SDL_LockTexture(player->texture, nullptr, &pixels, &pitch) == 0) {
        memcpy(pixels, player->frameRGB->data[0], player->height * player->frameRGB->linesize[0]);
        SDL_UnlockTexture(player->texture);
    }
}

// Video decoding thread
static void videoDecodingThread(VideoPlayer* player) {
    AVPacket* packet = av_packet_alloc();
    if (!packet) return;
    
    int64_t startTime = getCurrentTimeMicros();
    int64_t baseTime = 0;
    
    while (!player->shouldStop) {
        if (player->isPaused) {
            std::this_thread::sleep_for(std::chrono::milliseconds(10));
            continue;
        }
        
        if (av_read_frame(player->formatContext, packet) >= 0) {
            if (packet->stream_index == player->videoStream->index) {
                // Process video packet
                if (avcodec_send_packet(player->codecContext, packet) >= 0) {
                    if (avcodec_receive_frame(player->codecContext, player->frame) >= 0) {
                        // Calculate timing
                        int64_t pts = player->frame->pts;
                        if (pts != AV_NOPTS_VALUE) {
                            player->currentPTS = pts;
                            
                            // Convert PTS to microseconds
                            int64_t framePTS = av_rescale_q(pts, player->videoStream->time_base, {1, 1000000});
                            
                            // Apply playback speed
                            int64_t adjustedPTS = framePTS * 100 / player->playbackSpeed;
                            
                            // Wait for proper timing
                            int64_t currentTime = getCurrentTimeMicros();
                            int64_t targetTime = startTime + adjustedPTS - baseTime;
                            
                            if (targetTime > currentTime) {
                                std::this_thread::sleep_for(std::chrono::microseconds(targetTime - currentTime));
                            }
                            
                            // Convert frame to RGB buffer (thread-safe)
                            {
                                std::lock_guard<std::mutex> lock(player->frameMutex);
                                frameToRGBBuffer(player);
                                player->frameReady = true;
                                // printf("Frame decoded\n"); // Debug
                            }
                            player->frameCV.notify_one();
                            
                            // Update subtitles based on current video time
                            if (!player->subtitles.empty()) {
                                int64_t currentTimeMs = av_rescale_q(pts, player->videoStream->time_base, {1, 1000});
                                updateCurrentSubtitle(player, currentTimeMs);
                            }
                        }
                    }
                }
            } else if (player->audioStream && packet->stream_index == player->audioStream->index && player->audioInitialized) {
                // Process audio packet
                AVFrame* audioFrame = av_frame_alloc();
                if (audioFrame) {
                    if (avcodec_send_packet(player->audioCodecContext, packet) >= 0) {
                        while (avcodec_receive_frame(player->audioCodecContext, audioFrame) >= 0) {
                            // Convert audio frame to SDL format and queue it
                            int data_size = av_get_bytes_per_sample(player->audioCodecContext->sample_fmt);
                            if (data_size < 0) {
                                break;
                            }
                            
                            // Simple audio conversion - just take the first channel for now
                            // TODO: Proper audio resampling for multi-channel and different formats
                            if (player->audioCodecContext->sample_fmt == AV_SAMPLE_FMT_S16) {
                                // Direct copy for 16-bit signed samples
                                int samples = audioFrame->nb_samples * player->audioCodecContext->ch_layout.nb_channels;
                                SDL_QueueAudio(player->audioDevice, audioFrame->data[0], samples * sizeof(int16_t));
                            } else if (player->audioCodecContext->sample_fmt == AV_SAMPLE_FMT_FLTP) {
                                // Convert float planar to 16-bit interleaved
                                int16_t* output = new int16_t[audioFrame->nb_samples * player->audioCodecContext->ch_layout.nb_channels];
                                float** input = (float**)audioFrame->data;
                                int channels = player->audioCodecContext->ch_layout.nb_channels;
                                
                                for (int i = 0; i < audioFrame->nb_samples; i++) {
                                    for (int ch = 0; ch < channels; ch++) {
                                        float sample = input[ch][i];
                                        // Clamp and convert to 16-bit
                                        if (sample > 1.0f) sample = 1.0f;
                                        if (sample < -1.0f) sample = -1.0f;
                                        output[i * channels + ch] = (int16_t)(sample * 32767.0f);
                                    }
                                }
                                
                                SDL_QueueAudio(player->audioDevice, output, audioFrame->nb_samples * channels * sizeof(int16_t));
                                delete[] output;
                            }
                        }
                    }
                    av_frame_free(&audioFrame);
                }
            }
            av_packet_unref(packet);
        } else {
            // End of file - could loop here if desired
            break;
        }
    }
    
    av_packet_free(&packet);
    player->isPlaying = false;
}

// Lua Functions

static int lua_init(lua_State *L) {
    if (!g_ffmpegInitialized) {
        // Initialize FFmpeg (new API style)
        printf("Initializing FFmpeg...\n");
        g_ffmpegInitialized = true;
    }
    return 0;
}

static int lua_video_open(lua_State *L) {
    const char* filepath = luaL_checkstring(L, 1);
    
    std::lock_guard<std::mutex> lock(g_playerMutex);
    
    // Clean up existing player
    if (g_videoPlayer) {
        delete g_videoPlayer;
    }
    
    g_videoPlayer = new VideoPlayer();
    VideoPlayer* player = g_videoPlayer;
    
    // Open video file
    if (avformat_open_input(&player->formatContext, filepath, nullptr, nullptr) != 0) {
        delete g_videoPlayer;
        g_videoPlayer = nullptr;
        return luaL_error(L, "Could not open video file: %s", filepath);
    }
    
    // Retrieve stream information
    if (avformat_find_stream_info(player->formatContext, nullptr) < 0) {
        delete g_videoPlayer;
        g_videoPlayer = nullptr;
        return luaL_error(L, "Could not find stream information");
    }
    
    // Find video and audio streams
    int videoStreamIndex = -1;
    int audioStreamIndex = -1;
    for (unsigned int i = 0; i < player->formatContext->nb_streams; i++) {
        if (player->formatContext->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_VIDEO && videoStreamIndex == -1) {
            videoStreamIndex = i;
        } else if (player->formatContext->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_AUDIO && audioStreamIndex == -1) {
            audioStreamIndex = i;
        }
    }
    
    if (videoStreamIndex == -1) {
        delete g_videoPlayer;
        g_videoPlayer = nullptr;
        return luaL_error(L, "Could not find video stream");
    }
    
    player->videoStream = player->formatContext->streams[videoStreamIndex];
    
    // Set up audio stream if available
    if (audioStreamIndex != -1) {
        player->audioStream = player->formatContext->streams[audioStreamIndex];
        
        // Get audio codec
        const AVCodec* audioCodec = avcodec_find_decoder(player->audioStream->codecpar->codec_id);
        if (audioCodec) {
            player->audioCodecContext = avcodec_alloc_context3(audioCodec);
            if (player->audioCodecContext) {
                if (avcodec_parameters_to_context(player->audioCodecContext, player->audioStream->codecpar) >= 0) {
                    if (avcodec_open2(player->audioCodecContext, audioCodec, nullptr) >= 0) {
                        printf("Audio stream found: %d channels, %d Hz\n", 
                               player->audioCodecContext->ch_layout.nb_channels, 
                               player->audioCodecContext->sample_rate);
                        
                        // Initialize SDL audio
                        SDL_AudioSpec want, have;
                        SDL_zero(want);
                        want.freq = player->audioCodecContext->sample_rate;
                        want.format = AUDIO_S16SYS; // 16-bit signed audio
                        want.channels = player->audioCodecContext->ch_layout.nb_channels;
                        want.samples = 1024; // Buffer size
                        want.callback = nullptr; // We'll use SDL_QueueAudio instead
                        
                        player->audioDevice = SDL_OpenAudioDevice(nullptr, 0, &want, &have, 0);
                        if (player->audioDevice > 0) {
                            player->audioSpec = have;
                            player->audioInitialized = true;
                            printf("SDL Audio initialized: %d Hz, %d channels, %d samples\n", 
                                   have.freq, have.channels, have.samples);
                            SDL_PauseAudioDevice(player->audioDevice, 0); // Start audio
                        } else {
                            printf("Failed to open audio device: %s\n", SDL_GetError());
                        }
                    }
                }
            }
        }
    }
    
    // Get video codec
    const AVCodec* codec = avcodec_find_decoder(player->videoStream->codecpar->codec_id);
    if (!codec) {
        delete g_videoPlayer;
        g_videoPlayer = nullptr;
        return luaL_error(L, "Codec not found");
    }
    
    // Create codec context
    player->codecContext = avcodec_alloc_context3(codec);
    if (!player->codecContext) {
        delete g_videoPlayer;
        g_videoPlayer = nullptr;
        return luaL_error(L, "Could not allocate codec context");
    }
    
    // Copy codec parameters
    if (avcodec_parameters_to_context(player->codecContext, player->videoStream->codecpar) < 0) {
        delete g_videoPlayer;
        g_videoPlayer = nullptr;
        return luaL_error(L, "Could not copy codec parameters");
    }
    
    // Open codec
    if (avcodec_open2(player->codecContext, codec, nullptr) < 0) {
        delete g_videoPlayer;
        g_videoPlayer = nullptr;
        return luaL_error(L, "Could not open codec");
    }
    
    // Get video dimensions
    player->width = player->codecContext->width;
    player->height = player->codecContext->height;
    
    // Allocate frames
    player->frame = av_frame_alloc();
    player->frameRGB = av_frame_alloc();
    
    if (!player->frame || !player->frameRGB) {
        delete g_videoPlayer;
        g_videoPlayer = nullptr;
        return luaL_error(L, "Could not allocate frames");
    }
    
    // Allocate buffer for RGB frame
    int numBytes = av_image_get_buffer_size(AV_PIX_FMT_RGB24, player->width, player->height, 1);
    player->buffer = (uint8_t*)av_malloc(numBytes * sizeof(uint8_t));
    
    av_image_fill_arrays(player->frameRGB->data, player->frameRGB->linesize,
                        player->buffer, AV_PIX_FMT_RGB24, player->width, player->height, 1);
    
    // Initialize scaler
    player->swsContext = sws_getContext(player->width, player->height, player->codecContext->pix_fmt,
                                       player->width, player->height, AV_PIX_FMT_RGB24,
                                       SWS_BILINEAR, nullptr, nullptr, nullptr);
    
    if (!player->swsContext) {
        delete g_videoPlayer;
        g_videoPlayer = nullptr;
        return luaL_error(L, "Could not initialize scaler");
    }
    
    // Create SDL texture
    extern SDL_Renderer* g_renderer; // This should be available from the main SDL graphics module
    if (g_renderer) {
        player->texture = SDL_CreateTexture(g_renderer, SDL_PIXELFORMAT_RGB24, 
                                          SDL_TEXTUREACCESS_STREAMING,
                                          player->width, player->height);
        if (!player->texture) {
            printf("Warning: Could not create SDL texture for video: %s\n", SDL_GetError());
        } else {
            // Create LPP-compatible texture wrapper
            player->lppTexture = new lpp_texture();
            player->lppTexture->magic = 0xABADBEEF;
            player->lppTexture->texture = player->texture;
            player->lppTexture->data = nullptr;
            player->lppTexture->w = player->width;
            player->lppTexture->h = player->height;
        }
    } else {
        printf("Warning: No SDL renderer available for video texture\n");
    }
    
    printf("Video opened successfully: %dx%d\n", player->width, player->height);
    
    // Start decoding thread
    player->shouldStop = false;
    player->isPlaying = true;
    player->decodingThread = std::thread(videoDecodingThread, player);
    
    return 0;
}

static int lua_openSubs(lua_State *L) {
    const char* subtitlePath = luaL_checkstring(L, 1);
    
    std::lock_guard<std::mutex> lock(g_playerMutex);
    
    if (!g_videoPlayer) {
        return luaL_error(L, "No video file is currently open");
    }
    
    // Clear existing subtitles
    g_videoPlayer->subtitles.clear();
    
    // Determine file type by extension
    std::string pathStr(subtitlePath);
    std::string extension;
    size_t lastDot = pathStr.find_last_of('.');
    if (lastDot != std::string::npos) {
        extension = pathStr.substr(lastDot + 1);
        // Convert to lowercase for comparison
        std::transform(extension.begin(), extension.end(), extension.begin(), ::tolower);
    }
    
    bool success = false;
    if (extension == "srt") {
        // Parse SRT file
        success = parseSRTFile(subtitlePath, g_videoPlayer->subtitles);
    } else if (extension == "vtt") {
        // Parse VTT file
        success = parseVTTFile(subtitlePath, g_videoPlayer->subtitles);
    } else {
        // Try to detect format by attempting to parse as both
        printf("Unknown subtitle format, trying SRT first...\n");
        success = parseSRTFile(subtitlePath, g_videoPlayer->subtitles);
        if (!success || g_videoPlayer->subtitles.empty()) {
            printf("SRT parsing failed, trying VTT...\n");
            g_videoPlayer->subtitles.clear();
            success = parseVTTFile(subtitlePath, g_videoPlayer->subtitles);
        }
    }
    
    if (success) {
        printf("Successfully loaded %zu subtitles from: %s\n", g_videoPlayer->subtitles.size(), subtitlePath);
    } else {
        printf("Failed to load subtitles from: %s\n", subtitlePath);
    }
    
    return 0;
}

static int lua_getOutput(lua_State *L) {
    std::lock_guard<std::mutex> lock(g_playerMutex);
    
    if (!g_videoPlayer || !g_videoPlayer->lppTexture) {
        lua_pushinteger(L, 0);
        return 1;
    }
    
    // Update SDL texture from RGB buffer if new frame is ready (main thread safe)
    {
        std::lock_guard<std::mutex> frameLock(g_videoPlayer->frameMutex);
        if (g_videoPlayer->frameReady) {
            updateSDLTexture(g_videoPlayer);
            g_videoPlayer->frameReady = false;
            // printf("Frame updated\n"); // Debug
        }
    }
    
    // Return the lpp_texture as userdata (compatible with Graphics module)
    lua_pushlightuserdata(L, g_videoPlayer->lppTexture);
    return 1;
}

static int lua_video_close(lua_State *L) {
    std::lock_guard<std::mutex> lock(g_playerMutex);
    
    if (g_videoPlayer) {
        delete g_videoPlayer;
        g_videoPlayer = nullptr;
    }
    
    return 0;
}

static int lua_getTime(lua_State *L) {
    std::lock_guard<std::mutex> lock(g_playerMutex);
    
    if (!g_videoPlayer) {
        lua_pushinteger(L, 0);
        return 1;
    }
    
    // Convert PTS to milliseconds
    int64_t timeMs = av_rescale_q(g_videoPlayer->currentPTS, 
                                 g_videoPlayer->videoStream->time_base, 
                                 {1, 1000});
    lua_pushinteger(L, timeMs);
    return 1;
}

static int lua_jumpToTime(lua_State *L) {
    int64_t timeMs = luaL_checkinteger(L, 1);
    
    std::lock_guard<std::mutex> lock(g_playerMutex);
    
    if (!g_videoPlayer) {
        return 0;
    }
    
    // Convert milliseconds to stream time base
    int64_t seekPTS = av_rescale_q(timeMs, {1, 1000}, g_videoPlayer->videoStream->time_base);
    
    if (av_seek_frame(g_videoPlayer->formatContext, g_videoPlayer->videoStream->index, 
                     seekPTS, AVSEEK_FLAG_BACKWARD) >= 0) {
        avcodec_flush_buffers(g_videoPlayer->codecContext);
        printf("Seeked to time: %lld ms\n", timeMs);
    }
    
    return 0;
}

static int lua_pause(lua_State *L) {
    std::lock_guard<std::mutex> lock(g_playerMutex);
    
    if (g_videoPlayer) {
        g_videoPlayer->isPaused = true;
        g_videoPlayer->isPlaying = false;
        
        // Pause audio
        if (g_videoPlayer->audioInitialized && g_videoPlayer->audioDevice > 0) {
            SDL_PauseAudioDevice(g_videoPlayer->audioDevice, 1);
        }
    }
    
    return 0;
}

static int lua_resume(lua_State *L) {
    std::lock_guard<std::mutex> lock(g_playerMutex);
    
    if (g_videoPlayer) {
        g_videoPlayer->isPaused = false;
        g_videoPlayer->isPlaying = true;
        
        // Resume audio
        if (g_videoPlayer->audioInitialized && g_videoPlayer->audioDevice > 0) {
            SDL_PauseAudioDevice(g_videoPlayer->audioDevice, 0);
        }
    }
    
    return 0;
}

static int lua_isPlaying(lua_State *L) {
    std::lock_guard<std::mutex> lock(g_playerMutex);
    
    bool playing = g_videoPlayer && g_videoPlayer->isPlaying && !g_videoPlayer->isPaused;
    lua_pushboolean(L, playing);
    return 1;
}

static int lua_setVolume(lua_State *L) {
    // Audio volume would be handled by the audio system
    return 0;
}

static int lua_getVolume(lua_State *L) {
    lua_pushinteger(L, 100);
    return 1;
}

static int lua_getSubs(lua_State *L) {
    std::lock_guard<std::mutex> lock(g_playerMutex);
    
    if (g_videoPlayer) {
        std::lock_guard<std::mutex> subLock(g_videoPlayer->subtitleMutex);
        const char* subText = g_videoPlayer->subtitleText.c_str();
        // Avoid empty strings that cause TTF rendering issues
        lua_pushstring(L, strlen(subText) > 0 ? subText : " ");
    } else {
        lua_pushstring(L, " ");
    }
    return 1;
}

static int lua_setPlayMode(lua_State *L) {
    int mode = luaL_checkinteger(L, 1);
    
    std::lock_guard<std::mutex> lock(g_playerMutex);
    
    if (g_videoPlayer) {
        g_videoPlayer->playbackSpeed = mode;
        printf("Playback speed set to: %dx\n", mode / 100);
    }
    
    return 0;
}

//Register our Video Functions
static const luaL_Reg Video_functions[] = {
  {"init",          lua_init},
  {"open",          lua_video_open},
  {"openSubs",      lua_openSubs},
  {"getOutput",     lua_getOutput},
  {"close",         lua_video_close},
  {"getTime",       lua_getTime},
  {"jumpToTime",    lua_jumpToTime},
  {"pause",         lua_pause},
  {"resume",        lua_resume},
  {"isPlaying",     lua_isPlaying},
  {"setVolume",     lua_setVolume},
  {"getVolume",     lua_getVolume},
  {"getSubs",       lua_getSubs},
  {"setPlayMode",   lua_setPlayMode},
  {0, 0}
};

void luaVideo_init(lua_State *L) {
	lua_newtable(L);
	luaL_setfuncs(L, Video_functions, 0);
	lua_setglobal(L, "Video");
	
	// Video playback mode constants
	int NORMAL_MODE = 100;
	int FAST_FORWARD_2X_MODE = 200;
	int FAST_FORWARD_4X_MODE = 400;
	int FAST_FORWARD_8X_MODE = 800;
	int FAST_FORWARD_16X_MODE = 1600;
	int FAST_FORWARD_32X_MODE = 3200;
	VariableRegister(L, NORMAL_MODE);
	VariableRegister(L, FAST_FORWARD_2X_MODE);
	VariableRegister(L, FAST_FORWARD_4X_MODE);
	VariableRegister(L, FAST_FORWARD_8X_MODE);
	VariableRegister(L, FAST_FORWARD_16X_MODE);
	VariableRegister(L, FAST_FORWARD_32X_MODE);
}