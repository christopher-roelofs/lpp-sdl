-- Extended Archive Format Testing for lpp-sdl
-- Tests various archive formats supported by libarchive

print("=== Extended Archive Format Test ===")
print()

-- Check if libarchive support is available
local has_libarchive = System.unarchive ~= nil and System.detectArchiveFormat ~= nil

if not has_libarchive then
    print("Error: libarchive support not available!")
    print("Install libarchive-dev and rebuild to enable extended archive support.")
    System.exit()
end

print("✓ Extended archive support (libarchive) is available")
print()

-- Test function to extract and verify archives
local function test_archive(archive_path, expected_format)
    print("Testing: " .. archive_path)
    
    if not System.doesFileExist(archive_path) then
        print("  ✗ Archive not found: " .. archive_path)
        return false
    end
    
    -- Detect format
    local format = System.detectArchiveFormat(archive_path)
    print("  Detected format: " .. (format or "unknown"))
    
    if expected_format and format then
        if string.find(format:lower(), expected_format:lower()) then
            print("  ✓ Format detection correct")
        else
            print("  ⚠ Expected '" .. expected_format .. "' but got '" .. format .. "'")
        end
    end
    
    -- Create extraction directory
    local extract_dir = "extracted_" .. archive_path:gsub("[^%w]", "_")
    if System.doesDirExist(extract_dir) then
        System.deleteDirectory(extract_dir)
    end
    System.createDirectory(extract_dir)
    
    -- Extract archive
    local success, error_msg = System.unarchive(archive_path, extract_dir)
    if success then
        print("  ✓ Successfully extracted to: " .. extract_dir)
        
        -- List extracted contents
        local contents = System.listDirectory(extract_dir)
        if contents then
            print("  Contents:")
            for _, item in ipairs(contents) do
                if item.name ~= "." and item.name ~= ".." then
                    print("    " .. item.name .. " (" .. item.size .. " bytes)")
                end
            end
        end
        
        -- Clean up
        System.deleteDirectory(extract_dir)
        print("  ✓ Cleanup completed")
        return true
    else
        print("  ✗ Extraction failed: " .. (error_msg or "unknown error"))
        if System.doesDirExist(extract_dir) then
            System.deleteDirectory(extract_dir)
        end
        return false
    end
end

-- Test archives if they exist
local test_archives = {
    {"test.tar.gz", "gzip"},
    {"test.tar.bz2", "bzip2"},
}

print("=== Testing Archive Formats ===")
print()

local tested = 0
local successful = 0

for _, test_case in ipairs(test_archives) do
    local archive_path, expected_format = test_case[1], test_case[2]
    tested = tested + 1
    
    if test_archive(archive_path, expected_format) then
        successful = successful + 1
    end
    
    print()
end

-- Create additional test archives if tar/gzip tools are available
print("=== Creating Additional Test Archives ===")

-- Create test content
local test_content = {
    "file1.txt",
    "file2.txt",
    "subdir/file3.txt"
}

-- Create test directory structure
local test_source = "test_source"
if System.doesDirExist(test_source) then
    -- Clean up existing directory
    System.deleteDirectory(test_source)
end
System.createDirectory(test_source)
System.createDirectory(test_source .. "/subdir")

-- Create test files
for i, filename in ipairs(test_content) do
    local filepath = test_source .. "/" .. filename
    local file = System.openFile(filepath, FCREATE)
    if file then
        System.writeFile(file, "Test file " .. i .. " content\n")
        System.writeFile(file, "This file is for archive format testing.\n")
        System.writeFile(file, "Created by lpp-sdl archive test.\n")
        System.closeFile(file)
        print("Created: " .. filepath)
    end
end

print()

-- Test creating ZIP with minizip and then reading with libarchive
print("=== Cross-Compatibility Test ===")
print("Testing minizip -> libarchive compatibility...")

local zip_file = "compatibility_test.zip"
local zip_success = System.compressZip(test_source, zip_file, 6)

if zip_success then
    print("✓ ZIP created with minizip")
    
    -- Test reading with libarchive
    tested = tested + 1
    if test_archive(zip_file, "zip") then
        successful = successful + 1
        print("✓ ZIP successfully read with libarchive")
    else
        print("✗ Failed to read ZIP with libarchive")
    end
    
    -- Clean up
    if System.doesFileExist(zip_file) then
        System.deleteFile(zip_file)
    end
else
    print("✗ Failed to create ZIP with minizip")
end

print()

-- Summary
print("=== Test Summary ===")
print("Archives tested: " .. tested)
print("Successful extractions: " .. successful)
print("Success rate: " .. math.floor((successful / tested) * 100) .. "%")

if successful == tested then
    print("✓ All archive format tests passed!")
else
    print("⚠ Some tests failed - check archive files and libarchive installation")
end

-- Cleanup
print()
print("=== Cleanup ===")
if System.doesDirExist(test_source) then
    -- Remove test files
    for _, filename in ipairs(test_content) do
        local filepath = test_source .. "/" .. filename
        if System.doesFileExist(filepath) then
            System.deleteFile(filepath)
        end
    end
    
    -- Remove directories
    System.deleteDirectory(test_source .. "/subdir")
    System.deleteDirectory(test_source)
    print("Deleted test directory: " .. test_source)
end

-- List supported formats
print()
print("=== Supported Archive Formats ===")
print("With libarchive, lpp-sdl supports:")
print("  Read Formats:")
print("    - ZIP (alternative to minizip)")
print("    - TAR (uncompressed)")
print("    - TAR.GZ (gzip compressed)")
print("    - TAR.BZ2 (bzip2 compressed)")
print("    - TAR.XZ (xz compressed)")
print("    - 7-Zip (.7z)")
print("    - RAR (read-only)")
print("    - CAB (Windows cabinet)")
print("    - ISO (CD/DVD images)")
print("    - XAR (extensible archive)")
print("    - LHA/LZH")
print("    - AR (Unix archive)")
print("    - CPIO")
print()
print("  Usage:")
print("    local format = System.detectArchiveFormat('archive.tar.gz')")
print("    local success, error = System.unarchive('archive.tar.gz', 'destination/')")
print()
print("  Note: ZIP files should still use System.extractZip() for best compatibility")
print("        with existing Vita/3DS games.")

print()
print("Extended archive format test completed.")
System.exit()