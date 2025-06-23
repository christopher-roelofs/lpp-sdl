print("=== Testing if we can load game.lua safely ===")

-- Initialize minimal required globals that game.lua expects
white = Color.new(255,255,255, 255)
gray = Color.new(163, 160, 158)
red = Color.new(255,0,0, 255)
font = Font.load("Assets/Fonts/AllerDisplay.ttf")
Font.setPixelSizes(font, 72)

-- Initialize other variables that game.lua uses
finish = 0
number = 1
maxnumber = 26
numberz = 1
maxnumberz = 4
mode = "game"
extra = "Game started!"
start = 1
words = {}
wordlect = {}
wordbegin = {}
wordnotknow = {}
myword = {}
letters = 0
cross = SCE_CTRL_CROSS
circle = SCE_CTRL_CIRCLE

print("About to load game.lua with dofile...")

-- This is the exact call that happens in index.lua line 123
dofile("game.lua")