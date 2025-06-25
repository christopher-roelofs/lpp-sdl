-- Loading a TTF font
local fnt = Font.load("main.ttf")
local otf = Font.load("LibertinusSerif-Semibold.otf")
defaultFont = Font.load()

-- Main loop
while true do

	-- Starting GPU rendering
	Graphics.initBlend()
	
	-- Clearing screen
	Screen.clear()
	
	-- Drawing something on screen
	Font.print(fnt, 5, 45, "This is a local ttf font", Color.new(255, 255, 255))
	Font.print(otf, 5, 100, "This is a local otf font", Color.new(255, 255, 255))
	Font.print(defaultFont, 5, 150, "This is the default font", Color.new(255, 255, 255))
	Font.print(fnt, 5, 200, "Press ESC to exit.", Color.new(255, 255, 255))
	
	-- Terminating GPU rendering
	Graphics.termBlend()
	
	-- Updating screen
	Screen.flip()
	
	-- Check for input
	if Controls.check(Controls.read(), SCE_CTRL_TRIANGLE) then
		Font.unload(fnt)
		break
	end
	
end