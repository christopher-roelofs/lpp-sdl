Ogg.load("karaoke/ogg.ogg", 1)
backGround2 = Image.createEmpty(480, 272)
backGround2:clear(Color.new(255, 255, 255))
karakeys = Image.load("karaoke/arrowicons.png") 
haruhisprite = Image.load("karaoke/haruhisprite.png")



bclear = { }
bclear[1] = { complete = 0 }
bclear[2] = { complete = 0 }
bclear[3] = { complete = 0 }
bclear[4] = { complete = 0 }
bclear[5] = { complete = 0 }
bclear[6] = { complete = 0 }
bclear[7] = { complete = 0 }
bclear[8] = { complete = 0 }
bclear[9] = { complete = 0 }
bclear[10] = { complete = 0 }
bclear[11] = { complete = 0 }
bclear[12] = { complete = 0 }
bclear[13] = { complete = 0 }
bclear[14] = { complete = 0 }
bclear[15] = { complete = 0 }
bclear[16] = { complete = 0 }
bclear[17] = { complete = 0 }
bclear[18] = { complete = 0 }
bclear[19] = { complete = 0 }
bclear[20] = { complete = 0 }
bclear[21] = { complete = 0 }

delaytrack = 0
counter = Timer.new()
counter:start()

loopCount = 0
icons = 1
qcount = 1
score = 0

x = 300
z = 200
test = 1
start = 0

line = 1
name = ""
currentLetter7 = 1
lyrics = { "na", "zo", "na", "zo ", "mi", "ta", "i ", "ni ", "chi", "kyu", "u", "gi ", "wo ", "to", "ki", "a", "ka", "shi", "ta", "ra" }
lyrics2 = { "min", "na ", "de ", "do", "ko ", "ma", "de ", "mo ", "i", "ke", "ru ", "ne" }
lyrics3 = { "ji", "kan ", "no ", "ha", "te ", "ma", "de ", "Boooon" }
lyrics4 = { "waa", "pu ", "de ", "ruu", "pu ", "na ", "ko", "no ", "o", "mo", "i ", "wa" }
lyrics5 = { "na", "ni ", "mo ", "ka", "mo ", "wo ", "ma", "ki", "kon", "da ", "sou", "zou ", "de ", "a", "so", "bo", "u" }
lyrics6 = { "a", "ru ", "ha", "re", "ta ", "hi ", "no ", "ko", "to" }
lyrics7 = { "ma", "hou ", "i", "jou ", "no ", "yu", "ka", "i ", "ga" }
lyrics8 = { "ka", "gi", "ri", "na", "ku ", "fu", "ri", "so", "so", "gu ", "fu", "ka", "nou ", "ja", "na", "i ", "wa" }
lyrics9 = { "a", "shi", "ta ", "ma", "ta ", "au ", "to", "ki ", "wa", "ra", "i", "na", "ga", "ra ", "ha", "min", "gu" }
lyrics10 = { "u", "re", "shi", "sa ", "wo ", "a", "tsu", "me", "yo", "u" }
lyrics11 = { "kan", "tan ", "nan", "da ", "yo ", "kon", "na ", "no" }
lyrics12 = { "oi", "ka", "ke", "te ", "ne ", "tsu", "ka", "mae", "te ", "mi", "te" }
lyrics13 = { "oo", "ki ", "na ", "yu", "me ", "yu", "me ", "su", "ki ", "de", "shou?" }



function printCentered(y,text,color)
local length = string.len(text)
local x = 240 - ((length*8)/2)
font:print(x,y,text)
end



function round(num,range) --range is optional. 1 is the defalt for range.
range = range or 1
if (num%range < range/2) then
return num-(num%range)
else 
return (num-(num%range))+range
end
end

eve = 0
activeword1 = 0
activeword2 = 0
activeword3 = 0
activeword4 = 0
activeword5= 0
activeword6 = 0
activeword7 = 0
activeword8 = 0
activeword9 = 0
activeword10 = 0
activeword11 = 0
activeword12 = 0
activeword13 = 0
activeword14 = 0
activeword15 = 0
activeword16 = 0
activeword17 = 0
activeword18 = 0
activeword19 = 0
activeword20 = 0

while true do
currentTime = counter:time()

if currentTime >= 3336 and delaytrack == 0 then
Ogg.play(false, 1)
delaytrack = delaytrack + 1
end


 if test == 1 then
x = x - 2
elseif x < 0 then
test = 2
end	
 
System.draw()
screen:clear()







 if currentTime < 5200 then
  screen:blit(0, 0, backGround2)
  end

 		
if start == 0 and z < 319 then 
z = z + 1
screen:blit(z, 39, haruhisprite, 0, 0, 0, 64, 165)
elseif z >= 319 and z < 400 then
screen:blit(319, 39, haruhisprite, 0, 0, 0, 64, 165)
end
if start == 0 and z >= 400 then
start = 1
else z = z + 1 end



  

if line == 1 and bclear[1].complete == 0 then
screen:blit(20, 142, karakeys, 0, 64, 0, 32, 32)
elseif line == 2 and bclear[1].complete == 0 then
screen:blit(38, 182, karakeys, 0, 0, 0, 32, 32)
elseif line == 3 and bclear[1].complete == 0 then
screen:blit(96, 182, karakeys, 0, 228, 0, 30, 30)
elseif line == 4 and bclear[1].complete == 0 then
screen:blit(34, 182, karakeys, 0, 128, 0, 50, 30)
elseif line == 5 and bclear[1].complete == 0 then
screen:blit(26, 142, karakeys, 0, 64, 0, 32, 32)
elseif line == 6 and bclear[1].complete == 0 then
screen:blit(90, 182, karakeys, 0, 288, 0, 30, 30)
elseif line == 7 and bclear[1].complete == 0 then
screen:blit(82, 182, karakeys, 0, 0, 0, 32, 32)
elseif line == 8 and bclear[1].complete == 0 then
screen:blit(30, 142, karakeys, 0, 258, 0, 30, 30)
elseif line == 9 and bclear[1].complete == 0 then
screen:blit(96, 142, karakeys, 0, 288, 0, 30, 30)
elseif line == 10 and bclear[1].complete == 0 then
screen:blit(60, 182, karakeys, 0, 288, 0, 30, 30)
elseif line == 11 and bclear[1].complete == 0 then
screen:blit(92, 182, karakeys, 0, 258, 0, 30, 30)
elseif line == 12 and bclear[1].complete == 0 then
screen:blit(56, 182, karakeys, 0, 288, 0, 30, 30)
elseif line == 13 and bclear[1].complete == 0 then
screen:blit(38, 182, karakeys, 0, 288, 0, 30, 30)
end

if line == 1 and bclear[2].complete == 0 then
screen:blit(52, 142, karakeys, 0, 228, 0, 30, 30)
elseif line == 2 and bclear[2].complete == 0 then
screen:blit(72, 182, karakeys, 0, 64, 0, 32, 32)
elseif line == 3 and bclear[2].complete == 0 then
screen:blit(128, 182, karakeys, 0, 258, 0, 30, 30)
elseif line == 4 and bclear[2].complete == 0 then
screen:blit(88, 182, karakeys, 0, 96, 0, 32, 32)
elseif line == 5 and bclear[2].complete == 0 then
screen:blit(58, 142, karakeys, 0, 64, 0, 32, 32)
elseif line == 6 and bclear[2].complete == 0 then
screen:blit(124, 182, karakeys, 0, 32, 0, 32, 32)
elseif line == 7 and bclear[2].complete == 0 then
screen:blit(118, 182, karakeys, 0, 96, 0, 32, 32)
elseif line == 8 and bclear[2].complete == 0 then
screen:blit(62, 142, karakeys, 0, 258, 0, 30, 30)
elseif line == 9 and bclear[2].complete == 0 then
screen:blit(128, 142, karakeys, 0, 228, 0, 30, 30)
elseif line == 10 and bclear[2].complete == 0 then
screen:blit(92, 182, karakeys, 0, 32, 0, 32, 32)
elseif line == 11 and bclear[2].complete == 0 then
screen:blit(124, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 12 and bclear[2].complete == 0 then
screen:blit(88, 182, karakeys, 0, 258, 0, 30, 30)
elseif line == 13 and bclear[2].complete == 0 then
screen:blit(70, 182, karakeys, 0, 258, 0, 30, 30)
end	

if line == 1 and bclear[3].complete == 0 then
screen:blit(86, 142, karakeys, 0, 64, 0, 32, 32)
elseif line == 2 and bclear[3].complete == 0 then
screen:blit(106, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 3 and bclear[3].complete == 0 then
screen:blit(160, 182, karakeys, 0, 64, 0, 32, 32)
elseif line == 4 and bclear[3].complete == 0 then
screen:blit(122, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 5 and bclear[3].complete == 0 then
screen:blit(92, 142, karakeys, 0, 0, 0, 32, 32)
elseif line == 6 and bclear[3].complete == 0 then
screen:blit(158, 182, karakeys, 0, 96, 0, 32, 32)
elseif line == 7 and bclear[3].complete == 0 then
screen:blit(152, 182, karakeys, 0, 288, 0, 30, 30)
elseif line == 8 and bclear[3].complete == 0 then
screen:blit(94, 142, karakeys, 0, 32, 0, 32, 32)
elseif line == 9 and bclear[3].complete == 0 then
screen:blit(160, 142, karakeys, 0, 318, 0, 30, 30)
elseif line == 10 and bclear[3].complete == 0 then
screen:blit(126, 182, karakeys, 0, 228, 0, 30, 30)
elseif line == 11 and bclear[3].complete == 0 then
screen:blit(156, 182, karakeys, 0, 64, 0, 32, 32)
elseif line == 12 and bclear[3].complete == 0 then
screen:blit(120, 182, karakeys, 0, 258, 0, 30, 30)
elseif line == 13 and bclear[3].complete == 0 then
screen:blit(104, 182, karakeys, 0, 64, 0, 32, 32)
end	

if line == 1 and bclear[4].complete == 0 then
screen:blit(118, 142, karakeys, 0, 228, 0, 30, 30)
elseif line == 2 and bclear[4].complete == 0 then
screen:blit(138, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 3 and bclear[4].complete == 0 then
screen:blit(192, 182, karakeys, 0, 96, 0, 32, 32)
elseif line == 4 and bclear[4].complete == 0 then
screen:blit(156, 182, karakeys, 0, 32, 0, 32, 32)
elseif line == 5 and bclear[4].complete == 0 then
screen:blit(126, 142, karakeys, 0, 258, 0, 30, 30)
elseif line == 6 and bclear[4].complete == 0 then
screen:blit(192, 182, karakeys, 0, 32, 0, 32, 32)
elseif line == 7 and bclear[4].complete == 0 then
screen:blit(186, 182, karakeys, 0, 228, 0, 30, 30)
elseif line == 8 and bclear[4].complete == 0 then
screen:blit(128, 142, karakeys, 0, 64, 0, 32, 32)
elseif line == 9 and bclear[4].complete == 0 then
screen:blit(192, 142, karakeys, 0, 0, 0, 32, 32)
elseif line == 10 and bclear[4].complete == 0 then
screen:blit(158, 182, karakeys, 0, 228, 0, 30, 30)
elseif line == 11 and bclear[4].complete == 0 then
screen:blit(190, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 12 and bclear[4].complete == 0 then
screen:blit(152, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 13 and bclear[4].complete == 0 then
screen:blit(138, 182, karakeys, 0, 128, 0, 50, 30)
end

if line == 1 and bclear[5].complete == 0 then
screen:blit(152, 142, karakeys, 0, 0, 0, 32, 32)
elseif line == 2 and bclear[5].complete == 0 then
screen:blit(172, 182, karakeys, 0, 258, 0, 30, 30)
elseif line == 3 and bclear[5].complete == 0 then
screen:blit(224, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 4 and bclear[5].complete == 0 then
screen:blit(190, 182, karakeys, 0, 96, 0, 32, 32)
elseif line == 5 and bclear[5].complete == 0 then
screen:blit(158, 142, karakeys, 0, 0, 0, 32, 32)
elseif line == 6 and bclear[5].complete == 0 then
screen:blit(228, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 7 and bclear[5].complete == 0 then
screen:blit(220, 182, karakeys, 0, 64, 0, 32, 32)
elseif line == 8 and bclear[5].complete == 0 then
screen:blit(162, 142, karakeys, 0, 258, 0, 30, 30)
elseif line == 9 and bclear[5].complete == 0 then
screen:blit(226, 142, karakeys, 0, 318, 0, 30, 30)
elseif line == 10 and bclear[5].complete == 0 then
screen:blit(190, 182, karakeys, 0, 128, 0, 50, 30)
elseif line == 11 and bclear[5].complete == 0 then
screen:blit(222, 182, karakeys, 0, 128, 0, 50, 30)
elseif line == 12 and bclear[5].complete == 0 then
screen:blit(184, 182, karakeys, 0, 64, 0, 32, 32)
elseif line == 13 and bclear[5].complete == 0 then
screen:blit(190, 182, karakeys, 0, 0, 0, 32, 32)
end	

if line == 1 and bclear[6].complete == 0 then
screen:blit(184, 142, karakeys, 0, 318, 0, 30, 30)
elseif line == 2 and bclear[6].complete == 0 then
screen:blit(206, 182, karakeys, 0, 0, 0, 32, 32)
elseif line == 3 and bclear[6].complete == 0 then
screen:blit(256, 182, karakeys, 0, 0, 0, 32, 32)
elseif line == 4 and bclear[6].complete == 0 then
screen:blit(224, 182, karakeys, 0, 64, 0, 32, 32)
elseif line == 5 and bclear[6].complete == 0 then
screen:blit(192, 142, karakeys, 0, 128, 0, 50, 30)
elseif line == 6 and bclear[6].complete == 0 then
screen:blit(262, 182, karakeys, 0, 96, 0, 32, 32)
elseif line == 7 and bclear[6].complete == 0 then
screen:blit(254, 182, karakeys, 0, 128, 0, 50, 30)
elseif line == 8 and bclear[6].complete == 0 then
screen:blit(194, 142, karakeys, 0, 96, 0, 32, 32)
elseif line == 9 and bclear[6].complete == 0 then
screen:blit(258, 142, karakeys, 0, 288, 0, 30, 30)
elseif line == 10 and bclear[6].complete == 0 then
screen:blit(242, 182, karakeys, 0, 288, 0, 30, 30)
elseif line == 11 and bclear[6].complete == 0 then
screen:blit(274, 182, karakeys, 0, 258, 0, 30, 30)
elseif line == 12 and bclear[6].complete == 0 then
screen:blit(218, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 13 and bclear[6].complete == 0 then
screen:blit(224, 182, karakeys, 0, 128, 0, 50, 30)
end	

if line == 1 and bclear[7].complete == 0 then
screen:blit(216, 142, karakeys, 0, 288, 0, 30, 30)
elseif line == 2 and bclear[7].complete == 0 then
screen:blit(238, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 3 and bclear[7].complete == 0 then
screen:blit(288, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 4 and bclear[7].complete == 0 then
screen:blit(258, 182, karakeys, 0, 258, 0, 30, 30)
elseif line == 5 and bclear[7].complete == 0 then
screen:blit(244, 142, karakeys, 0, 0, 0, 32, 32)
elseif line == 6 and bclear[7].complete == 0 then
screen:blit(294, 182, karakeys, 0, 64, 0, 32, 32)
elseif line == 7 and bclear[7].complete == 0 then
screen:blit(306, 182, karakeys, 0, 258, 0, 30, 30)
elseif line == 8 and bclear[7].complete == 0 then
screen:blit(228, 142, karakeys, 0, 32, 0, 32, 32)
elseif line == 9 and bclear[7].complete == 0 then
screen:blit(290, 142, karakeys, true, 318, 0, 30, 30)
elseif line == 10 and bclear[7].complete == 0 then
screen:blit(274, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 11 and bclear[7].complete == 0 then
screen:blit(306, 182, karakeys, 0, 64, 0, 32, 32)
elseif line == 12 and bclear[7].complete == 0 then
screen:blit(250, 182, karakeys, 0, 258, 0, 30, 30)
elseif line == 13 and bclear[7].complete == 0 then
screen:blit(276, 182, karakeys, 0, 0, 0, 32, 32)
end	

if line == 1 and bclear[8].complete == 0 then
screen:blit(248, 142, karakeys, 0, 64, 0, 32, 32)
elseif line == 2 and bclear[8].complete == 0 then
screen:blit(272, 182, karakeys, 0, 0, 0, 32, 32)
elseif line == 3 and bclear[8].complete == 0 then
screen:blit(322, 182, karakeys, 0, 96, 0, 32, 32)
elseif line == 4 and bclear[8].complete == 0 then
screen:blit(292, 182, karakeys, 0, 64, 0, 32, 32)
elseif line == 5 and bclear[8].complete == 0 then
screen:blit(278, 142, karakeys, 0, 258, 0, 30, 30)
elseif line == 6 and bclear[8].complete == 0 then
screen:blit(328, 182, karakeys, 0, 258, 0, 30, 30)
elseif line == 7 and bclear[8].complete == 0 then
screen:blit(338, 182, karakeys, 0, 288, 0, 30, 30)
elseif line == 8 and bclear[8].complete == 0 then
screen:blit(262, 142, karakeys, 0, 228, 0, 30, 30)
elseif line == 9 and bclear[8].complete == 0 then
screen:blit(322, 142, karakeys, 0, 258, 0, 30, 30)
elseif line == 10 and bclear[8].complete == 0 then
screen:blit(306, 182, karakeys, 0, 0, 0, 32, 32)
elseif line == 11 and bclear[8].complete == 0 then
screen:blit(340, 182, karakeys, 0, 64, 0, 32, 32)
elseif line == 12 and bclear[8].complete == 0 then
screen:blit(282, 182, karakeys, 0, 0, 0, 32, 32)
elseif line == 13 and bclear[8].complete == 0 then
screen:blit(310, 182, karakeys, 0, 228, 0, 30, 30)
end	

if line == 1 and bclear[9].complete == 0 then
screen:blit(280, 142, karakeys, 0, 318, 0, 30, 30)
elseif line == 2 and bclear[9].complete == 0 then
screen:blit(306, 182, karakeys, 0, 288, 0, 30, 30)
elseif line == 4 and bclear[9].complete == 0 then
screen:blit(326, 182, karakeys, 0, 288, 0, 30, 30)
elseif line == 5 and bclear[9].complete == 0 then
screen:blit(310, 142, karakeys, 0, 258, 0, 30, 30)
elseif line == 6 and bclear[9].complete == 0 then
screen:blit(360, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 7 and bclear[9].complete == 0 then
screen:blit(372, 182, karakeys, 0, 258, 0, 30, 30)
elseif line == 8 and bclear[9].complete == 0 then
screen:blit(294, 142, karakeys, 0, 228, 0, 30, 30)
elseif line == 9 and bclear[9].complete == 0 then
screen:blit(74, 187, karakeys, 0, 128, 0, 50, 30)
elseif line == 10 and bclear[9].complete == 0 then
screen:blit(340, 182, karakeys, 0, 128, 0, 50, 30)
elseif line == 12 and bclear[9].complete == 0 then
screen:blit(316, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 13 and bclear[9].complete == 0 then
screen:blit(342, 182, karakeys, 0, 258, 0, 30, 30)
end	

if line == 1 and bclear[10].complete == 0 then
screen:blit(312, 142, karakeys, 0, 258, 0, 30, 30)
elseif line == 2 and bclear[10].complete == 0 then
screen:blit(338, 182, karakeys, 0, 258, 0, 30, 30)
elseif line == 4 and bclear[10].complete == 0 then
screen:blit(358, 182, karakeys, 0, 0, 0, 32, 32)
elseif line == 5 and bclear[10].complete == 0 then
screen:blit(342, 142, karakeys, 0, 318, 0, 30, 30)
elseif line == 8 and bclear[10].complete == 0 then
screen:blit(326, 142, karakeys, 0, 258, 0, 30, 30)
elseif line == 9 and bclear[10].complete == 0 then
screen:blit(126, 187, karakeys, 0, 32, 0, 32, 32)
elseif line == 10 and bclear[10].complete == 0 then
screen:blit(392, 182, karakeys, 0, 288, 0, 30, 30)
elseif line == 12 and bclear[10].complete == 0 then
screen:blit(350, 182, karakeys, 0, 0, 0, 32, 32)
elseif line == 13 and bclear[10].complete == 0 then
screen:blit(374, 182, karakeys, 0, 318, 0, 30, 30)
end	

if line == 1 and bclear[11].complete == 0 then
screen:blit(344, 142, karakeys, 0, 288, 0, 30, 30)
elseif line == 2 and bclear[11].complete == 0 then
screen:blit(370, 182, karakeys, 0, 32, 0, 32, 32)
elseif line == 4 and bclear[11].complete == 0 then
screen:blit(392, 182, karakeys, 0, 288, 0, 30, 30)
elseif line == 5 and bclear[11].complete == 0 then
screen:blit(374, 142, karakeys, 0, 228, 0, 30, 30)
elseif line == 8 and bclear[11].complete == 0 then
screen:blit(358, 142, karakeys, 0, 96, 0, 32, 32)
elseif line == 9 and bclear[11].complete == 0 then
screen:blit(160, 187, karakeys, 0, 288, 0, 30, 30)
elseif line == 12 and bclear[11].complete == 0 then
screen:blit(384, 182, karakeys, 0, 318, 0, 30, 30)
elseif line == 13 and bclear[11].complete == 0 then
screen:blit(406, 182, karakeys, 0, 228, 0, 30, 30)
end	

if line == 1 and bclear[12].complete == 0 then
screen:blit(376, 142, karakeys, 0, 258, 0, 30, 30)
elseif line == 2 and bclear[12].complete == 0 then
screen:blit(404, 182, karakeys, 0, 64, 0, 32, 32)
elseif line == 4 and bclear[12].complete == 0 then
screen:blit(426, 182, karakeys, 0, 96, 0, 32, 32)
elseif line == 5 and bclear[12].complete == 0 then
screen:blit(406, 142, karakeys, 0, 228, 0, 30, 30)
elseif line == 8 and bclear[12].complete == 0 then
screen:blit(392, 142, karakeys, 0, 258, 0, 30, 30)
elseif line == 9 and bclear[12].complete == 0 then
screen:blit(192, 187, karakeys, 0, 64, 0, 32, 32)
end	

if line == 1 and bclear[13].complete == 0 then
screen:blit(408, 142, karakeys, 0, 128, 0, 50, 30)
elseif line == 5 and bclear[13].complete == 0 then
screen:blit(438, 142, karakeys, 0, 318, 0, 30, 30)
elseif line == 8 and bclear[13].complete == 0 then
screen:blit(424, 142, karakeys, 0, 64, 0, 32, 32)
elseif line == 9 and bclear[13].complete == 0 then
screen:blit(226, 187, karakeys, 0, 258, 0, 30, 30)
end	

if line == 1 and bclear[14].complete == 0 then
screen:blit(120, 187, karakeys, 0, 318, 0, 30, 30)
elseif line == 5 and bclear[14].complete == 0 then
screen:blit(174, 187, karakeys, 0, 288, 0, 30, 30)
elseif line == 8 and bclear[14].complete == 0 then
screen:blit(170, 187, karakeys, 0, 228, 0, 30, 30)
elseif line == 9 and bclear[14].complete == 0 then
screen:blit(258, 187, karakeys, 0, 32, 0, 32, 32)
end	
	
if line == 1 and bclear[15].complete == 0 then
screen:blit(152, 187, karakeys, 0, 258, 0, 30, 30)
elseif line == 5 and bclear[15].complete == 0 then
screen:blit(206, 187, karakeys, 0, 228, 0, 30, 30)
elseif line == 8 and bclear[15].complete == 0 then
screen:blit(202, 187, karakeys, 0, 64, 0, 32, 32)
elseif line == 9 and bclear[15].complete == 0 then
screen:blit(292, 187, karakeys, 0, 96, 0, 32, 32)
end	
		
if line == 1 and bclear[16].complete == 0 then
screen:blit(184, 187, karakeys, 0, 288, 0, 30, 30)
elseif line == 5 and bclear[16].complete == 0 then
screen:blit(240, 187, karakeys, 0, 96, 0, 32, 32)
elseif line == 8 and bclear[16].complete == 0 then
screen:blit(236, 187, karakeys, 0, 288, 0, 30, 30)
elseif line == 9 and bclear[16].complete == 0 then
screen:blit(326, 187, karakeys, 0, 0, 0, 32, 32)
end	
		
if line == 1 and bclear[17].complete == 0 then
screen:blit(216, 187, karakeys, 0, 258, 0, 30, 30)
elseif line == 5 and bclear[17].complete == 0 then
screen:blit(274, 187, karakeys, 0, 288, 0, 30, 30)
elseif line == 8 and bclear[17].complete == 0 then
screen:blit(268, 187, karakeys, 0, 96, 0, 32, 32)
elseif line == 9 and bclear[17].complete == 0 then
screen:blit(360, 187, karakeys, 0, 258, 0, 30, 30)
end	
		
if line == 1 and bclear[18].complete == 0 then
screen:blit(248, 187, karakeys, 0, 228, 0, 30, 30)
end	
		
if line == 1 and bclear[19].complete == 0 then
screen:blit(280, 187, karakeys, 0, 318, 0, 30, 30)
end	
		
if line == 1 and bclear[20].complete == 0 then
screen:blit(312, 187, karakeys, 0, 32, 0, 32, 32)
end	



if loopCount >= 0 and loopCount < 4 and start == 1 then 
screen:blit(319, 39, haruhisprite, 0, 0, 0, 64, 165)
elseif loopCount >= 4 and loopCount < 8 and start == 1 then 
screen:blit(318, 39, haruhisprite, 0, 64, 0, 64, 165)
elseif loopCount >= 8 and loopCount < 12 and start == 1 then
screen:blit(318, 39, haruhisprite, 0, 128, 0, 64, 164)
elseif loopCount >= 12 and loopCount < 16 and start == 1 then
screen:blit(317, 39, haruhisprite, 0, 192, 0, 64, 165)
elseif loopCount >= 16 and loopCount < 20 and start == 1 then
screen:blit(317, 39, haruhisprite, 0, 256, 0, 64, 164)
elseif loopCount >= 20 and loopCount < 24 and start == 1 then
screen:blit(317, 39, haruhisprite, 0, 320, 0, 63, 164)
elseif loopCount >= 24 and loopCount < 28 and start == 1 then
screen:blit(312, 39, haruhisprite, 0, 383, 0, 63, 164)
elseif loopCount >= 28 and loopCount < 32 and start == 1 then
screen:blit(317, 39, haruhisprite, 0, 446, 0, 63, 165) end
if start == 1 then loopCount = loopCount + 1 
elseif loopCount >= 32 then loopCount = 100
end

if line == 1 and currentTime < 16300 then printCentered(242,"nazonazo mitai ni chikyuugi wo tokiakashitara",white)
elseif line == 2 and currentTime < 20113 then printCentered(242,"minna de doko made mo ikeru ne",white)
elseif line == 3 and currentTime < 22445 then printCentered(242,"jikan no hate made Boooon",white)
elseif line == 4 and currentTime < 26626 then printCentered(242,"waapu de ruupu na kono omoi wa",white)
elseif line == 5 and currentTime < 32806 then printCentered(242,"nani mo kamo wo makikonda souzou de asobou",white)
elseif line == 6 and currentTime < 35435 then printCentered(242,"aru hareta hi no koto",white)
elseif line == 7 and currentTime < 37900 then printCentered(242,"mahou ijou no yukai ga",white)
elseif line == 8 and currentTime < 43500 then printCentered(242,"kagirinaku furisosogu fukanou janai wa",white)
elseif line == 9 and currentTime < 49000 then printCentered(242,"ashita mata au toki warainagara hamingu",white)
elseif line == 10 and currentTime < 52350 then printCentered(242,"ureshisa wo atsumeyou",white)
elseif line == 11 and currentTime < 54622 then printCentered(242,"kantan nanda yo konna no",white)
elseif line == 12 and currentTime < 59454 then printCentered(242,"oikakete ne tsukamaete mite",white)
elseif line == 13 then printCentered(242,"ooki na yume yume suki deshou?",white)
end




font:print(10, 80, "line:" .. line)
if string.len(name) ~= 0 then
font:setStyle(0.5, blue, transparent, IntraFont.CACHE_ALL);
font:print(10, 90, "Start")
end






if line == 1 and currentTime >= 10700 and currentTime < 10880 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(60, 242, lyrics[1]) --na
elseif line == 1 and currentTime >= 10900 and currentTime < 11080 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(72, 242, lyrics[2]) --zo
elseif line == 1 and currentTime >= 11100 and currentTime < 11280 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(84, 242, lyrics[3]) --na
elseif line == 1 and currentTime >= 11300 and currentTime < 11670 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(95.6, 242, lyrics[4]) --zo
elseif line == 1 and currentTime >= 12100 and currentTime < 12360 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(112.2, 242, lyrics[5]) --mi
elseif line == 1 and currentTime >= 12380 and currentTime < 12520 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(124.2, 242, lyrics[6]) --ta
elseif line == 1 and currentTime >= 12540 and currentTime < 12680 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(135, 242, lyrics[7]) --i
elseif line == 1 and currentTime >= 12700 and currentTime < 13040 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(144.5, 242, lyrics[8]) --ni
elseif line == 1 and currentTime >= 13060 and currentTime < 13200 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(160, 242, lyrics[9]) --chi
elseif line == 1 and currentTime >= 13220 and currentTime < 13500 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(176.3, 242, lyrics[10]) --iky
elseif line == 1 and currentTime >= 13520 and currentTime < 13740 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(194.5, 242, lyrics[11]) --u
elseif line == 1 and currentTime >= 13760 and currentTime < 14000 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(201, 242, lyrics[12]) --gi
elseif line == 1 and currentTime >= 14020 and currentTime < 14480 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(216.4, 242, lyrics[13]) --wo
elseif line == 1 and currentTime >= 14500 and currentTime < 14670 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(234.4, 242, lyrics[14]) --to
elseif line == 1 and currentTime >= 14700 and currentTime < 14940 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(245.4, 242, lyrics[15]) --ki
elseif line == 1 and currentTime >= 14960 and currentTime < 15130 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(255.9, 242, lyrics[16]) --a
elseif line == 1 and currentTime >= 15150 and currentTime < 15460 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(262, 242, lyrics[17]) --ka
elseif line == 1 and currentTime >= 15480 and currentTime < 15650 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(273.6, 242, lyrics[18]) --shi
elseif line == 1 and currentTime >= 15670 and currentTime < 15820 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(290.2, 242, lyrics[19]) --ta
elseif line == 1 and currentTime >= 15840 and currentTime < 16000 then
font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(300.8, 242, lyrics[20]) --ra
end



if line == 1 and activeword1 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(60, 242, lyrics[1]) --na
end
if line == 1 and activeword2 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(72, 242, lyrics[2]) --zo
end
if line == 1 and activeword3 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(84, 242, lyrics[3]) --na
end
if line == 1 and activeword4 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(95.6, 242, lyrics[4]) --zo
end
if line == 1 and activeword5 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(112.2, 242, lyrics[5]) --mi
end
if line == 1 and activeword6 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(124.2, 242, lyrics[6]) --ta
end
if line == 1 and activeword7 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(135, 242, lyrics[7]) --i
end
if line == 1 and activeword8 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(144.5, 242, lyrics[8]) --ni
end
if line == 1 and activeword9 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(160, 242, lyrics[9]) --chi
end
if line == 1 and activeword10 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(176.3, 242, lyrics[10]) --iky
end
if line == 1 and activeword11 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(194.5, 242, lyrics[11]) --u
end
if line == 1 and activeword12 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(201, 242, lyrics[12]) --gi
end
if line == 1 and activeword13 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(216.4, 242, lyrics[13]) --wo
end
if line == 1 and activeword14 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(234.4, 242, lyrics[14]) --to
end
if line == 1 and activeword15 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(245.4, 242, lyrics[15]) --ki
end
if line == 1 and activeword16 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(255.9, 242, lyrics[16]) --a
end
if line == 1 and activeword17 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(262, 242, lyrics[17]) --ka
end
if line == 1 and activeword18 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(273.6, 242, lyrics[18]) --shi
end
if line == 1 and activeword19 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(290.2, 242, lyrics[19]) --ta
end
if line == 1 and activeword20 == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(300.8, 242, lyrics[20]) --ra
end






if line == 2 and currentTime >= 16240 and currentTime < 16560 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(120, 242, lyrics2[1]) --min
elseif line == 2 and currentTime >= 16610 and currentTime < 16880 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(138, 242, lyrics2[2]) --na
elseif line == 2 and currentTime >= 16900 and currentTime < 17260 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(154.4, 242, lyrics2[3]) --de
elseif line == 2 and currentTime >= 17280 and currentTime < 17580 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(171.6, 242, lyrics2[4]) --do
elseif line == 2 and currentTime >= 17600 and currentTime < 17860 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(183.8, 242, lyrics2[5]) --ko
elseif line == 2 and currentTime >= 17880 and currentTime < 18000 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(200.6, 242, lyrics2[6]) --ma
elseif line == 2 and currentTime >= 18134 and currentTime < 18290 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(214, 242, lyrics2[7]) --de
elseif line == 2 and currentTime >= 18310 and currentTime < 18600 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(230.8, 242, lyrics2[8]) --mo
elseif line == 2 and currentTime >= 18620 and currentTime < 18810 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(249, 242, lyrics2[9]) --i
elseif line == 2 and currentTime >= 18830 and currentTime < 19130 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(253.8, 242, lyrics2[10]) --ke
elseif line == 2 and currentTime >= 19150 and currentTime < 19380 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(265.8, 242, lyrics2[11]) --re
elseif line == 2 and currentTime >= 19400 and currentTime < 19700 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(282, 242, lyrics2[12]) --ne
end

if line == 2 and activeword1 == 2 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(120, 242, lyrics2[1]) --min
end
if line == 2 and activeword2 == 2 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(138, 242, lyrics2[2]) --na
end
if line == 2 and activeword3 == 2 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(154.4, 242, lyrics2[3]) --de
end
if line == 2 and activeword4 == 2 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(171.6, 242, lyrics2[4]) --do
end
if line == 2 and activeword5 == 2 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(183.8, 242, lyrics2[5]) --ko
end
if line == 2 and activeword6 == 2 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(200.6, 242, lyrics2[6]) --ma
end
if line == 2 and activeword7 == 2 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(214, 242, lyrics2[7]) --de
end
if line == 2 and activeword8 == 2 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(230.8, 242, lyrics2[8]) --mo
end
if line == 2 and activeword9 == 2 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(249, 242, lyrics2[9]) --i
end
if line == 2 and activeword10 == 2 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(253.8, 242, lyrics2[10]) --ke
end
if line == 2 and activeword11 == 2 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(265.8, 242, lyrics2[11]) --re
end
if line == 2 and activeword12 == 2 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(282, 242, lyrics2[12]) --ne
end


if line == 3 and currentTime >= 20080 and currentTime < 20200 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(140, 242, lyrics3[1]) --ji
elseif line == 3 and currentTime >= 20220 and currentTime < 20420 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(149.4, 242, lyrics3[2]) --kan 
elseif line == 3 and currentTime >= 20440 and currentTime < 20660 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(171.8, 242, lyrics3[3]) --no 
elseif line == 3 and currentTime >= 20680 and currentTime < 20860 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(188.7, 242, lyrics3[4]) --ha
elseif line == 3 and currentTime >= 20880 and currentTime < 21180 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(200.2, 242, lyrics3[5]) --te 
elseif line == 3 and currentTime >= 21200 and currentTime < 21320 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(216, 242, lyrics3[6]) --ma
elseif line == 3 and currentTime >= 21340 and currentTime < 21560 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(229.3, 242, lyrics3[7]) --de 
elseif line == 3 and currentTime >= 21580 and currentTime < 22100 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(246.3, 242, lyrics3[8]) --Boooon
end
if line == 3 and activeword1 == 3 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(140, 242, lyrics3[1]) --ji
end
if line == 3 and activeword2 == 3 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(149.4, 242, lyrics3[2]) --kan 
end
if line == 3 and activeword3 == 3 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(171.8, 242, lyrics3[3]) --no 
end
if line == 3 and activeword4 == 3 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(188.7, 242, lyrics3[4]) --ha
end
if line == 3 and activeword5 == 3 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(200.2, 242, lyrics3[5]) --te 
end
if line == 3 and activeword6 == 3 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(216, 242, lyrics3[6]) --ma
end
if line == 3 and activeword7 == 3 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(229.3, 242, lyrics3[7]) --de 
end
if line == 3 and activeword8 == 3 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(246.3, 242, lyrics3[8]) --Boooon
end


if line == 4 and currentTime >= 22360 and currentTime < 22700 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(120, 242, lyrics4[1]) --waa
elseif line == 4 and currentTime >= 22720 and currentTime < 22860 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(138.9, 242, lyrics4[2]) --pu
elseif line == 4 and currentTime >= 22880 and currentTime < 23840 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(156, 242, lyrics4[3]) --de
elseif line == 4 and currentTime >= 23860 and currentTime < 24160 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(172.9, 242, lyrics4[4]) --ruu
elseif line == 4 and currentTime >= 24180 and currentTime < 24310 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(191, 242, lyrics4[5]) --pu
elseif line == 4 and currentTime >= 24330 and currentTime < 24860 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(208, 242, lyrics4[6]) --na
elseif line == 4 and currentTime >= 24880 and currentTime < 25010 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(224.4, 242, lyrics4[7]) --ko
elseif line == 4 and currentTime >= 25030 and currentTime < 25400 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(236.7, 242, lyrics4[8]) --no
elseif line == 4 and currentTime >= 25420 and currentTime < 25600 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(253.4, 242, lyrics4[9]) --o
elseif line == 4 and currentTime >= 25620 and currentTime < 25800 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(259.5, 242, lyrics4[10]) --mo
elseif line == 4 and currentTime >= 25820 and currentTime < 26160 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(272.8, 242, lyrics4[11]) --i
elseif line == 4 and currentTime >= 26180 and currentTime < 26600 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(282.4, 242, lyrics4[12]) --wa
end
if line == 4 and activeword1 == 4 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(120, 242, lyrics4[1]) --waa
end
if line == 4 and activeword2 == 4 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(138.9, 242, lyrics4[2]) --pu
end
if line == 4 and activeword3 == 4 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(156, 242, lyrics4[3]) --de
end
if line == 4 and activeword4 == 4 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(172.9, 242, lyrics4[4]) --ruu
end
if line == 4 and activeword5 == 4 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(191, 242, lyrics4[5]) --pu
end
if line == 4 and activeword6 == 4 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(208, 242, lyrics4[6]) --na
end
if line == 4 and activeword7 == 4 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(224.4, 242, lyrics4[7]) --ko
end
if line == 4 and activeword8 == 4 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(236.7, 242, lyrics4[8]) --no
end
if line == 4 and activeword9 == 4 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(253.4, 242, lyrics4[9]) --o
end
if line == 4 and activeword10 == 4 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(259.5, 242, lyrics4[10]) --mo
end
if line == 4 and activeword11 == 4 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(272.8, 242, lyrics4[11]) --i
end
if line == 4 and activeword12 == 4 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(282.4, 242, lyrics4[12]) --wa
end
--

if line == 5 and currentTime >= 26780 and currentTime < 26920 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(72, 242, lyrics5[1]) --na
elseif line == 5 and currentTime >= 26960 and currentTime < 27140 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(84, 242, lyrics5[2]) --ni
elseif line == 5 and currentTime >= 27160 and currentTime < 27290 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(99, 242, lyrics5[3]) --mo
elseif line == 5 and currentTime >= 27310 and currentTime < 27460 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(117.4, 242, lyrics5[4]) --ka
elseif line == 5 and currentTime >= 27480 and currentTime < 27650 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(129, 242, lyrics5[5]) --mo
elseif line == 5 and currentTime >= 27670 and currentTime < 27960 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(147.6, 242, lyrics5[6]) --wo
elseif line == 5 and currentTime >= 27980 and currentTime < 28100 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(165.2, 242, lyrics5[7]) --ma
elseif line == 5 and currentTime >= 28120 and currentTime < 28270 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(179, 242, lyrics5[8]) --ki
elseif line == 5 and currentTime >= 28390 and currentTime < 28780 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(189, 242, lyrics5[9]) --kon
elseif line == 5 and currentTime >= 28800 and currentTime < 29000 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(207, 242, lyrics5[10]) --da
elseif line == 5 and currentTime >= 29020 and currentTime < 29380 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(223.6, 242, lyrics5[11]) --sou
elseif line == 5 and currentTime >= 29400 and currentTime < 29920 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(242, 242, lyrics5[12]) --zou
elseif line == 5 and currentTime >= 29940 and currentTime < 31080 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(265, 242, lyrics5[13]) --de
elseif line == 5 and currentTime >= 31100 and currentTime < 31290 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(282, 242, lyrics5[14]) --a
elseif line == 5 and currentTime >= 31310 and currentTime < 31780 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(288, 242, lyrics5[15]) --so
elseif line == 5 and currentTime >= 31800 and currentTime < 32040 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(300, 242, lyrics5[16]) --bo
elseif line == 5 and currentTime >= 32060 and currentTime < 32580 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(312, 242, lyrics5[17]) --u
end
if line == 5 and activeword1 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(72, 242, lyrics5[1]) --na
end
if line == 5 and activeword2 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(84, 242, lyrics5[2]) --ni
end
if line == 5 and activeword3 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(99, 242, lyrics5[3]) --mo
end
if line == 5 and activeword4 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(117.4, 242, lyrics5[4]) --ka
end
if line == 5 and activeword5 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(129, 242, lyrics5[5]) --mo
end
if line == 5 and activeword6 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(147.6, 242, lyrics5[6]) --wo
end
if line == 5 and activeword7 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(165.2, 242, lyrics5[7]) --ma
end
if line == 5 and activeword8 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(179, 242, lyrics5[8]) --ki
end
if line == 5 and activeword9 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(189, 242, lyrics5[9]) --kon
end
if line == 5 and activeword10 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(207, 242, lyrics5[10]) --da
end
if line == 5 and activeword11 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(223.6, 242, lyrics5[11]) --sou
end
if line == 5 and activeword12 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(242, 242, lyrics5[12]) --zou
end
if line == 5 and activeword7 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(265, 242, lyrics5[13]) --de
end
if line == 5 and activeword8 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(282, 242, lyrics5[14]) --a
end
if line == 5 and activeword9 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(288, 242, lyrics5[15]) --so
end
if line == 5 and activeword10 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(300, 242, lyrics5[16]) --bo
end
if line == 5 and activeword11 == 5 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(312, 242, lyrics5[17]) --u
end

if line == 6 and currentTime >= 32700 and currentTime < 32860 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(156, 242, lyrics6[1]) --a
elseif line == 6 and currentTime >= 32880 and currentTime < 33200 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(162, 242, lyrics6[2]) --ru
elseif line == 6 and currentTime >= 33220 and currentTime < 33400 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(178, 242, lyrics6[3]) --ha
elseif line == 6 and currentTime >= 33420 and currentTime < 33600 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(190, 242, lyrics6[4]) --re
elseif line == 6 and currentTime >= 33620 and currentTime < 33890 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(201.8, 242, lyrics6[5]) --ta
elseif line == 6 and currentTime >= 33910 and currentTime < 34300 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(216.6, 242, lyrics6[6]) --hi
elseif line == 6 and currentTime >= 34320 and currentTime < 34480 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(232.7, 242, lyrics6[7]) --no
elseif line == 6 and currentTime >= 34500 and currentTime < 34650 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(249, 242, lyrics6[8]) --ko
elseif line == 6 and currentTime >= 34670 and currentTime < 35320 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(261, 242, lyrics6[9]) --to
end
if line == 6 and activeword1 == 6 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(156, 242, lyrics6[1]) --a
end
if line == 6 and activeword2 == 6 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(162, 242, lyrics6[2]) --ru
end
if line == 6 and activeword3 == 6 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(178, 242, lyrics6[3]) --ha
end
if line == 6 and activeword4 == 6 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(190, 242, lyrics6[4]) --re
end
if line == 6 and activeword5 == 6 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(201.8, 242, lyrics6[5]) --ta
end
if line == 6 and activeword6 == 6 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(216.6, 242, lyrics6[6]) --hi
end
if line == 6 and activeword7 == 6 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(232.7, 242, lyrics6[7]) --no
end
if line == 6 and activeword8 == 6 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(249, 242, lyrics6[8]) --ko
end
if line == 6 and activeword9 == 6 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(261, 242, lyrics6[9]) --to
end

if line == 7 and currentTime >= 35440 and currentTime < 35580 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(152, 242, lyrics7[1])
elseif line == 7 and currentTime >= 35600 and currentTime < 35880 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(165, 242, lyrics7[2])
elseif line == 7 and currentTime >= 35900 and currentTime < 36160 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(188, 242, lyrics7[3])
elseif line == 7 and currentTime >= 36180 and currentTime < 36580 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(192.8, 242, lyrics7[4])
elseif line == 7 and currentTime >= 36600 and currentTime < 36740 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(215, 242, lyrics7[5])
elseif line == 7 and currentTime >= 36760 and currentTime < 37020 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(232, 242, lyrics7[6])
elseif line == 7 and currentTime >= 37040 and currentTime < 37160 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(244, 242, lyrics7[7])
elseif line == 7 and currentTime >= 37180 and currentTime < 37340 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(256, 242, lyrics7[8])
elseif line == 7 and currentTime >= 37360 and currentTime < 37800 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(265, 242, lyrics7[9])
end

if line == 7 and activeword1 == 7 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(152, 242, lyrics7[1])
end
if line == 7 and activeword2 == 7 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(165, 242, lyrics7[2])
end
if line == 7 and activeword3 == 7 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(188, 242, lyrics7[3])
end
if line == 7 and activeword4 == 7 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(192.8, 242, lyrics7[4])
end
if line == 7 and activeword5 == 7 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(215, 242, lyrics7[5])
end
if line == 7 and activeword6 == 7 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(232, 242, lyrics7[6])
end
if line == 7 and activeword7 == 7 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(244, 242, lyrics7[7])
end
if line == 7 and activeword8 == 7 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(256, 242, lyrics7[8])
end
if line == 7 and activeword9 == 7 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(265, 242, lyrics7[9])
end


if line == 8 and currentTime >= 38000 and currentTime < 38100 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(88, 242, lyrics8[1])
elseif line == 8 and currentTime >= 38120 and currentTime < 38220 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(100, 242, lyrics8[2])
elseif line == 8 and currentTime >= 38240 and currentTime < 38500 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(111, 242, lyrics8[3])
elseif line == 8 and currentTime >= 38520 and currentTime < 38800 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(121, 242, lyrics8[4])
elseif line == 8 and currentTime >= 38820 and currentTime < 39240 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(133, 242, lyrics8[5])
elseif line == 8 and currentTime >= 39260 and currentTime < 39500 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(149, 242, lyrics8[6])
elseif line == 8 and currentTime >= 39520 and currentTime < 39660 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(161, 242, lyrics8[7])
elseif line == 8 and currentTime >= 39680 and currentTime < 39880 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(171, 242, lyrics8[8])
elseif line == 8 and currentTime >= 39900 and currentTime < 40110 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(183, 242, lyrics8[9])
elseif line == 8 and currentTime >= 40130 and currentTime < 40660 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(195, 242, lyrics8[10])
elseif line == 8 and currentTime >= 40680 and currentTime < 40880 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(212, 242, lyrics8[11])
elseif line == 8 and currentTime >= 40900 and currentTime < 41080 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(224, 242, lyrics8[12])
elseif line == 8 and currentTime >= 41100 and currentTime < 41340 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(236, 242, lyrics8[13])
elseif line == 8 and currentTime >= 41360 and currentTime < 41520 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(259, 242, lyrics8[14])
elseif line == 8 and currentTime >= 41540 and currentTime < 41760 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(269, 242, lyrics8[15])
elseif line == 8 and currentTime >= 41780 and currentTime < 41980 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(281, 242, lyrics8[16])
elseif line == 8 and currentTime >= 42000 and currentTime < 42600 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(291, 242, lyrics8[17])
end

if line == 8 and activeword1 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(88, 242, lyrics8[1])
end
if line == 8 and activeword2 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(100, 242, lyrics8[2])
end
if line == 8 and activeword3 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(111, 242, lyrics8[3])
end
if line == 8 and activeword4 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(121, 242, lyrics8[4])
end
if line == 8 and activeword5 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(133, 242, lyrics8[5])
end
if line == 8 and activeword6 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(149, 242, lyrics8[6])
end
if line == 8 and activeword7 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(161, 242, lyrics8[7])
end
if line == 8 and activeword8 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(171, 242, lyrics8[8])
end
if line == 8 and activeword9 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(183, 242, lyrics8[9])
end
if line == 8 and activeword10 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(195, 242, lyrics8[10])
end
if line == 8 and activeword11 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(212, 242, lyrics8[11])
end
if line == 8 and activeword12 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(224, 242, lyrics8[12])
end
if line == 8 and activeword13 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(236, 242, lyrics8[13])
end
if line == 8 and activeword14 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(259, 242, lyrics8[14])
end
if line == 8 and activeword15 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(269, 242, lyrics8[15])
end
if line == 8 and activeword16 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(281, 242, lyrics8[16])
end
if line == 8 and activeword17 == 8 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(291, 242, lyrics8[17])
end


if line == 9 and currentTime >= 43780 and currentTime < 44020 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(84, 242, lyrics9[1])
elseif line == 9 and currentTime >= 44040 and currentTime < 44240 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(90, 242, lyrics9[2])
elseif line == 9 and currentTime >= 44260 and currentTime < 44580 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(106.4, 242, lyrics9[3])
elseif line == 9 and currentTime >= 44600 and currentTime < 44780 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(122, 242, lyrics9[4])
elseif line == 9 and currentTime >= 44800 and currentTime < 45080 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(135, 242, lyrics9[5])
elseif line == 9 and currentTime >= 45100 and currentTime < 45480 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(150, 242, lyrics9[6])
elseif line == 9 and currentTime >= 45480 and currentTime < 45700 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(167, 242, lyrics9[7])
elseif line == 9 and currentTime >= 45720 and currentTime < 46560 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(178, 242, lyrics9[8])
elseif line == 9 and currentTime >= 46580 and currentTime < 46760 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(194, 242, lyrics9[9])
elseif line == 9 and currentTime >= 46780 and currentTime < 46960 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(207, 242, lyrics9[10])
elseif line == 9 and currentTime >= 46980 and currentTime < 47140 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(218, 242, lyrics9[11])
elseif line == 9 and currentTime >= 47160 and currentTime < 47360 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(223, 242, lyrics9[12])
elseif line == 9 and currentTime >= 47380 and currentTime < 47560 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(234, 242, lyrics9[13])
elseif line == 9 and currentTime >= 47580 and currentTime < 47940 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(246, 242, lyrics9[14])
elseif line == 9 and currentTime >= 47960 and currentTime < 48140 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(262, 242, lyrics9[15])
elseif line == 9 and currentTime >= 48160 and currentTime < 48460 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(274, 242, lyrics9[16])
elseif line == 9 and currentTime >= 48480 and currentTime < 48800 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(292, 242, lyrics9[17])
end
if line == 9 and activeword1 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(84, 242, lyrics9[1])
end
if line == 9 and activeword2 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(90, 242, lyrics9[2])
end
if line == 9 and activeword3 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(106.4, 242, lyrics9[3])
end
if line == 9 and activeword4 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(122, 242, lyrics9[4])
end
if line == 9 and activeword5 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(135, 242, lyrics9[5])
end
if line == 9 and activeword6 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(150, 242, lyrics9[6])
end
if line == 9 and activeword7 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(167, 242, lyrics9[7])
end
if line == 9 and activeword8 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(178, 242, lyrics9[8])
end
if line == 9 and activeword9 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(194, 242, lyrics9[9])
end
if line == 9 and activeword10 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(207, 242, lyrics9[10])
end
if line == 9 and activeword11 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(218, 242, lyrics9[11])
end
if line == 9 and activeword12 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(223, 242, lyrics9[12])
end
if line == 9 and activeword13 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(234, 242, lyrics9[13])
end
if line == 9 and activeword14 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(246, 242, lyrics9[14])
end
if line == 9 and activeword15 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(262, 242, lyrics9[15])
end
if line == 9 and activeword16 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(274, 242, lyrics9[16])
end
if line == 9 and activeword17 == 9 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(292, 242, lyrics9[17])
end


if line == 10 and currentTime >= 49140 and currentTime < 49260 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(156, 242, lyrics10[1])
elseif line == 10 and currentTime >= 49280 and currentTime < 49400  then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(162, 242, lyrics10[2])
elseif line == 10 and currentTime >= 49420 and currentTime < 49700 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(174, 242, lyrics10[3])
elseif line == 10 and currentTime >= 49720 and currentTime < 50000 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(190, 242, lyrics10[4])
elseif line == 10 and currentTime >= 50020 and currentTime < 50420 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(207, 242, lyrics10[5])
elseif line == 10 and currentTime >= 50440 and currentTime < 50660 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(225, 242, lyrics10[6])
elseif line == 10 and currentTime >= 50680 and currentTime < 50980 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(231, 242, lyrics10[7])
elseif line == 10 and currentTime >= 51000 and currentTime < 51300 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(247.8, 242, lyrics10[8])
elseif line == 10 and currentTime >= 51320 and currentTime < 51660 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(261, 242, lyrics10[9])
elseif line == 10 and currentTime >= 51680 and currentTime < 51980 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(273, 242, lyrics10[10])
end

if line == 10 and activeword1 == 10 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(156, 242, lyrics10[1])
end
if line == 10 and activeword2 == 10 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(162, 242, lyrics10[2])
end
if line == 10 and activeword3 == 10 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(174, 242, lyrics10[3])
end
if line == 10 and activeword4 == 10 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(190, 242, lyrics10[4])
end
if line == 10 and activeword5 == 10 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(207, 242, lyrics10[5])
end
if line == 10 and activeword6 == 10 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(225, 242, lyrics10[6])
end
if line == 10 and activeword7 == 10 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(231, 242, lyrics10[7])
end
if line == 10 and activeword8 == 10 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(247.8, 242, lyrics10[8])
end
if line == 10 and activeword10 == 10 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(261, 242, lyrics10[9])
end
if line == 10 and activeword11 == 10 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(273, 242, lyrics10[10])
end


if line == 11 and currentTime >= 52200 and currentTime < 52460 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(144, 242, lyrics11[1])
elseif line == 11 and currentTime >= 52480 and currentTime < 52740 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(162, 242, lyrics11[2])
elseif line == 11 and currentTime >= 52760 and currentTime < 53080 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(183, 242, lyrics11[3])
elseif line == 11 and currentTime >= 53100 and currentTime < 53330 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(200.4, 242, lyrics11[4])
elseif line == 11 and currentTime >= 53350 and currentTime < 53600 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(217, 242, lyrics11[5])
elseif line == 11 and currentTime >= 53620 and currentTime < 53860 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(234, 242, lyrics11[6])
elseif line == 11 and currentTime >= 53880 and currentTime < 54080 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(252, 242, lyrics11[7])
elseif line == 11 and currentTime >= 54100 and currentTime < 54400 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(269, 242, lyrics11[8])
end
if line == 11 and activeword1 == 11 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(144, 242, lyrics11[1])
end
if line == 11 and activeword2 == 11 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(162, 242, lyrics11[2])
end
if line == 11 and activeword3 == 11 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(183, 242, lyrics11[3])
end
if line == 11 and activeword4 == 11 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(200.4, 242, lyrics11[4])
end
if line == 11 and activeword5 == 11 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(217, 242, lyrics11[5])
end
if line == 11 and activeword6 == 11 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(234, 242, lyrics11[6])
end
if line == 11 and activeword7 == 11 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(252, 242, lyrics11[7])
end
if line == 11 and activeword8 == 11 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(269, 242, lyrics11[8])
end

if line == 12 and currentTime >= 54460 and currentTime < 54740 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(132.3, 242, lyrics12[1])
elseif line == 12 and currentTime >= 54760 and currentTime < 55190 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(143, 242, lyrics12[2])
elseif line == 12 and currentTime >= 55210 and currentTime < 55500 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(155, 242, lyrics12[3])
elseif line == 12 and currentTime >= 55520 and currentTime < 55780 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(167, 242, lyrics12[4])
elseif line == 12 and currentTime >= 55800 and currentTime < 57080 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(182, 242, lyrics12[5])
elseif line == 12 and currentTime >= 57300 and currentTime < 57500 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(199, 242, lyrics12[6])
elseif line == 12 and currentTime >= 57520 and currentTime < 57700 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(216, 242, lyrics12[7])
elseif line == 12 and currentTime >= 57720 and currentTime < 57880 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(227.4, 242, lyrics12[8])
elseif line == 12 and currentTime >= 57900 and currentTime < 58280 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(247, 242, lyrics12[9])
elseif line == 12 and currentTime >= 58300 and currentTime < 58560 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(263, 242, lyrics12[10])
elseif line == 12 and currentTime >= 58580 and currentTime < 59000 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(275, 242, lyrics12[11])
end
if line == 12 and activeword1 == 12 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(132.3, 242, lyrics12[1])
end
if line == 12 and activeword2 == 12 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(143, 242, lyrics12[2])
end
if line == 12 and activeword3 == 12 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(155, 242, lyrics12[3])
end
if line == 12 and activeword4 == 12 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(167, 242, lyrics12[4])
end
if line == 12 and activeword5 == 12 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(182, 242, lyrics12[5])
end
if line == 12 and activeword6 == 12 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(199, 242, lyrics12[6])
end
if line == 12 and activeword7 == 12 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(216, 242, lyrics12[7])
end
if line == 12 and activeword8 == 12 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(227.4, 242, lyrics12[8])
end
if line == 12 and activeword9 == 12 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(247, 242, lyrics12[9])
end
if line == 12 and activeword10 == 12 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(263, 242, lyrics12[10])
end
if line == 12 and activeword11 == 12 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(275, 242, lyrics12[11])
end

if line == 13 and currentTime >= 59480 and currentTime < 59900 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(119.8, 242, lyrics13[1])
elseif line == 13 and currentTime >= 59920 and currentTime < 60380 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(132, 242, lyrics13[2])
elseif line == 13 and currentTime >= 60400 and currentTime < 60760 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(148, 242, lyrics13[3])
elseif line == 13 and currentTime >= 60780 and currentTime < 60940 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(164, 242, lyrics13[4])
elseif line == 13 and currentTime >= 60960 and currentTime < 61360 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(176.4, 242, lyrics13[5])
elseif line == 13 and currentTime >= 61380 and currentTime < 61660 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(194.8, 242, lyrics13[6])
elseif line == 13 and currentTime >= 61680 and currentTime < 62100 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(207, 242, lyrics13[7])
elseif line == 13 and currentTime >= 62120 and currentTime < 62260 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(225, 242, lyrics13[8])
elseif line == 13 and currentTime >= 62280 and currentTime < 62420 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(238, 242, lyrics13[9])
elseif line == 13 and currentTime >= 62440 and currentTime < 62660 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(253, 242, lyrics13[10])
elseif line == 13 and currentTime >= 62680 and currentTime < 63000 then font:setStyle(0.5, green, transparent, IntraFont.CACHE_ALL);
font:print(265, 242, lyrics13[11])
end
if line == 13 and activeword1 == 13 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(119.8, 242, lyrics13[1])
end
if line == 13 and activeword2 == 13 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(132, 242, lyrics13[2])
end
if line == 13 and activeword3 == 13 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(148, 242, lyrics13[3])
end
if line == 13 and activeword4 == 13 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(164, 242, lyrics13[4])
end
if line == 13 and activeword5 == 13 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(176.4, 242, lyrics13[5])
end
if line == 13 and activeword6 == 13 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(194.8, 242, lyrics13[6])
end
if line == 13 and activeword7 == 13 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(207, 242, lyrics13[7])
end
if line == 13 and activeword8 == 13 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(225, 242, lyrics13[8])
end
if line == 13 and activeword9 == 13 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(238, 242, lyrics13[9])
end
if line == 13 and activeword10 == 13 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(253, 242, lyrics13[10])
end
if line == 13 and activeword11 == 13 then font:setStyle(0.5, pink, transparent, IntraFont.CACHE_ALL);
font:print(265, 242, lyrics13[11])
end





pad = Controls.read()	




if pad:square() and oldpad:square() ~= pad:square() and line == 1  and currentLetter7 <= 1 and currentTime >= 10700 and currentTime < 10880
then name = name .. lyrics[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 1
elseif line == 1 and currentLetter7 <= 1 and currentTime >= 10880 and currentTime < 10900
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:down() and oldpad:down() ~=pad:down() and line == 1 and currentLetter7 <= 2 and currentTime >= 10900 and currentTime < 11080
then name = name .. lyrics[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 1

elseif line == 1 and currentLetter7 <= 2 and currentTime >= 11080 and currentTime < 11100
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:square() and oldpad:square() ~= pad:square() and line == 1 and currentLetter7 <= 3 and currentTime >= 11100 and currentTime < 11280
then name = name .. lyrics[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 1
elseif line == 1 and currentLetter7 <= 3 and currentTime >= 11280 and currentTime < 11300
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 4

elseif pad:down() and oldpad:down() ~=pad:down() and line == 1 and currentLetter7 <= 4 and currentTime >= 11300 and currentTime < 11670
then name = name .. lyrics[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 1
elseif line == 1 and currentLetter7 <= 4 and currentTime >= 11670 and currentTime < 11970
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 1 and currentLetter7 <= 5 and currentTime >= 12100 and currentTime < 12360
then name = name .. lyrics[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 1
elseif line == 1 and currentLetter7 <= 5 and currentTime >= 12360 and currentTime < 12380
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:right() and oldpad:right() ~=pad:right() and line == 1 and currentLetter7 <= 6 and currentTime >= 12380 and currentTime < 12520
then name = name .. lyrics[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 1
elseif line == 1 and currentLetter7 <= 6 and currentTime >= 12520 and currentTime < 12540
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:left() and oldpad:left() ~=pad:left() and line == 1 and currentLetter7 <= 7 and currentTime >= 12540 and currentTime < 12680
then name = name .. lyrics[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 1
elseif line == 1 and currentLetter7 <= 7 and currentTime >= 12680 and currentTime < 12700
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 8

elseif pad:square() and oldpad:square() ~= pad:square() and line == 1 and currentLetter7 <= 8 and currentTime >= 12700 and currentTime < 13040
then name = name .. lyrics[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 1
elseif line == 1 and currentLetter7 <= 8 and currentTime >= 13040 and currentTime < 13060
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 9
--

elseif pad:right() and oldpad:right() ~=pad:right() and line == 1 and currentLetter7 <= 9 and currentTime >= 13060 and currentTime < 13200
then name = name .. lyrics[9]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 10
activeword9 = 1
elseif line == 1 and currentLetter7 <= 9 and currentTime >= 13200 and currentTime < 13220
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 10

elseif pad:up() and oldpad:up() ~=pad:up() and line == 1 and currentLetter7 <= 10 and currentTime >= 13220 and currentTime < 13500
then name = name .. lyrics[10]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 11
activeword10 = 1
elseif line == 1 and currentLetter7 <= 10 and currentTime >= 13500 and currentTime < 13520
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 11

elseif pad:left() and oldpad:left() ~=pad:left() and line == 1 and currentLetter7 <= 11 and currentTime >= 13520 and currentTime < 13740
then name = name .. lyrics[11]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 12
activeword11 = 1
elseif line == 1 and currentLetter7 <= 11 and currentTime >= 13740 and currentTime < 13760
then name = name .. " "
qcount = qcount + 1
currentLetter7 = 12

elseif pad:up() and oldpad:up() ~=pad:up() and line == 1 and currentLetter7 <= 12 and currentTime >= 13760 and currentTime < 14000
then name = name .. lyrics[12]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 13
activeword12 = 1
elseif line == 1 and currentLetter7 <= 12 and currentTime >= 14000 and currentTime < 14020
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 13

elseif pad:l() and oldpad:l() ~=pad:l() and line == 1 and currentLetter7 <= 13 and currentTime >= 14020 and currentTime < 14480
then name = name .. lyrics[13]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 14
activeword13 = 1
elseif line == 1 and currentLetter7 <= 13 and currentTime >= 14480 and currentTime < 14500
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 14


elseif pad:right() and oldpad:right() ~=pad:right() and line == 1 and currentLetter7 <= 14 and currentTime >= 14500 and currentTime < 14670
then name = name .. lyrics[14]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 15
activeword14 = 1
elseif line == 1 and currentLetter7 <= 14 and currentTime >= 14670 and currentTime < 14690
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 15

elseif pad:up() and oldpad:up() ~=pad:up() and line == 1 and currentLetter7 <= 15 and currentTime >= 14700 and currentTime < 14940
then name = name .. lyrics[15]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 16
activeword15 = 1
elseif line == 1 and currentLetter7 <= 15 and currentTime >= 14940 and currentTime < 14960
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 16

elseif pad:left() and oldpad:left() ~=pad:left() and line == 1 and currentLetter7 <= 16 and currentTime >= 14960 and currentTime < 15130
then name = name .. lyrics[16]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 17
activeword16 = 1
elseif line == 1 and currentLetter7 <= 16 and currentTime >= 15130 and currentTime < 15150
then name = name .. " "
qcount = qcount + 1
currentLetter7 = 17

elseif pad:up() and oldpad:up() ~=pad:up() and line == 1 and currentLetter7 <= 17 and currentTime >= 15150 and currentTime < 15460
then name = name .. lyrics[17]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 18
activeword17 = 1
elseif line == 1 and currentLetter7 <= 17 and currentTime >= 15460 and currentTime < 15480
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 18

elseif pad:down() and oldpad:down() ~=pad:down() and line == 1 and currentLetter7 <= 18 and currentTime >= 15480 and currentTime < 15650
then name = name .. lyrics[18]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 19
activeword18 = 1
elseif line == 1 and currentLetter7 <= 18 and currentTime >= 15650 and currentTime < 15670
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 19

elseif pad:right() and oldpad:right() ~=pad:right() and line == 1 and currentLetter7 <= 19 and currentTime >= 15670 and currentTime < 15820
then name = name .. lyrics[19]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 20
activeword19 = 1
elseif line == 1 and currentLetter7 <= 19 and currentTime >= 15820 and currentTime < 15840
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 20

elseif pad:circle() and oldpad:circle() ~=pad:circle() and line == 1 and currentLetter7 <= 20 and currentTime >= 15840 and currentTime < 16000
then name = name .. lyrics[20]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 21
activeword20 = 1
elseif line == 1 and currentLetter7 <= 20 and currentTime >= 16200 and currentTime < 16220
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 21

---
elseif line == 1 and currentLetter7 <= 21 and currentTime >= 16220 and currentTime < 16240
then name = ""
line = 2
currentLetter7 = 1
for a = 1, 20 do
bclear[a].complete = 0
qcount = 1
end
		
---



elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 2 and currentLetter7 <= 1 and currentTime >= 16240 and currentTime < 16560 
then name = name .. lyrics2[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 2
elseif line == 2 and currentLetter7 <= 1 and currentTime >= 16560 and currentTime < 16580
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:square() and oldpad:square() ~= pad:square() and line == 2  and currentLetter7 <= 2 and currentTime >= 16610 and currentTime < 16880
then name = name .. lyrics2[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 2
elseif line == 2 and currentLetter7 <= 2 and currentTime >= 16880 and currentTime < 16900
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:right() and oldpad:right() ~=pad:right() and line == 2 and currentLetter7 <= 3 and currentTime >= 16900 and currentTime < 17260
then name = name .. lyrics2[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 2
elseif line == 2 and currentLetter7 <= 3 and currentTime >= 17260 and currentTime < 17280
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 4

elseif pad:right() and oldpad:right() ~=pad:right() and line == 2 and currentLetter7 <= 4 and currentTime >= 17280 and currentTime < 17580
then name = name .. lyrics2[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 2
elseif line == 2 and currentLetter7 <= 4 and currentTime >= 17580 and currentTime < 17600
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:up() and oldpad:up() ~=pad:up() and line == 2 and currentLetter7 <= 5 and currentTime >= 17600 and currentTime < 17860
then name = name .. lyrics2[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 2
elseif line == 2 and currentLetter7 <= 5 and currentTime >= 17860 and currentTime < 17880
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 2 and currentLetter7 <= 6 and currentTime >= 17880 and currentTime < 18000
then name = name .. lyrics2[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 2
elseif line == 2 and currentLetter7 <= 6 and currentTime >= 18114 and currentTime < 18134
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:right() and oldpad:right() ~=pad:right() and line == 2 and currentLetter7 <= 7 and currentTime >= 18134 and currentTime < 18290
then name = name .. lyrics2[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 2
elseif line == 2 and currentLetter7 <= 7 and currentTime >= 18290 and currentTime < 18310
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 8

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 2 and currentLetter7 <= 8 and currentTime >= 18310 and currentTime < 18600
then name = name .. lyrics2[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 2
elseif line == 2 and currentLetter7 <= 8 and currentTime >= 18600 and currentTime < 18620
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 9

elseif pad:left() and oldpad:left() ~=pad:left() and line == 2 and currentLetter7 <= 9 and currentTime >= 18620 and currentTime < 18810
then name = name .. lyrics2[9]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 10
activeword9 = 2
elseif line == 2 and currentLetter7 <= 9 and currentTime >= 18810 and currentTime < 18830
then name = name .. " "
qcount = qcount + 1
currentLetter7 = 10

elseif pad:up() and oldpad:up() ~=pad:up() and line == 2 and currentLetter7 <= 10 and currentTime >= 18830 and currentTime < 19130
then name = name .. lyrics2[10]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 11
activeword10 = 2
elseif line == 2 and currentLetter7 <= 10 and currentTime >= 19130 and currentTime < 19150
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 11

elseif pad:circle() and oldpad:circle() ~=pad:circle() and line == 2 and currentLetter7 <= 11 and currentTime >= 19150 and currentTime < 19380
then name = name .. lyrics2[11]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 12
activeword11 = 2
elseif line == 2 and currentLetter7 <= 11 and currentTime >= 19380 and currentTime < 19400
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 12

elseif pad:square() and oldpad:square() ~= pad:square() and line == 2 and currentLetter7 <= 12 and currentTime >= 19400 and currentTime < 19700
then name = name .. lyrics2[12]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 13
activeword12 = 2
elseif line == 2 and currentLetter7 <= 12 and currentTime >= 19700 and currentTime < 20080
then 
qcount = qcount + 1
currentLetter7 = 13



---
elseif line == 2 and currentLetter7 <= 13 and currentTime >= 20000 and currentTime < 20080
then name = ""
line = 3
currentLetter7 = 1
for a = 1, 21 do
bclear[a].complete = 0
qcount = 1
end
		
---

elseif pad:down() and oldpad:down() ~=pad:down() and line == 3 and currentLetter7 <= 1 and currentTime >= 20080 and currentTime < 20200
then name = name .. lyrics3[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 3
elseif line == 3 and currentLetter7 <= 1 and currentTime >= 20200 and currentTime < 20220
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:up() and oldpad:up() ~=pad:up() and line == 3 and currentLetter7 <= 2 and currentTime >= 20220 and currentTime < 20420
then name = name .. lyrics3[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 3
elseif line == 3 and currentLetter7 <= 2 and currentTime >= 20420 and currentTime < 20440
then name = name .. "    "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:square() and oldpad:square() ~= pad:square() and line == 3 and currentLetter7 <= 3 and currentTime >= 20440 and currentTime < 20660
then name = name .. lyrics3[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 3
elseif line == 3 and currentLetter7 <= 3 and currentTime >= 20660 and currentTime < 20680
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 4

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 3 and currentLetter7 <= 4 and currentTime >= 20680 and currentTime < 20860
then name = name .. lyrics3[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 3
elseif line == 3 and currentLetter7 <= 4 and currentTime >= 20860 and currentTime < 20880
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:right() and oldpad:right() ~=pad:right() and line == 3 and currentLetter7 <= 5 and currentTime >= 20880 and currentTime < 21180
then name = name .. lyrics3[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 3
elseif line == 3 and currentLetter7 <= 5 and currentTime >= 21180 and currentTime < 21200
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 3 and currentLetter7 <= 6 and currentTime >= 21200 and currentTime < 21320
then name = name .. lyrics3[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 3
elseif line == 3 and currentLetter7 <= 6 and currentTime >= 21320 and currentTime < 21340
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:right() and oldpad:right() ~=pad:right() and line == 3 and currentLetter7 <= 7 and currentTime >= 21340 and currentTime < 21560
then name = name .. lyrics3[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 3
elseif line == 3 and currentLetter7 <= 7 and currentTime >= 21560 and currentTime < 21580
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 8

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 3 and currentLetter7 <= 8 and currentTime >= 21580 and currentTime < 22100
then name = name .. lyrics3[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 3
elseif line == 3 and currentLetter7 <= 8 and currentTime >= 22100 and currentTime < 22300
then 
qcount = qcount + 1
currentLetter7 = 9

---
elseif line == 3 and currentLetter7 <= 9 and currentTime >= 22300 and currentTime < 22360
then name = ""
line = 4
currentLetter7 = 1
currentLetter7 = 1
for a = 1, 21 do
bclear[a].complete = 0
qcount = 1
end
		
---


elseif pad:l() and oldpad:l() ~=pad:l() and line == 4 and currentLetter7 <= 1 and currentTime >= 22360 and currentTime < 22700
then name = name .. lyrics4[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 4
elseif line == 4 and currentLetter7 <= 1 and currentTime >= 22700 and currentTime < 22720
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 4 and currentLetter7 <= 2 and currentTime >= 22720 and currentTime < 22860
then name = name .. lyrics4[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 4
elseif line == 4 and currentLetter7 <= 2 and currentTime >= 22860 and currentTime < 22880
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:right() and oldpad:right() ~=pad:right() and line == 4 and currentLetter7 <= 3 and currentTime >= 22880 and currentTime < 23840
then name = name .. lyrics4[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 4
elseif line == 4 and currentLetter7 <= 3 and currentTime >= 23840 and currentTime < 23860
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 4

elseif pad:circle() and oldpad:circle() ~=pad:circle() and line == 4 and currentLetter7 <= 4 and currentTime >= 23860 and currentTime < 24160
then name = name .. lyrics4[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 4
elseif line == 4 and currentLetter7 <= 4 and currentTime >= 24160 and currentTime < 24180
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 4 and currentLetter7 <= 5 and currentTime >= 24180 and currentTime < 24310
then name = name .. lyrics4[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 4
elseif line == 4 and currentLetter7 <= 5 and currentTime >= 24310 and currentTime < 24330
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:square() and oldpad:square() ~= pad:square() and line == 4 and currentLetter7 <= 6 and currentTime >= 24330 and currentTime < 24860
then name = name .. lyrics4[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 4
elseif line == 4 and currentLetter7 <= 6 and currentTime >= 24860 and currentTime < 24880
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:up() and oldpad:up() ~=pad:up() and line == 4 and currentLetter7 <= 7 and currentTime >= 24880 and currentTime < 25010
then name = name .. lyrics4[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 4
elseif line == 4 and currentLetter7 <= 7 and currentTime >= 25010 and currentTime < 25030
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 8

elseif pad:square() and oldpad:square() ~= pad:square() and line == 4 and currentLetter7 <= 8 and currentTime >= 25030 and currentTime < 25400
then name = name .. lyrics4[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 4
elseif line == 4 and currentLetter7 <= 8 and currentTime >= 25400 and currentTime < 25420
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 9

elseif pad:left() and oldpad:left() ~=pad:left() and line == 4 and currentLetter7 <= 9 and currentTime >= 25420 and currentTime < 25600
then name = name .. lyrics4[9]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 10
activeword9 = 4
elseif line == 4 and currentLetter7 <= 9 and currentTime >= 25600 and currentTime < 25620
then name = name .. " "
qcount = qcount + 1
currentLetter7 = 10

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 4 and currentLetter7 <= 10 and currentTime >= 25620 and currentTime < 25800
then name = name .. lyrics4[10]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 11
activeword10 = 4
elseif line == 4 and currentLetter7 <= 10 and currentTime >= 25800 and currentTime < 25820
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 11

elseif pad:left() and oldpad:left() ~=pad:left() and line == 4 and currentLetter7 <= 11 and currentTime >= 25820 and currentTime < 26160
then name = name .. lyrics4[11]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 12
activeword11 = 4
elseif line == 4 and currentLetter7 <= 11 and currentTime >= 26160 and currentTime < 26180
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 12

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 4 and currentLetter7 <= 12 and currentTime >= 26180 and currentTime < 26600
then name = name .. lyrics4[12]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 13
activeword12 = 4
elseif line == 4 and currentLetter7 <= 12 and currentTime >= 26600 and currentTime < 26700
then
qcount = qcount + 1
currentLetter7 = 13

---
elseif line == 4 and currentLetter7 <= 13 and currentTime >= 26700 and currentTime < 26780
then name = ""
line = 5
currentLetter7 = 1
for a = 1, 21 do
bclear[a].complete = 0
qcount = 1
end
---


elseif pad:square() and oldpad:square() ~= pad:square() and line == 5 and currentLetter7 <= 1 and currentTime >= 26780 and currentTime < 26920
then name = name .. lyrics5[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 5
elseif line == 5 and currentLetter7 <= 1 and currentTime >= 26940 and currentTime < 26960
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:square() and oldpad:square() ~= pad:square() and line == 5 and currentLetter7 <= 2 and currentTime >= 26960 and currentTime < 27140
then name = name .. lyrics5[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 5
elseif line == 5 and currentLetter7 <= 2 and currentTime >= 27140 and currentTime < 27160
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 5 and currentLetter7 <= 3 and currentTime >= 27160 and currentTime < 27290
then name = name .. lyrics5[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 5
elseif line == 5 and currentLetter7 <= 3 and currentTime >= 27290 and currentTime < 27310
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 4

elseif pad:up() and oldpad:up() ~=pad:up() and line == 5 and currentLetter7 <= 4 and currentTime >= 27310 and currentTime < 27460
then name = name .. lyrics5[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 5
elseif line == 5 and currentLetter7 <= 4 and currentTime >= 27460 and currentTime < 27480
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 5 and currentLetter7 <= 5 and currentTime >= 27480 and currentTime < 27650
then name = name .. lyrics5[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 5
elseif line == 5 and currentLetter7 <= 5 and currentTime >= 27650 and currentTime < 27670
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:l() and oldpad:l() ~=pad:l() and line == 5 and currentLetter7 <= 6 and currentTime >= 27670 and currentTime < 27960
then name = name .. lyrics5[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 5
elseif line == 5 and currentLetter7 <= 6 and currentTime >= 27960 and currentTime < 27980
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 5 and currentLetter7 <= 7 and currentTime >= 27980 and currentTime < 28100
then name = name .. lyrics5[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 5
elseif line == 5 and currentLetter7 <= 7 and currentTime >= 28100 and currentTime < 28120
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 8

elseif pad:up() and oldpad:up() ~=pad:up() and line == 5 and currentLetter7 <= 8 and currentTime >= 28120 and currentTime < 28270
then name = name .. lyrics5[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 5
elseif line == 5 and currentLetter7 <= 8 and currentTime >= 28270 and currentTime < 28290
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 9

elseif pad:up() and oldpad:up() ~=pad:up() and line == 5 and currentLetter7 <= 9 and currentTime >= 28390 and currentTime < 28780
then name = name .. lyrics5[9]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 10
activeword9 = 5
elseif line == 5 and currentLetter7 <= 9 and currentTime >= 28780 and currentTime < 28800
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 10

elseif pad:right() and oldpad:right() ~=pad:right() and line == 5 and currentLetter7 <= 10 and currentTime >= 28800 and currentTime < 29000
then name = name .. lyrics5[10]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 11
activeword10 = 5
elseif line == 5 and currentLetter7 <= 10 and currentTime >= 29000 and currentTime < 29020
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 11

elseif pad:down() and oldpad:down() ~=pad:down() and line == 5 and currentLetter7 <= 11 and currentTime >= 29020 and currentTime < 29380
then name = name .. lyrics5[11]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 12
activeword11 = 5
elseif line == 5 and currentLetter7 <= 11 and currentTime >= 29380 and currentTime < 29400
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 12

elseif pad:down() and oldpad:down() ~=pad:down() and line == 5 and currentLetter7 <= 12 and currentTime >= 29400 and currentTime < 29920
then name = name .. lyrics5[12]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 13
activeword12 = 5
elseif line == 5 and currentLetter7 <= 12 and currentTime >= 29920 and currentTime < 29940
then name = name .. "    "
qcount = qcount + 1
currentLetter7 = 13

elseif pad:right() and oldpad:right() ~=pad:right() and line == 5 and currentLetter7 <= 13 and currentTime >= 29940 and currentTime < 31080
then name = name .. lyrics5[13]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 14
activeword13 = 5
elseif line == 5 and currentLetter7 <= 13 and currentTime >= 31080 and currentTime < 31100
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 14


elseif pad:left() and oldpad:left() ~=pad:left() and line == 5 and currentLetter7 <= 14 and currentTime >= 31100 and currentTime < 31290
then name = name .. lyrics5[14]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 15
activeword14 = 5
elseif line == 5 and currentLetter7 <= 14 and currentTime >= 31290 and currentTime < 31310
then name = name .. " "
qcount = qcount + 1
currentLetter7 = 15

elseif pad:down() and oldpad:down() ~=pad:down() and line == 5 and currentLetter7 <= 15 and currentTime >= 31310 and currentTime < 31780
then name = name .. lyrics5[15]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 16
activeword15 = 5
elseif line == 5 and currentLetter7 <= 15 and currentTime >= 31780 and currentTime < 31800
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 16

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 5 and currentLetter7 <= 16 and currentTime >= 31800 and currentTime < 32040
then name = name .. lyrics5[16]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 17
activeword16 = 5
elseif line == 5 and currentLetter7 <= 16 and currentTime >= 32040 and currentTime < 32060
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 17


elseif pad:left() and oldpad:left() ~=pad:left() and line == 5 and currentLetter7 <= 17 and currentTime >= 32060 and currentTime < 32580
then name = name .. lyrics5[17]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 18
activeword17 = 5
elseif line == 5 and currentLetter7 <= 17 and currentTime >= 32580 and currentTime < 32680
then
qcount = qcount + 1
currentLetter7 = 18

---
elseif line == 5 and currentLetter7 <= 18 and currentTime >= 32680 and currentTime < 32700
then name = ""
line = 6
currentLetter7 = 1
for a = 1, 21 do
bclear[a].complete = 0
qcount = 1
end

		
---

elseif pad:left() and oldpad:left() ~=pad:left() and line == 6 and currentLetter7 <= 1 and currentTime >= 32700 and currentTime < 32860
then name = name .. lyrics6[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 6
elseif line == 6 and currentLetter7 <= 1 and currentTime >= 32860 and currentTime < 32880
then name = name .. " "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:circle() and oldpad:circle() ~=pad:circle() and line == 6 and currentLetter7 <= 2 and currentTime >= 32880 and currentTime < 33200
then name = name .. lyrics6[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 6
elseif line == 6 and currentLetter7 <= 2 and currentTime >= 33200 and currentTime < 33220
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 6 and currentLetter7 <= 3 and currentTime >= 33220 and currentTime < 33400
then name = name .. lyrics6[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 6
elseif line == 6 and currentLetter7 <= 3 and currentTime >= 33400 and currentTime < 33420
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 4

elseif pad:circle() and oldpad:circle() ~=pad:circle() and line == 6 and currentLetter7 <= 4 and currentTime >= 33420 and currentTime < 33600
then name = name .. lyrics6[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 6
elseif line == 6 and currentLetter7 <= 4 and currentTime >= 33600 and currentTime < 33620
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:right() and oldpad:right() ~=pad:right() and line == 6 and currentLetter7 <= 5 and currentTime >= 33620 and currentTime < 33890
then name = name .. lyrics6[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 6
elseif line == 6 and currentLetter7 <= 5 and currentTime >= 33890 and currentTime < 33910
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 6 and currentLetter7 <= 6 and currentTime >= 33910 and currentTime < 34300
then name = name .. lyrics6[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 6
elseif line == 6 and currentLetter7 <= 6 and currentTime >= 34300 and currentTime < 34320
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:square() and oldpad:square() ~= pad:square() and line == 6 and currentLetter7 <= 7 and currentTime >= 34320 and currentTime < 34480
then name = name .. lyrics6[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 6
elseif line == 6 and currentLetter7 <= 7 and currentTime >= 34480 and currentTime < 34500
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 8

elseif pad:up() and oldpad:up() ~=pad:up() and line == 6 and currentLetter7 <= 8 and currentTime >= 34500 and currentTime < 34650
then name = name .. lyrics6[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 6
elseif line == 6 and currentLetter7 <= 8 and currentTime >= 34650 and currentTime < 34670
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 9

elseif pad:right() and oldpad:right() ~=pad:right() and line == 6 and currentLetter7 <= 9 and currentTime >= 34670 and currentTime < 35320
then name = name .. lyrics6[9]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 10
activeword9 = 6
elseif line == 6 and currentLetter7 <= 9 and currentTime >= 35320 and currentTime < 35420
then
qcount = qcount + 1
currentLetter7 = 10

---
elseif line == 6 and currentLetter7 <= 10 and currentTime >= 35420 and currentTime < 35440
then name = ""
line = 7
currentLetter7 = 1
for a = 1, 21 do
bclear[a].complete = 0
qcount = 1
end
		
---

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 7 and currentLetter7 <= 1 and currentTime >= 35440 and currentTime < 35580
then name = name .. lyrics7[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 7
elseif line == 7 and currentLetter7 <= 1 and currentTime >= 35580 and currentTime < 35600
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 7 and currentLetter7 <= 2 and currentTime >= 35600 and currentTime < 35880
then name = name .. lyrics7[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 7
elseif line == 7 and currentLetter7 <= 2 and currentTime >= 35880 and currentTime < 35900
then name = name .. "    "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:left() and oldpad:left() ~=pad:left() and line == 7 and currentLetter7 <= 3 and currentTime >= 35900 and currentTime < 36160
then name = name .. lyrics7[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 7
elseif line == 7 and currentLetter7 <= 3 and currentTime >= 36160 and currentTime < 36180
then name = name .. " "
qcount = qcount + 1
currentLetter7 = 4

elseif pad:down() and oldpad:down() ~=pad:down() and line == 7 and currentLetter7 <= 4 and currentTime >= 36180 and currentTime < 36580
then name = name .. lyrics7[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 7
elseif line == 7 and currentLetter7 <= 4 and currentTime >= 36580 and currentTime < 36600
then name = name .. "    "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:square() and oldpad:square() ~= pad:square() and line == 7 and currentLetter7 <= 5 and currentTime >= 36600 and currentTime < 36740
then name = name .. lyrics7[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 7
elseif line == 7 and currentLetter7 <= 5 and currentTime >= 36740 and currentTime < 36760
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:l() and oldpad:l() ~=pad:l() and line == 7 and currentLetter7 <= 6 and currentTime >= 36760 and currentTime < 37020
then name = name .. lyrics7[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 7
elseif line == 7 and currentLetter7 <= 6 and currentTime >= 37020 and currentTime < 37040
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:up() and oldpad:up() ~=pad:up() and line == 7 and currentLetter7 <= 7 and currentTime >= 37040 and currentTime < 37160
then name = name .. lyrics7[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 7
elseif line == 7 and currentLetter7 <= 7 and currentTime >= 37160 and currentTime < 37180
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 8

elseif pad:left() and oldpad:left() ~=pad:left() and line == 7 and currentLetter7 <= 8 and currentTime >= 37180 and currentTime < 37340
then name = name .. lyrics7[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 7
elseif line == 7 and currentLetter7 <= 8 and currentTime >= 37340 and currentTime < 37360
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 9

elseif pad:up() and oldpad:up() ~=pad:up() and line == 7 and currentLetter7 <= 9 and currentTime >= 37360 and currentTime < 37800
then name = name .. lyrics7[9]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 10
activeword9 = 7
elseif line == 7 and currentLetter7 <= 9 and currentTime >= 37800 and currentTime < 37900
then
qcount = qcount + 1
currentLetter7 = 10

---
elseif line == 7 and currentLetter7 <= 10 and currentTime >= 37900 and currentTime < 38000
then name = ""
line = 8
currentLetter7 = 1
for a = 1, 21 do
bclear[a].complete = 0
qcount = 1
end
---

elseif pad:up() and oldpad:up() ~=pad:up() and line == 8 and currentLetter7 <= 1 and currentTime >= 38000 and currentTime < 38100
then name = name .. lyrics8[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 8
elseif line == 8 and currentLetter7 <= 1 and currentTime >= 38100 and currentTime < 38120
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:up() and oldpad:up() ~=pad:up() and line == 8 and currentLetter7 <= 2 and currentTime >= 38120 and currentTime < 38220
then name = name .. lyrics8[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 8
elseif line == 8 and currentLetter7 <= 2 and currentTime >= 38220 and currentTime < 38240
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:circle() and oldpad:circle() ~=pad:circle() and line == 8 and currentLetter7 <= 3 and currentTime >= 38240 and currentTime < 38500
then name = name .. lyrics8[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 8
elseif line == 8 and currentLetter7 <= 3 and currentTime >= 38500 and currentTime < 38520
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 4

elseif pad:square() and oldpad:square() ~= pad:square() and line == 8 and currentLetter7 <= 4 and currentTime >= 38520 and currentTime < 38800
then name = name .. lyrics8[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 8
elseif line == 8 and currentLetter7 <= 4 and currentTime >= 38800 and currentTime < 38820
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:up() and oldpad:up() ~=pad:up() and line == 8 and currentLetter7 <= 5 and currentTime >= 38820 and currentTime < 39240
then name = name .. lyrics8[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 8
elseif line == 8 and currentLetter7 <= 5 and currentTime >= 39240 and currentTime < 39260
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 8 and currentLetter7 <= 6 and currentTime >= 39260 and currentTime < 39500
then name = name .. lyrics8[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 8
elseif line == 8 and currentLetter7 <= 6 and currentTime >= 39500 and currentTime < 39520
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:circle() and oldpad:circle() ~=pad:circle() and line == 8 and currentLetter7 <= 7 and currentTime >= 39520 and currentTime < 39660
then name = name .. lyrics8[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 8
elseif line == 8 and currentLetter7 <= 7 and currentTime >= 39660 and currentTime < 39680
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 8

elseif pad:down() and oldpad:down() ~=pad:down() and line == 8 and currentLetter7 <= 8 and currentTime >= 39680 and currentTime < 39880
then name = name .. lyrics8[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 8
elseif line == 8 and currentLetter7 <= 8 and currentTime >= 39880 and currentTime < 39900
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 9

elseif pad:down() and oldpad:down() ~=pad:down() and line == 8 and currentLetter7 <= 9 and currentTime >= 39900 and currentTime < 40110
then name = name .. lyrics8[9]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 10
activeword9 = 8
elseif line == 8 and currentLetter7 <= 9 and currentTime >= 40110 and currentTime < 40130
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 10

elseif pad:up() and oldpad:up() ~=pad:up() and line == 8 and currentLetter7 <= 10 and currentTime >= 40130 and currentTime < 40660
then name = name .. lyrics8[10]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 11
activeword10 = 8
elseif line == 8 and currentLetter7 <= 10 and currentTime >= 40660 and currentTime < 40680
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 11

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 8 and currentLetter7 <= 11 and currentTime >= 40680 and currentTime < 40880
then name = name .. lyrics8[11]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 12
activeword11 = 8
elseif line == 8 and currentLetter7 <= 11 and currentTime >= 40880 and currentTime < 40900
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 12

elseif pad:up() and oldpad:up() ~=pad:up() and line == 8 and currentLetter7 <= 12 and currentTime >= 40900 and currentTime < 41080
then name = name .. lyrics8[12]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 13
activeword12 = 8
elseif line == 8 and currentLetter7 <= 12 and currentTime >= 41080 and currentTime < 41100
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 13

elseif pad:square() and oldpad:square() ~= pad:square() and line == 8 and currentLetter7 <= 13 and currentTime >= 41100 and currentTime < 41340
then name = name .. lyrics8[13]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 14
activeword13 = 8
elseif line == 8 and currentLetter7 <= 13 and currentTime >= 41340 and currentTime < 41360
then name = name .. "    "
qcount = qcount + 1
currentLetter7 = 14

elseif pad:down() and oldpad:down() ~=pad:down() and line == 8 and currentLetter7 <= 14 and currentTime >= 41360 and currentTime < 41520
then name = name .. lyrics8[14]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 15
activeword14 = 8
elseif line == 8 and currentLetter7 <= 14 and currentTime >= 41520 and currentTime < 41540
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 15

elseif pad:square() and oldpad:square() ~= pad:square() and line == 8 and currentLetter7 <= 15 and currentTime >= 41540 and currentTime < 41760
then name = name .. lyrics8[15]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 16
activeword15 = 8
elseif line == 8 and currentLetter7 <= 15 and currentTime >= 41760 and currentTime < 41780
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 16

elseif pad:left() and oldpad:left() ~=pad:left() and line == 8 and currentLetter7 <= 16 and currentTime >= 41780 and currentTime < 41980
then name = name .. lyrics8[16]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 17
activeword16 = 8
elseif line == 8 and currentLetter7 <= 16 and currentTime >= 41980 and currentTime < 42000
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 17

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 8 and currentLetter7 <= 17 and currentTime >= 42000 and currentTime < 42600
then name = name .. lyrics8[17]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 18
activeword17 = 8
elseif line == 8 and currentLetter7 <= 17 and currentTime >= 42600 and currentTime < 42900
then 
qcount = qcount + 1
currentLetter7 = 18

---
elseif line == 8 and currentLetter7 <= 18 and currentTime >= 42900 and currentTime < 43780
then name = ""
line = 9
currentLetter7 = 1
for a = 1, 21 do
bclear[a].complete = 0
qcount = 1
end	
---

elseif pad:left() and oldpad:left() ~=pad:left() and line == 9 and currentLetter7 <= 1 and currentTime >= 43780 and currentTime < 44020
then name = name .. lyrics9[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 9
elseif line == 9 and currentLetter7 <= 1 and currentTime >= 44020 and currentTime < 44040
then name = name .. " "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:down() and oldpad:down() ~=pad:down() and line == 9 and currentLetter7 <= 2 and currentTime >= 44040 and currentTime < 44240
then name = name .. lyrics9[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 9
elseif line == 9 and currentLetter7 <= 2 and currentTime >= 44240 and currentTime < 44260
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:right() and oldpad:right() ~=pad:right() and line == 9 and currentLetter7 <= 3 and currentTime >= 44260 and currentTime < 44580
then name = name .. lyrics9[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 9
elseif line == 9 and currentLetter7 <= 3 and currentTime >= 44580 and currentTime < 44600
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 4

currentLetter7 = 4
elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 9 and currentLetter7 <= 4 and currentTime >= 44600 and currentTime < 44780
then name = name .. lyrics9[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 9
elseif line == 9 and currentLetter7 <= 4 and currentTime >= 44780 and currentTime < 44800
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:right() and oldpad:right() ~=pad:right() and line == 9 and currentLetter7 <= 5 and currentTime >= 44800 and currentTime < 45080
then name = name .. lyrics9[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 9
elseif line == 9 and currentLetter7 <= 5 and currentTime >= 45080 and currentTime < 45100
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:left() and oldpad:left() ~=pad:left() and line == 9 and currentLetter7 <= 6 and currentTime >= 45100 and currentTime < 45480 
then name = name .. lyrics9[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 9
elseif line == 9 and currentLetter7 <= 6 and currentTime >= 45480 and currentTime < 45500
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:right() and oldpad:right() ~=pad:right() and line == 9 and currentLetter7 <= 7 and currentTime >= 45480 and currentTime < 45700
then name = name .. lyrics9[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 9
elseif line == 9 and currentLetter7 <= 7 and currentTime >= 45700 and currentTime < 45720
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 8


elseif pad:up() and oldpad:up() ~=pad:up() and line == 9 and currentLetter7 <= 8 and currentTime >= 45720 and currentTime < 46560
then name = name .. lyrics9[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 9
elseif line == 9 and currentLetter7 <= 8 and currentTime >= 46560 and currentTime < 46580
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 9

elseif pad:l() and oldpad:l() ~=pad:l() and line == 9 and currentLetter7 <= 9 and currentTime >= 46580 and currentTime < 46760
then name = name .. lyrics9[9]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 10
activeword9 = 9
elseif line == 9 and currentLetter7 <= 9 and currentTime >= 46760 and currentTime < 46780
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 10

elseif pad:circle() and oldpad:circle() ~=pad:circle() and line == 9 and currentLetter7 <= 10 and currentTime >= 46780 and currentTime < 46960
then name = name .. lyrics9[10]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 11
activeword10 = 9
elseif line == 9 and currentLetter7 <= 10 and currentTime >= 46960 and currentTime < 46980
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 11

elseif pad:left() and oldpad:left() ~=pad:left() and line == 9 and currentLetter7 <= 11 and currentTime >= 46980 and currentTime < 47140
then name = name .. lyrics9[11]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 12
activeword11 = 9
elseif line == 9 and currentLetter7 <= 11 and currentTime >= 47140 and currentTime < 47160
then name = name .. " "
qcount = qcount + 1
currentLetter7 = 12

elseif pad:square() and oldpad:square() ~= pad:square() and line == 9 and currentLetter7 <= 12 and currentTime >= 47160 and currentTime < 47360 
then name = name .. lyrics9[12]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 13
activeword12 = 9
elseif line == 9 and currentLetter7 <= 12 and currentTime >= 47360 and currentTime < 47380
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 13

elseif pad:up() and oldpad:up() ~=pad:up() and line == 9 and currentLetter7 <= 13 and currentTime >= 47380 and currentTime < 47560
then name = name .. lyrics9[13]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 14
activeword13 = 9
elseif line == 9 and currentLetter7 <= 13 and currentTime >= 47560 and currentTime < 47580
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 14

elseif pad:circle() and oldpad:circle() ~=pad:circle() and line == 9 and currentLetter7 <= 14 and currentTime >= 47580 and currentTime < 47940
then name = name .. lyrics9[14]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 15
activeword14 = 9
elseif line == 9 and currentLetter7 <= 14 and currentTime >= 47940 and currentTime < 47960
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 15

elseif pad:triangle() and oldpad:triangle() ~=pad:triangle() and line == 9 and currentLetter7 <= 15 and currentTime >= 47960 and currentTime < 48140
then name = name .. lyrics9[15]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 16
activeword15 = 9
elseif line == 9 and currentLetter7 <= 15 and currentTime >= 48140 and currentTime < 48160
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 16

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 9 and currentLetter7 <= 16 and currentTime >= 48160 and currentTime < 48460
then name = name .. lyrics9[16]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 17
activeword16 = 9
elseif line == 9 and currentLetter7 <= 16 and currentTime >= 48460 and currentTime < 48480
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 17

elseif pad:up() and oldpad:up() ~=pad:up() and line == 9 and currentLetter7 <= 17 and currentTime >= 48480 and currentTime < 48800
then name = name .. lyrics9[17]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 18
activeword17 = 9
elseif line == 9 and currentLetter7 <= 17 and currentTime >= 48800 and currentTime < 48900
then
qcount = qcount + 1
currentLetter7 = 18

---
elseif line == 9 and currentLetter7 <= 18 and currentTime >= 48900 and currentTime < 49140
then name = ""
line = 10
currentLetter7 = 1
for a = 1, 21 do
bclear[a].complete = 0
qcount = 1
end
---

elseif pad:left() and oldpad:left() ~=pad:left() and line == 10 and currentLetter7 <= 1 and currentTime >= 49140 and currentTime < 49260
then name = name .. lyrics10[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 10
elseif line == 10 and currentLetter7 <= 1 and currentTime >= 49260 and currentTime < 49280
then name = name .. " "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:circle() and oldpad:circle() ~=pad:circle() and line == 10 and currentLetter7 <= 2 and currentTime >= 49280 and currentTime < 49400 
then name = name .. lyrics10[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 10
elseif line == 10 and currentLetter7 <= 2 and currentTime >= 49400 and currentTime < 49420
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:down() and oldpad:down() ~=pad:down() and line == 10 and currentLetter7 <= 3 and currentTime >= 49420 and currentTime < 49700
then name = name .. lyrics10[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 10
elseif line == 10 and currentLetter7 <= 3 and currentTime >= 49700 and currentTime < 49720
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 4

elseif pad:down() and oldpad:down() ~=pad:down() and line == 10 and currentLetter7 <= 4 and currentTime >= 49720 and currentTime < 50000
then name = name .. lyrics10[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 10
elseif line == 10 and currentLetter7 <= 4 and currentTime >= 50000 and currentTime < 50020
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:l() and oldpad:l() ~=pad:l() and line == 10 and currentLetter7 <= 5 and currentTime >= 50020 and currentTime < 50420
then name = name .. lyrics10[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 10
elseif line == 10 and currentLetter7 <= 5 and currentTime >= 50420 and currentTime < 50440
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:left() and oldpad:left() ~=pad:left() and line == 10 and currentLetter7 <= 6 and currentTime >= 50440 and currentTime < 50660
then name = name .. lyrics10[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 10
elseif line == 10 and currentLetter7 <= 6 and currentTime >= 50660 and currentTime < 50680
then name = name .. " "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:right() and oldpad:right() ~=pad:right() and line == 10 and currentLetter7 <= 7 and currentTime >= 50680 and currentTime < 50980
then name = name .. lyrics10[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 10
elseif line == 10 and currentLetter7 <= 7 and currentTime >= 50980 and currentTime < 51000
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 8

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 10 and currentLetter7 <= 8 and currentTime >= 51000 and currentTime < 51300
then name = name .. lyrics10[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 10
elseif line == 10 and currentLetter7 <= 8 and currentTime >= 51300 and currentTime < 51320
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 9

elseif pad:l() and oldpad:l() ~=pad:l() and line == 10 and currentLetter7 <= 9 and currentTime >= 51320 and currentTime < 51660
then name = name .. lyrics10[9]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 10
activeword9 = 10
elseif line == 10 and currentLetter7 <= 9 and currentTime >= 51660 and currentTime < 51680
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 10

elseif pad:left() and oldpad:left() ~=pad:left() and line == 10 and currentLetter7 <= 10 and currentTime >= 51680 and currentTime < 51980
then name = name .. lyrics10[10]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 11
activeword10 = 10
elseif line == 10 and currentLetter7 <= 10 and currentTime >= 51980 and currentTime < 52150
then
qcount = qcount + 1
currentLetter7 = 11

---
elseif line == 10 and currentLetter7 <= 11 and currentTime >= 52150 and currentTime < 52200
then name = ""
line = 11
currentLetter7 = 1
for a = 1, 21 do
bclear[a].complete = 0
qcount = 1
end
---

elseif pad:up() and oldpad:up() ~=pad:up() and line == 11 and currentLetter7 <= 1 and currentTime >= 52200 and currentTime < 52460
then name = name .. lyrics11[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 11
elseif currentLetter7 <= 1 and currentTime >= 52460 and currentTime < 52480
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:right() and oldpad:right() ~=pad:right() and line == 11 and currentLetter7 <= 2 and currentTime >= 52480 and currentTime < 52740
then name = name .. lyrics11[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 11
elseif currentLetter7 <= 2 and currentTime >= 52740 and currentTime < 52760
then name = name .. "    "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:square() and oldpad:square() ~= pad:square() and line == 11 and currentLetter7 <= 3 and currentTime >= 52760 and currentTime < 53080
then name = name .. lyrics11[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 11
elseif currentLetter7 <= 3 and currentTime >= 53080 and currentTime < 53100
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 4

elseif pad:right() and oldpad:right() ~=pad:right() and line == 11 and currentLetter7 <= 4 and currentTime >= 53100 and currentTime < 53330
then name = name .. lyrics11[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 11
elseif currentLetter7 <= 4 and currentTime >= 53330 and currentTime < 53350
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:l() and oldpad:l() ~=pad:l() and line == 11 and currentLetter7 <= 5 and currentTime >= 53350 and currentTime < 53600
then name = name .. lyrics11[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 11
elseif currentLetter7 <= 5 and currentTime >= 53600 and currentTime < 53620
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:up() and oldpad:up() ~=pad:up() and line == 11 and currentLetter7 <= 6 and currentTime >= 53620 and currentTime < 53860
then name = name .. lyrics11[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 11
elseif currentLetter7 <= 6 and currentTime >= 53860 and currentTime < 53880
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:square() and oldpad:square() ~= pad:square() and line == 11 and currentLetter7 <= 7 and currentTime >= 53880 and currentTime < 54080
then name = name .. lyrics11[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 11
elseif currentLetter7 <= 7 and currentTime >= 54080 and currentTime < 54100
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 8

elseif pad:square() and oldpad:square() ~= pad:square() and line == 11 and currentLetter7 <= 8 and currentTime >= 54100 and currentTime < 54400
then name = name .. lyrics11[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 11
elseif line == 11 and currentLetter7 <= 8 and currentTime >= 54400 and currentTime < 54440
then 
qcount = qcount + 1
currentLetter7 = 9

---
elseif line == 11 and currentLetter7 <= 9 and currentTime >= 54440 and currentTime < 54460
then name = ""
line = 12
currentLetter7 = 1
for a = 1, 21 do
bclear[a].complete = 0
qcount = 1
end
		
---


elseif pad:left() and oldpad:left() ~=pad:left() and line == 12 and currentLetter7 <= 1 and currentTime >= 54460 and currentTime < 54740
then name = name .. lyrics12[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 12
elseif line == 12 and currentLetter7 <= 1 and currentTime >= 54740 and currentTime < 54760
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:up() and oldpad:up() ~=pad:up() and line == 12 and currentLetter7 <= 2 and currentTime >= 54760 and currentTime < 55190
then name = name .. lyrics12[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 12
elseif line == 12 and currentLetter7 <= 2 and currentTime >= 55190 and currentTime < 55210
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:up() and oldpad:up() ~=pad:up() and line == 12 and currentLetter7 <= 3 and currentTime >= 55210 and currentTime < 55500
then name = name .. lyrics12[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 12
elseif line == 12 and currentLetter7 <= 3 and currentTime >= 55500 and currentTime < 55520
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 4

elseif pad:right() and oldpad:right() ~=pad:right() and line == 12 and currentLetter7 <= 4 and currentTime >= 55520 and currentTime < 55780
then name = name .. lyrics12[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 12
elseif line == 12 and currentLetter7 <= 4 and currentTime >= 55780 and currentTime < 55800
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:square() and oldpad:square() ~= pad:square() and line == 12 and currentLetter7 <= 5 and currentTime >= 55800 and currentTime < 57080
then name = name .. lyrics12[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 12
elseif line == 12 and currentLetter7 <= 5 and currentTime >= 57080 and currentTime < 57300
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:right() and oldpad:right() ~=pad:right() and line == 12 and currentLetter7 <= 6 and currentTime >= 57300 and currentTime < 57500
then name = name .. lyrics12[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 12
elseif line == 12 and currentLetter7 <= 6 and currentTime >= 57500 and currentTime < 57520
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:up() and oldpad:up() ~=pad:up() and line == 12 and currentLetter7 <= 7 and currentTime >= 57520 and currentTime < 57700
then name = name .. lyrics12[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 12
elseif line == 12 and currentLetter7 <= 7 and currentTime >= 57700 and currentTime < 57720
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 8

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 12 and currentLetter7 <= 8 and currentTime >= 57720 and currentTime < 57880
then name = name .. lyrics12[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 12
elseif line == 12 and currentLetter7 <= 8 and currentTime >= 57880 and currentTime < 57900
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 9

elseif pad:right() and oldpad:right() ~=pad:right() and line == 12 and currentLetter7 <= 9 and currentTime >= 57900 and currentTime < 58280
then name = name .. lyrics12[9]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 10
activeword9 = 12
elseif line == 12 and currentLetter7 <= 9 and currentTime >= 58280 and currentTime < 58300
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 10

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 12 and currentLetter7 <= 10 and currentTime >= 58300 and currentTime < 58560
then name = name .. lyrics12[10]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 11
activeword10 = 12
elseif line == 12 and currentLetter7 <= 10 and currentTime >= 58560 and currentTime < 58580
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 11


elseif pad:right() and oldpad:right() ~=pad:right() and line == 12 and currentLetter7 <= 11 and currentTime >= 58580 and currentTime < 59000
then name = name .. lyrics12[11]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 12
activeword11 = 12
elseif line == 12 and currentLetter7 <= 11 and currentTime >= 59200 and currentTime < 59300
then 
qcount = qcount + 1
currentLetter7 = 12

---
elseif line == 12 and currentLetter7 <= 12 and currentTime >= 59300 and currentTime < 59480
then name = ""
line = 13
currentLetter7 = 1
for a = 1, 21 do
bclear[a].complete = 0
qcount = 1
end
---


elseif pad:left() and oldpad:left() ~=pad:left() and line == 13 and currentLetter7 <= 1 and currentTime >= 59480 and currentTime < 59900
then name = name .. lyrics13[1]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 2
activeword1 = 13
elseif line == 13 and currentLetter7<= 1 and currentTime >= 59900 and currentTime < 59920
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 2

elseif pad:up() and oldpad:up() ~=pad:up() and line == 13 and currentLetter7 <= 2 and currentTime >= 59920 and currentTime < 60380
then name = name .. lyrics13[2]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 3
activeword2 = 13
elseif line == 13 and currentLetter7<= 2 and currentTime >= 60380 and currentTime < 60400
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 3

elseif pad:square() and oldpad:square() ~= pad:square() and line == 13 and currentLetter7 <= 3 and currentTime >= 60400 and currentTime < 60760
then name = name .. lyrics13[3]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 4
activeword3 = 13
elseif line == 13 and currentLetter7<= 3 and currentTime >= 60760 and currentTime < 60780
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 4

elseif pad:l() and oldpad:l() ~=pad:l() and line == 13 and currentLetter7 <= 4 and currentTime >= 60780 and currentTime < 60940
then name = name .. lyrics13[4]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 5
activeword4 = 13
elseif line == 13 and currentLetter7<= 4 and currentTime >= 60940 and currentTime < 60960
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 5

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 13 and currentLetter7 <= 5 and currentTime >= 60960 and currentTime < 61360
then name = name .. lyrics13[5]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 6
activeword5 = 13
elseif line == 13 and currentLetter7<= 5 and currentTime >= 61360 and currentTime < 61380
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 6

elseif pad:l() and oldpad:l() ~=pad:l() and line == 13 and currentLetter7 <= 6 and currentTime >= 61380 and currentTime < 61660
then name = name .. lyrics13[6]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 7
activeword6 = 13
elseif line == 13 and currentLetter7<= 6 and currentTime >= 61660 and currentTime < 61680
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 7

elseif pad:cross() and oldpad:cross() ~=pad:cross() and line == 13 and currentLetter7 <= 7 and currentTime >= 61680 and currentTime < 62100
then name = name .. lyrics13[7]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 8
activeword7 = 13
elseif line == 13 and currentLetter7<= 7 and currentTime >= 62100 and currentTime < 62120
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 8

elseif pad:down() and oldpad:down() ~=pad:down() and line == 13 and currentLetter7 <= 8 and currentTime >= 62120 and currentTime < 62260
then name = name .. lyrics13[8]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 9
activeword8 = 13
elseif line == 13 and currentLetter7<= 8 and currentTime >= 62260 and currentTime < 62280
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 9

elseif pad:up() and oldpad:up() ~=pad:up() and line == 13 and currentLetter7 <= 9 and currentTime >= 62280 and currentTime < 62420
then name = name .. lyrics13[9]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 10
activeword9 = 13
elseif line == 13 and currentLetter7<= 9 and currentTime >= 62420 and currentTime < 62440
then name = name .. "   "
qcount = qcount + 1
currentLetter7 = 10

elseif pad:right() and oldpad:right() ~=pad:right() and line == 13 and currentLetter7 <= 10 and currentTime >= 62440 and currentTime < 62660
then name = name .. lyrics13[10]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 11
activeword10 = 13
elseif line == 13 and currentLetter7<= 10 and currentTime >= 62660 and currentTime < 62680
then name = name .. "  "
qcount = qcount + 1
currentLetter7 = 11

elseif pad:down() and oldpad:down() ~=pad:down() and line == 13 and currentLetter7 <= 11 and currentTime >= 62680 and currentTime < 63000
then name = name .. lyrics13[11]
bclear[qcount].complete = 1
qcount = qcount + 1
score = score + 1
currentLetter7 = 12
activeword11 = 13
elseif line == 13 and currentLetter7 <= 113 and currentTime >= 63000 and currentTime < 64000
then 
qcount = qcount + 1
currentLetter7 = 12


elseif line == 13 and currentLetter7 <= 113 and currentTime >= 64000
then 
font:setStyle(0.5, white, transparent, IntraFont.ALIGN_CENTER);
font:print(40, 35, "Score: "..round(score/161*100).."%")
end

--stop time?






if pad:select() and oldpad:select() ~= pad:select() then
	Ogg.stop(1)
    counter:stop()
end




font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(10, 10, "Select to Stop")

font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(10, 20, "R+Triangle = Menu")



if pad:r() and pad:triangle() ~= oldpad:triangle() 
then 
Ogg.stop(1)
    counter:stop()
	delaytrack = 0
karakeys:free()
backGround2:free()
haruhisprite:free()
break 
end


System.endDraw()
  screen.waitVblankStart()
  --System.showFPS()
  screen.flip() 
  oldpad = pad
end