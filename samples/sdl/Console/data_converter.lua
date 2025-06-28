-- Data Converter - Console Mode
-- Run with: ./lpp_sdl -headless samples/sdl/Console/data_converter.lua
-- Demonstrates data processing and format conversion

print("=== Data Converter Utility (Console Mode) ===")
print("Converting data between formats without GUI...")

-- Sample data to work with
local sample_data = {
    {name = "Player1", score = 15420, level = 12, health = 85.5, active = true},
    {name = "Player2", score = 8930, level = 8, health = 92.0, active = false},
    {name = "Player3", score = 22100, level = 15, health = 78.3, active = true},
    {name = "Player4", score = 5670, level = 5, health = 100.0, active = true},
    {name = "Player5", score = 18750, level = 11, health = 67.8, active = false}
}

-- Create input file in CSV format
local function create_sample_csv()
    print("\n1. Creating sample CSV data...")
    
    local csv_content = "Name,Score,Level,Health,Active\n"
    for _, player in ipairs(sample_data) do
        csv_content = csv_content .. string.format("%s,%d,%d,%.1f,%s\n",
            player.name, player.score, player.level, player.health, 
            player.active and "true" or "false")
    end
    
    local file_handle = System.openFile("players.csv", "w")
    if file_handle then
        System.writeFile(file_handle, csv_content)
        System.closeFile(file_handle)
        print("   ✓ Created players.csv")
        return true
    else
        print("   ✗ Failed to create CSV file")
        return false
    end
end

-- Parse CSV file
local function parse_csv(filename)
    print("\n2. Reading and parsing CSV...")
    
    if not System.doesFileExist(filename) then
        print("   ✗ CSV file not found:", filename)
        return nil
    end
    
    local file_handle = System.openFile(filename, "r")
    if not file_handle then
        print("   ✗ Failed to open CSV file")
        return nil
    end
    
    local size = System.sizeFile(file_handle)
    local content = System.readFile(file_handle, size)
    System.closeFile(file_handle)
    
    local lines = {}
    for line in content:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
    
    if #lines < 2 then
        print("   ✗ Invalid CSV format")
        return nil
    end
    
    -- Parse header
    local header = {}
    for field in lines[1]:gmatch("[^,]+") do
        table.insert(header, field)
    end
    
    -- Parse data rows
    local data = {}
    for i = 2, #lines do
        local row = {}
        local field_index = 1
        for field in lines[i]:gmatch("[^,]+") do
            local key = header[field_index]:lower()
            
            -- Convert data types
            if key == "score" or key == "level" then
                row[key] = tonumber(field)
            elseif key == "health" then
                row[key] = tonumber(field)
            elseif key == "active" then
                row[key] = field == "true"
            else
                row[key] = field
            end
            
            field_index = field_index + 1
        end
        table.insert(data, row)
    end
    
    print("   ✓ Parsed", #data, "records from CSV")
    return data
end

-- Convert to JSON format
local function convert_to_json(data)
    print("\n3. Converting to JSON format...")
    
    local function escape_json_string(str)
        return str:gsub('"', '\\"'):gsub('\n', '\\n'):gsub('\r', '\\r')
    end
    
    local function value_to_json(value)
        if type(value) == "string" then
            return '"' .. escape_json_string(value) .. '"'
        elseif type(value) == "number" then
            return tostring(value)
        elseif type(value) == "boolean" then
            return value and "true" or "false"
        else
            return "null"
        end
    end
    
    local json_lines = {"["}
    
    for i, record in ipairs(data) do
        local record_parts = {"  {"}
        
        local field_count = 0
        for key, value in pairs(record) do
            field_count = field_count + 1
        end
        
        local current_field = 0
        for key, value in pairs(record) do
            current_field = current_field + 1
            local comma = current_field < field_count and "," or ""
            table.insert(record_parts, string.format('    "%s": %s%s', key, value_to_json(value), comma))
        end
        
        table.insert(record_parts, "  }")
        
        local record_json = table.concat(record_parts, "\n")
        if i < #data then
            record_json = record_json .. ","
        end
        
        table.insert(json_lines, record_json)
    end
    
    table.insert(json_lines, "]")
    
    local json_content = table.concat(json_lines, "\n")
    
    local file_handle = System.openFile("players.json", "w")
    if file_handle then
        System.writeFile(file_handle, json_content)
        System.closeFile(file_handle)
        print("   ✓ Created players.json")
        return true
    else
        print("   ✗ Failed to create JSON file")
        return false
    end
end

-- Convert to XML format
local function convert_to_xml(data)
    print("\n4. Converting to XML format...")
    
    local function escape_xml(str)
        return str:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"):gsub("'", "&apos;")
    end
    
    local xml_lines = {'<?xml version="1.0" encoding="UTF-8"?>', '<players>'}
    
    for _, record in ipairs(data) do
        table.insert(xml_lines, "  <player>")
        
        for key, value in pairs(record) do
            local xml_value
            if type(value) == "string" then
                xml_value = escape_xml(value)
            else
                xml_value = tostring(value)
            end
            table.insert(xml_lines, string.format("    <%s>%s</%s>", key, xml_value, key))
        end
        
        table.insert(xml_lines, "  </player>")
    end
    
    table.insert(xml_lines, "</players>")
    
    local xml_content = table.concat(xml_lines, "\n")
    
    local file_handle = System.openFile("players.xml", "w")
    if file_handle then
        System.writeFile(file_handle, xml_content)
        System.closeFile(file_handle)
        print("   ✓ Created players.xml")
        return true
    else
        print("   ✗ Failed to create XML file")
        return false
    end
end

-- Generate summary report
local function generate_summary(data)
    print("\n5. Generating data summary...")
    
    -- Calculate statistics
    local total_score = 0
    local total_level = 0
    local total_health = 0
    local active_count = 0
    local max_score = 0
    local max_level = 0
    local top_player = ""
    
    for _, player in ipairs(data) do
        total_score = total_score + player.score
        total_level = total_level + player.level
        total_health = total_health + player.health
        
        if player.active then
            active_count = active_count + 1
        end
        
        if player.score > max_score then
            max_score = player.score
            top_player = player.name
        end
        
        if player.level > max_level then
            max_level = player.level
        end
    end
    
    local count = #data
    local summary = string.format([[
=== Player Data Analysis Summary ===
Generated: %s
Processing Mode: Console/Headless

=== STATISTICS ===
Total Players: %d
Active Players: %d (%.1f%%)
Inactive Players: %d (%.1f%%)

=== AVERAGES ===
Average Score: %.1f
Average Level: %.1f
Average Health: %.1f%%

=== RECORDS ===
Highest Score: %d (%s)
Highest Level: %d
Total Combined Score: %d

=== FILES GENERATED ===
✓ players.csv  - Comma Separated Values
✓ players.json - JavaScript Object Notation  
✓ players.xml  - Extensible Markup Language
✓ summary.txt  - This analysis report

=== CONVERSION INFO ===
Data processed entirely in console mode
No GUI components required
Perfect for automated data pipelines
Suitable for server-side processing

Generated by LPP-SDL Data Converter
]], 
        os.date("%Y-%m-%d %H:%M:%S"),
        count,
        active_count, (active_count / count) * 100,
        count - active_count, ((count - active_count) / count) * 100,
        total_score / count,
        total_level / count,
        total_health / count,
        max_score, top_player,
        max_level,
        total_score
    )
    
    local file_handle = System.openFile("summary.txt", "w")
    if file_handle then
        System.writeFile(file_handle, summary)
        System.closeFile(file_handle)
        print("   ✓ Created summary.txt")
        return true
    else
        print("   ✗ Failed to create summary file")
        return false
    end
end

-- Main execution
print("Starting data conversion process...")

-- Step 1: Create sample data
if not create_sample_csv() then
    print("❌ Failed to create sample data")
    System.exit()
    return
end

-- Step 2: Parse the CSV
local data = parse_csv("players.csv")
if not data then
    print("❌ Failed to parse CSV data")
    System.exit()
    return
end

-- Step 3 & 4: Convert to other formats
local json_success = convert_to_json(data)
local xml_success = convert_to_xml(data)

-- Step 5: Generate summary
local summary_success = generate_summary(data)

-- Final report
print("\n📊 Conversion Results:")
print("   CSV Input: ✓ players.csv")
print("   JSON Output:", json_success and "✓ players.json" or "✗ Failed")
print("   XML Output:", xml_success and "✓ players.xml" or "✗ Failed")
print("   Summary Report:", summary_success and "✓ summary.txt" or "✗ Failed")

if json_success and xml_success and summary_success then
    print("\n✅ Data conversion complete!")
    print("📄 All output files generated successfully")
    
    -- Show file sizes
    local files = {"players.csv", "players.json", "players.xml", "summary.txt"}
    print("\n📁 Output Files:")
    for _, filename in ipairs(files) do
        if System.doesFileExist(filename) then
            local handle = System.openFile(filename, "r")
            if handle then
                local size = System.sizeFile(handle)
                System.closeFile(handle)
                print(string.format("   %-15s %d bytes", filename, size))
            end
        end
    end
else
    print("\n⚠️ Some conversions failed")
end

print("\n=== Data Converter Demo Complete ===")
print("This shows how LPP-SDL can handle complex data processing tasks")
print("without requiring any graphical interface - perfect for automation!")

System.exit()