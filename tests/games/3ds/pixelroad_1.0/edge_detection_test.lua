-- Edge detection test for touch input
print("Edge detection test - testing if edge detection works for touch")

oldpad = Controls.read()

while true do
    Screen.waitVblankStart()
    Screen.refresh()
    Controls.init()
    pad = Controls.read()
    
    Screen.clear(TOP_SCREEN)
    
    -- Test edge detection: touch just started this frame
    local touching_now = Controls.check(pad, KEY_TOUCH)
    local touching_previous = Controls.check(oldpad, KEY_TOUCH)
    local edge_detected = touching_now and not touching_previous
    
    Screen.debugPrint(0, 0, "Current touch: " .. (touching_now and "TRUE" or "FALSE"), 
                     touching_now and Color.new(0,255,0) or Color.new(255,0,0), TOP_SCREEN)
    
    Screen.debugPrint(0, 20, "Previous touch: " .. (touching_previous and "TRUE" or "FALSE"), 
                     touching_previous and Color.new(0,255,0) or Color.new(255,0,0), TOP_SCREEN)
    
    Screen.debugPrint(0, 40, "Edge detected: " .. (edge_detected and "TRUE" or "FALSE"), 
                     edge_detected and Color.new(255,255,0) or Color.new(100,100,100), TOP_SCREEN)
    
    Screen.debugPrint(0, 60, "pad=" .. pad .. " oldpad=" .. oldpad, Color.new(255,255,255), TOP_SCREEN)
    Screen.debugPrint(0, 80, "KEY_TOUCH=" .. KEY_TOUCH, Color.new(255,255,255), TOP_SCREEN)
    
    if edge_detected then
        Screen.debugPrint(0, 100, "TOUCH EDGE DETECTED! Click works!", Color.new(0,255,255), TOP_SCREEN)
        local x, y = Controls.readTouch()
        if x and y then
            Screen.debugPrint(0, 120, "Touch pos: " .. x .. "," .. y, Color.new(255,255,255), TOP_SCREEN)
        end
    else
        Screen.debugPrint(0, 100, "Click to test edge detection", Color.new(200,200,200), TOP_SCREEN)
    end
    
    Screen.flip()
    oldpad = pad
end