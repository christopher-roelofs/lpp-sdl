-- Debug script to understand color bit layout
function printBits(num, name)
    if num < 0 then
        num = num + 4294967296  -- Convert to unsigned
    end
    local hex = string.format("0x%08X", num)
    print(name .. ": " .. num .. " = " .. hex)
end

green = Color.new(0,255,0)
blue = Color.new(0,0,255)
red = Color.new(255,0,0)
white = Color.new(255,255,255)
black = Color.new(0,0,0)

printBits(green, "Green")
printBits(blue, "Blue") 
printBits(red, "Red")
printBits(white, "White")
printBits(black, "Black")

System.exit()