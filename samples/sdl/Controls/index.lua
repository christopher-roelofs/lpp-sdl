-- LPP-Vita SDL Controls Test
-- Comprehensive test script for all Vita button mappings in SDL port
-- 
-- This script tests all 16 official Vita buttons mapped to keyboard keys.
-- Buttons light up in green when pressed, providing real-time feedback.
-- Also tests analog sticks, controller connectivity, and touch simulation.
--
-- Usage: ./lpp_sdl tests/controls_test.lua
-- Press ESC to quit

-- Colors
local white = Color.new(255, 255, 255)
local green = Color.new(0, 255, 0)
local red = Color.new(255, 0, 0)
local yellow = Color.new(255, 255, 0)
local blue = Color.new(0, 150, 255)
local gray = Color.new(128, 128, 128)

-- SDL keyboard mappings - Updated for SDLK scancode system
local controls = {
    {name = "UP", button = SDLK_UP, keys = "↑ Arrow"},
    {name = "DOWN", button = SDLK_DOWN, keys = "↓ Arrow"},
    {name = "LEFT", button = SDLK_LEFT, keys = "← Arrow"},
    {name = "RIGHT", button = SDLK_RIGHT, keys = "→ Arrow"},
    {name = "CROSS", button = SDLK_SPACE, keys = "Space"},
    {name = "CIRCLE", button = SDLK_BACKSPACE, keys = "Backspace"},
    {name = "SQUARE", button = SDLK_Z, keys = "Z"},
    {name = "TRIANGLE", button = SDLK_X, keys = "X"},
    {name = "L TRIGGER", button = SDLK_Q, keys = "Q"},
    {name = "R TRIGGER", button = SDLK_E, keys = "E"},
    {name = "START", button = SDLK_RETURN, keys = "Return"},
    {name = "SELECT", button = SDLK_TAB, keys = "Tab"},
    {name = "PS BUTTON", button = SDLK_H, keys = "H"},
    {name = "POWER", button = SDLK_P, keys = "P"},
    {name = "VOL UP", button = SDLK_PAGEUP, keys = "Page Up"},
    {name = "VOL DOWN", button = SDLK_PAGEDOWN, keys = "Page Down"}
}

-- Additional keyboard keys for demonstration
local keyboard_keys = {
    {name = "A", button = SDLK_A, keys = "A"},
    {name = "B", button = SDLK_B, keys = "B"},
    {name = "C", button = SDLK_C, keys = "C"},
    {name = "D", button = SDLK_D, keys = "D"},
    {name = "F", button = SDLK_F, keys = "F"},
    {name = "G", button = SDLK_G, keys = "G"},
    {name = "ESC", button = SDLK_ESCAPE, keys = "Escape"},
    {name = "DELETE", button = SDLK_DELETE, keys = "Delete"},
    {name = "F1", button = SDLK_F1, keys = "F1"},
    {name = "F2", button = SDLK_F2, keys = "F2"}
}

-- Analog stick display
local function drawAnalogStick(x, y, title, stick_x, stick_y)
    -- Draw title
    Graphics.debugPrint(x, y, title, white)
    
    -- Draw stick base (circle)
    local base_x = x + 50
    local base_y = y + 30
    local radius = 20
    
    -- Simple circle approximation using lines
    for angle = 0, 360, 10 do
        local rad = math.rad(angle)
        local x1 = base_x + radius * math.cos(rad)
        local y1 = base_y + radius * math.sin(rad)
        Graphics.debugPrint(x1, y1, ".", gray)
    end
    
    -- Draw stick position (Vita range: 0-255 with 128 as center)
    local stick_pos_x = base_x + ((stick_x - 128) / 128) * radius * 0.8
    local stick_pos_y = base_y + ((stick_y - 128) / 128) * radius * 0.8
    Graphics.debugPrint(stick_pos_x - 2, stick_pos_y - 2, "●", red)
    
    -- Display values
    Graphics.debugPrint(x, y + 70, "X: " .. stick_x, white)
    Graphics.debugPrint(x, y + 85, "Y: " .. stick_y, white)
end

-- Touch display
local function drawTouchInfo(x, y)
    Graphics.debugPrint(x, y, "TOUCH (Mouse)", white)
    Graphics.debugPrint(x, y + 15, "Click mouse to simulate touch", gray)
end

-- Main loop function for callback-based execution
function _LPP_MAIN_LOOP()
    -- Read current controller state
    local pad = Controls.read()
    local left_x, left_y = Controls.readLeftAnalog()
    local right_x, right_y = Controls.readRightAnalog()
    
    Graphics.initBlend()
    Screen.clear()
    
    -- Title
    Graphics.debugPrint(10, 10, "LPP-SDL SDLK Controls Test", yellow)
    Graphics.debugPrint(10, 30, "Updated to use SDLK_ scancode system", white)
    Graphics.debugPrint(10, 45, "Raw pad value: " .. tostring(pad), gray)
    
    -- Draw vita-style controls section
    Graphics.debugPrint(10, 70, "VITA-STYLE CONTROLS:", blue)
    local start_x = 10
    local start_y = 90
    local col_width = 180
    local row_height = 18
    
    for i, control in ipairs(controls) do
        local x = start_x + ((i - 1) % 4) * col_width
        local y = start_y + math.floor((i - 1) / 4) * row_height
        
        if control.button then
            local is_pressed = Controls.check(pad, control.button)
            local color = is_pressed and green or white
            local status = is_pressed and " [ON]" or ""
            Graphics.debugPrint(x, y, control.name .. ": " .. control.keys .. status, color)
        else
            Graphics.debugPrint(x, y, control.name .. ": NIL", red)
        end
    end
    
    -- Draw additional keyboard keys section
    local keyboard_y = start_y + math.ceil(#controls / 4) * row_height + 30
    Graphics.debugPrint(10, keyboard_y, "ADDITIONAL KEYBOARD KEYS:", blue)
    keyboard_y = keyboard_y + 20
    
    for i, key in ipairs(keyboard_keys) do
        local x = start_x + ((i - 1) % 5) * 150
        local y = keyboard_y + math.floor((i - 1) / 5) * row_height
        
        if key.button then
            local is_pressed = Controls.check(pad, key.button)
            local color = is_pressed and green or white
            local status = is_pressed and " [ON]" or ""
            Graphics.debugPrint(x, y, key.name .. ": " .. key.keys .. status, color)
        else
            Graphics.debugPrint(x, y, key.name .. ": NIL", red)
        end
    end
    
    -- Draw analog sticks
    local analog_y = keyboard_y + math.ceil(#keyboard_keys / 5) * row_height + 30
    drawAnalogStick(10, analog_y, "LEFT ANALOG", left_x, left_y)
    drawAnalogStick(150, analog_y, "RIGHT ANALOG", right_x, right_y)
    
    -- Draw touch info
    drawTouchInfo(300, analog_y)
    
    -- Controller info
    local controller_y = analog_y + 120
    Graphics.debugPrint(10, controller_y, "CONTROLLER INFO:", blue)
    local device_info = Controls.getDeviceInfo()
    if device_info and type(device_info) == "table" then
        for port = 1, 4 do
            if device_info[port] and device_info[port].type then
                local status = device_info[port].type > 0 and "Connected" or "Disconnected"
                Graphics.debugPrint(10, controller_y + 15 + (port * 15), 
                    "Port " .. port .. ": " .. status, 
                    device_info[port].type > 0 and green or red)
            end
        end
    else
        Graphics.debugPrint(10, controller_y + 15, "No controller info available", gray)
    end
    
    -- Instructions
    local instr_y = controller_y + 90
    Graphics.debugPrint(10, instr_y, "INSTRUCTIONS:", blue)
    Graphics.debugPrint(10, instr_y + 15, "• Updated to use SDLK_ scancode constants", white)
    Graphics.debugPrint(10, instr_y + 30, "• Vita-style controls: Arrow keys, Space=Cross, X=Triangle", white)
    Graphics.debugPrint(10, instr_y + 45, "• Additional keyboard keys: A-G, ESC, DELETE, F1-F2", white)
    Graphics.debugPrint(10, instr_y + 60, "• Connect a game controller for analog sticks", white)
    Graphics.debugPrint(10, instr_y + 75, "• Click mouse for touch simulation", white)
    Graphics.debugPrint(10, instr_y + 90, "• Press ESC to quit", yellow)
    Graphics.debugPrint(10, instr_y + 105, "• Old SCE_CTRL_ scripts still work via compatibility layer", white)
    
    Graphics.termBlend()
    Screen.flip()
    
    
end