-- Test single-screen mode for 3DS compatibility
-- Use TAB to switch between top and bottom screens

TOP_SCREEN = 0
BOTTOM_SCREEN = 1

-- Colors
white = Color.new(255, 255, 255)
red = Color.new(255, 0, 0)
green = Color.new(0, 255, 0)
blue = Color.new(0, 0, 255)
yellow = Color.new(255, 255, 0)
black = Color.new(0, 0, 0)

-- Main loop
while true do
    Screen.waitVblankStart()
    
    -- Handle controls
    pad = Controls.read()
    if Controls.check(pad, KEY_START) then
        break
    end
    
    Screen.refresh()
    
    -- Clear both screens (only the active one will be visible)
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    
    -- Draw on TOP_SCREEN (400x240)
    Screen.fillRect(0, 400, 0, 240, black, TOP_SCREEN)
    Screen.fillRect(50, 350, 50, 190, green, TOP_SCREEN)
    Screen.fillRect(10, 390, 10, 40, red, TOP_SCREEN)
    Screen.fillRect(10, 390, 200, 230, blue, TOP_SCREEN)
    
    Screen.debugPrint(10, 10, "TOP SCREEN (400x240)", white, TOP_SCREEN)
    Screen.debugPrint(10, 30, "Press TAB to switch screens", white, TOP_SCREEN)
    Screen.debugPrint(10, 220, "Press START to exit", white, TOP_SCREEN)
    
    -- Draw on BOTTOM_SCREEN (320x240)
    Screen.fillRect(0, 320, 0, 240, black, BOTTOM_SCREEN)
    Screen.fillRect(50, 270, 50, 190, yellow, BOTTOM_SCREEN)
    Screen.fillRect(10, 310, 10, 40, red, BOTTOM_SCREEN)
    Screen.fillRect(10, 310, 200, 230, blue, BOTTOM_SCREEN)
    
    Screen.debugPrint(10, 10, "BOTTOM SCREEN (320x240)", white, BOTTOM_SCREEN)
    Screen.debugPrint(10, 30, "Press TAB to switch screens", white, BOTTOM_SCREEN)
    Screen.debugPrint(10, 220, "Press START to exit", white, BOTTOM_SCREEN)
    
    Screen.flip()
end

System.exit()