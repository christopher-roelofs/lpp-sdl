-- System Module Console Test
-- Simple console-based test of System functionality

print("=== System Module Functionality Test ===")
print()

local test_count = 0
local passed_count = 0

-- Helper function to run tests
function runTest(name, testFunc)
    test_count = test_count + 1
    print("Testing " .. name .. "...")
    
    local success, result = pcall(testFunc)
    if success and result then
        print("  ✓ PASS: " .. name)
        passed_count = passed_count + 1
        return true
    else
        print("  ✗ FAIL: " .. name .. (result and (" - " .. tostring(result)) or ""))
        return false
    end
end

-- Test 1: File existence
runTest("File Existence", function()
    local exists = System.doesFileExist("index.lua")
    print("    index.lua exists: " .. tostring(exists))
    return exists
end)

-- Test 2: Directory existence  
runTest("Directory Existence", function()
    local exists = System.doesDirExist(".")
    print("    Current dir exists: " .. tostring(exists))
    return exists
end)

-- Test 3: Create directory
runTest("Create Directory", function()
    local success = System.createDirectory("test_dir")
    print("    Created test_dir: " .. tostring(success))
    return success
end)

-- Test 4: File operations
runTest("File I/O Operations", function()
    local test_content = "Hello System Test!"
    
    -- Write file
    local file = System.openFile("test.txt", FCREATE)
    if not file then return false end
    
    local write_ok = System.writeFile(file, test_content)
    System.closeFile(file)
    
    if not write_ok then return false end
    
    -- Read file
    file = System.openFile("test.txt", FREAD)
    if not file then return false end
    
    local content = System.readFile(file)
    local size = System.sizeFile(file)
    System.closeFile(file)
    
    print("    File size: " .. tostring(size))
    print("    Content matches: " .. tostring(content == test_content))
    
    return content == test_content and size > 0
end)

-- Test 5: Advanced file operations
runTest("File Statistics", function()
    local stat = System.statFile("test.txt")
    if stat then
        print("    File size: " .. tostring(stat.size))
        print("    Is directory: " .. tostring(stat.directory))
        print("    Modified time: " .. tostring(stat.mtime))
        return stat.size > 0
    end
    return false
end)

runTest("Copy File", function()
    local success = System.copyFile("test.txt", "test_copy.txt")
    if success then
        local exists = System.doesFileExist("test_copy.txt")
        print("    Copy exists: " .. tostring(exists))
        return exists
    end
    return false
end)

runTest("Rename File", function()
    local success = System.rename("test_copy.txt", "test_renamed.txt")
    if success then
        local new_exists = System.doesFileExist("test_renamed.txt")
        local old_exists = System.doesFileExist("test_copy.txt")
        print("    Rename successful: " .. tostring(new_exists and not old_exists))
        return new_exists and not old_exists
    end
    return false
end)

-- Test 6: Directory listing
runTest("List Directory", function()
    local files = System.listDirectory(".")
    if files and #files > 0 then
        print("    Found " .. #files .. " entries:")
        for i = 1, math.min(3, #files) do
            local entry = files[i]
            local type_str = entry.directory and "[DIR]" or "[FILE]"
            print("      " .. type_str .. " " .. entry.name)
        end
        return true
    end
    return false
end)

-- Test 7: Storage space
runTest("Storage Space", function()
    local free = System.getFreeSpace(".")
    local total = System.getTotalSpace(".")
    
    if free and total then
        local free_gb = free / (1024*1024*1024)
        local total_gb = total / (1024*1024*1024)
        print("    Free space: " .. string.format("%.2f GB", free_gb))
        print("    Total space: " .. string.format("%.2f GB", total_gb))
        return true
    end
    return false
end)

-- Test 8: Time
runTest("System Time", function()
    local hour, minute, second = System.getTime()
    if hour and minute and second then
        print("    Current time: " .. string.format("%02d:%02d:%02d", hour, minute, second))
        return hour >= 0 and hour <= 23 and minute >= 0 and minute <= 59
    end
    return false
end)

-- Test 9: Battery
runTest("Battery Information", function()
    local percentage = System.getBatteryPercentage()
    local charging = System.isBatteryCharging()
    local info = System.getBatteryInfo()
    
    print("    Battery: " .. tostring(percentage) .. "%")
    print("    Charging: " .. tostring(charging))
    if info then
        print("    State: " .. tostring(info.state))
    end
    
    return percentage ~= nil
end)

-- Test 10: File handle operations
runTest("File Handle Methods", function()
    local file = System.openFile("test.txt", FREAD)
    if not file then return false end
    
    local size = file:size()
    local stat = System.statOpenedFile(file)
    local seek_ok = file:seek(0, SET)
    
    System.closeFile(file)
    
    print("    Handle size: " .. tostring(size))
    print("    Handle stat: " .. tostring(stat ~= nil))
    print("    Seek operation: " .. tostring(seek_ok))
    
    return size and size > 0 and stat and seek_ok
end)

-- Cleanup
runTest("Cleanup", function()
    local cleanup_ok = true
    
    if System.doesFileExist("test.txt") then
        cleanup_ok = cleanup_ok and System.deleteFile("test.txt")
    end
    
    if System.doesFileExist("test_renamed.txt") then
        cleanup_ok = cleanup_ok and System.deleteFile("test_renamed.txt")
    end
    
    if System.doesDirExist("test_dir") then
        cleanup_ok = cleanup_ok and System.deleteDirectory("test_dir")
    end
    
    print("    Cleanup successful: " .. tostring(cleanup_ok))
    return cleanup_ok
end)

-- Summary
print()
print("=== Test Summary ===")
local success_rate = (passed_count / test_count) * 100
print(string.format("Tests passed: %d/%d (%.1f%%)", passed_count, test_count, success_rate))

if success_rate >= 80 then
    print("✓ System module is working well!")
elseif success_rate >= 60 then
    print("⚠ System module has some issues")
else
    print("✗ System module has significant problems")
end

print()
print("Test completed. Press Enter to exit...")

-- Simple exit - don't use System.exit() in case it's problematic