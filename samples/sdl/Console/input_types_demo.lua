-- Input Types Demo
-- Demonstrates the new string-based System.input() types

print("=== System.input() Types Demo ===")
print()

print("Current input types supported:")
print("• 'normal' (default) - Visible characters")
print("• 'password' - Hidden with asterisks")
print()

-- Normal input (default behavior)
print("1. Normal input (default):")
local name = System.input("Enter your name: ")
print("You entered: " .. (name or "nil"))
print()

-- Explicit normal input
print("2. Explicit normal input:")
local email = System.input("Enter email: ", "normal")
print("Email: " .. (email or "nil"))
print()

-- Password input
print("3. Password input (shows asterisks):")
local password = System.input("Enter password: ", "password")
print("Password length: " .. #(password or ""))
print()

-- Future extensibility example
print("4. Future input types could include:")
print("• 'numeric' - Only allow numbers")
print("• 'email' - Validate email format")
print("• 'phone' - Format phone numbers")
print("• 'hidden' - Completely invisible (no asterisks)")
print()

print("✓ String-based input types allow for future expansion")
print("✓ Backward compatible - no second parameter defaults to 'normal'")
print("✓ Current usage:")
print("  - System.input(prompt)           # normal input")
print("  - System.input(prompt, 'normal') # normal input")
print("  - System.input(prompt, 'password') # password input")

System.exit()