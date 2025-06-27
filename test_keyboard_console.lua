-- Test keyboard and console together (working version)
cns = Console.new(TOP_SCREEN)
last_input = ""

-- Main Loop
while true do
    -- Updating screens
    Screen.waitVblankStart()
    Screen.refresh()
    Screen.clear(TOP_SCREEN)
    
    -- Showing console
    Console.show(cns)
    
    -- Check keyboard state
    local kbState = Keyboard.getState()
    if kbState ~= FINISHED then
        -- Print keyboard graphics
        Keyboard.show()
        
        -- Get current input
        local current_input = Keyboard.getInput()
        
        -- Check if new character was typed
        if #current_input > #last_input then
            -- A new character was typed, append just that character
            local new_char = string.sub(current_input, #last_input + 1, #last_input + 1)
            Console.append(cns, "You typed: " .. new_char)
            last_input = current_input
        elseif #current_input < #last_input then
            -- Backspace was pressed
            Console.append(cns, "[Backspace]")
            last_input = current_input
        end
    else
        -- If user tapped return button, show final text and exit
        if #last_input > 0 then
            Console.append(cns, "Final text: " .. last_input)
        end
        Console.destroy(cns)
        System.exit()
    end
    
    -- Flipping screens
    Screen.flip()
end