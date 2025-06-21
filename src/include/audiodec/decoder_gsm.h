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

#ifndef EASYRPG_AUDIO_DECODER_GSM_H
#define EASYRPG_AUDIO_DECODER_GSM_H

// Headers
#include "audio_decoder.h"
#include <string>
#include <memory>
#include <gsm.h>

/**
 * Audio decoder for GSM 6.10 encoded WAV files using libgsm
 */
class GsmDecoder : public AudioDecoder {
public:
	GsmDecoder();

	~GsmDecoder();

	bool Open(FILE* file) override;

	bool Seek(size_t offset, Origin origin) override;

	bool IsFinished() const override;

	void GetFormat(int& frequency, AudioDecoder::Format& format, int& channels) const override;

	bool SetFormat(int frequency, AudioDecoder::Format format, int channels) override;

private:
	int FillBuffer(uint8_t* buffer, int length) override;
	
	FILE* file_;
	gsm gsm_handle_;
	bool finished_;
	bool inited_;
	
	uint32_t sample_rate_;
	uint16_t channels_;
	uint32_t data_offset_;
	uint32_t data_length_;
	uint32_t current_pos_;
	
	// GSM frame buffer (33 bytes per frame)
	static const int GSM_FRAME_SIZE = 33;
	// PCM samples per GSM frame (160 samples)
	static const int GSM_SAMPLES_PER_FRAME = 160;
	
	uint8_t gsm_frame_[GSM_FRAME_SIZE];
	gsm_signal pcm_buffer_[GSM_SAMPLES_PER_FRAME];
	int pcm_buffer_pos_;
	int pcm_buffer_len_;
};

#endif