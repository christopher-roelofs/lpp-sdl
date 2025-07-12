stage13back = Image.load("stage13/background.png")
Ogg.load("stage13/sounds/perfume.ogg", 0)

reset = 0
loopCount = 0
loopCount2 = 0
streak = { health = 0 }
question = { }
question[1] = { quest = "one", answer = "いち" }
question[2] = { quest = "two", answer = "に" }
question[3] = { quest = "three", answer = "さん" }
question[4] = { quest = "four", answer = "し" }
question[5] = { quest = "five", answer = "ご" }
question[6] = { quest = "six", answer = "ろく" }
question[7] = { quest = "seven", answer = "なな" }
question[8] = { quest = "eight", answer = "はち" }
question[9] = { quest = "nine", answer = "きゅう" }
question[10] = { quest = "ten", answer = "じゅう" }
question[11] = { quest = "11", answer = "じゅういち" }
question[12] = { quest = "12", answer = "じゅうに" }
question[13] = { quest = "13", answer = "じゅうさん" }
question[14] = { quest = "14", answer = "じゅうし" }
question[15] = { quest = "15", answer = "じゅうご" }
question[16] = { quest = "16", answer = "じゅうろく" }
question[17] = { quest = "17", answer = "じゅうなな" }
question[18] = { quest = "18", answer = "じゅうはち" }
question[19] = { quest = "19", answer = "じゅうきゅう" }
question[20] = { quest = "four (alternative)", answer = "よん" }
question[21] = { quest = "seven (alternative)", answer = "しち" }
question[22] = { quest = "nine (alternative)", answer = "く" }
question[23] = { quest = "14 (alternative)", answer = "じゅうよん" }
question[24] = { quest = "17 (alternative)", answer = "じゅうしち" }
question[25] = { quest = "19 (alternative)", answer = "じゅうく" }



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
mode2ka10 = 1
qcount = 1
gomenwav = 1
pose = 0
victory = 0
spacebar = 0

ifont:setStyle(1.0, white, nil_color, IntraFont.ALIGN_CENTER);

--[[
function printCentered(y,text,color)
local length = string.len(text)
local x = 240 - ((length*8)/2)
screen:print(x,y,text,color)
end
]]



while true do
System.draw()
screen:clear()

   screen:blit(0, 0, stage13back) 
	 
if mode2 == 1 then screen:blit(80, 120, dpad3, 0, 152, 0, 76, 78)
elseif mode2 == 2 then screen:blit(80, 120, dpad3, 0, 307, 88, 76, 78)
end

if mode2 == 1 then screen:blit(32, 22, dpad3, 0, 125, 118, 83, 18)
elseif mode2 == 2 then screen:blit(32, 22, dpad3, 0, 208, 114, 92, 19)
end

if mode2 == 1 then screen:blit(318, 115, dpad3, 0, 402, 0, 87, 87)
elseif mode2 == 2 then screen:blit(318, 115, dpad3, 0, 393, 90, 87, 87)
end
	 


   
   
   




if pose ~= 25 and loopCount >= 0 and loopCount < 4 then 
screen:blit(200, 150, sprite, 0, 0, 0, 80, 92)
elseif loopCount >= 4 and loopCount < 8 and pose ~= 25 then 
screen:blit(200, 150, sprite, 0, 80, 0, 80, 92)
elseif loopCount >= 8 and loopCount < 12 and pose ~= 25 then
screen:blit(200, 150, sprite, 0, 160, 0, 80, 92)
elseif loopCount >= 12 and loopCount < 16 and pose ~= 25 then
screen:blit(200, 150, sprite, 0, 240, 0, 80, 92)
elseif loopCount >= 16 and loopCount < 20 and pose ~= 25 then
screen:blit(200, 150, sprite, 0, 320, 0, 80, 92)
elseif loopCount >= 20 and loopCount < 24 and pose ~= 25 then
screen:blit(200, 150, sprite, 0, 400, 0, 80, 92)
elseif loopCount >= 24 and loopCount < 28 and pose ~= 25 then
screen:blit(200, 150, sprite, 0, 0, 92, 80, 92)
elseif loopCount >= 28 and loopCount < 32 and pose ~= 25 then
screen:blit(200, 150, sprite, 0, 80, 92, 80, 92)
elseif loopCount >= 32 and loopCount < 36 and pose ~= 25 then
screen:blit(200, 150, sprite, 0, 160, 92, 80, 92)
elseif loopCount >= 36 and loopCount < 40 and pose ~= 25 then
screen:blit(200, 150, sprite, 0, 240, 92, 80, 92)
elseif loopCount >= 40 and loopCount < 44 and pose ~= 25 then
screen:blit(200, 150, sprite, 0, 320, 92, 80, 92)
elseif loopCount >= 44 and loopCount < 48 and pose ~= 25 then
screen:blit(200, 150, sprite, 0, 400, 0, 80, 92) end
if pose ~= 25 and loopCount + 1 >= 48 then loopCount = 0 else loopCount = loopCount + 1 end


if pose == 25 then loopCount2 = loopCount2 + 1
if loopCount2 >= 0 and loopCount2 < 10 then 
screen:blit(201, 137, sprite, 0, 0, 184, 80, 100)
elseif loopCount2 >= 10 and loopCount2 < 20 then
screen:blit(202, 138, sprite, 0, 80, 184, 80, 100)
elseif loopCount2 >= 20 and loopCount2 < 30 then 
screen:blit(189, 139, sprite, 0, 160, 184, 80, 100)
elseif loopCount2 >= 30 and loopCount2 < 40 then
screen:blit(184, 139, sprite, 0, 243, 184, 83, 100)
elseif loopCount2 >= 40 and loopCount2 < 50 then
screen:blit(184, 139, sprite, 0, 326, 184, 83, 100)
elseif loopCount2 >= 50 and loopCount2 < 60 then
screen:blit(184, 139, sprite, 0, 0, 286, 83, 100)
elseif loopCount2 >= 60 and loopCount2 < 70 then 
screen:blit(186, 139, sprite, 0, 83, 286, 83, 100)
elseif loopCount2 >= 70 and loopCount2 < 80 then
screen:blit(184, 139, sprite, 0, 243, 184, 83, 100)
 end


if loopCount2 >= 80 then 
screen:blit(184, 139, sprite, 0, 243, 184, 83, 100)
loopCount2 = loopCount2 - 40
else loopCount2 = loopCount2 + 1 end
end

--ifont:print(240, 106, ""..name);

if answer == 1 then
ifont:print(240, 60, "" .. question[qcount].answer);
streak.health = 0
pose = 0
reset = 1
end

--if menuprompt == 0 then
ifont:print(90, 255, "R+▲ = Menu");
--end

--System.endDraw()

if victory == 1 then
Wav.play(false, 0)
end

if pose == 25 then victory = victory + 1
elseif victory == 3 then victory = victory - 1
end

if reset == 1 then loopCount2 = 0
reset = reset + 1
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
font:print(240, 80, question[qcount].quest)

font:setStyle(0.5, blue, nil_color, IntraFont.ALIGN_CENTER);
ifont:print(240, 106, ""..name);






pad = Controls.read()	

dofile("Cheat.LUA")




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
Ogg.stop(0)
Ogg.unload(0)
stage13back:free()
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
if name == question[qcount].answer and name ~= question[24].answer then
--printCentered(120,"Correct",pink)
font:setStyle(0.5, pink, nil_color, IntraFont.ALIGN_CENTER)
font:print(240, 120, "Correct")
screen.flip()
qcount = qcount + 1
gomenwav = gomenwav + 1
streak.health = streak.health + 1
pose = pose + 1
name = ""
screen.waitVblankStart(70)
elseif name == question[24].answer and gomenwav == 24 then
--printCentered(120,"Correct",pink)
font:setStyle(0.5, pink, nil_color, IntraFont.ALIGN_CENTER)
font:print(240, 120, "Correct")
screen.flip()
gomenwav = gomenwav + 1
qcount = qcount + 1
Ogg.play(false, 0)
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
reset = 1
name = ""
screen.waitVblankStart(30)
end
end

if streak.health == 25 then
s13check = 1
s13save = 0
end


	
if qcount == 26 then qcount = qcount -25
gomenwav = 1
end



System.endDraw()
screen.flip()
screen.waitVblankStart()
oldpad = pad
end