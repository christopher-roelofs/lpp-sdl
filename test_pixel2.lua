-- Test pixel functions with more positions
red = Color.new(255,0,0)
green = Color.new(0,255,0)
blue = Color.new(0,0,255)
white = Color.new(255,255,255)
black = Color.new(0,0,0)

-- Try to load a level bitmap
track = Screen.loadBitmap("tests/games/3ds/pixelroad_1.0/levels/1.bmp")

if track then
    print("Image loaded successfully")
    
    -- Test many positions to find different colors
    for y = 0, 20 do
        for x = 0, 20 do
            pixel = Screen.getPixel(x, y, track)
            if pixel ~= white and pixel ~= black then
                print("Found non-white/black pixel at (" .. x .. "," .. y .. "):", pixel)
                if pixel == green then
                    print("  -> This is GREEN!")
                elseif pixel == blue then
                    print("  -> This is BLUE!")
                elseif pixel == red then
                    print("  -> This is RED!")
                end
            end
        end
    end
    
    Screen.freeImage(track)
else
    print("Failed to load image")
end

print("Test completed")
System.exit()