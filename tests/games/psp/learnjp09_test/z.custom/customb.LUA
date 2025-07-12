wcount = 1
loopCount = 0
loopCount2 = 0
streak = { health = 0 }
space = { "", " " }


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
pose = 0
victory = 0
spacebar = 0

function printCentered(y,text,color)
local length = string.len(text)
local x = 240 - ((length*8)/2)
screen:print(x,y,text,color)
end

name2 = "1"
qcount = 1



file = io.open("write.txt", "r") 
cusq1 = file:read()
cusa1 = file:read()
cusq2 = file:read()
cusa2 = file:read()
cusq3 = file:read()
cusa3 = file:read()
cusq4 = file:read()
cusa4 = file:read()
cusq5 = file:read()
cusa5 = file:read()
cusq6 = file:read()
cusa6 = file:read()
cusq7 = file:read()
cusa7 = file:read()
cusq8 = file:read()
cusa8 = file:read()
cusq9 = file:read()
cusa9 = file:read()
cusq10 = file:read()
cusa10 = file:read()
file:close() 

question = { }
question[1] = { quest = cusq1, answer = cusa1 }
question[2] = { quest = cusq2, answer = cusa2 }
question[3] = { quest = cusq3, answer = cusa3 }
question[4] = { quest = cusq4, answer = cusa4 }
question[5] = { quest = cusq5, answer = cusa5 }
question[6] = { quest = cusq6, answer = cusa6 }
question[7] = { quest = cusq7, answer = cusa7 }
question[8] = { quest = cusq8, answer = cusa8 }
question[9] = { quest = cusq9, answer = cusa9 }
question[10] = { quest = cusq10, answer = cusa10 }
question[11] = { quest = cusq11, answer = cusa11 }


while true do
System.draw()
screen:clear()
screen:blit(0, 0, cusbg) 

  
if mode2 == 1 then screen:blit(80, 120, dpad3, 0, 0, 0, 76, 78)
elseif mode2 >= 2 then screen:blit(80, 120, dpad3, 0, 76, 0, 76, 78)
end

if mode2 == 1 then screen:blit(20, 22, dpad3, 0, 101, 78, 95, 15)
elseif mode2 >= 2 then screen:blit(20, 22, dpad3, 0, 0, 78, 101, 18)
end

if mode2 == 1 then screen:blit(318, 115, dpad3, 0, 228, 0, 87, 87)
elseif mode2 >= 2 then screen:blit(318, 115, dpad3, 0, 315, 0, 87, 87)
end




if pose ~= 21 and loopCount >= 0 and loopCount < 4 then 
screen:blit(200, 161, sprite, 0, 0, 0, 80, 92)
elseif loopCount >= 4 and loopCount < 8 and pose ~= 21 then 
screen:blit(200, 161, sprite, 0, 80, 0, 80, 92)
elseif loopCount >= 8 and loopCount < 12 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 160, 0, 80, 92)
elseif loopCount >= 12 and loopCount < 16 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 240, 0, 80, 92)
elseif loopCount >= 16 and loopCount < 20 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 320, 0, 80, 92)
elseif loopCount >= 20 and loopCount < 24 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 400, 0, 80, 92)
elseif loopCount >= 24 and loopCount < 28 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 0, 92, 80, 92)
elseif loopCount >= 28 and loopCount < 32 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 80, 92, 80, 92)
elseif loopCount >= 32 and loopCount < 36 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 160, 92, 80, 92)
elseif loopCount >= 36 and loopCount < 40 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 240, 92, 80, 92)
elseif loopCount >= 40 and loopCount < 44 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 320, 92, 80, 92)
elseif loopCount >= 44 and loopCount < 48 and pose ~= 21 then
screen:blit(200, 161, sprite, 0, 400, 0, 80, 92) end
if pose ~= 21 and loopCount + 1 >= 48 then loopCount = 0 else loopCount = loopCount + 1 end


if pose == 21 then loopCount2 = loopCount2 + 1
if loopCount2 >= 0 and loopCount2 < 10 then 
screen:blit(201, 148, sprite, 0, 0, 184, 80, 100)
elseif loopCount2 >= 10 and loopCount2 < 20 then
screen:blit(202, 149, sprite, 0, 80, 184, 80, 100)
elseif loopCount2 >= 20 and loopCount2 < 30 then 
screen:blit(189, 150, sprite, 0, 160, 184, 80, 100)
elseif loopCount2 >= 30 and loopCount2 < 40 then
screen:blit(184, 150, sprite, 0, 243, 184, 83, 100)
elseif loopCount2 >= 40 and loopCount2 < 50 then
screen:blit(184, 150, sprite, 0, 326, 184, 83, 100)
elseif loopCount2 >= 50 and loopCount2 < 60 then
screen:blit(184, 150, sprite, 0, 0, 286, 83, 100)
elseif loopCount2 >= 60 and loopCount2 < 70 then 
screen:blit(186, 150, sprite, 0, 83, 286, 83, 100)
elseif loopCount2 >= 70 and loopCount2 < 80 then
screen:blit(184, 150, sprite, 0, 243, 184, 83, 100)
 end


if loopCount2 >= 80 then 
screen:blit(184, 150, sprite, 0, 243, 184, 83, 100)
loopCount2 = loopCount2 - 40
else loopCount2 = loopCount2 + 1 end
end

--System.endDraw()

if victory == 1 then
Wav.play(false, 0)
end

if pose == 21 then victory = victory + 1
elseif victory == 3 then victory = victory - 1
end



pad = Controls.read()



font:setStyle(0.5, silver, transparent, IntraFont.ALIGN_CENTER);
font:print(240, 30, "LEARN JAPANESE");

font:setStyle(0.5, orange, transparent, IntraFont.ALIGN_CENTER);
font:print(240, 40, "by ponlork");

font:setStyle(0.5, white, transparent, IntraFont.ALIGN_CENTER);
font:print(240, 80, "" .. question[qcount].quest);

font:setStyle(0.5, lightyellow, transparent, IntraFont.ALIGN_LEFT);
font:print(375, 24, "Streak: " .. streak.health);

font:setStyle(0.5, green, transparent, IntraFont.ALIGN_LEFT);
font:print(375, 36, "R+O = Answer");

font:setStyle(0.5, silver, transparent, IntraFont.ALIGN_LEFT);
font:print(25, 10, "CUSTOM MODE");

font:setStyle(0.5, blue, transparent, IntraFont.ALIGN_CENTER);
font:print(240, 100, name);

font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(10, 260, "R+Triangle = Menu");



if answer == 1 then
--printCentered(50,"" .. question[qcount].answer,lightyellow)
font:setStyle(0.5, lightyellow, transparent, IntraFont.ALIGN_CENTER);
font:print(240, 60, "" .. question[qcount].answer)
streak.health = 0
pose = 0
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
end
end

if pad:r() and pad:triangle() ~= oldpad:triangle() 
then 

break 
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

if name == question[qcount].answer then
--printCentered(120,"Correct",pink)
font:setStyle(0.5, pink, nil_color, IntraFont.ALIGN_CENTER)
font:print(240, 120, "Correct")
screen.flip()
qcount = qcount + 1
streak.health = streak.health + 1
name = ""
screen.waitVblankStart(70)
else 
--printCentered(120,"WRONG!",pink)
font:setStyle(0.5, pink, nil_color, IntraFont.ALIGN_CENTER)
font:print(240, 120, "WRONG!")
screen.flip()
streak.health = 0
name = ""
screen.waitVblankStart(30)
end
end


if question[qcount].answer == nil then 
qcount = 1
 end

if pad:r() and pad:triangle() and pad:triangle() ~= oldpad:triangle() 
then break
end 




System.endDraw()
screen.flip()
screen.waitVblankStart()
oldpad = pad
end