-- ImGui Example for LPP-SDL
-- Demonstrates the Dear ImGui integration

-- Initialize graphics
Graphics.init()

-- Initialize ImGui
Gui.init()
Gui.setTheme(DARK_THEME)

-- Demo state variables
local demo_window_open = true
local show_demo_window = false
local show_another_window = false
local clear_color = {0.45, 0.55, 0.60, 1.00}

-- Slider values
local float_val = 0.0
local counter = 0

-- Input text
local text_input = "Hello, world!"
local multiline_text = "This is a multiline\ntext input field.\nYou can edit this text."

-- Checkbox values
local check1 = true
local check2 = false

-- Radio button selection
local radio_selection = 0

-- Combo box
local combo_items = {"Apple", "Banana", "Cherry", "Date", "Elderberry"}
local combo_current = 1

-- List box
local listbox_items = {"Item 1", "Item 2", "Item 3", "Item 4", "Item 5"}
local listbox_current = 1

-- Color picker
local color_value = 0xFF0080FF  -- RGBA format

-- Progress bar
local progress = 0.0
local progress_dir = 1

-- Slider arrays
local float3_vals = {0.0, 0.0, 0.0}
local int_val = 50

-- Main loop
local oldpad = Controls.read()

while true do
    -- Read controls
    local pad = Controls.read()
    
    -- Handle exit
    if Controls.check(pad, SCE_CTRL_START) and not Controls.check(oldpad, SCE_CTRL_START) then
        break
    end
    
    -- Update progress bar animation
    progress = progress + progress_dir * 0.01
    if progress >= 1.0 then
        progress = 1.0
        progress_dir = -1
    elseif progress <= 0.0 then
        progress = 0.0
        progress_dir = 1
    end
    
    -- Start the Dear ImGui frame
    Gui.initBlend()
    
    -- Main demo window
    if demo_window_open then
        Gui.setWindowPos(50, 50, SET_ONCE)
        Gui.setWindowSize(550, 680, SET_ONCE)
        
        if Gui.initWindow("ImGui Demo for LPP-SDL") then
            Gui.drawText("This is some useful text.")
            
            if Gui.drawButton("Button") then
                counter = counter + 1
            end
            Gui.resetLine()
            Gui.drawText("counter = " .. counter)
            
            -- Checkboxes
            check1 = Gui.drawCheckbox("Demo Window", check1)
            check2 = Gui.drawCheckbox("Another Window", check2)
            
            -- Radio buttons
            if Gui.drawRadioButton("Radio A", radio_selection == 0) then
                radio_selection = 0
            end
            Gui.resetLine()
            if Gui.drawRadioButton("Radio B", radio_selection == 1) then
                radio_selection = 1
            end
            Gui.resetLine()
            if Gui.drawRadioButton("Radio C", radio_selection == 2) then
                radio_selection = 2
            end
            
            Gui.drawSeparator()
            
            -- Sliders
            float_val = Gui.drawSlider("Float", 0.0, 1.0, float_val)
            int_val = Gui.drawIntSlider("Integer", 0, 100, int_val)
            
            -- Float3 slider
            local new_x, new_y, new_z = Gui.drawSlider("Float3", 0.0, 1.0, float3_vals[1], float3_vals[2], float3_vals[3])
            float3_vals[1] = new_x
            float3_vals[2] = new_y
            float3_vals[3] = new_z
            
            Gui.drawSeparator()
            
            -- Color picker
            color_value = Gui.drawColorPicker("Color", color_value)
            
            -- Progress bar
            Gui.drawProgressbar(progress)
            
            Gui.drawSeparator()
            
            -- Text input
            text_input = Gui.drawTextInput("Input text", text_input)
            
            -- Multiline text input
            multiline_text = Gui.drawMultilineTextInput("Multiline", multiline_text)
            
            Gui.drawSeparator()
            
            -- Combo box
            combo_current = Gui.drawComboBox("Combo", combo_current, combo_items)
            
            -- List box
            listbox_current = Gui.drawListBox("Listbox", listbox_current, listbox_items)
            
            Gui.drawSeparator()
            
            -- Buttons
            if Gui.drawButton("Show Demo Window") then
                show_demo_window = true
            end
            
            if Gui.drawButton("Show Another Window") then
                show_another_window = true
            end
            
            if Gui.drawButton("Close Application") then
                demo_window_open = false
            end
            
        end
        Gui.termWindow()
    end
    
    -- Another simple window
    if show_another_window then
        Gui.setWindowPos(200, 100, SET_ONCE)
        Gui.setWindowSize(300, 200, SET_ONCE)
        
        if Gui.initWindow("Another Window", FLAG_NO_COLLAPSE) then
            Gui.drawText("Hello from another window!")
            
            if Gui.drawButton("Close Me") then
                show_another_window = false
            end
            
            Gui.drawSeparator()
            
            -- Small buttons
            if Gui.drawSmallButton("Small 1") then
                Gui.drawTooltip("This is a small button!")
            end
            Gui.resetLine()
            if Gui.drawSmallButton("Small 2") then
                -- Do nothing
            end
            
            Gui.drawSeparator()
            
            -- Tooltips
            Gui.drawText("Hover over me")
            Gui.drawTooltip("This text appears when you hover!")
            
        end
        Gui.termWindow()
    end
    
    -- Menu bar demo
    if Gui.initMainMenubar() then
        if Gui.initMenu("File") then
            if Gui.drawMenuItem("New", false, true) then
                text_input = "New file created!"
            end
            if Gui.drawMenuItem("Open", false, true) then
                text_input = "File opened!"
            end
            if Gui.drawMenuItem("Save", false, true) then
                text_input = "File saved!"
            end
            Gui.drawSeparator()
            if Gui.drawMenuItem("Exit", false, true) then
                demo_window_open = false
            end
            Gui.termMenu()
        end
        
        if Gui.initMenu("Edit") then
            if Gui.drawMenuItem("Undo", false, true) then
                text_input = "Undo performed!"
            end
            if Gui.drawMenuItem("Redo", false, true) then
                text_input = "Redo performed!"
            end
            Gui.drawSeparator()
            if Gui.drawMenuItem("Copy", false, true) then
                text_input = "Copied to clipboard!"
            end
            if Gui.drawMenuItem("Paste", false, true) then
                text_input = "Pasted from clipboard!"
            end
            Gui.termMenu()
        end
        
        if Gui.initMenu("Help") then
            if Gui.drawMenuItem("About", false, true) then
                show_demo_window = true
            end
            Gui.termMenu()
        end
        
        Gui.termMainMenubar()
    end
    
    -- Simple demo window
    if show_demo_window then
        Gui.setWindowPos(400, 200, SET_ONCE)
        Gui.setWindowSize(350, 400, SET_ONCE)
        
        if Gui.initWindow("Demo Window") then
            Gui.drawText("ImGui for LPP-SDL")
            Gui.drawText("Application average %.3f ms/frame (%.1f FPS)", 1000.0/60.0, 60.0)
            
            Gui.drawSeparator()
            
            -- Text colors
            Gui.drawText("Colored text example:", 0xFFFFFFFF)
            Gui.drawText("Red text", 0xFF0000FF)
            Gui.drawText("Green text", 0xFF00FF00)
            Gui.drawText("Blue text", 0xFFFF0000)
            Gui.drawText("Yellow text", 0xFF00FFFF)
            
            Gui.drawSeparator()
            
            -- Disabled text
            Gui.drawDisabledText("This text is disabled")
            
            -- Wrapped text
            Gui.drawWrappedText("This is a very long line of text that will be wrapped automatically when it exceeds the window width. This demonstrates the text wrapping feature of ImGui.")
            
            Gui.drawSeparator()
            
            -- Widget positioning
            Gui.drawText("Manual positioning:")
            Gui.setWidgetPos(50, 300)
            Gui.drawText("Positioned text")
            
            -- Widget width control
            Gui.setWidgetWidth(100)
            float_val = Gui.drawSlider("Narrow", 0.0, 1.0, float_val)
            Gui.resetWidgetWidth()
            
            Gui.drawSeparator()
            
            if Gui.drawButton("Close Demo") then
                show_demo_window = false
            end
            
        end
        Gui.termWindow()
    end
    
    -- Exit if main window was closed
    if not demo_window_open then
        break
    end
    
    -- Start regular graphics rendering
    Graphics.initBlend()
    Screen.clear()
    
    -- Draw background
    Graphics.fillRect(0, 960, 0, 544, Color.new(
        math.floor(clear_color[1] * 255),
        math.floor(clear_color[2] * 255),
        math.floor(clear_color[3] * 255)
    ))
    
    -- Draw some info
    Graphics.debugPrint(10, 10, "ImGui Example Running", Color.new(255, 255, 255))
    Graphics.debugPrint(10, 30, "Press START to exit", Color.new(200, 200, 200))
    Graphics.debugPrint(10, 50, "Current float value: " .. string.format("%.2f", float_val), Color.new(200, 200, 200))
    Graphics.debugPrint(10, 70, "Counter: " .. counter, Color.new(200, 200, 200))
    Graphics.debugPrint(10, 90, "Selected: " .. combo_items[combo_current], Color.new(200, 200, 200))
    
    -- End regular graphics
    Graphics.termBlend()
    
    -- Render ImGui
    Gui.termBlend()
    
    -- Present
    Screen.flip()
    
    -- Update old pad
    oldpad = pad
end

-- Cleanup
Gui.term()
System.exit()