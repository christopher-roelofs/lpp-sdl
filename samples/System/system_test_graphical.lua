-- System Module Test Sample
-- Tests all available System functionality in lpp-sdl

-- Initialize graphics for display
Graphics.initBlend()
Screen.clear()

local white = Color.new(255, 255, 255)
local green = Color.new(0, 255, 0)
local red = Color.new(255, 0, 0)
local yellow = Color.new(255, 255, 0)
local blue = Color.new(0, 0, 255)

local y_pos = 10
local line_height = 20
local test_results = {}
local test_count = 0
local passed_count = 0

-- Helper function to display test results
function displayResult(test_name, result, details)
    test_count = test_count + 1
    local color = result and green or red
    local status = result and "PASS" or "FAIL"
    
    Graphics.debugPrint(10, y_pos, "[" .. status .. "] " .. test_name, color)
    y_pos = y_pos + line_height
    
    if details and details ~= "" then
        Graphics.debugPrint(20, y_pos, details, white)
        y_pos = y_pos + line_height
    end
    
    if result then
        passed_count = passed_count + 1
    end
    
    table.insert(test_results, {name = test_name, result = result, details = details})
end

-- Helper function to safely test functions
function safeTest(name, testFunc)
    local success, result = pcall(testFunc)
    if not success then
        displayResult(name, false, "Error: " .. tostring(result))
        return false
    end
    return result
end

-- Test header
Graphics.debugPrint(10, y_pos, "=== System Module Functionality Test ===", yellow)
y_pos = y_pos + line_height * 2

-- 1. FILE EXISTENCE TESTS
Graphics.debugPrint(10, y_pos, "--- File Operations ---", blue)
y_pos = y_pos + line_height

safeTest("System.doesFileExist", function()
    local exists = System.doesFileExist("index.lua")
    displayResult("doesFileExist(index.lua)", exists, "Current file exists: " .. tostring(exists))
    return exists
end)

safeTest("System.doesDirExist", function()
    local exists = System.doesDirExist(".")
    displayResult("doesDirExist(.)", exists, "Current directory exists: " .. tostring(exists))
    return exists
end)

-- 2. DIRECTORY OPERATIONS
Graphics.debugPrint(10, y_pos, "--- Directory Operations ---", blue)
y_pos = y_pos + line_height

safeTest("System.createDirectory", function()
    local success = System.createDirectory("test_dir")
    displayResult("createDirectory(test_dir)", success, "Created test directory: " .. tostring(success))
    return success
end)

safeTest("System.listDirectory", function()
    local files = System.listDirectory(".")
    local count = files and #files or 0
    displayResult("listDirectory(.)", count > 0, "Found " .. count .. " files/dirs")
    
    -- Display first few entries
    if files and count > 0 then
        for i = 1, math.min(3, count) do
            local entry = files[i]
            if entry and entry.name then
                local type_str = entry.directory and "[DIR]" or "[FILE]"
                local size_str = entry.size and (" (" .. entry.size .. " bytes)") or ""
                Graphics.debugPrint(30, y_pos, type_str .. " " .. entry.name .. size_str, white)
                y_pos = y_pos + line_height
            end
        end
    end
    return count > 0
end)

-- 3. FILE OPERATIONS
Graphics.debugPrint(10, y_pos, "--- File I/O Operations ---", blue)
y_pos = y_pos + line_height

safeTest("File Write/Read Operations", function()
    local test_file = "test_file.txt"
    local test_content = "Hello, lpp-sdl System test!\nLine 2\nLine 3"
    
    -- Test file creation and writing
    local file = System.openFile(test_file, FCREATE)
    if not file then
        displayResult("openFile(create)", false, "Failed to create test file")
        return false
    end
    
    local write_success = System.writeFile(file, test_content)
    displayResult("writeFile", write_success, "Wrote " .. string.len(test_content) .. " bytes")
    
    System.closeFile(file)
    
    -- Test file reading
    file = System.openFile(test_file, FREAD)
    if not file then
        displayResult("openFile(read)", false, "Failed to open test file for reading")
        return false
    end
    
    local file_size = System.sizeFile(file)
    displayResult("sizeFile", file_size > 0, "File size: " .. tostring(file_size) .. " bytes")
    
    local read_content = System.readFile(file)
    local read_success = read_content == test_content
    displayResult("readFile", read_success, read_success and "Content matches" or "Content mismatch")
    
    System.closeFile(file)
    return write_success and read_success
end)

-- 4. NEW FILE OPERATIONS (Recently Added)
Graphics.debugPrint(10, y_pos, "--- Advanced File Operations ---", blue)
y_pos = y_pos + line_height

safeTest("System.statFile", function()
    local stat = System.statFile("test_file.txt")
    if stat then
        displayResult("statFile", true, "Size: " .. tostring(stat.size) .. ", Dir: " .. tostring(stat.directory))
        if stat.mtime then
            Graphics.debugPrint(30, y_pos, "Modified: " .. os.date("%Y-%m-%d %H:%M:%S", stat.mtime), white)
            y_pos = y_pos + line_height
        end
        return true
    else
        displayResult("statFile", false, "Failed to get file stats")
        return false
    end
end)

safeTest("System.copyFile", function()
    local success = System.copyFile("test_file.txt", "test_file_copy.txt")
    if success then
        local original_exists = System.doesFileExist("test_file.txt")
        local copy_exists = System.doesFileExist("test_file_copy.txt")
        displayResult("copyFile", copy_exists, "Copy created: " .. tostring(copy_exists))
        return copy_exists
    else
        displayResult("copyFile", false, "Failed to copy file")
        return false
    end
end)

safeTest("System.rename", function()
    local success = System.rename("test_file_copy.txt", "test_file_renamed.txt")
    if success then
        local old_exists = System.doesFileExist("test_file_copy.txt")
        local new_exists = System.doesFileExist("test_file_renamed.txt")
        displayResult("rename", new_exists and not old_exists, "File renamed successfully")
        return new_exists and not old_exists
    else
        displayResult("rename", false, "Failed to rename file")
        return false
    end
end)

-- 5. STORAGE SPACE OPERATIONS
safeTest("Storage Space Functions", function()
    local free_space = System.getFreeSpace(".")
    local total_space = System.getTotalSpace(".")
    
    local free_gb = free_space and (free_space / (1024*1024*1024)) or 0
    local total_gb = total_space and (total_space / (1024*1024*1024)) or 0
    
    displayResult("getFreeSpace", free_space ~= nil, 
        free_space and ("Free: " .. string.format("%.2f", free_gb) .. " GB") or "Failed")
    displayResult("getTotalSpace", total_space ~= nil,
        total_space and ("Total: " .. string.format("%.2f", total_gb) .. " GB") or "Failed")
    
    return free_space ~= nil and total_space ~= nil
end)

-- 6. SYSTEM INFORMATION
Graphics.debugPrint(10, y_pos, "--- System Information ---", blue)
y_pos = y_pos + line_height

safeTest("System.getTime", function()
    local hour, minute, second = System.getTime()
    local time_valid = hour and minute and second and 
                      hour >= 0 and hour <= 23 and
                      minute >= 0 and minute <= 59 and
                      second >= 0 and second <= 59
    displayResult("getTime", time_valid, 
        time_valid and string.format("Time: %02d:%02d:%02d", hour, minute, second) or "Invalid time")
    return time_valid
end)

-- 7. BATTERY INFORMATION
Graphics.debugPrint(10, y_pos, "--- Battery Information ---", blue)
y_pos = y_pos + line_height

safeTest("Battery Functions", function()
    local percentage = System.getBatteryPercentage()
    local charging = System.isBatteryCharging()
    local battery_info = System.getBatteryInfo()
    
    displayResult("getBatteryPercentage", percentage ~= nil, "Battery: " .. tostring(percentage) .. "%")
    displayResult("isBatteryCharging", charging ~= nil, "Charging: " .. tostring(charging))
    
    if battery_info then
        displayResult("getBatteryInfo", true, "State: " .. tostring(battery_info.state))
        if battery_info.secondsLeft then
            Graphics.debugPrint(30, y_pos, "Time left: " .. tostring(battery_info.secondsLeft) .. "s", white)
            y_pos = y_pos + line_height
        end
    else
        displayResult("getBatteryInfo", false, "Failed to get battery info")
    end
    
    return percentage ~= nil
end)

-- 8. FILE HANDLE OPERATIONS
Graphics.debugPrint(10, y_pos, "--- File Handle Operations ---", blue)
y_pos = y_pos + line_height

safeTest("File Handle Methods", function()
    local file = System.openFile("test_file.txt", FREAD)
    if not file then
        displayResult("File Handle Test", false, "Could not open test file")
        return false
    end
    
    -- Test file handle stat method
    local stat = System.statOpenedFile(file)
    local stat_success = stat ~= nil and stat.size ~= nil
    displayResult("statOpenedFile", stat_success, 
        stat_success and ("Handle size: " .. tostring(stat.size)) or "Failed to get handle stats")
    
    -- Test file handle methods
    local size = file:size()
    local size_success = size ~= nil and size > 0
    displayResult("filehandle:size()", size_success, "Handle size method: " .. tostring(size))
    
    -- Test seek operations
    local seek_success = file:seek(0, SET)
    displayResult("filehandle:seek()", seek_success, "Seek to start: " .. tostring(seek_success))
    
    System.closeFile(file)
    return stat_success and size_success and seek_success
end)

-- 9. CLEANUP AND POWER MANAGEMENT
Graphics.debugPrint(10, y_pos, "--- Power Management & Cleanup ---", blue)
y_pos = y_pos + line_height

safeTest("Power Management", function()
    local cpu_success = System.setCpuSpeed(444)
    local gpu_success = System.setGpuSpeed(222)
    local bus_success = System.setBusSpeed(222)
    
    displayResult("setCpuSpeed", cpu_success, "CPU speed setting: " .. tostring(cpu_success))
    displayResult("setGpuSpeed", gpu_success, "GPU speed setting: " .. tostring(gpu_success))
    displayResult("setBusSpeed", bus_success, "Bus speed setting: " .. tostring(bus_success))
    
    return cpu_success and gpu_success and bus_success
end)

-- Cleanup test files
safeTest("Cleanup", function()
    local cleanup_success = true
    
    if System.doesFileExist("test_file.txt") then
        cleanup_success = cleanup_success and System.deleteFile("test_file.txt")
    end
    
    if System.doesFileExist("test_file_renamed.txt") then
        cleanup_success = cleanup_success and System.deleteFile("test_file_renamed.txt")
    end
    
    if System.doesDirExist("test_dir") then
        cleanup_success = cleanup_success and System.deleteDirectory("test_dir")
    end
    
    displayResult("Cleanup", cleanup_success, "Removed test files and directories")
    return cleanup_success
end)

-- 10. FINAL SUMMARY
Graphics.debugPrint(10, y_pos, "--- Test Summary ---", blue)
y_pos = y_pos + line_height

local success_rate = (passed_count / test_count) * 100
local summary_color = success_rate >= 80 and green or (success_rate >= 60 and yellow or red)

Graphics.debugPrint(10, y_pos, string.format("Tests Passed: %d/%d (%.1f%%)", 
    passed_count, test_count, success_rate), summary_color)
y_pos = y_pos + line_height * 2

Graphics.debugPrint(10, y_pos, "Press any key to exit...", white)

-- Main loop
while true do
    Graphics.initBlend()
    
    -- Display all the test results (they're already drawn above)
    
    Graphics.termBlend()
    Screen.flip()
    Screen.waitVblankStart()
    
    -- Check for exit conditions
    if Controls.check(Controls.read(), SCE_CTRL_START) or 
       Controls.check(Controls.read(), SCE_CTRL_CROSS) or
       System.shouldExit() then
        break
    end
    
    System.wait(16) -- ~60 FPS
end

System.exit()