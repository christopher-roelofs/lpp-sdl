-- Password Input Demo
-- Demonstrates the enhanced System.input() function with hidden password input

print("=== Password Input Demo ===")
print()

-- Normal input (visible)
print("1. Normal input (characters visible):")
local username = System.input("Username: ")
if username then
    print("You entered username: " .. username)
else
    print("Error: No input received")
    System.exit()
end
print()

-- Password input (hidden with asterisks)
print("2. Password input (shows asterisks):")
local password = System.input("Password: ", "password")
print("Password received (length: " .. #password .. " characters)")
print()

-- Demonstration of both together
print("3. Login simulation:")
local user = System.input("Login: ")
local pass = System.input("Password: ", "password")
print()
print("Login attempt:")
print("  User: " .. user)
print("  Password: " .. string.rep("*", #pass))
print()

print("✓ Password input now properly hides characters and shows asterisks!")
print("✓ Backspace works to correct mistakes")
print("✓ Usage: System.input(prompt, \"password\") for hidden input")

System.exit()