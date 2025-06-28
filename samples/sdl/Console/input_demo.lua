-- Console Input Demonstration
-- This script demonstrates System.input() for user interaction

print("=== Console Input Demo ===")
print("This script demonstrates System.input() - Python-style user input for console scripts")
print()

-- Simple input without prompt
print("1. Basic input (no prompt):")
local basic = System.input()
print("   You entered: '" .. (basic or "nil") .. "'")
print()

-- Input with prompt
print("2. Input with prompt:")
local name = System.input("What's your name? ")
print("   Hello, " .. (name or "Anonymous") .. "!")
print()

-- Numeric input with validation
print("3. Numeric input with validation:")
local age
while true do
    local input = System.input("Enter your age (number): ")
    if not input then
        print("   Input cancelled.")
        break
    end
    
    age = tonumber(input)
    if age then
        print("   You are " .. age .. " years old.")
        break
    else
        print("   Please enter a valid number.")
    end
end
print()

-- Menu selection
print("4. Menu selection:")
print("   Choose an option:")
print("   1. Process files")
print("   2. Show system info")
print("   3. Exit demo")

local choice = System.input("Enter choice (1-3): ")
if choice == "1" then
    print("   You chose: Process files")
    
    -- File processing simulation
    local pattern = System.input("   Enter file pattern (e.g., *.lua): ")
    print("   Processing files matching: " .. (pattern or "*.lua"))
    
    -- List matching files
    local files = System.listDirectory(".")
    if files then
        local count = 0
        for _, file in ipairs(files) do
            if not file.directory and file.name:match("%.lua$") then
                count = count + 1
                if count <= 3 then
                    print("     Found: " .. file.name)
                end
            end
        end
        if count > 3 then
            print("     ... and " .. (count - 3) .. " more files")
        end
        print("   Total Lua files found: " .. count)
    end
    
elseif choice == "2" then
    print("   You chose: Show system info")
    print("   Current directory: " .. System.currentDirectory())
    print("   Platform: " .. (os.getenv("OS") or "Linux/Unix"))
    
elseif choice == "3" then
    print("   You chose: Exit demo")
    
else
    print("   Invalid choice: " .. (choice or "nil"))
end
print()

-- Password-style input (not hidden, but demonstrates the concept)
print("5. Sensitive input:")
local password = System.input("Enter a secret word: ")
if password and #password > 0 then
    print("   Secret word has " .. #password .. " characters")
    print("   First character: " .. password:sub(1,1))
    print("   Last character: " .. password:sub(-1))
else
    print("   No secret word entered")
end
print()

-- Multi-line input simulation
print("6. Multi-line input simulation:")
print("   Enter multiple lines (empty line to finish):")
local lines = {}
local line_num = 1
while true do
    local line = System.input("   Line " .. line_num .. ": ")
    if not line or line == "" then
        break
    end
    table.insert(lines, line)
    line_num = line_num + 1
end

if #lines > 0 then
    print("   You entered " .. #lines .. " lines:")
    for i, line in ipairs(lines) do
        print("     " .. i .. ". " .. line)
    end
    
    -- Save to file
    local save = System.input("   Save to file? (y/N): ")
    if save and save:lower() == "y" then
        local filename = System.input("   Filename: ")
        if filename and #filename > 0 then
            local file = System.openFile(filename, FCREATE)
            if file then
                for _, line in ipairs(lines) do
                    System.writeFile(file, line .. "\n")
                end
                System.closeFile(file)
                print("   Saved to: " .. filename)
            else
                print("   Failed to create file: " .. filename)
            end
        end
    end
else
    print("   No lines entered")
end
print()

-- Interactive calculator
print("7. Interactive calculator:")
print("   Enter mathematical expressions (type 'quit' to exit):")
while true do
    local expr = System.input("   calc> ")
    if not expr or expr:lower() == "quit" or expr:lower() == "exit" then
        break
    end
    
    if expr == "" then
        goto continue
    end
    
    -- Simple expression evaluation (be careful with load!)
    local success, result = pcall(load("return " .. expr))
    if success and type(result) == "number" then
        print("   = " .. result)
    else
        print("   Error: Invalid expression")
    end
    
    ::continue::
end
print()

print("=== Input Demo Features ===")
print("✓ Basic input with and without prompts")
print("✓ Input validation and loops")
print("✓ Menu systems and user choices")
print("✓ Multi-line input collection")
print("✓ File operations based on user input")
print("✓ Interactive applications (calculator)")
print()

if name and name ~= "" then
    print("Thanks for trying the input demo, " .. name .. "!")
else
    print("Thanks for trying the input demo!")
end
print()

print("🆕 Enhanced Features:")
print("• With readline: Line editing, history, tab completion")
print("• Without readline: Simple but reliable input")
print("• Cross-platform: Works on Linux, macOS, Windows")
print("• Python-compatible: Same behavior as Python's input()")
print()

print("📝 Usage Examples:")
print("  local name = System.input('Name: ')      -- With prompt")
print("  local data = System.input()              -- No prompt")
print("  if not data then                         -- Handle EOF/cancel")
print("    print('Input cancelled')")
print("  end")
print()

print("Input demo completed!")
System.exit()