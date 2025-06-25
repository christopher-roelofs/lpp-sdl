-- Simple test for Screen.getPixel functionality
print("Testing Screen.getPixel...")

-- Load the track image
track = Screen.loadBitmap("tests/games/3ds/pixelroad_1.0/levels/1.bmp")
print("Track loaded")

-- Test some pixel values
local pixel1 = Screen.getPixel(10, 10, track)
local pixel2 = Screen.getPixel(50, 50, track)
local pixel3 = Screen.getPixel(100, 100, track)

print("Pixel at (10,10): " .. pixel1)
print("Pixel at (50,50): " .. pixel2)  
print("Pixel at (100,100): " .. pixel3)

-- Check for green value (should be 65280 for pure green)
local green_value = 65280
print("Expected green value: " .. green_value)

if pixel1 == green_value then
    print("FOUND GREEN at (10,10)!")
elseif pixel2 == green_value then
    print("FOUND GREEN at (50,50)!")
elseif pixel3 == green_value then
    print("FOUND GREEN at (100,100)!")
else
    print("No green found at test positions")
end

print("Test completed")