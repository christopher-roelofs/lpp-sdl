-- Enhanced File Manager with Gamepad Support
-- Supports D-pad, analog stick navigation, and gamepad buttons

-- Init colors
local white = Color.new(255, 255, 255)
local yellow = Color.new(255, 255, 0)
local red = Color.new(255, 0, 0)
local green = Color.new(0, 255, 0)
local blue = Color.new(0, 150, 255)
local gray = Color.new(128, 128, 128)
local dark_gray = Color.new(64, 64, 64)

-- Input state tracking
local oldpad = SCE_CTRL_CROSS
local last_analog_time = 0
local analog_delay = 150 -- ms delay between analog inputs

-- File browser state
local scripts = System.listDirectory(".")
local cur_dir = "./"
local selected_index = 1
local scroll_offset = 0
local max_visible = 20 -- entries visible on screen

-- Gamepad detection
local function check_gamepad_available()
    local device_info = Controls.getDeviceInfo()
    if device_info and type(device_info) == "table" then
        for port = 1, 4 do
            if device_info[port] and device_info[port].type and device_info[port].type > 0 then
                return true
            end
        end
    end
    return false
end

local gamepad_connected = check_gamepad_available()

-- Input handling functions
local function handle_navigation_up()
    if selected_index > 1 then
        selected_index = selected_index - 1
        -- Adjust scroll if needed
        if selected_index < scroll_offset + 1 then
            scroll_offset = selected_index - 1
        end
    elseif #scripts > 0 then
        -- Wrap to bottom
        selected_index = #scripts
        scroll_offset = math.max(0, #scripts - max_visible)
    end
end

local function handle_navigation_down()
    if selected_index < #scripts then
        selected_index = selected_index + 1
        -- Adjust scroll if needed
        if selected_index > scroll_offset + max_visible then
            scroll_offset = selected_index - max_visible
        end
    elseif #scripts > 0 then
        -- Wrap to top
        selected_index = 1
        scroll_offset = 0
    end
end

local function handle_action()
    if scripts[selected_index] and scripts[selected_index].directory then
        -- Enter directory
        cur_dir = cur_dir .. scripts[selected_index].name .. "/"
        scripts = System.listDirectory(cur_dir)
        selected_index = 1
        scroll_offset = 0
    else
        -- File selected - could add file opening logic here
        -- For now, just show file info
        print("Selected file: " .. (scripts[selected_index] and scripts[selected_index].name or "unknown"))
    end
end

local function handle_back()
    if string.len(cur_dir) > 2 then -- Excluding ./
        local j = -2
        while string.sub(cur_dir, j, j) ~= "/" do
            j = j - 1
        end
        cur_dir = string.sub(cur_dir, 1, j)
        scripts = System.listDirectory(cur_dir)
        selected_index = 1
        scroll_offset = 0
    end
end

-- Main loop
while true do
    local current_time = os.clock() * 1000 -- Convert to milliseconds
    
    -- Get input
    local pad = Controls.read()
    local left_x, left_y = Controls.readLeftAnalog()
    
    -- Update gamepad connection status periodically
    if current_time % 1000 < 50 then -- Check every second
        gamepad_connected = check_gamepad_available()
    end
    
    -- Handle D-pad and keyboard input (with edge detection)
    if Controls.check(pad, SCE_CTRL_UP) and not Controls.check(oldpad, SCE_CTRL_UP) then
        handle_navigation_up()
    elseif Controls.check(pad, SCE_CTRL_DOWN) and not Controls.check(oldpad, SCE_CTRL_DOWN) then
        handle_navigation_down()
    end
    
    -- Handle analog stick input (with timing delay to prevent too fast movement)
    if gamepad_connected and (current_time - last_analog_time) > analog_delay then
        -- Analog stick navigation (Vita range: 0-255, center at 128)
        if left_y < 100 then -- Stick pushed up
            handle_navigation_up()
            last_analog_time = current_time
        elseif left_y > 156 then -- Stick pushed down
            handle_navigation_down()
            last_analog_time = current_time
        end
    end
    
    -- Handle action buttons (Cross/A for enter, Circle/B for back)
    if Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS) then
        handle_action()
    elseif Controls.check(pad, SCE_CTRL_CIRCLE) and not Controls.check(oldpad, SCE_CTRL_CIRCLE) then
        handle_back()
    end
    
    -- Handle additional gamepad buttons
    if gamepad_connected then
        -- Space (A button) for action
        if Controls.check(pad, SDLK_SPACE) and not Controls.check(oldpad, SDLK_SPACE) then
            handle_action()
        end
        -- Backspace (B button) for back
        if Controls.check(pad, SDLK_BACKSPACE) and not Controls.check(oldpad, SDLK_BACKSPACE) then
            handle_back()
        end
    end
    
    -- Exit on Triangle/Y
    if Controls.check(pad, SCE_CTRL_TRIANGLE) or Controls.check(pad, SDLK_ESCAPE) then
        break
    end
    
    -- Bounds checking
    if #scripts > 0 then
        if selected_index > #scripts then
            selected_index = #scripts
        elseif selected_index < 1 then
            selected_index = 1
        end
        -- Ensure scroll_offset is valid
        scroll_offset = math.max(0, math.min(scroll_offset, #scripts - 1))
    else
        selected_index = 1
        scroll_offset = 0
    end
    
    -- Render
    Graphics.initBlend()
    Screen.clear()
    
    -- Header with enhanced info
    Graphics.debugPrint(5, 5, "Enhanced File Manager with Gamepad Support", yellow)
    local input_info = gamepad_connected and " (Gamepad: Connected)" or " (Keyboard Only)"
    Graphics.debugPrint(5, 25, "Current Directory: " .. cur_dir .. input_info, white)
    
    -- Controls info
    local y_controls = 45
    Graphics.debugPrint(5, y_controls, "Controls:", blue)
    Graphics.debugPrint(5, y_controls + 15, "Navigate: D-Pad/Arrow Keys" .. (gamepad_connected and "/Left Analog" or ""), gray)
    Graphics.debugPrint(5, y_controls + 30, "Enter/Select: X/Cross" .. (gamepad_connected and "/A Button" or ""), gray)
    Graphics.debugPrint(5, y_controls + 45, "Back: O/Circle" .. (gamepad_connected and "/B Button" or ""), gray)
    Graphics.debugPrint(5, y_controls + 60, "Exit: Triangle/Escape", gray)
    
    -- File list
    local start_y = 130
    local line_height = 18
    local files_shown = 0
    
    for j = 1, #scripts do
        if j > scroll_offset and files_shown < max_visible then
            local file = scripts[j]
            local y = start_y + files_shown * line_height
            local x = 5
            local color = white
            
            -- Highlight selected item
            if j == selected_index then
                Graphics.fillRect(0, y - 2, 900, line_height, dark_gray)
                color = yellow
                x = 10
                Graphics.debugPrint(x, y, "> ", red)
                x = x + 20
            end
            
            -- Color code by type
            if file.directory then
                color = green -- Directories in green
                Graphics.debugPrint(x, y, "[DIR] " .. file.name, color)
            else
                -- Files in different colors based on extension
                local ext = string.match(file.name, "%.([^%.]+)$")
                if ext then
                    ext = string.lower(ext)
                    if ext == "lua" then
                        color = blue
                    elseif ext == "txt" or ext == "md" then
                        color = gray
                    end
                end
                Graphics.debugPrint(x, y, file.name, color)
            end
            
            files_shown = files_shown + 1
        end
    end
    
    -- Status bar
    local status_y = start_y + max_visible * line_height + 20
    Graphics.debugPrint(5, status_y, "Files: " .. #scripts .. " | Selected: " .. selected_index, white)
    
    -- Scroll indicator
    if #scripts > max_visible then
        local scroll_bar_x = 880
        local scroll_bar_y = start_y
        local scroll_bar_height = max_visible * line_height
        local thumb_height = math.max(20, scroll_bar_height * max_visible / #scripts)
        local thumb_y = scroll_bar_y + (scroll_bar_height - thumb_height) * scroll_offset / math.max(1, #scripts - max_visible)
        
        Graphics.fillRect(scroll_bar_x, scroll_bar_y, 10, scroll_bar_height, dark_gray)
        Graphics.fillRect(scroll_bar_x + 1, thumb_y, 8, thumb_height, white)
    end
    
    -- Show analog stick values if gamepad connected
    if gamepad_connected then
        Graphics.debugPrint(5, status_y + 20, "Left Analog: " .. left_x .. ", " .. left_y, gray)
    end
    
    Graphics.termBlend()
    Screen.flip()
    
    -- Update input state
    oldpad = pad
    
    -- Small delay to prevent excessive CPU usage
    Timer.sleep(16) -- ~60 FPS
end
