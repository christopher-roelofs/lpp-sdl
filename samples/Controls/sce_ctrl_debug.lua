-- Debug test for SCE_CTRL backward compatibility

-- Colors
local white = Color.new(255, 255, 255)
local green = Color.new(0, 255, 0)
local red = Color.new(255, 0, 0)
local yellow = Color.new(255, 255, 0)

function _LPP_MAIN_LOOP()
    Graphics.initBlend()
    Screen.clear()
    
    Graphics.debugPrint(10, 10, "SCE_CTRL Backward Compatibility Debug", yellow)
    
    -- Test Controls.read()
    local pad = Controls.read()
    Graphics.debugPrint(10, 40, "Controls.read() returns: " .. tostring(pad), white)
    
    -- Test SCE_CTRL constants
    Graphics.debugPrint(10, 70, "SCE_CTRL constants:", white)
    Graphics.debugPrint(10, 85, "SCE_CTRL_LEFT: " .. tostring(SCE_CTRL_LEFT), white)
    Graphics.debugPrint(10, 100, "SCE_CTRL_RIGHT: " .. tostring(SCE_CTRL_RIGHT), white)
    Graphics.debugPrint(10, 115, "SCE_CTRL_CROSS: " .. tostring(SCE_CTRL_CROSS), white)
    
    -- Test Controls.check with SCE_CTRL codes
    local y = 140
    local test_buttons = {
        {"LEFT", SCE_CTRL_LEFT},
        {"RIGHT", SCE_CTRL_RIGHT},
        {"UP", SCE_CTRL_UP},
        {"DOWN", SCE_CTRL_DOWN},
        {"CROSS", SCE_CTRL_CROSS},
        {"CIRCLE", SCE_CTRL_CIRCLE},
        {"SQUARE", SCE_CTRL_SQUARE},
        {"TRIANGLE", SCE_CTRL_TRIANGLE}
    }
    
    for _, button in ipairs(test_buttons) do
        local name, code = button[1], button[2]
        if code then
            local is_pressed = Controls.check(pad, code)
            local color = is_pressed and green or white
            local status = is_pressed and " [PRESSED]" or ""
            Graphics.debugPrint(10, y, name .. " (" .. tostring(code) .. "): " .. status, color)
        else
            Graphics.debugPrint(10, y, name .. ": nil", red)
        end
        y = y + 15
    end
    
    y = y + 10
    Graphics.debugPrint(10, y, "Press arrow keys, space, backspace, z, x to test", white)
    y = y + 15
    Graphics.debugPrint(10, y, "Press ESC to quit", yellow)
    
    Graphics.termBlend()
    Screen.flip()
    
    -- Test quit
    if Controls.check(pad, SCE_CTRL_POWER) then  -- ESC should map to some SCE_CTRL
        System.exit()
    end
end