-- Test file operations in different compatibility modes
print("=== File System Compatibility Test ===")

-- Test 1: Basic file operations
print("\n1. Basic File Operations Test:")
local test_file = "compatibility_test.txt"
local test_data = "Hello from compatibility test!"

-- Create, write, read, delete
local file_handle = System.openFile(test_file, "w")
if file_handle then
    print("✓ File opened for writing")
    local write_result = System.writeFile(file_handle, test_data)
    print("✓ Write result:", write_result)
    local close_result = System.closeFile(file_handle)
    print("✓ Close result:", close_result, "(type:", type(close_result), ")")
    
    -- Read back
    local read_handle = System.openFile(test_file, "r")
    if read_handle then
        local size = System.sizeFile(read_handle)
        local data = System.readFile(read_handle, size)
        local close_result2 = System.closeFile(read_handle)
        print("✓ Read back:", data)
        print("✓ Close result 2:", close_result2, "(type:", type(close_result2), ")")
    end
    
    -- Cleanup
    System.deleteFile(test_file)
    print("✓ Cleanup complete")
else
    print("✗ Failed to open file")
end

-- Test 2: Console path translation
print("\n2. Console Path Translation Test:")
local console_paths = {
    "app0:/test.txt",      -- Vita app path
    "ux0:/save.dat",       -- Vita user path  
    "/save.dat",           -- 3DS absolute path
    "/config.ini",         -- 3DS absolute path
    "/home/user/file.txt", -- Full system path (should be preserved)
    "/",                   -- Root directory
}

for i, path in ipairs(console_paths) do
    local exists = System.doesFileExist(path)
    print(string.format("Path: '%-20s' | Exists: %s", path, tostring(exists)))
end

-- Test 3: Directory listing with metadata
print("\n3. Directory Listing Metadata Test:")
local current_list = System.listDirectory(".")
if current_list and #current_list > 0 then
    print("Found", #current_list, "items in current directory:")
    for i = 1, math.min(3, #current_list) do
        local item = current_list[i]
        print(string.format("  %d. %s", i, item.name))
        print(string.format("     Type: %s | Directory: %s | Size: %s", 
                           tostring(item.type), 
                           tostring(item.directory),
                           tostring(item.size)))
        
        -- Check if additional fields exist (SDL enhancements)
        if item.mtime then
            print(string.format("     Modified: %s", tostring(item.mtime)))
        end
    end
    
    -- Test field compatibility
    local first_item = current_list[1]
    print("\n  Field Compatibility Check:")
    print("    Has 'name':", first_item.name ~= nil)
    print("    Has 'size':", first_item.size ~= nil) 
    print("    Has 'directory':", first_item.directory ~= nil)
    print("    Has 'type' (SDL extra):", first_item.type ~= nil)
    print("    Has 'mtime' (SDL extra):", first_item.mtime ~= nil)
else
    print("No items found or error listing directory")
end

-- Test 4: Root directory access
print("\n4. Root Directory Access Test:")
print("Root / exists as file:", System.doesFileExist("/"))
print("Root / exists as dir:", System.doesDirExist("/"))

local root_list = System.listDirectory("/")
if root_list then
    print("Root directory contains", #root_list, "items")
    if #root_list > 0 then
        print("First few items:")
        for i = 1, math.min(3, #root_list) do
            local item = root_list[i]
            print(string.format("  - %s (%s)", item.name, item.type or "unknown"))
        end
    end
else
    print("Failed to list root directory")
end

-- Test 5: Error handling
print("\n5. Error Handling Test:")
print("Non-existent file:", System.doesFileExist("/this/does/not/exist.txt"))
print("Non-existent dir:", System.doesDirExist("/this/does/not/exist"))

local bad_list = System.listDirectory("/non/existent/directory")
print("Bad directory listing returns:", bad_list ~= nil and #bad_list or "nil", "items")

print("\n=== Compatibility Test Complete ===")
System.exit()