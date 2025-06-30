-- UI Example using the UI Library
-- Demonstrates composable UI components

-- Load the UI library
local UI = dofile("ui_library.lua")

-- Initialize graphics
Graphics.init()

-- Create UI manager
local uiManager = UI.Manager:new()

-- Create main panel
local mainPanel = UI.Panel:new(50, 50, 860, 444)
mainPanel.backgroundColor = Color.new(32, 32, 40)
uiManager:add(mainPanel)

-- Create title label
local titleLabel = UI.Label:new(20, 20, "UI Component Example")
titleLabel.textColor = Color.new(255, 255, 255)
titleLabel.width = 820
titleLabel.alignment = "center"
mainPanel:addChild(titleLabel)

-- Create button panel
local buttonPanel = UI.Panel:new(20, 60, 400, 200)
buttonPanel.backgroundColor = Color.new(48, 48, 56)
mainPanel:addChild(buttonPanel)

-- Add some buttons to the button panel
local button1 = UI.Button:new(20, 20, 160, 40, "Button 1")
button1.backgroundColor = Color.new(64, 128, 64)
button1.hoverColor = Color.new(96, 160, 96)
button1.pressedColor = Color.new(32, 96, 32)
button1.onClick = function(btn)
    titleLabel.text = "Button 1 clicked!"
end
buttonPanel:addChild(button1)

local button2 = UI.Button:new(200, 20, 160, 40, "Button 2")
button2.backgroundColor = Color.new(128, 64, 64)
button2.hoverColor = Color.new(160, 96, 96)
button2.pressedColor = Color.new(96, 32, 32)
button2.onClick = function(btn)
    titleLabel.text = "Button 2 clicked!"
end
buttonPanel:addChild(button2)

local button3 = UI.Button:new(20, 80, 340, 40, "Toggle Panel Visibility")
button3.onClick = function(btn)
    buttonPanel.visible = not buttonPanel.visible
    titleLabel.text = buttonPanel.visible and "Panel visible" or "Panel hidden"
end
buttonPanel:addChild(button3)

-- Create input panel
local inputPanel = UI.Panel:new(440, 60, 400, 200)
inputPanel.backgroundColor = Color.new(48, 48, 56)
mainPanel:addChild(inputPanel)

-- Add label and text field
local inputLabel = UI.Label:new(20, 20, "Enter your name:")
inputPanel:addChild(inputLabel)

local textField = UI.TextField:new(20, 50, 360, 40)
textField.onChange = function(field, text)
    titleLabel.text = "Hello, " .. text .. "!"
end
inputPanel:addChild(textField)

-- Create a nested component example
local nestedPanel = UI.Panel:new(20, 120, 360, 60)
nestedPanel.backgroundColor = Color.new(64, 64, 72)
inputPanel:addChild(nestedPanel)

local nestedButton = UI.Button:new(10, 10, 150, 40, "Nested Button")
nestedButton.backgroundColor = Color.new(128, 64, 128)
nestedButton.onClick = function(btn)
    titleLabel.text = "Nested button clicked!"
end
nestedPanel:addChild(nestedButton)

local nestedLabel = UI.Label:new(170, 20, "Inside nested panel")
nestedLabel.textColor = Color.new(200, 200, 200)
nestedPanel:addChild(nestedLabel)

-- Create status panel at bottom
local statusPanel = UI.Panel:new(20, 280, 820, 144)
statusPanel.backgroundColor = Color.new(40, 40, 48)
mainPanel:addChild(statusPanel)

local statusLabel = UI.Label:new(20, 20, "Status: Ready")
statusPanel:addChild(statusLabel)

-- Add exit button
local exitButton = UI.Button:new(660, 84, 140, 40, "Exit")
exitButton.backgroundColor = Color.new(128, 32, 32)
exitButton.onClick = function(btn)
    System.exit()
end
statusPanel:addChild(exitButton)

-- Create dynamic button creator
local createY = 60
local createButton = UI.Button:new(20, createY, 200, 40, "Create Button")
createButton.backgroundColor = Color.new(64, 64, 128)
createButton.onClick = function(btn)
    createY = createY + 50
    if createY > 100 then createY = 60 end
    
    local newBtn = UI.Button:new(240, createY, 140, 30, "Dynamic " .. tostring(createY))
    newBtn.backgroundColor = Color.new(
        math.random(32, 96),
        math.random(32, 96),
        math.random(32, 96)
    )
    newBtn.onClick = function(b)
        statusLabel.text = "Dynamic button at Y=" .. createY .. " clicked"
    end
    statusPanel:addChild(newBtn)
end
statusPanel:addChild(createButton)

-- Main loop
local oldpad = Controls.read()
local frameCount = 0

while true do
    -- Read controls
    local pad = Controls.read()
    
    -- Handle exit
    if Controls.check(pad, SCE_CTRL_START) and not Controls.check(oldpad, SCE_CTRL_START) then
        break
    end
    
    -- Update UI
    uiManager:update(1/60) -- 60 FPS assumed
    
    -- Start drawing
    Graphics.initBlend()
    Screen.clear()
    
    -- Draw background
    Graphics.fillRect(0, 960, 0, 544, Color.new(16, 16, 20))
    
    -- Draw UI
    uiManager:draw()
    
    -- Draw FPS counter
    frameCount = frameCount + 1
    Graphics.debugPrint(5, 5, "FPS: 60 | Frame: " .. frameCount, Color.new(255, 255, 0))
    Graphics.debugPrint(5, 25, "Touch screen or press START to exit", Color.new(200, 200, 200))
    
    -- End drawing
    Graphics.termBlend()
    Screen.flip()
    
    -- Update old pad
    oldpad = pad
end

-- Exit
System.exit()