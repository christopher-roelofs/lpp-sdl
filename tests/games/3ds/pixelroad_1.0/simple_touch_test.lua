-- Simple touch test
print("Simple touch test - click and hold mouse button")

while true do
    Screen.waitVblankStart()
    Screen.refresh()
    Controls.init()
    pad = Controls.read()
    
    Screen.clear(TOP_SCREEN)
    
    -- Test if touch is detected
    local touching = Controls.check(pad, KEY_TOUCH)
    
    if touching then
        Screen.debugPrint(0, 0, "MOUSE DETECTED!", Color.new(255,0,0), TOP_SCREEN)
        local x, y = Controls.readTouch()
        if x and y then
            Screen.debugPrint(0, 20, "Pos: " .. x .. "," .. y, Color.new(255,255,255), TOP_SCREEN)
        else
            Screen.debugPrint(0, 20, "No coordinates returned", Color.new(255,255,255), TOP_SCREEN)
        end
    else
        Screen.debugPrint(0, 0, "Click and hold mouse button", Color.new(255,255,255), TOP_SCREEN)
        Screen.debugPrint(0, 20, "KEY_TOUCH = " .. KEY_TOUCH, Color.new(255,255,255), TOP_SCREEN)
    end
    
    Screen.flip()
end