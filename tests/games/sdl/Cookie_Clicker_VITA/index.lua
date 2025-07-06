-- Cookie Clicker SDL Port (from Vita version)
-- Gamepad controls optimized for 640x480 resolution
-- Converted from Vita touch controls to gamepad navigation

-- Save encryption configuration (set to true to encrypt save files)
local ENCRYPT_SAVE = false

Graphics.init()

-- Load CryptLib for save encryption support
dofile("libs/CryptLib.lua")

-- Initialize game controllers for SDL gamepad support
if Controls.init then
    Controls.init()
end

-- Target 640x480 resolution with responsive scaling
local screenW, screenH = 640, 480

-- Try to set window size if the function exists (native SDL mode only)
if Graphics.setMode then
    Graphics.setMode(screenW, screenH)
elseif Window and Window.setSize then
    Window.setSize(screenW, screenH)
elseif Screen and Screen.setMode then
    Screen.setMode(screenW, screenH)
end

-- If none of the above work, check for actual screen size
if Screen and Screen.getWidth then
    local actualW = Screen.getWidth()
    local actualH = Screen.getHeight()
    if actualW and actualW > 0 then
        screenW = actualW
        screenH = actualH
    end
end

-- Calculate scale factor for responsive design (640x480 as base resolution)
local BASE_WIDTH = 640
local BASE_HEIGHT = 480
local scaleX = screenW / BASE_WIDTH
local scaleY = screenH / BASE_HEIGHT
local scale = math.min(scaleX, scaleY) -- Use smaller scale to maintain aspect ratio

-- Apply reasonable scaling limits
scaleX = math.max(0.5, math.min(4.0, scaleX))
scaleY = math.max(0.5, math.min(4.0, scaleY))
scale = math.max(0.5, math.min(4.0, scale))

-- Debug: Print scaling information
print(string.format("Cookie Clicker SDL Scaling: %dx%d -> scaleX=%.2f, scaleY=%.2f, scale=%.2f", 
                   screenW, screenH, scaleX, scaleY, scale))

-- Large number formatting from Vita version
local NAMEOMBTQ={"Million", "Billion", "Trillion", "Quadrillion", "Quintillion", "Sextillion", "Septillion", "Octillion", "Nonillion", "Decillion", "Undecillion", "Duodecillion", "Tredecillion", "Quattuordecillion", "Quindecillion", "Sexdecillion", "Septendecillion", "Octodecillion", "Novemdecillion", "Vigintillion"}

-- Colors (from Vita version)
local white = Color.new(255,255,255)
local black = Color.new(0,0,0)
local gray = Color.new(128,128,128)
local yellow = Color.new(255,255,80)
local blue = Color.new(80,80,255)
local red = Color.new(255,80,80)
local transred = Color.new(255,80,80,80)
local trans150red = Color.new(255,80,80,150)
local green = Color.new(80,255,80)
local transwhite = Color.new(255,255,255,150)
local trans100white = Color.new(255,255,255,100)

-- UI Layout for 640x480 (2-panel design like 3DS version)
-- Left panel: Buildings (60% of screen)
-- Right panel: Cookie + Store (40% of screen)
local BASE_LEFT_WIDTH = 384  -- Buildings panel (60% of 640)
local BASE_RIGHT_WIDTH = 256  -- Cookie + Store panel (40% of 640)

-- Apply scaling with minimum sizes
local PANEL_LEFT_WIDTH = math.max(320, math.floor(BASE_LEFT_WIDTH * scaleX))
local PANEL_RIGHT_WIDTH = screenW - PANEL_LEFT_WIDTH

-- Ensure right panel has minimum width for usability
if PANEL_RIGHT_WIDTH < 220 then
    PANEL_LEFT_WIDTH = screenW - 220
    PANEL_RIGHT_WIDTH = 220
end

-- Panel positions
local PANEL_LEFT_X = 0
local PANEL_RIGHT_X = PANEL_LEFT_WIDTH

-- Right panel subdivisions  
local COOKIE_AREA_HEIGHT = math.floor(screenH * 0.40)  -- Reduced to 40% for cookie
local STORE_AREA_HEIGHT = screenH - COOKIE_AREA_HEIGHT  -- Bottom 60% for store + upgrades

-- Cookie position (centered in right panel top area)
local CENTER_OF_COOKIE_X = PANEL_RIGHT_X + PANEL_RIGHT_WIDTH / 2
local CENTER_OF_COOKIE_Y = math.floor(COOKIE_AREA_HEIGHT / 2) + math.floor(20 * scaleY)

-- Header and store positioning
local HEADER_HEIGHT = math.floor(30 * scaleY)
local UPGRADE_HEIGHT = math.floor(70 * scaleY)  -- Reduced space for upgrade frames
local STORE_START_Y = COOKIE_AREA_HEIGHT + HEADER_HEIGHT + UPGRADE_HEIGHT

-- Game state variables
local gameState = "Title"  -- "Title", "Game", "Controls", "Settings", "About", "Statistics"
local version = "version 1.0"

-- Menu state
local MenuState = {
    selectedIndex = 1,
    options = {"Start", "Settings", "Controls", "Statistics", "About", "Exit"},
    optionCount = 6
}

-- Check if save file exists and update menu
if System.doesFileExist("data/ccsave.sav") then
    MenuState.options[1] = "Continue"
end

-- Game objects (converted from Vita structure)
local Building = {}
local Button = {}
local Cookie = {
    shower = {}
}
local CookiePerSecond = {}
local Cursor = {}
local Panel = {}
local Price = {}
local ScreenB = {}
local Shine = {}
local SpdOf = {}
local Texture = {}
local Upgrade = {
    Now = {}
}
local Game = {}
local Milk = {}

-- Game session statistics
Game.startTime = 0
Game.totalPlayTime = 0
Game.sessionStart = 0
Game.longestSession = 0
Game.totalBuildings = 0
Game.totalUpgrades = 0

-- Audio settings
local AudioSettings = {
    bgMusicEnabled = true,
    bgMusicVolume = 0.7,  -- 0.0 to 1.0
    isPlaying = false
}

-- Visual settings
local VisualSettings = {
    cookieShowerEnabled = true,
    milkAnimationEnabled = true
}

-- Control settings
local ControlSettings = {
    mode = "Keyboard",  -- "Keyboard" or "Gamepad"
    gamepadEnabled = false
}

-- Settings navigation
local SettingsState = {
    selectedIndex = 1,
    options = {"Background Music", "Music Volume", "Cookie Shower", "Milk Animation", "Reset Game"},
    optionCount = 5
}

-- SDL Control state (simplified for 2-panel layout)
local GamepadState = {
    currentPanel = "Store",  -- "Store", "Buildings"
    selectedIndex = 1,
    purchaseQuantity = 1,    -- 1, 10, 100
    buyMode = true,          -- true = buy, false = sell
    scrollOffset = 0
}

-- Scaled UI positions for 2-panel layout
Button.default = STORE_START_Y + math.floor(10 * scaleY)
Button.tmp = 0
Button.quantity = 2
Button.x = PANEL_RIGHT_X + math.floor(10 * scaleX)  -- Store panel position
Button.y = Button.default
Button.defaulttemp = Button.default

Building.default = HEADER_HEIGHT + math.floor(10 * scaleY)
Building.x = PANEL_LEFT_X + math.floor(10 * scaleX)   -- Buildings panel position
Building.y = Building.default

Cookie.count = 0
Cookie.total = 0
Cookie.size = 0
Cookie.tmp = 0
Cookie.speed = 0.1
Cookie.shower.speed = 1

-- New statistics tracking
Cookie.clicked = 0          -- Total cookies earned from clicks
Cookie.clickCount = 0       -- Total number of clicks made
Cookie.maxCpS = 0          -- Maximum CpS achieved
Cookie.totalSpent = 0      -- Total cookies spent on buildings/upgrades
Cookie.shower.y = 0

Cursor.rot = 0
Cursor.speed = -0.0025
Cursor.max = 30

Panel.kolvo = 1
Panel.state = "Buy"
Panel.tmp = 0

Shine.rot = 0
Shine.speed = 0.008

SpdOf.framerate = 60
SpdOf.tmp = 0
SpdOf.cmn = 0

Upgrade.default = Button.default
Upgrade.tmp = 0
Upgrade.mode = 1

Milk.y = math.floor(464 * scaleY)
Milk.x = 0
Milk.speed = 0.8

Game.state = "Normal"

local pi = math.pi
local oldpad = Controls.read()  -- Initialize with proper Controls value instead of 0
-- Gamepad state tracking for edge detection
local gamepadState = {
    A_prev = false,
    X_prev = false,
    B_prev = false,
    Y_prev = false,
    L_prev = false,
    R_prev = false,
    Start_prev = false,
    DPadUp_prev = false,
    DPadDown_prev = false,
    DPadLeft_prev = false,
    DPadRight_prev = false
}

-- Timer setup
local timer = Timer.new()
local navTimer = Timer.new()
local buttonTimer = Timer.new()
local cookieTimer = Timer.new()
local NAV_DELAY = 150  -- milliseconds between navigation inputs
local BUTTON_DELAY = 100  -- milliseconds between button presses
local COOKIE_DELAY = 50   -- milliseconds between cookie clicks (faster for better feel)

-- Load images (adjusted paths for SDL structure)
if System.currentDirectory() == "/" then
    System.currentDirectory("romfs:/")
end

local assetPath = System.currentDirectory().."/assets/"

-- Essential images
local Cookie_img = Graphics.loadImage(assetPath.."cookie.png")
local Shine_img = Graphics.loadImage(assetPath.."shine.png")
local Icons_img = Graphics.loadImage(assetPath.."icons.png")
local Cursor_img = Graphics.loadImage(assetPath.."cursor.png")
local Background_img = Graphics.loadImage(assetPath.."background.png")
local Darkback_img = Graphics.loadImage(assetPath.."darkback.png")
local ShadedBorders_img = Graphics.loadImage(assetPath.."shadedBorders.png")
local Milk_img = Graphics.loadImage(assetPath.."milk.png")

-- Building and UI images
local BLDBacks_img = Graphics.loadImage(assetPath.."BLDBacks.png")
local BLDIcons_img = Graphics.loadImage(assetPath.."BLDIcons.png")
local StoreTile_img = Graphics.loadImage(assetPath.."storeTile.jpg")
local PressedTile_img = Graphics.loadImage(assetPath.."pressedTile.png")
local UpgradeFrame_img = Graphics.loadImage(assetPath.."upgradeFrame.png")

-- Cookie shower effects
local CookieShower1_img = Graphics.loadImage(assetPath.."cookieShower1.png")
local CookieShower2_img = Graphics.loadImage(assetPath.."cookieShower2.png")
local CookieShower3_img = Graphics.loadImage(assetPath.."cookieShower3.png")

-- Panel separator images
local PanelVertical_img = Graphics.loadImage(assetPath.."panelVertical.png")
local PanelHorizontal_img = Graphics.loadImage(assetPath.."panelHorizontal.png")

-- Gradient images for polish
local PanelGradientLeft_img = Graphics.loadImage(assetPath.."panelGradientLeft.png")
local PanelGradientRight_img = Graphics.loadImage(assetPath.."panelGradientRight.png")
local PanelGradientTop_img = Graphics.loadImage(assetPath.."panelGradientTop.png")
local PanelGradientBottom_img = Graphics.loadImage(assetPath.."panelGradientBottom.png")

-- Store button images
local Buildings_img = Graphics.loadImage(assetPath.."buildings.png")
local Favicon_img = Graphics.loadImage(assetPath.."favicon.png")

-- Title screen images
local Banner_img = Graphics.loadImage(assetPath.."banner.png")
local LppSDL_img = Graphics.loadImage(assetPath.."lppsdl.png")

-- Initialize audio subsystem
Sound.init()

-- Audio files
local bgMusic = nil
if System.doesFileExist(assetPath.."bgm.ogg") then
    bgMusic = Sound.open(assetPath.."bgm.ogg")
end

-- Store textures in table for easy access
Texture = {
    ["BLDBacks"] = BLDBacks_img,
    ["BLDIcons"] = BLDIcons_img,
    ["Cookie"] = Cookie_img,
    ["Shine"] = Shine_img,
    ["Icons"] = Icons_img,
    ["Cursor"] = Cursor_img,
    ["Background"] = Background_img,
    ["Darkback"] = Darkback_img,
    ["ShadedBorders"] = ShadedBorders_img,
    ["Milk"] = Milk_img,
    ["StoreTile"] = StoreTile_img,
    ["PressedTile"] = PressedTile_img,
    ["UpgradeFrame"] = UpgradeFrame_img,
    ["CookieShower1"] = CookieShower1_img,
    ["CookieShower2"] = CookieShower2_img,
    ["CookieShower3"] = CookieShower3_img,
    ["panelVertical"] = PanelVertical_img,
    ["panelHorizontal"] = PanelHorizontal_img,
    ["panelGradientLeft"] = PanelGradientLeft_img,
    ["panelGradientRight"] = PanelGradientRight_img,
    ["panelGradientTop"] = PanelGradientTop_img,
    ["panelGradientBottom"] = PanelGradientBottom_img,
    ["Buildings"] = Buildings_img,
    ["Favicon"] = Favicon_img,
    ["Banner"] = Banner_img,
    ["LppSDL"] = LppSDL_img
}

-- Font system (inline from Vita libs/Font.lua)
local glyph_l = {}
local glyph_r = {}
local glyph_w = {}

function g_init(char, l, r)
    glyph_l[char] = l
    glyph_r[char] = r
    glyph_w[char] = r-l+1
end

-- Initialize font glyphs
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

-- Load fonts
local defaultFont = Font.load()
local smallFont = Font.load()
local titleFont = Font.load()

-- Set font sizes
if Font.setPixelSizes then
    Font.setPixelSizes(titleFont, 32)  -- Large font for title
    Font.setPixelSizes(defaultFont, 16)  -- Normal font size
    Font.setPixelSizes(smallFont, 12)  -- Small font for prices
end

-- Use default LPP-SDL fonts instead of PNG fonts
function drawText(x, y, text, color)
    Font.print(defaultFont, x, y, text, color)
end

-- Small text function for prices
function drawSmallText(x, y, text, color)
    Font.print(smallFont, x, y, text, color)
end

-- Title text function for large text
function drawTitleText(x, y, text, color)
    Font.print(titleFont, x, y, text, color)
end

-- Number formatting for cookie counts (whole numbers, no abbreviations)
function formatCookieCount(num)
    num = math.floor(num)  -- Always use whole numbers for cookie count
    
    if num >= 1000000000000000000000 then
        local index = math.min(math.floor(math.log10(num)/3) - 5, #NAMEOMBTQ)
        return string.format("%.0f %s", num / (10^(index*3+15)), NAMEOMBTQ[index] or "???")
    elseif num >= 1000000000 then
        return string.format("%.0f B", num/1000000000)
    elseif num >= 1000000 then
        return string.format("%.0f M", num/1000000)
    else
        return string.format("%d", num)
    end
end

-- Number formatting function for other values (prices, CPS, etc.)
function formatNumber(num)
    -- Round up to nearest integer first
    num = math.ceil(num)
    
    if num >= 1000000000000000000000 then
        local index = math.min(math.floor(math.log10(num)/3) - 5, #NAMEOMBTQ)
        local scaled = math.ceil(num / (10^(index*3+15)))
        return string.format("%d %s", scaled, NAMEOMBTQ[index] or "???")
    elseif num >= 1000000 then
        local scaled = math.ceil(num/1000000)
        return string.format("%d M", scaled)
    elseif num >= 1000 then
        local scaled = math.ceil(num/1000)
        return string.format("%d K", scaled)
    else
        return string.format("%d", num)
    end
end

-- Time formatting function (converts seconds to readable format)
function formatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    
    if hours > 0 then
        return string.format("%d:%02d:%02d", hours, minutes, secs)
    else
        return string.format("%d:%02d", minutes, secs)
    end
end

-- Audio management functions
function startBackgroundMusic()
    if bgMusic and AudioSettings.bgMusicEnabled and not AudioSettings.isPlaying then
        -- Convert 0.0-1.0 volume to 0-32767 range for LPP-SDL
        local lppVolume = math.floor(AudioSettings.bgMusicVolume * 32767)
        Sound.setVolume(bgMusic, lppVolume)
        
        -- Always start fresh to ensure looping works
        Sound.play(bgMusic, true)  -- true for looping
        AudioSettings.isPlaying = true
    end
end

function stopBackgroundMusic()
    if bgMusic and AudioSettings.isPlaying then
        Sound.pause(bgMusic)
        AudioSettings.isPlaying = false
    end
end

function updateMusicVolume()
    if bgMusic and AudioSettings.isPlaying then
        -- Convert 0.0-1.0 volume to 0-32767 range for LPP-SDL
        local lppVolume = math.floor(AudioSettings.bgMusicVolume * 32767)
        Sound.setVolume(bgMusic, lppVolume)
    end
end

function toggleBackgroundMusic()
    AudioSettings.bgMusicEnabled = not AudioSettings.bgMusicEnabled
    if AudioSettings.bgMusicEnabled then
        startBackgroundMusic()
    else
        stopBackgroundMusic()
    end
end

function checkMusicLoop()
    -- Check if music should be playing but has stopped, restart it
    if bgMusic and AudioSettings.bgMusicEnabled and AudioSettings.isPlaying then
        if not Sound.isPlaying(bgMusic) then
            -- Music stopped, restart it
            AudioSettings.isPlaying = false
            startBackgroundMusic()
        end
    end
end

-- Button creation system (from Vita version)
function Button.make(name, fprice, id, cps)
    Button[name.."id"] = id
    Button[name.."fprice"] = fprice
    Button[name.."price"] = fprice
    Button[name.."count"] = 0
    Button[name.."cps"] = cps
    Button[name.."A"] = 0
    Button[name.."total"] = 0          -- Total ever purchased
    Button[name.."produced"] = 0       -- Total cookies produced by this building type
    Button[name.."spent"] = 0          -- Total spent on this building type
    Button[#Button + 1] = name
end

-- Upgrade system (from Vita version)
function Upgrade.make(name, id, count, price, column, row)
    local upgradeName = name..id
    Upgrade[upgradeName.."id"] = id
    Upgrade[upgradeName.."name"] = name
    Upgrade[upgradeName.."count"] = count
    Upgrade[upgradeName.."price"] = price
    Upgrade[upgradeName.."column"] = column
    Upgrade[upgradeName.."row"] = row
    Upgrade[upgradeName.."a"] = 0
    Upgrade[name.."Quan"] = 1
    Upgrade[#Upgrade + 1] = upgradeName
end

-- Initialize all buildings (from Vita version)
Button.make("Cursor", 15, 1, 0.1)
Button.make("Grandma", 100, 2, 1)
Button.make("Farm", 1000, 4, 8)
Button.make("Mine", 12000, 5, 47)
Button.make("Factory", 130000, 6, 260)
Button.make("Bank", 1400000, 7, 1400)
Button.make("Temple", 20000000, 8, 7800)
Button.make("WizardTower", 330000000, 9, 44000)
Button.make("Shipment", 5100000000, 10, 260000)
Button.make("AlchemyLab", 75000000000, 11, 1600000)
Button.make("Portal", 1000000000000, 12, 10000000)
Button.make("TimeMachine", 14000000000000, 13, 65000000)
Button.make("AntimatterCondenser", 170000000000000, 14, 430000000)
Button.make("Prism", 2100000000000000, 15, 2900000000)

-- Initialize Building list (for display order)
Building[1] = "Cursor"
Building[2] = "Grandma"
Building[3] = "Farm"
Building[4] = "Mine"
Building[5] = "Factory"
Building[6] = "Bank"
Building[7] = "Temple"
Building[8] = "WizardTower"
Building[9] = "Shipment"
Building[10] = "AlchemyLab"
Building[11] = "Portal"
Building[12] = "TimeMachine"
Building[13] = "AntimatterCondenser"
Building[14] = "Prism"

-- Save game function (plain text for easy testing)
function saveGame()
    -- Create save string with all game data
    local saveData = {}
    
    -- Save cookie data
    table.insert(saveData, tostring(Cookie.count))
    table.insert(saveData, tostring(Cookie.total))
    
    -- Save building counts
    for i = 1, #Building do
        local building = Building[i]
        table.insert(saveData, tostring(Button[building.."count"] or 0))
    end
    
    -- Save upgrade states
    for i = 1, #Upgrade do
        table.insert(saveData, tostring(Upgrade[Upgrade[i].."a"] or 0))
    end
    
    -- Save statistics
    table.insert(saveData, tostring(Cookie.clicked))
    table.insert(saveData, tostring(Cookie.clickCount))
    table.insert(saveData, tostring(Cookie.maxCpS))
    table.insert(saveData, tostring(Cookie.totalSpent))
    table.insert(saveData, tostring(Game.totalPlayTime))
    table.insert(saveData, tostring(Game.longestSession))
    table.insert(saveData, tostring(Game.totalBuildings))
    table.insert(saveData, tostring(Game.totalUpgrades))
    
    -- Save building production and spending stats
    for i = 1, #Building do
        local building = Building[i]
        table.insert(saveData, tostring(Button[building.."total"] or 0))
        table.insert(saveData, tostring(Button[building.."produced"] or 0))
        table.insert(saveData, tostring(Button[building.."spent"] or 0))
    end
    
    -- Save audio settings
    table.insert(saveData, tostring(AudioSettings.bgMusicEnabled and 1 or 0))
    table.insert(saveData, tostring(AudioSettings.bgMusicVolume))
    
    -- Save visual settings
    table.insert(saveData, tostring(VisualSettings.cookieShowerEnabled and 1 or 0))
    table.insert(saveData, tostring(VisualSettings.milkAnimationEnabled and 1 or 0))
    
    -- Save control settings
    table.insert(saveData, tostring(ControlSettings.gamepadEnabled and 1 or 0))
    
    -- Join with # delimiter like Vita version
    local saveString = table.concat(saveData, "#")
    
    -- Encrypt if enabled
    if ENCRYPT_SAVE then
        saveString = Encrypt(saveString, "cookieclickerkey")
    end
    
    -- Use LPP-SDL file I/O
    local savefile = io.open("data/ccsave.sav", FCREATE)
    if savefile then
        local saveStringLen = string.len(saveString)
        io.write(savefile, 0, saveString, saveStringLen)
        io.close(savefile)
        print("Game saved" .. (ENCRYPT_SAVE and " (encrypted)" or "") .. "!")
        return true
    end
    return false
end

-- Load game function
function loadGame()
    -- Check if save file exists first
    if not System.doesFileExist("data/ccsave.sav") then
        return false
    end
    
    -- Use LPP-SDL file I/O
    local savefile = io.open("data/ccsave.sav", FREAD)
    if savefile then
        local size = io.size(savefile)
        local saveString = io.read(savefile, 0, size)
        io.close(savefile)
        
        -- Try to decrypt if it looks encrypted (doesn't contain # delimiter)
        local isEncrypted = not string.find(saveString, "#")
        if isEncrypted or ENCRYPT_SAVE then
            local decrypted = Decrypt(saveString, "cookieclickerkey")
            -- Check if decryption was successful (should contain # delimiter)
            if decrypted and string.find(decrypted, "#") then
                saveString = decrypted
                print("Save file decrypted successfully")
            elseif isEncrypted then
                -- File appears encrypted but couldn't decrypt - delete corrupt save
                print("Could not decrypt save file - removing corrupt save")
                System.deleteFile("data/ccsave.sav")
                return false
            end
        end
        
        -- Split save string by # delimiter
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
            for i = 1, #Building do
                if saveData[index] then
                    local building = Building[i]
                    Button[building.."count"] = tonumber(saveData[index]) or 0
                    -- Update price based on count
                    if Button[building.."count"] > 0 then
                        Button[building.."price"] = math.floor(Button[building.."fprice"] * (1.15 ^ Button[building.."count"]))
                    end
                    index = index + 1
                end
            end
            
            -- Load upgrade states
            for i = 1, #Upgrade do
                if saveData[index] then
                    Upgrade[Upgrade[i].."a"] = tonumber(saveData[index]) or 0
                    index = index + 1
                end
            end
            
            -- Load statistics (if available in save file)
            if saveData[index] then Cookie.clicked = tonumber(saveData[index]) or 0; index = index + 1 end
            if saveData[index] then Cookie.clickCount = tonumber(saveData[index]) or 0; index = index + 1 end
            if saveData[index] then Cookie.maxCpS = tonumber(saveData[index]) or 0; index = index + 1 end
            if saveData[index] then Cookie.totalSpent = tonumber(saveData[index]) or 0; index = index + 1 end
            if saveData[index] then Game.totalPlayTime = tonumber(saveData[index]) or 0; index = index + 1 end
            if saveData[index] then Game.longestSession = tonumber(saveData[index]) or 0; index = index + 1 end
            if saveData[index] then Game.totalBuildings = tonumber(saveData[index]) or 0; index = index + 1 end
            if saveData[index] then Game.totalUpgrades = tonumber(saveData[index]) or 0; index = index + 1 end
            
            -- Load building production and spending stats (if available)
            for i = 1, #Building do
                local building = Building[i]
                if saveData[index] then Button[building.."total"] = tonumber(saveData[index]) or 0; index = index + 1 end
                if saveData[index] then Button[building.."produced"] = tonumber(saveData[index]) or 0; index = index + 1 end
                if saveData[index] then Button[building.."spent"] = tonumber(saveData[index]) or 0; index = index + 1 end
            end
            
            -- Load audio settings (if available)
            if saveData[index] then AudioSettings.bgMusicEnabled = (tonumber(saveData[index]) or 1) == 1; index = index + 1 end
            if saveData[index] then AudioSettings.bgMusicVolume = tonumber(saveData[index]) or 0.7; index = index + 1 end
            
            -- Load visual settings (if available)
            if saveData[index] then VisualSettings.cookieShowerEnabled = (tonumber(saveData[index]) or 1) == 1; index = index + 1 end
            if saveData[index] then VisualSettings.milkAnimationEnabled = (tonumber(saveData[index]) or 1) == 1; index = index + 1 end
            
            -- Load control settings (if available)
            if saveData[index] then 
                ControlSettings.gamepadEnabled = (tonumber(saveData[index]) or 0) == 1
                ControlSettings.mode = ControlSettings.gamepadEnabled and "Gamepad" or "Keyboard"
                index = index + 1 
            end
            
            print("Game loaded!")
            return true
        end
    end
    return false
end

-- Reset game function
function resetGame()
    -- Delete save file if it exists
    if System.doesFileExist("data/ccsave.sav") then
        System.deleteFile("data/ccsave.sav")
    end
    
    -- Reset all game variables to initial state
    Cookie.count = 0
    Cookie.total = 0
    Cookie.clicked = 0
    Cookie.clickCount = 0
    Cookie.maxCpS = 0
    Cookie.totalSpent = 0
    
    -- Reset building counts and prices
    for i = 1, #Building do
        local building = Building[i]
        Button[building.."count"] = 0
        Button[building.."price"] = Button[building.."fprice"]
        Button[building.."total"] = 0
        Button[building.."produced"] = 0
        Button[building.."spent"] = 0
    end
    
    -- Reset upgrade states
    for i = 1, #Upgrade do
        Upgrade[Upgrade[i].."a"] = 0
    end
    
    -- Reset game statistics
    Game.totalPlayTime = 0
    Game.longestSession = 0
    Game.totalBuildings = 0
    Game.totalUpgrades = 0
    
    -- Reset audio and visual settings to defaults
    AudioSettings.bgMusicEnabled = true
    AudioSettings.bgMusicVolume = 0.7
    AudioSettings.isPlaying = false
    VisualSettings.cookieShowerEnabled = true
    VisualSettings.milkAnimationEnabled = true
    
    -- Stop music if playing
    if bgMusic and AudioSettings.isPlaying then
        Sound.pause(bgMusic)
        AudioSettings.isPlaying = false
    end
    
    -- Update menu to show "Start" instead of "Continue"
    MenuState.options[1] = "Start"
    
    -- Return to title screen
    gameState = "Title"
    MenuState.selectedIndex = 1
    
    print("Game reset!")
end

-- Initialize upgrades (from Vita version)
Upgrade.make("Cursor",  1,   1,    100,           1,  1)
Upgrade.make("Cursor",  2,   1,    500,           1,  2)
Upgrade.make("Cursor",  3,   10,   10000,         1,  3)
Upgrade.make("Cursor",  4,   25,   100000,        1,  4)
Upgrade.make("Grandma", 1,   1,    1000,          2,  1)
Upgrade.make("Grandma", 2,   5,    5000,          2,  2)
Upgrade.make("Grandma", 3,   25,   50000,         2,  3)
Upgrade.make("Grandma", 4,   50,   5000000,       2,  4)
Upgrade.make("Farm",    1,   1,    11000,         4,  1)
Upgrade.make("Farm",    2,   5,    55000,         4,  2)
Upgrade.make("Farm",    3,   25,   550000,        4,  3)
Upgrade.make("Farm",    4,   50,   55000000,      4,  4)
Upgrade.make("Mine",    1,   1,    120000,        5,  1)
Upgrade.make("Mine",    2,   5,    600000,        5,  2)
Upgrade.make("Mine",    3,   25,   6000000,       5,  3)
Upgrade.make("Mine",    4,   50,   600000000,     5,  4)
Upgrade.make("Factory", 1,   1,    1300000,       6,  1)
Upgrade.make("Factory", 2,   5,    6500000,       6,  2)
Upgrade.make("Factory", 3,   25,   65000000,      6,  3)
Upgrade.make("Factory", 4,   50,   6500000000,    6,  4)
Upgrade.make("Bank",    1,   1,    14000000,      7,  1)
Upgrade.make("Bank",    2,   5,    70000000,      7,  2)
Upgrade.make("Bank",    3,   25,   700000000,     7,  3)
Upgrade.make("Bank",    4,   50,   70000000000,   7,  4)
Upgrade.make("Temple",  1,   1,    200000000,     8,  1)
Upgrade.make("Temple",  2,   5,    1000000000,    8,  2)
Upgrade.make("Temple",  3,   25,   10000000000,   8,  3)
Upgrade.make("Temple",  4,   50,   1000000000000, 8,  4)

-- SDL Input handling

-- Gamepad input helper functions for edge detection
function checkGamepadButtonPressed(button)
    if not Controls.checkGamepadButton then
        return false
    end
    
    local current = Controls.checkGamepadButton(button)
    local wasPressed = false
    
    if button == SDL_CONTROLLER_BUTTON_A then
        wasPressed = current and not gamepadState.A_prev
        gamepadState.A_prev = current
    elseif button == SDL_CONTROLLER_BUTTON_X then
        wasPressed = current and not gamepadState.X_prev
        gamepadState.X_prev = current
    elseif button == SDL_CONTROLLER_BUTTON_B then
        wasPressed = current and not gamepadState.B_prev
        gamepadState.B_prev = current
    elseif button == SDL_CONTROLLER_BUTTON_Y then
        wasPressed = current and not gamepadState.Y_prev
        gamepadState.Y_prev = current
    elseif button == SDL_CONTROLLER_BUTTON_LEFTSHOULDER then
        wasPressed = current and not gamepadState.L_prev
        gamepadState.L_prev = current
    elseif button == SDL_CONTROLLER_BUTTON_RIGHTSHOULDER then
        wasPressed = current and not gamepadState.R_prev
        gamepadState.R_prev = current
    elseif button == SDL_CONTROLLER_BUTTON_START then
        wasPressed = current and not gamepadState.Start_prev
        gamepadState.Start_prev = current
    elseif button == SDL_CONTROLLER_BUTTON_DPAD_UP then
        wasPressed = current and not gamepadState.DPadUp_prev
        gamepadState.DPadUp_prev = current
    elseif button == SDL_CONTROLLER_BUTTON_DPAD_DOWN then
        wasPressed = current and not gamepadState.DPadDown_prev
        gamepadState.DPadDown_prev = current
    elseif button == SDL_CONTROLLER_BUTTON_DPAD_LEFT then
        wasPressed = current and not gamepadState.DPadLeft_prev
        gamepadState.DPadLeft_prev = current
    elseif button == SDL_CONTROLLER_BUTTON_DPAD_RIGHT then
        wasPressed = current and not gamepadState.DPadRight_prev
        gamepadState.DPadRight_prev = current
    end
    
    return wasPressed
end

function checkGamepadButtonHeld(button)
    if not Controls.checkGamepadButton then
        return false
    end
    return Controls.checkGamepadButton(button)
end

-- Helper function to check for select/confirm button
function isSelectPressed(pad, oldpad)
    -- Check both keyboard Space and gamepad A button independently
    local keyboardPressed = Controls.check(pad, SDLK_SPACE) and not Controls.check(oldpad, SDLK_SPACE)
    local gamepadPressed = checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_A)
    return keyboardPressed or gamepadPressed
end

function handleInput(pad)
    
    -- Global exit - ESC key
    if Controls.check(pad, SDLK_ESCAPE) and not Controls.check(oldpad, SDLK_ESCAPE) then
        if gameState == "Game" then
            -- Update play time statistics before saving
            local currentTime = Timer.getTime(timer)
            local sessionTime = (currentTime - Game.sessionStart) / 1000
            Game.totalPlayTime = Game.totalPlayTime + sessionTime
            if sessionTime > Game.longestSession then
                Game.longestSession = sessionTime
            end
            saveGame()
        end
        -- Stop music before exiting the program completely
        stopBackgroundMusic()
        System.exit()
    end
    
    -- Handle input based on current game state
    if gameState == "Title" then
        handleTitleInput(pad)
    elseif gameState == "Game" then
        handleGameInput(pad)
    elseif gameState == "Controls" then
        handleControlsInput(pad)
    elseif gameState == "Settings" then
        handleSettingsInput(pad)
    elseif gameState == "Statistics" then
        handleStatisticsInput(pad)
    elseif gameState == "About" then
        handleAboutInput(pad)
    end
    
    -- oldpad will be updated in main game loop
end

-- Title screen input handling
function handleTitleInput(pad)
    -- Navigation with timing delay
    if Timer.getTime(navTimer) >= NAV_DELAY then
        -- Navigate menu options - Up/Down arrows or D-pad
        local upPressed = (Controls.check(pad, SDLK_UP) and not Controls.check(oldpad, SDLK_UP)) or
                          checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_DPAD_UP)
        if upPressed then
            MenuState.selectedIndex = MenuState.selectedIndex - 1
            if MenuState.selectedIndex < 1 then
                MenuState.selectedIndex = MenuState.optionCount
            end
            Timer.reset(navTimer)
        end
        
        local downPressed = (Controls.check(pad, SDLK_DOWN) and not Controls.check(oldpad, SDLK_DOWN)) or
                            checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_DPAD_DOWN)
        if downPressed then
            MenuState.selectedIndex = MenuState.selectedIndex + 1
            if MenuState.selectedIndex > MenuState.optionCount then
                MenuState.selectedIndex = 1
            end
            Timer.reset(navTimer)
        end
    end
    
    -- Select option with timing delay
    if Timer.getTime(buttonTimer) >= BUTTON_DELAY then
        if isSelectPressed(pad, oldpad) then
            local selectedOption = MenuState.options[MenuState.selectedIndex]
            
            if selectedOption == "Start" or selectedOption == "Continue" then
                gameState = "Game"
                -- Initialize session timer
                Game.sessionStart = Timer.getTime(timer)
            elseif selectedOption == "Settings" then
                gameState = "Settings"
            elseif selectedOption == "Controls" then
                gameState = "Controls"
            elseif selectedOption == "Statistics" then
                gameState = "Statistics"
            elseif selectedOption == "About" then
                gameState = "About"
            elseif selectedOption == "Exit" then
                System.exit()
            end
            
            Timer.reset(buttonTimer)
        end
    end
end

-- Controls screen input handling
function handleControlsInput(pad)
    if Timer.getTime(buttonTimer) >= BUTTON_DELAY then
        -- Return to title screen - Enter/A button, Backspace, or gamepad Start button
        if isSelectPressed(pad, oldpad) or
           (Controls.check(pad, SDLK_BACKSPACE) and not Controls.check(oldpad, SDLK_BACKSPACE)) or
           checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_START) then
            gameState = "Title"
            Timer.reset(buttonTimer)
        end
    end
end

-- Settings screen input handling
function handleSettingsInput(pad)
    if Timer.getTime(navTimer) >= NAV_DELAY then
        -- Navigate settings - Up/Down arrows
        if Controls.check(pad, SDLK_UP) and not Controls.check(oldpad, SDLK_UP) then
            SettingsState.selectedIndex = SettingsState.selectedIndex - 1
            if SettingsState.selectedIndex < 1 then
                SettingsState.selectedIndex = SettingsState.optionCount
            end
            Timer.reset(navTimer)
        end
        
        if Controls.check(pad, SDLK_DOWN) and not Controls.check(oldpad, SDLK_DOWN) then
            SettingsState.selectedIndex = SettingsState.selectedIndex + 1
            if SettingsState.selectedIndex > SettingsState.optionCount then
                SettingsState.selectedIndex = 1
            end
            Timer.reset(navTimer)
        end
    end
    
    if Timer.getTime(buttonTimer) >= BUTTON_DELAY then
        local selectedOption = SettingsState.options[SettingsState.selectedIndex]
        
        -- Toggle/Adjust selected option - Enter/A button/Left/Right
        if isSelectPressed(pad, oldpad) then
            if selectedOption == "Background Music" then
                toggleBackgroundMusic()
            elseif selectedOption == "Cookie Shower" then
                VisualSettings.cookieShowerEnabled = not VisualSettings.cookieShowerEnabled
            elseif selectedOption == "Milk Animation" then
                VisualSettings.milkAnimationEnabled = not VisualSettings.milkAnimationEnabled
            elseif selectedOption == "Reset Game" then
                resetGame()
            end
            Timer.reset(buttonTimer)
        end
        
        -- Adjust values - Left/Right arrows or D-pad
        local leftPressed = (Controls.check(pad, SDLK_LEFT) and not Controls.check(oldpad, SDLK_LEFT)) or
                           checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_DPAD_LEFT)
        if leftPressed then
            if selectedOption == "Music Volume" then
                AudioSettings.bgMusicVolume = math.max(0.0, AudioSettings.bgMusicVolume - 0.1)
                updateMusicVolume()
            elseif selectedOption == "Background Music" then
                toggleBackgroundMusic()
            elseif selectedOption == "Cookie Shower" then
                VisualSettings.cookieShowerEnabled = not VisualSettings.cookieShowerEnabled
            elseif selectedOption == "Milk Animation" then
                VisualSettings.milkAnimationEnabled = not VisualSettings.milkAnimationEnabled
            end
            Timer.reset(buttonTimer)
        end
        
        local rightPressed = (Controls.check(pad, SDLK_RIGHT) and not Controls.check(oldpad, SDLK_RIGHT)) or
                            checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_DPAD_RIGHT)
        if rightPressed then
            if selectedOption == "Music Volume" then
                AudioSettings.bgMusicVolume = math.min(1.0, AudioSettings.bgMusicVolume + 0.1)
                updateMusicVolume()
            elseif selectedOption == "Background Music" then
                toggleBackgroundMusic()
            elseif selectedOption == "Cookie Shower" then
                VisualSettings.cookieShowerEnabled = not VisualSettings.cookieShowerEnabled
            elseif selectedOption == "Milk Animation" then
                VisualSettings.milkAnimationEnabled = not VisualSettings.milkAnimationEnabled
            end
            Timer.reset(buttonTimer)
        end
        
        -- Return to title screen - Backspace or gamepad Start button
        if (Controls.check(pad, SDLK_BACKSPACE) and not Controls.check(oldpad, SDLK_BACKSPACE)) or
           checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_START) then
            gameState = "Title"
            Timer.reset(buttonTimer)
        end
    end
end

-- About screen input handling
function handleAboutInput(pad)
    if Timer.getTime(buttonTimer) >= BUTTON_DELAY then
        -- Return to title screen - Enter, Backspace, or gamepad Start button
        if (Controls.check(pad, SDLK_RETURN) and not Controls.check(oldpad, SDLK_RETURN)) or
           (Controls.check(pad, SDLK_BACKSPACE) and not Controls.check(oldpad, SDLK_BACKSPACE)) or
           checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_START) then
            gameState = "Title"
            Timer.reset(buttonTimer)
        end
    end
end

-- Statistics screen input handling
function handleStatisticsInput(pad)
    if Timer.getTime(buttonTimer) >= BUTTON_DELAY then
        -- Return to title screen - Enter, Backspace, or gamepad Start button
        if (Controls.check(pad, SDLK_RETURN) and not Controls.check(oldpad, SDLK_RETURN)) or
           (Controls.check(pad, SDLK_BACKSPACE) and not Controls.check(oldpad, SDLK_BACKSPACE)) or
           checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_START) then
            gameState = "Title"
            Timer.reset(buttonTimer)
        end
    end
end

-- Game input handling (original input code)
function handleGameInput(pad)
    -- Return to title screen - Backspace or gamepad Start button
    local backToMenuPressed = (Controls.check(pad, SDLK_BACKSPACE) and not Controls.check(oldpad, SDLK_BACKSPACE)) or
                              checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_START)
    if backToMenuPressed then
        -- Update play time statistics before saving
        local currentTime = Timer.getTime(timer)
        local sessionTime = (currentTime - Game.sessionStart) / 1000
        Game.totalPlayTime = Game.totalPlayTime + sessionTime
        if sessionTime > Game.longestSession then
            Game.longestSession = sessionTime
        end
        
        saveGame()
        gameState = "Title"
        -- Update menu to show "Continue" since we just saved
        MenuState.options[1] = "Continue"
        return
    end
    
    -- Cookie clicking - Check both keyboard X and gamepad X button independently
    local keyboardXPressed = Controls.check(pad, SDLK_X) and not Controls.check(oldpad, SDLK_X)
    local gamepadXPressed = checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_X)
    
    if keyboardXPressed or gamepadXPressed then
        -- Button was just pressed, increment cookie count
        local cookiesEarned = 1 * Upgrade["CursorQuan"]
        Cookie.count = Cookie.count + cookiesEarned
        Cookie.total = Cookie.total + cookiesEarned
        Cookie.clicked = Cookie.clicked + cookiesEarned
        Cookie.clickCount = Cookie.clickCount + 1
        Cookie.tmp = 1
    end
    
    -- Panel navigation with timing delay
    if Timer.getTime(navTimer) >= NAV_DELAY then
        -- Switch panels - gamepad B button or Tab key (2-panel layout: Buildings -> Store)
        local panelSwitchPressed = (Controls.check(pad, SDLK_TAB) and not Controls.check(oldpad, SDLK_TAB)) or
                                  checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_B)
        if panelSwitchPressed then
            if GamepadState.currentPanel == "Buildings" then
                GamepadState.currentPanel = "Store"
            else
                GamepadState.currentPanel = "Buildings"
            end
            GamepadState.selectedIndex = 1
            Timer.reset(navTimer)
        end
        
        -- Navigate within current panel - Arrow keys or D-pad Up/Down
        local upPressed = (Controls.check(pad, SDLK_UP) and not Controls.check(oldpad, SDLK_UP)) or
                          checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_DPAD_UP)
        if upPressed then
            if GamepadState.currentPanel == "Store" then
                GamepadState.selectedIndex = math.max(1, GamepadState.selectedIndex - 1)
            elseif GamepadState.currentPanel == "Buildings" then
                GamepadState.selectedIndex = math.max(1, GamepadState.selectedIndex - 1)
            else
                GamepadState.selectedIndex = math.max(1, GamepadState.selectedIndex - 1)
            end
            Timer.reset(navTimer)
        end
        
        local downPressed = (Controls.check(pad, SDLK_DOWN) and not Controls.check(oldpad, SDLK_DOWN)) or
                            checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_DPAD_DOWN)
        if downPressed then
            if GamepadState.currentPanel == "Store" then
                GamepadState.selectedIndex = math.min(#Button, GamepadState.selectedIndex + 1)
            elseif GamepadState.currentPanel == "Buildings" then
                -- Count owned buildings to determine scroll limit
                local ownedBuildings = 0
                for i = 1, #Button do
                    local building = Button[i]
                    if building and Button[building.."count"] > 0 then
                        ownedBuildings = ownedBuildings + 1
                    end
                end
                
                -- Calculate how many buildings fit on screen
                local headerHeight = math.floor(40 * scaleY)
                local availableHeight = screenH - headerHeight - math.floor(20 * scaleY)
                local buildingHeight = math.floor(144 * ((PANEL_LEFT_WIDTH - math.floor(10 * scaleX)) / 332))
                local buildingsOnScreen = math.floor(availableHeight / buildingHeight)
                
                -- Allow scrolling through all owned buildings with extra room
                -- Since you can see ~2.5 buildings at once, allow more scroll positions
                local maxScrollSteps = math.max(ownedBuildings, ownedBuildings + 3)  -- Always allow at least a few extra steps
                
                GamepadState.selectedIndex = math.min(maxScrollSteps, GamepadState.selectedIndex + 1)
                
            else
                GamepadState.selectedIndex = GamepadState.selectedIndex + 1
            end
            Timer.reset(navTimer)
        end
    end
    
    -- Purchase actions with timing delay
    if Timer.getTime(buttonTimer) >= BUTTON_DELAY then
        -- Purchase/Sell selected item - Check both keyboard Space and gamepad A button independently
        local keyboardSpacePressed = Controls.check(pad, SDLK_SPACE) and not Controls.check(oldpad, SDLK_SPACE)
        local gamepadAPressed = checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_A)
        local selectPressed = keyboardSpacePressed or gamepadAPressed
        if selectPressed then
            if GamepadState.currentPanel == "Store" then
                local selectedBuilding = Button[GamepadState.selectedIndex]
                if selectedBuilding then
                    if GamepadState.buyMode then
                        -- Purchase building
                        if Cookie.count >= Button[selectedBuilding.."price"] then
                            local cost = Button[selectedBuilding.."price"]
                            Cookie.count = Cookie.count - cost
                            Cookie.totalSpent = Cookie.totalSpent + cost
                            Button[selectedBuilding.."count"] = Button[selectedBuilding.."count"] + GamepadState.purchaseQuantity
                            Button[selectedBuilding.."total"] = Button[selectedBuilding.."total"] + GamepadState.purchaseQuantity
                            Button[selectedBuilding.."spent"] = Button[selectedBuilding.."spent"] + cost
                            Game.totalBuildings = Game.totalBuildings + GamepadState.purchaseQuantity
                            -- Update price with exponential scaling
                            Button[selectedBuilding.."price"] = math.floor(Button[selectedBuilding.."fprice"] * (1.15 ^ Button[selectedBuilding.."count"]))
                            -- Auto-save after purchase
                            saveGame()
                        end
                    else
                        -- Sell building
                        if Button[selectedBuilding.."count"] >= GamepadState.purchaseQuantity then
                            Button[selectedBuilding.."count"] = Button[selectedBuilding.."count"] - GamepadState.purchaseQuantity
                            -- Update price
                            Button[selectedBuilding.."price"] = math.floor(Button[selectedBuilding.."fprice"] * (1.15 ^ Button[selectedBuilding.."count"]))
                            -- Refund 50% of current price
                            local refund = math.floor(Button[selectedBuilding.."price"] * 0.5 * GamepadState.purchaseQuantity)
                            Cookie.count = Cookie.count + refund
                            -- Auto-save after selling
                            saveGame()
                        end
                    end
                end
            end
            Timer.reset(buttonTimer)
        end
        
        -- Purchase upgrade for selected building - Y button or Y key
        local upgradePressed = (Controls.check(pad, SDLK_Y) and not Controls.check(oldpad, SDLK_Y)) or
                              checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_Y)
        if upgradePressed then
            if GamepadState.currentPanel == "Store" then
                local selectedBuilding = Button[GamepadState.selectedIndex]
                if selectedBuilding then
                    print("Trying to upgrade: " .. selectedBuilding)
                    print("Available upgrades count: " .. #Upgrade.Now)
                    
                    -- Find available upgrades for this building
                    local buildingUpgrades = {}
                    for i = 1, #Upgrade.Now do
                        local upgradeName = Upgrade.Now[i]
                        print("Checking upgrade: " .. upgradeName .. " for building: " .. Upgrade[upgradeName.."name"])
                        if Upgrade[upgradeName.."name"] == selectedBuilding then
                            table.insert(buildingUpgrades, upgradeName)
                            print("Found matching upgrade: " .. upgradeName)
                        end
                    end
                    
                    print("Building upgrades found: " .. #buildingUpgrades)
                    
                    -- Purchase the first available upgrade for this building
                    if #buildingUpgrades > 0 then
                        local upgradeToBy = buildingUpgrades[1]
                        local upgradePrice = Upgrade[upgradeToBy.."price"]
                        print("Upgrade price: " .. upgradePrice .. ", Cookie count: " .. Cookie.count)
                        if Cookie.count >= upgradePrice then
                            Cookie.count = Cookie.count - upgradePrice
                            Cookie.totalSpent = Cookie.totalSpent + upgradePrice
                            Game.totalUpgrades = Game.totalUpgrades + 1
                            Upgrade[upgradeToBy.."a"] = 2  -- Mark as purchased
                            print("Upgrade purchased!")
                            -- Auto-save after upgrade purchase
                            saveGame()
                        else
                            print("Not enough cookies for upgrade")
                        end
                    else
                        print("No upgrades available for this building")
                    end
                end
            end
            Timer.reset(buttonTimer)
        end
        
        -- Toggle buy/sell mode - L button (left shoulder) or T key
        local toggleModePressed = (Controls.check(pad, SDLK_T) and not Controls.check(oldpad, SDLK_T)) or
                                 checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_LEFTSHOULDER)
        if toggleModePressed then
            GamepadState.buyMode = not GamepadState.buyMode
            Timer.reset(buttonTimer)
        end
        
        -- Cycle purchase quantity - R button (right shoulder) or R key
        local quantityPressed = (Controls.check(pad, SDLK_R) and not Controls.check(oldpad, SDLK_R)) or
                               checkGamepadButtonPressed(SDL_CONTROLLER_BUTTON_RIGHTSHOULDER)
        if quantityPressed then
            if GamepadState.purchaseQuantity == 1 then
                GamepadState.purchaseQuantity = 10
            elseif GamepadState.purchaseQuantity == 10 then
                GamepadState.purchaseQuantity = 100
            else
                GamepadState.purchaseQuantity = 1
            end
            Timer.reset(buttonTimer)
        end
    end
end

-- Panel drawing functions (2-panel layout)
function drawPanels()
    -- Draw vertical panel separator between buildings and cookie/store
    if Texture["panelVertical"] then
        local verticalW = Graphics.getImageWidth(Texture["panelVertical"]) or 8
        local verticalH = Graphics.getImageHeight(Texture["panelVertical"]) or 32
        local verticalScaleX = math.floor(8 * scaleX) / verticalW
        local verticalScaleY = screenH / verticalH
        
        Graphics.drawImageExtended(PANEL_RIGHT_X, screenH/2, 0, 0, verticalW, verticalH, 0, verticalScaleX, verticalScaleY, Texture["panelVertical"])
    end
    
    -- Draw horizontal separators in right panel (solid first, then gradients on top)
    if Texture["panelHorizontal"] then
        local solidW = Graphics.getImageWidth(Texture["panelHorizontal"]) or 32
        local solidH = Graphics.getImageHeight(Texture["panelHorizontal"]) or 8
        local solidScaleX = PANEL_RIGHT_WIDTH / solidW
        local solidScaleY = math.floor(8 * scaleY) / solidH
        
        -- Draw solid dividers first
        Graphics.drawImageExtended(PANEL_RIGHT_X + PANEL_RIGHT_WIDTH/2, COOKIE_AREA_HEIGHT + math.floor(25 * scaleY), 0, 0, solidW, solidH, 0, solidScaleX, solidScaleY, Texture["panelHorizontal"])
        local storeHeaderY = COOKIE_AREA_HEIGHT + math.floor(60 * scaleY) - 4
        Graphics.drawImageExtended(PANEL_RIGHT_X + PANEL_RIGHT_WIDTH/2, storeHeaderY, 0, 0, solidW, solidH, 0, solidScaleX, solidScaleY, Texture["panelHorizontal"])
        local upgradeBottomY = COOKIE_AREA_HEIGHT + HEADER_HEIGHT + UPGRADE_HEIGHT + math.floor(10 * scaleY) - 4
        Graphics.drawImageExtended(PANEL_RIGHT_X + PANEL_RIGHT_WIDTH/2, upgradeBottomY, 0, 0, solidW, solidH, 0, solidScaleX, solidScaleY, Texture["panelHorizontal"])
        
        -- Draw gradients on top
        local gradientW = Graphics.getImageWidth(Texture["panelGradientTop"])
        local gradientH = Graphics.getImageHeight(Texture["panelGradientTop"])
        local gradientScaleX = PANEL_RIGHT_WIDTH / gradientW
        local gradientScaleY = math.floor(8 * scaleY) / gradientH
        
        Graphics.drawImageExtended(PANEL_RIGHT_X + PANEL_RIGHT_WIDTH/2, COOKIE_AREA_HEIGHT + math.floor(25 * scaleY), 0, 0, gradientW, gradientH, 0, gradientScaleX, gradientScaleY, Texture["panelGradientTop"])
        Graphics.drawImageExtended(PANEL_RIGHT_X + PANEL_RIGHT_WIDTH/2, storeHeaderY, 0, 0, gradientW, gradientH, 0, gradientScaleX, gradientScaleY, Texture["panelGradientTop"])
        Graphics.drawImageExtended(PANEL_RIGHT_X + PANEL_RIGHT_WIDTH/2, upgradeBottomY, 0, 0, gradientW, gradientH, 0, gradientScaleX, gradientScaleY, Texture["panelGradientTop"])
    end
    
    -- Draw background overlay over buildings header area to mask scrolling buildings
    if Texture["Background"] then
        local headerMaskHeight = math.floor(30 * scaleY)  -- Height of header area to mask
        local bgW = Graphics.getImageWidth(Texture["Background"]) or 960
        local bgH = Graphics.getImageHeight(Texture["Background"]) or 544
        
        -- Use left portion of background that corresponds to left panel
        local srcX = 0
        local srcY = 0
        local srcW = (PANEL_LEFT_WIDTH / screenW) * bgW
        local srcH = (headerMaskHeight / screenH) * bgH
        
        -- Draw background section over header area
        Graphics.drawImageExtended(PANEL_LEFT_WIDTH/2, headerMaskHeight/2, 
                                 srcX, srcY, srcW, srcH, 0, 
                                 PANEL_LEFT_WIDTH/srcW, headerMaskHeight/srcH, Texture["Background"])
    end
    
    -- Draw dark overlay filter over buildings header area
    if Texture["Darkback"] then
        local headerMaskHeight = math.floor(30 * scaleY)  -- Height of header area to mask
        local darkW = Graphics.getImageWidth(Texture["Darkback"]) or 960
        local darkH = Graphics.getImageHeight(Texture["Darkback"]) or 544
        
        -- Use left portion of darkback that corresponds to left panel
        local srcX = 0
        local srcY = 0
        local srcW = (PANEL_LEFT_WIDTH / screenW) * darkW
        local srcH = (headerMaskHeight / screenH) * darkH
        
        -- Draw darkback section over header area
        Graphics.drawImageExtended(PANEL_LEFT_WIDTH/2, headerMaskHeight/2, 
                                 srcX, srcY, srcW, srcH, 0, 
                                 PANEL_LEFT_WIDTH/srcW, headerMaskHeight/srcH, Texture["Darkback"])
    end
    
    -- Draw panel headers (after background overlay so they appear on top)
    drawText(PANEL_LEFT_X + math.floor(10 * scaleX), math.floor(5 * scaleY) - 3, "BUILDINGS", white)
    -- Draw panel indicator to the right of BUILDINGS header
    drawText(PANEL_LEFT_X + math.floor(120 * scaleX), math.floor(5 * scaleY) - 3, "PANEL: " .. GamepadState.currentPanel, white)
    
    -- Draw horizontal divider below BUILDINGS header (solid first, then gradient on top)
    if Texture["panelHorizontal"] then
        local horizontalY = math.floor(25 * scaleY) + 1  -- Position below header text, lowered by 1 pixel
        
        -- Draw solid divider first
        local solidW = Graphics.getImageWidth(Texture["panelHorizontal"]) or 1
        local solidH = Graphics.getImageHeight(Texture["panelHorizontal"]) or 1
        local solidScaleX = PANEL_LEFT_WIDTH / solidW
        local solidScaleY = math.floor(8 * scaleY) / solidH
        Graphics.drawImageExtended(PANEL_LEFT_X + PANEL_LEFT_WIDTH/2, horizontalY, 0, 0, solidW, solidH, 0, solidScaleX, solidScaleY, Texture["panelHorizontal"])
        
        -- Draw gradient on top
        local gradientW = Graphics.getImageWidth(Texture["panelGradientTop"])
        local gradientH = Graphics.getImageHeight(Texture["panelGradientTop"])
        local gradientScaleX = PANEL_LEFT_WIDTH / gradientW
        local gradientScaleY = math.floor(8 * scaleY) / gradientH
        Graphics.drawImageExtended(PANEL_LEFT_X + PANEL_LEFT_WIDTH/2, horizontalY, 0, 0, gradientW, gradientH, 0, gradientScaleX, gradientScaleY, Texture["panelGradientTop"])
    end
    
    -- Draw store header with buy/sell mode and quantity
    drawText(PANEL_RIGHT_X + math.floor(10 * scaleX), COOKIE_AREA_HEIGHT + math.floor(35 * scaleY) - 3, "STORE", white)
    local modeText = GamepadState.buyMode and "BUY" or "SELL"
    local modeColor = GamepadState.buyMode and green or red
    drawText(PANEL_RIGHT_X + math.floor(80 * scaleX), COOKIE_AREA_HEIGHT + math.floor(35 * scaleY) - 3, modeText, modeColor)
    
    -- Draw quantity selector (1  10  100)
    local quantityX = PANEL_RIGHT_X + math.floor(130 * scaleX)
    local quantityY = COOKIE_AREA_HEIGHT + math.floor(35 * scaleY) - 3
    local darkGray = Color.new(50, 50, 50)
    
    -- Draw "1" quantity
    local color1 = GamepadState.purchaseQuantity == 1 and white or darkGray
    drawText(quantityX, quantityY, "1", color1)
    
    -- Draw "10" quantity (with 2 spaces between)
    local color10 = GamepadState.purchaseQuantity == 10 and white or darkGray
    drawText(quantityX + math.floor(24 * scaleX), quantityY, "10", color10)
    
    -- Draw "100" quantity (with 2 spaces between)
    local color100 = GamepadState.purchaseQuantity == 100 and white or darkGray
    drawText(quantityX + math.floor(56 * scaleX), quantityY, "100", color100)
end

function drawBuildings()
    -- Start buildings at a good visible position
    local firstBuildingY = -20  -- Start higher, closer to header area
    
    -- Calculate actual scaled building height from the BLDBacks scaling
    local backW = Graphics.getImageWidth(Texture["BLDBacks"]) or 332
    local backH = 144  -- Each slice is 144px tall
    local frameWidth = PANEL_LEFT_WIDTH - math.floor(10 * scaleX)
    local scaleWidth = frameWidth / backW
    local scaleHeight = scaleWidth  -- We use uniform scaling
    local actualBuildingHeight = math.floor(backH * scaleHeight)
    
    -- Always apply a base offset to position buildings better, plus scrolling when in Buildings panel
    local buildingScrollOffset = -110  -- Negative offset to move buildings UP (base position, raised by 10px total)
    
    if GamepadState.currentPanel == "Buildings" then
        -- Calculate how many buildings we own
        local ownedBuildings = 0
        for i = 1, #Button do
            if Button[Button[i].."count"] > 0 then
                ownedBuildings = ownedBuildings + 1
            end
        end
        
        -- Calculate how many buildings can fit on screen
        local headerHeight = math.floor(40 * scaleY)  -- Buildings header space
        local availableHeight = screenH - headerHeight - math.floor(20 * scaleY)  -- Screen minus header and padding
        local buildingsOnScreen = math.floor(availableHeight / actualBuildingHeight)
        
        -- Always scroll based on selectedIndex, but use smaller increments
        -- This allows better visibility of buildings since you can see ~2.5 buildings at once
        local scrollIncrement = actualBuildingHeight * 0.6  -- Scroll by 60% of building height per step
        local scrollAmount = (GamepadState.selectedIndex - 1) * scrollIncrement
        buildingScrollOffset = -110 - scrollAmount  -- Subtract to scroll UP when selecting down
        
        -- Calculate maximum scroll to keep last building fully visible
        local lastBuildingY = (#Button - 1) * actualBuildingHeight  -- Position of last building
        local targetBottomY = screenH - math.floor(20 * scaleY)  -- Bottom of visible area
        local headerOffset = math.floor(40 * scaleY)  -- Buildings header space
        local maxNeededScroll = lastBuildingY + actualBuildingHeight - (targetBottomY - headerOffset)
        local maxScrollOffset = -110 - maxNeededScroll
        
        -- Don't scroll past the point where last building is fully visible
        if buildingScrollOffset < maxScrollOffset then
            buildingScrollOffset = maxScrollOffset
        end
        
    end
    
    for i = 1, #Button do
        local building = Button[i]
        if building then
            -- Each building starts at the bottom of the previous building
            local y = firstBuildingY + (i - 1) * actualBuildingHeight + buildingScrollOffset
            
            -- Only draw if visible in left panel
            if y > -100 and y < screenH then
                local x = PANEL_LEFT_X + math.floor(5 * scaleX)
                local frameWidth = PANEL_LEFT_WIDTH - math.floor(10 * scaleX)
                local frameHeight = actualBuildingHeight  -- Match the actual scaled building height
                
                -- Only draw building backgrounds if owned (Cursor has no background)
                if Texture["BLDBacks"] and Button[building.."count"] > 0 then
                    local buildingId = Button[building.."id"] or 1
                    
                    -- Use Vita formula: (id - 2) - Cursor (ID 1) has no background
                    if buildingId >= 2 then
                        local backSliceY = (buildingId - 2) * 144  -- Each building back is 144px tall
                        
                        -- Scale more like Vita version - preserve aspect ratio better
                        local backW = Graphics.getImageWidth(Texture["BLDBacks"]) or 332
                        local backH = 144  -- Each slice is 144px tall
                        -- Scale to fit width, let height be natural
                        local scale = frameWidth / backW
                        local scaleWidth = scale
                        local scaleHeight = scale
                        
                        Graphics.drawImageExtended(x + frameWidth/2, y + frameHeight/2 - 1, 
                            0, backSliceY, backW, backH, 0, scaleWidth * 1.006, scaleHeight, Texture["BLDBacks"])
                        
                        -- Draw BLDIcons on top of background
                        if Texture["BLDIcons"] then
                            local iconSliceX = 64 * (buildingId - 2) + 1  -- Add 1 pixel offset to avoid left border
                            local buildingCount = Button[building.."count"]
                            
                            -- Icon display with multiple rows
                            local maxIconsPerRow = math.floor(frameWidth / (25 * scale))  -- Calculate how many fit horizontally
                            local maxRows = 2  -- Support up to 2 rows
                            local maxIconsTotal = maxIconsPerRow * maxRows
                            local iconsToShow = math.min(buildingCount, maxIconsTotal)
                            local iconScale = scale * 1.0
                            local iconSpacing = math.floor(25 * scale)
                            local rowSpacing = math.floor(30 * scale)  -- Vertical spacing between rows
                            
                            for iconNum = 1, iconsToShow do
                                -- Calculate row and column for this icon
                                local row = math.floor((iconNum - 1) / maxIconsPerRow)
                                local col = (iconNum - 1) % maxIconsPerRow
                                
                                local iconX = x + math.floor(30 * scaleX) + col * iconSpacing
                                local iconY = y + math.floor(60 * scaleY) + row * rowSpacing
                                
                                -- Only draw icon if it fits within the background frame boundaries
                                local iconSize = 62 * iconScale
                                if iconX + iconSize/2 <= x + frameWidth then
                                    Graphics.drawImageExtended(iconX, iconY, iconSliceX, 0, 62, 64, 0, iconScale, iconScale, Texture["BLDIcons"])
                                end
                            end
                        end
                    end
                end
                
                -- Buildings panel shows only visual backgrounds, no selection overlay
            end
        end
    end
end

function drawCookie()
    if Texture["Cookie"] then
        local cookieX = CENTER_OF_COOKIE_X
        local cookieY = CENTER_OF_COOKIE_Y
        
        -- Use smaller cookie size to make room for upgrades
        local cookieScale = 0.45  -- Even smaller to fit upgrades
        
        -- Add click animation
        if Cookie.tmp > 0 then
            cookieScale = cookieScale * 1.2
        end
        
        -- Draw shine effect first (behind cookie)
        if Texture["Shine"] then
            local shineScale = cookieScale * 0.8  -- Shine scale relative to cookie
            
            -- Get shine image dimensions
            local shineW = Graphics.getImageWidth(Texture["Shine"]) or 128
            local shineH = Graphics.getImageHeight(Texture["Shine"]) or 128
            
            -- Draw rotating shine effects
            Graphics.drawImageExtended(cookieX, cookieY, 0, 0, shineW, shineH, Shine.rot, shineScale, shineScale, Texture["Shine"])
            Graphics.drawImageExtended(cookieX, cookieY, 0, 0, shineW, shineH, -Shine.rot, shineScale, shineScale, Texture["Shine"])
        end
        
        -- Draw cookie on top
        local cookieW = Graphics.getImageWidth(Texture["Cookie"]) or 128
        local cookieH = Graphics.getImageHeight(Texture["Cookie"]) or 128
        Graphics.drawImageExtended(cookieX, cookieY, 0, 0, cookieW, cookieH, 0, cookieScale, cookieScale, Texture["Cookie"])
        
        -- Draw rotating cursors around the cookie
        drawCursors(cookieX, cookieY, cookieScale)
        
        -- Decay click effect
        if Cookie.tmp > 0 then
            Cookie.tmp = Cookie.tmp - 0.25
            if Cookie.tmp < 0 then Cookie.tmp = 0 end
        end
    end
end

function drawMilk()
    -- Only draw if milk animation is enabled
    if not VisualSettings.milkAnimationEnabled then
        return
    end
    
    -- Draw milk animation exactly like Vita version (simple horizontal scrolling)
    if Texture["Milk"] then
        local milkHeight = math.floor(25 * scaleY)  -- Height of milk animation
        local milkY = COOKIE_AREA_HEIGHT + math.floor(15 * scaleY)  -- Position lower in store area
        local milkW = Graphics.getImageWidth(Texture["Milk"]) or 480
        local milkH = Graphics.getImageHeight(Texture["Milk"]) or 80
        
        -- Scale milk to fit right panel width
        local milkScaleX = PANEL_RIGHT_WIDTH / milkW
        local milkScaleY = milkHeight / milkH
        
        -- Simple left-to-right scrolling like Vita version
        local scaledMilkWidth = milkW * milkScaleX
        
        -- Draw two milk images for seamless looping (like original Vita code)
        Graphics.drawImageExtended(PANEL_RIGHT_X + Milk.x + scaledMilkWidth/2, milkY, 0, 0, milkW, milkH, 0, milkScaleX, milkScaleY, Texture["Milk"])
        Graphics.drawImageExtended(PANEL_RIGHT_X + Milk.x - scaledMilkWidth + scaledMilkWidth/2, milkY, 0, 0, milkW, milkH, 0, milkScaleX, milkScaleY, Texture["Milk"])
        
        -- Update position and loop when needed (like Vita version)
        if Milk.x >= scaledMilkWidth then
            Milk.x = Milk.x - scaledMilkWidth
        end
        Milk.x = Milk.x + Milk.speed
    end
end

function drawCookieShower()
    -- Only draw if cookie shower is enabled
    if not VisualSettings.cookieShowerEnabled then
        return
    end
    
    -- Draw cookie shower animation in right panel (cookie section) only
    if Texture["CookieShower1"] then
        -- Calculate current CPS to determine shower intensity
        local cps = 0
        for i = 1, #Button do
            local building = Button[i]
            if building then
                local quan = Upgrade[building.."Quan"] or 1
                cps = cps + Button[building.."count"] * Button[building.."cps"] * quan
            end
        end
        
        -- Determine which shower to show based on CPS (like Vita version)
        local showerType = 0
        if cps >= 200 and cps < 500 then
            showerType = 1
        elseif cps >= 500 and cps < 1000 then
            showerType = 2
        elseif cps >= 1000 then
            showerType = 3
        end
        
        -- Only draw if we have enough CPS
        if showerType > 0 then
            local showerTexture = Texture["CookieShower"..showerType]
            local showerW = Graphics.getImageWidth(showerTexture) or 300
            local showerH = Graphics.getImageHeight(showerTexture) or 544
            
            -- Scale shower to fit right panel width while maintaining aspect ratio
            local showerScale = PANEL_RIGHT_WIDTH / showerW  -- Use same scale for both X and Y
            local scaledShowerHeight = showerH * showerScale
            
            -- Position shower in center of right panel
            local showerX = PANEL_RIGHT_X + PANEL_RIGHT_WIDTH/2
            
            -- Simple vertical scrolling like Vita version - just two images, only draw if in cookie area
            local img1Y = Cookie.shower.y
            local img2Y = Cookie.shower.y - scaledShowerHeight
            
            -- Simple vertical scrolling like Vita version - just two images
            Graphics.drawImageExtended(showerX, img1Y, 0, 0, showerW, showerH, 0, showerScale, showerScale, showerTexture)
            Graphics.drawImageExtended(showerX, img2Y, 0, 0, showerW, showerH, 0, showerScale, showerScale, showerTexture)
            
            -- Update animation position (pure vertical movement)
            Cookie.shower.y = Cookie.shower.y + Cookie.shower.speed
            if Cookie.shower.y >= scaledShowerHeight then
                Cookie.shower.y = Cookie.shower.y - scaledShowerHeight
            end
        end
    end
end

function drawBuildingsBackground()
    -- Draw background overlay over buildings section to mask milk animation
    if Texture["Background"] then
        local buildingsY = 0
        local buildingsHeight = screenH
        
        -- Calculate which part of background.png to use for buildings area
        local bgW = Graphics.getImageWidth(Texture["Background"]) or 960
        local bgH = Graphics.getImageHeight(Texture["Background"]) or 544
        
        -- Use left portion of background that corresponds to left panel
        local srcX = 0
        local srcY = 0
        local srcW = (PANEL_LEFT_WIDTH / screenW) * bgW
        local srcH = bgH
        
        -- Draw background section over buildings area
        Graphics.drawImageExtended(PANEL_LEFT_WIDTH/2, screenH/2, 
                                 srcX, srcY, srcW, srcH, 0, 
                                 PANEL_LEFT_WIDTH/srcW, screenH/srcH, Texture["Background"])
    end
end

function drawStoreBackground()
    -- Draw background overlay over store section to mask cookie shower (start at store header)
    if Texture["Background"] then
        local storeY = COOKIE_AREA_HEIGHT + HEADER_HEIGHT - math.floor(2 * scaleY)  -- Start slightly higher
        local storeHeight = screenH - storeY
        
        -- Calculate which part of background.png to use for store area
        local bgW = Graphics.getImageWidth(Texture["Background"]) or 960
        local bgH = Graphics.getImageHeight(Texture["Background"]) or 544
        
        -- Use right portion of background that corresponds to right panel
        local srcX = (PANEL_RIGHT_X / screenW) * bgW
        local srcY = (storeY / screenH) * bgH
        local srcW = (PANEL_RIGHT_WIDTH / screenW) * bgW
        local srcH = (storeHeight / screenH) * bgH
        
        -- Draw background section over store area
        Graphics.drawImageExtended(PANEL_RIGHT_X + PANEL_RIGHT_WIDTH/2, storeY + storeHeight/2, 
                                 srcX, srcY, srcW, srcH, 0, 
                                 PANEL_RIGHT_WIDTH/srcW, storeHeight/srcH, Texture["Background"])
    end
    
    -- Draw dark overlay filter over store section
    if Texture["Darkback"] then
        local storeY = COOKIE_AREA_HEIGHT + HEADER_HEIGHT - math.floor(2 * scaleY)  -- Start slightly higher
        local storeHeight = screenH - storeY
        
        -- Calculate which part of darkback.png to use for store area
        local darkW = Graphics.getImageWidth(Texture["Darkback"]) or 960
        local darkH = Graphics.getImageHeight(Texture["Darkback"]) or 544
        
        -- Use right portion of darkback that corresponds to right panel
        local srcX = (PANEL_RIGHT_X / screenW) * darkW
        local srcY = (storeY / screenH) * darkH
        local srcW = (PANEL_RIGHT_WIDTH / screenW) * darkW
        local srcH = (storeHeight / screenH) * darkH
        
        -- Draw darkback section over store area
        Graphics.drawImageExtended(PANEL_RIGHT_X + PANEL_RIGHT_WIDTH/2, storeY + storeHeight/2, 
                                 srcX, srcY, srcW, srcH, 0, 
                                 PANEL_RIGHT_WIDTH/srcW, storeHeight/srcH, Texture["Darkback"])
    end
end

function drawStore()
    local itemHeight = math.floor(50 * scaleY)  -- Remove gaps between buttons
    local startY = COOKIE_AREA_HEIGHT + HEADER_HEIGHT + UPGRADE_HEIGHT + math.floor(10 * scaleY)  -- Start right after the horizontal divider
    
    -- Simple scrolling like 3DS version
    local scrollOffset = 0
    if GamepadState.currentPanel == "Store" and GamepadState.selectedIndex > 3 then
        -- Start scrolling after the 3rd item to keep them in view
        scrollOffset = -(GamepadState.selectedIndex - 3) * itemHeight
    end
    
    for i = 1, #Button do
        local building = Button[i]
        if building then
            local y = startY + (i - 1) * itemHeight + scrollOffset
            
            -- Only draw if visible in store area of right panel (below upgrade area)
            local minVisibleY = COOKIE_AREA_HEIGHT + HEADER_HEIGHT + UPGRADE_HEIGHT + math.floor(5 * scaleY)
            if y > minVisibleY and y < screenH then
                local x = PANEL_RIGHT_X  -- Start at panel edge (no left gap)
                local frameWidth = PANEL_RIGHT_WIDTH  -- Full width to panel edge (no right gap)
                local frameHeight = itemHeight  -- Match item height exactly for no gaps
                
                -- Draw storeTile.jpg background
                if Texture["StoreTile"] then
                    local tileW = Graphics.getImageWidth(Texture["StoreTile"]) or 64
                    local tileH = Graphics.getImageHeight(Texture["StoreTile"]) or 64
                    local scaleWidth = frameWidth / tileW
                    local scaleHeight = frameHeight / tileH
                    Graphics.drawImageExtended(x + frameWidth/2, y + frameHeight/2, 0, 0, tileW, tileH, 0, scaleWidth, scaleHeight, Texture["StoreTile"])
                else
                    -- Fallback: draw a solid rectangle if StoreTile is missing
                    Graphics.fillRect(x, x + frameWidth, y, y + frameHeight, Color.new(100, 100, 100))
                end
                
                -- Apply pressed tile overlay to non-selected items for inset effect
                if GamepadState.currentPanel == "Store" and GamepadState.selectedIndex ~= i then
                    if Texture["PressedTile"] then
                        local pressedW = Graphics.getImageWidth(Texture["PressedTile"]) or 64
                        local pressedH = Graphics.getImageHeight(Texture["PressedTile"]) or 64
                        local pressedScaleX = frameWidth / pressedW
                        local pressedScaleY = frameHeight / pressedH
                        Graphics.drawImageExtended(x + frameWidth/2, y + frameHeight/2, 0, 0, pressedW, pressedH, 0, pressedScaleX, pressedScaleY, Texture["PressedTile"])
                    end
                end
                
                -- Draw building icon from buildings.png (using Vita formula)
                if Texture["Buildings"] then
                    local buildingId = Button[building.."id"] or 1
                    
                    -- Unlocked if you own at least one of this building
                    local isUnlocked = Button[building.."count"] > 0
                    local iconSliceX = isUnlocked and 0 or 64  -- X=0 for unlocked, X=64 for locked
                    local iconSliceY = 64 * (buildingId - 1)  -- Row based on building ID
                    
                    local iconSize = math.floor(40 * scale)  -- Bigger icon size
                    local iconX = x + math.floor(25 * scaleX)  -- Move icon slightly more right
                    local iconY = y + frameHeight/2
                    
                    Graphics.drawImageExtended(iconX, iconY, iconSliceX + 1, iconSliceY, 62, 64, 0, iconSize/62, iconSize/64, Texture["Buildings"])
                end
                
                -- Draw building name (to the right of icon)
                local textX = x + math.floor(55 * scaleX)  -- Move text closer to icon
                drawText(textX, y + 5, building, white)
                
                -- Draw favicon cookie + cost below name
                if Texture["Favicon"] then
                    local cookieIconSize = math.floor(12 * scale)
                    local cookieX = textX
                    local cookieY = y + math.floor(35 * scaleY)  -- Move favicon even lower
                    
                    Graphics.drawImageExtended(cookieX, cookieY, 0, 0, 16, 16, 0, cookieIconSize/16, cookieIconSize/16, Texture["Favicon"])
                    
                    -- Draw cost next to cookie icon with smaller font
                    local price = Button[building.."price"]
                    local priceColor = Cookie.count >= price and green or red
                    drawSmallText(cookieX + cookieIconSize + 3, cookieY - 10, formatCookieCount(price), priceColor)
                end
                
                -- Draw count on far right
                local ownCount = Button[building.."count"]
                local countX = x + frameWidth - math.floor(30 * scaleX)
                drawText(countX, y + frameHeight/2 - 5, tostring(ownCount), yellow)
            end
        end
    end
end

function drawCursors(cookieX, cookieY, cookieScale)
    -- Draw cursors rotating around the cookie
    local cursorCount = Button["Cursorcount"] or 0
    if cursorCount > 0 then
        local pi = 3.14159
        
        -- Find the highest cursor upgrade the player owns
        local highestCursorUpgrade = 0  -- 0 = no upgrades, use basic cursor
        for i = 4, 1, -1 do  -- Check from highest to lowest upgrade
            local upgradeName = "Cursor" .. i
            if Upgrade[upgradeName.."a"] == 2 then  -- Status 2 = purchased
                highestCursorUpgrade = i
                break
            end
        end
        
        -- Calculate radius to position cursors around the cookie
        local cookieVisualRadius = 64 * cookieScale  -- Actual visual radius of the cookie
        local cursorSize = 32 * scale  -- Approximate cursor size
        local cursorDistance = math.floor(40 * scale)   -- Closer positioning
        local radius = cookieVisualRadius + cursorDistance
        
        -- Draw up to 8 cursors around the cookie
        local cursorsToShow = math.min(cursorCount, 8)
        
        for i = 1, cursorsToShow do
            local angle = Cursor.rot + (pi * 2 * i / cursorsToShow)
            local x = cookieX + math.cos(angle) * radius
            local y = cookieY + math.sin(angle) * radius
            
            -- Rotate cursor to point toward the center of the cookie
            local rotationAngle = angle + pi + pi/2
            
            if highestCursorUpgrade == 0 and Texture["Cursor"] then
                -- Use basic cursor from cursor.png (first sprite at bottom)
                local cursorW = Graphics.getImageWidth(Texture["Cursor"]) or 32
                local cursorH = Graphics.getImageHeight(Texture["Cursor"]) or 128
                
                -- Adjust cropping to include the full cursor with fingertip
                -- Use the full width and adjust height to capture complete cursor
                local spriteHeight = math.min(cursorW * 1.2, cursorH)  -- Slightly taller to include fingertip
                local sourceY = math.max(0, cursorH - spriteHeight)  -- Start from bottom, but ensure we don't go negative
                
                local cursorScale = math.max(0.3, math.min(1.0, scale * 0.8))
                Graphics.drawImageExtended(x, y, 0, sourceY, cursorW, spriteHeight, rotationAngle, cursorScale, cursorScale, Texture["Cursor"])
                
            elseif highestCursorUpgrade > 0 and Texture["Icons"] then
                -- Use upgraded cursor from icons.png
                local iconColumn = 1
                local iconRow = highestCursorUpgrade
                local iconX = (iconColumn - 1) * 48
                local iconY = (iconRow - 1) * 48
                
                local cursorIconScale = math.max(0.25, math.min(0.6, scale * 0.5))
                Graphics.drawImageExtended(x, y, iconX, iconY, 48, 48, rotationAngle, cursorIconScale, cursorIconScale, Texture["Icons"])
            end
        end
    end
end

function drawUpgrades()
    -- Only show upgrades when in Store panel
    if GamepadState.currentPanel ~= "Store" then
        return
    end
    
    -- Get currently selected building
    local selectedBuilding = Button[GamepadState.selectedIndex]
    if not selectedBuilding then
        return
    end
    
    -- Draw upgrade area slightly above center between the two horizontal dividers
    local upgradeAreaTop = COOKIE_AREA_HEIGHT + HEADER_HEIGHT
    local upgradeAreaBottom = COOKIE_AREA_HEIGHT + HEADER_HEIGHT + UPGRADE_HEIGHT
    local upgradeY = upgradeAreaTop + (upgradeAreaBottom - upgradeAreaTop) * 0.48 + math.floor(2 * scaleY) - 4
    local upgradeX = PANEL_RIGHT_X + math.floor(6 * scaleX)
    
    -- Show all 4 upgrade slots for the selected building
    for i = 1, 4 do
        local upgradeName = selectedBuilding .. i
        local frameX = upgradeX + (i - 1) * math.floor(42 * scaleX)
        local frameSize = math.floor(40 * scale)
        
        -- Check if this upgrade exists and process it
        if Upgrade[upgradeName.."price"] then
            -- Check upgrade status
            local upgradeStatus = Upgrade[upgradeName.."a"] or 0
            local upgradePrice = Upgrade[upgradeName.."price"]
            local upgradeCount = Upgrade[upgradeName.."count"]  -- Required building count
            local currentBuildingCount = Button[selectedBuilding.."count"]
            
            -- Only show upgrade if player has enough buildings to unlock it
            if currentBuildingCount >= upgradeCount then
                -- Draw upgrade frame based on status
                if Texture["UpgradeFrame"] then
                    local frameSliceX = 0
                    
                    if upgradeStatus == 2 then
                        -- Already purchased - show special frame or darkened version
                        frameSliceX = 120  -- Assuming there's a third frame for purchased upgrades
                        -- If no third frame exists, use the affordable frame but we'll darken it
                        if frameSliceX > Graphics.getImageWidth(Texture["UpgradeFrame"]) then
                            frameSliceX = 0
                        end
                    elseif Cookie.count >= upgradePrice then
                        frameSliceX = 0  -- Left slice = affordable
                    else
                        frameSliceX = 60  -- Right slice = unaffordable
                    end
                    
                    Graphics.drawImageExtended(frameX + frameSize/2, upgradeY + frameSize/2, 
                        frameSliceX, 0, 60, 60, 0, frameSize/60, frameSize/60, Texture["UpgradeFrame"])
                    
                    -- Darken purchased upgrades
                    if upgradeStatus == 2 then
                        Graphics.fillRect(frameX, frameX + frameSize, upgradeY, upgradeY + frameSize, Color.new(0, 0, 0, 128))
                    end
                    
                    -- Draw upgrade icon from icons.png
                    if Texture["Icons"] then
                        local iconColumn = Upgrade[upgradeName.."column"] or 1
                        local iconRow = Upgrade[upgradeName.."row"] or 1
                        local iconX = (iconColumn - 1) * 48
                        local iconY = (iconRow - 1) * 48
                        local iconSize = math.floor(32 * scale)
                        
                        Graphics.drawImageExtended(frameX + frameSize/2, upgradeY + frameSize/2, 
                            iconX, iconY, 48, 48, 0, iconSize/48, iconSize/48, Texture["Icons"])
                        
                        -- Show price for available upgrades (not purchased)
                        if upgradeStatus ~= 2 then
                            local priceText = formatNumber(upgradePrice)
                            local priceColor = Cookie.count >= upgradePrice and green or red
                            local textY = upgradeY + frameSize - math.floor(15 * scaleY)
                            Font.print(smallFont, frameX + math.floor(2 * scaleX), textY, priceText, priceColor)
                        end
                    end
                end
            else
                -- Not unlocked yet - show empty frame or lock icon
                if Texture["UpgradeFrame"] then
                    -- Draw a darkened frame
                    Graphics.drawImageExtended(frameX + frameSize/2, upgradeY + frameSize/2, 
                        60, 0, 60, 60, 0, frameSize/60, frameSize/60, Texture["UpgradeFrame"])
                    Graphics.fillRect(frameX, frameX + frameSize, upgradeY, upgradeY + frameSize, Color.new(0, 0, 0, 180))
                    
                    -- Show lock symbol or required count
                    local lockText = tostring(upgradeCount)
                    drawSmallText(frameX + frameSize/2 - 6, upgradeY + frameSize/2 - 6, lockText, white)
                end
            end
        end
    end
end

-- Title Screen drawing
function drawTitleScreen()
    -- Draw background if available
    if Texture["Background"] then
        Graphics.drawImageExtended(screenW/2, screenH/2, 0, 0, 960, 544, 0, scaleX, scaleY, Texture["Background"])
    end
    
    
    -- Draw "Cookie Clicker" title
    local titleY = math.floor(40 * scaleY)
    local titleText = "COOKIE CLICKER"
    local titleX = screenW/2 - 140  -- Adjusted for larger font
    drawTitleText(titleX, titleY, titleText, white)
    
    -- Draw version in bottom right corner
    drawSmallText(screenW - 80, screenH - 25, version, white)
    
    -- Draw cookie image
    if Texture["Cookie"] then
        local cookieScale = 0.6  -- Smaller cookie size
        local cookieX = screenW/2
        local cookieY = screenH/2 - math.floor(50 * scaleY)  -- Center it better, move up slightly
        
        -- Get actual image dimensions
        local cookieW = Graphics.getImageWidth(Texture["Cookie"]) or 128
        local cookieH = Graphics.getImageHeight(Texture["Cookie"]) or 128
        
        -- Draw shine effect behind cookie
        if Texture["Shine"] then
            local shineW = Graphics.getImageWidth(Texture["Shine"]) or 128
            local shineH = Graphics.getImageHeight(Texture["Shine"]) or 128
            local shineScale = cookieScale * 0.8
            Graphics.drawImageExtended(cookieX, cookieY, 0, 0, shineW, shineH, Shine.rot, shineScale, shineScale, Texture["Shine"])
            Graphics.drawImageExtended(cookieX, cookieY, 0, 0, shineW, shineH, -Shine.rot, shineScale, shineScale, Texture["Shine"])
        end
        
        Graphics.drawImageExtended(cookieX, cookieY, 0, 0, cookieW, cookieH, 0, cookieScale, cookieScale, Texture["Cookie"])
    end
    
    -- Draw menu options
    local menuStartY = screenH/2 + math.floor(80 * scaleY)  -- Position below the cookie
    local menuSpacing = math.floor(25 * scaleY)  -- Reduced spacing between menu items
    
    for i = 1, MenuState.optionCount do
        local option = MenuState.options[i]
        local y = menuStartY + (i - 1) * menuSpacing
        local darkGray = Color.new(50, 50, 50)
        local color = darkGray
        
        -- Calculate text width (approximate based on character count)
        local textWidth = string.len(option) * 8  -- Approximate character width
        local textX = screenW/2 - textWidth/2
        
        -- Highlight selected option
        if i == MenuState.selectedIndex then
            color = white
            -- Draw selection indicator centered to the left of text
            drawText(textX - 25, y, ">", white)
        end
        
        drawText(textX, y, option, color)
    end
    
end

-- Controls Screen drawing
function drawControlsScreen()
    -- Draw background
    if Texture["Background"] then
        Graphics.drawImageExtended(screenW/2, screenH/2, 0, 0, 960, 544, 0, scaleX, scaleY, Texture["Background"])
    end
    
    -- Draw title
    drawText(screenW/2 - 50, math.floor(30 * scaleY), "CONTROLS", white)
    
    -- Draw controls list
    local startY = math.floor(70 * scaleY)
    local lineHeight = math.floor(22 * scaleY)
    local currentY = startY
    
    -- Combined controls showing keyboard/gamepad for each action
    local controls = {
        {"SPACE/A Button", "Enter/Action"},
        {"X/X Button", "Click Cookie"},
        {"TAB/B Button", "Switch Panel (Buildings/Store)"},
        {"UP/DOWN/D-Pad UP/DOWN", "Navigate Items"},
        {"LEFT/RIGHT/D-Pad LEFT/RIGHT", "Navigate Horizontally"},
        {"ENTER/A Button", "Confirm/Purchase"},
        {"T/L Button", "Toggle Buy/Sell Mode"},
        {"R/R Button", "Change Quantity (1/10/100)"},
        {"Y/Y Button", "Buy Upgrade"},
        {"BACKSPACE/Start", "Return to Menu"},
        {"ESC", "Exit Game"}
    }
    
    for i, control in ipairs(controls) do
        local keys = control[1]
        local description = control[2]
        
        drawText(math.floor(50 * scaleX), currentY, keys, green)
        drawText(math.floor(320 * scaleX), currentY, description, white)
        currentY = currentY + lineHeight
    end
    
    -- Draw instructions
    drawText(math.floor(10 * scaleX), screenH - math.floor(20 * scaleY), "ENTER or BACKSPACE: Return to Menu", gray)
end

-- Settings Screen drawing
function drawSettingsScreen()
    -- Draw background
    if Texture["Background"] then
        Graphics.drawImageExtended(screenW/2, screenH/2, 0, 0, 960, 544, 0, scaleX, scaleY, Texture["Background"])
    end
    
    -- Draw title
    drawText(screenW/2 - 50, math.floor(30 * scaleY), "SETTINGS", white)
    
    -- Settings menu with navigation
    local startY = math.floor(120 * scaleY)
    local lineHeight = math.floor(40 * scaleY)
    local darkGray = Color.new(50, 50, 50)
    
    for i = 1, SettingsState.optionCount do
        local option = SettingsState.options[i]
        local y = startY + (i - 1) * lineHeight
        local color = darkGray
        local valueText = ""
        local valueColor = white
        
        -- Get option values
        if option == "Background Music" then
            valueText = AudioSettings.bgMusicEnabled and "ON" or "OFF"
            valueColor = AudioSettings.bgMusicEnabled and green or red
        elseif option == "Music Volume" then
            valueText = math.floor(AudioSettings.bgMusicVolume * 100) .. "%"
            valueColor = white
        elseif option == "Cookie Shower" then
            valueText = VisualSettings.cookieShowerEnabled and "ON" or "OFF"
            valueColor = VisualSettings.cookieShowerEnabled and green or red
        elseif option == "Milk Animation" then
            valueText = VisualSettings.milkAnimationEnabled and "ON" or "OFF"
            valueColor = VisualSettings.milkAnimationEnabled and green or red
        elseif option == "Reset Game" then
            valueText = "PRESS ENTER"
            valueColor = red
        end
        
        -- Highlight selected option
        if i == SettingsState.selectedIndex then
            color = white
            -- Draw selection indicator
            drawText(math.floor(50 * scaleX), y, ">", white)
        end
        
        -- Draw option name and value
        drawText(math.floor(80 * scaleX), y, option .. ": " .. valueText, color)
    end
    
    -- Controls info at bottom
    local controlsY = startY + (SettingsState.optionCount + 1) * lineHeight
    drawText(math.floor(50 * scaleX), controlsY, "UP/DOWN: Navigate   LEFT/RIGHT: Adjust   ENTER: Toggle", white)
    controlsY = controlsY + math.floor(25 * scaleY)
    drawText(math.floor(50 * scaleX), controlsY, "BACKSPACE: Return to Menu", white)
end

-- Statistics Screen drawing
function drawStatisticsScreen()
    -- Draw background
    if Texture["Background"] then
        Graphics.drawImageExtended(screenW/2, screenH/2, 0, 0, 960, 544, 0, scaleX, scaleY, Texture["Background"])
    end
    
    -- Draw title
    drawText(screenW/2 - 60, math.floor(30 * scaleY), "STATISTICS", white)
    
    -- Calculate play time
    local currentTime = Timer.getTime(timer)
    local sessionTime = (currentTime - Game.sessionStart) / 1000
    local totalTime = Game.totalPlayTime + sessionTime
    
    -- Column setup
    local leftX = math.floor(20 * scaleX)
    local rightX = math.floor(320 * scaleX)
    local startY = math.floor(80 * scaleY)
    local lineHeight = math.floor(25 * scaleY)
    local currentY = startY
    
    -- Cookie Statistics (Left Column)
    drawText(leftX, currentY, "COOKIE STATISTICS", yellow)
    currentY = currentY + lineHeight
    
    drawText(leftX, currentY, "Total Cookies: " .. formatNumber(Cookie.total), white)
    currentY = currentY + lineHeight
    
    drawText(leftX, currentY, "Current Cookies: " .. formatNumber(Cookie.count), white)
    currentY = currentY + lineHeight
    
    drawText(leftX, currentY, "Cookies Clicked: " .. formatNumber(Cookie.clicked), white)
    currentY = currentY + lineHeight
    
    drawText(leftX, currentY, "Total Clicks: " .. formatNumber(Cookie.clickCount), white)
    currentY = currentY + lineHeight
    
    drawText(leftX, currentY, "Max CpS: " .. formatNumber(Cookie.maxCpS), white)
    currentY = currentY + lineHeight
    
    drawText(leftX, currentY, "Total Spent: " .. formatNumber(Cookie.totalSpent), white)
    currentY = currentY + lineHeight + 10
    
    -- Session Statistics
    drawText(leftX, currentY, "SESSION STATISTICS", yellow)
    currentY = currentY + lineHeight
    
    drawText(leftX, currentY, "Session Time: " .. formatTime(sessionTime), white)
    currentY = currentY + lineHeight
    
    drawText(leftX, currentY, "Total Time: " .. formatTime(totalTime), white)
    currentY = currentY + lineHeight
    
    -- Building Statistics (Right Column)
    currentY = startY
    drawText(rightX, currentY, "BUILDING STATISTICS", yellow)
    currentY = currentY + lineHeight
    
    drawText(rightX, currentY, "Total Buildings: " .. formatNumber(Game.totalBuildings), white)
    currentY = currentY + lineHeight
    
    drawText(rightX, currentY, "Total Upgrades: " .. formatNumber(Game.totalUpgrades), white)
    currentY = currentY + lineHeight + 10
    
    -- Top building producers
    drawText(rightX, currentY, "TOP PRODUCERS", yellow)
    currentY = currentY + lineHeight
    
    -- Find top 3 producing buildings
    local buildingStats = {}
    for i = 1, #Button do
        local building = Button[i]
        if building and Button[building.."count"] > 0 then
            table.insert(buildingStats, {
                name = building,
                produced = Button[building.."produced"],
                count = Button[building.."count"]
            })
        end
    end
    
    -- Sort by production
    table.sort(buildingStats, function(a, b) return a.produced > b.produced end)
    
    -- Display top 3
    for i = 1, math.min(3, #buildingStats) do
        local stat = buildingStats[i]
        drawText(rightX, currentY, stat.name .. ": " .. formatNumber(stat.produced), white)
        currentY = currentY + lineHeight
    end
    
    -- Draw instructions
    drawText(math.floor(10 * scaleX), screenH - math.floor(20 * scaleY), "ENTER or BACKSPACE: Return to Menu", gray)
end

-- About Screen drawing
function drawAboutScreen()
    -- Draw background
    if Texture["Background"] then
        Graphics.drawImageExtended(screenW/2, screenH/2, 0, 0, 960, 544, 0, scaleX, scaleY, Texture["Background"])
    end
    
    -- Draw title
    local titleText = "ABOUT"
    local titleWidth = string.len(titleText) * 20  -- Approximate width for title font
    drawTitleText(screenW/2 - titleWidth/2, math.floor(30 * scaleY), titleText, white)
    
    -- Draw cookie image (smaller)
    if Texture["Cookie"] then
        local cookieScale = 0.3
        local cookieX = screenW/2
        local cookieY = math.floor(120 * scaleY)
        
        local cookieW = Graphics.getImageWidth(Texture["Cookie"]) or 128
        local cookieH = Graphics.getImageHeight(Texture["Cookie"]) or 128
        
        Graphics.drawImageExtended(cookieX, cookieY, 0, 0, cookieW, cookieH, 0, cookieScale, cookieScale, Texture["Cookie"])
    end
    
    -- Draw about info
    local aboutY = math.floor(180 * scaleY)
    local lineHeight = math.floor(25 * scaleY)
    
    local gameTitle = "Cookie Clicker SDL"  
    local gameTitleWidth = string.len(gameTitle) * 8
    drawText(screenW/2 - gameTitleWidth/2, aboutY, gameTitle, white)
    aboutY = aboutY + lineHeight
    
    local desc1 = "A port of Cookie Clicker"
    local desc1Width = string.len(desc1) * 6  -- Small font width
    drawSmallText(screenW/2 - desc1Width/2, aboutY, desc1, white)
    aboutY = aboutY + lineHeight
    
    local desc2 = "for LPP-SDL Platform"
    local desc2Width = string.len(desc2) * 6
    drawSmallText(screenW/2 - desc2Width/2, aboutY, desc2, white)
    aboutY = aboutY + lineHeight * 2
    
    local creditsText = "CREDITS"
    local creditsWidth = string.len(creditsText) * 8
    drawText(screenW/2 - creditsWidth/2, aboutY, creditsText, white)
    aboutY = aboutY + lineHeight
    
    local credit1 = "Original Vita Version by Creckeryop"
    local credit1Width = string.len(credit1) * 6
    drawSmallText(screenW/2 - credit1Width/2, aboutY, credit1, white)
    aboutY = aboutY + lineHeight
    
    local credit2 = "Thanks to Rinnegatamante for Lua Player Plus Vita"
    local credit2Width = string.len(credit2) * 6
    drawSmallText(screenW/2 - credit2Width/2, aboutY, credit2, white)
    aboutY = aboutY + lineHeight
    
    local credit3 = "Cookie Clicker by Orteil/DashNet"
    local credit3Width = string.len(credit3) * 6
    drawSmallText(screenW/2 - credit3Width/2, aboutY, credit3, white)
    
    -- Draw LPP-SDL logo at bottom
    if Texture["LppSDL"] then
        local logoW = Graphics.getImageWidth(Texture["LppSDL"]) or 200
        local logoH = Graphics.getImageHeight(Texture["LppSDL"]) or 50
        local logoScale = math.min(screenW / logoW * 0.3, screenH / logoH * 0.2)  -- Scale to fit nicely
        local logoX = screenW/2
        local logoY = screenH - math.floor(60 * scaleY)  -- Position above instructions
        
        Graphics.drawImageExtended(logoX, logoY, 0, 0, logoW, logoH, 0, logoScale, logoScale, Texture["LppSDL"])
    end
    
    -- Draw instructions (centered)
    local instructions = "ENTER or BACKSPACE: Return to Menu"
    local instructionsWidth = string.len(instructions) * 8
    drawText(screenW/2 - instructionsWidth/2, screenH - math.floor(20 * scaleY), instructions, white)
end

function drawUI()
    -- Draw panels
    drawPanels()
    
    -- Draw cookie counter in right panel (above cookie)
    local cookieCountX = PANEL_RIGHT_X + math.floor(10 * scaleX)
    local cookieCountY = math.floor(3 * scaleY)
    drawText(cookieCountX, cookieCountY, "COOKIES: " .. formatCookieCount(Cookie.count), white)
    
    -- Draw CPS below cookie counter
    local cps = 0
    for i = 1, #Button do
        local building = Button[i]
        if building then
            local quan = Upgrade[building.."Quan"] or 1
            cps = cps + Button[building.."count"] * Button[building.."cps"] * quan
        end
    end
    drawText(cookieCountX, cookieCountY + math.floor(20 * scaleY), "CPS: " .. formatNumber(cps), white)
    
    -- Draw vertical dividers (solid first, then gradients on top)
    if Texture["panelVertical"] then
        local verticalW = Graphics.getImageWidth(Texture["panelVertical"]) or 8
        local verticalH = Graphics.getImageHeight(Texture["panelVertical"]) or 1
        local verticalScaleX = math.floor(8 * scaleX) / verticalW
        local verticalScaleY = screenH / verticalH
        
        -- Draw solid dividers first
        Graphics.drawImageExtended(0, screenH/2, 0, 0, verticalW, verticalH, 0, verticalScaleX, verticalScaleY, Texture["panelVertical"])
        Graphics.drawImageExtended(PANEL_LEFT_WIDTH, screenH/2, 0, 0, verticalW, verticalH, 0, verticalScaleX, verticalScaleY, Texture["panelVertical"])
        Graphics.drawImageExtended(screenW, screenH/2, 0, 0, verticalW, verticalH, 0, verticalScaleX, verticalScaleY, Texture["panelVertical"])
        
        -- Draw gradients on top
        local leftW = Graphics.getImageWidth(Texture["panelGradientLeft"])
        local leftH = Graphics.getImageHeight(Texture["panelGradientLeft"])
        local gradientScaleX = math.floor(8 * scaleX) / leftW
        local gradientScaleY = screenH / leftH
        
        Graphics.drawImageExtended(0, screenH/2, 0, 0, leftW, leftH, 0, gradientScaleX, gradientScaleY, Texture["panelGradientLeft"])
        Graphics.drawImageExtended(PANEL_LEFT_WIDTH, screenH/2, 0, 0, leftW, leftH, 0, gradientScaleX, gradientScaleY, Texture["panelGradientLeft"])
        Graphics.drawImageExtended(screenW, screenH/2, 0, 0, leftW, leftH, 0, gradientScaleX, gradientScaleY, Texture["panelGradientRight"])
    end
end

-- Initialize timers
Timer.resume(timer)
Timer.resume(navTimer)
Timer.resume(buttonTimer)
Timer.resume(cookieTimer)

-- Initialize upgrade quantities for all buildings
Upgrade["CursorQuan"] = 1
Upgrade["GrandmaQuan"] = 1
Upgrade["FarmQuan"] = 1
Upgrade["MineQuan"] = 1
Upgrade["FactoryQuan"] = 1
Upgrade["BankQuan"] = 1
Upgrade["TempleQuan"] = 1
Upgrade["WizardTowerQuan"] = 1
Upgrade["ShipmentQuan"] = 1
Upgrade["AlchemyLabQuan"] = 1
Upgrade["PortalQuan"] = 1
Upgrade["TimeMachineQuan"] = 1
Upgrade["AntimatterCondenserQuan"] = 1
Upgrade["PrismQuan"] = 1

-- Initialize upgrade system
Upgrade.Now = {}

-- Upgrade management functions (from Vita version)
function Upgrade.update()
    -- Reset any upgrades that were marked as available but not purchased
    for i = 1, #Upgrade do
        if Upgrade[Upgrade[i].."a"] == 1 then
            Upgrade[Upgrade[i].."a"] = 0
        end
    end
    
    -- Clear current available upgrades
    for i = 1, #Upgrade.Now do
        table.remove(Upgrade.Now, 1)
    end
    
    -- Check which upgrades should be available (like Vita version)
    for i = 1, #Upgrade do
        local upgradeName = Upgrade[i]
        if Upgrade[upgradeName.."count"] <= Button[Upgrade[upgradeName.."name"].."count"] and Upgrade[upgradeName.."a"] == 0 then
            Upgrade[upgradeName.."a"] = 1
        end
        if Upgrade[upgradeName.."a"] == 1 then
            Upgrade.Now[#Upgrade.Now + 1] = upgradeName
        end
    end
end

function Upgrade.cps()
    -- Reset all upgrade quantities
    for i = 1, #Upgrade do
        Upgrade[Upgrade[Upgrade[i].."name"].."Quan"] = 1
    end
    -- Apply purchased upgrades (double CPS)
    for i = 1, #Upgrade do
        if Upgrade[Upgrade[i].."a"] == 2 then
            Upgrade[Upgrade[Upgrade[i].."name"].."Quan"] = Upgrade[Upgrade[Upgrade[i].."name"].."Quan"] * 2
        end
    end
end

-- Try to load saved game
loadGame()

-- Start background music for all screens if enabled
if AudioSettings.bgMusicEnabled then
    startBackgroundMusic()
end

-- Initialize upgrade system
Upgrade.update()
Upgrade.cps()


-- Main game loop
while true do
    -- Read controls once per frame
    local pad = Controls.read()
    
    
    handleInput(pad)
    
    -- Update shine rotation for all states (used in title screen and game)
    Shine.rot = Shine.rot + Shine.speed
    if Shine.rot >= 2 * pi then
        Shine.rot = Shine.rot - 2 * pi
    end
    
    -- Update cursor rotation (only used in game)
    if gameState == "Game" then
        Cursor.rot = Cursor.rot + Cursor.speed
        if Cursor.rot >= 2 * pi then
            Cursor.rot = Cursor.rot - 2 * pi
        end
    end
    
    -- Check music looping (in all states)
    checkMusicLoop()
    
    -- Passive cookie generation and upgrade updates (only in game)
    if gameState == "Game" and Timer.getTime(timer) >= 40 then
        local cps = 0
        for i = 1, #Button do
            local building = Button[i]
            if building then
                local quan = Upgrade[building.."Quan"] or 1
                cps = cps + Button[building.."count"] * Button[building.."cps"] * quan
            end
        end
        local cookiesFromBuildings = cps / 25
        Cookie.count = Cookie.count + cookiesFromBuildings
        Cookie.total = Cookie.total + cookiesFromBuildings
        
        -- Track max CpS achieved
        if cps > Cookie.maxCpS then
            Cookie.maxCpS = cps
        end
        
        -- Track production per building type
        for i = 1, #Button do
            local building = Button[i]
            if building then
                local quan = Upgrade[building.."Quan"] or 1
                local buildingCps = Button[building.."count"] * Button[building.."cps"] * quan
                Button[building.."produced"] = Button[building.."produced"] + buildingCps / 25
            end
        end
        
        -- Update available upgrades
        Upgrade.update()
        Upgrade.cps()
        
        Timer.reset(timer)
    end
    
    -- Render
    Graphics.initBlend()
    Screen.clear()
    
    -- Draw based on current game state
    if gameState == "Title" then
        drawTitleScreen()
    elseif gameState == "Game" then
        -- Draw background if available
        if Texture["Background"] then
            Graphics.drawImageExtended(screenW/2, screenH/2, 0, 0, 960, 544, 0, scaleX, scaleY, Texture["Background"])
        end
        
        -- Draw shaded borders over cookie section (like Vita version)
        if Texture["ShadedBorders"] then
            -- Cover the right panel (cookie area) - extend down to cover gap above milk
            local cookieAreaWidth = PANEL_RIGHT_WIDTH
            local cookieAreaHeight = screenH  -- Extend to full height to cover gap
            
            -- Scale the shadedBorders to cover the cookie area
            local borderW = Graphics.getImageWidth(Texture["ShadedBorders"]) or 256
            local borderH = Graphics.getImageHeight(Texture["ShadedBorders"]) or 256
            
            Graphics.drawImageExtended(PANEL_RIGHT_X + cookieAreaWidth/2, cookieAreaHeight/2, 
                                     0, 0, borderW, borderH, 0, 
                                     cookieAreaWidth/borderW, cookieAreaHeight/borderH, Texture["ShadedBorders"])
        end
        
        -- Draw all game UI components
        drawCookieShower()
        drawStoreBackground()
        drawMilk()
        drawBuildingsBackground()
        drawBuildings()
        drawCookie()
        drawUpgrades()
        drawStore()
        drawUI()
    elseif gameState == "Controls" then
        drawControlsScreen()
    elseif gameState == "Settings" then
        drawSettingsScreen()
    elseif gameState == "Statistics" then
        drawStatisticsScreen()
    elseif gameState == "About" then
        drawAboutScreen()
    end
    
    Graphics.termBlend()
    Screen.flip()
    Screen.waitVblankStart()
    
    -- Update oldpad at the very end of each frame
    oldpad = pad
end