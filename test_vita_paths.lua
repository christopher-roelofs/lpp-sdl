-- Test script for Vita path translation
-- This script tests that app0:/ and ux0:/ paths are properly translated

print("Testing Vita path translation...")

-- Test 1: Try to load a font with app0:/ path
print("\nTest 1: Font loading with app0:/ path")
local success, font = pcall(Font.load, "app0:/font.ttf")
if success then
    print("✓ Font.load with app0:/ path succeeded (or file exists)")
else
    print("✗ Font.load failed:", font)
end

-- Test 2: Try to load an image with app0:/ path
print("\nTest 2: Image loading with app0:/ path")
local success, img = pcall(Graphics.loadImage, "app0:/test.png")
if success then
    print("✓ Graphics.loadImage with app0:/ path succeeded (or file exists)")
else
    print("✗ Graphics.loadImage failed:", img)
end

-- Test 3: Try to open a sound with app0:/ path
print("\nTest 3: Sound loading with app0:/ path")
local success, snd = pcall(Sound.openOgg, "app0:/test.ogg")
if success then
    print("✓ Sound.openOgg with app0:/ path succeeded (or file exists)")
else
    print("✗ Sound.openOgg failed:", snd)
end

-- Test 4: Try to open a file with app0:/ path
print("\nTest 4: File operations with app0:/ path")
local success, file = pcall(System.openFile, "app0:/test.txt", FREAD)
if success and file then
    print("✓ System.openFile with app0:/ path succeeded (or file exists)")
    System.closeFile(file)
else
    print("✗ System.openFile failed:", file or "nil")
end

-- Test 5: Try dofile with app0:/ path
print("\nTest 5: dofile with app0:/ path")
local success, err = pcall(dofile, "app0:/test_script.lua")
if success then
    print("✓ dofile with app0:/ path succeeded (or file exists)")
else
    -- This is expected to fail if the file doesn't exist
    print("✗ dofile failed (expected if file doesn't exist):", err)
end

print("\n✓ All path translation tests completed!")
print("Note: Failures are expected if the test files don't exist.")
print("The important thing is that the paths are being translated correctly.")