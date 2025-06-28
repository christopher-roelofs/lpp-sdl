-- Test file system operations for edge cases
print("=== File System Operations Test ===\n")

-- Test 1: Current directory operations
print("1. Current Directory Test:")
local current_dir = System.currentDirectory()
print("Current directory:", current_dir)
print("Type:", type(current_dir))
print("Length:", #current_dir)

-- Test 2: Path edge cases
print("\n2. Path Edge Cases:")
local test_paths = {
    "",                    -- Empty path
    ".",                   -- Current directory
    "..",                  -- Parent directory  
    "/",                   -- Root directory
    "//",                  -- Double slash
    "test//file.txt",      -- Double slash in middle
    "test/./file.txt",     -- Current dir in path
    "test/../file.txt",    -- Parent dir in path
    "app0:/test.txt",      -- Vita path
    "ux0:/save.dat",       -- Vita user path
    "/save.dat",           -- Simple 3DS absolute
    "/very/long/path.txt", -- Complex 3DS path
    "très_long_nom_de_fichier_avec_caractères_spéciaux.txt", -- Special chars
    "file with spaces.txt", -- Spaces
    ".hidden",             -- Hidden file (Unix)
    "file.",               -- Trailing dot
    "file..txt",           -- Double dot
}

for i, path in ipairs(test_paths) do
    local exists = System.doesFileExist(path)
    local dir_exists = System.doesDirExist(path)
    print(string.format("Path: '%s' | File: %s | Dir: %s", path, tostring(exists), tostring(dir_exists)))
end

-- Test 3: File operations on non-existent paths
print("\n3. Non-existent File Operations:")
local test_file = "/tmp/nonexistent_file_12345.txt"
print("Testing operations on:", test_file)

-- Test file operations that should fail gracefully
local tests = {
    function() return System.doesFileExist(test_file) end,
    function() return System.statFile(test_file) end,
    function() return System.deleteFile(test_file) end,
}

for i, test_func in ipairs(tests) do
    local success, result = pcall(test_func)
    print(string.format("Test %d: Success=%s, Result=%s", i, tostring(success), tostring(result)))
end

-- Test 4: Directory listing edge cases
print("\n4. Directory Listing Test:")
local dir_tests = {
    ".",           -- Current directory
    "..",          -- Parent directory  
    "/",           -- Root (may fail on some systems)
    "/nonexistent", -- Non-existent directory
    "",            -- Empty path
}

for i, dir in ipairs(dir_tests) do
    print(string.format("Listing directory: '%s'", dir))
    local success, result = pcall(function() return System.listDirectory(dir) end)
    if success and result then
        print(string.format("  Found %d items", #result))
        -- Show first few items
        for j = 1, math.min(3, #result) do
            if result[j] then
                print(string.format("  - %s (type: %s)", result[j].name or "unknown", result[j].type or "unknown"))
            end
        end
        if #result > 3 then
            print(string.format("  ... and %d more", #result - 3))
        end
    else
        print("  Failed or returned nil")
    end
end

-- Test 5: Unicode and special character handling
print("\n5. Unicode/Special Character Test:")
local special_files = {
    "test_αβγ.txt",       -- Greek letters
    "test_中文.txt",        -- Chinese characters  
    "test_🎮.txt",         -- Emoji
    "test'quote.txt",      -- Single quote
    'test"double.txt',     -- Double quote
    "test&ampersand.txt",  -- Ampersand
    "test$dollar.txt",     -- Dollar sign
    "test%percent.txt",    -- Percent sign
}

for i, filename in ipairs(special_files) do
    local exists = System.doesFileExist(filename)
    print(string.format("Special file '%s': %s", filename, tostring(exists)))
end

-- Test 6: Very long path
print("\n6. Long Path Test:")
local long_path = "very/" .. string.rep("long/", 50) .. "path.txt"
print("Long path length:", #long_path)
local exists = System.doesFileExist(long_path)
print("Long path exists:", tostring(exists))

print("\n=== Test Complete ===")
System.exit()