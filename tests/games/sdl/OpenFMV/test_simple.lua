-- Simple test to verify core functionality
print("=== OpenFMV Test ===")

-- Test file loading
if System.doesFileExist("lang/en.str") then
    print("✓ Found language file")
    
    local file = System.openFile("lang/en.str", "r")
    if file then
        local size = System.sizeFile(file)
        local content = System.readFile(file, size)
        System.closeFile(file)
        
        local lines = {}
        for line in string.gmatch(content, "[^\r\n]+") do
            table.insert(lines, line)
        end
        
        print("✓ Loaded " .. #lines .. " strings")
        print("  First string: " .. (lines[1] or "none"))
        print("  String 5 (New Game): " .. (lines[5] or "none"))
    else
        print("✗ Could not open language file")
    end
else
    print("✗ Language file not found")
end

-- Test video file detection
if System.doesFileExist("videos/Converted/5e64b89e15c746245c2a6fea75b74f6c.mp4") then
    print("✓ Found test video file")
else
    print("✗ Test video file not found")
end

print("Test completed!")