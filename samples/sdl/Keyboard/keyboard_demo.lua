-- On-Screen Keyboard Demo for lpp-sdl
-- Shows how to use the software keyboard with gamepad/keyboard support

-- Initialize graphics
Graphics.initBlend()

local input_text = ""
local keyboard_active = false
local message = "Press SPACE to open keyboard, ESC to exit"

-- Main Loop
while true do
    -- Clear screen
    Screen.clear()
    Graphics.initBlend()
    
    -- Draw interface
    Graphics.debugPrint(10, 10, "lpp-sdl Keyboard Demo", Color.new(255, 255, 255))
    Graphics.debugPrint(10, 40, message, Color.new(200, 200, 200))
    Graphics.debugPrint(10, 80, "Current text: " .. input_text, Color.new(0, 255, 0))
    
    -- Handle keyboard state
    local kbState = Keyboard.getState()
    
    if keyboard_active then
        if kbState == FINISHED then
            -- User pressed Enter/OK
            input_text = Keyboard.getInput()
            Keyboard.clear()
            keyboard_active = false
            message = "Text entered! Press SPACE for new input, ESC to exit"
            
        elseif kbState == CANCELED then
            -- User pressed Cancel/Circle
            Keyboard.clear()
            keyboard_active = false
            message = "Input canceled. Press SPACE for new input, ESC to exit"
            
        elseif kbState == RUNNING then
            -- Keyboard is active - draw it and handle input
            Keyboard.draw()
            
            -- Handle input using modern update for gamepad support
            Keyboard.updateModern()
            
            message = "Use D-Pad to navigate, Cross to select, Circle to cancel"
        end
    else
        -- Read controls
        local pad = Controls.read()
        
        if Controls.check(pad, SDLK_SPACE) then
            -- Start keyboard
            Keyboard.start("Enter Text:", input_text)
            keyboard_active = true
            System.wait(200) -- Debounce
            
        elseif Controls.check(pad, SDLK_ESCAPE) then
            -- Exit
            break
        end
    end
    
    Graphics.termBlend()
    Screen.flip()
end

-- Cleanup
if keyboard_active then
    Keyboard.clear()
end
Graphics.termBlend()