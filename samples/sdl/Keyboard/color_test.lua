-- Keyboard Color Customization Test
-- This sample demonstrates the new color setter methods for the onscreen keyboard

local current_test = 1
local total_tests = 6
local test_names = {
    "Default Colors",
    "Dark Theme",
    "Blue Theme", 
    "Green Theme",
    "Red Theme",
    "Custom Rainbow"
}

-- Button state tracking for proper press detection
local last_pad = 0

function setColorTheme(theme_id)
    if theme_id == 1 then
        -- Default colors (reset to original)
        Keyboard.setBackgroundColor(Color.new(40, 40, 40, 220))
        Keyboard.setFontColor(Color.new(255, 255, 255, 255))
        Keyboard.setSelectedBackgroundColor(Color.new(100, 150, 200, 255))
        Keyboard.setSelectedFontColor(Color.new(255, 255, 0, 255))
        Keyboard.setKeyBackgroundColor(Color.new(80, 80, 80, 255))
        Keyboard.setShiftKeyColor(Color.new(150, 100, 100, 255))
        Keyboard.setTitleBarColor(Color.new(60, 60, 60, 255))
        -- NEW: Input and border colors
        Keyboard.setInputBackgroundColor(Color.new(255, 255, 255, 255))
        Keyboard.setInputBorderColor(Color.new(0, 0, 0, 255))
        Keyboard.setInputTextColor(Color.new(0, 0, 0, 255))
        Keyboard.setKeyboardBorderColor(Color.new(100, 100, 100, 255))
        Keyboard.setKeyBorderColor(Color.new(120, 120, 120, 255))
        -- Reset to default font
        Keyboard.setFont("main.ttf", 18)
        
    elseif theme_id == 2 then
        -- Dark theme
        Keyboard.setBackgroundColor(Color.new(20, 20, 20, 240))
        Keyboard.setFontColor(Color.new(200, 200, 200, 255))
        Keyboard.setSelectedBackgroundColor(Color.new(60, 60, 60, 255))
        Keyboard.setSelectedFontColor(Color.new(255, 255, 255, 255))
        Keyboard.setKeyBackgroundColor(Color.new(40, 40, 40, 255))
        Keyboard.setShiftKeyColor(Color.new(80, 80, 80, 255))
        Keyboard.setTitleBarColor(Color.new(30, 30, 30, 255))
        -- NEW: Dark input and border colors
        Keyboard.setInputBackgroundColor(Color.new(50, 50, 50, 255))
        Keyboard.setInputBorderColor(Color.new(100, 100, 100, 255))
        Keyboard.setInputTextColor(Color.new(255, 255, 255, 255))
        Keyboard.setKeyboardBorderColor(Color.new(80, 80, 80, 255))
        Keyboard.setKeyBorderColor(Color.new(60, 60, 60, 255))
        -- Use slightly larger font for dark theme
        Keyboard.setFont("InterVariable.ttf", 18)
        
    elseif theme_id == 3 then
        -- Pure Blue theme (no red/green to avoid yellow mixing)
        Keyboard.setBackgroundColor(Color.new(0, 0, 180, 255))
        Keyboard.setFontColor(Color.new(200, 200, 255, 255))
        Keyboard.setSelectedBackgroundColor(Color.new(0, 0, 255, 255))
        Keyboard.setSelectedFontColor(Color.new(255, 255, 255, 255))
        Keyboard.setKeyBackgroundColor(Color.new(0, 0, 200, 255))
        Keyboard.setShiftKeyColor(Color.new(100, 100, 255, 255))
        Keyboard.setTitleBarColor(Color.new(0, 0, 160, 255))
        -- NEW: Pure blue input and border colors
        Keyboard.setInputBackgroundColor(Color.new(240, 240, 255, 255))
        Keyboard.setInputBorderColor(Color.new(0, 0, 255, 255))
        Keyboard.setInputTextColor(Color.new(0, 0, 200, 255))
        Keyboard.setKeyboardBorderColor(Color.new(0, 0, 220, 255))
        Keyboard.setKeyBorderColor(Color.new(0, 0, 240, 255))
        
    elseif theme_id == 4 then
        -- Green theme
        Keyboard.setBackgroundColor(Color.new(20, 80, 20, 220))
        Keyboard.setFontColor(Color.new(200, 255, 200, 255))
        Keyboard.setSelectedBackgroundColor(Color.new(100, 255, 100, 255))
        Keyboard.setSelectedFontColor(Color.new(0, 0, 0, 255))
        Keyboard.setKeyBackgroundColor(Color.new(40, 120, 40, 255))
        Keyboard.setShiftKeyColor(Color.new(80, 160, 80, 255))
        Keyboard.setTitleBarColor(Color.new(30, 100, 30, 255))
        -- NEW: Green input and border colors
        Keyboard.setInputBackgroundColor(Color.new(240, 255, 240, 255))
        Keyboard.setInputBorderColor(Color.new(50, 150, 50, 255))
        Keyboard.setInputTextColor(Color.new(0, 80, 0, 255))
        Keyboard.setKeyboardBorderColor(Color.new(80, 200, 80, 255))
        Keyboard.setKeyBorderColor(Color.new(60, 160, 60, 255))
        
    elseif theme_id == 5 then
        -- Red theme
        Keyboard.setBackgroundColor(Color.new(100, 20, 20, 220))
        Keyboard.setFontColor(Color.new(255, 200, 200, 255))
        Keyboard.setSelectedBackgroundColor(Color.new(255, 100, 100, 255))
        Keyboard.setSelectedFontColor(Color.new(255, 255, 255, 255))
        Keyboard.setKeyBackgroundColor(Color.new(140, 40, 40, 255))
        Keyboard.setShiftKeyColor(Color.new(180, 60, 60, 255))
        Keyboard.setTitleBarColor(Color.new(120, 30, 30, 255))
        -- NEW: Red input and border colors
        Keyboard.setInputBackgroundColor(Color.new(255, 240, 240, 255))
        Keyboard.setInputBorderColor(Color.new(150, 50, 50, 255))
        Keyboard.setInputTextColor(Color.new(80, 0, 0, 255))
        Keyboard.setKeyboardBorderColor(Color.new(200, 80, 80, 255))
        Keyboard.setKeyBorderColor(Color.new(160, 60, 60, 255))
        
    elseif theme_id == 6 then
        -- Custom rainbow theme
        Keyboard.setBackgroundColor(Color.new(60, 30, 90, 220))
        Keyboard.setFontColor(Color.new(255, 255, 0, 255))
        Keyboard.setSelectedBackgroundColor(Color.new(255, 100, 200, 255))
        Keyboard.setSelectedFontColor(Color.new(0, 255, 255, 255))
        Keyboard.setKeyBackgroundColor(Color.new(120, 60, 180, 255))
        Keyboard.setShiftKeyColor(Color.new(255, 150, 100, 255))
        Keyboard.setTitleBarColor(Color.new(80, 50, 120, 255))
        -- NEW: Rainbow input and border colors
        Keyboard.setInputBackgroundColor(Color.new(255, 250, 240, 255))
        Keyboard.setInputBorderColor(Color.new(200, 100, 150, 255))
        Keyboard.setInputTextColor(Color.new(100, 50, 150, 255))
        Keyboard.setKeyboardBorderColor(Color.new(255, 200, 100, 255))
        Keyboard.setKeyBorderColor(Color.new(200, 150, 255, 255))
        -- Use bold font for rainbow theme
        Keyboard.setFont("InterVariable.ttf", 20)
    end
end

-- Initialize first theme and keyboard
Keyboard.start("Color Test: " .. test_names[current_test], "Type something to test colors!")
setColorTheme(current_test)

local result = "Testing keyboard color themes..."
local keyboard_finished = false

-- Main loop
while true do
    
    -- Initialize drawing phase
    Graphics.initBlend()
    Screen.clear()
    
    -- Check keyboard status
    local status = Keyboard.getState()
    
    if status ~= RUNNING and not keyboard_finished then
        keyboard_finished = true
        
        -- Check if user didn't cancel the keyboard
        if status ~= CANCELED then
            result = "Theme " .. current_test .. " (" .. test_names[current_test] .. "): " .. Keyboard.getInput()
        else
            result = "Theme " .. current_test .. " (" .. test_names[current_test] .. "): Canceled"
        end
        
        -- Terminate current keyboard
        Keyboard.clear()
    end
    
    -- Draw current state
    Graphics.debugPrint(5, 5, "Keyboard Color Theme Test - Complete Customization", Color.new(255, 255, 255))
    Graphics.debugPrint(5, 25, "Current Theme: " .. current_test .. "/" .. total_tests .. " - " .. test_names[current_test], Color.new(200, 200, 200))
    Graphics.debugPrint(5, 45, result, Color.new(255, 255, 0))
    Graphics.debugPrint(5, 65, "Features 12 different color elements per theme!", Color.new(150, 255, 150))
    
    if keyboard_finished then
        Graphics.debugPrint(5, 85, "Controls:", Color.new(255, 255, 255))
        Graphics.debugPrint(5, 105, "Left/Right Arrow: Previous/Next Theme", Color.new(200, 200, 200))
        Graphics.debugPrint(5, 125, "SPACE: Test Current Theme", Color.new(200, 200, 200))
        Graphics.debugPrint(5, 145, "ESC: Exit", Color.new(200, 200, 200))
        
        -- Handle controls when keyboard is not active
        local pad = Controls.read()
        
        -- Check for new button presses (not held)
        if Controls.check(pad, SDLK_LEFT) and not Controls.check(last_pad, SDLK_LEFT) then
            -- Previous theme (only on new press)
            current_test = current_test - 1
            if current_test < 1 then
                current_test = total_tests
            end
            Keyboard.clear()  -- Clear any existing keyboard state
            setColorTheme(current_test)
            result = "Theme changed to: " .. test_names[current_test]
            
        elseif Controls.check(pad, SDLK_RIGHT) and not Controls.check(last_pad, SDLK_RIGHT) then
            -- Next theme (only on new press)
            current_test = current_test + 1
            if current_test > total_tests then
                current_test = 1
            end
            Keyboard.clear()  -- Clear any existing keyboard state
            setColorTheme(current_test)
            result = "Theme changed to: " .. test_names[current_test]
            
        elseif Controls.check(pad, SDLK_SPACE) and not Controls.check(last_pad, SDLK_SPACE) then
            -- Test current theme (only on new press)
            Keyboard.clear()  -- Clear any existing keyboard state
            Keyboard.start("Color Test: " .. test_names[current_test], "Testing " .. test_names[current_test] .. " theme!")
            setColorTheme(current_test)  -- Set colors AFTER starting keyboard
            keyboard_finished = false
            result = "Testing " .. test_names[current_test] .. " theme..."
            
        elseif Controls.check(pad, SDLK_ESCAPE) and not Controls.check(last_pad, SDLK_ESCAPE) then
            -- Exit (only on new press)
            break
        end
        
        -- Update last button state for next frame
        last_pad = pad
    end
    
    Graphics.termBlend()
    Screen.flip()
    
end