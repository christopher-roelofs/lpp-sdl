white = Color.new(255,255,255, 255)
gray = Color.new(163, 160, 158)
red = Color.new(255,0,0, 255)
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
cross = SCE_CTRL_CROSS
circle = SCE_CTRL_CIRCLE

function PrintWord()
	if finish ==1 and status == 7 then
		Graphics.debugPrint(0,400,"The word was: "..exactword,gray)
	else
		i = 1
		smallword = ""
	while i <= #myword do
		smallword = smallword..myword[i].." "
		i = i + 1
	end
	Graphics.debugPrint(0,375,smallword,gray)
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

while true do
	Graphics.initBlend()
	Screen.clear()
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
	mc = {white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white,white}
	mc[number] = red
	Graphics.debugPrint(0,425,extra..extra2,gray)
	if finish == 1 then
		Graphics.debugPrint(0,450,"Press X to play again, O to exit.",gray)
	else
		Graphics.debugPrint(0,400,"Press O to try a solution.",gray)
	end
	Font.print(font,500,30,"A",mc[1])
	Font.print(font,600,30,"B",mc[2])
	Font.print(font,700,30,"C",mc[3])
	Font.print(font,800,30,"D",mc[4])
	Font.print(font,900,30,"E",mc[5])
	Font.print(font,500,130,"F",mc[6])
	Font.print(font,600,130,"G",mc[7])
	Font.print(font,700,130,"H",mc[8])
	Font.print(font,810,130,"I",mc[9])
	Font.print(font,905,130,"J",mc[10])
	Font.print(font,500,230,"K",mc[11])
	Font.print(font,600,230,"L",mc[12])
	Font.print(font,700,230,"M",mc[13])
	Font.print(font,800,230,"N",mc[14])
	Font.print(font,895,230,"O",mc[15])
	Font.print(font,500,330,"P",mc[16])
	Font.print(font,600,330,"Q",mc[17])
	Font.print(font,700,330,"R",mc[18])
	Font.print(font,800,330,"S",mc[19])
	Font.print(font,900,330,"T",mc[20])
	Font.print(font,500,430,"U",mc[21])
	Font.print(font,575,430,"V",mc[22])
	Font.print(font,650,430,"W",mc[23])
	Font.print(font,750,430,"X",mc[24])
	Font.print(font,825,430,"Y",mc[25])
	Font.print(font,900,430,"Z",mc[26])
	PrintWord()
	if finish == 1 then
		if Controls.check(pad,cross) and not Controls.check(oldpad,cross) then
			Graphics.freeImage(STATE)
			dofile("index.lua")
		end

		if Controls.check(pad,circle) and not Controls.check(oldpad,circle) then
			Graphics.freeImage(STATE)
			System.exit()
		end
	else
		if mode == "game" then
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 1 then
				SearchWord("A","a")
			end
			
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 2 then
				SearchWord("B","b")
			end
			
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 3 then
				SearchWord("C","c")
			end
			
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 4 then
				SearchWord("D","d")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 5 then
				SearchWord("E","e")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 6 then
				SearchWord("F","f")
			end
			
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 7 then
				SearchWord("G","g")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 8 then
				SearchWord("H","h")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 9 then
				SearchWord("I","i")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 10 then
				SearchWord("J","j")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 11 then
				SearchWord("K","k")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 12 then
				SearchWord("L","l")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 13 then
				SearchWord("M","m")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 14 then
				SearchWord("N","n")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 15 then
				SearchWord("O","o")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 16 then
				SearchWord("P","p")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 17 then
				SearchWord("Q","q")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 18 then
				SearchWord("R","r")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 19 then
				SearchWord("S","s")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 20 then
				SearchWord("T","t")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 21 then
				SearchWord("U","u")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 22 then
				SearchWord("V","v")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 23 then
				SearchWord("W","w")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 24 then
				SearchWord("X","x")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 25 then
				SearchWord("Y","y")
			end
	
			if Controls.check(pad,cross) and not Controls.check(oldpad,cross) and number == 26 then
				SearchWord("Z","z")
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
