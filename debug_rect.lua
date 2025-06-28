-- Test with a visible rectangle instead of single pixel
red = Color.new(255,0,0)

while true do
    Screen.waitVblankStart()
    Screen.refresh()
    Controls.init()
    pad = Controls.read()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    
    -- Draw a small filled rectangle at 100,100 on bottom screen
    Screen.fillRect(100, 100, 110, 110, red, BOTTOM_SCREEN)
    Screen.debugPrint(0,5,"Test rectangle at 100,100",red,TOP_SCREEN)
    
    if (Controls.check(pad,KEY_START)) then
        break
    end
    
    Screen.flip()
end

System.exit()