-- Test Graphics.setPixel function
red = Color.new(255,0,0)
green = Color.new(0,255,0)
blue = Color.new(0,0,255)
white = Color.new(255,255,255)
black = Color.new(0,0,0)

print("Testing Graphics.setPixel functionality...")

-- Load an image
image = Graphics.loadImage("tests/games/3ds/pixelroad_1.0/levels/1.bmp")

if image then
    print("Image loaded successfully")
    
    -- Test reading original pixel
    original_pixel = Graphics.getPixel(10, 10, image)
    print("Original pixel at (10,10):", original_pixel)
    
    -- Set a red pixel
    Graphics.setPixel(10, 10, red, image)
    
    -- Read it back
    new_pixel = Graphics.getPixel(10, 10, image)
    print("New pixel at (10,10) after setting red:", new_pixel)
    print("Red color value:", red)
    
    if new_pixel == red then
        print("SUCCESS: setPixel correctly set red pixel!")
    else
        print("FAILED: setPixel did not set red pixel correctly")
    end
    
    -- Test setting different colors
    Graphics.setPixel(15, 15, green, image)
    green_pixel = Graphics.getPixel(15, 15, image)
    print("Green pixel test:", green_pixel, "Expected:", green)
    
    Graphics.setPixel(20, 20, blue, image)
    blue_pixel = Graphics.getPixel(20, 20, image)
    print("Blue pixel test:", blue_pixel, "Expected:", blue)
    
    -- Test bounds checking
    Graphics.setPixel(-1, -1, red, image) -- Should not crash
    Graphics.setPixel(1000, 1000, red, image) -- Should not crash
    print("Bounds checking: No crash (good)")
    
    Graphics.freeImage(image)
    print("Test completed successfully")
else
    print("Failed to load image")
end

System.exit()