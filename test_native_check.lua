-- Test native mode Controls.check() function
print("Testing native mode Controls.check()...")
print("Press keys to test - ESC to exit")

for i = 1, 600 do  -- 10 seconds at 60fps
    local pad = Controls.read()
    
    -- Test Controls.check() with various keys
    if Controls.check(pad, SDLK_RETURN) then
        print("Frame " .. i .. " - RETURN key pressed!")
    end
    
    if Controls.check(pad, SDLK_SPACE) then
        print("Frame " .. i .. " - SPACE key pressed!")
    end
    
    if Controls.check(pad, SDLK_UP) then
        print("Frame " .. i .. " - UP arrow pressed!")
    end
    
    if Controls.check(pad, SDLK_ESCAPE) then
        print("Frame " .. i .. " - ESC pressed - exiting!")
        break
    end
    
    -- Print debug info every 2 seconds
    if i % 120 == 0 then
        print("Frame " .. i .. " - pad value: " .. tostring(pad) .. " - still testing...")
    end
    
    Screen.flip()
end

print("Native Controls.check() test completed")