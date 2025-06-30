-- Scaled UI Example - Resolution Independent
-- Works at any resolution with automatic scaling

-- Load the scaled UI library
local UI = dofile("ui_library_scaled.lua")

-- Initialize graphics
Graphics.init()

-- Get actual screen size (you can change these values to test different resolutions)
local screenWidth = 960
local screenHeight = 544

-- Create UI manager with current screen size
local uiManager = UI.Manager:new(screenWidth, screenHeight)

-- Set reference resolution (the resolution we design for)
UI.setReferenceResolution(1920, 1080)

-- Create main container using relative sizing
local mainContainer = UI.Panel:new({
    relativeX = 0.05,  -- 5% from left
    relativeY = 0.05,  -- 5% from top
    relativeWidth = 0.9,  -- 90% of screen width
    relativeHeight = 0.9, -- 90% of screen height
    backgroundColor = Color.new(32, 32, 40),
    borderRadius = 10,
    padding = {top = 20, right = 20, bottom = 20, left = 20}
})
uiManager:add(mainContainer)

-- Create header with flex layout
local header = UI.Panel:new({
    width = 1920 * 0.9 - 40, -- Full width minus padding
    height = 100,
    backgroundColor = Color.new(48, 48, 56),
    borderRadius = 8,
    layout = UI.Layout.FLEX,
    flexDirection = "row",
    alignItems = "center",
    padding = {top = 10, right = 20, bottom = 10, left = 20},
    gap = 20
})
mainContainer:addChild(header)

-- Title in header
local title = UI.Label:new({
    text = "Resolution Independent UI Demo",
    fontSize = 24,
    flex = 1,
    alignment = "center"
})
header:addChild(title)

-- Info label showing current resolution
local infoLabel = UI.Label:new({
    text = string.format("Screen: %dx%d | Scale: %.2f", screenWidth, screenHeight, UI.scale),
    fontSize = 14,
    width = 300,
    alignment = "right",
    textColor = Color.new(200, 200, 200)
})
header:addChild(infoLabel)

-- Create content area with flex layout
local content = UI.Panel:new({
    y = 120,
    width = 1920 * 0.9 - 40,
    height = 1080 * 0.9 - 160 - 120, -- Full height minus header and footer
    layout = UI.Layout.FLEX,
    flexDirection = "row",
    gap = 20
})
mainContainer:addChild(content)

-- Left panel with buttons
local leftPanel = UI.Panel:new({
    flex = 1,
    backgroundColor = Color.new(48, 48, 56),
    borderRadius = 8,
    padding = {top = 20, right = 20, bottom = 20, left = 20},
    layout = UI.Layout.FLEX,
    flexDirection = "column",
    gap = 15
})
content:addChild(leftPanel)

-- Add title to left panel
local leftTitle = UI.Label:new({
    text = "Button Examples",
    fontSize = 20,
    height = 40,
    alignment = "center"
})
leftPanel:addChild(leftTitle)

-- Create buttons with different styles
local button1 = UI.Button:new({
    height = 60,
    text = "Primary Button",
    fontSize = 18,
    backgroundColor = Color.new(64, 128, 255),
    hoverColor = Color.new(96, 160, 255),
    pressedColor = Color.new(32, 96, 224),
    borderRadius = 8,
    onClick = function(btn)
        title.text = "Primary button clicked!"
    end
})
leftPanel:addChild(button1)

local button2 = UI.Button:new({
    height = 60,
    text = "Secondary Button",
    fontSize = 18,
    backgroundColor = Color.new(96, 96, 96),
    hoverColor = Color.new(128, 128, 128),
    pressedColor = Color.new(64, 64, 64),
    borderRadius = 8,
    onClick = function(btn)
        title.text = "Secondary button clicked!"
    end
})
leftPanel:addChild(button2)

local button3 = UI.Button:new({
    height = 60,
    text = "Danger Button",
    fontSize = 18,
    backgroundColor = Color.new(220, 53, 69),
    hoverColor = Color.new(255, 96, 96),
    pressedColor = Color.new(180, 32, 48),
    borderRadius = 8,
    onClick = function(btn)
        title.text = "Danger button clicked!"
    end
})
leftPanel:addChild(button3)

-- Right panel with nested flex layouts
local rightPanel = UI.Panel:new({
    flex = 1,
    backgroundColor = Color.new(48, 48, 56),
    borderRadius = 8,
    padding = {top = 20, right = 20, bottom = 20, left = 20},
    layout = UI.Layout.FLEX,
    flexDirection = "column",
    gap = 15
})
content:addChild(rightPanel)

-- Add title to right panel
local rightTitle = UI.Label:new({
    text = "Flex Layout Demo",
    fontSize = 20,
    height = 40,
    alignment = "center"
})
rightPanel:addChild(rightTitle)

-- Create horizontal button group
local buttonGroup = UI.Panel:new({
    height = 60,
    layout = UI.Layout.FLEX,
    flexDirection = "row",
    gap = 10
})
rightPanel:addChild(buttonGroup)

-- Add flex buttons
for i = 1, 3 do
    local flexBtn = UI.Button:new({
        flex = 1,
        text = "Flex " .. i,
        fontSize = 16,
        backgroundColor = Color.new(64 + i * 20, 64, 128),
        borderRadius = 6,
        onClick = function(btn)
            title.text = "Flex button " .. i .. " clicked!"
        end
    })
    buttonGroup:addChild(flexBtn)
end

-- Create cards with different alignments
local cardContainer = UI.Panel:new({
    flex = 1,
    backgroundColor = Color.new(40, 40, 48),
    borderRadius = 6,
    padding = {top = 15, right = 15, bottom = 15, left = 15},
    layout = UI.Layout.FLEX,
    flexDirection = "column",
    gap = 10
})
rightPanel:addChild(cardContainer)

-- Card examples
local alignments = {"start", "center", "end"}
for i, align in ipairs(alignments) do
    local card = UI.Panel:new({
        height = 60,
        backgroundColor = Color.new(56, 56, 64),
        borderRadius = 4,
        padding = {top = 10, right = 10, bottom = 10, left = 10},
        layout = UI.Layout.FLEX,
        flexDirection = "row",
        alignItems = align
    })
    cardContainer:addChild(card)
    
    local cardLabel = UI.Label:new({
        text = "Align: " .. align,
        fontSize = 14,
        flex = 1
    })
    card:addChild(cardLabel)
    
    local cardButton = UI.Button:new({
        width = 80,
        height = 40,
        text = "Test",
        fontSize = 14,
        borderRadius = 4,
        onClick = function()
            title.text = "Card with " .. align .. " alignment clicked!"
        end
    })
    card:addChild(cardButton)
end

-- Footer with centered content
local footer = UI.Panel:new({
    y = 1080 * 0.9 - 80,
    width = 1920 * 0.9 - 40,
    height = 60,
    backgroundColor = Color.new(48, 48, 56),
    borderRadius = 8,
    layout = UI.Layout.FLEX,
    flexDirection = "row",
    justifyContent = "center",
    alignItems = "center",
    gap = 30
})
mainContainer:addChild(footer)

-- Footer buttons
local resButtons = {
    {w = 960, h = 544, name = "Vita"},
    {w = 1280, h = 720, name = "720p"},
    {w = 1920, h = 1080, name = "1080p"}
}

for _, res in ipairs(resButtons) do
    local resBtn = UI.Button:new({
        width = 120,
        height = 40,
        text = res.name,
        fontSize = 14,
        borderRadius = 6,
        onClick = function()
            -- In a real implementation, you would resize the window here
            -- For demo purposes, we just update the UI scale
            UI.setScreenSize(res.w, res.h)
            infoLabel.text = string.format("Screen: %dx%d | Scale: %.2f", res.w, res.h, UI.scale)
            title.text = "UI scaled for " .. res.name .. " resolution"
            -- Force layout recalculation
            uiManager.root:invalidateLayout()
        end
    })
    footer:addChild(resBtn)
end

-- Exit button
local exitBtn = UI.Button:new({
    width = 120,
    height = 40,
    text = "Exit",
    fontSize = 14,
    backgroundColor = Color.new(180, 32, 48),
    borderRadius = 6,
    onClick = function()
        System.exit()
    end
})
footer:addChild(exitBtn)

-- Main loop
local oldpad = Controls.read()

while true do
    -- Read controls
    local pad = Controls.read()
    
    -- Handle exit
    if Controls.check(pad, SCE_CTRL_START) and not Controls.check(oldpad, SCE_CTRL_START) then
        break
    end
    
    -- Update UI
    uiManager:update(1/60)
    
    -- Start drawing
    Graphics.initBlend()
    Screen.clear()
    
    -- Draw background
    Graphics.fillRect(0, screenWidth, 0, screenHeight, Color.new(16, 16, 20))
    
    -- Draw UI
    uiManager:draw()
    
    -- Draw help text
    Graphics.debugPrint(5, 5, "Touch screen to interact | Press START to exit", Color.new(200, 200, 200))
    
    -- End drawing
    Graphics.termBlend()
    Screen.flip()
    
    -- Update old pad
    oldpad = pad
end

-- Exit
System.exit()