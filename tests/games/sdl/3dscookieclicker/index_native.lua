-- Cookie Clicker Native SDL Port
-- Single screen 3-panel layout with controller support
-- Left: Cookie + Stats | Center: Buildings | Right: Store

Graphics.init()

-- Target 640x480 resolution
local screenW, screenH = 640, 480

-- Try to set window size if the function exists (native SDL mode only)
-- This won't affect 3DS/Vita modes since they don't have this function
if Graphics.setMode then
    -- setMode might be the SDL function to set resolution
    Graphics.setMode(screenW, screenH)
elseif Window and Window.setSize then
    -- Or it might be under Window module
    Window.setSize(screenW, screenH)
elseif Screen and Screen.setMode then
    -- Or under Screen module
    Screen.setMode(screenW, screenH)
end

-- If none of the above work, check for actual screen size
if Screen and Screen.getWidth then
    local actualW = Screen.getWidth()
    local actualH = Screen.getHeight()
    if actualW and actualW > 0 then
        screenW = actualW
        screenH = actualH
        -- Recalculate panel widths based on actual resolution
        LEFT_PANEL_WIDTH = math.floor(screenW * 0.28)   -- ~28% of screen
        CENTER_PANEL_WIDTH = math.floor(screenW * 0.31) -- ~31% of screen
        RIGHT_PANEL_WIDTH = screenW - LEFT_PANEL_WIDTH - CENTER_PANEL_WIDTH
    end
end

-- Panel sizes - will be set based on resolution
local LEFT_PANEL_WIDTH, CENTER_PANEL_WIDTH, RIGHT_PANEL_WIDTH

-- Calculate scale factor for responsive design (640x480 as base resolution)
local BASE_WIDTH = 640
local BASE_HEIGHT = 480
local scaleX = screenW / BASE_WIDTH
local scaleY = screenH / BASE_HEIGHT
local scale = math.min(scaleX, scaleY) -- Use smaller scale to maintain aspect ratio

-- Apply reasonable scaling limits to prevent UI from becoming too small or too large
scaleX = math.max(0.5, math.min(4.0, scaleX))
scaleY = math.max(0.5, math.min(4.0, scaleY))
scale = math.max(0.5, math.min(4.0, scale))

-- Debug: Print scaling information for development
print(string.format("Cookie Clicker Scaling: %dx%d -> scaleX=%.2f, scaleY=%.2f, scale=%.2f", 
                   screenW, screenH, scaleX, scaleY, scale))

-- Set panel sizes with responsive scaling (2-panel layout)
-- Left panel: Buildings (~60% of screen) - more space for building display
-- Right panel: Cookie + Store (~40% of screen) - compact store design
local BASE_LEFT_WIDTH = 384  -- Buildings panel (60% of 640)
local BASE_RIGHT_WIDTH = 256  -- Cookie + Store panel (40% of 640)

-- Apply scaling with minimum sizes for very small screens
LEFT_PANEL_WIDTH = math.max(320, math.floor(BASE_LEFT_WIDTH * scaleX))
RIGHT_PANEL_WIDTH = screenW - LEFT_PANEL_WIDTH

-- Ensure right panel has minimum width for usability
if RIGHT_PANEL_WIDTH < 220 then
    LEFT_PANEL_WIDTH = screenW - 220
    RIGHT_PANEL_WIDTH = 220
end

-- Right panel subdivisions  
local COOKIE_AREA_HEIGHT = math.floor(screenH * 0.50)  -- Top 50% for cookie (more space for shine)
local STORE_AREA_HEIGHT = screenH - COOKIE_AREA_HEIGHT  -- Bottom 50% for store

-- Debug: Print panel layout information
print(string.format("Panel Layout: Left=%d, Right=%d (Total=%d), Cookie Area=%d, Store Area=%d", 
                   LEFT_PANEL_WIDTH, RIGHT_PANEL_WIDTH, LEFT_PANEL_WIDTH + RIGHT_PANEL_WIDTH,
                   COOKIE_AREA_HEIGHT, STORE_AREA_HEIGHT))

-- Colors
local white = Color.new(255,255,255)
local black = Color.new(0,0,0)
local gray = Color.new(128,128,128)
local yellow = Color.new(255,255,80)
local blue = Color.new(80,80,255)
local red = Color.new(255,80,80)
local green = Color.new(80,255,80)
local transwhite = Color.new(255,255,255,150)

-- Game state
local oldpad = 0
-- Cookie size with proportional scaling (base size 0.9 at 640x480)
local BASE_COOKIE_SIZE = 0.9
local cookieSize = math.max(0.6, math.min(1.5, BASE_COOKIE_SIZE * scale))
local Cookie = {count=0, total=0, size=cookieSize, clicking=false}
local Buildings = {}
local Store = {selectedIndex=1, scrollOffset=0, mode="BUY", listY=0, targetY=0}
local CpS = 0
local AvailableUpgrade = nil  -- Currently available upgrade building (like Abig in 3DS version)
local UpgradePrice = 0  -- Current upgrade cost (like NowPrice in 3DS version)
local timer = Timer.new()
local navTimer = Timer.new()
local buttonTimer = Timer.new()
local NAV_DELAY = 150  -- milliseconds between navigation inputs
local BUTTON_DELAY = 100  -- milliseconds between button presses
local cursorRotation = 0
local shineRotation = 0
local SHINE_SPEED = 0.008

-- Building definitions (from 3DS version)
local BuildingTypes = {
    {name="Cursor", price=15, basePrice=15, count=0, cps=0.1, icon=0, upgrade=1, unlockThreshold=0, actualName="Cursor", avupgrade=0},
    {name="LOCKED", price=100, basePrice=100, count=0, cps=1, icon=1, upgrade=1, unlockThreshold=100, actualName="Grandma", avupgrade=0},
    {name="LOCKED", price=1000, basePrice=1000, count=0, cps=8, icon=2, upgrade=1, unlockThreshold=1000, actualName="Farm", avupgrade=0},
    {name="LOCKED", price=12000, basePrice=12000, count=0, cps=47, icon=3, upgrade=1, unlockThreshold=12000, actualName="Mine", avupgrade=0},
    {name="LOCKED", price=130000, basePrice=130000, count=0, cps=260, icon=4, upgrade=1, unlockThreshold=130000, actualName="Factory", avupgrade=0},
    {name="LOCKED", price=1400000, basePrice=1400000, count=0, cps=1400, icon=5, upgrade=1, unlockThreshold=1400000, actualName="Bank", avupgrade=0},
    {name="LOCKED", price=20000000, basePrice=20000000, count=0, cps=7800, icon=6, upgrade=1, unlockThreshold=20000000, actualName="Temple", avupgrade=0},
    {name="LOCKED", price=330000000, basePrice=330000000, count=0, cps=44000, icon=7, upgrade=1, unlockThreshold=330000000, actualName="WizardTower", avupgrade=0}
}

-- Load images
if System.currentDirectory() == "/" then
    System.currentDirectory("romfs:/")
end

local Cookie_img = Graphics.loadImage(System.currentDirectory().."/data/cookie.png")
local Shine_img = Graphics.loadImage(System.currentDirectory().."/data/shine.png")
local Icons_img = Graphics.loadImage(System.currentDirectory().."/data/icons.png")
local BackgroundSprites_img = Graphics.loadImage(System.currentDirectory().."/data/BackgroundSprites.png")
local ButtonsSheet_img = Graphics.loadImage(System.currentDirectory().."/data/ButtonsSheet.png")
local Cursor_img = Graphics.loadImage(System.currentDirectory().."/data/cursor.png")
local ObjectsSheet_img = Graphics.loadImage(System.currentDirectory().."/data/ObjectsSheet.png")
local Frameus_img = Graphics.loadImage(System.currentDirectory().."/data/frameus.png")

-- Initialize sound system and load background music
Sound.init()
local bgm = Sound.openOgg(System.currentDirectory().."/data/bgm.ogg", false)
if bgm then
    Sound.play(bgm, LOOP)
end

-- Font system from 3DS version
local glyph_l = {}
local glyph_r = {}
local glyph_w = {}

function g_init(char, l, r)
    glyph_l[char] = l
    glyph_r[char] = r
    glyph_w[char] = r-l+1
end

-- Initialize font glyphs (from 3DS version)
g_init('0',414,430)
g_init('1',431,439)
g_init('2',440,454)
g_init('3',455,468)
g_init('4',469,483)
g_init('5',484,497)
g_init('6',498,512)
g_init('7',512,525)
g_init('8',526,540)
g_init('9',541,554)
g_init('A',1,19)
g_init('B',20,35)
g_init('C',36,52)
g_init('D',53,70)
g_init('E',71,84)
g_init('F',85,98)
g_init('G',99,116)
g_init('H',117,133)
g_init('I',134,139)
g_init('J',140,148)
g_init('K',149,164)
g_init('L',165,177)
g_init('M',178,196)
g_init('N',197,213)
g_init('O',214,232)
g_init('P',233,248)
g_init('Q',249,268)
g_init('R',269,284)
g_init('S',285,296)
g_init('T',297,310)
g_init('U',311,327)
g_init('V',328,344)
g_init('W',345,367)
g_init('X',368,383)
g_init('Y',384,399)
g_init('Z',400,413)
g_init('.',562,568)
g_init(' ',580,581)
g_init(':',555,561)
g_init('-',569,580)

local Font_img = Graphics.loadImage(System.currentDirectory().."/data/Font2.png")

function drawText(x, y, text, color)
    local text_u = string.upper(text)
    local str_width = 0
    local str_length = string.len(text)
    
    for i = 1, str_length do
        local chr = string.sub(text_u, i, i)
        local cw = glyph_w[chr]
        if cw ~= nil then
            Graphics.drawPartialImage(x + str_width, y, glyph_l[chr], 0, cw, 22, Font_img, color)
            str_width = str_width + cw - 1
        end
    end
end

function formatNumber(num)
    if num >= 1000000 then
        return (math.floor(num/1000000)).." M"
    elseif num >= 1000 then
        return (math.floor(num/1000)).." K"
    elseif num >= 1 then
        return math.floor(num * 10) / 10  -- Show 1 decimal place
    else
        return math.floor(num * 100) / 100  -- Show 2 decimal places for small numbers
    end
end

function updatePrices()
    for i, building in ipairs(BuildingTypes) do
        building.price = math.floor(building.basePrice * (1.15 ^ building.count))
    end
end

function updateCpS()
    CpS = 0
    for i, building in ipairs(BuildingTypes) do
        CpS = CpS + building.count * building.cps * building.upgrade
    end
end

function getUpgradeCost(buildingIndex, upgradeLevel)
    -- Upgrade costs from 3DS version
    local costs = {
        -- Cursor upgrade costs
        [1] = {100, 500, 10000, 100000, 10000000},
        -- Grandma upgrade costs  
        [2] = {1000, 5000, 50000, 5000000},
        -- Farm upgrade costs
        [3] = {11000, 55000, 550000, 55000000},
        -- Mine upgrade costs
        [4] = {120000, 600000, 6000000},
        -- Factory upgrade costs
        [5] = {1300000, 6500000, 65000000},
        -- Bank upgrade costs
        [6] = {14000000, 70000000},
        -- Temple upgrade costs
        [7] = {200000000}
    }
    
    if costs[buildingIndex] and costs[buildingIndex][upgradeLevel] then
        return costs[buildingIndex][upgradeLevel]
    end
    return 0  -- No upgrade available
end

function updateUpgrades()
    -- Check upgrade availability for each building type (like 3DS version)
    AvailableUpgrade = nil  -- Reset available upgrade
    UpgradePrice = 0
    
    for i, building in ipairs(BuildingTypes) do
        building.avupgrade = 0  -- Reset available upgrade
        
        -- Cursor upgrades
        if i == 1 then  -- Cursor
            if building.count > 0 and building.upgrade == 1 then building.avupgrade = 1
            elseif building.count > 0 and building.upgrade == 2 then building.avupgrade = 2
            elseif building.count > 9 and building.upgrade == 4 then building.avupgrade = 3
            elseif building.count > 19 and building.upgrade == 8 then building.avupgrade = 4
            elseif building.count > 39 and building.upgrade == 16 then building.avupgrade = 5
            end
        -- Grandma upgrades
        elseif i == 2 then  -- Grandma
            if building.count > 0 and building.upgrade == 1 then building.avupgrade = 1
            elseif building.count > 4 and building.upgrade == 2 then building.avupgrade = 2
            elseif building.count > 24 and building.upgrade == 4 then building.avupgrade = 3
            elseif building.count > 49 and building.upgrade == 8 then building.avupgrade = 4
            end
        -- Farm upgrades
        elseif i == 3 then  -- Farm
            if building.count > 0 and building.upgrade == 1 then building.avupgrade = 1
            elseif building.count > 4 and building.upgrade == 2 then building.avupgrade = 2
            elseif building.count > 24 and building.upgrade == 4 then building.avupgrade = 3
            elseif building.count > 49 and building.upgrade == 8 then building.avupgrade = 4
            end
        -- Mine upgrades
        elseif i == 4 then  -- Mine
            if building.count > 0 and building.upgrade == 1 then building.avupgrade = 1
            elseif building.count > 4 and building.upgrade == 2 then building.avupgrade = 2
            elseif building.count > 24 and building.upgrade == 4 then building.avupgrade = 3
            end
        -- Factory upgrades
        elseif i == 5 then  -- Factory
            if building.count > 0 and building.upgrade == 1 then building.avupgrade = 1
            elseif building.count > 4 and building.upgrade == 2 then building.avupgrade = 2
            elseif building.count > 24 and building.upgrade == 4 then building.avupgrade = 3
            end
        -- Bank upgrades
        elseif i == 6 then  -- Bank
            if building.count > 0 and building.upgrade == 1 then building.avupgrade = 1
            elseif building.count > 4 and building.upgrade == 2 then building.avupgrade = 2
            end
        -- Temple upgrades
        elseif i == 7 then  -- Temple
            if building.count > 0 and building.upgrade == 1 then building.avupgrade = 1
            end
        -- WizardTower has no upgrades in 3DS version
        end
        
        -- Set available upgrade if one is found (prioritize first available)
        if building.avupgrade > 0 and AvailableUpgrade == nil then
            AvailableUpgrade = building
            UpgradePrice = getUpgradeCost(i, building.avupgrade)
        end
    end
end

function updateBuildingNames()
    -- Unlock building names based on total cookies earned (like 3DS version)
    for i, building in ipairs(BuildingTypes) do
        if Cookie.total >= building.unlockThreshold then
            building.name = building.actualName
        end
    end
end

function saveGame()
    -- Use LPP-style file I/O (like 3DS version)
    local savefile = io.open("ccsave_native.sav", FCREATE)
    if savefile then
        -- Create save string with all game data (like 3DS version)
        local saveData = {}
        saveData[1] = tostring(Cookie.count)
        saveData[2] = tostring(Cookie.total)
        
        -- Save building counts and upgrades
        for i, building in ipairs(BuildingTypes) do
            table.insert(saveData, tostring(building.count))
            table.insert(saveData, tostring(building.upgrade))
        end
        
        local saveString = table.concat(saveData, "#")
        local saveStringLen = string.len(saveString)
        io.write(savefile, 0, saveString, saveStringLen)
        io.close(savefile)
        return true
    end
    return false
end

function loadGame()
    -- Check if save file exists first
    if not System.doesFileExist("ccsave_native.sav") then
        return false
    end
    
    -- Use LPP-style file I/O (like 3DS version)
    local savefile = io.open("ccsave_native.sav", FREAD)
    if savefile then
        local size = io.size(savefile)
        local saveString = io.read(savefile, 0, size)
        io.close(savefile)
        
        -- Split save string by # delimiter (like 3DS version)
        local saveData = {}
        for value in string.gmatch(saveString, "([^#]+)") do
            table.insert(saveData, value)
        end
        
        if #saveData >= 2 then
            -- Load cookie data
            Cookie.count = tonumber(saveData[1]) or 0
            Cookie.total = tonumber(saveData[2]) or 0
            
            -- Load building data
            local index = 3
            for i, building in ipairs(BuildingTypes) do
                if saveData[index] then
                    building.count = tonumber(saveData[index]) or 0
                    index = index + 1
                end
                if saveData[index] then
                    building.upgrade = tonumber(saveData[index]) or 1
                    index = index + 1
                end
            end
            
            -- Update prices and CpS after loading
            updatePrices()
            updateCpS()
            updateUpgrades()  -- Check for available upgrades after loading
            updateBuildingNames()  -- Update building names after loading
            return true
        end
    end
    return false
end

function drawCursors(cookieX, cookieY)
    local cursorBuilding = BuildingTypes[1]  -- Cursor is the first building
    if cursorBuilding.count > 0 then
        local pi = 3.14159
        -- Calculate radius to position cursors around the outside edge of the cookie
        local cookieScale = Cookie.size * 0.7  -- Same scale as the actual cookie drawing
        local cookieVisualRadius = 64 * cookieScale  -- Actual visual radius of the cookie
        local cursorDistance = math.floor(-2 * scale)  -- Small distance from cookie edge
        local radius = cookieVisualRadius + cursorDistance
        
        -- Draw up to 8 cursors around the cookie
        local cursorsToShow = math.min(cursorBuilding.count, 8)
        
        for i = 1, cursorsToShow do
            local angle = cursorRotation + (pi * 2 * i / cursorsToShow)
            local x = cookieX + math.cos(angle) * radius
            local y = cookieY + math.sin(angle) * radius
            
            -- Scale cursor images appropriately
            local cursorScale = math.max(0.5, math.min(2.0, scale))
            if cursorScale ~= 1.0 then
                Graphics.drawImageExtended(x, y, 0, 0, 32, 32, angle + pi/2, cursorScale, cursorScale, Cursor_img)
            else
                Graphics.drawRotateImage(x, y, Cursor_img, angle + pi/2)
            end
        end
    end
end

function drawLeftPanel()
    -- Buildings panel background
    Graphics.fillRect(0, LEFT_PANEL_WIDTH, 0, screenH, Color.new(35, 40, 35))
    
    -- Add visual panel border (right edge)
    Graphics.fillRect(LEFT_PANEL_WIDTH - 2, LEFT_PANEL_WIDTH, 0, screenH, Color.new(15, 20, 30))
    
    -- Buildings header area
    local headerPadding = math.floor(10 * scaleX)
    local headerY = math.floor(10 * scaleY)
    
    -- Header background (consistent height with cookie area)
    Graphics.fillRect(0, LEFT_PANEL_WIDTH, 0, math.floor(45 * scaleY), Color.new(25, 30, 25))
    
    Graphics.debugPrint(headerPadding, headerY, "BUILDINGS", white)
    
    local buildingY = math.floor(45 * scaleY)  -- Start right after header
    local BASE_LINE_HEIGHT = 71
    local lineHeight = math.max(50, math.floor(BASE_LINE_HEIGHT * scaleY))
    
    for i, building in ipairs(BuildingTypes) do
        if building.count > 0 then
            local currentY = buildingY + (i - 2) * lineHeight  -- Start from grandma (index 2)
            
            if currentY > 0 and currentY < screenH - lineHeight then
                -- Draw background sprite (taller and wider)
                if BackgroundSprites_img then
                    -- Map building types to background sprite indices (grandma=0, farm=1, mine=2, etc.)
                    local spriteIndex = i - 2  -- Cursor=skip, Grandma=0, Farm=1, Mine=2, etc.
                    
                    -- Scale to fit panel width and proportional height
                    local spriteScaleX = LEFT_PANEL_WIDTH / 242  -- Scale width to fit panel
                    local spriteScaleY = math.max(1.0, lineHeight / 71)  -- Scale height proportionally
                    
                    -- Use the positioning that worked with drawPartialImage
                    Graphics.drawImageExtended(LEFT_PANEL_WIDTH/2, currentY + (lineHeight/2), 0, spriteIndex * 71, 242, 71, 0, spriteScaleX, spriteScaleY, BackgroundSprites_img)
                end
                
                -- Draw building icons on top of background (using ObjectsSheet)
                if ObjectsSheet_img then
                    local iconsPerRow = math.min(building.count, math.floor(LEFT_PANEL_WIDTH / (40 * scaleX)))  -- Adaptive icon count
                    local iconSpacing = math.floor(40 * scaleX)
                    local iconSize = math.floor(50 * scale)
                    
                    for j = 1, iconsPerRow do
                        -- Proportional positioning
                        local iconX = math.floor(2 * scaleX) + (j-1) * iconSpacing
                        local iconY = currentY + math.floor((lineHeight - iconSize) / 2)  -- Center vertically
                        -- Use the correct sprite mapping: grandma=0, farm=50, mine=100, etc.
                        local spriteX = (i - 2) * 50  -- Skip cursor, start from grandma
                        
                        -- Scale the icon appropriately
                        if iconSize ~= 50 then
                            Graphics.drawImageExtended(iconX + iconSize/2, iconY + iconSize/2, spriteX, 0, 50, 50, 0, iconSize/50, iconSize/50, ObjectsSheet_img)
                        else
                            Graphics.drawPartialImage(iconX, iconY, spriteX, 0, 50, 50, ObjectsSheet_img)
                        end
                    end
                end
            end
        end
    end
end

function drawCookieArea()
    local panelX = LEFT_PANEL_WIDTH
    local areaHeight = COOKIE_AREA_HEIGHT
    
    -- Cookie area background
    Graphics.fillRect(panelX, screenW, 0, areaHeight, Color.new(30, 35, 50))
    
    -- Horizontal divider between cookie and store areas
    Graphics.fillRect(panelX, screenW, areaHeight - 2, areaHeight, Color.new(15, 20, 30))
    
    -- Cookie display (positioned to center in the larger cookie area)
    local cookieX = panelX + RIGHT_PANEL_WIDTH / 2
    local cookieY = math.floor(areaHeight * 0.60)  -- Position lower to center in expanded cookie area
    
    -- Stats header area
    local headerPadding = math.floor(10 * scaleX)
    local headerY = math.floor(4 * scaleY)  -- Raised up 6 pixels total
    
    -- Header background (taller to contain both text lines)
    Graphics.fillRect(panelX, screenW, 0, math.floor(45 * scaleY), Color.new(20, 25, 40))
    
    -- Cookie count and per second at the top (number on the right)
    Graphics.debugPrint(panelX + headerPadding, headerY, "Cookies: "..formatNumber(math.floor(Cookie.count)), white)
    Graphics.debugPrint(panelX + headerPadding, headerY + math.floor(18 * scaleY), "Per Sec: "..formatNumber(CpS), white)
    
    -- Shine effect (scaled for cookie area)
    local shineScale = Cookie.size * 0.8  -- Smaller scale for smaller area
    
    -- Get shine image dimensions
    local shineW = Graphics.getImageWidth(Shine_img) or 128
    local shineH = Graphics.getImageHeight(Shine_img) or 128
    
    -- First shine rotating clockwise (positive rotation)
    Graphics.drawImageExtended(cookieX, cookieY, 0, 0, shineW, shineH, shineRotation, shineScale, shineScale, Shine_img)
    -- Second shine rotating counter-clockwise (negative rotation)
    Graphics.drawImageExtended(cookieX, cookieY, 0, 0, shineW, shineH, -shineRotation, shineScale, shineScale, Shine_img)
    
    -- Cookie with size animation (smaller for the area)
    local cookieScale = Cookie.size * 0.7  -- Scale down for smaller area
    if Cookie.clicking then
        cookieScale = cookieScale * 1.2
    end
    Graphics.drawImageExtended(cookieX, cookieY, 0, 0, 128, 128, 0, cookieScale, cookieScale, Cookie_img)
    
    -- Draw rotating cursors around the cookie (scaled down)
    drawCursors(cookieX, cookieY)
end

function drawStoreArea()
    local panelX = LEFT_PANEL_WIDTH
    local storeStartY = COOKIE_AREA_HEIGHT
    
    -- Store area background (bottom 2/3 of right panel)
    Graphics.fillRect(panelX, screenW, storeStartY, screenH, Color.new(45, 40, 55))
    
    -- Store header area
    local headerPadding = math.floor(10 * scaleX)
    local headerY = storeStartY + math.floor(10 * scaleY)
    
    -- Header background
    Graphics.fillRect(panelX, screenW, storeStartY, storeStartY + math.floor(35 * scaleY), Color.new(35, 30, 45))
    
    Graphics.debugPrint(panelX + headerPadding, headerY, "STORE:  "..Store.mode, white)
    
    -- Building list with proportional scaling and scrolling (positioned at bottom)
    local BASE_ITEM_HEIGHT = 42  -- More compact items like the reference image
    local itemHeight = math.max(35, math.floor(BASE_ITEM_HEIGHT * scaleY))
    
    -- Calculate viewport for sliding list (like 3DS version)
    local viewportHeight = math.floor(130 * scaleY)  -- Height of visible area
    local viewportY = storeStartY + STORE_AREA_HEIGHT - viewportHeight - math.floor(10 * scaleY)
    
    -- Update list sliding animation
    Store.targetY = -(Store.selectedIndex - 1) * itemHeight  -- Target position based on selection
    local slideSpeed = math.floor(11 * scale)  -- Animation speed (like 3DS version)
    
    if Store.listY < Store.targetY then
        Store.listY = math.min(Store.listY + slideSpeed, Store.targetY)
    elseif Store.listY > Store.targetY then
        Store.listY = math.max(Store.listY - slideSpeed, Store.targetY)
    end
    
    -- Calculate actual drawing position with sliding offset
    local startY = viewportY + Store.listY
    
    -- Draw all items but only render those within viewport
    for i = 1, #BuildingTypes do
        local building = BuildingTypes[i]
        local itemY = startY + (i - 1) * itemHeight
        
        -- Only render if item is within viewport bounds
        if itemY + itemHeight > viewportY and itemY < viewportY + viewportHeight then
        
            local canAfford = Cookie.count >= building.price
            local textColor = canAfford and green or red
            
            -- Use ButtonsSheet images for store items (like 3DS version)
            if ButtonsSheet_img then
                local buttonState = 0  -- Normal state
                if i == Store.selectedIndex then
                    buttonState = 1  -- Selected/pressed state (like 3DS version)
                elseif not canAfford then
                    buttonState = 2  -- Disabled state (if available)
                end
                
                -- ButtonsSheet has locked items on left, unlocked on right
                -- Total width is 300px: locked (0-149px) and unlocked (150-299px)
                -- Each button is 150 pixels wide, 32 pixels tall
                local buttonWidth = 150  -- Full width of each button
                local buttonHeight = 32
                
                -- Determine which set to use (locked vs unlocked)
                local buttonX_offset = 150  -- Start with unlocked version (right side)
                if Cookie.total < building.unlockThreshold and building.count == 0 then
                    buttonX_offset = 0  -- Use locked version (left side) only if never unlocked AND never bought
                end
                
                -- Scale the button to fill the width of the panel
                local buttonScaleX = (RIGHT_PANEL_WIDTH - math.floor(10 * scaleX)) / buttonWidth  -- Scale to fill width minus small margins
                local buttonScaleY = itemHeight / buttonHeight  -- Scale height to fit item height
                
                -- Position button to fill the panel width
                local buttonX = panelX + (RIGHT_PANEL_WIDTH / 2)
                local buttonY = itemY + (itemHeight / 2)
                
                -- Draw the button background from ButtonsSheet (the image contains icon and text)
                -- Y offset should match building index: cursor=0, grandma=32, farm=64, etc.
                local buttonY_offset = (i - 1) * buttonHeight
                Graphics.drawImageExtended(buttonX, buttonY, 
                                         buttonX_offset, buttonY_offset, buttonWidth, buttonHeight, 0, 
                                         buttonScaleX, buttonScaleY, ButtonsSheet_img)
                
                -- Draw selection frame overlay (like 3DS version) with blue tint
                if i == Store.selectedIndex then
                    if Frameus_img then
                        -- Scale frameus to be larger than the stretched button size
                        local frameWidth = Graphics.getImageWidth(Frameus_img)
                        local frameHeight = Graphics.getImageHeight(Frameus_img)
                        local frameScaleX = (buttonWidth * buttonScaleX) / frameWidth  -- Same width as button
                        local frameScaleY = (buttonHeight * buttonScaleY * 1.3) / frameHeight  -- 30% taller than button
                        
                        Graphics.drawImageExtended(buttonX, buttonY, 
                                                 0, 0, frameWidth, frameHeight, 0, 
                                                 frameScaleX, frameScaleY, Frameus_img, Color.new(0, 150, 255, 180))
                    else
                        -- Fallback: draw a blue rectangle border if frameus not available
                        local borderThickness = math.floor(3 * scale)
                        local borderColor = Color.new(0, 150, 255, 200)
                        local x1 = buttonX - (buttonWidth * buttonScaleX / 2)
                        local y1 = buttonY - (buttonHeight * buttonScaleY / 2)
                        local x2 = buttonX + (buttonWidth * buttonScaleX / 2)
                        local y2 = buttonY + (buttonHeight * buttonScaleY / 2)
                        
                        -- Top border
                        Graphics.fillRect(x1, x2, y1, y1 + borderThickness, borderColor)
                        -- Bottom border
                        Graphics.fillRect(x1, x2, y2 - borderThickness, y2, borderColor)
                        -- Left border
                        Graphics.fillRect(x1, x1 + borderThickness, y1, y2, borderColor)
                        -- Right border
                        Graphics.fillRect(x2 - borderThickness, x2, y1, y2, borderColor)
                    end
                end
            else
                -- Fallback to colored rectangles if ButtonsSheet not available
                local tileColor = canAfford and Color.new(50, 55, 65) or Color.new(35, 30, 40)
                Graphics.fillRect(panelX + 2, panelX + RIGHT_PANEL_WIDTH - 2, itemY + 2, itemY + itemHeight - 2, tileColor)
                
                -- Selection highlight
                if i == Store.selectedIndex then
                    Graphics.fillRect(panelX + 1, panelX + RIGHT_PANEL_WIDTH - 1, itemY + 1, itemY + itemHeight - 1, Color.new(80, 90, 110))
                end
                
                -- Fallback text only if ButtonsSheet is not available
                local textX = panelX + math.floor(30 * scaleX)
                local lineSpacing = math.max(10, math.floor(12 * scaleY))
                
                local displayName = building.name
                if Cookie.total < building.unlockThreshold then
                    displayName = "???"
                end
                
                Graphics.debugPrint(textX, itemY + 3, displayName, white)
                Graphics.debugPrint(textX, itemY + lineSpacing, formatNumber(building.price), textColor)
                
                if building.count > 0 then
                    Graphics.debugPrint(textX, itemY + lineSpacing * 2, "x"..building.count, gray)
                end
            end
        end -- End of viewport bounds check
    end
    
    -- Draw selected item info section below store header (compact inline layout)
    if Store.selectedIndex <= #BuildingTypes then
        local selectedBuilding = BuildingTypes[Store.selectedIndex]
        local infoY = storeStartY + math.floor(35 * scaleY)  -- Below store header
        
        -- Info section background (shorter area)
        local infoHeight = math.floor(35 * scaleY)  -- Shorter height
        Graphics.fillRect(panelX, screenW, infoY, infoY + infoHeight, Color.new(25, 20, 35))
        
        -- All elements inline on same line
        local baseY = infoY + math.floor(8 * scaleY)  -- Vertically centered in shorter section
        
        -- Selected item icon (to the left)
        if Icons_img then
            local iconX = panelX + math.floor(10 * scaleX)
            local iconScale = math.max(1.0, math.min(1.2, scale))
            Graphics.drawImageExtended(iconX, baseY + math.floor(2 * scaleY), selectedBuilding.icon * 24, 0, 24, 24, 0, iconScale, iconScale, Icons_img)
        end
        
        -- Building count next to icon (like 3DS version: "# X")
        local countX = panelX + math.floor(40 * scaleX)
        Graphics.debugPrint(countX, baseY, "# "..selectedBuilding.count, white)
        
        -- Cost next to count
        local costX = panelX + math.floor(90 * scaleX)
        Graphics.debugPrint(costX, baseY, formatNumber(selectedBuilding.price), Cookie.count >= selectedBuilding.price and green or red)
    end
    
    -- Upgrade display section (like 3DS version)
    if AvailableUpgrade ~= nil then
        local upgradeY = storeStartY + math.floor(70 * scaleY)  -- Below selected item info
        
        -- Upgrade section background
        local upgradeHeight = math.floor(25 * scaleY)
        Graphics.fillRect(panelX, screenW, upgradeY, upgradeY + upgradeHeight, Color.new(40, 25, 50))
        
        -- Upgrade text and cost
        local upgradeBaseY = upgradeY + math.floor(5 * scaleY)
        
        -- Show upgrade multiplier (x2 like 3DS version)
        Graphics.debugPrint(panelX + math.floor(10 * scaleX), upgradeBaseY, "UPGRADE x2", yellow)
        
        -- Show upgrade cost with color based on affordability
        local upgradeCostColor = Cookie.count >= UpgradePrice and green or red
        Graphics.debugPrint(panelX + math.floor(130 * scaleX), upgradeBaseY, formatNumber(UpgradePrice), upgradeCostColor)
    end
    
    -- Bottom detail section removed - menu items now use the bottom space
end

function handleInput()
    local pad = Controls.read()
    
    -- Cookie clicking - Using C key for cookie clicking
    local cookiePressed = false
    local cookieWasPressed = false
    
    if SDLK_C then
        cookiePressed = Controls.check(pad, SDLK_C)
        cookieWasPressed = Controls.check(oldpad, SDLK_C)
    end
    
    if cookiePressed then
        Cookie.clicking = true
    end
    
    if not cookiePressed and cookieWasPressed then
        -- Button was just released, increment cookie count with cursor upgrade bonus
        local cursorBuilding = BuildingTypes[1]  -- Cursor is the first building
        local clickValue = 1 * cursorBuilding.upgrade
        Cookie.count = Cookie.count + clickValue
        Cookie.total = Cookie.total + clickValue
        updateBuildingNames()  -- Check for newly unlocked buildings
        updateUpgrades()  -- Check for newly available upgrades
        Cookie.clicking = false
    elseif not cookiePressed then
        Cookie.clicking = false
    end
    
    -- Store navigation (D-pad) - with timing delay to prevent too fast navigation and auto-scrolling
    if Timer.getTime(navTimer) >= NAV_DELAY then
        if Controls.check(pad, SDLK_UP) and not Controls.check(oldpad, SDLK_UP) then
            Store.selectedIndex = math.max(1, Store.selectedIndex - 1)
            Timer.reset(navTimer)
        end
        
        if Controls.check(pad, SDLK_DOWN) and not Controls.check(oldpad, SDLK_DOWN) then
            Store.selectedIndex = math.min(#BuildingTypes, Store.selectedIndex + 1)
            Timer.reset(navTimer)
        end
    end
    
    -- Buy/Sell (A button) - Using Space for primary action
    if Timer.getTime(buttonTimer) >= BUTTON_DELAY then
        if Controls.check(pad, SDLK_SPACE) and not Controls.check(oldpad, SDLK_SPACE) then
            local building = BuildingTypes[Store.selectedIndex]
            if Store.mode == "BUY" and Cookie.count >= building.price then
                Cookie.count = Cookie.count - building.price
                building.count = building.count + 1
                updatePrices()
                updateCpS()
                updateUpgrades()  -- Check for newly available upgrades
                saveGame()  -- Autosave after buying
                Timer.reset(buttonTimer)
            elseif Store.mode == "SELL" and building.count > 0 then
                building.count = building.count - 1
                Cookie.count = Cookie.count + math.floor(building.price * 0.5)
                updatePrices()
                updateCpS()
                updateUpgrades()  -- Check for newly available upgrades
                saveGame()  -- Autosave after selling
                Timer.reset(buttonTimer)
            end
        end
    end
    
    -- Upgrade (Y button) - Using Y key
    if Timer.getTime(buttonTimer) >= BUTTON_DELAY then
        if Controls.check(pad, SDLK_Y) and not Controls.check(oldpad, SDLK_Y) then
            -- Purchase upgrade if available and affordable (like 3DS version)
            if AvailableUpgrade ~= nil and Cookie.count >= UpgradePrice then
                Cookie.count = Cookie.count - UpgradePrice
                AvailableUpgrade.upgrade = AvailableUpgrade.upgrade * 2  -- Double the upgrade multiplier
                updateCpS()  -- Recalculate CPS with new upgrade
                updateUpgrades()  -- Check for next available upgrades
                saveGame()  -- Autosave after upgrading
            end
            Timer.reset(buttonTimer)
        end
    end
    
    -- Toggle BUY/SELL mode (Select button) - Using Tab
    if Timer.getTime(buttonTimer) >= BUTTON_DELAY then
        if Controls.check(pad, SDLK_TAB) and not Controls.check(oldpad, SDLK_TAB) then
            Store.mode = (Store.mode == "BUY") and "SELL" or "BUY"
            Timer.reset(buttonTimer)
        end
    end
    
    -- Screenshot (L+R shoulders) - Using Q+E
    if Controls.check(pad, SDLK_Q) and Controls.check(pad, SDLK_E) and 
       not (Controls.check(oldpad, SDLK_Q) and Controls.check(oldpad, SDLK_E)) then
        -- Future screenshot functionality
    end
    
    -- Save and Exit (SELECT button) - Using ESC key
    if Timer.getTime(buttonTimer) >= BUTTON_DELAY then
        if Controls.check(pad, SDLK_ESCAPE) and not Controls.check(oldpad, SDLK_ESCAPE) then
            saveGame()  -- Save before exiting
            os.exit()   -- Exit the game
        end
    end
    
    oldpad = pad
end

-- Initialize
Timer.resume(timer)
Timer.resume(navTimer)
Timer.resume(buttonTimer)

-- Load saved game if it exists
if not loadGame() then
    -- If no save file exists, use default values
    updatePrices()
    updateCpS()
end

-- Main game loop
while true do
    handleInput()
    
    -- Update shine rotation (like 3DS version)
    shineRotation = shineRotation + SHINE_SPEED
    if shineRotation >= 2 * 3.14159 then
        shineRotation = shineRotation - 2 * 3.14159
    end
    
    -- Update cursor rotation
    cursorRotation = cursorRotation + 0.008
    if cursorRotation >= 2 * 3.14159 then
        cursorRotation = cursorRotation - 2 * 3.14159
    end
    
    -- Passive cookie generation
    if Timer.getTime(timer) >= 40 then
        Cookie.count = Cookie.count + CpS / 25
        Cookie.total = Cookie.total + CpS / 25
        updateBuildingNames()  -- Check for newly unlocked buildings
        Timer.reset(timer)
    end
    
    -- Render
    Graphics.initBlend()
    Screen.clear()
    
    drawLeftPanel()
    drawCookieArea()
    drawStoreArea()
    
    Graphics.termBlend()
    Screen.flip()
    Screen.waitVblankStart()
end