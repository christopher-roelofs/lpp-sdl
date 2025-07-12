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
question[1] = { quest = "one", answer = "いち" }
question[2] = { quest = "two", answer = "に" }
question[3] = { quest = "three", answer = "さん" }
question[4] = { quest = "boat", answer = "ふね" }
question[5] = { quest = "airplane", answer = "ひこうき" }
question[6] = { quest = "more", answer = "もっと" }
question[7] = { quest = "hospital", answer = "びょういん" }
question[8] = { quest = "library", answer = "としょかん" }
question[9] = { quest = "post office", answer = "ゆうびんきょく" }
question[10] = { quest = "today is good weather isn't it?", answer = "きょうはいいてんきですね" }
question[11] = { quest = "magazine", answer = "ざっし" }
question[12] = { quest = "room", answer = "へや" }
question[13] = { quest = "today is bad weather isn't it?", answer = "きょうはわるいてんきですね" }
question[14] = { quest = "rain", answer = "あめ" }
question[15] = { quest = "snow", answer = "ゆき" }
question[16] = { quest = "white", answer = "しろい" }
question[17] = { quest = "black", answer = "くろい" }
question[18] = { quest = "river", answer = "かわ" }
question[19] = { quest = "horse", answer = "うま" }
question[20] = { quest = "wind", answer = "かぜ" }
question[21] = { quest = "Devil", answer = "あくま" }



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

ifont:setStyle(1.0, white, nil_color, IntraFont.ALIGN_CENTER);


math.randomseed(os.time()) -- prevents same random numbers each run
math.random(); math.random(); math.random()



--function printCentered(y,text,color)
--local length = string.len(text)
--local x = 240 - ((length*8)/2)
--screen:print(x,y,text,color)
--end



while true do
if randomnum == 1 and question[RanNumber].complete == 1 then
RanNumber = math.random(#question)
end
System.draw()
screen:clear()
   screen:blit(0, 0, stage11back) 

if mode2 == 1 then screen:blit(80, 120, dpad3, 0, 152, 0, 76, 78)
elseif mode2 >= 2 then screen:blit(80, 120, dpad3, 0, 307, 88, 76, 78)
end

if mode2 == 1 then screen:blit(20, 22, dpad3, 0, 125, 118, 83, 18)
elseif mode2 >= 2 then screen:blit(20, 22, dpad3, 0, 208, 114, 92, 19)
end

if mode2 == 1 then screen:blit(318, 115, dpad3, 0, 402, 0, 87, 87)
elseif mode2 >= 2 then screen:blit(318, 115, dpad3, 0, 393, 90, 87, 87)
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

if answer == 1 then
ifont:print(240, 60, "" .. question[RanNumber].answer);
streak.health = 0
pose = 0
qcount = 1
for a = 1, 21 do
question[a].complete = 0
end
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
ifont:print(90, 255, "R+▲ = Menu");
--end


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



if pad:select() and oldpad:select() ~= pad:select() then
if mode2 == 1 then mode2 = 2
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




if pad:left() and oldpad:left() ~=pad:left() and pad:left() ~=pad:r() and mode2 == 1 and mode2ka2 ~= 11
then name = name .. hira[1]
mode2ka2 = mode2ka2 + 1
mode2ka = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:left() and oldpad:left() ~=pad:left() and mode2 == 1 and mode2ka2 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[2]
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

if pad:left() and oldpad:left() ~=pad:left() and mode2 == 1 and mode2ka2 == 5
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[3]
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

if pad:left() and oldpad:left() ~=pad:left() and mode2 == 1 and mode2ka2 == 7
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[4]
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

if pad:left() and oldpad:left() ~=pad:left() and mode2 == 1 and mode2ka2 == 9
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[5]
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

if pad:left() and oldpad:left() ~=pad:left() and mode2 == 1 and mode2ka2 == 11
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[1]
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


	
	


	
	
	
--------------
	
	
	

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 1 and mode2ka ~= 11
then name = name .. hira[6]
mode2ka = mode2ka + 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 1 and mode2ka == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[7]
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

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 1 and mode2ka == 5
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[8]
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

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 1 and mode2ka == 7
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[9]
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

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 1 and mode2ka == 9
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[10]
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

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 1 and mode2ka == 11
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[6]
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


-------------


if pad:down() and oldpad:down() ~=pad:down() and mode2 == 1 and mode2ka3 ~= 11
then name = name .. hira[16]
mode2ka3 = mode2ka3 + 1
mode2ka2 = 1
mode2ka = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 1 and mode2ka3 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[17]
mode2ka3 = mode2ka3 + 1
mode2ka2 = 1
mode2ka = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 1 and mode2ka3 == 5
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[18]
mode2ka3 = mode2ka3 + 1
mode2ka2 = 1
mode2ka = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 1 and mode2ka3 == 7
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[19]
mode2ka3 = mode2ka3 + 1
mode2ka2 = 1
mode2ka = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 1 and mode2ka3 == 9
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[20]
mode2ka3 = mode2ka3 + 1
mode2ka2 = 1
mode2ka = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 1 and mode2ka3 == 11
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[16]
mode2ka3 = mode2ka3 - 9
mode2ka2 = 1
mode2ka = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end



-------------

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 1 and mode2ka4 ~= 11
then name = name .. hira[26]
mode2ka4 = mode2ka4 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end


if pad:analogY() < -120 and mode2 == 1 and mode2ka6 ~= 10 and mode2ka4 == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[31]
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 1 and mode2ka4 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[27]
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

if pad:analogY() < -120 and mode2 == 1 and mode2ka6 ~= 10 and mode2ka4 == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[32]
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 1 and mode2ka4 == 5
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[28]
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

if pad:analogY() < -120 and mode2 == 1 and mode2ka6 ~= 10 and mode2ka4 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[33]
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka6 ~= 10 and mode2ka4 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[73]
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 1 and mode2ka4 == 7
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[29]
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

if pad:analogY() < -120 and mode2 == 1 and mode2ka4 == 8 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[34]
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 1 and mode2ka4 == 9
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[30]
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

if pad:analogY() < -120 and mode2 == 1 and mode2ka4 == 10 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[35]
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 1 and mode2ka4 == 11
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[26]
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



-------------



if pad:square() and oldpad:square() ~=pad:square() and mode2 == 1 and mode2ka5 ~= 11 and pad:square() ~= pad:r()
then name = name .. hira[36]
mode2ka5 = mode2ka5 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 1 and mode2ka5 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[37]
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

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 1 and mode2ka5 == 5
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[38]
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

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 1 and mode2ka5 == 7
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[39]
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

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 1 and mode2ka5 == 9
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[40]
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

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 1 and mode2ka5 == 11
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[36]
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




-------------

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 1 and mode2ka6 ~= 11
then name = name .. hira[41]
mode2ka6 = mode2ka6 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:analogY() < -120 and mode2 == 1 and mode2ka6 ~= 10 and mode2ka6 == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[46]
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka6 ~= 10 and mode2ka6 == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[51]

mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka3 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 1 and mode2ka6 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[42]
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

if pad:analogY() < -120 and mode2 == 1 and mode2ka6 ~= 10 and mode2ka6 == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[47]
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka6 ~= 10 and mode2ka6 == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[52]

mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka3 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 1 and mode2ka6 == 5
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[43]
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

if pad:analogY() < -120 and mode2 == 1 and mode2ka6 ~= 10 and mode2ka6 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[48]
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka6 ~= 10 and mode2ka6 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[53]

mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka3 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 1 and mode2ka6 == 7
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[44]
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

if pad:analogY() < -120 and mode2 == 1 and mode2ka6 == 8 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[49]
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka6 == 8 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[54]

mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka3 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 1 and mode2ka6 == 9
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[45]
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

if pad:analogY() < -120 and mode2 == 1 and mode2ka6 == 10 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[50]
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka6 == 10 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[55]
mode2ka = 1
mode2ka2 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka3 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:triangle() and oldpad:triangle() ~=pad:triangle() and mode2 == 1 and mode2ka6 == 11
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[41]
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



-------------


if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 1 and mode2ka7 ~= 11
then name = name .. hira[57]
mode2ka7 = mode2ka7 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 1 and mode2ka7 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[58]
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

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 1 and mode2ka7 == 5
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[59]
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

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 1 and mode2ka7 == 7
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[60]
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

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 1 and mode2ka7 == 9
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[61]
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

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 1 and mode2ka7 == 11
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[57]
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





-------------


if pad:circle() and oldpad:circle() ~=pad:circle() and pad:circle() ~=pad:r() and mode2 == 1 and mode2ka8 ~= 11
then name = name .. hira[62]
mode2ka8 = mode2ka8 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 1 and mode2ka8 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[63]
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

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 1 and mode2ka8 == 5
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[64]
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

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 1 and mode2ka8 == 7
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[65]
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

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 1 and mode2ka8 == 9
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[66]
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

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 1 and mode2ka8 == 11
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[62]
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





-------------


if pad:l() and oldpad:l() ~=pad:l() and mode2 == 1 and mode2ka9 ~= 13
then name = name .. hira[67]
mode2ka9 = mode2ka9 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka10 = 1
end

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 1 and mode2ka9 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[68]
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

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 1 and mode2ka9 == 5
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[69]
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

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 1 and mode2ka9 == 7
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[70]
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

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 1 and mode2ka9 == 9
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[71]
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

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 1 and mode2ka9 == 11
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[72]
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

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 1 and mode2ka9 == 13
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[67]
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


------katakana


if pad:left() and oldpad:left() ~=pad:left() and pad:left() ~=pad:r() and mode2 == 2 and mode2ka2 ~= 11
then name = name .. kata[1]
mode2ka2 = mode2ka2 + 1
mode2ka = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:left() and oldpad:left() ~=pad:left() and mode2 == 2 and mode2ka2 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[2]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[3]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[4]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[5]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[1]
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

	

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka ~= 11
then name = name .. kata[6]
mode2ka = mode2ka + 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[7]
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

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka == 5
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[8]
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

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka == 7
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[9]
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

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka == 9
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[10]
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

if pad:up() and oldpad:up() ~=pad:up() and mode2 == 2 and mode2ka == 11
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[6]
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


if pad:down() and oldpad:down() ~=pad:down() and mode2 == 2 and mode2ka3 ~= 11
then name = name .. kata[16]
mode2ka3 = mode2ka3 + 1
mode2ka2 = 1
mode2ka = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 2 and mode2ka3 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[17]
mode2ka3 = mode2ka3 + 1
mode2ka2 = 1
mode2ka = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 2 and mode2ka3 == 5
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[18]
mode2ka3 = mode2ka3 + 1
mode2ka2 = 1
mode2ka = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 2 and mode2ka3 == 7
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[19]
mode2ka3 = mode2ka3 + 1
mode2ka2 = 1
mode2ka = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:down() and oldpad:down() ~=pad:down() and mode2 == 2 and mode2ka3 == 9
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[20]
mode2ka3 = mode2ka3 + 1
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[16]
mode2ka3 = mode2ka3 - 9
mode2ka2 = 1
mode2ka = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end


if pad:right() and oldpad:right() ~=pad:right() and mode2 == 2 and mode2ka4 ~= 11
then name = name .. kata[26]
mode2ka4 = mode2ka4 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end


if pad:analogY() < -120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka4 == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[31]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[27]
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

if pad:analogY() < -120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka4 == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[32]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[28]
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

if pad:analogY() < -120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka4 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[33]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka4 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[73]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[29]
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
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[34]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[30]
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

if pad:analogY() < -120 and mode2 == 2 and mode2ka4 == 10 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[35]
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
end

if pad:right() and oldpad:right() ~=pad:right() and mode2 == 2 and mode2ka4 == 11
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[26]
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



if pad:square() and oldpad:square() ~=pad:square() and mode2 == 2 and mode2ka5 ~= 11 and pad:square() ~= pad:r()
then name = name .. kata[36]
mode2ka5 = mode2ka5 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 2 and mode2ka5 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[37]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[38]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[39]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[40]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[36]
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
then name = name .. kata[41]
mode2ka6 = mode2ka6 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:analogY() < -120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka6 == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[46]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka6 == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[51]

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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[42]
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
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[47]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka6 == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[52]

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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[43]
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
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[48]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka6 ~= 10 and mode2ka6 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[53]

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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[44]
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
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[49]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka6 == 8 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[54]

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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[45]
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
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[50]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka6 == 10 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[55]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[41]
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
then name = name .. kata[57]
mode2ka7 = mode2ka7 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 2 and mode2ka7 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[58]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[59]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[60]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[61]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[57]
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
then name = name .. kata[62]
mode2ka8 = mode2ka8 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if pad:circle() and oldpad:circle() ~=pad:circle() and mode2 == 2 and mode2ka8 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[63]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[64]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[65]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[66]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[62]
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
then name = name .. kata[67]
mode2ka9 = mode2ka9 + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka10 = 1
end

if pad:l() and oldpad:l() ~=pad:l() and mode2 == 2 and mode2ka9 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[68]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[69]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[70]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[71]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[72]
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
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. kata[67]
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



----------------










if pad:r() and pad:left() ~= oldpad:left() and pad:r() ~= oldpad:left() 
then name = string.sub(name, 1, string.len(name) - 3)
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
mode2ka10 = 1
end





--ka
if pad:analogY() < -120 and mode2 == 1 and mode2ka == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[11]
elseif pad:analogY() < -120 and mode2 == 1 and mode2ka == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[12]
elseif pad:analogY() < -120 and mode2 == 1 and mode2ka == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[13]
elseif pad:analogY() < -120 and mode2 == 1 and mode2ka == 8 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[14]
elseif pad:analogY() < -120 and mode2 == 1 and mode2ka == 10 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[15]
--sa
elseif pad:analogY() < -120 and mode2 == 1 and mode2ka3 == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[21]
elseif pad:analogY() < -120 and mode2 == 1 and mode2ka3 == 4
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[22]
elseif pad:analogY() < -120 and mode2 == 1 and mode2ka3 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[23]
elseif pad:analogY() < -120 and mode2 == 1 and mode2ka3 == 8 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[24]
elseif pad:analogY() < -120 and mode2 == 1 and mode2ka3 == 10 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[25]
--ya
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka9 == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[74]
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka9 == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[75]
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka9 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[76]
--aa
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka2 == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. hira[81]
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka2 == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[82]
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka2 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[83]
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka2 == 8 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[84]
elseif pad:analogY() > 120 and mode2 == 1 and mode2ka2 == 10 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..hira[85]
end

--ka (katakana)
if pad:analogY() < -120 and mode2 == 2 and mode2ka == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[11]
elseif pad:analogY() < -120 and mode2 == 2 and mode2ka == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[12]
elseif pad:analogY() < -120 and mode2 == 2 and mode2ka == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[13]
elseif pad:analogY() < -120 and mode2 == 2 and mode2ka == 8 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[14]
elseif pad:analogY() < -120 and mode2 == 2 and mode2ka == 10 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[15]
--sa
elseif pad:analogY() < -120 and mode2 == 2 and mode2ka3 == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[21]
elseif pad:analogY() < -120 and mode2 == 2 and mode2ka3 == 4
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[22]
elseif pad:analogY() < -120 and mode2 == 2 and mode2ka3 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[23]
elseif pad:analogY() < -120 and mode2 == 2 and mode2ka3 == 8 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[24]
elseif pad:analogY() < -120 and mode2 == 2 and mode2ka3 == 10 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[25]
--ya
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka9 == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[74]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka9 == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[75]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka9 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[76]
--aa
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka2 == 2 
then name = string.sub(name, 1, string.len(name) - 3)
name = name .. kata[81]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka2 == 4 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[82]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka2 == 6 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[83]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka2 == 8 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[84]
elseif pad:analogY() > 120 and mode2 == 2 and mode2ka2 == 10 
then name = string.sub(name, 1, string.len(name) - 3)
name = name..kata[85]
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
mode2ka10 = 1
end

----------comma


if pad:r() and pad:square() ~= oldpad:square() and pad:r() ~= oldpad:square() and mode2ka10 ~= 9 
then name = name .. hira[77]
mode2ka10 = mode2ka10 + 1
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

if pad:r() and pad:square() ~= oldpad:square() and pad:r() ~= oldpad:square() and mode2ka10 == 3
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[78]
mode2ka10 = mode2ka10 + 1
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


if pad:r() and pad:square() ~= oldpad:square() and pad:r() ~= oldpad:square() and mode2ka10 == 5
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[79]
mode2ka10 = mode2ka10 + 1
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


if pad:r() and pad:square() ~= oldpad:square() and pad:r() ~= oldpad:square() and mode2ka10 == 7
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[80]
mode2ka10 = mode2ka10 + 1
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


if pad:r() and pad:square() ~= oldpad:square() and pad:r() ~= oldpad:square() and mode2ka10 == 9
then name = string.sub(name, 1, string.len(name) - 6)
name = name .. hira[77]
mode2ka10 = mode2ka10 - 7
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

-------------

if pad:analogX() > 120 and oldpad:analogX() ~=pad:analogX() and pad:analogX() ~=pad:analogY() and spacebar < 1
then name = name .. space[3]
spacebar = spacebar + 1
mode2ka = 1
mode2ka2 = 1
mode2ka3 = 1
mode2ka4 = 1
mode2ka5 = 1
mode2ka6 = 1
mode2ka7 = 1
mode2ka8 = 1
mode2ka9 = 1
mode2ka10 = 1
end

if spacebar >= 1 then spacebar = spacebar + 1
end

if spacebar == 9 then spacebar = 0
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
mode2ka10 = 1
qcount = 1
for a = 1, 21 do
question[a].complete = 0
end
end
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

ifont:setStyle(1.0, orange, nil_color, IntraFont.ALIGN_CENTER);
ifont:print(240, 106, ""..name);

dofile("Cheatjprandom.LUA")




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