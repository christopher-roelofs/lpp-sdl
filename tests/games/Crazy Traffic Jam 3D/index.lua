-- Loading resources
Sound.init()
local snd = Sound.openWav("data/Resources/horn.wav")
local logo = Graphics.loadImage("logo.png")
local bg = Graphics.loadImage("bg.png")

local black_transparent = Color.new(0, 0, 0, 100)

-- Initializing oldpad variable
oldpad = SCE_CTRL_CROSS

-- Used colors
local white = Color.new(255, 255, 255)

imgalpha = 255
startdelay = 40.0

showcredits = false
showscores = false
local hiscore = 0


-- Main loop
while true do
	if startdelay>0 then
		startdelay = startdelay - 0.1
	else
		startdelay=0
		if imgalpha>0 then
			imgalpha = imgalpha - 1
		end
	end
	
	-- Starting drawing phase
	Graphics.initBlend()
	
	-- Drawing background
	Graphics.drawImage(0,0, bg)
	
	if showcredits == true then
		-- CREDITS
		Graphics.fillRect(0, 260, 0, 518, black_transparent)
		Graphics.debugPrint(20, 50, "CREDITS\n\nDeveloped by\nVitaHEX Games\n\nPROGRAMMING, ART\nSakis Rg\n\nMUSIC\nwww.bensound.com\n\nEngine used\nLua Player Plus by\nRinnegatamante", white)
	end
	if showscores == true then
		-- CREDITS
		Graphics.fillRect(960, 700, 0, 518, black_transparent)
		Graphics.debugPrint(720, 50, "HI-SCORES\n\nBest: " .. hiscore, white)
	end
	
	-- Drawing description
	Graphics.debugPrint(20, 522, "© 2017  VitaHEX Games | www.patreon.com/vitahex", white)
	
	-- Drawing top right corner
	--Graphics.debugPrint(700, 5, "Press START to exit.", white)
		

	if imgalpha>0 then
	Graphics.drawImage(0,0, logo, Color.new(255, 255, 255, imgalpha))
	end
	
	-- Terminating drawing phase
	Graphics.termBlend()
	Screen.flip()
	
	-- Controls checking
	pad = Controls.read()
	if imgalpha<1 then
		if Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS) then
		Sound.play(snd, NO_LOOP)
		dofile("data/gameplay.lua")
		end
		if Controls.check(pad, SCE_CTRL_SQUARE) then
		showcredits = true
		else
		showcredits = false
		end
		if Controls.check(pad, SCE_CTRL_CIRCLE) then
			if System.doesFileExist("data/CTJ3Dsave.txt") then
			handle = System.openFile("data/CTJ3Dsave.txt", FREAD)
			hiscore = System.readFile(handle, 10) 
			System.closeFile(handle)
			end
		showscores = true
		else
		showscores = false
		end
	end
	
	-- Saving old controls scheme
	oldpad = pad
	
end