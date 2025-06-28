-- Test touch input and pixel drawing
red = Color.new(255,0,0)
oldpad = Controls.read()

while true do
    Screen.waitVblankStart()
    Screen.refresh()
    Controls.init()
    pad = Controls.read()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    
    Screen.debugPrint(0,5,"Touch test - click bottom screen",red,TOP_SCREEN)
    
    if (Controls.check(pad,KEY_TOUCH) and not Controls.check(oldpad,KEY_TOUCH)) then
        x,y = Controls.readTouch()
        Screen.debugPrint(0,19,"Touch at: " .. x .. "," .. y,red,TOP_SCREEN)
        
        -- Draw a red pixel at touch position
        Screen.drawPixel(x,y,red,BOTTOM_SCREEN)
        Screen.debugPrint(0,33,"Drew pixel at " .. x .. "," .. y,red,TOP_SCREEN)
    end
    
    if (Controls.check(pad,KEY_START)) then
        break
    end
    
    Screen.flip()
    oldpad = pad
end

System.exit()