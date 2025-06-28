-- Archive Support Demonstration for lpp-sdl
-- This sample demonstrates both ZIP (minizip) and extended archive support (libarchive)

print("=== LPP-SDL Archive Support Test ===")
print()

-- Test if libarchive support is available
local has_libarchive = System.unarchive ~= nil and System.detectArchiveFormat ~= nil

print("Archive Support Status:")
print("  ZIP support (minizip): YES")
print("  Extended archive support (libarchive): " .. (has_libarchive and "YES" or "NO"))

if not has_libarchive then
    print("  Note: To enable extended archive support, install libarchive-dev and rebuild:")
    print("    sudo apt install libarchive-dev")
    print("    make clean && make")
end

print()

-- Create some test files for archiving
local test_dir = "archive_test_data"
if not System.doesDirExist(test_dir) then
    System.createDirectory(test_dir)
end

-- Create test files
local test_files = {
    "test1.txt",
    "test2.txt", 
    "test3.txt"
}

for i, filename in ipairs(test_files) do
    local filepath = test_dir .. "/" .. filename
    local file = System.openFile(filepath, FCREATE)
    if file then
        System.writeFile(file, "This is test file " .. i .. "\n")
        System.writeFile(file, "Created for archive testing.\n")
        System.writeFile(file, "Line 3 of file " .. i .. ".\n")
        System.closeFile(file)
        print("Created: " .. filepath)
    end
end

print()

-- Test ZIP functionality (always available)
print("=== Testing ZIP Support (minizip) ===")

local zip_file = "test_archive.zip"
local zip_extract_dir = "zip_extracted"

-- Create ZIP archive
print("Creating ZIP archive...")
local success = System.compressZip(test_dir, zip_file, 6)
if success then
    print("✓ ZIP archive created: " .. zip_file)
    
    -- Get file size
    if System.doesFileExist(zip_file) then
        local stats = System.statFile(zip_file)
        if stats then
            print("  Archive size: " .. stats.size .. " bytes")
        end
    end
    
    -- Extract ZIP archive
    if System.doesDirExist(zip_extract_dir) then
        System.deleteDirectory(zip_extract_dir)
    end
    System.createDirectory(zip_extract_dir)
    
    print("Extracting ZIP archive...")
    local extract_success = System.extractZip(zip_file, zip_extract_dir)
    if extract_success then
        print("✓ ZIP archive extracted to: " .. zip_extract_dir)
        
        -- List extracted files
        local extracted_files = System.listDirectory(zip_extract_dir)
        if extracted_files then
            print("  Extracted files:")
            for _, item in ipairs(extracted_files) do
                if item.name ~= "." and item.name ~= ".." then
                    print("    " .. item.name .. " (" .. item.size .. " bytes)")
                end
            end
        end
    else
        print("✗ Failed to extract ZIP archive")
    end
else
    print("✗ Failed to create ZIP archive")
end

print()

-- Test extended archive functionality (if available)
if has_libarchive then
    print("=== Testing Extended Archive Support (libarchive) ===")
    
    -- Test archive detection
    if System.doesFileExist(zip_file) then
        print("Detecting archive format...")
        local format = System.detectArchiveFormat(zip_file)
        print("  Detected format: " .. (format or "unknown"))
    end
    
    -- Test unarchive function with ZIP
    local libarchive_extract_dir = "libarchive_extracted"
    if System.doesDirExist(libarchive_extract_dir) then
        System.deleteDirectory(libarchive_extract_dir)
    end
    System.createDirectory(libarchive_extract_dir)
    
    print("Testing libarchive unarchive with ZIP file...")
    local success, error_msg = System.unarchive(zip_file, libarchive_extract_dir)
    if success then
        print("✓ Archive extracted using libarchive")
        
        -- List extracted files
        local extracted_files = System.listDirectory(libarchive_extract_dir)
        if extracted_files then
            print("  Extracted files:")
            for _, item in ipairs(extracted_files) do
                if item.name ~= "." and item.name ~= ".." then
                    print("    " .. item.name .. " (" .. item.size .. " bytes)")
                end
            end
        end
    else
        print("✗ Failed to extract using libarchive: " .. (error_msg or "unknown error"))
    end
    
    -- Instructions for testing other formats
    print()
    print("To test other archive formats with libarchive:")
    print("  1. Create test archives (tar, 7z, etc.)")
    print("  2. Use System.detectArchiveFormat(path) to identify format")
    print("  3. Use System.unarchive(archive, destination) to extract")
    print()
    print("Supported formats include:")
    print("  - TAR (with gzip, bzip2, xz compression)")
    print("  - 7-Zip (7z)")
    print("  - RAR (read-only)")
    print("  - CAB, ISO, XAR, LHA, AR, CPIO")
    print("  - ZIP (alternative to minizip)")
    
else
    print("=== Extended Archive Support Not Available ===")
    print("To enable support for additional archive formats:")
    print("  1. Install libarchive development package:")
    print("     sudo apt install libarchive-dev")
    print("  2. Rebuild the project:")
    print("     make clean && make")
    print("  3. Re-run this test")
    print()
    print("With libarchive enabled, you'll have support for:")
    print("  - TAR (with various compressions)")
    print("  - 7-Zip (7z)")
    print("  - RAR (read-only)")
    print("  - CAB, ISO, XAR, LHA, AR, CPIO")
    print("  - And many more formats")
end

print()

-- Cleanup function
local function cleanup()
    print("=== Cleanup ===")
    
    -- Remove test files
    for _, filename in ipairs(test_files) do
        local filepath = test_dir .. "/" .. filename
        if System.doesFileExist(filepath) then
            System.deleteFile(filepath)
            print("Deleted: " .. filepath)
        end
    end
    
    -- Remove directories
    if System.doesDirExist(test_dir) then
        System.deleteDirectory(test_dir)
        print("Deleted directory: " .. test_dir)
    end
    
    if System.doesDirExist(zip_extract_dir) then
        System.deleteDirectory(zip_extract_dir)
        print("Deleted directory: " .. zip_extract_dir)
    end
    
    if has_libarchive and System.doesDirExist("libarchive_extracted") then
        System.deleteDirectory("libarchive_extracted")
        print("Deleted directory: libarchive_extracted")
    end
    
    -- Remove archive file
    if System.doesFileExist(zip_file) then
        System.deleteFile(zip_file)
        print("Deleted: " .. zip_file)
    end
    
    print("Cleanup completed.")
end

-- Ask user if they want to cleanup
print("Archive test completed!")
print("Leave test files for inspection? (y/N)")

-- Simple input (since we're in console mode)
local keep_files = false
-- For automation, we'll clean up automatically
-- In interactive mode, user could modify this

if not keep_files then
    cleanup()
else
    print("Test files preserved for inspection.")
end

print()
print("Archive test finished.")
System.exit()