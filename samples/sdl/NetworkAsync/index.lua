-- LPP-SDL Async Network Test
-- Test script for the new async network functionality
-- 
-- This script demonstrates async downloads that don't block the main thread,
-- allowing for smooth animations and UI updates during network operations.
--
-- Usage: ./lpp_sdl samples/sdl/NetworkAsync/index.lua

-- Colors for UI
local white = Color.new(255, 255, 255)
local green = Color.new(0, 255, 0)
local red = Color.new(255, 0, 0)
local yellow = Color.new(255, 255, 0)
local blue = Color.new(0, 150, 255)
local cyan = Color.new(0, 255, 255)
local gray = Color.new(128, 128, 128)

-- Test state
local test_state = "idle"
local async_id = nil
local start_time = 0
local spinner_frame = 0
local test_url = "https://httpbin.org/delay/3" -- 3 second delay for testing
local result_text = ""
local status_text = "Press SPACE to start async test, ESC to quit"

-- Animation
local spinner_chars = {"|", "/", "-", "\\"}

function _LPP_MAIN_LOOP()
    local pad = Controls.read()
    local current_time = os.clock()
    
    -- Handle input
    if Controls.check(pad, SDLK_SPACE) and test_state == "idle" then
        -- Initialize network if needed
        Network.init()
        
        -- Start async download
        status_text = "Starting async download..."
        async_id = Network.requestStringAsync(test_url, "lpp-sdl-async-test", GET_METHOD)
        test_state = "downloading"
        start_time = current_time
        spinner_frame = 0
    elseif Controls.check(pad, SDLK_ESCAPE) then
        -- Cleanup and exit
        if test_state ~= "idle" then
            Network.term()
        end
        System.exit()
    end
    
    -- Update async operation
    if test_state == "downloading" and async_id then
        local state = Network.getAsyncState(async_id)
        local elapsed = current_time - start_time
        
        if state == ASYNC_RUNNING then
            -- Update spinner animation
            spinner_frame = (spinner_frame + 1) % 4
            status_text = "Downloading " .. spinner_chars[spinner_frame + 1] .. " (" .. string.format("%.1f", elapsed) .. "s)"
            
        elseif state == ASYNC_COMPLETED then
            -- Get result
            result_text = Network.getAsyncResult(async_id)
            status_text = "Download completed in " .. string.format("%.1f", elapsed) .. "s"
            test_state = "completed"
            async_id = nil
            
        elseif state == ASYNC_FAILED then
            result_text = "Download failed"
            status_text = "Download failed after " .. string.format("%.1f", elapsed) .. "s"
            test_state = "failed"
            async_id = nil
        end
    end
    
    -- Render UI
    Graphics.initBlend()
    Screen.clear()
    
    -- Title
    Graphics.debugPrint(10, 10, "LPP-SDL Async Network Test", cyan)
    Graphics.debugPrint(10, 30, "Non-blocking network downloads", white)
    
    -- Instructions
    Graphics.debugPrint(10, 70, "INSTRUCTIONS:", yellow)
    Graphics.debugPrint(10, 90, "SPACE: Start async download test", white)
    Graphics.debugPrint(10, 105, "ESC: Exit", white)
    
    -- Status
    Graphics.debugPrint(10, 140, "STATUS:", yellow)
    local status_color = white
    if test_state == "downloading" then
        status_color = blue
    elseif test_state == "completed" then
        status_color = green
    elseif test_state == "failed" then
        status_color = red
    end
    Graphics.debugPrint(10, 160, status_text, status_color)
    
    -- Test details
    Graphics.debugPrint(10, 200, "TEST DETAILS:", yellow)
    Graphics.debugPrint(10, 220, "URL: " .. test_url, white)
    Graphics.debugPrint(10, 240, "Method: Async string download", white)
    
    if async_id then
        Graphics.debugPrint(10, 260, "Async ID: " .. async_id, white)
    end
    
    -- Result (if available)
    if test_state == "completed" and result_text ~= "" then
        Graphics.debugPrint(10, 300, "RESULT (first 500 chars):", yellow)
        local display_result = string.sub(result_text, 1, 500)
        if string.len(result_text) > 500 then
            display_result = display_result .. "..."
        end
        
        -- Word wrap the result
        local y_offset = 320
        local max_line_length = 80
        local lines = {}
        local current_line = ""
        
        for word in display_result:gmatch("%S+") do
            if string.len(current_line .. " " .. word) <= max_line_length then
                if current_line == "" then
                    current_line = word
                else
                    current_line = current_line .. " " .. word
                end
            else
                if current_line ~= "" then
                    table.insert(lines, current_line)
                end
                current_line = word
            end
        end
        
        if current_line ~= "" then
            table.insert(lines, current_line)
        end
        
        for i, line in ipairs(lines) do
            Graphics.debugPrint(10, y_offset + (i - 1) * 15, line, gray)
            if i > 15 then -- Limit to 15 lines to avoid overflow
                Graphics.debugPrint(10, y_offset + i * 15, "... (truncated)", gray)
                break
            end
        end
    end
    
    -- Performance info
    Graphics.debugPrint(10, 600, "ASYNC BENEFITS:", yellow)
    Graphics.debugPrint(10, 620, "• UI remains responsive during download", white)
    Graphics.debugPrint(10, 635, "• Multiple downloads can run in parallel", white)
    Graphics.debugPrint(10, 650, "• No blocking of game logic or animations", white)
    Graphics.debugPrint(10, 665, "• Perfect for Vita compatibility", white)
    
    -- Show that the UI is responsive with animated timestamp
    Graphics.debugPrint(10, 700, "Live timestamp: " .. string.format("%.2f", current_time), cyan)
    
    -- Reset button prompt
    if test_state ~= "idle" and test_state ~= "downloading" then
        Graphics.debugPrint(10, 730, "Press SPACE to test again", yellow)
        if Controls.check(pad, SDLK_SPACE) then
            test_state = "idle"
            async_id = nil
            result_text = ""
            status_text = "Press SPACE to start async test, ESC to quit"
        end
    end
    
    Graphics.termBlend()
    Screen.flip()
    
    -- Small delay for smooth animation
    Timer.sleep(50) -- 20 FPS for demo
end