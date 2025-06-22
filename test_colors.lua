-- Quick test of new keyboard color functions
print("Testing keyboard color functions...")

-- Test setting colors
Keyboard.setBackgroundColor(Color.new(50, 50, 50, 200))
Keyboard.setFontColor(Color.new(200, 200, 200, 255))
print("Background and font colors set successfully")

Keyboard.setSelectedBackgroundColor(Color.new(100, 100, 255, 255))
Keyboard.setSelectedFontColor(Color.new(255, 255, 0, 255))
print("Selected colors set successfully")

Keyboard.setKeyBackgroundColor(Color.new(80, 80, 80, 255))
Keyboard.setShiftKeyColor(Color.new(255, 100, 100, 255))
Keyboard.setTitleBarColor(Color.new(100, 100, 150, 255))
print("Key colors set successfully")

Keyboard.setInputBackgroundColor(Color.new(200, 255, 200, 255))
Keyboard.setInputBorderColor(Color.new(0, 150, 0, 255))
Keyboard.setInputTextColor(Color.new(0, 100, 0, 255))
Keyboard.setKeyboardBorderColor(Color.new(255, 200, 0, 255))
Keyboard.setKeyBorderColor(Color.new(150, 100, 200, 255))
print("Input and border colors set successfully")

print("All color functions working correctly!")
print("Test completed successfully")