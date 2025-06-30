-- Simple ImGui Test to verify all functions work
print("Testing ImGui functions...")

-- Initialize graphics and ImGui
Graphics.init()
Gui.init()
Gui.setTheme(DARK_THEME)

print("ImGui initialized successfully!")

-- Simple test window
local counter = 0
local test_text = "Hello ImGui!"

-- Main loop
local frames = 0
while frames < 60 do  -- Run for 60 frames then exit
    frames = frames + 1
    
    -- Start ImGui frame
    Gui.initBlend()
    
    -- Test window
    if Gui.initWindow("ImGui Test") then
        Gui.drawText("ImGui is working!")
        
        if Gui.drawButton("Test Button") then
            counter = counter + 1
            print("Button clicked! Count: " .. counter)
        end
        
        Gui.drawText("Counter: " .. counter)
        
        -- Test menu bar
        if Gui.initMainMenubar() then
            if Gui.initMenu("Test") then
                if Gui.drawMenuItem("Test Item") then
                    print("Menu item clicked!")
                end
                Gui.termMenu()
            end
            Gui.termMainMenubar()
        end
        
    end
    Gui.termWindow()
    
    -- Regular graphics
    Graphics.initBlend()
    Screen.clear()
    Graphics.fillRect(0, 1536, 0, 864, Color.new(30, 30, 30))
    Graphics.debugPrint(10, 10, "ImGui Test - Frame " .. frames, Color.new(255, 255, 255))
    Graphics.termBlend()
    
    -- End ImGui frame
    Gui.termBlend()
    
    Screen.flip()
end

print("ImGui test completed successfully!")

-- Cleanup
Gui.term()
System.exit()