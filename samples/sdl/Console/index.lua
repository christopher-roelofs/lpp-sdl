-- Console/Headless Mode Demo
-- Run with: ./lpp_sdl -headless samples/sdl/Console/index.lua
-- Or: ./lpp_sdl -console samples/sdl/Console/index.lua

print("=== LPP-SDL Console Mode Demo ===")
print("Running without GUI - perfect for server scripts and automation!")

-- Test 1: System Information
print("\n1. System Information:")
print("   Current Directory:", System.currentDirectory())
print("   Platform Info: Cross-platform Lua Player Plus SDL")

-- Test 2: File Operations
print("\n2. File System Operations:")
local demo_file = "console_demo_output.txt"
local demo_data = "Console mode output - " .. os.date("%Y-%m-%d %H:%M:%S")

-- Write file
local file_handle = System.openFile(demo_file, "w")
if file_handle then
    System.writeFile(file_handle, demo_data)
    System.closeFile(file_handle)
    print("   ✓ Created file:", demo_file)
else
    print("   ✗ Failed to create file")
end

-- Verify file exists
if System.doesFileExist(demo_file) then
    print("   ✓ File exists and is accessible")
    
    -- Read file back
    local read_handle = System.openFile(demo_file, "r")
    if read_handle then
        local size = System.sizeFile(read_handle)
        local content = System.readFile(read_handle, size)
        System.closeFile(read_handle)
        print("   ✓ File contents:", content)
    end
else
    print("   ✗ File verification failed")
end

-- Test 3: Directory Operations
print("\n3. Directory Listing:")
local current_dir = System.listDirectory(".")
if current_dir and #current_dir > 0 then
    print("   Found", #current_dir, "items in current directory:")
    
    -- Show first few items as examples
    local max_items = math.min(5, #current_dir)
    for i = 1, max_items do
        local item = current_dir[i]
        local type_str = item.directory and "[DIR]" or "[FILE]"
        local size_str = item.directory and "" or string.format(" (%d bytes)", item.size or 0)
        print(string.format("   %s %s%s", type_str, item.name, size_str))
    end
    
    if #current_dir > max_items then
        print("   ... and", #current_dir - max_items, "more items")
    end
else
    print("   ✗ Failed to list directory")
end

-- Test 4: Path Operations
print("\n4. Path Compatibility Test:")
local test_paths = {
    "app0:/test.txt",      -- Vita app path
    "ux0:/save.dat",       -- Vita user path  
    "/save.dat",           -- 3DS absolute path
    "/tmp/test.txt",       -- System path
    "./local_file.txt"     -- Relative path
}

for i, path in ipairs(test_paths) do
    local exists = System.doesFileExist(path)
    local status = exists and "EXISTS" or "not found"
    print(string.format("   %-20s -> %s", path, status))
end

-- Test 5: Timer Operations
print("\n5. Timer Functions:")
local timer = Timer.new()
local start_time = Timer.getTime(timer)
Timer.sleep(50) -- Sleep for 50ms
local end_time = Timer.getTime(timer)
local elapsed = (end_time - start_time) * 1000
print(string.format("   ✓ Timer precision test: %.1f ms elapsed", elapsed))

-- Test 6: Practical Example - Log File Creation
print("\n6. Practical Example - Creating Log File:")
local log_file = "console_session_log.txt"
local log_content = string.format([[
=== LPP-SDL Console Session Log ===
Timestamp: %s
Platform: Linux SDL2
Mode: Headless/Console
Working Directory: %s
Demo File Created: %s
Session Duration: %.1f ms

This demonstrates how LPP-SDL can be used for:
- Server-side scripting
- File processing automation  
- Data migration scripts
- Headless testing
- Command-line utilities

No GUI required - perfect for remote servers!
]], os.date("%Y-%m-%d %H:%M:%S"), 
    System.currentDirectory(),
    demo_file,
    elapsed)

local log_handle = System.openFile(log_file, "w")
if log_handle then
    System.writeFile(log_handle, log_content)
    System.closeFile(log_handle)
    print("   ✓ Session log saved to:", log_file)
else
    print("   ✗ Failed to create log file")
end

-- Cleanup
print("\n7. Cleanup:")
if System.doesFileExist(demo_file) then
    System.deleteFile(demo_file)
    print("   ✓ Removed demo file:", demo_file)
end

print("\n=== Console Mode Demo Complete ===")
print("Check", log_file, "for detailed session information.")
print("\nTip: This script runs completely without a GUI window!")
print("Perfect for automation, servers, and command-line workflows.")

-- Exit cleanly
System.exit()