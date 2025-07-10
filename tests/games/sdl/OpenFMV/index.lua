-- OpenFMV - Interactive FMV Game Engine for lpp-sdl
-- Main launcher for FMV games

-- Colors
local white = Color.new(255, 255, 255)
local black = Color.new(0, 0, 0)
local gray = Color.new(128, 128, 128)
local blue = Color.new(100, 150, 255)
local green = Color.new(100, 255, 100)
local red = Color.new(255, 100, 100)

-- Available games
local games = {
    {
        title = "Late Shift",
        description = "Interactive thriller about a student night watchman",
        script = "lateshift.lua",
        available = true
    }
    -- Future games can be added here:
    -- {
    --     title = "Five Dates",
    --     description = "Interactive romantic comedy",
    --     script = "fivedates.lua",
    --     available = false
    -- }
}

-- Launcher state
local state = {
    selection = 1,
    showInfo = false
}

-- Draw the main launcher screen
local function drawLauncher()
    local sw = Screen.getWidth()
    local sh = Screen.getHeight()
    
    Graphics.initBlend()
    Screen.clear()
    
    -- Title
    local titleY = 50
    Graphics.debugPrint(sw/2 - 60, titleY, "OpenFMV", white)
    Graphics.debugPrint(sw/2 - 80, titleY + 25, "Interactive FMV Games", gray)
    
    -- Separator line
    local lineY = titleY + 60
    Graphics.debugPrint(50, lineY, string.rep("-", (sw - 100) / 8), gray)
    
    -- Game list
    local startY = lineY + 40
    local spacing = 60
    
    for i, game in ipairs(games) do
        local y = startY + (i - 1) * spacing
        local color = white
        local statusColor = gray
        
        -- Highlight selected game
        if i == state.selection then
            color = blue
        end
        
        -- Game title
        Graphics.debugPrint(100, y, game.title, color)
        
        -- Availability status
        local status = game.available and "Available" or "Coming Soon"
        statusColor = game.available and green or red
        Graphics.debugPrint(100, y + 20, status, statusColor)
        
        -- Description (only for selected game)
        if i == state.selection and game.description then
            Graphics.debugPrint(100, y + 40, game.description, gray)
        end
    end
    
    -- Instructions
    local instrY = sh - 100
    Graphics.debugPrint(50, instrY, "Controls:", white)
    Graphics.debugPrint(50, instrY + 20, "Arrow Keys/D-Pad: Select game", gray)
    Graphics.debugPrint(50, instrY + 40, "Enter/Space: Launch game", gray)
    Graphics.debugPrint(50, instrY + 60, "Backspace: Exit launcher", gray)
    
    -- System info
    Graphics.debugPrint(10, 10, "Screen: " .. sw .. "x" .. sh, gray)
    Graphics.debugPrint(10, 30, "lpp-sdl OpenFMV Engine", gray)
    
    Graphics.termBlend()
end

-- Handle launcher input
local function handleInput(pad, oldpad)
    -- Navigation (Arrow keys or D-pad)
    if (Controls.check(pad, SCE_CTRL_UP) and not Controls.check(oldpad, SCE_CTRL_UP)) or
       (Controls.check(pad, SDLK_UP) and not Controls.check(oldpad, SDLK_UP)) then
        state.selection = state.selection - 1
        if state.selection < 1 then
            state.selection = #games
        end
    elseif (Controls.check(pad, SCE_CTRL_DOWN) and not Controls.check(oldpad, SCE_CTRL_DOWN)) or
           (Controls.check(pad, SDLK_DOWN) and not Controls.check(oldpad, SDLK_DOWN)) then
        state.selection = state.selection + 1
        if state.selection > #games then
            state.selection = 1
        end
    end
    
    -- Launch game (Enter/Return, Space, or X button)
    if (Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS)) or
       (Controls.check(pad, SDLK_RETURN) and not Controls.check(oldpad, SDLK_RETURN)) or
       (Controls.check(pad, SDLK_SPACE) and not Controls.check(oldpad, SDLK_SPACE)) then
        local selectedGame = games[state.selection]
        if selectedGame.available then
            print("Launching: " .. selectedGame.title)
            print("Loading script: " .. selectedGame.script)
            
            -- Load and execute the game script
            local success, err = pcall(dofile, selectedGame.script)
            if not success then
                print("Error loading game: " .. tostring(err))
            end
            
            -- Return to launcher after game ends
            print("Returned to launcher")
        else
            print("Game not available yet: " .. selectedGame.title)
        end
    end
    
    -- Exit (Backspace key or Triangle button)
    if (Controls.check(pad, SCE_CTRL_TRIANGLE) and not Controls.check(oldpad, SCE_CTRL_TRIANGLE)) or
       (Controls.check(pad, SDLK_BACKSPACE) and not Controls.check(oldpad, SDLK_BACKSPACE)) then
        print("Exiting OpenFMV launcher")
        return false
    end
    
    return true
end

-- Main launcher loop
local function main()
    print("=== OpenFMV Launcher ===")
    print("Interactive FMV Game Engine for lpp-sdl")
    print()
    print("Available games:")
    for i, game in ipairs(games) do
        local status = game.available and "[AVAILABLE]" or "[COMING SOON]"
        print("  " .. i .. ". " .. game.title .. " " .. status)
    end
    print()
    
    local oldpad = 0
    local running = true
    
    while running do
        -- Get input
        local pad = Controls.read()
        
        -- Draw launcher
        drawLauncher()
        
        -- Handle input
        running = handleInput(pad, oldpad)
        
        -- Present frame
        Screen.waitVblankStart()
        Screen.flip()
        
        oldpad = pad
    end
    
    print("OpenFMV launcher closed")
end

-- Start the launcher
main()