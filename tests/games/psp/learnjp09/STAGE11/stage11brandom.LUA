stage11back = Image.load("stage11/background.png")
Mp3.load("stage11/sounds/001.mp3", 1)
devil = Image.load("stage11/akuma/001.png")
devil2 = Image.load("stage11/akuma/002.png")
devil3 = Image.load("stage11/akuma/003.png")
devil4 = Image.load("stage11/akuma/004.png")


grayscreen = Image.createEmpty(160, 91)
grayscreen:clear(rdemongray)



player2 = {}
player2.x = 2
player2.y = 42
player2.pad = "none"

goukirepeat = 0
loopCount = 0
loopCount2 = 0
akumacount = 0
sakurako = 0
rdemon = 0
sfx = 0
streak = { health = 0 }
question = { }
question[1] = { quest = "one", answer = "ichi" }
question[2] = { quest = "two", answer = "ni" }
question[3] = { quest = "three", answer = "san" }
question[4] = { quest = "boat", answer = "fune" }
question[5] = { quest = "airplane", answer = "hikouki" }
question[6] = { quest = "more", answer = "motto" }
question[7] = { quest = "hospital", answer = "byouin" }
question[8] = { quest = "library", answer = "toshokan" }
question[9] = { quest = "post office", answer = "yuubin kyoku" }
question[10] = { quest = "today is good weather, isn't it?", answer = "kyou wa ii tenki desu ne" }
question[11] = { quest = "magazine", answer = "zasshi" }
question[12] = { quest = "room", answer = "heya" }
question[13] = { quest = "today is bad weather, isn't it?", answer = "kyou wa warui tenki desu ne" }
question[14] = { quest = "rain", answer = "ame" }
question[15] = { quest = "snow", answer = "yuki" }
question[16] = { quest = "white", answer = "shiroi" }
question[17] = { quest = "black", answer = "kuroi" }
question[18] = { quest = "river", answer = "kawa" }
question[19] = { quest = "horse", answer = "uma" }
question[20] = { quest = "wind", answer = "kaze" }
question[21] = { quest = "Devil", answer = "akuma" }



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
qcount = 1
gomenwav = 1
pose = 0
victory = 0
rage = 0
rage2 = 0
demon = 0
demon2 = 0
demon3 = 0
victory2 = 0
spacebar = 0


math.randomseed(os.time()) -- prevents same random numbers each run
math.random(); math.random(); math.random()



--function printCentered(y,text,color)
--local length = string.len(text)
--local x = 240 - ((length*8)/2)
--screen:print(x,y,text,color)
--end



while true do
System.draw()
screen:clear()
   screen:blit(0, 0, stage11back) 

if mode2 == 1 then screen:blit(80, 120, dpad3, 0, 0, 0, 76, 78)
elseif mode2 >= 2 then screen:blit(80, 120, dpad3, 0, 76, 0, 76, 78)
end

if mode2 == 1 then screen:blit(20, 22, dpad3, 0, 101, 78, 95, 15)
elseif mode2 >= 2 then screen:blit(20, 22, dpad3, 0, 0, 78, 101, 18)
end

if mode2 == 1 then screen:blit(318, 115, dpad3, 0, 228, 0, 87, 87)
elseif mode2 >= 2 then screen:blit(318, 115, dpad3, 0, 315, 0, 87, 87)
end

if sakurako == 1 then
screen:blit(130, 220, devil, 0, 335, 0, 104, 48)
end


if pose ~= 21 and loopCount >= 0 and akumacount < 60 and loopCount < 4 then 
screen:blit(200, 161, sprite, 0, 0, 0, 80, 92)
elseif loopCount >= 4 and loopCount < 8 and akumacount < 60 and pose ~= 21 then 
screen:blit(200, 161, sprite, 0, 80, 0, 80, 92)
elseif loopCount >= 8 and loopCount < 12 and akumacount < 60 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 160, 0, 80, 92)
elseif loopCount >= 12 and loopCount < 16 and akumacount < 60 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 240, 0, 80, 92)
elseif loopCount >= 16 and loopCount < 20 and akumacount < 60 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 320, 0, 80, 92)
elseif loopCount >= 20 and loopCount < 24 and akumacount < 60 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 400, 0, 80, 92)
elseif loopCount >= 24 and loopCount < 28 and akumacount < 60 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 0, 92, 80, 92)
elseif loopCount >= 28 and loopCount < 32 and akumacount < 60 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 80, 92, 80, 92)
elseif loopCount >= 32 and loopCount < 36 and akumacount < 60 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 160, 92, 80, 92)
elseif loopCount >= 36 and loopCount < 40 and akumacount < 60 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 240, 92, 80, 92)
elseif loopCount >= 40 and loopCount < 44 and akumacount < 60 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 320, 92, 80, 92)
elseif loopCount >= 44 and loopCount < 48 and akumacount < 60 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 400, 0, 80, 92) end
if pose ~= 21 and loopCount + 1 >= 48 and akumacount < 60 then loopCount = 0 else loopCount = loopCount + 1 end


if pose == 21 and akumacount < 60 then loopCount2 = loopCount2 + 1
if loopCount2 >= 0 and loopCount2 < 10 and akumacount < 60 then 
screen:blit(201, 148, sprite, 0, 0, 184, 80, 100)
elseif loopCount2 >= 10 and loopCount2 < 20 and akumacount < 60 then
screen:blit(202, 149, sprite, 0, 80, 184, 80, 100)
elseif loopCount2 >= 20 and loopCount2 < 30 and akumacount < 60 then 
screen:blit(189, 150, sprite, 0, 160, 184, 80, 100)
elseif loopCount2 >= 30 and loopCount2 < 40 and akumacount < 60 then
screen:blit(184, 150, sprite, 0, 243, 184, 83, 100)
elseif loopCount2 >= 40 and loopCount2 < 50 and akumacount < 60 then
screen:blit(184, 150, sprite, 0, 326, 184, 83, 100)
elseif loopCount2 >= 50 and loopCount2 < 60 and akumacount < 60 then
screen:blit(184, 150, sprite, 0, 0, 286, 83, 100)
elseif loopCount2 >= 60 and loopCount2 < 70 and akumacount < 60 then 
screen:blit(186, 150, sprite, 0, 83, 286, 83, 100)
elseif loopCount2 >= 70 and loopCount2 < 80 and akumacount < 60 then
screen:blit(184, 150, sprite, 0, 243, 184, 83, 100)
 end


if loopCount2 >= 80 and akumacount < 60 then 
screen:blit(184, 150, sprite, 0, 243, 184, 83, 100)
loopCount2 = loopCount2 - 40
else loopCount2 = loopCount2 + 1 end
end

if victory == 1 then
Wav.play(false, 0)
rdemon = 1
end


if pose == 21 then victory = victory + 1
victory2 = 1
elseif victory == 3 then victory = victory - 1
end



if rdemon >= 1 then akumacount = akumacount + 1 
sfx = sfx + 1
end

if sfx == 1 then
Mp3.play(false, 1)
end

if rdemon >= 1 and akumacount < 20 then
screen:blit(player2.x, player2.y, stage11back, 0, 0, 272, 191, 185)
end




if akumacount >= 0 and akumacount < 2 then
player2.x = -150
end
if akumacount >= 2 and akumacount < 4 then
player2.x = -120
end
if akumacount >= 4 and akumacount < 6 then
player2.x = -90
end
if akumacount >= 8 and akumacount < 10 then
player2.x = -60
end
if akumacount >= 10 and akumacount < 12 then
player2.x = -30
end
if akumacount >= 14 and akumacount < 16 then
player2.x = 0
end
if akumacount >= 16 and akumacount < 18 then
player2.x = 10
end

if akumacount >= 18 and akumacount < 20 then
player2.x = 10
screen.waitVblankStart(30)
end


if akumacount >= 20 and akumacount < 22 then
screen:blit(460, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 22 and akumacount < 24 then
screen:blit(450, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 24 and akumacount < 26 then
screen:blit(440, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 26 and akumacount < 28 then
screen:blit(430, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 28 and akumacount < 30 then
screen:blit(420, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 30 and akumacount < 32 then
screen:blit(400, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 32 and akumacount < 34 then
screen:blit(390, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 34 and akumacount < 36 then
screen:blit(380, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 36 and akumacount < 38 then
screen:blit(370, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 38 and akumacount < 40 then
screen:blit(360, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 40 and akumacount < 42 then
screen:blit(350, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 42 and akumacount < 44 then
screen:blit(340, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 44 and akumacount < 46 then
screen:blit(330, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 46 and akumacount < 48 then
screen:blit(320, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 48 and akumacount < 50 then
screen:blit(310, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 50 and akumacount < 52 then
screen:blit(300, 158, devil, 0, 0, 0, 86, 96)
end

if akumacount >= 52 and akumacount < 54 then
screen:blit(282, 158, devil, 0, 86, 0, 86, 96)
end

if akumacount >= 54 and akumacount < 56 then
screen:blit(272, 158, devil, 0, 86, 0, 86, 96)
end

if akumacount >= 56 and akumacount < 58 then
screen:blit(267, 158, devil, 0, 86, 0, 86, 96)
end

if akumacount >= 58 and akumacount < 60 then
screen:blit(239, 162, devil, 0, 172, 0, 86, 96)
end

if akumacount >= 60 and akumacount < 100 then
screen:blit(192, 159, devil, 0, 258, 0, 77, 96)
screen:blit(239, 162, devil, 0, 172, 0, 86, 96)

end

if akumacount >= 100 and akumacount < 280 then
screen:blit(0, 0, grayscreen) 
screen:blit(160, 0, grayscreen) 
screen:blit(320, 0, grayscreen)

screen:blit(0, 91, grayscreen) 
screen:blit(160, 91, grayscreen) 
screen:blit(320, 91, grayscreen) 

screen:blit(0, 182, grayscreen) 
screen:blit(160, 182, grayscreen) 
screen:blit(320, 182, grayscreen) 

end

if akumacount >= 102 and akumacount < 104 then
screen:blit(199, 157, devil2, 0, 0, 82, 86, 46)
end

if akumacount == 104 then
screen:blit(208, 140, devil2, 0, 0, 0, 81, 82)
end

if akumacount == 105 then
screen:blit(203, 129, devil2, 0, 81, 0, 92, 146)
end

if akumacount == 106 then
screen:blit(200, 115, devil2, 0, 173, 0, 103, 146)
end

if akumacount == 107 then
screen:blit(197, 109, devil2, 0, 276, 0, 114, 146)
end

if akumacount == 108 then
screen:blit(191, 109, devil2, 0, 390, 0, 120, 146)
end

if akumacount == 109 then
screen:blit(186, 114, devil2, 0, 0, 146, 125, 146)
end

if akumacount == 110 then
screen:blit(187, 116, devil2, 0, 127, 141, 123, 151)
end

if akumacount == 111 then
screen:blit(156, 102, devil2, 0, 251, 135, 161, 165)
end

if akumacount == 112 then 
screen:blit(151, 97, devil2, 0, 0, 300, 166, 170)
end

if akumacount == 113 then
screen:blit(148, 82, devil2, 0, 166, 300, 153, 170)
end

if akumacount == 114 then
screen:blit(143, 78, devil2, 0, 319, 300, 157, 194)
end

if akumacount == 115 then
screen:blit(136, 86, devil3, 0, 0, 0, 196, 186)
end

if akumacount == 116 then
screen:blit(136, 86, devil3, 0, 196, 0, 197, 186)
end

if akumacount == 117 then
screen:blit(210, 179, devil3, 0, 0, 186, 125, 93)
end

if akumacount == 118 then
screen:blit(184, 158, devil3, 0, 125, 186, 142, 114)
end

if akumacount == 119 then
screen:blit(149, 102, devil3, 0, 267, 186, 158, 170)
end

if akumacount == 120 then
screen:blit(144, 97, devil3, 0, 0, 279, 163, 175)
end

if akumacount == 121 then
screen:blit(141, 86, devil3, 0, 163, 320, 153, 159)
end

if akumacount == 122 then
screen:blit(114, 86, devil, 0, 0, 96, 188, 176)
end

if akumacount == 123 then
screen:blit(106, 80, devil, 0, 188, 96, 201, 192)
end

if akumacount == 124 then
screen:blit(96, 74, devil, 0, 0, 288, 215, 198)
end

if akumacount == 125 then
screen:blit(96, 71, devil, 0, 215, 288, 200, 201)
end

if akumacount == 126 then
screen:blit(105, 70, devil4, 0, 0, 0, 196, 202)
end

if akumacount == 127 then
screen:blit(105, 71, devil4, 0, 196, 0, 196, 202)
end

if akumacount == 128 then
screen:blit(144, 111, devil4, 0, 0, 202, 137, 148)
end

if akumacount == 129 then
screen:blit(143, 110, devil4, 0, 137, 202, 145, 131)
end

if akumacount == 130 then
screen:blit(171, 117, devil4, 0, 282, 202, 118, 127)
end

if akumacount == 131 then
screen:blit(170, 129, devil4, 0, 0, 350, 125, 99)
end

if akumacount == 132 then
screen:blit(170, 115, devil4, 0, 125, 350, 133, 117)
end

if akumacount == 133 then
screen:blit(197, 109, devil2, 0, 276, 0, 114, 146)
end

if akumacount == 134 then
screen:blit(191, 109, devil2, 0, 390, 0, 120, 146)
end

if akumacount == 135 then
screen:blit(186, 114, devil2, 0, 0, 146, 125, 146)
end

if akumacount == 136 then
screen:blit(187, 116, devil2, 0, 127, 141, 123, 151)
end

if akumacount == 137 then
screen:blit(156, 102, devil2, 0, 251, 135, 161, 165)
end

if akumacount == 138 then
screen:blit(151, 97, devil2, 0, 0, 300, 166, 170)
end

if akumacount == 139 then
screen:blit(148, 82, devil2, 0, 166, 300, 153, 170)
end

if akumacount == 140 then
screen:blit(143, 78, devil2, 0, 319, 300, 157, 194)
end

if akumacount == 141 then
screen:blit(136, 86, devil3, 0, 0, 0, 196, 186)
end

if akumacount == 142 then
screen:blit(136, 86, devil3, 0, 196, 0, 197, 186)
end

if akumacount == 143 then
screen:blit(210, 179, devil3, 0, 0, 186, 125, 93)
end

if akumacount == 144 then
screen:blit(184, 158, devil3, 0, 125, 186, 142, 114)
end

if akumacount == 145 then
screen:blit(149, 102, devil3, 0, 267, 186, 158, 170)
end

if akumacount == 146 then
screen:blit(144, 97, devil3, 0, 0, 279, 163, 175)
end

if akumacount == 147 then
screen:blit(141, 86, devil3, 0, 163, 320, 153, 159)
end

if akumacount == 148 then
screen:blit(114, 86, devil, 0, 0, 96, 188, 176)
end

if akumacount == 149 then
screen:blit(106, 80, devil, 0, 188, 96, 201, 192)
end

if akumacount == 150 then
screen:blit(96, 74, devil, 0, 0, 288, 215, 198)
end

if akumacount == 151 then
screen:blit(96, 71, devil, 0, 215, 288, 200, 201)
end

if akumacount == 152 then
screen:blit(105, 70, devil4, 0, 0, 0, 196, 202)
end

if akumacount == 153 then
screen:blit(105, 71, devil4, 0, 196, 0, 196, 202)
end

if akumacount == 154 then
screen:blit(144, 111, devil4, 0, 0, 202, 137, 148)
end

if akumacount == 155 then
screen:blit(143, 110, devil4, 0, 137, 202, 145, 131)
end

if akumacount == 156 then
screen:blit(171, 117, devil4, 0, 282, 202, 118, 127)
end

if akumacount == 157 then
screen:blit(170, 129, devil4, 0, 0, 350, 125, 99)
end

if akumacount == 158 then
screen:blit(170, 115, devil4, 0, 125, 350, 133, 117)
end

if akumacount == 159 then
screen:blit(170, 111, devil4, 0, 258, 347, 136, 120)
end 

if akumacount >= 160 and akumacount < 280 then
screen:blit(140, 31, stage11back, 0, 191, 272, 234, 213)
sakurako = 1
end

if akumacount >= 160 and akumacount < 172  then
screen:blit(208, 162, devil4, 0, 400, 0, 61, 90)
end

if akumacount >= 162 and akumacount < 174 then 
screen:blit(208, 162, devil4, 0, 400, 90, 61, 90)
end

if akumacount >= 164 and akumacount < 176 then
screen:blit(208, 162, devil4, 0, 400, 180, 61, 90)
end

if akumacount >= 166 and akumacount < 178 then
screen:blit(208, 162, devil4, 0, 400, 270, 61, 90)
end

if akumacount >= 168 and akumacount < 180 then
screen:blit(208, 162, devil4, 0, 400, 360, 61, 90)
end

if akumacount >= 170 and akumacount < 182 then
screen:blit(208, 162, devil3, 0, 425, 0, 61, 90)
end

if akumacount >= 172  and akumacount < 280 then
screen:blit(208, 162, devil3, 0, 425, 90, 61, 90)
end

if akumacount >= 280 then
screen:blit(208, 162, devil3, 0, 425, 90, 61, 90)
end


if akumacount >= 280 then akumacount = 296 end

--if menuprompt == 0 then
font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(10, 260, "R+Triangle = Menu")
--end

if randomnum == 1 and question[RanNumber].complete == 1 then
RanNumber = math.random(#question)
end


	pad = Controls.read()		

if pad:square() and oldpad:square() ~=pad:square() and victory2 == 1 then
demon2 = demon2 + 1
end


if demon2 == 1 then demon3 = 1
end

if demon3 == 1 then rage2 = rage2 + 1
victory2 = victory2 + 1
end

if rage2 >= 1 and rage2 < 11 and demon3 == 1 then

lp = 1
elseif rage2 >= 70 and rage2 < 100 then
demon = 0
demon2 = 0
demon3 = 0
rage = 0
rage2 = 0
victory2 = 0
lp = 0
lp2 = 0
foward = 0
lk = 0
hp = 0
end


if pad:square() and oldpad:square() ~=pad:square() and lp == 1 and rage2 >=11 and rage2 < 20
then
lp2 = 1
end



if pad:right() and oldpad:right() ~=pad:right() and lp == 1 and lp2 == 1 and rage2 >=20 and rage2 < 33
then
foward = 1
end



if pad:cross() and oldpad:cross() ~=pad:cross() and lp == 1 and lp2 == 1 and foward == 1 and rage2 >= 33 and rage2 < 40
then
lk = 1
end


if pad:r() and oldpad:r() ~=pad:r() and lp == 1 and lp2 == 1 and foward == 1 and lk == 1 and rage2 >= 40 and rage2 < 55
then
hp = 1
end


if lp == 1 and lp2 == 1 and foward == 1 and lk == 1 and hp == 1 then
rdemon = rdemon + 1
name = ""
end








if pad:analogX() > 120 and oldpad:analogX() ~=pad:analogX() and pad:analogX() ~=pad:analogY() and mode2 == 1 and spacebar < 1
then name = name .. space[2]
spacebar = spacebar + 1
currentLetter = 1
currentLetter2 = 1
currentLetter3 = 1
currentLetter4 = 1
currentLetter5 = 1
currentLetter6 = 1
currentLetter7 = 1
currentLetter8 = 1
currentLetter9 = 1
end

if spacebar >= 1 then spacebar = spacebar + 1
end

if spacebar == 9 then spacebar = 0
end





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

if pad:l() and oldpad:l() ~=pad:l() and mode2 <= 1
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

if pad:r() and pad:circle() ~= oldpad:circle() and pad:r() ~= oldpad:circle() then 
if answer == 1 then answer = 0
else answer = 1
streak.health = 0
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
qcount = 1
for a = 1, 21 do
question[a].complete = 0
end
end
end

if pad:r() and pad:triangle() ~= oldpad:triangle() 
then
Mp3.unload(1)
stage11back:free()
devil:free()
devil2:free()
devil3:free()
devil4:free()
grayscreen:free()
	collectgarbage("collect")
	collectgarbage("stop")
	menuprompt = 1
break 
end



font:setStyle(0.5, pink2, nil_color, IntraFont.ALIGN_LEFT)
font:print(370, 24, "Streak: " .. streak.health)

font:setStyle(0.5, green, nil_color, IntraFont.ALIGN_LEFT)
font:print(370, 36, "R+O = Answer")

font:setStyle(0.5, silver, nil_color, IntraFont.ALIGN_CENTER);
font:print(240, 30, "LEARN JAPANESE")

font:setStyle(0.5, orange, nil_color, IntraFont.ALIGN_CENTER);
font:print(240, 40, "by ponlork")

font:setStyle(0.5, white, nil_color, IntraFont.ALIGN_CENTER);
font:print(240, 80, question[RanNumber].quest)

font:setStyle(0.5, orange, nil_color, IntraFont.ALIGN_CENTER);
font:print(240, 106, ""..name);

dofile("Cheatjprandom.LUA")








if answer == 1 then
--printCentered(55,"" .. question[RanNumber].answer,lightyellow)
font:setStyle(0.5, lightyellow, nil_color, IntraFont.ALIGN_CENTER)
font:print(240, 60, "" .. question[RanNumber].answer);
streak.health = 0
pose = 0
qcount = 1
for a = 1, 21 do
question[a].complete = 0
end
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
if name == question[RanNumber].answer then
--printCentered(120,"Correct",pink)
font:setStyle(0.5, pink, nil_color, IntraFont.ALIGN_CENTER)
font:print(240, 120, "Correct")
screen.flip()
question[RanNumber].complete = 1
qcount = qcount + 1
streak.health = streak.health + 1
pose = pose + 1
name = ""
screen.waitVblankStart(70)
else
--printCentered(120,"WRONG!",pink)
font:setStyle(0.5, pink, nil_color, IntraFont.ALIGN_CENTER)
font:print(240, 120, "WRONG!")
screen.flip()
streak.health = 0
pose = 0
name = ""
screen.waitVblankStart(30)
for a = 1, 21 do
question[a].complete = 0
end
end
end


if streak.health == 21 then
s11check = 1
s11save = 0
end



if qcount == 22 then
RanNumber = math.random(#question)
for a = 1, 21 do
question[a].complete = 0
qcount = 1
end
end



System.endDraw()
screen.flip()
screen.waitVblankStart()
oldpad = pad
end