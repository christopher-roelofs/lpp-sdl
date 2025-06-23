-- Battery test to demonstrate SDL_PowerState integration
white = Color.new(255, 255, 255)
green = Color.new(0, 255, 0)
red = Color.new(255, 0, 0)
yellow = Color.new(255, 255, 0)
blue = Color.new(0, 150, 255)

font = Font.load()
Font.setPixelSizes(font, 20)

function formatTime(seconds)
    if seconds == nil or seconds < 0 then
        return "Unknown"
    end
    
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    
    if hours > 0 then
        return string.format("%dh %dm %ds", hours, minutes, secs)
    elseif minutes > 0 then
        return string.format("%dm %ds", minutes, secs)
    else
        return string.format("%ds", secs)
    end
end

while true do
    Screen.clear()
    
    -- Get battery percentage (backward compatible)
    local battery_pct = System.getBatteryPercentage()
    
    -- Get detailed battery info (new function)
    local battery_info = System.getBatteryInfo()
    
    -- Display title
    Font.print(font, 20, 20, "Battery Status Test", white)
    Font.print(font, 20, 50, "Press ESC to exit", white)
    
    -- Display basic battery percentage
    local pct_color = white
    if battery_pct <= 20 then
        pct_color = red
    elseif battery_pct <= 50 then
        pct_color = yellow
    else
        pct_color = green
    end
    
    Font.print(font, 20, 100, "Battery Percentage: " .. battery_pct .. "%", pct_color)
    
    -- Display detailed battery information
    local y_offset = 140
    
    Font.print(font, 20, y_offset, "=== Detailed Battery Info ===", blue)
    y_offset = y_offset + 40
    
    Font.print(font, 20, y_offset, "State: " .. (battery_info.state or "unknown"), white)
    y_offset = y_offset + 30
    
    local charging_text = battery_info.charging and "Yes" or "No"
    local charging_color = battery_info.charging and green or white
    Font.print(font, 20, y_offset, "Charging: " .. charging_text, charging_color)
    y_offset = y_offset + 30
    
    if battery_info.percentage then
        Font.print(font, 20, y_offset, "Precise %: " .. battery_info.percentage .. "%", white)
    else
        Font.print(font, 20, y_offset, "Precise %: Not available", white)
    end
    y_offset = y_offset + 30
    
    local time_text = formatTime(battery_info.secondsLeft)
    Font.print(font, 20, y_offset, "Time Left: " .. time_text, white)
    y_offset = y_offset + 50
    
    -- Display interpretation based on state
    Font.print(font, 20, y_offset, "=== Interpretation ===", blue)
    y_offset = y_offset + 40
    
    if battery_info.state == "no_battery" then
        Font.print(font, 20, y_offset, "Desktop/laptop plugged into power", green)
    elseif battery_info.state == "charging" then
        Font.print(font, 20, y_offset, "Device is charging", green)
    elseif battery_info.state == "charged" then
        Font.print(font, 20, y_offset, "Device is fully charged", green)
    elseif battery_info.state == "battery" then
        Font.print(font, 20, y_offset, "Running on battery power", yellow)
    else
        Font.print(font, 20, y_offset, "Battery status unknown", white)
    end
    
    Screen.flip()
    Screen.waitVblankStart()
end