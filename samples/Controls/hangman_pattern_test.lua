-- Test the exact button pattern used by Vita Hangman

-- Colors
local white = Color.new(255, 255, 255)
local green = Color.new(0, 255, 0)
local red = Color.new(255, 0, 0)
local yellow = Color.new(255, 255, 0)

-- Menu state (like in hangman)
local number = 1
local maxnumber = 3
local oldpad = Controls.read()

function _LPP_MAIN_LOOP()
    Graphics.initBlend()
    Screen.clear()
    
    Graphics.debugPrint(10, 10, "Hangman Button Pattern Test", yellow)
    
    local pad = Controls.read()
    
    Graphics.debugPrint(10, 40, "Current pad: " .. tostring(pad), white)
    Graphics.debugPrint(10, 55, "Old pad: " .. tostring(oldpad), white)
    Graphics.debugPrint(10, 70, "Current menu selection: " .. tostring(number), white)
    
    -- Test the exact pattern from hangman
    if Controls.check(pad, SCE_CTRL_LEFT) and not Controls.check(oldpad, SCE_CTRL_LEFT) then
        number = number - 1
        Graphics.debugPrint(10, 100, "LEFT PRESSED! Number decreased", green)
    end
    
    if Controls.check(pad, SCE_CTRL_RIGHT) and not Controls.check(oldpad, SCE_CTRL_RIGHT) then
        number = number + 1
        Graphics.debugPrint(10, 115, "RIGHT PRESSED! Number increased", green)
    end
    
    if number > maxnumber then
        number = 1
    end
    
    if number <= 0 then
        number = maxnumber
    end
    
    -- Test cross button
    local cross = SCE_CTRL_CROSS
    if Controls.check(pad, cross) and not Controls.check(oldpad, cross) then
        Graphics.debugPrint(10, 130, "CROSS PRESSED! (Selection: " .. number .. ")", green)
    end
    
    -- Show current states
    Graphics.debugPrint(10, 160, "Button States:", white)
    Graphics.debugPrint(10, 175, "LEFT now: " .. tostring(Controls.check(pad, SCE_CTRL_LEFT)), white)
    Graphics.debugPrint(10, 190, "LEFT old: " .. tostring(Controls.check(oldpad, SCE_CTRL_LEFT)), white)
    Graphics.debugPrint(10, 205, "RIGHT now: " .. tostring(Controls.check(pad, SCE_CTRL_RIGHT)), white)
    Graphics.debugPrint(10, 220, "RIGHT old: " .. tostring(Controls.check(oldpad, SCE_CTRL_RIGHT)), white)
    Graphics.debugPrint(10, 235, "CROSS now: " .. tostring(Controls.check(pad, SCE_CTRL_CROSS)), white)
    Graphics.debugPrint(10, 250, "CROSS old: " .. tostring(Controls.check(oldpad, SCE_CTRL_CROSS)), white)
    
    Graphics.debugPrint(10, 280, "Press LEFT/RIGHT arrows to change selection", white)
    Graphics.debugPrint(10, 295, "Press SPACE (cross) to select", white)
    Graphics.debugPrint(10, 310, "Press ESC to quit", yellow)
    
    if Controls.check(pad, SCE_CTRL_POWER) then  -- ESC
        System.exit()
    end
    
    Graphics.termBlend()
    Screen.flip()
    
    -- Update oldpad for next frame (like in hangman)
    oldpad = pad
end