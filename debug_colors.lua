-- Debug script to test color values
green = Color.new(0,255,0)
blue = Color.new(0,0,255)

print("Green color value:", green)
print("Blue color value:", blue)

-- Test if we can load the level bitmap
track = Screen.loadBitmap("tests/games/3ds/pixelroad_1.0/levels/1.bmp")
if track then
    print("Loaded track successfully")
    
    -- Test some pixel values
    pixel1 = Screen.getPixel(10, 10, track)
    pixel2 = Screen.getPixel(50, 50, track)
    pixel3 = Screen.getPixel(100, 100, track)
    
    print("Pixel at (10,10):", pixel1)
    print("Pixel at (50,50):", pixel2) 
    print("Pixel at (100,100):", pixel3)
    
    print("Green == pixel1?", green == pixel1)
    print("Green == pixel2?", green == pixel2)
    print("Green == pixel3?", green == pixel3)
else
    print("Failed to load track")
end

System.exit()