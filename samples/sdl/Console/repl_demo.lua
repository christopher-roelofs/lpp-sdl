-- REPL Demo Script
-- This script demonstrates the power of the console REPL
-- Run from REPL with: run repl_demo.lua

print("=== Console REPL Demo Script ===")
print("This script was executed from the interactive console!")
print("")

-- Show some system information
print("📍 Current Working Directory:", System.currentDirectory())

-- Create a small demo file
local demo_file = "repl_demo_output.txt"
local timestamp = os.date("%Y-%m-%d %H:%M:%S")
local content = string.format([[
REPL Demo Output
Generated: %s
Working Directory: %s

This file was created by a Lua script executed through
the LPP-SDL Console REPL. This demonstrates how you can:

1. Navigate directories with 'cd' and 'list'
2. Run scripts with 'run <filename>'
3. Use full Lua scripting capabilities
4. Access file system operations
5. Process data without any GUI

The console REPL makes LPP-SDL perfect for:
- Server automation
- Script development and testing
- File processing workflows
- Command-line utilities
- Educational purposes

Try these REPL commands after this script finishes:
  pwd
  list
  cd ..
  list
  cd samples/sdl/Console
  run data_converter.lua
]], timestamp, System.currentDirectory())

-- Write the demo file
local file_handle = System.openFile(demo_file, "w")
if file_handle then
    System.writeFile(file_handle, content)
    System.closeFile(file_handle)
    print("✅ Created demo output file:", demo_file)
else
    print("❌ Failed to create demo file")
end

-- Show directory contents
print("\n📁 Current directory contents:")
local files = System.listDirectory(".")
if files and #files > 0 then
    for i = 1, math.min(5, #files) do
        local file = files[i]
        local type_str = file.directory and "[DIR]" or "[FILE]"
        print(string.format("   %s %s", type_str, file.name))
    end
    if #files > 5 then
        print(string.format("   ... and %d more items", #files - 5))
    end
else
    print("   No files found")
end

print("\n🎯 Demo complete! The console REPL gives you full control")
print("   over script execution and file system navigation.")
print("\n💡 Try running other scripts from the REPL:")
print("   run index.lua")
print("   run file_processor.lua") 
print("   run data_converter.lua")

print("\n🆕 Enhanced REPL Features:")
print("   • Tab completion for commands and file paths")
print("   • Command history (up/down arrows)")
print("   • Line editing (left/right, home/end)")
print("   • Persistent history (.lpp_sdl_history)")
print("\n🚀 Console REPL makes LPP-SDL a powerful automation tool!")

-- Exit cleanly
System.exit()