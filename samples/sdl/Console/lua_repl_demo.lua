-- Lua REPL Command Demonstration
-- This script showcases the new 'lua' command in the REPL

print("=== Lua REPL Command Demo ===")
print()
print("This script demonstrates the new 'lua' command that allows")
print("executing Lua code directly from the REPL!")
print()

print("🎯 Exit this script and try these commands in the REPL:")
print()

print("1. Basic Lua execution:")
print("   lpp-sdl> lua print('Hello from Lua!')")
print("   lpp-sdl> lua print(2 + 2)")
print("   lpp-sdl> lua print(math.sqrt(16))")
print()

print("2. System function calls:")
print("   lpp-sdl> lua print('Current dir:', System.currentDirectory())")
print("   lpp-sdl> lua local files = System.listDirectory('.'); print('Files:', #files)")
print("   lpp-sdl> lua print(System.doesFileExist('README.md'))")
print()

print("3. Interactive input:")
print("   lpp-sdl> lua local name = System.input('Your name: '); print('Hello', name)")
print("   lpp-sdl> lua local age = tonumber(System.input('Age: ')); print('In 10 years:', age + 10)")
print()

print("4. File operations:")
print("   lpp-sdl> lua local f = System.openFile('test.txt', FCREATE)")
print("   lpp-sdl> lua System.writeFile(f, 'Hello World\\n'); System.closeFile(f)")
print("   lpp-sdl> lua print('File created!')")
print()

print("5. Loops and logic:")
print("   lpp-sdl> lua for i=1,5 do print('Count:', i) end")
print("   lpp-sdl> lua if System.doesFileExist('test.txt') then print('Found!') end")
print()

print("6. Variables and calculations:")
print("   lpp-sdl> lua x = 10; y = 20; print('Sum:', x + y)")
print("   lpp-sdl> lua local result = math.random(1, 100); print('Random:', result)")
print()

print("7. Archive operations (with libarchive):")
print("   lpp-sdl> lua local fmt = System.detectArchiveFormat('test.tar.gz')")
print("   lpp-sdl> lua print('Archive format:', fmt)")
print()

print("8. One-liner utilities:")
print("   lpp-sdl> lua print(os.date('%Y-%m-%d %H:%M:%S'))  -- Current timestamp")
print("   lpp-sdl> lua print(string.upper(System.input('Text: ')))  -- Uppercase input")
print("   lpp-sdl> lua local n = tonumber(System.input('Number: ')); print('Square:', n^2)")
print()

print("🚀 Benefits of the 'lua' command:")
print("✓ Direct access to all System.* functions")
print("✓ Full Lua language features (loops, conditions, math)")
print("✓ Interactive programming and testing")
print("✓ Quick calculations and data processing")
print("✓ File manipulation and system operations")
print("✓ Integration with readline for command history")
print("✓ Error handling and debugging")
print()

print("💡 Pro Tips:")
print("• Use tab completion: type 'lu<TAB>' to complete 'lua'")
print("• Command history works: use up/down arrows")
print("• Combine with shell commands: mix 'lua', 'cd', 'list', etc.")
print("• Test Lua code snippets before putting them in scripts")
print("• Use for quick file operations and data processing")
print()

print("🔧 Common Patterns:")
print("• Data validation: lua if not System.doesFileExist('file') then print('Missing!') end")
print("• Quick math: lua print('Result:', (5 + 3) * 2)")
print("• File info: lua local stat = System.statFile('file.txt'); print('Size:', stat.size)")
print("• Interactive config: lua local setting = System.input('Setting: '); print('Got:', setting)")
print()

print("Try it out! Exit this script and run:")
print("  ./lpp_sdl -headless")
print("Then use the 'lua' command to execute Lua code directly!")

System.exit()