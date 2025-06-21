-- Minimal test replicating Vita Hangman behavior

local white = Color.new(255, 255, 255)
local green = Color.new(0, 255, 0)
local yellow = Color.new(255, 255, 0)

local number = 1
local oldpad = Controls.read()

function _LPP_MAIN_LOOP()
    Graphics.initBlend()
    Screen.clear()
    
    local pad = Controls.read()
    
    Graphics.debugPrint(10, 10, "Vita Hangman Pattern Test", yellow)
    Graphics.debugPrint(10, 40, "Selection: " .. number, white)
    
    -- Exact code from Vita Hangman
    if Controls.check(pad,SCE_CTRL_LEFT) and not Controls.check(oldpad,SCE_CTRL_LEFT) then
        number = number - 1
    end
    
    if Controls.check(pad,SCE_CTRL_RIGHT) and not Controls.check(oldpad,SCE_CTRL_RIGHT) then
        number = number + 1
    end
    
    if number > 3 then number = 1 end
    if number <= 0 then number = 3 end
    
    Graphics.debugPrint(10, 70, "Press LEFT/RIGHT arrows to change selection", white)
    Graphics.debugPrint(10, 85, "Current selection should change when you press arrows", white)
    
    Graphics.termBlend()
    Screen.flip()
    
    oldpad = pad
end