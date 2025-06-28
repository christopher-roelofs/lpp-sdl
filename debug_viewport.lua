-- Debug viewport clipping
red = Color.new(255,0,0)
green = Color.new(0,255,0)

while true do
    Screen.waitVblankStart()
    Screen.refresh()
    Controls.init()
    pad = Controls.read()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    
    -- Try drawing without using screen parameter (should default to TOP_SCREEN)
    Screen.fillRect(50, 50, 60, 60, red)
    Screen.debugPrint(0,5,"Red rect (no screen param)",red,TOP_SCREEN)
    
    -- Try drawing with explicit TOP_SCREEN
    Screen.fillRect(70, 70, 80, 80, green, TOP_SCREEN) 
    Screen.debugPrint(0,19,"Green rect on TOP_SCREEN",red,TOP_SCREEN)
    
    if (Controls.check(pad,KEY_START)) then
        break
    end
    
    Screen.flip()
end

System.exit()