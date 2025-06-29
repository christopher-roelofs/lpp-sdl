-- System.clear() Demo
-- Demonstrates the new console clear functionality

print("=== System.clear() Demo ===")
print()
print("This demo will:")
print("1. Show some text")
print("2. Wait for user input")
print("3. Clear the screen") 
print("4. Show new text")
print()

-- Fill screen with some content
for i = 1, 15 do
    print("Line " .. i .. " - This is some test content to fill the screen")
end

print()
print("Press Enter to clear the screen...")
System.input("")

-- Clear the screen
System.clear()

-- Show new content after clearing
print("🎉 Screen cleared successfully!")
print()
print("System.clear() uses ANSI escape codes:")
print("• \\033[2J - Clears entire screen")  
print("• \\033[H - Moves cursor to home position (top-left)")
print()
print("This works in most modern terminals and console environments.")
print()
print("✓ System.clear() function is now available for console scripts!")

System.exit()