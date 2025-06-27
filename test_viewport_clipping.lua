-- Test viewport clipping in 3DS compatibility mode
-- This script draws rectangles that should be clipped at screen boundaries

TOP_SCREEN = 0
BOTTOM_SCREEN = 1

-- Colors
white = Color.new(255, 255, 255)
red = Color.new(255, 0, 0)
green = Color.new(0, 255, 0)
blue = Color.new(0, 0, 255)
yellow = Color.new(255, 255, 0)

-- Main loop
while true do
    Screen.waitVblankStart()
    
    -- Handle controls
    pad = Controls.read()
    if Controls.check(pad, KEY_START) then
        break
    end
    
    Screen.refresh()
    
    -- Clear both screens
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    
    -- Draw on TOP_SCREEN (400x240)
    -- Normal rectangle within bounds
    Screen.fillRect(50, 150, 50, 100, green, TOP_SCREEN)
    
    -- Rectangle that extends beyond right edge (should be clipped at x=400)
    Screen.fillRect(350, 450, 120, 170, red, TOP_SCREEN)
    
    -- Rectangle that extends beyond bottom edge (should be clipped at y=240)
    Screen.fillRect(200, 300, 200, 280, blue, TOP_SCREEN)
    
    -- Draw on BOTTOM_SCREEN (320x240)
    -- Normal rectangle within bounds
    Screen.fillRect(50, 150, 50, 100, yellow, BOTTOM_SCREEN)
    
    -- Rectangle that extends beyond right edge (should be clipped at x=320)
    Screen.fillRect(280, 380, 120, 170, red, BOTTOM_SCREEN)
    
    -- Rectangle that extends beyond bottom edge (should be clipped at y=240)
    Screen.fillRect(160, 260, 200, 280, blue, BOTTOM_SCREEN)
    
    -- Draw text labels
    Font.print(Font.getDefault(), 10, 10, "TOP SCREEN (400x240)", white, TOP_SCREEN)
    Font.print(Font.getDefault(), 10, 30, "Green = normal", white, TOP_SCREEN)
    Font.print(Font.getDefault(), 10, 50, "Red = clips right", white, TOP_SCREEN)
    Font.print(Font.getDefault(), 10, 70, "Blue = clips bottom", white, TOP_SCREEN)
    
    Font.print(Font.getDefault(), 10, 10, "BOTTOM SCREEN (320x240)", white, BOTTOM_SCREEN)
    Font.print(Font.getDefault(), 10, 30, "Yellow = normal", white, BOTTOM_SCREEN)
    Font.print(Font.getDefault(), 10, 50, "Red = clips right", white, BOTTOM_SCREEN)
    Font.print(Font.getDefault(), 10, 70, "Blue = clips bottom", white, BOTTOM_SCREEN)
    
    Font.print(Font.getDefault(), 10, 220, "Press START to exit", white, BOTTOM_SCREEN)
    
    Screen.flip()
end

System.exit()