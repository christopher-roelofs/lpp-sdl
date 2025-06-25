-- Comprehensive touch test for debugging click and drag issues
print("Comprehensive touch test - testing all aspects of touch input")

while true do
    Screen.waitVblankStart()
    Screen.refresh()
    Controls.init()
    pad = Controls.read()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    
    -- Test if touch is detected
    local touching = Controls.check(pad, KEY_TOUCH)
    
    Screen.debugPrint(0, 0, "Touch Status: " .. (touching and "TOUCHING" or "NOT TOUCHING"), 
                     touching and Color.new(0,255,0) or Color.new(255,0,0), TOP_SCREEN)
    
    Screen.debugPrint(0, 20, "KEY_TOUCH value: " .. KEY_TOUCH, Color.new(255,255,255), TOP_SCREEN)
    Screen.debugPrint(0, 40, "pad value: " .. pad, Color.new(255,255,255), TOP_SCREEN)
    
    if touching then
        local x, y = Controls.readTouch()
        if x and y then
            Screen.debugPrint(0, 60, "Touch coordinates: " .. x .. "," .. y, Color.new(0,255,255), TOP_SCREEN)
            
            -- Show touch position on bottom screen if coordinates are in range
            if x >= 0 and x <= 320 and y >= 0 and y <= 240 then
                Screen.debugPrint(0, 80, "Bottom screen touch detected", Color.new(255,255,0), TOP_SCREEN)
                -- Draw a circle at touch position on bottom screen
                if x > 5 and x < 315 and y > 5 and y < 235 then
                    for dx = -2, 2 do
                        for dy = -2, 2 do
                            if dx*dx + dy*dy <= 4 then
                                Screen.drawPixel(x + dx, y + dy, Color.new(255,0,0), BOTTOM_SCREEN)
                            end
                        end
                    end
                end
                Screen.debugPrint(x - 20, y - 10, "TOUCH", Color.new(255,255,255), BOTTOM_SCREEN)
            else
                Screen.debugPrint(0, 80, "Touch outside bottom screen range", Color.new(255,100,100), TOP_SCREEN)
            end
        else
            Screen.debugPrint(0, 60, "Touch detected but no coordinates", Color.new(255,255,0), TOP_SCREEN)
        end
    else
        Screen.debugPrint(0, 60, "Hold left mouse button to test", Color.new(200,200,200), TOP_SCREEN)
    end
    
    -- Show some instructions
    Screen.debugPrint(0, 100, "Instructions:", Color.new(255,255,255), TOP_SCREEN)
    Screen.debugPrint(0, 120, "- Click and hold left mouse button", Color.new(200,200,200), TOP_SCREEN)
    Screen.debugPrint(0, 140, "- Move mouse around", Color.new(200,200,200), TOP_SCREEN)
    Screen.debugPrint(0, 160, "- Touch indicator should appear on bottom screen", Color.new(200,200,200), TOP_SCREEN)
    
    Screen.flip()
end