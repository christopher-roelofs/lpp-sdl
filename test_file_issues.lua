-- Test specific file system issues discovered
print("=== Investigating File System Issues ===\n")

-- Issue 1: Root directory "/" shows as both not file and not directory, but "//" shows as directory
print("1. Root Directory Issue:")
print("/ exists as file:", System.doesFileExist("/"))
print("/ exists as dir:", System.doesDirExist("/"))
print("// exists as file:", System.doesFileExist("//"))  
print("// exists as dir:", System.doesDirExist("//"))

-- Let's check what the path translation is doing
print("\n2. Path Translation Debug:")
-- Create a test to see what translate_console_path does to "/"
local test_paths = {"/", "//", "/save.dat", "/home"}

-- Issue 2: Directory listing returning 0 items for "/" and non-existent dirs
print("\n3. Directory Listing Issues:")
print("Listing root /:")
local root_list = System.listDirectory("/")
if root_list then
    print("Root listing returned:", #root_list, "items")
    for i = 1, math.min(5, #root_list) do
        if root_list[i] then
            print("  Item:", root_list[i].name, "type:", root_list[i].type)
        end
    end
else
    print("Root listing returned nil")
end

print("\nListing non-existent /nonexistent:")  
local bad_list = System.listDirectory("/nonexistent")
if bad_list then
    print("Non-existent listing returned:", #bad_list, "items")
else
    print("Non-existent listing returned nil")
end

-- Issue 3: Check if directory listing metadata is working
print("\n4. Directory Metadata Test:")
local current_list = System.listDirectory(".")
if current_list and #current_list > 0 then
    print("Current directory items found:", #current_list)
    for i = 1, math.min(3, #current_list) do
        local item = current_list[i]
        print(string.format("Item %d:", i))
        print("  name:", item.name or "nil")
        print("  type:", item.type or "nil") 
        print("  size:", item.size or "nil")
        print("  mtime:", item.mtime or "nil")
    end
else
    print("No items found in current directory")
end

-- Issue 4: Test actual file creation and operations
print("\n5. File Creation Test:")
local test_file = "test_file_creation.txt"
local test_data = "Hello, World!"

-- Try to create and write a file
local file_handle = System.openFile(test_file, "w")
if file_handle then
    print("File opened successfully")
    local write_result = System.writeFile(file_handle, test_data)
    print("Write result:", write_result)
    local close_result = System.closeFile(file_handle)
    print("Close result:", close_result)
    
    -- Check if file now exists
    local exists = System.doesFileExist(test_file)
    print("File exists after creation:", exists)
    
    -- Read it back
    if exists then
        local read_handle = System.openFile(test_file, "r")
        if read_handle then
            local file_size = System.sizeFile(read_handle)
            print("File size:", file_size)
            local read_data = System.readFile(read_handle, file_size)
            print("Read data:", read_data)
            System.closeFile(read_handle)
        end
    end
    
    -- Clean up
    System.deleteFile(test_file)
    print("Cleanup complete")
else
    print("Failed to open file for writing")
end

print("\n=== Investigation Complete ===")
System.exit()