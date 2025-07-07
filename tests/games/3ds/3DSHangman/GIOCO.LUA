giallo = Color.new (255,255,255)
rosso = Color.new(255,0,0)
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
lettere = 0
while true do
Screen.refresh()
Screen.clear(TOP_SCREEN)
Screen.clear(BOTTOM_SCREEN)
function PrintWord()
if finish ==1 and status == 7 then
Screen.debugPrint(0,160,"The word was: "..exactword,giallo,TOP_SCREEN)
else
i = 1
parolina = ""
while i <= #myword do
parolina = parolina..myword[i].." "
i = i + 1
end
Screen.debugPrint(0,160,parolina,giallo,TOP_SCREEN)
end
end
function SearchWord(word1,word2)
old = lettere
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
lettere = lettere + 1
i = i + 1
end
if old == lettere then
extra = "Letter not found!"
status = status + 1
Screen.freeImage(stato)
stato = Screen.loadImage(System.currentDirectory().."/STATO"..status..".png")
else
extra = "Letter found!"
end
end
function AddWord(parola)
num = #words + 1
words[num] = parola
end
if start == 1 then
dofile(System.currentDirectory().."/WORDS.TXT")
maxnum = #words
math.randomseed(Timer.new())
parola = math.random(1,maxnum)
exactword = words[parola]
length = string.len(exactword)
while start <= length do
wordlect[start] = string.sub(exactword,start,start)
myword[start] = "_"
start = start + 1
end
status = 1
stato = Screen.loadImage(System.currentDirectory().."/STATO1.png")
wordnotknow = wordlect
end
if #wordnotknow == lettere then
extra2 = " You win!"
finish = 1
end
if status == 7 then
extra2 = " You lose!"
finish = 1
end
Controls.init()
pad = Controls.read()
if mode == "game" then
if Controls.check(pad,KEY_DUP) and not Controls.check(oldpad,KEY_DUP) then
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
if Controls.check(pad,KEY_DDOWN) and not Controls.check(oldpad,KEY_DDOWN) then
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
if Controls.check(pad,KEY_DLEFT) and not Controls.check(oldpad,KEY_DLEFT) then
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
if Controls.check(pad,KEY_DRIGHT) and not Controls.check(oldpad,KEY_DRIGHT) then
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
mc = {giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo}
mc[number] = rosso
Screen.debugPrint(0,210,extra..extra2,giallo,TOP_SCREEN)
if finish == 1 then
Screen.debugPrint(0,225,"Press A to exit, B to play again.",giallo,TOP_SCREEN)
else
Screen.debugPrint(0,150,"Press B to try a solution.",giallo,BOTTOM_SCREEN)
end
Screen.debugPrint(50,30,"A",mc[1],BOTTOM_SCREEN)
Screen.debugPrint(70,30,"B",mc[2],BOTTOM_SCREEN)
Screen.debugPrint(90,30,"C",mc[3],BOTTOM_SCREEN)
Screen.debugPrint(110,30,"D",mc[4],BOTTOM_SCREEN)
Screen.debugPrint(130,30,"E",mc[5],BOTTOM_SCREEN)
Screen.debugPrint(50,45,"F",mc[6],BOTTOM_SCREEN)
Screen.debugPrint(70,45,"G",mc[7],BOTTOM_SCREEN)
Screen.debugPrint(90,45,"H",mc[8],BOTTOM_SCREEN)
Screen.debugPrint(110,45,"I",mc[9],BOTTOM_SCREEN)
Screen.debugPrint(130,45,"J",mc[10],BOTTOM_SCREEN)
Screen.debugPrint(50,60,"K",mc[11],BOTTOM_SCREEN)
Screen.debugPrint(70,60,"L",mc[12],BOTTOM_SCREEN)
Screen.debugPrint(90,60,"M",mc[13],BOTTOM_SCREEN)
Screen.debugPrint(110,60,"N",mc[14],BOTTOM_SCREEN)
Screen.debugPrint(130,60,"O",mc[15],BOTTOM_SCREEN)
Screen.debugPrint(50,75,"P",mc[16],BOTTOM_SCREEN)
Screen.debugPrint(70,75,"Q",mc[17],BOTTOM_SCREEN)
Screen.debugPrint(90,75,"R",mc[18],BOTTOM_SCREEN)
Screen.debugPrint(110,75,"S",mc[19],BOTTOM_SCREEN)
Screen.debugPrint(130,75,"T",mc[20],BOTTOM_SCREEN)
Screen.debugPrint(40,90,"U",mc[21],BOTTOM_SCREEN)
Screen.debugPrint(60,90,"V",mc[22],BOTTOM_SCREEN)
Screen.debugPrint(80,90,"W",mc[23],BOTTOM_SCREEN)
Screen.debugPrint(100,90,"X",mc[24],BOTTOM_SCREEN)
Screen.debugPrint(120,90,"Y",mc[25],BOTTOM_SCREEN)
Screen.debugPrint(140,90,"Z",mc[26],BOTTOM_SCREEN)
PrintWord()
if finish == 1 then
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) then
Screen.freeImage(stato)
dofile(System.currentDirectory().."/index.lua")
end
if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
Screen.freeImage(stato)
dofile(System.currentDirectory().."/GIOCO.lua")
end
else
if mode == "game" then
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 1 then
SearchWord("A","a")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 2 then
SearchWord("B","b")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 3 then
SearchWord("C","c")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 4 then
SearchWord("D","d")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 5 then
SearchWord("E","e")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 6 then
SearchWord("F","f")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 7 then
SearchWord("G","g")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 8 then
SearchWord("H","h")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 9 then
SearchWord("I","i")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 10 then
SearchWord("J","j")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 11 then
SearchWord("K","k")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 12 then
SearchWord("L","l")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 13 then
SearchWord("M","m")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 14 then
SearchWord("N","n")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 15 then
SearchWord("O","o")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 16 then
SearchWord("P","p")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 17 then
SearchWord("Q","q")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 18 then
SearchWord("R","r")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 19 then
SearchWord("S","s")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 20 then
SearchWord("T","t")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 21 then
SearchWord("U","u")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 22 then
SearchWord("V","v")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 23 then
SearchWord("W","w")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 24 then
SearchWord("X","x")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 25 then
SearchWord("Y","y")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 26 then
SearchWord("Z","z")
end
if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
madic = System.startKeyboard("Word")
pad = KEY_A
oldpad = KEY_A
if string.upper(exactword) == string.upper(madic) then
extra = "Good solution!"
lettere = #wordnotknow
else
extra = "Bad solution!"
status = status + 1
Screen.freeImage(stato)
stato = Screen.loadImage(System.currentDirectory().."/STATO"..status..".png")
end
end
end
end
Screen.fillEmptyRect(19,20+116,19,20+112,rosso,TOP_SCREEN)
Screen.drawImage(20,20,stato,TOP_SCREEN)
Screen.flip()
Screen.waitVblankStart()
oldpad = pad
end
