-- Simple debug test
red = Color.new(255,0,0)

while true do
    Screen.waitVblankStart()
    Screen.refresh()
    Controls.init()
    pad = Controls.read()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    
    -- Always draw a test pixel at a fixed position
    Screen.drawPixel(100, 100, red, BOTTOM_SCREEN)
    Screen.debugPrint(0,5,"Test pixel at 100,100",red,TOP_SCREEN)
    
    if (Controls.check(pad,KEY_START)) then
        break
    end
    
    Screen.flip()
end

System.exit()