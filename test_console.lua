-- Simple console test
cns = Console.new(TOP_SCREEN)

-- Add some test text
Console.append(cns, "Hello from Console!")
Console.append(cns, "Line 2")
Console.append(cns, "Line 3")

-- Main loop
while true do
    Screen.waitVblankStart()
    Screen.refresh()
    Screen.clear(TOP_SCREEN)
    
    -- Show console
    Console.show(cns)
    
    -- Also draw some debug text
    Screen.debugPrint(10, 100, "Debug: Console should be visible above", Color.new(255, 255, 0), TOP_SCREEN)
    
    Screen.flip()
    
    -- Exit on triangle
    if Controls.check(Controls.read(), SCE_CTRL_TRIANGLE) then
        break
    end
end

Console.destroy(cns)