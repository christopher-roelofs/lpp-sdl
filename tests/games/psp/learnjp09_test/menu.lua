background = Image.load("menu12.png")
menu3 = Image.load("menu3.png")
dpad3 = Image.load("dpad3.png")


nil_color = Color.new(  0,   0,   0,   0);
transparent = 	Color.new(255, 255, 255, 128);

silver = Color.new(192, 192, 192)
lightyellow = Color.new(250, 250, 210)
midnightblue = Color.new(25, 25, 112)
black = Color.new(0, 0, 0)
white = Color.new(255, 255, 255) 
blue = Color.new(100, 149, 237)
pink = Color.new(255, 0 , 153)
orange = Color.new(255, 228, 196)
pink2 = Color.new(255, 20, 147)
green = Color.new(60, 179, 113)
green2 = Color.new(108, 189, 124)
red = Color.new(255, 0, 0)
rdemongray = Color.new(240, 240, 240)
litegray = Color.new(200, 200, 200)
gray = Color.new(150, 150, 150)
darkgray = Color.new(100, 100, 100)


Wav.load("stage1/sounds/victory.wav", 0)
sprite = Image.load("SAKURAZZ.PNG") 
ifont = IntraFont.load("jpn0.pgf", IntraFont.STRING_UTF8);
font = IntraFont.load("ltn9.pgf", 0); 
ltn1 = IntraFont.load("ltn1.pgf", 0); 

space = { "", " ", "　" }
abc = { "a", "b", "c", "a" }
def = { "d", "e", "f", "d" }
ghi = { "g", "h", "i", "g" }
jkl = { "j", "k", "l", "j" }
mno = { "m", "n", "o", "m" }
pqrs = { "p", "q", "r", "s", "p" }
tuv = { "t", "u", "v", "t" }
wxyz = { "w", "x", "y", "z", "w" }
aieu = { "a", "i", "u", "e", "o", "a"  }
kaki = { "ka", "ki", "ku", "ke", "ko", "ka", "ga", "gi", "gu", "ge", "go" }
sashi = { "sa", "shi", "su", "se", "so", "sa", "za", "ji", "zu", "ze", "zo"  }
tachi = { "ta", "chi", "tsu", "te", "to", "ta", "da", "ji", "zu", "de", "do" }
nani = { "na", "ni", "nu", "ne", "no", "na"  }
hahi = { "ha", "hi", "fu", "he", "ho", "ha"  }
mami = { "ma", "mi", "mu", "me", "mo", "ma"  }
rari = { "ra", "ri", "ru", "re", "ro", "ra"  }
yayu = { "ya", "yu", "yo", "n", "wa", "wo", "ya"  }
bapi = { "ba", "bi", "bu", "be", "bo", "pa", "pi", "pu", "pe", "po"  }
hira = { "あ", "い", "う", "え", "お", "か", "き", "く", "け", "こ", "が", "ぎ", "ぐ", "げ", "ご", "さ", "し", "す", "せ", "そ", "ざ", "じ", "ず", "ぜ", "ぞ", "た", "ち", "つ", "て", "と", "だ", "ぢ", "づ", "で", "ど", "な", "に", "ぬ", "ね", "の", "は", "ひ", "ふ", "へ", "ほ", "ば", "び", "ぶ", "べ", "ぼ", "ぱ", "ぴ", "ぷ", "ぺ", "ぽ", "ヴ", "ま", "み", "む", "め", "も", "ら", "り", "る", "れ", "ろ", "や", "ゆ", "よ", "ん", "わ", "を", "っ", "ゃ", "ゅ", "ょ", "、", "ー", "。", "？", "ぁ", "ぃ", "ぅ", "ぇ", "ぉ" }
kata = { "ア", "イ", "ウ", "エ", "オ", "カ", "キ", "ク", "ケ", "コ", "ガ", "ギ", "グ", "ゲ", "ゴ", "サ", "シ", "ス", "セ", "ソ", "ザ", "ジ", "ズ", "ゼ", "ゾ", "タ", "チ", "ツ", "テ", "ト", "ダ", "ヂ", "ヅ", "デ", "ド", "ナ", "ニ", "ヌ", "ネ", "ノ", "ハ", "ヒ", "フ", "ヘ", "ホ", "バ", "ビ", "ブ", "ベ", "ボ", "パ", "ピ", "プ", "ペ", "ポ", "ヴ", "マ", "ミ", "ム", "メ", "モ", "ラ", "リ", "ル", "レ", "ロ", "ヤ", "ユ", "ヨ", "ン", "ワ", "ヲ", "ッ", "ャ", "ュ", "ョ", "ー", "・", "Ⅱ", "？", "ァ", "ィ", "ゥ", "ェ", "ォ"  }
longvowel = { "A", "I", "U", "E", "O" }
nippon = 0
load = 0
menu1 = 1
menubg = 1
nexxchk = 0
menupromtsv = 0
sg15note = 0
sg15notesv = 0
cursora = 0
ending = 0
endingsv = 0

oldpad = pad


while true do
	
if menuprompt == 0 then menuprompt = 0
elseif menuprompt == 1 then menuprompt = 1
else menuprompt = 0
end


if nexx == 1 then nexx = 1
elseif nexx == 2 then nexx = 2
elseif nexx == 3 then nexx = 3
else nexx = 1
end


	
if randomnum == 0 then randomnum = 0
elseif randomnum == 1 then randomnum = 1
else randomnum = 0
end

if randomnum == 1 then
RanNumber = math.random(1,21)
end
System.draw()
screen:clear()

if load == 0 then
dofile("./save/SDATA.LUA")
load = 1
end


if menubg == 1 then
screen:blit(0, 0, background, 0, 0, 0, 480, 272)
elseif menubg == 2 then
screen:blit(0, 0, background, 0, 0, 272, 480, 240)
screen:blit(0, 240, background, 0, 480, 0, 32, 32)
screen:blit(32, 240, background, 0, 480, 32, 32, 32)
screen:blit(64, 240, background, 0, 480, 64, 32, 32)
screen:blit(96, 240, background, 0, 480, 96, 32, 32)
screen:blit(128, 240, background, 0, 480, 128, 32, 32)
screen:blit(160, 240, background, 0, 480, 160, 32, 32)
screen:blit(192, 240, background, 0, 480, 192, 32, 32)
screen:blit(224, 240, background, 0, 480, 224, 32, 32)
screen:blit(256, 240, background, 0, 480, 256, 32, 32)
screen:blit(288, 240, background, 0, 480, 288, 32, 32)
screen:blit(320, 240, background, 0, 480, 320, 32, 32)
screen:blit(352, 240, background, 0, 480, 352, 32, 32)
screen:blit(384, 240, background, 0, 480, 384, 32, 32)
screen:blit(416, 240, background, 0, 480, 416, 32, 32)
screen:blit(448, 240, background, 0, 480, 448, 32, 32)
elseif menubg == 3 then
screen:blit(0, 0, menu3, 0, 0, 0, 480, 272)
end

pose = 0

if menu1 == 1 then screen:blit(26, 43, dpad3, 0, 0, 96, 103, 40)
end
if menu1 == 2 then screen:blit(26, 73, dpad3, 0, 0, 96, 103, 40)
end
if menu1 == 3 then screen:blit(26, 103, dpad3, 0, 0, 96, 103, 40)
end
if menu1 == 4 and menubg ~= 3 then screen:blit(26, 133, dpad3, 0, 0, 96, 103, 40)
end
if menu1 == 5 and menubg ~= 3 then screen:blit(26, 163, dpad3, 0, 0, 96, 103, 40)
end
if menu1 == 6 then screen:blit(26, 193, dpad3, 0, 0, 96, 103, 40)
end
if menu1 == 7 then screen:blit(26, 223, dpad3, 0, 0, 96, 103, 40)
end

if s1check == 1 and menubg == 1 then screen:blit(56, 49, dpad3, 0, 103, 110, 22, 26)
end

if s2check == 1 and menubg == 1 then screen:blit(56, 79, dpad3, 0, 103, 110, 22, 26)
end

if s3check == 1 and menubg == 1 then screen:blit(56, 109, dpad3, 0, 103, 110, 22, 26)
end

if s4check == 1 and menubg == 1 then screen:blit(56, 139, dpad3, 0, 103, 110, 22, 26)
end

if s5check == 1 and menubg == 1 then screen:blit(56, 169, dpad3, 0, 103, 110, 22, 26)
end

if s6check == 1 and menubg == 1 then screen:blit(56, 199, dpad3, 0, 103, 110, 22, 26)
end

if s7check == 1 and menubg == 2 then screen:blit(56, 49, dpad3, 0, 103, 110, 22, 26)
end

if s8check == 1 and menubg == 2 then screen:blit(56, 79, dpad3, 0, 103, 110, 22, 26)
end

if s9check == 1 and menubg == 2 then screen:blit(56, 109, dpad3, 0, 103, 110, 22, 26)
end

if s10check == 1 and menubg == 2 then screen:blit(56, 139, dpad3, 0, 103, 110, 22, 26)
end

if s11check == 1 and menubg == 2 then screen:blit(56, 169, dpad3, 0, 103, 110, 22, 26)
end

if s12check == 1 and menubg == 2 then screen:blit(56, 199, dpad3, 0, 103, 110, 22, 26)
end

if s13check == 1 and menubg == 3 then screen:blit(56, 49, dpad3, 0, 103, 110, 22, 26)
end

if s14check == 1 and menubg == 3 then screen:blit(56, 79, dpad3, 0, 103, 110, 22, 26)
end

if s15check == 1 and menubg == 3 then screen:blit(56, 109, dpad3, 0, 103, 110, 22, 26)
end


 
if nexx <= 2 and cursora >= 0 and cursora < 8 then 
screen:blit(456, 113, dpad3, 0, 0, 141, 16, 30)
elseif nexx <= 2 and cursora >= 8 and cursora < 16 then 
screen:blit(456, 113, dpad3, 0, 16, 141, 16, 30)
elseif nexx <= 2 and cursora >= 16 and cursora < 24 then 
screen:blit(456, 113, dpad3, 0, 32, 141, 16, 30)
elseif nexx <= 2 and cursora >= 24 and cursora < 32 then 
screen:blit(456, 113, dpad3, 0, 48, 141, 16, 30) end
if nexx <= 2  and cursora + 1 >= 32 then cursora = 0 else cursora = cursora + 1 end

if nexx <= 2 then
font:setStyle(1.0, white, black, IntraFont.ALIGN_CENTER);
font:print(330, 264, "Uses intraFont by BenHur");

end

if menubg == 3 and menu1 == 3 then
screen:blit(162, 104, dpad3, 0, 0, 171, 293, 146)
font:setStyle(0.5, white, black, IntraFont.ALIGN_CENTER);
font:print(305, 140, "This stage will focus on\n\nloan words that were\n\nadapted into the Japanese\n\ndictionary")
end

if menubg == 3 and menu1 == 7 then
screen:blit(162, 104, dpad3, 0, 0, 171, 293, 146)
font:setStyle(0.5, white, black, IntraFont.ALIGN_CENTER);
font:print(305, 130, "The Karaoke stage is to help\n\nget the rhythm of the Japanese\n\nlanguage down")
end

if nippon == 0 then
font:setStyle(0.5, white, black, IntraFont.ALIGN_LEFT);
font:print(5, 10, "Romaji");
elseif nippon == 1 then
font:setStyle(0.5, white, black, IntraFont.ALIGN_LEFT);
font:print(5, 10, "Japanese");
end

if randomnum == 0 then
font:setStyle(0.5, white, black, IntraFont.ALIGN_LEFT);
font:print(5, 20, "Random: Off");
elseif randomnum == 1 then
font:setStyle(0.5, white, black, IntraFont.ALIGN_LEFT);
font:print(5, 20, "Random: On");
elseif randomnum ~= 1 then
font:setStyle(0.5, white, black, IntraFont.ALIGN_LEFT);
font:print(5, 30, "Random: ???");
end



	System.endDraw()



pad = Controls.read()

	
if pad:down() and oldpad:down() ~=pad:down() and menubg == 1 then 
menu1 = menu1 + 1
elseif menu1 == 8 and menubg == 1 then menu1 = menu1 - 7
end

if pad:up() and oldpad:up() ~=pad:up() and menubg == 1 then 
menu1 = menu1 - 1
elseif menu1 == 0 and menubg == 1 then menu1 = menu1 + 7
end	
	
if pad:down() and oldpad:down() ~=pad:down() and menubg == 2 then 
menu1 = menu1 + 1
elseif menubg == 2  and menu1 == 8 then menu1 = menu1 - 7
end

if pad:up() and oldpad:up() ~=pad:up() and menubg == 2 then 
menu1 = menu1 - 1
elseif menu1 == 0 and menubg == 2 then menu1 = menu1 + 7
end
	
if pad:down() and oldpad:down() ~=pad:down() and menubg == 3 then 
menu1 = menu1 + 1
elseif menubg == 3  and menu1 == 4 then menu1 = menu1 + 2
elseif menubg == 3  and menu1 == 8 then menu1 = menu1 - 7
end

if pad:up() and oldpad:up() ~=pad:up() and menubg == 3 then 
menu1 = menu1 - 1
elseif menu1 == 0 and menubg == 3 then menu1 = menu1 + 7
elseif menu1 == 5 and menubg == 3 then menu1 = 3
end
	
	
if pad:right() and oldpad:right() ~=pad:right() and menubg <= 2 then 
menubg = menubg + 1
nexx = nexx + 1
if menubg == 2 then menu1 = 1
elseif menubg == 3 then menu1 = 1
end
end


if pad:left() and oldpad:left() ~=pad:left() and menubg >= 2 then 
menubg = menubg - 1
if menubg == 1 then menu1 = 1
elseif menubg == 2 then menu1 = 1
end
end	
	
if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 1 and nippon == 0 and randomnum ~= 1
then dofile("./stage1/stage1b.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 1 and nippon == 1 and randomnum ~= 1
then dofile("./stage1/stage1jp.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 1 and nippon == 0 and randomnum == 1
then dofile("./stage1/stage1brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 1 and nippon == 1 and randomnum == 1
then dofile("./stage1/stage1jprandom.lua")
end
	
if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 2 and nippon == 0 and randomnum ~= 1
then dofile("./stage2/stage2b.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 2 and nippon == 1 and randomnum ~= 1
then dofile("./stage2/stage2jp.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 2 and nippon == 0 and randomnum == 1
then dofile("./stage2/stage2brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 2 and nippon == 1 and randomnum == 1
then dofile("./stage2/stage2jprandom.lua")
end
	
if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 3 and nippon == 0 and randomnum ~= 1
then dofile("./stage3/stage3b.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 3 and nippon == 1 and randomnum ~= 1
then dofile("./stage3/stage3jp.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 3 and nippon == 0 and randomnum == 1
then dofile("./stage3/stage3brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 3 and nippon == 1 and randomnum == 1
then dofile("./stage3/stage3jprandom.lua")
end
	
if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 4 and nippon == 0 and randomnum ~= 1
then dofile("./stage4/stage4b.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 4 and nippon == 1 and randomnum ~= 1
then dofile("./stage4/stage4jp.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 4 and nippon == 0 and randomnum == 1
then dofile("./stage4/stage4brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 4 and nippon == 1 and randomnum == 1
then dofile("./stage4/stage4jprandom.lua")
end

if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 5 and nippon == 0 and randomnum ~= 1
then dofile("./stage5/stage5b.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 5 and nippon == 1 and randomnum ~= 1
then dofile("./stage5/stage5jp.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 5 and nippon == 0 and randomnum == 1
then dofile("./stage5/stage5brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 5 and nippon == 1 and randomnum == 1
then dofile("./stage5/stage5jprandom.lua")
end
	
if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1  and menu1 == 6 and nippon == 0 and randomnum ~= 1
then dofile("./stage6/stage6b.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 6 and nippon == 1 and randomnum ~= 1
then dofile("./stage6/stage6jp.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 6 and nippon == 0 and randomnum == 1
then dofile("./stage6/stage6brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 6 and nippon == 1 and randomnum == 1
then dofile("./stage6/stage6jprandom.lua")
end

if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 1 and nippon == 0 and randomnum ~= 1
then dofile("./stage7/stage7b.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 1 and nippon == 1 and randomnum ~= 1
then dofile("./stage7/stage7jp.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 1 and nippon == 0 and randomnum == 1
then dofile("./stage7/stage7brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 1 and nippon == 1 and randomnum == 1
then dofile("./stage7/stage7jprandom.lua")
end

if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 2 and nippon == 0 and randomnum ~= 1
then dofile("./stage8/stage8b.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 2 and nippon == 1 and randomnum ~= 1
then dofile("./stage8/stage8jp.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 2 and nippon == 0 and randomnum == 1
then dofile("./stage8/stage8brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 2 and nippon == 1 and randomnum == 1
then dofile("./stage8/stage8jprandom.lua")
end

if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 3 and nippon == 0 and randomnum ~= 1
then dofile("./stage9/stage9b.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 3 and nippon == 1 and randomnum ~= 1
then dofile("./stage9/stage9jp.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 3 and nippon == 0 and randomnum == 1
then dofile("./stage9/stage9brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 3 and nippon == 1 and randomnum == 1
then dofile("./stage9/stage9jprandom.lua")
end

if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 4 and nippon == 0 and randomnum ~= 1
then dofile("./stage10/stage10b.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 4 and nippon == 1 and randomnum ~= 1
then dofile("./stage10/stage10jp.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 4 and nippon == 0 and randomnum == 1
then dofile("./stage10/stage10brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 4 and nippon == 1 and randomnum == 1
then dofile("./stage10/stage10jprandom.lua")
end


if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 5 and nippon == 0 and randomnum ~= 1
then dofile("./stage11/stage11b.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 5 and nippon == 1 and randomnum ~= 1
then dofile("./stage11/stage11jp.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 5 and nippon == 0 and randomnum == 1
then dofile("./stage11/stage11brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 5 and nippon == 1 and randomnum == 1
then dofile("./stage11/stage11jprandom.lua")
end





if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2  and menu1 == 6 and nippon == 0 and randomnum ~= 1
then dofile("./stage12/stage12b.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 6 and nippon == 1 and randomnum ~= 1
then dofile("./stage12/stage12jp.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 6 and nippon == 0 and randomnum == 1
then dofile("./stage12/stage12brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 6 and nippon == 1 and randomnum == 1
then dofile("./stage12/stage12jprandom.lua")
end



if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 1 and nippon == 0 and randomnum ~= 1
then dofile("./stage13/stage13b.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 1 and nippon == 1 and randomnum ~= 1
then dofile("./stage13/stage13jp.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 1 and nippon == 0 and randomnum == 1
then dofile("./stage13/stage13brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 1 and nippon == 1 and randomnum == 1
then dofile("./stage13/stage13jprandom.lua")
end

if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 2 and nippon == 0 and randomnum ~= 1
then dofile("./stage14/stage14b.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 2 and nippon == 1 and randomnum ~= 1
then dofile("./stage14/stage14jp.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 2 and nippon == 0 and randomnum == 1
then dofile("./stage14/stage14brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 2 and nippon == 1 and randomnum == 1
then dofile("./stage14/stage14jprandom.lua")
end


if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 3 and nippon == 0 and randomnum ~= 1
then dofile("./stage15/stage15b.lua") 
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 3 and nippon == 1 and randomnum ~= 1
then dofile("./stage15/stage15jp.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 3 and nippon == 0 and randomnum == 1
then dofile("./stage15/stage15brandom.lua")
elseif pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 3 and nippon == 1 and randomnum == 1
then dofile("./stage15/stage15jprandom.lua")
end

if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 6
then dofile("./howtoplay/howtob.lua") 
end


if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 3 and menu1 == 7
then dofile("./karaoke/indexb.lua") 
end


if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 1 and menu1 == 7
then dofile("./z.custom/customloaderb.lua")
end



if pad:cross() and oldpad:cross() ~=pad:cross() and menubg == 2 and menu1 == 7
then dofile("./options/optionsb.lua") 
end

if nexx >= 3 then nexx = 3
end

if mode2 == 1 then mode2 = 1
elseif mode2 == 2 then mode2 = 2
else mode2 = 1
end

if ending == 0 and s1check == 1 and s2check == 1 and s3check == 1 and s4check == 1 and s5check == 1 and s6check == 1 and s7check == 1 and s8check == 1 and s9check == 1 and s10check == 1 and s11check == 1 and s12check == 1 and s13check == 1 and s14check == 1 and s15check == 1 
then dofile("./ending/endingb.lua")
end


if s1check == 1 and s2check == 1 and s3check == 1 and s4check == 1 and s5check == 1 and s6check == 1 and s7check == 1 and s8check == 1 and s9check == 1 and s10check == 1 and s11check == 1 and s12check == 1 and s13check == 1 and s14check == 1 and s15check == 1 and pad:start() and oldpad:start() ~=pad:start()
then dofile("ending/endingb.lua")
end




screen.waitVblankStart()
oldpad = pad
screen.flip()

end


