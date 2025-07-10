-- Late Shift - OpenFMV Implementation for lpp-sdl
-- Interactive FMV game engine
-- Based on the original PS Vita OpenFMV port

-- Game configuration
local GAME_TITLE = "Late Shift"
local GAME_VERSION = "1.0.0"

-- Colors
local white = Color.new(255, 255, 255)
local black = Color.new(0, 0, 0)
local gray = Color.new(128, 128, 128)
local blue = Color.new(100, 150, 255)
local red = Color.new(255, 100, 100)
local green = Color.new(100, 255, 100)

-- Game state
local gameState = {
    currentVideo = nil,
    currentTime = 0,
    gameVars = {
        has_pepper_spray = false,
        know_about_party = false,
        key_given = false,
        cctv_seg = false,
        with_lee = false,
        may_likes_matt = false,
        respect_earned = false,
        sabotage = false,
        intervened = false,
        sold_for = 0,
        gone_upstairs = false,
        security_alert = false,
        blank_book = false,
        gone_to_woe = false,
        has_cookie = false,
        report_to_police = false,
        matt_escape = false,
        may_kiss = false,
        knife_long = false,
        matt_alone_playing = false,
        may_stabbed = false,
        cross_exam = false,
        turned_away = false,
        left_may_crying = false,
        go_home = false,
        beat_up = false
    },
    showSubtitles = true,
    showDebug = false,
    sequences = {},
    currentSequence = nil,
    isPlaying = false,
    showMenu = true,
    menuSelection = 1,
    showSettings = false,
    settingsSelection = 1,
    choices = {},
    showingChoices = false,
    choiceSelection = 1,
    choiceStartTime = 0,
    choiceTimeLimit = 10000, -- 10 seconds default
    subtitleText = "",
    gameStrings = {},
    language = "en",
    subtitleCache = {},  -- Cache for loaded subtitle content
    availableLanguages = {"en", "fr", "de", "es", "it", "ru", "ja", "ko", "zh", "pt", "ar", "da", "he", "hu", "pl", "tr", "uk", "cs", "zhs", "zht"}
}

-- Load game strings from language file
local function loadGameStrings(lang)
    local filePath = "lang/" .. lang .. ".str"
    
    -- Check if file exists first
    if not System.doesFileExist(filePath) then
        print("Warning: Could not find language file: " .. filePath)
        return false
    end
    
    local file = System.openFile(filePath, "r")
    if not file then
        print("Warning: Could not open language file: " .. filePath)
        return false
    end
    
    gameState.gameStrings = {}
    local lineNum = 1
    
    -- Get file size and read entire content
    local size = System.sizeFile(file)
    local content = System.readFile(file, size)
    System.closeFile(file)
    
    -- Split by lines
    for line in string.gmatch(content, "[^\r\n]+") do
        -- Trim whitespace
        line = line:match("^%s*(.-)%s*$")
        if line and line ~= "" then
            gameState.gameStrings[lineNum] = line
            lineNum = lineNum + 1
        end
    end
    
    print("Loaded " .. (lineNum - 1) .. " game strings for language: " .. lang)
    return true
end

-- Get localized string by index
local function getString(index)
    return gameState.gameStrings[index] or ("String_" .. tostring(index))
end

-- Load subtitle content from ZIP file
local function loadSubtitleFromZip(videoHash, language)
    language = language or gameState.language
    local cacheKey = language .. "_" .. videoHash
    
    -- Check cache first
    if gameState.subtitleCache[cacheKey] then
        return gameState.subtitleCache[cacheKey]
    end
    
    local zipFile = "subtitles/" .. language .. ".zip"
    local srtFile = videoHash .. ".srt"
    
    -- Check if ZIP file exists
    if not System.doesFileExist(zipFile) then
        print("Warning: Subtitle ZIP file not found: " .. zipFile)
        return nil
    end
    
    -- Read SRT file directly from ZIP using new function
    local subtitleContent = System.readFromZip(zipFile, srtFile)
    
    if subtitleContent then
        print("Loaded subtitles for " .. videoHash .. " in " .. language .. " (direct from ZIP)")
    else
        print("Warning: No subtitles found for " .. videoHash .. " in " .. language)
    end
    
    -- Cache the result (even if nil)
    gameState.subtitleCache[cacheKey] = subtitleContent
    
    return subtitleContent
end

-- Function removed - subtitles are now loaded per video using C++ system

-- Load subtitles using the C++ video system
local function loadSubtitlesForVideo(videoHash, language)
    if not gameState.currentVideo then
        return false
    end
    
    -- Get subtitle content from ZIP
    local content = loadSubtitleFromZip(videoHash, language)
    if not content then
        return false
    end
    
    -- Use the new C++ function to parse and load subtitles
    local success = Video.openSubsFromString(content, "srt")
    if success then
        print("Successfully loaded subtitles for video " .. videoHash .. " in language " .. language)
        return true
    else
        print("Failed to load subtitles for video " .. videoHash .. " in language " .. language)
        return false
    end
end

-- Get current subtitle text for video time
local function getCurrentSubtitle(videoHash, currentTime)
    if not gameState.showSubtitles then
        return ""
    end
    
    -- Use the C++ video system to get current subtitle
    local subtitleText = Video.getSubs()
    if subtitleText and subtitleText ~= "" and subtitleText ~= " " then
        return subtitleText
    end
    
    return ""
end

-- Create a sequence
local function createSequence(hash, choices, nextSequence)
    return {
        hash = hash,
        choices = choices or {},
        nextSequence = nextSequence,
        hasChoices = choices and #choices > 0,
        choiceStartTime = nil,
        choiceEndTime = nil
    }
end

-- Add choice to current sequence
local function addChoice(text, action, jumpTo)
    table.insert(gameState.choices, {
        text = text,
        action = action,
        jumpTo = jumpTo
    })
end

-- Clear current choices
local function clearChoices()
    gameState.choices = {}
    gameState.showingChoices = false
    gameState.choiceSelection = 1
end

-- Show choices during video playback
local function showChoices(timeLimit)
    gameState.showingChoices = true
    gameState.choiceSelection = 1
    gameState.choiceStartTime = Video.getTime()
    gameState.choiceTimeLimit = timeLimit or 10000
end

-- Save game state
local function saveGameState(filename)
    filename = filename or "lateshift_save.lua"
    print("Saving game state to " .. filename)
    local file = System.openFile(filename, "w")
    if not file then
        print("Error: Could not save game state to " .. filename)
        return false
    end
    
    local saveContent = "-- Late Shift Save Game\n"
    saveContent = saveContent .. "return {\n"
    saveContent = saveContent .. "  currentVideo = " .. (gameState.currentVideo and '"' .. gameState.currentVideo .. '"' or "nil") .. ",\n"
    saveContent = saveContent .. "  gameVars = {\n"
    for key, value in pairs(gameState.gameVars) do
        if type(value) == "boolean" then
            saveContent = saveContent .. "    " .. key .. " = " .. tostring(value) .. ",\n"
        elseif type(value) == "number" then
            saveContent = saveContent .. "    " .. key .. " = " .. tostring(value) .. ",\n"
        end
    end
    saveContent = saveContent .. "  },\n"
    saveContent = saveContent .. "  language = \"" .. gameState.language .. "\",\n"
    saveContent = saveContent .. "  showSubtitles = " .. tostring(gameState.showSubtitles) .. ",\n"
    saveContent = saveContent .. "  showDebug = " .. tostring(gameState.showDebug) .. "\n"
    saveContent = saveContent .. "}\n"
    
    System.writeFile(file, saveContent)
    System.closeFile(file)
    print("Game saved to " .. filename)
    return true
end

-- Load and play a video file
local function playVideo(videoHash, looping)
    looping = looping or false
    local videoPath = "videos/Converted/" .. videoHash .. ".mp4"
    
    print("Playing video: " .. videoPath)
    
    -- Close current video if playing
    if gameState.currentVideo then
        Video.close()
        -- Small delay to ensure clean transition
        os.execute("sleep 0.1")
    end
    
    -- Clear any existing choices
    clearChoices()
    
    -- Open new video with audio
    Video.open(videoPath)
    print("Video opened, setting volume...")
    Video.setVolume(1.0) -- Set volume to maximum
    print("Video volume set to 1.0")
    
    -- Load subtitles for this video
    loadSubtitlesForVideo(videoHash, gameState.language)
    
    -- Wait a moment for video to initialize before continuing
    local retry_count = 0
    while not Video.isPlaying() and retry_count < 10 do
        os.execute("sleep 0.05")
        retry_count = retry_count + 1
    end
    
    print("Video is playing: " .. tostring(Video.isPlaying()))
    gameState.currentVideo = videoHash
    gameState.isPlaying = true
    gameState.currentSequence = gameState.sequences[videoHash]
    
    
    -- Set up choices for this sequence if they exist
    if gameState.currentSequence and gameState.currentSequence.choices and #gameState.currentSequence.choices > 0 then
        -- Copy choices from sequence to current choices
        for _, choice in ipairs(gameState.currentSequence.choices) do
            addChoice(choice.text, choice.action, choice.jumpTo)
        end
        
        -- Set automatic choice timing based on sequence definition
        gameState.choiceStartTime = gameState.currentSequence.choiceStartTime
        gameState.choiceEndTime = gameState.currentSequence.choiceEndTime
        gameState.choiceTimeLimit = gameState.currentSequence.choiceEndTime - gameState.currentSequence.choiceStartTime
        
        print("Sequence has " .. #gameState.choices .. " choices, will show at " .. gameState.choiceStartTime .. "ms")
    else
        gameState.choiceStartTime = nil
        print("Sequence has no choices")
    end
    
    return true
end

-- Execute choice action
local function executeChoice(choiceIndex)
    if choiceIndex > 0 and choiceIndex <= #gameState.choices then
        local choice = gameState.choices[choiceIndex]
        print("Choice selected: " .. choice.text)
        
        -- Execute choice action
        if choice.action then
            choice.action()
        end
        
        -- Auto-save after choice
        saveGameState()
        
        -- Jump to next sequence
        if choice.jumpTo then
            playVideo(choice.jumpTo)
        end
        
        clearChoices()
        return true
    end
    return false
end


-- Load game state
local function loadGameState(filename)
    filename = filename or "lateshift_save.lua"
    
    if not System.doesFileExist(filename) then
        print("No save file found: " .. filename)
        return false
    end
    
    -- Use pcall to safely load the save file
    local success, saveData = pcall(dofile, filename)
    if success and saveData then
        gameState.currentVideo = saveData.currentVideo
        if saveData.gameVars then
            for key, value in pairs(saveData.gameVars) do
                gameState.gameVars[key] = value
            end
        end
        if saveData.language then
            gameState.language = saveData.language
        end
        if saveData.showSubtitles ~= nil then
            gameState.showSubtitles = saveData.showSubtitles
        end
        if saveData.showDebug ~= nil then
            gameState.showDebug = saveData.showDebug
        end
        print("Game loaded from " .. filename)
        return true
    end
    
    print("Error loading save file: " .. tostring(saveData))
    return false
end

-- Initialize sequence definitions  
local function initSequences()
    -- seg101 - Opening sequence (proper first sequence from original game)
    gameState.sequences["913398e931405382ff0e1d99870880b3"] = {
        hash = "913398e931405382ff0e1d99870880b3",
        choices = {
            {
                text = getString(33), -- "Selfish" (first choice)
                action = function() 
                    print("Choice: Selfish")
                end,
                jumpTo = "e5eebecf80017a2abbb5313406d47ad6" -- seg102_b
            },
            {
                text = getString(32), -- "Selfless" (second choice)
                action = function() 
                    print("Choice: Selfless")
                end,
                jumpTo = "225188737a3efb1f5210c86fe4e3eb4c" -- seg102_a
            }
        },
        choiceStartTime = 74583,  -- 74.583 seconds
        choiceEndTime = 80250,    -- 80.25 seconds  
        choiceJumpTime = 76875    -- 76.875 seconds
    }
    
    -- seg102_a - After selfless choice
    gameState.sequences["225188737a3efb1f5210c86fe4e3eb4c"] = {
        hash = "225188737a3efb1f5210c86fe4e3eb4c",
        choices = {},
        nextSequence = "230a802844f0b3657637eb63cdd0c949" -- seg106
    }
    
    -- seg102_b - After selfish choice  
    gameState.sequences["e5eebecf80017a2abbb5313406d47ad6"] = {
        hash = "e5eebecf80017a2abbb5313406d47ad6", 
        choices = {},
        nextSequence = "230a802844f0b3657637eb63cdd0c949" -- seg106
    }
    
    -- seg106 - Next sequence with choices
    gameState.sequences["230a802844f0b3657637eb63cdd0c949"] = {
        hash = "230a802844f0b3657637eb63cdd0c949",
        choices = {
            {
                text = getString(33), -- "Board"
                action = function() 
                    print("Choice: Board")
                end,
                jumpTo = "2362542e5d266aa1f758bb836231ab76" -- seg107_a
            },
            {
                text = getString(34), -- "Help"  
                action = function()
                    print("Choice: Help")
                end,
                jumpTo = "25299de84083de12a3a8d2db7c4fc1de" -- seg107_b
            }
        },
        choiceStartTime = 18625,  -- 18.625 seconds
        choiceEndTime = 23125,    -- 23.125 seconds
        choiceJumpTime = 22375    -- 22.375 seconds
    }
    
    print("Sequences initialized with proper Late Shift sequence flow")
end

-- Initialize video system
local function initVideo()
    Video.init()
    print("Video system initialized")
    
    -- Try to set default volume
    print("Setting default video volume to 1.0")
end

-- Function moved to earlier in file to fix scope issue

-- Main menu options
local menuOptions = {
    {text = "New Game", action = "newgame"},
    {text = "Resume", action = "resume"},
    {text = "Settings", action = "settings"},
    {text = "Exit", action = "exit"}
}

-- Settings menu options
local settingsOptions = {
    {text = "Subtitle Language", type = "language", getValue = function() return string.upper(gameState.language) end},
    {text = "Subtitles", type = "toggle", property = "showSubtitles", getValue = function() return gameState.showSubtitles and "ON" or "OFF" end},
    {text = "Debug Info", type = "toggle", property = "showDebug", getValue = function() return gameState.showDebug and "ON" or "OFF" end},
    {text = "Audio Volume", type = "volume", getValue = function() return "100%" end}, -- Placeholder for future
    {text = "Back to Menu", type = "action", action = "back"}
}

-- Helper function to draw properly centered text with left offset
local function drawCenteredText(text, y, color, offsetX)
    local sw = Screen.getWidth()
    local textWidth, textHeight = Gui.getTextSize(text)
    local x = (sw - textWidth) / 2 + (offsetX or 0)
    Graphics.debugPrint(x, y, text, color)
    return textHeight
end

-- Draw the main menu with background video
local function drawMainMenu()
    local sw = Screen.getWidth()
    local sh = Screen.getHeight()
    
    -- Clear screen with black background first
    Screen.clear(black)
    Graphics.initBlend()
    
    -- Simple loop detection - restart before video ends to avoid artifacts
    if gameState.currentVideo == "menu_background" then
        local currentTime = Video.getTime()
        local isPlaying = Video.isPlaying()
        
        -- Initialize tracking variables if not set
        if not gameState.lastRestartTime then gameState.lastRestartTime = 0 end
        if not gameState.menuVideoDuration then gameState.menuVideoDuration = 20900 end -- About 20.9 seconds based on previous observation
        if not gameState.videoRestarting then gameState.videoRestarting = false end
        
        local needsRestart = false
        local reason = ""
        
        -- Restart 1 second before video ends to avoid artifacts
        local restartTime = gameState.menuVideoDuration - 1000 -- 1 second before end
        
        if currentTime >= restartTime and isPlaying and not gameState.videoRestarting then
            needsRestart = true
            reason = "approaching end of video"
        elseif not isPlaying and not gameState.videoRestarting then
            needsRestart = true
            reason = "video stopped playing"
        elseif currentTime <= 0 and gameState.lastVideoTime and gameState.lastVideoTime > 1000 and not gameState.videoRestarting then
            needsRestart = true 
            reason = "time jumped to zero"
        end
        
        -- Prevent rapid restarts
        local timeSinceLastRestart = os.clock() - gameState.lastRestartTime
        if needsRestart and timeSinceLastRestart > 0.5 then -- Wait at least 500ms between restarts
            print("Restarting menu video: " .. reason .. " (time: " .. currentTime .. "ms, target: " .. restartTime .. "ms)")
            
            -- Set restarting flag to prevent drawing corrupted frames
            gameState.videoRestarting = true
            
            -- Clean restart sequence
            Video.close()
            
            -- Small delay to ensure clean state
            local delay_start = os.clock()
            while os.clock() - delay_start < 0.2 do end -- Longer delay
            
            -- Reopen video
            Video.open("videos/Converted/5e64b89e15c746245c2a6fea75b74f6c.mp4")
            Video.setVolume(0.5)
            
            -- Wait for video to initialize properly
            local init_timeout = os.clock() + 2.0 -- Longer timeout
            while not Video.isPlaying() and os.clock() < init_timeout do
                local wait_start = os.clock()
                while os.clock() - wait_start < 0.05 do end
            end
            
            -- Additional delay to ensure first frame is valid
            local frame_delay = os.clock()
            while os.clock() - frame_delay < 0.1 do end
            
            -- Update tracking
            gameState.lastRestartTime = os.clock()
            gameState.videoRestarting = false -- Allow drawing again
        end
        
        -- Update time tracking for fallback detection
        gameState.lastVideoTime = currentTime
    end
    
    -- Draw background video if available and valid (skip if restarting)
    if not gameState.videoRestarting then
        local frame = Video.getOutput()
        if frame and frame ~= 0 and Video.isPlaying() then
            local gw = Graphics.getImageWidth(frame)
            local gh = Graphics.getImageHeight(frame)
            
            -- Only draw if we have valid dimensions
            if gw and gh and gw > 0 and gh > 0 then
                -- Scale video to fill entire screen as background
                local scale_x = sw / gw
                local scale_y = sh / gh
                local scale = math.min(scale_x, scale_y)
                
                -- Center the video on screen
                local scaled_width = gw * scale
                local scaled_height = gh * scale
                local x_offset = (sw - scaled_width) / 2
                local y_offset = (sh - scaled_height) / 2
                
                Graphics.drawScaleImage(x_offset, y_offset, frame, scale, scale)
            else
                -- Invalid dimensions, fill with black
                Graphics.fillRect(0, 0, sw, sh, black)
            end
        else
            -- No valid video frame, fill with black
            Graphics.fillRect(0, 0, sw, sh, black)
        end
    else
        -- Video is restarting, show black screen
        Graphics.fillRect(0, 0, sw, sh, black)
    end
    
    -- Draw menu elements centered on screen (overlaid on video)
    local startY = sh / 2 - 100  -- Center vertically like original game
    local spacing = 50
    
    for i, option in ipairs(menuOptions) do
        local y = startY + (i - 1) * spacing
        local color = white
        
        -- Highlight selected option
        if i == gameState.menuSelection then
            color = blue
        end
        
        -- Get localized text
        local text = option.text
        if option.action == "newgame" then
            text = getString(5) -- "New Game"
        elseif option.action == "resume" then
            text = getString(7) -- "Resume"
        elseif option.action == "settings" then
            text = getString(10) -- "Settings"
        elseif option.action == "exit" then
            text = getString(11) -- "Exit Game"
        end
        
        -- Draw center-aligned text shifted left to fill the gap
        drawCenteredText(text, y, color, -50)
    end
    
    -- Instructions at bottom
    Graphics.debugPrint(10, sh - 60, "Arrow Keys/D-Pad: Navigate | Enter/Space: Select | Backspace: Back", gray)
    
    -- Draw title and version in bottom right
    local title_width, title_height = Gui.getTextSize(GAME_TITLE)
    local version_text = "v" .. GAME_VERSION
    local version_width, version_height = Gui.getTextSize(version_text)
    
    Graphics.debugPrint(sw - title_width - 10, sh - 60, GAME_TITLE, white)
    Graphics.debugPrint(sw - version_width - 10, sh - 40, version_text, gray)
    
    Graphics.termBlend()
end

-- Draw the settings menu
local function drawSettingsMenu()
    local sw = Screen.getWidth()
    local sh = Screen.getHeight()
    
    -- Clear screen with black background first
    Screen.clear(black)
    Graphics.initBlend()
    
    -- Title
    local titleY = 50
    drawCenteredText("Settings", titleY, white)
    
    -- Separator line
    local lineY = titleY + 40
    Graphics.debugPrint(50, lineY, string.rep("-", (sw - 100) / 8), gray)
    
    -- Settings options
    local startY = lineY + 60
    local spacing = 80
    
    for i, option in ipairs(settingsOptions) do
        local y = startY + (i - 1) * spacing
        local color = white
        local valueColor = gray
        
        -- Highlight selected option
        if i == gameState.settingsSelection then
            color = blue
            valueColor = blue
        end
        
        -- Draw setting name
        Graphics.debugPrint(100, y, option.text, color)
        
        -- Draw current value
        if option.getValue then
            local value = option.getValue()
            Graphics.debugPrint(100, y + 25, value, valueColor)
        end
        
        -- Draw navigation hints for interactive options
        if i == gameState.settingsSelection then
            if option.type == "language" then
                Graphics.debugPrint(100, y + 45, "Left/Right: Change Language", gray)
            elseif option.type == "toggle" then
                if option.property == "showDebug" then
                    Graphics.debugPrint(100, y + 45, "Left/Right: Toggle Debug Display", gray)
                else
                    Graphics.debugPrint(100, y + 45, "Left/Right: Toggle On/Off", gray)
                end
            elseif option.type == "volume" then
                Graphics.debugPrint(100, y + 45, "Left/Right: Adjust Volume", gray)
            end
        end
    end
    
    -- Instructions at bottom
    local instrY = sh - 100
    Graphics.debugPrint(50, instrY, "Controls:", white)
    Graphics.debugPrint(50, instrY + 20, "Up/Down: Navigate", gray)
    Graphics.debugPrint(50, instrY + 40, "Left/Right: Change Values", gray)
    Graphics.debugPrint(50, instrY + 60, "Enter/Space: Select | Backspace: Back", gray)
    
    Graphics.termBlend()
end

-- Handle menu input
local function handleMenuInput(pad, oldpad)
    -- Navigation (Arrow keys or D-pad)
    if (Controls.check(pad, SCE_CTRL_UP) and not Controls.check(oldpad, SCE_CTRL_UP)) or
       (Controls.check(pad, SDLK_UP) and not Controls.check(oldpad, SDLK_UP)) then
        gameState.menuSelection = gameState.menuSelection - 1
        if gameState.menuSelection < 1 then
            gameState.menuSelection = #menuOptions
        end
    elseif (Controls.check(pad, SCE_CTRL_DOWN) and not Controls.check(oldpad, SCE_CTRL_DOWN)) or
           (Controls.check(pad, SDLK_DOWN) and not Controls.check(oldpad, SDLK_DOWN)) then
        gameState.menuSelection = gameState.menuSelection + 1
        if gameState.menuSelection > #menuOptions then
            gameState.menuSelection = 1
        end
    end
    
    -- Selection (Enter/Return or X button)
    if (Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS)) or
       (Controls.check(pad, SDLK_RETURN) and not Controls.check(oldpad, SDLK_RETURN)) or
       (Controls.check(pad, SDLK_SPACE) and not Controls.check(oldpad, SDLK_SPACE)) then
        local selectedOption = menuOptions[gameState.menuSelection]
        
        if selectedOption.action == "newgame" then
            print("Starting new game...")
            gameState.showMenu = false
            -- Start with seg101 - the proper first sequence from Late Shift
            playVideo("913398e931405382ff0e1d99870880b3") -- seg101
            
        elseif selectedOption.action == "resume" then
            if loadGameState() then
                gameState.showMenu = false
                if gameState.currentVideo then
                    playVideo(gameState.currentVideo)
                else
                    -- Start with the intro video if no save state
                    playVideo("5e64b89e15c746245c2a6fea75b74f6c")
                end
            else
                print("No save game found")
            end
            
        elseif selectedOption.action == "settings" then
            print("Opening settings menu...")
            gameState.showSettings = true
            gameState.settingsSelection = 1
            
        elseif selectedOption.action == "exit" then
            print("Exiting game...")
            return false
        end
    end
    
    return true
end

-- Handle settings menu input
local function handleSettingsInput(pad, oldpad)
    -- Navigation (Arrow keys or D-pad)
    if (Controls.check(pad, SCE_CTRL_UP) and not Controls.check(oldpad, SCE_CTRL_UP)) or
       (Controls.check(pad, SDLK_UP) and not Controls.check(oldpad, SDLK_UP)) then
        gameState.settingsSelection = gameState.settingsSelection - 1
        if gameState.settingsSelection < 1 then
            gameState.settingsSelection = #settingsOptions
        end
    elseif (Controls.check(pad, SCE_CTRL_DOWN) and not Controls.check(oldpad, SCE_CTRL_DOWN)) or
           (Controls.check(pad, SDLK_DOWN) and not Controls.check(oldpad, SDLK_DOWN)) then
        gameState.settingsSelection = gameState.settingsSelection + 1
        if gameState.settingsSelection > #settingsOptions then
            gameState.settingsSelection = 1
        end
    end
    
    local selectedOption = settingsOptions[gameState.settingsSelection]
    
    -- Handle left/right for value changes
    if (Controls.check(pad, SCE_CTRL_LEFT) and not Controls.check(oldpad, SCE_CTRL_LEFT)) or
       (Controls.check(pad, SDLK_LEFT) and not Controls.check(oldpad, SDLK_LEFT)) then
        
        if selectedOption.type == "language" then
            -- Previous language
            local currentIndex = 1
            for i, lang in ipairs(gameState.availableLanguages) do
                if lang == gameState.language then
                    currentIndex = i
                    break
                end
            end
            
            currentIndex = currentIndex - 1
            if currentIndex < 1 then
                currentIndex = #gameState.availableLanguages
            end
            
            local newLanguage = gameState.availableLanguages[currentIndex]
            gameState.language = newLanguage
            gameState.subtitleCache = {} -- Clear cache for old language
            loadGameStrings(newLanguage)
            
            -- Reload subtitles for current video if playing
            if gameState.currentVideo then
                loadSubtitlesForVideo(gameState.currentVideo, newLanguage)
            end
            
            saveGameState() -- Auto-save settings
            print("Language changed to: " .. newLanguage)
            
        elseif selectedOption.type == "toggle" then
            if selectedOption.property == "showSubtitles" then
                gameState.showSubtitles = not gameState.showSubtitles
                print("Subtitles: " .. (gameState.showSubtitles and "ON" or "OFF"))
            elseif selectedOption.property == "showDebug" then
                gameState.showDebug = not gameState.showDebug
                print("Debug Info: " .. (gameState.showDebug and "ON" or "OFF"))
            end
            saveGameState() -- Auto-save settings
        end
        
    elseif (Controls.check(pad, SCE_CTRL_RIGHT) and not Controls.check(oldpad, SCE_CTRL_RIGHT)) or
           (Controls.check(pad, SDLK_RIGHT) and not Controls.check(oldpad, SDLK_RIGHT)) then
        
        if selectedOption.type == "language" then
            -- Next language
            local currentIndex = 1
            for i, lang in ipairs(gameState.availableLanguages) do
                if lang == gameState.language then
                    currentIndex = i
                    break
                end
            end
            
            currentIndex = currentIndex + 1
            if currentIndex > #gameState.availableLanguages then
                currentIndex = 1
            end
            
            local newLanguage = gameState.availableLanguages[currentIndex]
            gameState.language = newLanguage
            gameState.subtitleCache = {} -- Clear cache for old language
            loadGameStrings(newLanguage)
            
            -- Reload subtitles for current video if playing
            if gameState.currentVideo then
                loadSubtitlesForVideo(gameState.currentVideo, newLanguage)
            end
            
            saveGameState() -- Auto-save settings
            print("Language changed to: " .. newLanguage)
            
        elseif selectedOption.type == "toggle" then
            if selectedOption.property == "showSubtitles" then
                gameState.showSubtitles = not gameState.showSubtitles
                print("Subtitles: " .. (gameState.showSubtitles and "ON" or "OFF"))
            elseif selectedOption.property == "showDebug" then
                gameState.showDebug = not gameState.showDebug
                print("Debug Info: " .. (gameState.showDebug and "ON" or "OFF"))
            end
            saveGameState() -- Auto-save settings
        end
    end
    
    -- Selection (Enter/Return, Space, or X button)
    if (Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS)) or
       (Controls.check(pad, SDLK_RETURN) and not Controls.check(oldpad, SDLK_RETURN)) or
       (Controls.check(pad, SDLK_SPACE) and not Controls.check(oldpad, SDLK_SPACE)) then
        
        if selectedOption.action == "back" then
            gameState.showSettings = false
            -- Clean transition back to menu
            Video.close()
            os.execute("sleep 0.1")
            Video.open("videos/Converted/5e64b89e15c746245c2a6fea75b74f6c.mp4")
            Video.setVolume(0.5)
            gameState.currentVideo = "menu_background"
            print("Returning to main menu")
        end
    end
    
    -- Back (Backspace key or Triangle button)
    if (Controls.check(pad, SCE_CTRL_TRIANGLE) and not Controls.check(oldpad, SCE_CTRL_TRIANGLE)) or
       (Controls.check(pad, SDLK_BACKSPACE) and not Controls.check(oldpad, SDLK_BACKSPACE)) then
        gameState.showSettings = false
        -- Clean transition back to menu
        Video.close()
        os.execute("sleep 0.1")
        Video.open("videos/Converted/5e64b89e15c746245c2a6fea75b74f6c.mp4")
        Video.setVolume(0.5)
        gameState.currentVideo = "menu_background"
        print("Returning to main menu")
        return true
    end
    
    return true
end

-- Draw video frame with UI overlay
local function drawVideoFrame()
    local sw = Screen.getWidth()
    local sh = Screen.getHeight()
    
    Graphics.initBlend()
    Screen.clear()
    
    -- Get video frame (only draw if video is actually playing)
    local frame = Video.getOutput()
    if frame ~= 0 and Video.isPlaying() then
        local gw = Graphics.getImageWidth(frame)
        local gh = Graphics.getImageHeight(frame)
        
        -- Calculate scaling to fit video while maintaining aspect ratio
        local scale_x = sw / gw
        local scale_y = sh / gh
        local scale = math.min(scale_x, scale_y)
        
        -- Center the video
        local scaled_width = gw * scale
        local scaled_height = gh * scale
        local x_offset = (sw - scaled_width) / 2
        local y_offset = (sh - scaled_height) / 2
        
        Graphics.drawScaleImage(x_offset, y_offset, frame, scale, scale)
    end
    
    -- Check if we should show choices automatically based on video timestamp
    local currentTime = Video.getTime()
    if gameState.choiceStartTime and currentTime >= gameState.choiceStartTime and not gameState.showingChoices and #gameState.choices > 0 then
        -- Automatically show choices at the designated time
        gameState.showingChoices = true
        gameState.choiceSelection = 1
        gameState.choiceStartedAt = currentTime
        print("Automatically showing choices at " .. currentTime .. "ms")
    end
    
    -- Draw choices if they're active
    if gameState.showingChoices and #gameState.choices > 0 then
        -- Calculate time remaining based on choice end time
        local timeRemaining = gameState.choiceEndTime - currentTime
        local totalChoiceTime = gameState.choiceEndTime - gameState.choiceStartTime
        local timeProgress = math.max(0, timeRemaining / totalChoiceTime)
        
        -- Timer bar
        local bar_width = sw * 0.6
        local bar_height = 8
        local bar_x = (sw - bar_width) / 2
        local bar_y = 50
        
        -- Background
        Graphics.debugPrint(bar_x, bar_y, string.rep("-", bar_width / 8), gray)
        -- Foreground
        local filled_width = bar_width * timeProgress
        Graphics.debugPrint(bar_x, bar_y, string.rep("=", filled_width / 8), blue)
        
        -- Draw choices horizontally
        local choice_y = sh / 2
        local total_choices = #gameState.choices
        local choice_width = 300 -- Width allocated for each choice
        local total_width = total_choices * choice_width
        local choice_x_start = (sw - total_width) / 2 -- Center the choices horizontally
        
        -- Test: Draw a simple red rectangle to see if Graphics.fillRect works at all
        Graphics.fillRect(100, 300, 100, 150, red)  -- (x1, x2, y1, y2, color)
        
        for i, choice in ipairs(gameState.choices) do
            local x = choice_x_start + (i - 1) * choice_width
            
            -- Calculate text dimensions (approximate)
            local text_width = #choice.text * 12  -- Increased size for better visibility
            local text_height = 30
            local padding = 15
            
            -- Rectangle coordinates (x1, x2, y1, y2)
            local rect_x1 = x - padding
            local rect_x2 = x + text_width + padding
            local rect_y1 = choice_y - padding
            local rect_y2 = choice_y + text_height + padding
            
            -- Draw rectangles with correct parameter format
            local text_color = black
            
            if i == gameState.choiceSelection then
                -- Selected choice: blue background with white text
                Graphics.fillRect(rect_x1, rect_x2, rect_y1, rect_y2, blue)
                text_color = white
            else
                -- Non-selected choice: white background with black text
                Graphics.fillRect(rect_x1, rect_x2, rect_y1, rect_y2, white)
                text_color = black
            end
            
            -- Draw border using fillEmptyRect
            Graphics.fillEmptyRect(rect_x1, rect_x2, rect_y1, rect_y2, black)
            
            Graphics.debugPrint(x, choice_y, choice.text, text_color)
        end
        
        -- Auto-select if time runs out or we've passed the choice end time
        if timeRemaining <= 0 or currentTime >= gameState.choiceEndTime then
            print("Choice time expired, auto-selecting option " .. gameState.choiceSelection)
            executeChoice(gameState.choiceSelection)
        end
    end
    
    -- Draw subtitles (only if enabled and not showing choices)
    if gameState.showSubtitles and not gameState.showingChoices and gameState.currentVideo then
        local subtitle = getCurrentSubtitle(gameState.currentVideo, currentTime)
        -- Debug: Always print subtitle info to terminal
        if subtitle and subtitle ~= " " and subtitle ~= "" then
            print("SUBTITLE [" .. currentTime .. "ms]: " .. subtitle)
        end
        if subtitle and subtitle ~= " " and subtitle ~= "" then
            -- Enhanced subtitle rendering
            local lines = {}
            for s in string.gmatch(subtitle, "[^\n]+") do
                -- Trim whitespace
                s = s:match("^%s*(.-)%s*$")
                if s ~= "" then
                    table.insert(lines, s)
                end
            end
            
            local char_width = 8
            local line_height = 22
            local padding = 4
            local max_width = sw * 0.8 -- Use 80% of screen width max
            
            -- Position subtitles at bottom with good clearance
            local total_height = #lines * line_height
            local start_y = sh - 120 - total_height
            
            -- Draw semi-transparent background for better readability
            if #lines > 0 then
                local max_line_width = 0
                for _, line in ipairs(lines) do
                    local line_width = string.len(line) * char_width
                    if line_width > max_line_width then
                        max_line_width = line_width
                    end
                end
                
                -- Draw background box
                local box_x = (sw - max_line_width) / 2 - padding * 2
                local box_y = start_y - padding
                local box_width = max_line_width + padding * 4
                local box_height = total_height + padding * 2
                
                -- Draw semi-transparent black background
                for y = box_y, box_y + box_height do
                    Graphics.debugPrint(box_x, y, string.rep(" ", box_width / char_width), black)
                end
            end
            
            -- Draw subtitle text
            for i, line in ipairs(lines) do
                local text_width = string.len(line) * char_width
                local x_pos = (sw - text_width) / 2
                local y_pos = start_y + ((i - 1) * line_height)
                
                -- Draw text with shadow effect
                Graphics.debugPrint(x_pos + 2, y_pos + 2, line, black)
                Graphics.debugPrint(x_pos + 1, y_pos + 1, line, black)
                Graphics.debugPrint(x_pos, y_pos, line, white)
            end
        end
    end
    
    -- Check for video completion and auto-progression
    if not gameState.showingChoices and gameState.currentSequence then
        -- If video is not playing and we have a next sequence, auto-progress
        if not Video.isPlaying() and gameState.currentSequence.nextSequence then
            print("Video completed, auto-progressing to next sequence: " .. gameState.currentSequence.nextSequence)
            playVideo(gameState.currentSequence.nextSequence)
        end
    end
    
    -- Draw debug info in corner (only if debug enabled)
    if gameState.showDebug then
        local sw = Screen.getWidth()
        local sh = Screen.getHeight()
        Graphics.debugPrint(10, 10, "Time: " .. Video.getTime() .. " ms", white)
        Graphics.debugPrint(10, 30, "Video: " .. (gameState.currentVideo or "none"), white)
        Graphics.debugPrint(10, 50, "Resolution: " .. sw .. "x" .. sh, white)
        if gameState.showingChoices then
            Graphics.debugPrint(10, 70, "Choices: " .. #gameState.choices, white)
        end
    end
    
    -- Draw controls
    if gameState.showingChoices then
        Graphics.debugPrint(10, sh - 40, "Left/Right: Select | Enter/Space: Choose", gray)
    else
        Graphics.debugPrint(10, sh - 40, "Backspace: Menu | P/Space: Pause", gray)
    end
    
    -- Draw subtitle status and language (only if debug enabled)
    if gameState.showDebug then
        local sw = Screen.getWidth()
        if gameState.showSubtitles then
            Graphics.debugPrint(sw - 150, 10, "Subtitles: ON", white)
        else
            Graphics.debugPrint(sw - 150, 10, "Subtitles: OFF", white)
        end
        
        -- Draw current language
        Graphics.debugPrint(sw - 150, 30, "Language: " .. string.upper(gameState.language), white)
    end
    
    Graphics.termBlend()
end

-- Handle video playback input
local function handleVideoInput(pad, oldpad)
    -- Handle choices if they're showing
    if gameState.showingChoices then
        -- Navigation (Left/Right Arrow keys or D-pad)
        if (Controls.check(pad, SCE_CTRL_LEFT) and not Controls.check(oldpad, SCE_CTRL_LEFT)) or
           (Controls.check(pad, SDLK_LEFT) and not Controls.check(oldpad, SDLK_LEFT)) then
            gameState.choiceSelection = gameState.choiceSelection - 1
            if gameState.choiceSelection < 1 then
                gameState.choiceSelection = #gameState.choices
            end
        elseif (Controls.check(pad, SCE_CTRL_RIGHT) and not Controls.check(oldpad, SCE_CTRL_RIGHT)) or
               (Controls.check(pad, SDLK_RIGHT) and not Controls.check(oldpad, SDLK_RIGHT)) then
            gameState.choiceSelection = gameState.choiceSelection + 1
            if gameState.choiceSelection > #gameState.choices then
                gameState.choiceSelection = 1
            end
        end
        
        -- Selection (Enter/Return, Space, or X button)
        if (Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS)) or
           (Controls.check(pad, SDLK_RETURN) and not Controls.check(oldpad, SDLK_RETURN)) or
           (Controls.check(pad, SDLK_SPACE) and not Controls.check(oldpad, SDLK_SPACE)) then
            executeChoice(gameState.choiceSelection)
            return true
        end
    else
        -- Normal video controls when choices aren't showing
        -- Pause/Resume (P key or Square button)
        if (Controls.check(pad, SCE_CTRL_SQUARE) and not Controls.check(oldpad, SCE_CTRL_SQUARE)) or
           (Controls.check(pad, SDLK_P) and not Controls.check(oldpad, SDLK_P)) or
           (Controls.check(pad, SDLK_SPACE) and not Controls.check(oldpad, SDLK_SPACE)) then
            if Video.isPlaying() then
                Video.pause()
            else
                Video.resume()
            end
        end
        
        
        -- Video seeking controls have been removed
    end
    
    -- Menu (Backspace key or Triangle button)
    if (Controls.check(pad, SCE_CTRL_TRIANGLE) and not Controls.check(oldpad, SCE_CTRL_TRIANGLE)) or
       (Controls.check(pad, SDLK_BACKSPACE) and not Controls.check(oldpad, SDLK_BACKSPACE)) then
        Video.close()
        gameState.showMenu = true
        gameState.isPlaying = false
        clearChoices()
        -- Clean transition back to menu
        os.execute("sleep 0.1")
        Video.open("videos/Converted/5e64b89e15c746245c2a6fea75b74f6c.mp4")
        Video.setVolume(0.5)
        gameState.currentVideo = "menu_background"
        return true
    end
    
    return true
end

-- Main initialization
local function initGame()
    print("Initializing " .. GAME_TITLE .. "...")
    
    -- Load settings from save file if it exists
    if System.doesFileExist("lateshift_save.lua") then
        local success, savedData = pcall(dofile, "lateshift_save.lua")
        if success and savedData then
            print("Loading settings from save file...")
            -- Load language setting
            if savedData.language then
                gameState.language = savedData.language
                print("Loaded language: " .. gameState.language)
            end
            -- Load subtitle setting
            if savedData.showSubtitles ~= nil then
                gameState.showSubtitles = savedData.showSubtitles
                print("Loaded subtitles: " .. (gameState.showSubtitles and "ON" or "OFF"))
            end
            -- Load debug setting
            if savedData.showDebug ~= nil then
                gameState.showDebug = savedData.showDebug
                print("Loaded debug: " .. (gameState.showDebug and "ON" or "OFF"))
            end
        else
            print("Could not load settings from save file")
        end
    else
        print("No save file found, using default settings")
    end
    
    -- Load game strings
    if not loadGameStrings(gameState.language) then
        print("Using English as fallback")
        loadGameStrings("en")
    end
    
    -- Initialize video system
    initVideo()
    
    -- Initialize sequences
    initSequences()
    
    -- Subtitle system now uses C++ Video.openSubsFromString() for parsing
    print("Subtitle system initialized - using C++ parsing")
    
    -- Start menu background video
    print("Starting menu background video...")
    Video.open("videos/Converted/5e64b89e15c746245c2a6fea75b74f6c.mp4")
    Video.setVolume(0.5) -- Lower volume for menu background
    gameState.currentVideo = "menu_background"
    
    print("Game initialized successfully!")
    return true
end

-- Main game loop
local function gameLoop()
    local oldpad = 0
    local running = true
    
    while running do
        -- Get input
        local pad = Controls.read()
        
        -- Handle different game states
        if gameState.showSettings then
            drawSettingsMenu()
            running = handleSettingsInput(pad, oldpad)
        elseif gameState.showMenu then
            drawMainMenu()
            running = handleMenuInput(pad, oldpad)
        else
            drawVideoFrame()
            running = handleVideoInput(pad, oldpad)
        end
        
        -- Present frame
        Screen.waitVblankStart()
        Screen.flip()
        
        oldpad = pad
    end
    
    -- Cleanup
    Video.close()
    print("Game ended")
end

-- Entry point
local function main()
    print("=== " .. GAME_TITLE .. " ===")
    print("OpenFMV Implementation for lpp-sdl")
    print("Version: " .. GAME_VERSION)
    print()
    
    if initGame() then
        gameLoop()
    else
        print("Failed to initialize game!")
    end
end

-- Start the game
main()