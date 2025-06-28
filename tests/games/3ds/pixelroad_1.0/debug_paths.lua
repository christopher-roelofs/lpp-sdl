-- Debug file paths
print("Current directory:", System.currentDirectory())

-- Test all level files
for i = 1, 6 do
    local path = System.currentDirectory().."/levels/"..i..".bmp"
    local exists = System.doesFileExist(path)
    print("Level " .. i .. " path:", path)
    print("Level " .. i .. " exists:", exists)
end

System.exit()