-- Console-based touch test to avoid any screen rendering issues
print("Console touch test starting...")
print("Click and hold mouse button to test touch detection")

oldpad = Controls.read()
local frame_count = 0

while frame_count < 300 do -- Test for 5 seconds at 60fps
    Controls.init()
    pad = Controls.read()
    
    local touching_now = Controls.check(pad, KEY_TOUCH)
    local touching_previous = Controls.check(oldpad, KEY_TOUCH)
    local edge_detected = touching_now and not touching_previous
    
    if edge_detected then
        print("EDGE DETECTED! Touch started on frame " .. frame_count)
        local x, y = Controls.readTouch()
        if x and y then
            print("  Touch coordinates: " .. x .. "," .. y)
        else
            print("  No coordinates returned")
        end
    end
    
    if touching_now then
        if frame_count % 30 == 0 then -- Print every half second when touching
            print("Still touching on frame " .. frame_count)
        end
    end
    
    oldpad = pad
    frame_count = frame_count + 1
    
    -- Small delay to simulate game loop
    Timer.new()
    Timer.sleep(16) -- ~60fps
end

print("Test completed.")