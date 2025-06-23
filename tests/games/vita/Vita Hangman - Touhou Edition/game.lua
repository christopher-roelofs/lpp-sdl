-- Hangman

Sound.init()

local img_background = Graphics.loadImage("Assets/Graphics/background.png")
local snd_background = Sound.open("Assets/Audio/BGM.ogg")
local snd_click = Sound.open("Assets/Audio/click.ogg")

-- Declaring Stuff

white = Color.new(255,255,255, 255)
gray = Color.new(163, 160, 158)
red = Color.new(255,0,0, 255)
black = Color.new(0,0,0)
blue = Color.new(102,178,255)
font = Font.load("Assets/Fonts/AllerDisplay.ttf")
Font.setPixelSizes(font, 72)
extra2=""
finish = 0
number = 1
maxnumber = 26
numberz = 1
maxnumberz = 4
mode = "game"
extra = "Game started!"
oldpad = Controls.read()
start = 1
words = {}
wordlect = {}
wordbegin = {}
wordnotknow = {}
myword = {}
letters = 0
cross = SDLK_RETURN
circle = SDLK_BACKSPACE
mc = {white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white}
mpressed = {false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false}

function PrintWord()
	if finish ==1 and status == 7 then
		Graphics.debugPrint(0,400,"The word was: "..exactword,blue)
	else
		i = 1
		smallword = ""
	while i <= #myword do
		smallword = smallword..myword[i].." "
		i = i + 1
	end
	Graphics.debugPrint(0,375,smallword,blue)
	end
end

function SearchWord(word1,word2)
	old = letters
	i = 1
	begin = 1
	wordbegin = {}
	while i <= #wordnotknow do
		if wordnotknow[i] == word1 or wordnotknow[i] == word2 then
			wordbegin[begin] = i
			begin = begin + 1
		end
		i = i + 1
	end
	i = 1
	patch = 0
	while i <= #wordbegin do
		myword[wordbegin[i]] = wordnotknow[wordbegin[i]]
		wordnotknow[wordbegin[i]] = "_"
		letters = letters + 1
		i = i + 1
	end
	
	if old == letters then
		extra = "Letter not found!"
		status = status + 1
		Graphics.freeImage(STATE)
		STATE = Graphics.loadImage("Assets/Graphics/".."STATE"..status..".png")
	else
		extra = "Letter found!"
	end
end

function AddWord(word)
	num = #words + 1
	words[num] = word
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

function drawLetters()
    Font.print(font,500,30,"A",mc[1])
    if number == 1 then
    	Font.print(font,500,30,"A",red)
    end
	Font.print(font,600,30,"B",mc[2])
	if number == 2 then
    	Font.print(font,600,30,"B",red)
    end
	Font.print(font,700,30,"C",mc[3])
	if number == 3 then
    	Font.print(font,700,30,"C",red)
    end
	Font.print(font,800,30,"D",mc[4])
	if number == 4 then
    	Font.print(font,800,30,"D",red)
    end
	Font.print(font,900,30,"E",mc[5])
	if number == 5 then
    	Font.print(font,900,30,"E",red)
    end
	Font.print(font,500,130,"F",mc[6])
	if number == 6 then
    	Font.print(font,500,130,"F",red)
    end
	Font.print(font,600,130,"G",mc[7])
	if number == 7 then
    	Font.print(font,600,130,"G",red)
    end
	Font.print(font,700,130,"H",mc[8])
	if number == 8 then
    	Font.print(font,700,130,"H",red)
    end
	Font.print(font,810,130,"I",mc[9])
	if number == 9 then
    	Font.print(font,810,130,"I",red)
    end
	Font.print(font,905,130,"J",mc[10])
	if number == 10 then
    	Font.print(font,905,130,"J",red)
    end
	Font.print(font,500,230,"K",mc[11])
	if number == 11 then
    	Font.print(font,500,230,"K",red)
    end
	Font.print(font,600,230,"L",mc[12])
	if number == 12 then
    	Font.print(font,600,230,"L",red)
    end
	Font.print(font,700,230,"M",mc[13])
	if number == 13 then
    	Font.print(font,700,230,"M",red)
    end
	Font.print(font,800,230,"N",mc[14])
	if number == 14 then
    	Font.print(font,800,230,"N",red)
    end
	Font.print(font,895,230,"O",mc[15])
	if number == 15 then
    	Font.print(font,895,230,"O",red)
    end
	Font.print(font,500,330,"P",mc[16])
	if number == 16 then
    	Font.print(font,500,330,"P",red)
    end
	Font.print(font,600,330,"Q",mc[17])
	if number == 17 then
    	Font.print(font,600,330,"Q",red)
    end
	Font.print(font,700,330,"R",mc[18])
	if number == 18 then
    	Font.print(font,700,330,"R",red)
    end
	Font.print(font,800,330,"S",mc[19])
	if number == 19 then
    	Font.print(font,800,330,"S",red)
    end
	Font.print(font,900,330,"T",mc[20])
	if number == 20 then
    	Font.print(font,900,330,"T",red)
    end
	Font.print(font,500,430,"U",mc[21])
	if number == 21 then
    	Font.print(font,500,430,"U",red)
    end
	Font.print(font,575,430,"V",mc[22])
	if number == 22 then
    	Font.print(font,575,430,"V",red)
    end
	Font.print(font,650,430,"W",mc[23])
	if number == 23 then
    	Font.print(font,650,430,"W",red)
    end
	Font.print(font,750,430,"X",mc[24])
	if number == 24 then
    	Font.print(font,750,430,"X",red)
    end
	Font.print(font,825,430,"Y",mc[25])
	if number == 25 then
    	Font.print(font,825,430,"Y",red)
    end
	Font.print(font,900,430,"Z",mc[26])
	if number == 26 then
    	Font.print(font,900,430,"Z",red)
    end
	
end
	
--Main Method
function main()

		Sound.play(snd_background, LOOP)
	
	
while true do
	Graphics.initBlend()
	Screen.clear()
	Graphics.drawImage(0, 0, img_background)
	if start == 1 then
		dofile("Assets/Data/WORDS.TXT")
		maxnum = #words
		math.randomseed(Timer.new())
		word = math.random(1,maxnum)
		exactword = words[word]
		length = string.len(exactword)
		while start <= length do
			wordlect[start] = string.sub(exactword,start,start)
			myword[start] = "_"
			start = start + 1
		end
		status = 1
		STATE = Graphics.loadImage("Assets/Graphics/STATE1.png")
		wordnotknow = wordlect
	end
	if #wordnotknow == letters then
		extra2 = " You win!"
		finish = 1
	end
	if status == 7 then
		extra2 = " You lose!"
		finish = 1
	end
	pad = Controls.read()
	if mode == "game" then
		if Controls.check(pad,SCE_CTRL_UP) and not Controls.check(oldpad,SCE_CTRL_UP) then
			if number > 5 then
				if number == 26 then
					number = 20
				else
					number = number - 5
				end
			else
				number = maxnumber - 6 + number
			end
		end
		
		if Controls.check(pad,SCE_CTRL_DOWN) and not Controls.check(oldpad,SCE_CTRL_DOWN) then
			if maxnumber - number > 5 then
				number = number + 5
			else
				if number == 26 then
					number = 5
				else
					number = number - 20
				end
			end
		end
		
		if Controls.check(pad,SCE_CTRL_LEFT) and not Controls.check(oldpad,SCE_CTRL_LEFT) then
			if number == 1 or number == 6 or number == 11 or number == 16 or number == 21 then
				if number == 21 then
					number = 26
				else
					number = number + 4
				end
			else
				number = number - 1
			end
		end
		
		if Controls.check(pad,SCE_CTRL_RIGHT) and not Controls.check(oldpad,SCE_CTRL_RIGHT) then
			if number == 5 or number == 10 or number == 15 or number == 20 or number == 26 then
				if number == 26 then
					number = 21
				else
					number = number - 4
				end
			else
				number = number + 1
			end
		end
	end
	
	Graphics.debugPrint(0,425,extra..extra2,blue)
	if finish == 1 then
		Graphics.debugPrint(0,450,"Press X to play again, O to exit to menu.",blue)
	else
		Graphics.debugPrint(0,400,"Press O to try a solution.",blue)
	end
	drawLetters()
	PrintWord()
	if finish == 1 then
		if Controls.check(pad,cross) and not Controls.check(oldpad,cross) then
			Graphics.freeImage(STATE)
			Sound.close(snd_background)
			dofile("game.lua")
		end

		if Controls.check(pad,circle) and not Controls.check(oldpad,circle) then
			Graphics.freeImage(STATE)
			Sound.close(snd_background)
			GAME_SOUND_STATUS = false
			dofile("index.lua")
		end
	else
		if mode == "game" then
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 1 then
				if mpressed[number] == false then
				SearchWord("A","a")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
			
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 2 then
				if mpressed[number] == false then
				SearchWord("B","b")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
			
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 3 then
				if mpressed[number] == false then
				SearchWord("C","c")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
			
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 4 then
				if mpressed[number] == false then
				SearchWord("D","d")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 5 then
				if mpressed[number] == false then
				SearchWord("E","e")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 6 then
				if mpressed[number] == false then
				SearchWord("F","f")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
			
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 7 then
				if mpressed[number] == false then
				SearchWord("G","g")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 8 then
				if mpressed[number] == false then
				SearchWord("H","h")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 9 then
				if mpressed[number] == false then
				SearchWord("I","i")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 10 then
				if mpressed[number] == false then
				SearchWord("J","j")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 11 then
				if mpressed[number] == false then
				SearchWord("K","k")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 12 then
				if mpressed[number] == false then
				SearchWord("L","l")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 13 then
				if mpressed[number] == false then
				SearchWord("M","m")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 14 then
				if mpressed[number] == false then
				SearchWord("N","n")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 15 then
				if mpressed[number] == false then
				SearchWord("O","o")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 16 then
				if mpressed[number] == false then
				SearchWord("P","p")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 17 then
				if mpressed[number] == false then
				SearchWord("Q","q")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 18 then
				if mpressed[number] == false then
				SearchWord("R","r")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 19 then
				if mpressed[number] == false then
				SearchWord("S","s")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 20 then
				if mpressed[number] == false then
				SearchWord("T","t")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 21 then
				if mpressed[number] == false then
				SearchWord("U","u")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 22 then
				if mpressed[number] == false then
				SearchWord("V","v")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 23 then
				if mpressed[number] == false then
				SearchWord("W","w")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 24 then
				if mpressed[number] == false then
				SearchWord("X","x")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 25 then
				if mpressed[number] == false then
				SearchWord("Y","y")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 26 then
				if mpressed[number] == false then
				SearchWord("Z","z")
				mc[number] = gray
				mpressed[number] = true
				drawLetters()
				Sound.play(snd_click, NO_LOOP)
				end
			end
			
			if Controls.check(pad,circle) and not Controls.check(oldpad,circle) then
				madic = checkInput("Word", "")
				pad = cross
				oldpad = cross
				if madic ~= "" then
					if string.upper(exactword) == string.upper(madic) then
						extra = "Good solution!"
						letters = #wordnotknow
					else
						extra = "Bad solution!"
						status = status + 1
						Graphics.freeImage(STATE)
						STATE = Graphics.loadImage("Assets/Graphics/".."STATE"..status..".png")
					end
				end
			end
		end
	end
	Graphics.fillRect(19,319,19,355,red)
	Graphics.drawImage(20,20,STATE)
	Graphics.termBlend()
	Screen.flip()
	Screen.waitVblankStart()
	oldpad = pad
end
end

main()
