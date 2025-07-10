-- Menu Text Centering Example
-- Demonstrates proper text centering in menu systems using lpp-sdl text measurement functions

-- Get screen dimensions
local screenW = Screen.getWidth()
local screenH = Screen.getHeight()

-- Menu system state
local menuItems = {
    "New Game",
    "Load Game", 
    "Options",
    "Credits",
    "Exit"
}

local selectedItem = 1
local menuTitle = "MAIN MENU"

-- Colors
local WHITE = Color.new(255, 255, 255)
local YELLOW = Color.new(255, 255, 0)
local GRAY = Color.new(128, 128, 128)
local RED = Color.new(255, 0, 0)
local BLUE = Color.new(0, 100, 255)

-- Function to draw properly centered text
function drawCenteredText(text, y, color)
    local textWidth, textHeight = Gui.getTextSize(text)
    local x = (screenW - textWidth) / 2
    Graphics.debugPrint(x, y, text, color)
    return textHeight
end

-- Function to draw right-aligned text
function drawRightAlignedText(text, x, y, color)
    local textWidth, textHeight = Gui.getTextSize(text)
    local rightX = x - textWidth
    Graphics.debugPrint(rightX, y, text, color)
    return textHeight
end

-- Function to draw left-aligned text
function drawLeftAlignedText(text, x, y, color)
    Graphics.debugPrint(x, y, text, color)
    local textWidth, textHeight = Gui.getTextSize(text)
    return textHeight
end

-- Function to get the maximum width of menu items
function getMaxMenuWidth()
    local maxWidth = 0
    for i, item in ipairs(menuItems) do
        local width, height = Gui.getTextSize(item)
        if width > maxWidth then
            maxWidth = width
        end
    end
    return maxWidth
end

-- Function to draw the menu
function drawMenu()
    Graphics.initBlend()
    Screen.clear(Color.new(20, 20, 60))  -- Dark blue background
    
    -- Draw title - centered
    local titleY = 50
    local titleHeight = drawCenteredText(menuTitle, titleY, WHITE)
    
    -- Draw a separator line under the title
    local lineY = titleY + titleHeight + 20
    Graphics.drawLine(screenW/2 - 100, screenW/2 + 100, lineY, lineY, GRAY)
    
    -- Calculate menu positioning
    local menuStartY = lineY + 40
    local itemSpacing = 35
    local maxMenuWidth = getMaxMenuWidth()
    
    -- Draw menu items
    for i, item in ipairs(menuItems) do
        local itemY = menuStartY + (i - 1) * itemSpacing
        local color = WHITE
        
        -- Highlight selected item
        if i == selectedItem then
            color = YELLOW
            
            -- Draw selection highlight background
            local itemWidth, itemHeight = Gui.getTextSize(item)
            local highlightX = (screenW - itemWidth) / 2 - 10
            local highlightY = itemY - 2
            Graphics.fillRect(highlightX, highlightX + itemWidth + 20, 
                            highlightY, highlightY + itemHeight + 4, 
                            Color.new(50, 50, 100))
        end
        
        -- Draw the menu item centered
        drawCenteredText(item, itemY, color)
    end
    
    -- Draw instructions at the bottom
    local instructionY = screenH - 80
    drawCenteredText("Use UP/DOWN to navigate, X to select, O to go back", instructionY, GRAY)
    
    -- Draw text measurement info (for demonstration)
    local infoY = screenH - 40
    local infoText = "Max menu width: " .. maxMenuWidth .. "px, Screen: " .. screenW .. "x" .. screenH
    drawCenteredText(infoText, infoY, Color.new(100, 100, 100))
    
    Screen.flip()
    Graphics.termBlend()
end

-- Function to demonstrate different alignment methods
function drawAlignmentDemo()
    Graphics.initBlend()
    Screen.clear(Color.new(40, 40, 40))  -- Dark gray background
    
    local demoText = "Alignment Demo"
    local sampleText = "This is sample text for alignment"
    
    -- Title
    drawCenteredText(demoText, 30, WHITE)
    
    -- Left alignment
    local leftY = 100
    drawLeftAlignedText("Left aligned:", 50, leftY, YELLOW)
    drawLeftAlignedText(sampleText, 50, leftY + 25, WHITE)
    
    -- Center alignment
    local centerY = 180
    drawCenteredText("Center aligned:", centerY, YELLOW)
    drawCenteredText(sampleText, centerY + 25, WHITE)
    
    -- Right alignment
    local rightY = 260
    drawRightAlignedText("Right aligned:", screenW - 50, rightY, YELLOW)
    drawRightAlignedText(sampleText, screenW - 50, rightY + 25, WHITE)
    
    -- Demonstrate text width calculation
    local calcY = 340
    local calcText = "Text width calculation"
    local calcWidth, calcHeight = Gui.getTextSize(calcText)
    drawCenteredText(calcText, calcY, YELLOW)
    drawCenteredText("Width: " .. calcWidth .. "px, Height: " .. calcHeight .. "px", calcY + 25, WHITE)
    
    -- Show character estimation vs actual measurement
    local estY = 400
    local estText = "Estimation vs Measurement"
    local estWidth, estHeight = Gui.getTextSize(estText)
    local charEstimate = string.len(estText) * 8
    drawCenteredText(estText, estY, YELLOW)
    drawCenteredText("Character estimate: " .. charEstimate .. "px", estY + 25, RED)
    drawCenteredText("Actual measurement: " .. estWidth .. "px", estY + 45, Color.new(0, 255, 0))
    drawCenteredText("Difference: " .. math.abs(charEstimate - estWidth) .. "px", estY + 65, WHITE)
    
    -- Instructions
    drawCenteredText("Press START to return to menu", screenH - 50, GRAY)
    
    Screen.flip()
    Graphics.termBlend()
end

-- State management
local currentState = "menu"  -- "menu" or "demo"

-- Input handling
function handleInput()
    local pad = Controls.read()
    
    if currentState == "menu" then
        if Controls.check(pad, SCE_CTRL_UP) then
            selectedItem = selectedItem - 1
            if selectedItem < 1 then
                selectedItem = #menuItems
            end
        elseif Controls.check(pad, SCE_CTRL_DOWN) then
            selectedItem = selectedItem + 1
            if selectedItem > #menuItems then
                selectedItem = 1
            end
        elseif Controls.check(pad, SCE_CTRL_CROSS) then
            if selectedItem == 1 then
                print("New Game selected")
            elseif selectedItem == 2 then
                print("Load Game selected")
            elseif selectedItem == 3 then
                currentState = "demo"
            elseif selectedItem == 4 then
                print("Credits selected")
            elseif selectedItem == 5 then
                return false  -- Exit
            end
        elseif Controls.check(pad, SCE_CTRL_START) then
            currentState = "demo"
        end
    elseif currentState == "demo" then
        if Controls.check(pad, SCE_CTRL_START) or Controls.check(pad, SCE_CTRL_CIRCLE) then
            currentState = "menu"
        end
    end
    
    return true
end

-- Main loop
print("=== Menu Text Centering Example ===")
print("This example demonstrates proper text centering using:")
print("1. Gui.getTextSize() for measuring text dimensions")
print("2. Font.getTextWidth() and Font.getTextHeight() for font-based text")
print("3. Proper centering calculations instead of character estimates")
print("")
print("Controls:")
print("- UP/DOWN: Navigate menu")
print("- X: Select item")
print("- START: Toggle alignment demo")
print("- O: Back (in demo mode)")

while true do
    if not handleInput() then
        break
    end
    
    if currentState == "menu" then
        drawMenu()
    elseif currentState == "demo" then
        drawAlignmentDemo()
    end
    
    -- Small delay to prevent too rapid input
    Timer.sleep(16)  -- ~60 FPS
end

print("Menu example finished.")