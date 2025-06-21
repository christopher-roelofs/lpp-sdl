/*
 * This file is part of EasyRPG Player.
 *
 * EasyRPG Player is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * EasyRPG Player is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with EasyRPG Player. If not, see <http://www.gnu.org/licenses/>.
 */

// Headers
#include "decoder_gsm.h"
#include <cstring>
#include <algorithm>

GsmDecoder::GsmDecoder() :
	file_(nullptr),
	gsm_handle_(nullptr),
	finished_(false),
	inited_(false),
	sample_rate_(8000),
	channels_(1),
	data_offset_(0),
	data_length_(0),
	current_pos_(0),
	pcm_buffer_pos_(0),
	pcm_buffer_len_(0) {

	music_type = "gsm";
}

GsmDecoder::~GsmDecoder() {
	if (gsm_handle_) {
		gsm_destroy(gsm_handle_);
	}
	if (file_) {
		fclose(file_);
	}
}

bool GsmDecoder::Open(FILE* file) {
	file_ = file;
	finished_ = false;
	
	// Read WAV header
	char riff_header[12];
	if (fread(riff_header, 1, 12, file_) != 12) {
		error_message = "Failed to read RIFF header";
		return false;
	}
	
	// Check RIFF signature
	if (memcmp(riff_header, "RIFF", 4) != 0 || memcmp(riff_header + 8, "WAVE", 4) != 0) {
		error_message = "Invalid RIFF/WAVE header";
		return false;
	}
	
	// Find fmt chunk
	bool found_fmt = false;
	bool found_data = false;
	
	while (!found_fmt || !found_data) {
		char chunk_header[8];
		if (fread(chunk_header, 1, 8, file_) != 8) {
			error_message = "Failed to read chunk header";
			return false;
		}
		
		uint32_t chunk_size = *reinterpret_cast<uint32_t*>(chunk_header + 4);
		
		if (memcmp(chunk_header, "fmt ", 4) == 0) {
			if (chunk_size < 20) {
				error_message = "Invalid fmt chunk size";
				return false;
			}
			
			struct {
				uint16_t format_tag;
				uint16_t channels;
				uint32_t sample_rate;
				uint32_t avg_bytes_per_sec;
				uint16_t block_align;
				uint16_t bits_per_sample;
				uint16_t extra_size;
			} fmt_data;
			
			if (fread(&fmt_data, 1, sizeof(fmt_data), file_) != sizeof(fmt_data)) {
				error_message = "Failed to read fmt chunk data";
				return false;
			}
			
			// Check if this is GSM format (format tag 49 = 0x31)
			if (fmt_data.format_tag != 49) {
				error_message = "Not a GSM WAV file";
				return false;
			}
			
			sample_rate_ = fmt_data.sample_rate;
			channels_ = fmt_data.channels;
			
			// GSM only supports mono
			if (channels_ != 1) {
				error_message = "GSM format only supports mono audio";
				return false;
			}
			
			found_fmt = true;
			
			// Skip any remaining fmt data
			if (chunk_size > sizeof(fmt_data)) {
				fseek(file_, chunk_size - sizeof(fmt_data), SEEK_CUR);
			}
		}
		else if (memcmp(chunk_header, "data", 4) == 0) {
			data_offset_ = ftell(file_);
			data_length_ = chunk_size;
			found_data = true;
			break;
		}
		else {
			// Skip unknown chunk
			fseek(file_, chunk_size, SEEK_CUR);
		}
	}
	
	if (!found_fmt || !found_data) {
		error_message = "Missing fmt or data chunk";
		return false;
	}
	
	// Initialize GSM decoder
	gsm_handle_ = gsm_create();
	if (!gsm_handle_) {
		error_message = "Failed to create GSM decoder";
		return false;
	}
	
	// Set GSM options for better quality
	int opt_val = 1;
	gsm_option(gsm_handle_, GSM_OPT_WAV49, &opt_val);
	
	// Seek to data start
	fseek(file_, data_offset_, SEEK_SET);
	current_pos_ = 0;
	
	inited_ = true;
	return true;
}

bool GsmDecoder::Seek(size_t offset, Origin origin) {
	if (!inited_) return false;
	
	if (origin == Origin::Begin && offset == 0) {
		// Rewind to beginning
		fseek(file_, data_offset_, SEEK_SET);
		current_pos_ = 0;
		finished_ = false;
		pcm_buffer_pos_ = 0;
		pcm_buffer_len_ = 0;
		
		// Reset GSM decoder state
		gsm_destroy(gsm_handle_);
		gsm_handle_ = gsm_create();
		if (gsm_handle_) {
			int opt_val = 1;
			gsm_option(gsm_handle_, GSM_OPT_WAV49, &opt_val);
		}
		return gsm_handle_ != nullptr;
	}
	
	return false; // Only rewind is supported
}

bool GsmDecoder::IsFinished() const {
	return finished_;
}

void GsmDecoder::GetFormat(int& frequency, AudioDecoder::Format& format, int& channels) const {
	frequency = sample_rate_;
	format = AudioDecoder::Format::S16;
	channels = channels_;
}

bool GsmDecoder::SetFormat(int frequency, AudioDecoder::Format format, int channels) {
	return false; // Format conversion not supported
}

int GsmDecoder::FillBuffer(uint8_t* buffer, int length) {
	if (!inited_ || finished_) {
		return 0;
	}
	
	int16_t* output = reinterpret_cast<int16_t*>(buffer);
	int samples_needed = length / sizeof(int16_t);
	int samples_written = 0;
	
	while (samples_written < samples_needed && !finished_) {
		// If we have buffered PCM data, use it first
		if (pcm_buffer_pos_ < pcm_buffer_len_) {
			int samples_to_copy = std::min(samples_needed - samples_written, pcm_buffer_len_ - pcm_buffer_pos_);
			
			for (int i = 0; i < samples_to_copy; i++) {
				output[samples_written + i] = pcm_buffer_[pcm_buffer_pos_ + i];
			}
			
			samples_written += samples_to_copy;
			pcm_buffer_pos_ += samples_to_copy;
			continue;
		}
		
		// Need to decode a new GSM frame
		if (current_pos_ >= data_length_) {
			finished_ = true;
			break;
		}
		
		// Read GSM frame - ensure we read complete frames only
		size_t bytes_remaining = data_length_ - current_pos_;
		
		if (bytes_remaining < GSM_FRAME_SIZE) {
			// Not enough data for a complete frame
			finished_ = true;
			break;
		}
		
		size_t bytes_read = fread(gsm_frame_, 1, GSM_FRAME_SIZE, file_);
		
		if (bytes_read != GSM_FRAME_SIZE) {
			finished_ = true;
			break;
		}
		
		current_pos_ += bytes_read;
		
		// Decode GSM frame to PCM
		int decode_result = gsm_decode(gsm_handle_, gsm_frame_, pcm_buffer_);
		
		if (decode_result != 0) {
			error_message = "GSM decode error";
			finished_ = true;
			break;
		}
		
		pcm_buffer_pos_ = 0;
		pcm_buffer_len_ = GSM_SAMPLES_PER_FRAME;
	}
	
	return samples_written * sizeof(int16_t);
}