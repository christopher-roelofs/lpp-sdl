-- Text Measurement Test for LPP-SDL
-- This script demonstrates how to use text measurement functions for proper text centering

-- Get screen dimensions
local screenW = Screen.getWidth()
local screenH = Screen.getHeight()

-- Load a font (optional - if you have a font file)
local font = nil
-- Uncomment the following line if you have a font file:
-- font = Font.load("font.ttf")

-- Sample text to measure
local text = "Hello, World!"
local longText = "This is a longer text to test measurement"

-- Function to demonstrate text measurement with different approaches
function measureTextDemo()
    print("=== Text Measurement Demo ===")
    print("Screen dimensions: " .. screenW .. "x" .. screenH)
    
    -- Method 1: Using Font.getTextWidth and Font.getTextHeight (if font is loaded)
    if font then
        Font.setPixelSizes(font, 16)
        local textWidth = Font.getTextWidth(font, text)
        local textHeight = Font.getTextHeight(font, text)
        print("Font method - Width: " .. textWidth .. ", Height: " .. textHeight)
        
        -- Calculate centered position
        local centeredX = (screenW - textWidth) / 2
        local centeredY = (screenH - textHeight) / 2
        print("Centered position: (" .. centeredX .. ", " .. centeredY .. ")")
    end
    
    -- Method 2: Using GUI text measurement (works with default font)
    local guiWidth, guiHeight = Gui.getTextSize(text)
    print("GUI method - Width: " .. guiWidth .. ", Height: " .. guiHeight)
    
    -- Calculate centered position for GUI text
    local guiCenteredX = (screenW - guiWidth) / 2
    local guiCenteredY = (screenH - guiHeight) / 2
    print("GUI Centered position: (" .. guiCenteredX .. ", " .. guiCenteredY .. ")")
    
    -- Method 3: Test with longer text
    local longTextWidth, longTextHeight = Gui.getTextSize(longText)
    print("Long text - Width: " .. longTextWidth .. ", Height: " .. longTextHeight)
    
    -- Compare with character estimation (what was used before)
    local estimatedWidth = string.len(text) * 8  -- 8 pixels per character estimate
    print("Character estimation: " .. estimatedWidth .. " vs measured: " .. guiWidth)
    
    local estimatedLongWidth = string.len(longText) * 8
    print("Long text estimation: " .. estimatedLongWidth .. " vs measured: " .. longTextWidth)
end

-- Main rendering loop
function drawCenteredText()
    -- Clear screen
    Graphics.initBlend()
    Screen.clear(Color.new(0, 0, 100))  -- Dark blue background
    
    -- GUI text measurement and rendering
    local text1 = "Centered with GUI measurement"
    local text2 = "This text is properly centered"
    local text3 = "Press X to exit"
    
    -- Measure and center text1
    local w1, h1 = Gui.getTextSize(text1)
    local x1 = (screenW - w1) / 2
    local y1 = screenH / 2 - 60
    Graphics.debugPrint(x1, y1, text1, Color.new(255, 255, 255))
    
    -- Measure and center text2
    local w2, h2 = Gui.getTextSize(text2)
    local x2 = (screenW - w2) / 2
    local y2 = screenH / 2 - 20
    Graphics.debugPrint(x2, y2, text2, Color.new(255, 255, 255))
    
    -- Measure and center text3
    local w3, h3 = Gui.getTextSize(text3)
    local x3 = (screenW - w3) / 2
    local y3 = screenH / 2 + 40
    Graphics.debugPrint(x3, y3, text3, Color.new(255, 255, 0))
    
    -- If we have a font, demonstrate font-based text measurement
    if font then
        local fontText = "Font-based centered text"
        Font.setPixelSizes(font, 20)
        local fw = Font.getTextWidth(font, fontText)
        local fh = Font.getTextHeight(font, fontText)
        local fx = (screenW - fw) / 2
        local fy = screenH / 2 + 100
        Font.print(font, fx, fy, fontText, Color.new(0, 255, 0))
    end
    
    -- Show comparison with old method
    local comparisonText = "Old method (rough estimate)"
    local estimatedWidth = string.len(comparisonText) * 8
    local oldMethodX = (screenW - estimatedWidth) / 2
    local oldMethodY = screenH / 2 + 80
    Graphics.debugPrint(oldMethodX, oldMethodY, comparisonText, Color.new(255, 100, 100))
    
    Screen.flip()
    Graphics.termBlend()
end

-- Run the measurement demo
measureTextDemo()

-- Main loop
while true do
    local pad = Controls.read()
    
    if Controls.check(pad, SCE_CTRL_CROSS) then
        break
    end
    
    drawCenteredText()
end

-- Cleanup
if font then
    Font.unload(font)
end