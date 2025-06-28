-- Test pixel functions
red = Color.new(255,0,0)
green = Color.new(0,255,0)
blue = Color.new(0,0,255)
white = Color.new(255,255,255)
black = Color.new(0,0,0)

-- Try to load a level bitmap
track = Screen.loadBitmap("tests/games/3ds/pixelroad_1.0/levels/1.bmp")

if track then
    print("Image loaded successfully")
    
    -- Test pixel reading at a few positions
    pixel1 = Screen.getPixel(10, 10, track)
    pixel2 = Screen.getPixel(20, 20, track)
    pixel3 = Screen.getPixel(50, 50, track)
    
    print("Pixel at (10,10):", pixel1)
    print("Pixel at (20,20):", pixel2) 
    print("Pixel at (50,50):", pixel3)
    
    -- Test color comparisons
    print("Green color value:", green)
    print("Blue color value:", blue)
    print("White color value:", white)
    print("Black color value:", black)
    
    if pixel1 == green then
        print("Pixel 1 is green")
    elseif pixel1 == blue then
        print("Pixel 1 is blue")
    elseif pixel1 == white then
        print("Pixel 1 is white")
    elseif pixel1 == black then
        print("Pixel 1 is black")
    else
        print("Pixel 1 is unknown color")
    end
    
    Screen.freeImage(track)
else
    print("Failed to load image")
end

print("Test completed")
System.exit()