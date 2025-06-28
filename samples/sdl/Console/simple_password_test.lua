-- Simple Password Test
print("Testing password input...")

-- Test normal input
print("Enter a username:")
local user = System.input("Username: ")
if user then
    print("Got username: " .. user)
else
    print("No username received")
    System.exit()
end

-- Test password input
print("Enter a password (should show asterisks):")
local pass = System.input("Password: ", "password")
if pass then
    print("Got password of length: " .. #pass)
    print("Password was: " .. pass)  -- For testing only!
else
    print("No password received")
end

print("Done!")
System.exit()