-- LPP-SDL Cross-Platform Controls Test
-- Comprehensive test script for both 3DS and Vita button mappings
-- 
-- This script demonstrates the button mapping differences between platforms
-- and provides real-time feedback for all supported inputs including
-- gamepad, keyboard, analog sticks, and touch input.
--
-- Usage: ./lpp_sdl samples/sdl/Controls/index.lua
-- Press ESC to quit, F1/F2 to switch between platform demos

-- Enhanced color palette
local white = Color.new(255, 255, 255)
local green = Color.new(0, 255, 0)
local red = Color.new(255, 0, 0)
local yellow = Color.new(255, 255, 0)
local blue = Color.new(0, 150, 255)
local cyan = Color.new(0, 255, 255)
local magenta = Color.new(255, 0, 255)
local orange = Color.new(255, 165, 0)
local gray = Color.new(128, 128, 128)
local dark_gray = Color.new(64, 64, 64)
local light_blue = Color.new(173, 216, 230)
local lime = Color.new(50, 205, 50)

-- Display mode: 0 = Overview, 1 = 3DS Focus, 2 = Vita Focus
local display_mode = 0
local mode_names = {"Cross-Platform Overview", "3DS Platform Focus", "Vita Platform Focus"}

-- 3DS button mappings (Nintendo layout)
local controls_3ds = {
    {name = "A", button = SDLK_RETURN, keys = "Return", pos = "Right", desc = "Confirm/OK"},
    {name = "B", button = SDLK_BACKSPACE, keys = "Backspace", pos = "Bottom", desc = "Cancel/Back"},
    {name = "X", button = SDLK_SPACE, keys = "Space", pos = "Top", desc = "Action"},
    {name = "Y", button = SDLK_LSHIFT, keys = "LShift", pos = "Left", desc = "Action"},
    {name = "L", button = SDLK_PAGEUP, keys = "Page Up", pos = "Left Shoulder", desc = "Shoulder"},
    {name = "R", button = SDLK_PAGEDOWN, keys = "Page Down", pos = "Right Shoulder", desc = "Shoulder"},
    {name = "START", button = SDLK_LALT, keys = "LAlt", pos = "System", desc = "Start Game"},
    {name = "SELECT", button = SDLK_LCTRL, keys = "LCtrl", pos = "System", desc = "Select/Menu"},
    {name = "D-UP", button = SDLK_UP, keys = "↑ Arrow", pos = "D-Pad", desc = "Move Up"},
    {name = "D-DOWN", button = SDLK_DOWN, keys = "↓ Arrow", pos = "D-Pad", desc = "Move Down"},
    {name = "D-LEFT", button = SDLK_LEFT, keys = "← Arrow", pos = "D-Pad", desc = "Move Left"},
    {name = "D-RIGHT", button = SDLK_RIGHT, keys = "→ Arrow", pos = "D-Pad", desc = "Move Right"}
}

-- Vita button mappings (PlayStation layout)
local controls_vita = {
    {name = "CROSS", button = SDLK_SPACE, keys = "Space", pos = "Bottom", desc = "Confirm/OK"},
    {name = "CIRCLE", button = SDLK_BACKSPACE, keys = "Backspace", pos = "Right", desc = "Cancel/Back"},
    {name = "SQUARE", button = SDLK_Z, keys = "Z", pos = "Left", desc = "Action"},
    {name = "TRIANGLE", button = SDLK_X, keys = "X", pos = "Top", desc = "Action"},
    {name = "L TRIGGER", button = SDLK_Q, keys = "Q", pos = "Left Shoulder", desc = "Shoulder"},
    {name = "R TRIGGER", button = SDLK_E, keys = "E", pos = "Right Shoulder", desc = "Shoulder"},
    {name = "START", button = SDLK_RETURN, keys = "Return", pos = "System", desc = "Start Game"},
    {name = "SELECT", button = SDLK_TAB, keys = "Tab", pos = "System", desc = "Select/Menu"},
    {name = "D-UP", button = SDLK_UP, keys = "↑ Arrow", pos = "D-Pad", desc = "Move Up"},
    {name = "D-DOWN", button = SDLK_DOWN, keys = "↓ Arrow", pos = "D-Pad", desc = "Move Down"},
    {name = "D-LEFT", button = SDLK_LEFT, keys = "← Arrow", pos = "D-Pad", desc = "Move Left"},
    {name = "D-RIGHT", button = SDLK_RIGHT, keys = "→ Arrow", pos = "D-Pad", desc = "Move Right"},
    {name = "PS BUTTON", button = SDLK_H, keys = "H", pos = "System", desc = "Home Button"},
    {name = "POWER", button = SDLK_P, keys = "P", pos = "System", desc = "Power"},
    {name = "VOL UP", button = SDLK_PAGEUP, keys = "Page Up", pos = "System", desc = "Volume Up"},
    {name = "VOL DOWN", button = SDLK_PAGEDOWN, keys = "Page Down", pos = "System", desc = "Volume Down"}
}

-- Enhanced analog stick display with better visuals
local function drawAnalogStick(x, y, title, stick_x, stick_y, color_theme)
    -- Draw title with platform-specific color
    Graphics.debugPrint(x, y, title, color_theme or cyan)
    
    -- Draw stick base (larger, better circle)
    local base_x = x + 60
    local base_y = y + 35
    local radius = 25
    
    -- Draw outer circle border
    for angle = 0, 360, 8 do
        local rad = math.rad(angle)
        local x1 = base_x + radius * math.cos(rad)
        local y1 = base_y + radius * math.sin(rad)
        Graphics.debugPrint(x1, y1, "•", gray)
    end
    
    -- Draw center dot
    Graphics.debugPrint(base_x - 1, base_y - 1, "+", dark_gray)
    
    -- Draw stick position (Vita range: 0-255 with 128 as center)
    local stick_pos_x = base_x + ((stick_x - 128) / 128) * radius * 0.8
    local stick_pos_y = base_y + ((stick_y - 128) / 128) * radius * 0.8
    Graphics.debugPrint(stick_pos_x - 2, stick_pos_y - 2, "●", color_theme or red)
    
    -- Display values with better formatting
    Graphics.debugPrint(x, y + 75, "X: " .. stick_x .. " (" .. math.floor((stick_x - 128) / 128 * 100) .. "%)", white)
    Graphics.debugPrint(x, y + 90, "Y: " .. stick_y .. " (" .. math.floor((stick_y - 128) / 128 * 100) .. "%)", white)
    
    -- Show deadzone indicator
    local deadzone = 10 -- 10% deadzone
    local is_in_deadzone = math.abs(stick_x - 128) < deadzone and math.abs(stick_y - 128) < deadzone
    Graphics.debugPrint(x, y + 105, "Status: " .. (is_in_deadzone and "Neutral" or "Active"), 
                       is_in_deadzone and gray or lime)
end

-- Enhanced touch display
local function drawTouchInfo(x, y)
    Graphics.debugPrint(x, y, "TOUCH INPUT", cyan)
    Graphics.debugPrint(x, y + 15, "Click mouse to simulate", gray)
    Graphics.debugPrint(x, y + 30, "touch input on screen", gray)
    
    -- Show current mouse position if available
    -- This would need additional mouse tracking functionality
end

-- Draw button layout diagram
local function drawButtonLayout(x, y, platform, controls)
    local title = platform .. " Button Layout"
    Graphics.debugPrint(x, y, title, platform == "3DS" and orange or magenta)
    
    local layout_y = y + 20
    
    if platform == "3DS" then
        -- Draw 3DS button layout diagram
        Graphics.debugPrint(x + 60, layout_y, "X", white)      -- Top
        Graphics.debugPrint(x + 40, layout_y + 20, "Y", white) -- Left  
        Graphics.debugPrint(x + 80, layout_y + 20, "A", white) -- Right
        Graphics.debugPrint(x + 60, layout_y + 40, "B", white) -- Bottom
        
        -- Draw connecting lines (simple)
        Graphics.debugPrint(x + 50, layout_y + 10, "┌─┐", dark_gray)
        Graphics.debugPrint(x + 50, layout_y + 30, "└─┘", dark_gray)
        
    else -- Vita
        -- Draw Vita button layout diagram  
        Graphics.debugPrint(x + 60, layout_y, "△", white)      -- Top (Triangle)
        Graphics.debugPrint(x + 40, layout_y + 20, "□", white) -- Left (Square)
        Graphics.debugPrint(x + 80, layout_y + 20, "○", white) -- Right (Circle) 
        Graphics.debugPrint(x + 60, layout_y + 40, "✕", white) -- Bottom (Cross)
        
        -- Draw connecting circle
        Graphics.debugPrint(x + 50, layout_y + 10, "┌─┐", dark_gray)
        Graphics.debugPrint(x + 50, layout_y + 30, "└─┘", dark_gray)
    end
end

-- Draw controller info with enhanced display
local function drawControllerInfo(x, y)
    Graphics.debugPrint(x, y, "CONTROLLER STATUS", cyan)
    local device_info = Controls.getDeviceInfo()
    
    if device_info and type(device_info) == "table" then
        local connected_count = 0
        for port = 1, 4 do
            if device_info[port] and device_info[port].type and device_info[port].type > 0 then
                connected_count = connected_count + 1
                Graphics.debugPrint(x, y + 15 + (connected_count * 15), 
                    "Controller " .. port .. ": Connected", green)
            end
        end
        if connected_count == 0 then
            Graphics.debugPrint(x, y + 15, "No controllers detected", red)
            Graphics.debugPrint(x, y + 30, "Using keyboard input only", gray)
        end
    else
        Graphics.debugPrint(x, y + 15, "Controller info unavailable", gray)
    end
end

-- Draw platform-specific control section
local function drawControlSection(platform, controls, start_x, start_y, cols)
    local platform_color = platform == "3DS" and orange or magenta
    local row_height = 18
    local col_width = 200
    
    Graphics.debugPrint(start_x, start_y, platform .. " CONTROLS:", platform_color)
    
    for i, control in ipairs(controls) do
        local x = start_x + ((i - 1) % cols) * col_width
        local y = start_y + 20 + math.floor((i - 1) / cols) * row_height
        
        if control.button then
            local pad = Controls.read()
            local is_pressed = Controls.check(pad, control.button)
            local color = is_pressed and lime or white
            local status = is_pressed and " ●" or " ○"
            
            -- Format: BUTTON: Key (Description) Status
            local text = control.name .. ": " .. control.keys .. " (" .. control.desc .. ")" .. status
            Graphics.debugPrint(x, y, text, color)
        else
            Graphics.debugPrint(x, y, control.name .. ": ERROR", red)
        end
    end
    
    return start_y + 20 + math.ceil(#controls / cols) * row_height
end

-- Main loop function
function _LPP_MAIN_LOOP()
    -- Handle mode switching
    local pad = Controls.read()
    if Controls.check(pad, SDLK_F1) then
        display_mode = (display_mode - 1) % 3
    elseif Controls.check(pad, SDLK_F2) then
        display_mode = (display_mode + 1) % 3
    end
    
    -- Read analog inputs
    local left_x, left_y = Controls.readLeftAnalog()
    local right_x, right_y = Controls.readRightAnalog()
    
    Graphics.initBlend()
    Screen.clear()
    
    -- Dynamic title based on mode
    local title = "LPP-SDL Controls Demo - " .. mode_names[display_mode + 1]
    Graphics.debugPrint(10, 10, title, yellow)
    Graphics.debugPrint(10, 30, "F1/F2: Switch modes | ESC: Quit | Raw pad: " .. tostring(pad), gray)
    
    local current_y = 55
    
    if display_mode == 0 then
        -- Overview mode - show both platforms side by side
        Graphics.debugPrint(10, current_y, "CROSS-PLATFORM GAMEPAD SUPPORT", cyan)
        current_y = current_y + 25
        
        -- Show both platforms in columns
        local next_y_3ds = drawControlSection("3DS", controls_3ds, 10, current_y, 2)
        local next_y_vita = drawControlSection("Vita", controls_vita, 420, current_y, 2)
        current_y = math.max(next_y_3ds, next_y_vita) + 15
        
        -- Show button layout diagrams
        drawButtonLayout(10, current_y, "3DS", controls_3ds)
        drawButtonLayout(420, current_y, "Vita", controls_vita)
        current_y = current_y + 80
        
    elseif display_mode == 1 then
        -- 3DS focus mode
        Graphics.debugPrint(10, current_y, "3DS PLATFORM - NINTENDO BUTTON LAYOUT", orange)
        Graphics.debugPrint(10, current_y + 15, "Physical buttons map to Nintendo-style actions", white)
        current_y = current_y + 40
        
        current_y = drawControlSection("3DS", controls_3ds, 10, current_y, 3) + 15
        drawButtonLayout(10, current_y, "3DS", controls_3ds)
        current_y = current_y + 80
        
    else
        -- Vita focus mode  
        Graphics.debugPrint(10, current_y, "VITA PLATFORM - PLAYSTATION BUTTON LAYOUT", magenta)
        Graphics.debugPrint(10, current_y + 15, "Physical buttons map to PlayStation-style actions", white)
        current_y = current_y + 40
        
        current_y = drawControlSection("Vita", controls_vita, 10, current_y, 3) + 15
        drawButtonLayout(10, current_y, "Vita", controls_vita)
        current_y = current_y + 80
    end
    
    -- Analog sticks (always shown)
    Graphics.debugPrint(10, current_y, "ANALOG INPUTS", cyan)
    current_y = current_y + 20
    
    local stick_color = display_mode == 1 and orange or (display_mode == 2 and magenta or cyan)
    drawAnalogStick(10, current_y, "LEFT ANALOG", left_x, left_y, stick_color)
    drawAnalogStick(200, current_y, "RIGHT ANALOG", right_x, right_y, stick_color)
    drawTouchInfo(400, current_y)
    current_y = current_y + 130
    
    -- Controller status
    drawControllerInfo(10, current_y)
    current_y = current_y + 70
    
    -- Instructions
    Graphics.debugPrint(10, current_y, "INSTRUCTIONS:", cyan)
    Graphics.debugPrint(10, current_y + 15, "• F1/F2: Switch between platform views", white)
    Graphics.debugPrint(10, current_y + 30, "• Connect gamepad for full button mapping test", white)
    Graphics.debugPrint(10, current_y + 45, "• Button layout adapts automatically to game platform", white)
    Graphics.debugPrint(10, current_y + 60, "• Each platform uses authentic button behavior", white)
    Graphics.debugPrint(10, current_y + 75, "• Press ESC to quit demo", yellow)
    
    Graphics.termBlend()
    Screen.flip()
end