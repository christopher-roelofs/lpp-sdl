red = 			Color.new(255,   0,   0);
--green =			Color.new(  0, 255,   0);
--blue =			Color.new(  0,   0, 255);
white = 		Color.new(255, 255, 255);

silver = 		Color.new(192, 192, 192);
lightyellow = 		Color.new(250, 250, 210);
midnightblue = 		Color.new(25, 25, 112);
--black = 		Color.new(0, 0, 0);
--white = 		Color.new(255, 255, 255);
blue =			Color.new(100, 149, 237);
pink =			Color.new(255, 0 , 153);
orange = 		Color.new(255, 228, 196);
pink2 = 		Color.new(255, 20, 147);
green = 		Color.new(60, 179, 113);
green2 = 		Color.new(108, 189, 124);

litegray = 		Color.new(200, 200, 200);
gray = 			Color.new(150, 150, 150);
darkgray = 		Color.new(100, 100, 100);
black = 		Color.new(  0,   0,   0);
transparent = 	Color.new(255, 255, 255, 128);
nil_color = 	Color.new(  0,   0,   0,   0);

space = { "", " ", " " }
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
hira = { "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?" }
kata = { "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "·", "?", "?", "?", "?", "?", "?", "?"  }
longvowel = { "A", "I", "U", "E", "O" }


wcount = 1
mode2 = 1
oldpad = pad
name = ""
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1

function printCentered(y,text,color)
local length = string.len(text)
local x = 240 - ((length*8)/2)
screen:print(x,y,text,color)
end

ltn = {};
for i=1, 16 do
	-- this is where the actual loading happens 
	ltn[i] = IntraFont.load("flash0:/font/ltn"..(i-1)..".pgf", 0); 
	ltn[i]:setStyle(1.0, white, darkgray, 0);
end

x_scroll1 = 80; x_scroll2 = 225; x_scroll3 = 370;  x_scroll4 = 385;

while true do
System.draw()
screen:clear()

	x = 240;
	y = 20;

screen:blit(0, 0, isuzu) 
   
if mode2 == 1 then screen:blit(30, 170, dpad3, true, 0, 0, 76, 78)
elseif mode2 >= 2 then screen:blit(30, 170, dpad3, true, 76, 0, 76, 78)
end

if mode2 == 1 then screen:blit(20, 20, dpad3, true, 101, 78, 95, 15)
elseif mode2 >= 2 then screen:blit(20, 20, dpad3, true, 0, 78, 101, 18)
end

if mode2 == 1 then screen:blit(190, 164, dpad3, true, 228, 0, 87, 87)
elseif mode2 >= 2 then screen:blit(190, 164, dpad3, true, 315, 0, 87, 87)
end

	--System.endDraw()
	

	pad = Controls.read()	
pose = 0


if wcount == 1 then
--screen:print(90,86,"ENTER Question",white)
	ltn[ 9]:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
	ltn[ 9]:print(90, 86, "ENTER Question");


else
--screen:print(90,86,"ENTER Answer",white)
	ltn[ 9]:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
	ltn[ 9]:print(90, 86, "ENTER Answer");
end
--printCentered(110,""..name,blue)
	ltn[ 9]:setStyle(0.5, blue, transparent, IntraFont.ALIGN_CENTER);
	ltn[ 9]:print(110, 96, name);

	System.endDraw()


if pad:select() and oldpad:select() ~= pad:select() then
if mode2 == 1 then mode2 = 2
else
mode2 = 1 
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end
end

if pad:left() and oldpad:left() ~=pad:left() and pad:left() ~=pad:r() and mode2 == 1 and currentLetter ~= 7
then name = name .. abc[1]
currentLetter = currentLetter + 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:left() and oldpad:left() ~=pad:left() and mode2 == 1 and currentLetter == 3
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. abc[2]
currentLetter = currentLetter + 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:left() and oldpad:left() ~=pad:left() and pad:left() ~=pad:r() and zzzz <= 25 and mode2 == 2 and mode2ka2 ~= 11
then name = name .. aieu[1]
mode2ka2 = mode2ka2 + 1
mode2ka = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:left() and oldpad:left() ~=pad:left() and mode2 == 1 and currentLetter == 5
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. abc[3]
currentLetter = currentLetter + 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:left() and oldpad:left() ~=pad:left() and mode2 == 1 and currentLetter == 7
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. abc[4]
currentLetter = currentLetter - 5
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 1 and currentLetter2 ~= 7
then name = name .. def[1]
currentLetter2 = currentLetter2 + 1
currentLetter = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 1 and currentLetter2 == 3
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. def[2]
currentLetter2 = currentLetter2 + 1
currentLetter = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 1 and currentLetter2 == 5
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. def[3]
currentLetter2 = currentLetter2 + 1
currentLetter = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end


if pad:up() and oldpad:up() ~=pad:up() and mode2 == 1 and currentLetter2 == 7
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. def[4]
currentLetter2 = currentLetter2 - 5
currentLetter = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 1 and currentLetter3 ~= 7
then name = name .. ghi[1]
currentLetter3 = currentLetter3 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 1 and currentLetter3 == 3
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. ghi[2]
currentLetter3 = currentLetter3 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 1 and currentLetter3 == 5
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. ghi[3]
currentLetter3 = currentLetter3 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 1 and currentLetter3 == 7
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. ghi[4]
currentLetter3 = currentLetter3 - 5
currentLetter = 1
currentLetter2 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and pad:right() ~= pad:r() and mode2 == 1 and currentLetter4 ~= 7
then name = name .. jkl[1]
currentLetter4 = currentLetter4 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 1 and currentLetter4 == 3
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. jkl[2]
currentLetter4 = currentLetter4 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 1 and currentLetter4 == 5
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. jkl[3]
currentLetter4 = currentLetter4 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 1 and currentLetter4 == 7
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. jkl[4]
currentLetter4 = currentLetter4 - 5
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 1 and currentLetter5 ~= 7
then name = name .. mno[1]
currentLetter5 = currentLetter5 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 1 and currentLetter5 == 3
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. mno[2]
currentLetter5 = currentLetter5 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 1 and currentLetter5 == 5
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. mno[3]
currentLetter5 = currentLetter5 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 1 and currentLetter5 == 7
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. mno[4]
currentLetter5 = currentLetter5 - 5
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 1 and currentLetter6 ~= 9
then name = name .. pqrs[1]
currentLetter6 = currentLetter6 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 1 and currentLetter6 == 3
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. pqrs[2]
currentLetter6 = currentLetter6 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 1 and currentLetter6 == 5
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. pqrs[3]
currentLetter6 = currentLetter6 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 1 and currentLetter6 == 7
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. pqrs[4]
currentLetter6 = currentLetter6 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 1 and currentLetter6 == 9
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. pqrs[5]
currentLetter6 = currentLetter6 - 7
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter7 = 1
currentLetter8 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 1 and currentLetter7 ~= 7
then name = name .. tuv[1]
currentLetter7 = currentLetter7 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter8 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 1 and currentLetter7 == 3
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. tuv[2]
currentLetter7 = currentLetter7 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter8 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 1 and currentLetter7 == 5
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. tuv[3]
currentLetter7 = currentLetter7 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter8 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 1 and currentLetter7 == 7
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. tuv[4]
currentLetter7 = currentLetter7 - 5
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter8 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and pad:circle() ~=pad:r() and mode2 == 1 and currentLetter8 ~= 9
then name = name .. wxyz[1]
currentLetter8 = currentLetter8 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 1 and currentLetter8 == 3
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. wxyz[2]
currentLetter8 = currentLetter8 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 1 and currentLetter8 == 5
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. wxyz[3]
currentLetter8 = currentLetter8 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 1 and currentLetter8 == 7
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. wxyz[4]
currentLetter8 = currentLetter8 + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 1 and currentLetter8 == 9
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. wxyz[5]
currentLetter8 = currentLetter8 - 7
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
end

if pad:r() and oldpad:r() ~=pad:r() 
then name = name .. space[1]
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end


if pad:r() and pad:left() ~= oldpad:left() and pad:r() ~= oldpad:left() 
then name = string.sub(name, 1, string.len(name) - 1)
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:r() then
zzzz = zzzz + 1
else zzzz = 0
end

if pad:r() and pad:right() ~= oldpad:right() and pad:r() ~= oldpad:right() and mode2 == 1 
then name = name .. space[2]
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka ~= 11
then name = name .. kaki[1]
mode2ka = mode2ka + 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka == 2 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. kaki[7]
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka == 3
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. kaki[2]
mode2ka = mode2ka + 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka == 4 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. kaki[8]
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka == 5
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. kaki[3]
mode2ka = mode2ka + 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka == 6 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. kaki[9]
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka == 7
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. kaki[4]
mode2ka = mode2ka + 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka == 8 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. kaki[10]
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka == 9
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. kaki[5]

elseif pad:analogY() < -120 and mode2 == 2 and mode2ka == 9 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. kaki[11]
mode2ka = mode2ka + 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka == 10
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. kaki[6]
mode2ka = mode2ka - 8
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka == 11
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. kaki[6]
mode2ka = mode2ka - 9
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end



if pad:left() and oldpad:left() ~=pad:left() and mode2 == 2 and mode2ka2 == 3
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. aieu[2]
mode2ka2 = mode2ka2 + 1
mode2ka = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:left() and oldpad:left() ~=pad:left() and mode2 == 2 and mode2ka2 == 5
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. aieu[3]
mode2ka2 = mode2ka2 + 1
mode2ka = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end


if pad:left() and oldpad:left() ~=pad:left() and mode2 == 2 and mode2ka2 == 7
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. aieu[4]
mode2ka2 = mode2ka2 + 1
mode2ka = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:left() and oldpad:left() ~=pad:left() and mode2 == 2 and mode2ka2 == 9
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. aieu[5]
mode2ka2 = mode2ka2 + 1
mode2ka = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:left() and oldpad:left() ~=pad:left() and mode2 == 2 and mode2ka2 == 11
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. aieu[6]
mode2ka2 = mode2ka2 - 9
mode2ka = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 2 and mode2ka3 ~= 11
then name = name .. sashi[1]
mode2ka3 = mode2ka3 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka3 == 2 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. sashi[7]
mode2ka3 = 10
mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 2 and mode2ka3 == 3
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. sashi[2]
mode2ka3 = mode2ka3 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka3 == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. sashi[8]
mode2ka3 = 10
mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 2 and mode2ka3 == 5
then name = string.sub(name, 1, string.len(name) - 5)
name = name .. sashi[3]
mode2ka3 = mode2ka3 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka3 == 6 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. sashi[9]
mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 2 and mode2ka3 == 7
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. sashi[4]
mode2ka3 = mode2ka3 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka3 == 8 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. sashi[10]
mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 2 and mode2ka3 == 9
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. sashi[5]

elseif pad:analogY() < -120 and mode2 == 2 and mode2ka3 == 9 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. sashi[11]
mode2ka3 = mode2ka3 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 2 and mode2ka3 == 10
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. sashi[6]
mode2ka3 = mode2ka3 - 8
mode2ka2 = 1
mode2ka = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 2 and mode2ka3 == 11
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. sashi[6]
mode2ka3 = mode2ka3 - 9
mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 2 and mode2ka4 ~= 11
then name = name .. tachi[1]
mode2ka4 = mode2ka4 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka4 == 2 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. tachi[7]
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 2 and mode2ka4 == 3
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. tachi[2]
mode2ka4 = mode2ka4 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka4 == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. tachi[8]
mode2ka4 = 10
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 2 and mode2ka4 == 5
then name = string.sub(name, 1, string.len(name) - 5)
name = name .. tachi[3]
mode2ka4 = mode2ka4 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka4 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. tachi[9]
mode2ka4 = 10
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 2 and mode2ka4 == 7
then name = string.sub(name, 1, string.len(name) - 5)
name = name .. tachi[4]
mode2ka4 = mode2ka4 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka4 == 8 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. tachi[10]
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 2 and mode2ka4 == 9
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. tachi[5]

elseif pad:analogY() < -120 and mode2 == 2 and mode2ka4 == 9 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. tachi[11]
mode2ka4 = mode2ka4 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 2 and mode2ka4 == 10
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. tachi[6]
mode2ka4 = mode2ka4 - 8
mode2ka2 = 1
mode2ka = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 2 and mode2ka4 == 11
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. tachi[6]
mode2ka4 = mode2ka4 - 9
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 2 and mode2ka5 ~= 11
then name = name .. nani[1]
mode2ka5 = mode2ka5 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 2 and mode2ka5 == 3
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. nani[2]
mode2ka5 = mode2ka5 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 2 and mode2ka5 == 5
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. nani[3]
mode2ka5 = mode2ka5 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end


if pad:square() and oldpad:square() ~=pad:square() and mode2 == 2 and mode2ka5 == 7
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. nani[4]
mode2ka5 = mode2ka5 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 2 and mode2ka5 == 9
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. nani[5]
mode2ka5 = mode2ka5 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 2 and mode2ka5 == 11
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. nani[6]
mode2ka5 = mode2ka5 - 9
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 2 and mode2ka6 ~= 11
then name = name .. hahi[1]
mode2ka6 = mode2ka6 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka6 == 2 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. bapi[1]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka6 == 2 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. bapi[6]

mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka3 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 2 and mode2ka6 == 3
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. hahi[2]
mode2ka6 = mode2ka6 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka6 == 4 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. bapi[2]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka6 == 4 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. bapi[7]

mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka3 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 2 and mode2ka6 == 5
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. hahi[3]
mode2ka6 = mode2ka6 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka6 == 6 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. bapi[3]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka6 == 6 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. bapi[8]

mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka3 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 2 and mode2ka6 == 7
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. hahi[4]
mode2ka6 = mode2ka6 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka6 == 8 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. bapi[4]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka6 == 8 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. bapi[9]

mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka3 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 2 and mode2ka6 == 9
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. hahi[5]
mode2ka6 = mode2ka6 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka6 == 10 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. bapi[5]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka6 == 10 
then name = string.sub(name, 1, string.len(name) - 2)
name = name .. bapi[10]
mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka3 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 2 and mode2ka6 == 11
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. hahi[6]
mode2ka6 = mode2ka6 - 9
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 2 and mode2ka7 ~= 11
then name = name .. mami[1]
mode2ka7 = mode2ka7 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 2 and mode2ka7 == 3
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. mami[2]
mode2ka7 = mode2ka7 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 2 and mode2ka7 == 5
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. mami[3]
mode2ka7 = mode2ka7 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 2 and mode2ka7 == 7
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. mami[4]
mode2ka7 = mode2ka7 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 2 and mode2ka7 == 9
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. mami[5]
mode2ka7 = mode2ka7 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 2 and mode2ka7 == 11
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. mami[6]
mode2ka7 = mode2ka7 - 9
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and pad:circle() ~=pad:r() and mode2 == 2 and mode2ka8 ~= 11
then name = name .. rari[1]
mode2ka8 = mode2ka8 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka9 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 2 and mode2ka8 == 3
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. rari[2]
mode2ka8 = mode2ka8 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka9 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 2 and mode2ka8 == 5
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. rari[3]
mode2ka8 = mode2ka8 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka9 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 2 and mode2ka8 == 7
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. rari[4]
mode2ka8 = mode2ka8 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka9 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 2 and mode2ka8 == 9
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. rari[5]
mode2ka8 = mode2ka8 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka9 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 2 and mode2ka8 == 11
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. rari[6]
mode2ka8 = mode2ka8 - 9
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka9 = 1
end

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 2 and mode2ka9 ~= 13
then name = name .. yayu[1]
mode2ka9 = mode2ka9 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
end


if pad:l() and oldpad:l() ~=pad:l() and mode2 == 2 and mode2ka9 == 3
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. yayu[2]
mode2ka9 = mode2ka9 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
end

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 2 and mode2ka9 == 5
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. yayu[3]
mode2ka9 = mode2ka9 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
end

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 2 and mode2ka9 == 7
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. yayu[4]
mode2ka9 = mode2ka9 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
end

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 2 and mode2ka9 == 9
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. yayu[5]
mode2ka9 = mode2ka9 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
end

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 2 and mode2ka9 == 11
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. yayu[6]
mode2ka9 = mode2ka9 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
end

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 2 and mode2ka9 == 13
then name = string.sub(name, 1, string.len(name) - 4)
name = name .. yayu[7]
mode2ka9 = mode2ka9 - 11
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
end

if pad:l() and oldpad:l() ~=pad:l() and mode2 ~= 2
then name = string.sub(name, 1, string.len(name) - 1)
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:analogX() > 120 and oldpad:analogX() ~=pad:analogX() and pad:analogX() ~=pad:analogY() and mode2 == 2
then name = name .. space[2]
mode2 = mode2 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end


if mode2 >= 3 then mode2 = mode2 + 1
end

if mode2 == 12 then mode2 = 2
end




if pad:start() and oldpad:start() ~=pad:start()
then
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1

file = io.open("write.txt","a")
myText = "\n"
file:write(name..myText)
file:close() 

wcount = wcount + 1
name = ""
end



if wcount == 3 then
rcount= 1
function printCentered(y,text,color)
local length = string.len(text)
local x = 240 - ((length*8)/2)
screen:print(x,y,text,color)
end
break
end


screen.waitVblankStart()
oldpad = pad
screen.flip()

end


