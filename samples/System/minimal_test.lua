-- Minimal System Test
print("Starting minimal system test...")

-- Test basic file existence
local exists = System.doesFileExist("minimal_test.lua")
print("File exists test: " .. tostring(exists))

-- Test directory existence
local dir_exists = System.doesDirExist(".")
print("Directory exists test: " .. tostring(dir_exists))

-- Test time
local hour, minute, second = System.getTime()
print("Time test: " .. tostring(hour) .. ":" .. tostring(minute) .. ":" .. tostring(second))

-- Test battery
local battery = System.getBatteryPercentage()
print("Battery test: " .. tostring(battery) .. "%")

print("Basic tests completed")

-- Exit immediately
System.exit()