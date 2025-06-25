-- Debug version of PixelRoad to see what's happening with touch detection
red_color = Color.new(255,0,0)
green_color = Color.new(0,255,0)
blue_color = Color.new(0,0,255)
white_color = Color.new(255,255,255)
black_color = Color.new(0,0,0)
yellow_color = Color.new(255,255,0)

print("Starting PixelRoad debug - loading level 1")

-- Load the track
track = Screen.loadBitmap(System.currentDirectory().."/levels/1.bmp")
print("Track loaded")

oldpad = Controls.read()

while true do
    Screen.waitVblankStart()
    Screen.refresh()
    Controls.init()
    pad = Controls.read()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    
    -- Draw the track
    Screen.drawImage(0,0,track,BOTTOM_SCREEN)
    
    -- Debug info on top screen
    Screen.debugPrint(0, 0, "PixelRoad Debug Mode", white_color, TOP_SCREEN)
    Screen.debugPrint(0, 20, "Click on green zone to start", white_color, TOP_SCREEN)
    
    local touching_now = Controls.check(pad, KEY_TOUCH)
    local touching_previous = Controls.check(oldpad, KEY_TOUCH)
    local edge_detected = touching_now and not touching_previous
    
    Screen.debugPrint(0, 40, "Current touch: " .. (touching_now and "YES" or "NO"), 
                     touching_now and green_color or red_color, TOP_SCREEN)
    Screen.debugPrint(0, 60, "Edge detected: " .. (edge_detected and "YES" or "NO"), 
                     edge_detected and white_color or Color.new(100,100,100), TOP_SCREEN)
    
    if edge_detected then
        print("EDGE DETECTED in PixelRoad!")
        local x, y = Controls.readTouch()
        if x and y then
            print("Touch at: " .. x .. "," .. y)
            Screen.debugPrint(0, 80, "Touch: " .. x .. "," .. y, yellow_color, TOP_SCREEN)
            
            -- Check pixel color at touch position
            local pixel_color = Screen.getPixel(x, y, track)
            print("Pixel color at touch: " .. pixel_color)
            Screen.debugPrint(0, 100, "Pixel color: " .. pixel_color, white_color, TOP_SCREEN)
            
            -- Note: green is a number (the packed color value) not a Color object
            local green_value = 65280  -- This should be the packed value for pure green
            Screen.debugPrint(0, 120, "Expected green: " .. green_value, white_color, TOP_SCREEN)
            
            if pixel_color == green_value then
                print("GREEN ZONE DETECTED! Starting game logic...")
                Screen.debugPrint(0, 140, "GREEN ZONE HIT!", green_color, TOP_SCREEN)
            else
                print("Not green zone, pixel color was: " .. pixel_color)
                Screen.debugPrint(0, 140, "Not green zone", red_color, TOP_SCREEN)
            end
        else
            print("No coordinates returned")
            Screen.debugPrint(0, 80, "No coordinates", red_color, TOP_SCREEN)
        end
    end
    
    Screen.flip()
    oldpad = pad
end