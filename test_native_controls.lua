-- Test native mode controls
print("Testing native mode controls")
print("Press arrow keys, Enter, Space, etc.")

for i = 1, 300 do  -- 5 seconds at 60fps
    local controls = Controls.read()
    
    -- Test some basic controls in native mode
    if controls then
        print("Frame " .. i .. " - controls value: " .. tostring(controls))
        if type(controls) == "number" then
            print("  Controls returned number: " .. controls)
        end
    end
    
    -- Print status every 2 seconds
    if i % 120 == 0 then
        print("Frame " .. i .. " - testing native controls...")
    end
    
    Screen.flip()
end

print("Native controls test completed")