local white = Color.new(255,255,255) 

-- Init video device
Video.init()

-- Loading and starting our video file
Video.open("video.mp4")
Video.openSubs("video.vtt")

local modes = {
	NORMAL_MODE,
	FAST_FORWARD_2X_MODE,
	FAST_FORWARD_4X_MODE,
	FAST_FORWARD_8X_MODE,
	FAST_FORWARD_16X_MODE,
	FAST_FORWARD_32X_MODE
}

local mode_idx = 1
local oldpad = 0

-- Main loop
while true do
	
	-- Blend instructions
	Graphics.initBlend()
	Screen.clear()
	
	-- Get screen dimensions first
	sh = Screen.getHeight()
	sw = Screen.getWidth()
	
	frame = Video.getOutput()
	if frame ~= 0 then
		gw = Graphics.getImageWidth(frame)
		gh = Graphics.getImageHeight(frame)
		
		-- Calculate scaling to fit video in screen while maintaining aspect ratio
		local scale_x = sw / gw
		local scale_y = sh / gh
		local scale = math.min(scale_x, scale_y)  -- Use smaller scale to maintain aspect ratio
		
		-- Center the video on screen
		local scaled_width = gw * scale
		local scaled_height = gh * scale
		local x_offset = (sw - scaled_width) / 2
		local y_offset = (sh - scaled_height) / 2
		
		Graphics.drawScaleImage(x_offset, y_offset, frame, scale, scale)
	end
	
	-- Display debug info in top-left corner
	Graphics.debugPrint(10, 10, "Time: " .. Video.getTime() .. " ms", white)
	Graphics.debugPrint(10, 30, "Speed: x" .. (modes[mode_idx] / 100), white)
	Graphics.debugPrint(10, 50, "Screen: " .. sw .. "x" .. sh, white)
	if frame ~= 0 then
		Graphics.debugPrint(10, 70, "Video: " .. gw .. "x" .. gh, white)
	end
	
	-- Display subtitles at bottom of screen with proper positioning
	local subtitle_text = Video.getSubs()
	if subtitle_text and subtitle_text ~= " " and subtitle_text ~= "" then
		-- Calculate text width for centering (approximate)
		local full_text = "Subtitles: " .. subtitle_text
		local char_width = 8  -- Approximate character width in pixels
		local text_width = string.len(full_text) * char_width
		local x_pos = (sw - text_width) / 2
		
		-- Ensure subtitle doesn't go off-screen
		if x_pos < 10 then x_pos = 10 end
		if x_pos + text_width > sw - 10 then x_pos = sw - text_width - 10 end
		
		-- Position subtitles at bottom center of screen
		Graphics.debugPrint(x_pos, sh - 80, full_text, white)
	end
	Graphics.termBlend()
	Screen.waitVblankStart()
	Screen.flip()
	
	-- Check for input
	local pad = Controls.read()
	if Controls.check(pad, SCE_CTRL_CIRCLE) and Video.isPlaying() then
		Video.pause()
	elseif Controls.check(pad, SCE_CTRL_SQUARE) and not Video.isPlaying() then
		Video.resume()
	elseif Controls.check(pad, SCE_CTRL_TRIANGLE) then
		Video.close()
		break
	elseif Controls.check(pad, SCE_CTRL_LTRIGGER) and not Controls.check(oldpad, SCE_CTRL_LTRIGGER) then
		mode_idx = mode_idx - 1
		if mode_idx < 1 then
			mode_idx = 1
		end
		Video.setPlayMode(modes[mode_idx])
	elseif Controls.check(pad, SCE_CTRL_RTRIGGER) and not Controls.check(oldpad, SCE_CTRL_RTRIGGER) then
		mode_idx = mode_idx + 1
		if mode_idx > #modes then
			mode_idx = #modes
		end
		Video.setPlayMode(modes[mode_idx])
	elseif Controls.check(pad, SCE_CTRL_LEFT) and not Controls.check(oldpad, SCE_CTRL_LEFT) then
		local cur_time = Video.getTime()
		jump_time = cur_time - 10000
		if jump_time < 0 then
			jump_time = 0
		end
		Video.jumpToTime(jump_time)
	elseif Controls.check(pad, SCE_CTRL_RIGHT) and not Controls.check(oldpad, SCE_CTRL_RIGHT) then
		Video.jumpToTime(Video.getTime() + 10000)
	end
	
	oldpad = pad
end