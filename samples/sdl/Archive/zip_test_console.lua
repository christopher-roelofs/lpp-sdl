-- Pure Console Test for Zip Operations
-- Tests all zip functionality without any UI components
-- This helps isolate issues from UI-related problems

print("=== LPP-SDL Zip Operations Console Test ===")
print("Testing all zip functions without UI dependencies...")
print("")

-- Test results tracking
local testsPassed = 0
local testsFailed = 0
local testResults = {}

-- Helper function to run a test
function runTest(testName, testFunc)
    print("Running: " .. testName)
    local startTime = os.clock()
    
    local success, result = pcall(testFunc)
    
    local endTime = os.clock()
    local elapsed = math.floor((endTime - startTime) * 1000)
    
    if success and result then
        testsPassed = testsPassed + 1
        print("  ✓ PASS (" .. elapsed .. "ms): " .. result)
        testResults[testName] = "PASS: " .. result
    else
        testsFailed = testsFailed + 1
        local errorMsg = result or "Unknown error"
        print("  ✗ FAIL (" .. elapsed .. "ms): " .. errorMsg)
        testResults[testName] = "FAIL: " .. errorMsg
    end
    print("")
end

-- Helper function to check if file exists
function checkFile(path, description)
    local exists = System.doesFileExist(path)
    if exists then
        print("    ✓ " .. description .. " exists: " .. path)
        return true
    else
        print("    ✗ " .. description .. " missing: " .. path)
        return false
    end
end

-- Helper function to check if directory exists
function checkDir(path, description)
    local exists = System.doesDirExist(path)
    if exists then
        print("    ✓ " .. description .. " exists: " .. path)
        return true
    else
        print("    ✗ " .. description .. " missing: " .. path)
        return false
    end
end

-- Cleanup function
function cleanup()
    print("Cleaning up test files...")
    
    -- Delete test files
    local filesToDelete = {
        "test_data/file1.txt",
        "test_data/file2.txt",
        "test_data/subfolder/nested.txt",
        "test_data/readme.md",
        "extra_file.txt",
        "single_test.txt"
    }
    
    for _, file in ipairs(filesToDelete) do
        if System.doesFileExist(file) then
            System.deleteFile(file)
        end
    end
    
    -- Delete directories
    if System.doesDirExist("test_data/subfolder") then
        System.deleteDirectory("test_data/subfolder")
    end
    if System.doesDirExist("test_data") then
        System.deleteDirectory("test_data")
    end
    if System.doesDirExist("output") then
        -- Delete zip files first
        if System.doesFileExist("output/single_file.zip") then
            System.deleteFile("output/single_file.zip")
        end
        if System.doesFileExist("output/directory.zip") then
            System.deleteFile("output/directory.zip")
        end
        System.deleteDirectory("output")
    end
    if System.doesDirExist("extracted") then
        System.deleteDirectory("extracted")
    end
    
    print("Cleanup completed.")
    print("")
end

-- Test 1: Setup test environment
function test1_setup()
    print("  Creating test directory structure...")
    
    -- Create directories
    System.createDirectory("test_data")
    System.createDirectory("test_data/subfolder")
    System.createDirectory("output")
    System.createDirectory("extracted")
    
    -- Verify directories
    if not checkDir("test_data", "Main test directory") then
        error("Failed to create test_data directory")
    end
    if not checkDir("test_data/subfolder", "Subfolder") then
        error("Failed to create test_data/subfolder directory")
    end
    if not checkDir("output", "Output directory") then
        error("Failed to create output directory")
    end
    if not checkDir("extracted", "Extracted directory") then
        error("Failed to create extracted directory")
    end
    
    print("  Creating test files...")
    
    -- Create test files
    local files = {
        {
            path = "test_data/file1.txt",
            content = "This is test file 1\nContains multiple lines\nFor zip testing purposes\nLine 4\nLine 5"
        },
        {
            path = "test_data/file2.txt", 
            content = "Test file 2 content\nDifferent from file 1\nWith some unique content"
        },
        {
            path = "test_data/subfolder/nested.txt",
            content = "This file is in a subfolder\nTesting directory compression\nNested file content"
        },
        {
            path = "test_data/readme.md",
            content = "# Test Archive\nThis is a test markdown file\n## Features\n- File compression\n- Directory compression\n- Extraction\n- Adding to existing archives"
        }
    }
    
    for _, fileInfo in ipairs(files) do
        local file = System.openFile(fileInfo.path, FWRITE)
        if not file then
            error("Failed to create file: " .. fileInfo.path)
        end
        
        local writeSuccess = System.writeFile(file, fileInfo.content)
        System.closeFile(file)
        
        if not writeSuccess then
            error("Failed to write content to: " .. fileInfo.path)
        end
        
        if not checkFile(fileInfo.path, "Test file") then
            error("File verification failed: " .. fileInfo.path)
        end
    end
    
    return "Test environment setup completed successfully"
end

-- Test 2: Compress single file
function test2_compress_single()
    print("  Compressing single file...")
    
    local result = System.compressZip("test_data/file1.txt", "output/single_file.zip", 6)
    if not result then
        error("compressZip returned false")
    end
    
    if not checkFile("output/single_file.zip", "Compressed single file") then
        error("Compressed file was not created")
    end
    
    return "Single file compressed successfully"
end

-- Test 3: Compress directory
function test3_compress_directory()
    print("  Compressing directory...")
    
    local result = System.compressZip("test_data", "output/directory.zip", 9)
    if not result then
        error("compressZip returned false for directory")
    end
    
    if not checkFile("output/directory.zip", "Compressed directory") then
        error("Compressed directory was not created")
    end
    
    return "Directory compressed successfully"
end

-- Test 4: Extract zip archive
function test4_extract_zip()
    print("  Extracting zip archive...")
    
    local result = System.extractZip("output/directory.zip", "extracted/full/")
    if not result then
        error("extractZip returned false")
    end
    
    -- Verify extracted files
    local expectedFiles = {
        "extracted/full/test_data/file1.txt",
        "extracted/full/test_data/file2.txt",
        "extracted/full/test_data/readme.md",
        "extracted/full/test_data/subfolder/nested.txt"
    }
    
    for _, file in ipairs(expectedFiles) do
        if not checkFile(file, "Extracted file") then
            error("Expected extracted file missing: " .. file)
        end
    end
    
    return "Zip archive extracted successfully"
end

-- Test 5: Extract specific file
function test5_extract_specific()
    print("  Extracting specific file...")
    
    local result = System.extractFromZip("output/directory.zip", "test_data/subfolder/nested.txt", "extracted/specific_file.txt")
    if not result then
        error("extractFromZip returned false")
    end
    
    if not checkFile("extracted/specific_file.txt", "Specifically extracted file") then
        error("Specifically extracted file was not created")
    end
    
    -- Verify file content
    local file = System.openFile("extracted/specific_file.txt", FREAD)
    if file then
        local content = System.readFile(file)
        System.closeFile(file)
        
        if not string.find(content, "subfolder") then
            error("Extracted file content is incorrect")
        end
        print("    ✓ File content verified")
    else
        error("Could not open extracted file for verification")
    end
    
    return "Specific file extracted successfully"
end

-- Test 6: Add to existing zip (the problematic one)
function test6_add_to_zip()
    print("  Adding file to existing zip...")
    
    -- Create additional file to add
    print("  Creating additional file...")
    local file = System.openFile("extra_file.txt", FWRITE)
    if not file then
        error("Failed to create extra file")
    end
    
    local writeSuccess = System.writeFile(file, "This file was added to an existing zip archive\nAdditional content for testing\nLine 3 of extra file")
    System.closeFile(file)
    
    if not writeSuccess then
        error("Failed to write to extra file")
    end
    
    if not checkFile("extra_file.txt", "Extra file to add") then
        error("Extra file was not created properly")
    end
    
    -- Add to existing zip
    print("  Adding to zip archive...")
    local addResult = System.addToZip("extra_file.txt", "output/single_file.zip", "added_files", 5)
    if not addResult then
        error("addToZip returned false")
    end
    
    print("    ✓ addToZip completed successfully")
    
    -- Extract modified zip to verify
    print("  Extracting modified zip for verification...")
    local extractResult = System.extractZip("output/single_file.zip", "extracted/added_test/")
    if not extractResult then
        error("Failed to extract modified zip")
    end
    
    print("    ✓ Modified zip extracted")
    
    -- Verify original file is still there
    if not checkFile("extracted/added_test/file1.txt", "Original file in modified zip") then
        error("Original file missing from modified zip")
    end
    
    -- Verify added file exists
    if not checkFile("extracted/added_test/added_files/extra_file.txt", "Added file in zip") then
        error("Added file missing from zip")
    end
    
    -- Verify added file content
    local addedFile = System.openFile("extracted/added_test/added_files/extra_file.txt", FREAD)
    if addedFile then
        local content = System.readFile(addedFile)
        System.closeFile(addedFile)
        
        if not string.find(content, "added to an existing zip") then
            error("Added file content is incorrect")
        end
        print("    ✓ Added file content verified")
    else
        error("Could not open added file for verification")
    end
    
    return "File added to existing zip successfully"
end

-- Test 7: Async zip extraction
function test7_async_extract()
    print("  Testing async zip extraction...")
    
    local result = System.extractZipAsync("output/directory.zip", "extracted/async_full/")
    if not result then
        error("extractZipAsync returned false")
    end
    
    print("    ✓ Async extraction started")
    
    -- Wait for completion with timeout
    local maxWait = 50 -- 5 seconds max
    local waitCount = 0
    
    while waitCount < maxWait do
        local state = System.getAsyncState()
        
        if state == 1 then
            -- Completed successfully
            print("    ✓ Async extraction completed")
            break
        elseif state == -1 then
            error("Async extraction failed")
        end
        
        -- Still in progress
        System.wait(100)
        waitCount = waitCount + 1
    end
    
    if waitCount >= maxWait then
        error("Async extraction timed out")
    end
    
    -- Verify extracted files
    if not checkFile("extracted/async_full/test_data/file1.txt", "Async extracted file") then
        error("Async extraction verification failed")
    end
    
    return "Async zip extraction completed successfully"
end

-- Test 8: Async specific file extraction
function test8_async_specific()
    print("  Testing async specific file extraction...")
    
    local result = System.extractFromZipAsync("output/directory.zip", "test_data/readme.md", "extracted/async_specific.md")
    if not result then
        error("extractFromZipAsync returned false")
    end
    
    print("    ✓ Async file extraction started")
    
    -- Wait for completion with timeout
    local maxWait = 50 -- 5 seconds max
    local waitCount = 0
    
    while waitCount < maxWait do
        local state = System.getAsyncState()
        
        if state == 1 then
            -- Completed successfully
            print("    ✓ Async file extraction completed")
            break
        elseif state == -1 then
            error("Async file extraction failed")
        end
        
        -- Still in progress
        System.wait(100)
        waitCount = waitCount + 1
    end
    
    if waitCount >= maxWait then
        error("Async file extraction timed out")
    end
    
    -- Verify extracted file
    if not checkFile("extracted/async_specific.md", "Async extracted specific file") then
        error("Async specific file extraction verification failed")
    end
    
    return "Async specific file extraction completed successfully"
end

-- Main test execution
print("Starting console zip tests...\n")

-- Clean up any existing test files
cleanup()

-- Run all tests
runTest("1. Setup test environment", test1_setup)
runTest("2. Compress single file", test2_compress_single)
runTest("3. Compress directory", test3_compress_directory)
runTest("4. Extract zip archive", test4_extract_zip)
runTest("5. Extract specific file", test5_extract_specific)
runTest("6. Add to existing zip", test6_add_to_zip)
runTest("7. Async zip extraction", test7_async_extract)
runTest("8. Async specific file extraction", test8_async_specific)

-- Print final results
print("=== TEST RESULTS SUMMARY ===")
print("Tests passed: " .. testsPassed)
print("Tests failed: " .. testsFailed)
print("Total tests:  " .. (testsPassed + testsFailed))
print("")

if testsFailed == 0 then
    print("🎉 ALL TESTS PASSED! Zip functionality is working correctly.")
else
    print("❌ " .. testsFailed .. " test(s) failed. Please check the output above for details.")
    
    print("\nFailed tests:")
    for testName, result in pairs(testResults) do
        if string.find(result, "FAIL:") then
            print("  - " .. testName .. ": " .. result)
        end
    end
end

print("")

-- Clean up test files
cleanup()

print("Console zip test completed.")
print("Script will exit in 3 seconds...")

-- Brief pause before exit
System.wait(3000)