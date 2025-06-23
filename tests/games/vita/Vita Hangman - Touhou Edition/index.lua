white = Color.new (255,255,255)
red = Color.new(255,0,0)
blue = Color.new(0,0,255)
black = Color.new(0,0,0)
green = Color.new(0,204,0)

Sound.init()
local snd_menu = Sound.open("Assets/Audio/MenuBGM.ogg")

local menu_background = Graphics.loadImage("Assets/Graphics/menu_background.png")

stat1 = Graphics.loadImage("Assets/Graphics/STATE1.png")
stat2 = Graphics.loadImage("Assets/Graphics/STATE2.png")
stat3 = Graphics.loadImage("Assets/Graphics/STATE3.png")
stat4 = Graphics.loadImage("Assets/Graphics/STATE4.png")
stat5 = Graphics.loadImage("Assets/Graphics/STATE5.png")
stat6 = Graphics.loadImage("Assets/Graphics/STATE6.png")
stat7 = Graphics.loadImage("Assets/Graphics/STATE7.png")

font = Font.load("Assets/Fonts/AllerDisplay.ttf")
font2 = Font.load("Assets/Fonts/Revue.ttf")
Font.setPixelSizes(font, 32)
Font.setPixelSizes(font2, 48)

cross = SDLK_RETURN

number = 1
maxnumber = 3

filePrefix = "data/hang"

if not System.doesFileExist(filePrefix) then
	System.createDirectory(filePrefix) 
end

if not System.doesFileExist(filePrefix.."/WORDS.TXT") then
	database = System.openFile("Assets/Data/WORDS.TXT",FREAD)
	words = System.readFile(database, System.sizeFile(database))
	System.closeFile(database)
	database = System.openFile(filePrefix.."/WORDS.TXT", FCREATE)
	System.writeFile(database,words,string.len(words)) 
	System.closeFile(database)
end

function GarbageCollection()
	Graphics.freeImage(stat1)
	Graphics.freeImage(stat2)
	Graphics.freeImage(stat3)
	Graphics.freeImage(stat4)
	Graphics.freeImage(stat5)
	Graphics.freeImage(stat6)
	Graphics.freeImage(stat7)
	Font.unload(font)
	Font.unload(font2)
end

function checkInput(title, default)
	Keyboard.show(title, default)
	text = ""
	while true do
		Graphics.initBlend()
		Screen.clear()
		kState = Keyboard.getState()
		if kState ~= RUNNING then
			if kState ~= CANCELED then
				text = Keyboard.getInput()
			end
			Keyboard.clear()
			break
		end
		Graphics.termBlend()
		Screen.flip()
		Screen.waitVblankStart()
	end
	return text
end

go = 0
oldpad = Controls.read()
while true do
	Graphics.initBlend()
	Screen.clear()
	if(Sound.isPlaying(snd_menu) == false) then
	Sound.play(snd_menu, LOOP)
	end
	Graphics.drawImage(0, 0, menu_background)
	pad = Controls.read()
	if Controls.check(pad,SCE_CTRL_LEFT) and not Controls.check(oldpad,SCE_CTRL_LEFT) then
		number = number - 1
	end
	
	if Controls.check(pad,SCE_CTRL_RIGHT) and not Controls.check(oldpad,SCE_CTRL_RIGHT) then
		number = number + 1
	end

	if number > maxnumber then
		number = 1
	end

	if number <= 0 then
		number = maxnumber
	end
	mc = {black,black,black}
	mc[number] = green
	Font.print(font2, 80, 50, "Vita Hangman - Touhou Edition", blue)
	Font.print(font2, 720, 170, "v1.1A-TH1", blue)
	Font.print(font, 50, 350, "New Game" ,mc[1])
	Font.print(font, 320, 350, "Add word to database", mc[2])
	Font.print(font, 750, 350, "Exit Game" ,mc[3])
	Font.print(font, 100, 500, "By Rinnegatamante, Jackiepooh, Aurora (Wololo.net)", red)
	
	x,y = Controls.readTouch()
	if (not (x == nil)) then
		if y < 400 and x < 210 and x > 40 and y > 340 then
			go = 1
		end
		if y < 400 and x < 660 and x > 310 and y > 340 then
			word = checkInput("Word", "Word")
			word = word:match( "^%s*(.-)%s*$" )
			word = word:gsub("%s+", "")
				if word ~= "" then
					fileStream = System.openFile(filePrefix.."/WORDS.TXT", FRDWR)
					words = System.readFile(fileStream, System.sizeFile(fileStream))
					newText = words.."\nAddWord(\""..word.."\")"
					System.writeFile(fileStream,newText,string.len(newText)) 
					System.closeFile(fileStream)
				end
		end
		if y < 400 and x < 910 and x > 740 and y > 340 then
			GarbageCollection()
			System.exit()
		end
	end
	
	if go == 1 then
		Sound.close(snd_menu)
		dofile("game.lua")
	end

	if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 1 then
		go = 1
	end

	if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 2 then
		word = checkInput("Word", "Word")
		word = word:match( "^%s*(.-)%s*$" )
		word = word:gsub("%s+", "")
		if word ~= "" then
			fileStream = System.openFile(filePrefix.."/WORDS.TXT", FRDWR)
			words = System.readFile(fileStream, System.sizeFile(fileStream))
			newText = words.."\nAddWord(\""..word.."\")"
			System.writeFile(fileStream,newText,string.len(newText)) 
			System.closeFile(fileStream)
		end
	end

	if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 3 then
		GarbageCollection()
		System.exit()
	end
	Graphics.termBlend()
	Screen.flip()
	Screen.waitVblankStart()
	oldpad = pad
end
