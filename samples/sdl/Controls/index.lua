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

-- Display mode: 0 = Overview, 1 = Native Focus, 2 = 3DS Focus, 3 = Vita Focus, 4 = SDL Gamepad Focus
local display_mode = 0
local mode_names = {"Cross-Platform Overview", "Native Platform Focus", "3DS Platform Focus", "Vita Platform Focus", "SDL Gamepad Focus"}
local last_key_press = 0  -- To prevent rapid mode switching

-- Native button mappings (intuitive layout)
local controls_native = {
    {name = "Primary Action", button = SDLK_SPACE, keys = "Space", pos = "Main", desc = "Jump/Confirm"},
    {name = "Secondary Action", button = SDLK_BACKSPACE, keys = "Backspace", pos = "Main", desc = "Back/Cancel"},
    {name = "X Action", button = SDLK_X, keys = "X", pos = "Main", desc = "Action X"},
    {name = "Y Action", button = SDLK_Y, keys = "Y", pos = "Main", desc = "Action Y"},
    {name = "Left Shoulder", button = SDLK_Q, keys = "Q", pos = "Shoulder", desc = "L1/LB"},
    {name = "Right Shoulder", button = SDLK_E, keys = "E", pos = "Shoulder", desc = "R1/RB"},
    {name = "Start/Menu", button = SDLK_RETURN, keys = "Return", pos = "System", desc = "Start Game"},
    {name = "Back/Select", button = SDLK_TAB, keys = "Tab", pos = "System", desc = "Back/Menu"},
    {name = "D-UP", button = SDLK_UP, keys = "↑ Arrow", pos = "D-Pad", desc = "Move Up"},
    {name = "D-DOWN", button = SDLK_DOWN, keys = "↓ Arrow", pos = "D-Pad", desc = "Move Down"},
    {name = "D-LEFT", button = SDLK_LEFT, keys = "← Arrow", pos = "D-Pad", desc = "Move Left"},
    {name = "D-RIGHT", button = SDLK_RIGHT, keys = "→ Arrow", pos = "D-Pad", desc = "Move Right"},
    {name = "Escape/Guide", button = SDLK_ESCAPE, keys = "Escape", pos = "System", desc = "Exit/Guide"}
}

-- 3DS button mappings (Nintendo layout)
local controls_3ds = {
    {name = "A", button = SDLK_RETURN, keys = "Return", pos = "Right", desc = "Confirm/OK"},
    {name = "B", button = SDLK_BACKSPACE, keys = "Backspace", pos = "Bottom", desc = "Cancel/Back"},
    {name = "X", button = SDLK_SPACE, keys = "Space", pos = "Top", desc = "Action"},
    {name = "Y", button = SDLK_LSHIFT, keys = "LShift", pos = "Left", desc = "Action"},
    {name = "L", button = SDLK_Q, keys = "Q", pos = "Left Shoulder", desc = "Shoulder"},
    {name = "R", button = SDLK_E, keys = "E", pos = "Right Shoulder", desc = "Shoulder"},
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

-- SDL Gamepad button mappings (raw SDL controller buttons)
local controls_sdl_gamepad = {
    {name = "A Button", button = SDLK_SPACE, keys = "Space", pos = "Bottom", desc = "Primary Action"},
    {name = "B Button", button = SDLK_BACKSPACE, keys = "Backspace", pos = "Right", desc = "Secondary Action"},
    {name = "X Button", button = SDLK_Z, keys = "Z", pos = "Left", desc = "Third Action"},
    {name = "Y Button", button = SDLK_X, keys = "X", pos = "Top", desc = "Fourth Action"},
    {name = "Left Shoulder", button = SDLK_Q, keys = "Q", pos = "Left Shoulder", desc = "L1/LB"},
    {name = "Right Shoulder", button = SDLK_E, keys = "E", pos = "Right Shoulder", desc = "R1/RB"},
    {name = "Left Trigger", button = SDLK_PAGEUP, keys = "Page Up", pos = "Left Trigger", desc = "L2/LT"},
    {name = "Right Trigger", button = SDLK_PAGEDOWN, keys = "Page Down", pos = "Right Trigger", desc = "R2/RT"},
    {name = "Start Button", button = SDLK_RETURN, keys = "Return", pos = "System", desc = "Menu/Pause"},
    {name = "Back/Select", button = SDLK_TAB, keys = "Tab", pos = "System", desc = "Back/View"},
    {name = "D-Pad Up", button = SDLK_UP, keys = "↑ Arrow", pos = "D-Pad", desc = "Navigate Up"},
    {name = "D-Pad Down", button = SDLK_DOWN, keys = "↓ Arrow", pos = "D-Pad", desc = "Navigate Down"},
    {name = "D-Pad Left", button = SDLK_LEFT, keys = "← Arrow", pos = "D-Pad", desc = "Navigate Left"},
    {name = "D-Pad Right", button = SDLK_RIGHT, keys = "→ Arrow", pos = "D-Pad", desc = "Navigate Right"},
    {name = "Guide Button", button = SDLK_H, keys = "H", pos = "System", desc = "Home/Guide"},
    {name = "Left Stick Click", button = SDLK_LSHIFT, keys = "LShift", pos = "Analog", desc = "L3 Click"}
}

-- Enhanced analog stick display with better visuals
local function drawAnalogStick(x, y, title, stick_x, stick_y, color_theme)
    -- Draw title with platform-specific color
    Graphics.debugPrint(x, y, title, color_theme or cyan)
    
    -- Draw stick base (simplified circle to avoid overlapping)
    local base_x = x + 50
    local base_y = y + 25
    local radius = 20
    
    -- Draw simplified circle border (fewer points to avoid overlap)
    for angle = 0, 315, 45 do
        local rad = math.rad(angle)
        local x1 = base_x + radius * math.cos(rad)
        local y1 = base_y + radius * math.sin(rad)
        Graphics.debugPrint(math.floor(x1), math.floor(y1), ".", gray)
    end
    
    -- Draw center reference
    Graphics.debugPrint(base_x, base_y, "+", dark_gray)
    
    -- Draw stick position (Vita range: 0-255 with 128 as center)
    local stick_pos_x = base_x + ((stick_x - 128) / 128) * radius * 0.7
    local stick_pos_y = base_y + ((stick_y - 128) / 128) * radius * 0.7
    Graphics.debugPrint(math.floor(stick_pos_x), math.floor(stick_pos_y), "*", color_theme or red)
    
    -- Display values with better formatting
    local x_percent = math.floor((stick_x - 128) / 1.28)
    local y_percent = math.floor((stick_y - 128) / 1.28)
    Graphics.debugPrint(x, y + 60, "X: " .. stick_x .. " (" .. x_percent .. "%)", white)
    Graphics.debugPrint(x, y + 75, "Y: " .. stick_y .. " (" .. y_percent .. "%)", white)
    
    -- Show deadzone indicator
    local deadzone = 10 -- 10% deadzone
    local is_in_deadzone = math.abs(stick_x - 128) < deadzone and math.abs(stick_y - 128) < deadzone
    Graphics.debugPrint(x, y + 90, "Status: " .. (is_in_deadzone and "Neutral" or "Active"), 
                       is_in_deadzone and gray or lime)
end

-- Enhanced touch display
local function drawTouchInfo(x, y)
    Graphics.debugPrint(x, y, "TOUCH/MOUSE INPUT", cyan)
    
    -- Try to get touch coordinates
    local touch_x, touch_y = Controls.readTouch()
    
    -- Handle nil values safely
    if touch_x and touch_y and touch_x > 0 and touch_y > 0 then
        Graphics.debugPrint(x, y + 15, "Status: ACTIVE", lime)
        Graphics.debugPrint(x, y + 30, "X: " .. touch_x, white)
        Graphics.debugPrint(x, y + 45, "Y: " .. touch_y, white)
        
        -- Draw a simple indicator
        Graphics.debugPrint(x + 100, y + 15, "*", red)
        Graphics.debugPrint(x, y + 60, "Touch detected!", yellow)
    else
        Graphics.debugPrint(x, y + 15, "Status: No Touch", gray)
        Graphics.debugPrint(x, y + 30, "Click/tap to test", gray)
        Graphics.debugPrint(x, y + 45, "mouse or touch input", gray)
        
        -- Draw inactive indicator
        Graphics.debugPrint(x + 100, y + 15, "o", dark_gray)
    end
end

-- Draw button layout diagram
local function drawButtonLayout(x, y, platform, controls)
    local title = platform .. " Button Layout"
    Graphics.debugPrint(x, y, title, platform == "Native" and green or (platform == "3DS" and orange or (platform == "SDL Gamepad" and blue or magenta)))
    
    local layout_y = y + 20
    
    if platform == "Native" then
        -- Draw Native button layout diagram (intuitive layout)
        Graphics.debugPrint(x + 60, layout_y, "Y", white)      -- Top
        Graphics.debugPrint(x + 40, layout_y + 20, "X", white) -- Left
        Graphics.debugPrint(x + 80, layout_y + 20, "B", white) -- Right (Secondary)
        Graphics.debugPrint(x + 60, layout_y + 40, "A", white) -- Bottom (Primary)
        
        -- Draw connecting frame
        Graphics.debugPrint(x + 50, layout_y + 10, "+---+", dark_gray)
        Graphics.debugPrint(x + 50, layout_y + 30, "+---+", dark_gray)
        
    elseif platform == "3DS" then
        -- Draw 3DS button layout diagram
        Graphics.debugPrint(x + 60, layout_y, "X", white)      -- Top
        Graphics.debugPrint(x + 40, layout_y + 20, "Y", white) -- Left  
        Graphics.debugPrint(x + 80, layout_y + 20, "A", white) -- Right
        Graphics.debugPrint(x + 60, layout_y + 40, "B", white) -- Bottom
        
        -- Draw connecting lines (ASCII only)
        Graphics.debugPrint(x + 50, layout_y + 10, "+---+", dark_gray)
        Graphics.debugPrint(x + 50, layout_y + 30, "+---+", dark_gray)
        
    elseif platform == "Vita" then
        -- Draw Vita button layout diagram (ASCII only)
        Graphics.debugPrint(x + 60, layout_y, "^", white)      -- Top (Triangle)
        Graphics.debugPrint(x + 40, layout_y + 20, "#", white) -- Left (Square)
        Graphics.debugPrint(x + 80, layout_y + 20, "O", white) -- Right (Circle) 
        Graphics.debugPrint(x + 60, layout_y + 40, "X", white) -- Bottom (Cross)
        
        -- Draw connecting frame
        Graphics.debugPrint(x + 50, layout_y + 10, "+---+", dark_gray)
        Graphics.debugPrint(x + 50, layout_y + 30, "+---+", dark_gray)
        
    elseif platform == "SDL Gamepad" then
        -- Draw SDL gamepad button layout diagram (shows SDL logical mapping)
        Graphics.debugPrint(x + 60, layout_y, "Y", white)      -- Top (SDL Y)
        Graphics.debugPrint(x + 40, layout_y + 20, "X", white) -- Left (SDL X)
        Graphics.debugPrint(x + 80, layout_y + 20, "B", white) -- Right (SDL B) 
        Graphics.debugPrint(x + 60, layout_y + 40, "A", white) -- Bottom (SDL A)
        
        -- Draw connecting frame
        Graphics.debugPrint(x + 50, layout_y + 10, "+---+", dark_gray)
        Graphics.debugPrint(x + 50, layout_y + 30, "+---+", dark_gray)
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
    local platform_color = platform == "Native" and green or (platform == "3DS" and orange or (platform == "SDL Gamepad" and blue or magenta))
    local row_height = 20  -- Increased for better spacing
    local col_width = platform == "3DS" and 280 or 320  -- Wider columns to prevent overlap
    
    Graphics.debugPrint(start_x, start_y, platform .. " CONTROLS:", platform_color)
    
    for i, control in ipairs(controls) do
        local x = start_x + ((i - 1) % cols) * col_width
        local y = start_y + 25 + math.floor((i - 1) / cols) * row_height  -- More space after header
        
        if control.button then
            local pad = Controls.read()
            local is_pressed = Controls.check(pad, control.button)
            local color = is_pressed and lime or white
            local status = is_pressed and " [ON]" or " [--]"
            
            -- Single line format to prevent extra text
            local text = control.name .. ": " .. control.desc .. status
            Graphics.debugPrint(x, y, text, color)
        else
            Graphics.debugPrint(x, y, control.name .. ": ERROR", red)
        end
    end
    
    -- Calculate actual height used
    local total_rows = math.ceil(#controls / cols)
    return start_y + 25 + (total_rows * row_height) + 10  -- Reduced padding
end

-- Main loop function
function _LPP_MAIN_LOOP()
    -- Handle mode switching with debouncing
    local pad = Controls.read()
    local current_time = os.clock() * 1000  -- Convert to milliseconds
    
    if (current_time - last_key_press) > 200 then  -- 200ms debounce
        if Controls.check(pad, SDLK_F1) then
            display_mode = (display_mode - 1) % 5
            last_key_press = current_time
        elseif Controls.check(pad, SDLK_F2) then
            display_mode = (display_mode + 1) % 5
            last_key_press = current_time
        end
    end
    
    -- Read analog inputs
    local left_x, left_y = Controls.readLeftAnalog()
    local right_x, right_y = Controls.readRightAnalog()
    
    Graphics.initBlend()
    Screen.clear()
    -- Ensure complete screen clear with explicit background
    Screen.fillRect(0, 0, 2000, 1000, Color.new(0, 0, 0))
    
    -- Dynamic title based on mode
    local title = "LPP-SDL Controls Demo - " .. mode_names[display_mode + 1]
    Graphics.debugPrint(10, 10, title, yellow)
    Graphics.debugPrint(10, 30, "F1/F2: Switch modes | ESC: Quit | Raw pad: " .. tostring(pad), gray)
    
    local current_y = 55
    
    if display_mode == 0 then
        -- Overview mode - show all four platforms side by side
        Graphics.debugPrint(10, current_y, "CROSS-PLATFORM GAMEPAD SUPPORT", cyan)
        current_y = current_y + 30
        
        -- Show all four platforms in columns (extra wide spacing to prevent overlap)
        local next_y_native = drawControlSection("Native", controls_native, 10, current_y, 1)
        local next_y_3ds = drawControlSection("3DS", controls_3ds, 320, current_y, 1)
        local next_y_vita = drawControlSection("Vita", controls_vita, 630, current_y, 1)
        local next_y_sdl = drawControlSection("SDL Gamepad", controls_sdl_gamepad, 940, current_y, 1)
        current_y = math.max(next_y_native, next_y_3ds, next_y_vita, next_y_sdl) + 20
        
        -- Show button layout diagrams
        drawButtonLayout(10, current_y, "Native", controls_native)
        drawButtonLayout(320, current_y, "3DS", controls_3ds)
        drawButtonLayout(630, current_y, "Vita", controls_vita)
        drawButtonLayout(940, current_y, "SDL Gamepad", controls_sdl_gamepad)
        current_y = current_y + 90
        
    elseif display_mode == 1 then
        -- Native focus mode
        Graphics.debugPrint(10, current_y, "NATIVE PLATFORM - INTUITIVE BUTTON LAYOUT", green)
        Graphics.debugPrint(10, current_y + 18, "Logical button mapping for modern games", white)
        current_y = current_y + 45
        
        current_y = drawControlSection("Native", controls_native, 10, current_y, 2) + 20
        drawButtonLayout(10, current_y, "Native", controls_native)
        current_y = current_y + 90
        
    elseif display_mode == 2 then
        -- 3DS focus mode
        Graphics.debugPrint(10, current_y, "3DS PLATFORM - NINTENDO BUTTON LAYOUT", orange)
        Graphics.debugPrint(10, current_y + 18, "Physical buttons map to Nintendo-style actions", white)
        current_y = current_y + 45
        
        current_y = drawControlSection("3DS", controls_3ds, 10, current_y, 2) + 20
        drawButtonLayout(10, current_y, "3DS", controls_3ds)
        current_y = current_y + 90
        
    elseif display_mode == 3 then
        -- Vita focus mode  
        Graphics.debugPrint(10, current_y, "VITA PLATFORM - PLAYSTATION BUTTON LAYOUT", magenta)
        Graphics.debugPrint(10, current_y + 18, "Physical buttons map to PlayStation-style actions", white)
        current_y = current_y + 45
        
        current_y = drawControlSection("Vita", controls_vita, 10, current_y, 2) + 20
        drawButtonLayout(10, current_y, "Vita", controls_vita)
        current_y = current_y + 90
        
    else
        -- SDL Gamepad focus mode
        Graphics.debugPrint(10, current_y, "SDL GAMEPAD - RAW CONTROLLER INPUT", blue)
        Graphics.debugPrint(10, current_y + 18, "Direct SDL controller button mapping (Xbox/standard layout)", white)
        current_y = current_y + 45
        
        current_y = drawControlSection("SDL Gamepad", controls_sdl_gamepad, 10, current_y, 2) + 20
        drawButtonLayout(10, current_y, "SDL Gamepad", controls_sdl_gamepad)
        current_y = current_y + 90
    end
    
    -- Analog sticks (always shown)
    Graphics.debugPrint(10, current_y, "ANALOG INPUTS", cyan)
    current_y = current_y + 25
    
    local stick_color = display_mode == 1 and green or (display_mode == 2 and orange or (display_mode == 3 and magenta or (display_mode == 4 and blue or cyan)))
    drawAnalogStick(10, current_y, "LEFT ANALOG", left_x, left_y, stick_color)
    drawAnalogStick(180, current_y, "RIGHT ANALOG", right_x, right_y, stick_color)
    drawTouchInfo(350, current_y)
    current_y = current_y + 115  -- Reduced height since analog display is smaller
    
    -- Controller status
    drawControllerInfo(10, current_y)
    current_y = current_y + 80
    
    -- Instructions
    Graphics.debugPrint(10, current_y, "INSTRUCTIONS:", cyan)
    Graphics.debugPrint(10, current_y + 15, "• F1/F2: Switch between platform views", white)
    Graphics.debugPrint(10, current_y + 30, "• Connect gamepad for full button mapping test", white)
    Graphics.debugPrint(10, current_y + 45, "• Button layout adapts automatically to game platform", white)
    Graphics.debugPrint(10, current_y + 60, "• Each platform uses authentic button behavior", white)
    Graphics.debugPrint(10, current_y + 75, "• Press ESC to quit demo", yellow)
    
    Graphics.termBlend()
    Screen.flip()
    
    -- Small delay to prevent screen tearing/ghosting
    Timer.sleep(16)  -- ~60 FPS
end