-- Debug what's happening in file existence check
print("Testing path:", "/home/christopher/Documents/Development/lpp-sdl/tests/games/3ds/pixelroad_1.0/levels/2.bmp")
print("File exists:", System.doesFileExist("/home/christopher/Documents/Development/lpp-sdl/tests/games/3ds/pixelroad_1.0/levels/2.bmp"))

print("\nTesting relative path:", "levels/2.bmp")  
print("File exists:", System.doesFileExist("levels/2.bmp"))

print("\nTesting with ./:", "./levels/2.bmp")
print("File exists:", System.doesFileExist("./levels/2.bmp"))

System.exit()