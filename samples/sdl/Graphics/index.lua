-- Graphics sample converted for SDL port
print("Loading Graphics test...")

local white = Color.new(255,255,255)
local red = Color.new(255,0,0)
local green = Color.new(0,255,0)
local blue = Color.new(0,0,255)

print("Graphics test loaded")

-- Main loop function called by SDL
function _LPP_MAIN_LOOP()
    -- Basic graphics test
    Graphics.initBlend()
    Screen.clear()
    
    Graphics.debugPrint(5, 10, "LPP-Vita SDL Graphics Test", white)
    Graphics.debugPrint(5, 30, "Press ESC (Triangle) to exit", white)
    
    -- Draw some basic shapes
    Graphics.debugPrint(5, 60, "Basic shapes:", white)
    Graphics.drawPixel(50, 100, red)
    Graphics.drawPixel(52, 100, green) 
    Graphics.drawPixel(54, 100, blue)
    
    Graphics.drawLine(70, 100, 150, 120, red)
    Graphics.drawRect(70, 130, 80, 40, green)
    Graphics.fillRect(170, 130, 80, 40, blue)
    
    Graphics.drawCircle(120, 200, 30, red)
    Graphics.fillCircle(200, 200, 30, green)
    
    Graphics.debugPrint(5, 260, "Shapes test complete", white)
    
    Graphics.termBlend()
    
    -- Check for input
    if Controls.check(Controls.read(), SCE_CTRL_TRIANGLE) then
        print("Exiting graphics test")
        System.exit()
    end
    
    -- Flip screen
    Screen.flip()
end

print("Graphics test main loop function ready")