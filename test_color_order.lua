-- Test Color.new parameter order
c1 = Color.new(255, 0, 0)  -- Should be red
c2 = Color.new(0, 255, 0)  -- Should be green  
c3 = Color.new(0, 0, 255)  -- Should be blue

print("Color.new(255,0,0):", c1)  -- Expected: 0xFF0000FF
print("Color.new(0,255,0):", c2)  -- Expected: 0xFF00FF00  
print("Color.new(0,0,255):", c3)  -- Expected: 0xFFFF0000

System.exit()