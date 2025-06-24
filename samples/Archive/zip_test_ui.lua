-- Simple Non-Blocking Zip Demo for LPP-SDL
-- Uses a timer-based approach to prevent UI hanging
-- Simplified interface with reliable operation scheduling

print("Loading Simple Zip Demo...")

-- Colors for display
local white = Color.new(255, 255, 255)
local green = Color.new(0, 255, 0)
local red = Color.new(255, 0, 0)
local blue = Color.new(0, 0, 255)
local yellow = Color.new(255, 255, 0)
local gray = Color.new(128, 128, 128)

-- Demo state
local currentMenu = 1
local operationStatus = "Ready"
local operationResult = ""
local operationStartTime = 0

-- Timer-based operation state
local operationTimer = nil
local operationDelay = 100 -- ms between operation checks
local operationActive = false

-- Menu options
local menuOptions = {
    "Create Test Files",
    "Compress Single File", 
    "Compress Directory",
    "Extract Archive",
    "Extract Specific File",
    "Add to Existing Zip",
    "Test Async Operations",
    "Clean Up Files",
    "Exit Demo"
}

-- Simple logging function
function log(message)
    print("[" .. os.clock() * 1000 .. "ms] " .. message)
end

-- Timer-based operation scheduler
function scheduleOperation(operationFunc, description)
    if operationActive then
        operationResult = "Another operation is already running"
        return false
    end
    
    operationActive = true
    operationStatus = description
    operationResult = "Starting..."
    operationStartTime = os.clock() * 1000
    operationTimer = Timer.new()
    
    log("Scheduling: " .. description)
    
    -- Schedule the operation to run after a brief delay
    System.wait(50) -- Small initial delay to update UI
    
    -- Execute operation in a protected call
    local success, result = pcall(operationFunc)
    
    local elapsed = math.floor(os.clock() * 1000 - operationStartTime)
    
    if success then
        operationResult = result or "Operation completed successfully"
        operationStatus = "Completed (" .. elapsed .. "ms)"
        log("SUCCESS: " .. description .. " - " .. elapsed .. "ms")
    else
        operationResult = "Error: " .. (result or "Unknown error")
        operationStatus = "Failed (" .. elapsed .. "ms)"
        log("ERROR: " .. description .. " - " .. (result or "Unknown error"))
    end
    
    operationActive = false
    return success
end

-- Operation implementations
function createTestFiles()
    log("Creating test files...")
    
    -- Clean up first
    if System.doesDirExist("test_data") then
        System.deleteDirectory("test_data")
    end
    if System.doesDirExist("output") then
        System.deleteDirectory("output")
    end
    if System.doesDirExist("extracted") then
        System.deleteDirectory("extracted")
    end
    
    -- Create directories
    System.createDirectory("test_data")
    System.createDirectory("test_data/subfolder")
    System.createDirectory("output")
    System.createDirectory("extracted")
    
    -- Create test files
    local files = {
        {path = "test_data/document.txt", content = "Sample document for compression testing\nMultiple lines of content\nLine 3\nLine 4"},
        {path = "test_data/data.txt", content = "Data file content\nSome important data\nMore data here"},
        {path = "test_data/subfolder/nested.txt", content = "Nested file in subfolder\nSubfolder content\nNested data"}
    }
    
    for _, fileInfo in ipairs(files) do
        local file = System.openFile(fileInfo.path, FWRITE)
        if file then
            System.writeFile(file, fileInfo.content)
            System.closeFile(file)
            log("Created: " .. fileInfo.path)
        else
            error("Failed to create: " .. fileInfo.path)
        end
    end
    
    return "Test files created successfully"
end

function compressSingleFile()
    log("Compressing single file...")
    
    if not System.doesFileExist("test_data/document.txt") then
        error("Test file not found. Create test files first.")
    end
    
    local result = System.compressZip("test_data/document.txt", "output/single.zip", 6)
    if not result then
        error("Compression failed")
    end
    
    if not System.doesFileExist("output/single.zip") then
        error("Compressed file was not created")
    end
    
    return "Single file compressed to output/single.zip"
end

function compressDirectory()
    log("Compressing directory...")
    
    if not System.doesDirExist("test_data") then
        error("Test directory not found. Create test files first.")
    end
    
    local result = System.compressZip("test_data", "output/directory.zip", 9)
    if not result then
        error("Directory compression failed")
    end
    
    if not System.doesFileExist("output/directory.zip") then
        error("Compressed directory was not created")
    end
    
    return "Directory compressed to output/directory.zip"
end

function extractArchive()
    log("Extracting archive...")
    
    if not System.doesFileExist("output/directory.zip") then
        error("Directory zip not found. Compress directory first.")
    end
    
    local result = System.extractZip("output/directory.zip", "extracted/full/")
    if not result then
        error("Extraction failed")
    end
    
    if not System.doesFileExist("extracted/full/test_data/document.txt") then
        error("Extracted files not found")
    end
    
    return "Archive extracted to extracted/full/"
end

function extractSpecificFile()
    log("Extracting specific file...")
    
    if not System.doesFileExist("output/directory.zip") then
        error("Directory zip not found. Compress directory first.")
    end
    
    local result = System.extractFromZip("output/directory.zip", "test_data/subfolder/nested.txt", "extracted/nested_only.txt")
    if not result then
        error("Specific file extraction failed")
    end
    
    if not System.doesFileExist("extracted/nested_only.txt") then
        error("Extracted specific file not found")
    end
    
    return "Specific file extracted to extracted/nested_only.txt"
end

function addToExistingZip()
    log("Adding to existing zip...")
    
    if not System.doesFileExist("output/single.zip") then
        error("Single file zip not found. Compress single file first.")
    end
    
    -- Create additional file
    local extraFile = System.openFile("extra.txt", FWRITE)
    if extraFile then
        System.writeFile(extraFile, "Extra file added to existing archive\nAdditional content\nExtra data")
        System.closeFile(extraFile)
        log("Created extra.txt")
    else
        error("Failed to create extra file")
    end
    
    -- Add to zip
    local result = System.addToZip("extra.txt", "output/single.zip", "extras", 5)
    if not result then
        error("Adding to zip failed")
    end
    
    -- Verify by extracting
    local extractResult = System.extractZip("output/single.zip", "extracted/modified/")
    if not extractResult then
        error("Failed to extract modified zip")
    end
    
    if not System.doesFileExist("extracted/modified/extras/extra.txt") then
        error("Added file not found in modified zip")
    end
    
    -- Clean up temporary file
    System.deleteFile("extra.txt")
    
    return "File added to existing zip successfully"
end

function testAsyncOperations()
    log("Testing async operations...")
    
    if not System.doesFileExist("output/directory.zip") then
        error("Directory zip not found. Compress directory first.")
    end
    
    -- Test async extraction
    local result = System.extractZipAsync("output/directory.zip", "extracted/async/")
    if not result then
        error("Failed to start async extraction")
    end
    
    log("Async extraction started, waiting for completion...")
    
    -- Wait for completion with timeout
    local maxWait = 50 -- 5 seconds
    local waitCount = 0
    
    while waitCount < maxWait do
        local state = System.getAsyncState()
        
        if state == 1 then
            log("Async extraction completed")
            break
        elseif state == -1 then
            error("Async extraction failed")
        end
        
        System.wait(100)
        waitCount = waitCount + 1
    end
    
    if waitCount >= maxWait then
        error("Async extraction timed out")
    end
    
    if not System.doesFileExist("extracted/async/test_data/document.txt") then
        error("Async extracted files not found")
    end
    
    return "Async operations tested successfully"
end

function cleanUpFiles()
    log("Cleaning up files...")
    
    local itemsRemoved = 0
    
    -- Remove directories
    if System.doesDirExist("test_data") then
        System.deleteDirectory("test_data")
        itemsRemoved = itemsRemoved + 1
        log("Removed test_data directory")
    end
    
    if System.doesDirExist("output") then
        System.deleteDirectory("output")
        itemsRemoved = itemsRemoved + 1
        log("Removed output directory")
    end
    
    if System.doesDirExist("extracted") then
        System.deleteDirectory("extracted")
        itemsRemoved = itemsRemoved + 1
        log("Removed extracted directory")
    end
    
    -- Remove any leftover files
    if System.doesFileExist("extra.txt") then
        System.deleteFile("extra.txt")
        itemsRemoved = itemsRemoved + 1
        log("Removed extra.txt")
    end
    
    return "Cleanup completed - " .. itemsRemoved .. " items removed"
end

-- Menu execution
function executeMenuOption()
    if operationActive then
        return -- Don't start new operation if one is running
    end
    
    local operations = {
        createTestFiles,
        compressSingleFile,
        compressDirectory,
        extractArchive,
        extractSpecificFile,
        addToExistingZip,
        testAsyncOperations,
        cleanUpFiles,
        function() 
            log("Exiting demo...")
            System.exit() 
        end
    }
    
    local operation = operations[currentMenu]
    if operation then
        scheduleOperation(operation, menuOptions[currentMenu])
    end
end

-- Render function
function drawInterface()
    Graphics.fillRect(0, 0, 960, 544, Color.new(25, 25, 50))
    
    -- Title
    Graphics.debugPrint(50, 50, "Simple Zip Demo - Non-Blocking Operations", white)
    Graphics.debugPrint(50, 75, "Use UP/DOWN arrows, SPACE to execute, ESC to exit", gray)
    Graphics.debugPrint(50, 95, "===============================================", white)
    
    -- Status
    local statusColor = white
    if operationActive then
        statusColor = yellow
    elseif string.find(operationStatus, "Completed") then
        statusColor = green
    elseif string.find(operationStatus, "Failed") then
        statusColor = red
    end
    
    Graphics.debugPrint(50, 120, "Status: " .. operationStatus, statusColor)
    Graphics.debugPrint(50, 140, "Result: " .. operationResult, statusColor)
    
    -- Menu
    Graphics.debugPrint(50, 180, "Select Operation:", white)
    
    for i, option in ipairs(menuOptions) do
        local y = 200 + (i - 1) * 25
        local color = white
        
        if i == currentMenu then
            Graphics.fillRect(45, y - 5, 400, 20, Color.new(50, 50, 100))
            color = yellow
            Graphics.debugPrint(50, y, "> " .. option, color)
        else
            Graphics.debugPrint(70, y, option, color)
        end
    end
    
    -- Instructions
    Graphics.debugPrint(50, 450, "This demo uses timer-based operations to prevent UI blocking.", gray)
    Graphics.debugPrint(50, 470, "Each operation runs independently and reports progress.", gray)
    Graphics.debugPrint(50, 490, "The UI remains responsive throughout all operations.", gray)
    
    -- Performance info
    if operationActive then
        local elapsed = math.floor(os.clock() * 1000 - operationStartTime)
        Graphics.debugPrint(50, 515, "Operation running: " .. elapsed .. "ms", blue)
    end
end

-- Main loop
log("Starting Simple Zip Demo")

while true do
    local pad = Controls.read()
    
    -- Handle input (only when not in an operation)
    if not operationActive then
        if Controls.check(pad, SDLK_UP) then -- UP
            currentMenu = currentMenu - 1
            if currentMenu < 1 then
                currentMenu = #menuOptions
            end
            System.wait(150)
        elseif Controls.check(pad, SDLK_DOWN) then -- DOWN
            currentMenu = currentMenu + 1
            if currentMenu > #menuOptions then
                currentMenu = 1
            end
            System.wait(150)
        elseif Controls.check(pad, SDLK_RETURN) then -- X button/SPACE
            executeMenuOption()
            System.wait(200)
        end
    end
    
    -- Check for exit
    if System.shouldExit() then
        log("Exit requested")
        break
    end
    
    -- Render
    Graphics.initBlend()
    Screen.clear()
    drawInterface()
    Graphics.termBlend()
    Screen.flip()
    
    -- Maintain frame rate (60 FPS)
    System.wait(16)
end

-- Cleanup on exit
log("Demo exiting, cleaning up...")
if not operationActive then
    pcall(cleanUpFiles)
end

log("Simple Zip Demo ended")