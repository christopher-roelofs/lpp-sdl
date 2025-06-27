-- Test console with different colors
cns = Console.new(TOP_SCREEN)

-- Add some test text
Console.append(cns, "Testing Console on TOP_SCREEN")
Console.append(cns, "This should be visible")

-- Main loop
while true do
    Screen.waitVblankStart()
    Screen.refresh()
    
    -- Clear with a dark blue background to see if text shows
    Screen.fillRect(0, 400, 0, 240, Color.new(0, 0, 64), TOP_SCREEN)
    
    -- Show console
    Console.show(cns)
    
    -- Also show keyboard state
    local kbState = Keyboard.getState()
    Keyboard.show()
    
    -- Draw debug info
    Graphics.debugPrint(10, 150, "Press X to exit", Color.new(255, 255, 0))
    
    Screen.flip()
    
    -- Exit on X
    if Controls.check(Controls.read(), SCE_CTRL_CROSS) then
        break
    end
end

Console.destroy(cns)