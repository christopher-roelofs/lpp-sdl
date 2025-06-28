-- Test both screens
red = Color.new(255,0,0)
green = Color.new(0,255,0)

while true do
    Screen.waitVblankStart()
    Screen.refresh()
    Controls.init()
    pad = Controls.read()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    
    -- Draw rectangle on TOP screen
    Screen.fillRect(50, 50, 60, 60, red, TOP_SCREEN)
    Screen.debugPrint(0,5,"Red rect on TOP screen",red,TOP_SCREEN)
    
    -- Draw rectangle on BOTTOM screen  
    Screen.fillRect(50, 50, 60, 60, green, BOTTOM_SCREEN)
    Screen.debugPrint(0,19,"Green rect on BOTTOM screen",red,TOP_SCREEN)
    
    if (Controls.check(pad,KEY_START)) then
        break
    end
    
    Screen.flip()
end

System.exit()