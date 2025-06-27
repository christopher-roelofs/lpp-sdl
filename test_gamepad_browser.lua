-- Test file for gamepad file browser
print("Gamepad file browser test successful!")
print("This file was selected using gamepad controls!")

-- Simple test loop
for i = 1, 100 do
    Graphics.initBlend()
    Screen.clear()
    Graphics.debugPrint(50, 50, "File browser gamepad test success!", Color.new(0, 255, 0))
    Graphics.debugPrint(50, 80, "Selected with gamepad controls", Color.new(255, 255, 255))
    Graphics.debugPrint(50, 110, "Press any key to exit...", Color.new(200, 200, 200))
    Graphics.termBlend()
    Screen.flip()
    
    local pad = Controls.read()
    if pad ~= 0 then
        break
    end
    
    Timer.sleep(50)
end

System.exit()