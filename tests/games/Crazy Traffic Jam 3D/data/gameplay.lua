-- Setting PSVITA at maximum speed
System.setCpuSpeed(444)
System.setBusSpeed(222)
System.setGpuSpeed(222)
System.setGpuXbarSpeed(166)
Sound.init()

local snd = Sound.openWav("data/Resources/impact.wav")
local sndcoin = Sound.openWav("data/Resources/coin.wav")
local sndboost = Sound.openWav("data/Resources/boost.wav")
local music = Sound.openOgg("data/Resources/main.ogg")
Sound.play(music, LOOP)

local crashbg = Graphics.loadImage("data/Resources/crash.png")

-- Load textures
local texturecar = Graphics.loadImage("data/Resources/car.png")
local texturecarb = Graphics.loadImage("data/Resources/carb.png")
local texturecarc = Graphics.loadImage("data/Resources/carc.png")
local texturecard = Graphics.loadImage("data/Resources/card.png")
local texturecare = Graphics.loadImage("data/Resources/truck.png")

local texturemap = Graphics.loadImage("data/Resources/map.png")
local texturedecor = Graphics.loadImage("data/Resources/decor.png")
local texturecoin = Graphics.loadImage("data/Resources/coin.png")
local texlightning = Graphics.loadImage("data/Resources/lightning.png")

-- Load models
local modCar = Render.loadObject("data/Resources/car.obj", texturecar)
local modCarb = Render.loadObject("data/Resources/car.obj", texturecarb)
local modCarc = Render.loadObject("data/Resources/car.obj", texturecarc)
local modCard = Render.loadObject("data/Resources/car.obj", texturecard)
local modCare = Render.loadObject("data/Resources/truck.obj", texturecare)

local modRoad = Render.loadObject("data/Resources/map.obj", texturemap)
local modDecor = Render.loadObject("data/Resources/decor.obj", texturedecor)
local modCoin = Render.loadObject("data/Resources/coin.obj", texturecoin)
local modLightning = Render.loadObject("data/Resources/lightning.obj", texlightning)

-- Loading a TTF font
local fnt = Font.load("data/Resources/main.ttf")
local timer = Timer.new()
Font.setPixelSizes(fnt, 38)

local black_transparent = Color.new(0, 0, 0, 80)

hiscore = 0
	if System.doesFileExist("data/CTJ3Dsave.txt") then
		handle = System.openFile("data/CTJ3Dsave.txt", FREAD)
		hiscore = tonumber(System.readFile(handle, 10))
		System.closeFile(handle)
	end
			
-- Set default angle, position and translation values
playerz = -20.0
playerx = 0.0
playery = -4.0

angleX = 0.0
angleY = 180.0
translX = 0.0017
translY = 0.0005
roadY = 0.0

gameSpeed = 0.025
extraspeed = 0.0
turboTimer = 0.0

score = 0.0
totalScore = 0
coins = 0

tmpscore = 0.0

crashed = false
paused = false

-- Coin position
coinx = -1 + math.ceil(math.random(0, 2))
coiny = 80 + math.ceil(math.random(0, 180))
coinRot = 80 + math.ceil(math.random(0, 180))
-- Turbo position
turbox = -1 + math.ceil(math.random(0, 2))
turboy = 80 + math.ceil(math.random(0, 180))

-- Traffic cars
carAx = -1 + math.ceil(math.random(0, 2))
carAy = 15 + math.ceil(math.random(0, 5))
carBx = -1 + math.ceil(math.random(0, 2))
carBy = 25 + math.ceil(math.random(0, 5))
carCx = -1 + math.ceil(math.random(0, 2))
carCy = 35 + math.ceil(math.random(0, 5))
carDx = -1 + math.ceil(math.random(0, 2))
carDy = 45 + math.ceil(math.random(0, 5))

-- Main loop
while true do
	
	if crashed == false and paused == false then
		roadY = roadY - gameSpeed+extraspeed
		coiny = coiny - (gameSpeed/1.3)+extraspeed
		turboy = turboy - (gameSpeed/1.3)+extraspeed
		coinRot = coinRot + 0.6
		carAy = carAy - (gameSpeed/1.3)+extraspeed
		carBy = carBy - (gameSpeed/1.3)+extraspeed
		carCy = carCy - (gameSpeed/1.3)+extraspeed
		carDy = carDy - (gameSpeed/1.3)+extraspeed
	
		if angleY<180 then
			angleY = angleY + 0.3
		end	
		if angleY>180 then
			angleY = angleY - 0.3
		end
	
	
		if turboTimer>0 then
		tmpscore = tmpscore + 0.2
		else
		tmpscore = tmpscore + 0.1
		end
		
		if tmpscore>5 then
			tmpscore=0
			score = score + 1
		end
	
	end
	
	if roadY<-27 then
	roadY = 27
	end
	
	if turboTimer>0 then
	turboTimer = turboTimer - 0.05
	extraspeed = -0.05
	else
	extraspeed = 0
	turboTimer = 0
	end
	
	if carAy<-55 then
	carAx = (-1 + math.ceil(math.random(0, 2)))*2.2
	carAy = 15-- + math.ceil(math.random(0, 5))
		-- Increase game speed by time
		if gameSpeed<0.054 then
		gameSpeed = gameSpeed + 0.001
		end
	end		
	if carBy<-45 then
	carBx = (-1 + math.ceil(math.random(0, 2)))*2.2
	carBy = 25-- + math.ceil(math.random(0, 5))
	end	
	if carCy<-35 then
	carCx = (-1 + math.ceil(math.random(0, 2)))*2.2
	carCy = 35-- + math.ceil(math.random(0, 5))
	end
	if carDy<-25 then
	carDx = (-1 + math.ceil(math.random(0, 2)))*2.2
	carDy = 45-- + math.ceil(math.random(0, 5))
	end
	
	if coiny<-20 then
	coinx = (-1 + math.ceil(math.random(0, 2)))*2.2
	coiny = 50 + math.ceil(math.random(0, 250))
	end
	
	if turboy<-20 then
	turbox = (-1 + math.ceil(math.random(0, 2)))*2.2
	turboy = 100 + math.ceil(math.random(0, 650))
	end
	
	-- Blend the model with info on screen
	Graphics.initBlend()
	Screen.clear()
	
	-- Items
	Render.drawModel(modCoin, coinx, coiny, -20, 60, coinRot)
	Render.drawModel(modLightning, turbox, turboy, -20, 60, coinRot)

	-- Traffic cars
	Render.drawModel(modCarb, carAx, carAy, -20, 90, 180)
	Render.drawModel(modCarc, carBx, carBy, -20, 90, 180)
	Render.drawModel(modCard, carCx, carCy, -20, 90, 180)
	Render.drawModel(modCare, carDx, carDy, -20, 90, 180)
	if turboTimer==0 then
	-- Player collisions
		if playerx < carAx+1.6 and playerx > carAx-1.6 and playery < carAy+2.8 and  playery > carAy-2.8 then
			if crashed == false then
			crashed = true
			totalScore = score+(coins*100)
			Sound.pause(music)
			Sound.play(snd, NO_LOOP)
			gameSpeed = 0
			end
		end
		if playerx < carBx+1.6 and playerx > carBx-1.6 and playery < carBy+2.8 and  playery > carBy-2.8 then
			if crashed == false then
			crashed = true
			totalScore = score+(coins*100)
			Sound.pause(music)
			Sound.play(snd, NO_LOOP)
			gameSpeed = 0
			end
		end
		if playerx < carCx+1.6 and playerx > carCx-1.6 and playery < carCy+2.8 and  playery > carCy-2.8 then
			if crashed == false then
			crashed = true
			totalScore = score+(coins*100)
			Sound.pause(music)
			Sound.play(snd, NO_LOOP)
			gameSpeed = 0
			end
		end
		if playerx < carDx+1.6 and playerx > carDx-1.6 and playery < carDy+3.5 and  playery > carDy-3.5 then
			if crashed == false then
			crashed = true
			totalScore = score+(coins*100)
			Sound.pause(music)
			Sound.play(snd, NO_LOOP)
			gameSpeed = 0
			end
		end
	end
		if playerx < coinx+1.6 and playerx > coinx-1.6 and playery < coiny+1.6 and  playery > coiny-1.6 then
			coinx = (-1 + math.ceil(math.random(0, 2)))*2.2
			coiny = 50 + math.ceil(math.random(0, 200))
			coins = coins + 1;
			Sound.play(sndcoin, NO_LOOP)
		end
		if playerx < turbox+1.6 and playerx > turbox-1.6 and playery < turboy+1.6 and  playery > turboy-1.6 then
			turbox = (-1 + math.ceil(math.random(0, 2)))*2.2
			turboy = 200 + math.ceil(math.random(0, 650))
			turboTimer = 40
			Sound.play(sndboost, NO_LOOP)
		end
	
	Render.drawModel(modCar, playerx, playery, playerz, 90, angleY)
	Render.drawModel(modRoad, 0.0, roadY, -21.0, 90, 0.0)
	Render.drawModel(modDecor, 0.0, roadY, -21.0, 90, 0.0)
		
	if paused == true then
		-- PAUSE
		Graphics.fillRect(0, 960, 0, 544, black_transparent)
		Font.print(fnt, 334, 184, "        PAUSED\n\nCIRCLE to Resume\nTRIANGLE to Quit", Color.new(0, 0, 0))--shadow
		Font.print(fnt, 330, 180, "        PAUSED\n\nCIRCLE to Resume\nTRIANGLE to Quit", Color.new(255, 255, 255))
	end
		
	if crashed == false then
		-- Drawing Score
		Font.print(fnt, 11, 7, "Score= " .. score, Color.new(0, 0, 0))--shadow
		Font.print(fnt, 8, 4, "Score= " .. score, Color.new(247, 181, 13))
	
		-- Drawing Coins
		Font.print(fnt, 11, 47, "Coins= " .. coins, Color.new(0, 0, 0))--shadow
		Font.print(fnt, 8, 44, "Coins= " .. coins, Color.new(247, 181, 13))
	else
		-- Game Over
		Graphics.drawImage(0,0, crashbg)
		Font.print(fnt, 374, 224, "Score= " .. score .. "\nCoins= " .. coins .. " x100\nTotal= " .. totalScore, Color.new(0, 0, 0))--shadow
		Font.print(fnt, 370, 220, "Score= " .. score .. "\nCoins= " .. coins .. " x100\nTotal= " .. totalScore, Color.new(250, 210, 0))
	
	
	end
	
	Graphics.termBlend()
	Screen.flip()

	-- Controls checking
	pad = Controls.read()
	if crashed == false and paused == false then
		if Controls.check(pad, SCE_CTRL_LEFT) and not Controls.check(oldpad, SCE_CTRL_LEFT) then	
			if playerx>-3.5 then
			playerx = playerx - 0.02
				if angleY<195 then
				angleY = angleY + 0.6
				end
			end
		elseif Controls.check(pad, SCE_CTRL_RIGHT) and not Controls.check(oldpad, SCE_CTRL_RIGHT) then
			if playerx<3.5 then
			playerx = playerx + 0.02
				if angleY>165 then
				angleY = angleY - 0.6
				end
			end
		elseif Controls.check(pad, SCE_CTRL_START) and not Controls.check(oldpad, SCE_CTRL_START) then
			paused = true
		end
	end
	
	if Controls.check(Controls.read(), SCE_CTRL_CIRCLE) and paused == true then
		paused = false
	end
		
	-- Exit game
	if Controls.check(Controls.read(), SCE_CTRL_TRIANGLE) then
		if crashed == true then 
			if totalScore>hiscore then
			-- Saving score
			if System.doesFileExist("data/CTJ3Dsave.txt") then
				handle = System.openFile("data/CTJ3Dsave.txt", FWRITE)
			else
				handle = System.openFile("data/CTJ3Dsave.txt", FCREATE)
			end
			System.writeFile(handle, "" .. totalScore, string.len(totalScore))
			System.closeFile(handle)
			end
		end

		if paused == true or crashed == true then
		Render.unloadModel(modCar)
		Render.unloadModel(modCarb)
		Render.unloadModel(modCarc)
		Render.unloadModel(modCard)
		Render.unloadModel(modCare)
		Render.unloadModel(modRoad)
		Render.unloadModel(modCoin)
		Render.unloadModel(modDecor)
		Render.unloadModel(modLightning)
		Graphics.freeImage(texturecar)
		Graphics.freeImage(texturecarb)
		Graphics.freeImage(texturecarc)
		Graphics.freeImage(texturecard)
		Graphics.freeImage(texturecare)
		Graphics.freeImage(texturecoin)
		Graphics.freeImage(texturemap)
		Graphics.freeImage(texturedecor)
		Graphics.freeImage(crashbg)
		Graphics.freeImage(texlightning)
		
		Timer.destroy(timer)
		Sound.close(music)
		break
		end
	end
   
end
