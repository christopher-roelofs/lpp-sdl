-- Lua Player Plus SDL - Game Launcher
-- A game launcher written in Lua using dofile to launch games

-- Initialize graphics
local screen_width = 960
local screen_height = 544

-- Load font
local font = Font.load("main.ttf", 18)

-- Launcher state
local launcher = {
    running = true,
    selected_index = 1,
    scroll_offset = 0,
    games = {},
    max_visible = 12,
    scanning = true
}

-- Scan for games in tests/games directory
local function scan_games()
    launcher.games = {}
    
    -- Scan Vita games
    if System.doesDirExist("../../../tests/games/vita") then
        local vita_dirs = System.listDirectory("../../../tests/games/vita")
        for i = 1, #vita_dirs do
            local entry = vita_dirs[i]
            if entry.directory and entry.name ~= "." and entry.name ~= ".." then
                local game_path = "../../../tests/games/vita/" .. entry.name .. "/index.lua"
                if System.doesFileExist(game_path) then
                    table.insert(launcher.games, {
                        name = entry.name .. " (Vita)",
                        path = game_path,
                        type = "vita"
                    })
                end
            end
        end
    end
    
    -- Scan 3DS games
    if System.doesDirExist("../../../tests/games/3ds") then
        local threeds_dirs = System.listDirectory("../../../tests/games/3ds")
        for i = 1, #threeds_dirs do
            local entry = threeds_dirs[i]
            if entry.directory and entry.name ~= "." and entry.name ~= ".." then
                local game_path = "../../../tests/games/3ds/" .. entry.name .. "/index.lua"
                if System.doesFileExist(game_path) then
                    table.insert(launcher.games, {
                        name = entry.name .. " (3DS)",
                        path = game_path,
                        type = "3ds"
                    })
                end
            end
        end
    end
    
    -- Add option to browse for other files
    table.insert(launcher.games, {
        name = "Browse for other Lua files...",
        path = "BROWSE",
        type = "browse"
    })
    
    launcher.scanning = false
    print("Found " .. (#launcher.games - 1) .. " games")
end

-- Draw text helper
local function draw_text(x, y, text, color)
    Font.print(font, x, y, text, color or Color.new(255, 255, 255))
end

-- Launch a game with error handling
local function launch_game(game)
    if game.type == "browse" then
        print("Browse functionality would open file browser here")
        System.wait(2000)
        return
    end
    
    print("Launching: " .. game.name)
    print("Path: " .. game.path)
    
    -- Clear screen before launching
    Graphics.initBlend()
    Screen.clear()
    Screen.flip()
    
    -- Launch the game with error handling
    local success, error_msg = pcall(dofile, game.path)
    
    if not success then
        print("Game crashed: " .. tostring(error_msg))
        -- Show error screen
        for i = 1, 180 do -- Show error for 3 seconds at 60fps
            Graphics.initBlend()
            Screen.clear()
            
            draw_text(50, 200, "Game Error:", Color.new(255, 100, 100))
            draw_text(50, 230, tostring(error_msg), Color.new(255, 200, 200))
            draw_text(50, 280, "Returning to launcher in " .. math.ceil((180-i)/60) .. " seconds...", Color.new(200, 200, 200))
            
            Screen.flip()
            if Controls.check(Controls.read(), SCE_CTRL_CROSS) then break end
        end
    else
        print("Game exited normally, returning to launcher")
    end
    
    -- Reinitialize any resources that might have been changed
    Graphics.initBlend()
end

-- Main launcher loop
local function run_launcher()
    -- Scan for games on startup
    scan_games()
    
    local pad = Controls.read()
    local oldpad = pad
    
    while launcher.running do
        pad = Controls.read()
        
        -- Handle input
        if Controls.check(pad, SCE_CTRL_UP) and not Controls.check(oldpad, SCE_CTRL_UP) then
            if launcher.selected_index > 1 then
                launcher.selected_index = launcher.selected_index - 1
                if launcher.selected_index < launcher.scroll_offset + 1 then
                    launcher.scroll_offset = launcher.selected_index - 1
                end
            end
        end
        
        if Controls.check(pad, SCE_CTRL_DOWN) and not Controls.check(oldpad, SCE_CTRL_DOWN) then
            if launcher.selected_index < #launcher.games then
                launcher.selected_index = launcher.selected_index + 1
                if launcher.selected_index > launcher.scroll_offset + launcher.max_visible then
                    launcher.scroll_offset = launcher.selected_index - launcher.max_visible
                end
            end
        end
        
        if Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS) then
            if launcher.selected_index <= #launcher.games then
                launch_game(launcher.games[launcher.selected_index])
            end
        end
        
        if Controls.check(pad, SCE_CTRL_CIRCLE) and not Controls.check(oldpad, SCE_CTRL_CIRCLE) then
            launcher.running = false
        end
        
        if Controls.check(pad, SCE_CTRL_TRIANGLE) and not Controls.check(oldpad, SCE_CTRL_TRIANGLE) then
            -- Rescan games
            launcher.scanning = true
            scan_games()
        end
        
        -- Render launcher
        Graphics.initBlend()
        Screen.clear()
        
        -- Header
        draw_text(50, 30, "Lua Player Plus SDL - Game Launcher", Color.new(100, 200, 255))
        draw_text(50, 60, "Found " .. (#launcher.games - 1) .. " games", Color.new(200, 200, 200))
        
        -- Instructions
        draw_text(50, screen_height - 120, "Controls:", Color.new(200, 200, 100))
        draw_text(50, screen_height - 95, "Up/Down: Navigate", Color.new(150, 150, 150))
        draw_text(50, screen_height - 75, "X: Launch Game", Color.new(150, 150, 150))
        draw_text(50, screen_height - 55, "O: Exit Launcher", Color.new(150, 150, 150))
        draw_text(50, screen_height - 35, "Triangle: Rescan Games", Color.new(150, 150, 150))
        
        -- Game list
        local start_y = 120
        local line_height = 25
        
        for i = 1, math.min(launcher.max_visible, #launcher.games) do
            local game_index = launcher.scroll_offset + i
            if game_index <= #launcher.games then
                local game = launcher.games[game_index]
                local y = start_y + (i - 1) * line_height
                
                -- Highlight selected item
                if game_index == launcher.selected_index then
                    Graphics.fillRect(40, y - 2, screen_width - 80, line_height, Color.new(50, 50, 100))
                    draw_text(60, y + 3, "> " .. game.name, Color.new(255, 255, 100))
                else
                    local color = Color.new(200, 200, 200)
                    if game.type == "vita" then
                        color = Color.new(100, 200, 255) -- Blue for Vita
                    elseif game.type == "3ds" then
                        color = Color.new(255, 100, 100) -- Red for 3DS
                    elseif game.type == "browse" then
                        color = Color.new(100, 255, 100) -- Green for browse
                    end
                    draw_text(60, y + 3, game.name, color)
                end
            end
        end
        
        -- Scroll indicator
        if #launcher.games > launcher.max_visible then
            local scroll_y = start_y + 50
            local scroll_height = launcher.max_visible * line_height - 100
            local thumb_height = math.max(20, scroll_height * launcher.max_visible / #launcher.games)
            local thumb_y = scroll_y + (scroll_height - thumb_height) * launcher.scroll_offset / math.max(1, #launcher.games - launcher.max_visible)
            
            Graphics.fillRect(screen_width - 20, scroll_y, 10, scroll_height, Color.new(50, 50, 50))
            Graphics.fillRect(screen_width - 18, thumb_y, 6, thumb_height, Color.new(150, 150, 150))
        end
        
        -- Scanning indicator
        if launcher.scanning then
            draw_text(screen_width - 200, 30, "Scanning...", Color.new(255, 255, 100))
        end
        
        Screen.flip()
        oldpad = pad
    end
end

-- Initialize and run
print("Starting Lua Game Launcher...")
run_launcher()
print("Launcher exiting...")