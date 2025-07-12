lyricsbg = Image.load("stage6/background.png")
mikuru = Image.load("karaoke/lyrics/mikuru.png") 
dpad3 = Image.load("dpad3.png")
Mp3.load("karaoke/lyrics/sounds/001.mp3", 0)
Mp3.load("karaoke/lyrics/sounds/002.mp3", 1)
Ogg.load("karaoke/lyrics/sounds/003.ogg", 0)
Ogg.load("karaoke/lyrics/sounds/004.ogg", 1)

collectgarbage()

loopCount = 0
loopCount2 = 0
streak = { health = 0 }
question = { }
question[1] = { quest = "", answer = "nazonazo mitai ni" }
question[2] = { quest = "", answer = "chikyuugi wo tokiakashitara" }
question[3] = { quest = "", answer = "minna de doko made mo ikeru ne" }
question[4] = { quest = "", answer = "jikan no hate made boon" }
question[5] = { quest = "", answer = "warp de loop na kono omoi wa" }
question[6] = { quest = "", answer = "nani mo kamo wo makikonda souzou de asobou" }
question[7] = { quest = "", answer = "aru hareta hi no koto" }
question[8] = { quest = "", answer = "mahou ijou no yukai ga" }
question[9] = { quest = "", answer = "kagirinaku furisosogu fukanou janai wa" }
question[10] = { quest = "", answer = "ashita mata au toki warainagara humming" }
question[11] = { quest = "", answer = "ureshisa wo atsumeyou" }
question[12] = { quest = "", answer = "kantan nanda yo konna no" }
question[13] = { quest = "", answer = "oikakete ne tsukamaete mite" }
question[14] = { quest = "", answer = "ooki na yume yume suki deshou" }
question[15] = { quest = "Finished! Press X to restart. R+Triangle to exit", answer = "" }




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
linep = 0
victory = 0
spacebar = 0
load = 0



while true do
System.draw()
screen:clear()
   screen:blit(0, 0, lyricsbg) 
    
if mode2 == 1 then screen:blit(80, 120, dpad3, 0, 0, 0, 76, 78)
elseif mode2 >= 2 then screen:blit(80, 120, dpad3, 0, 76, 0, 76, 78)
end

if mode2 == 1 then screen:blit(20, 22, dpad3, 0, 101, 78, 95, 15)
elseif mode2 >= 2 then screen:blit(20, 22, dpad3, 0, 0, 78, 101, 18)
end

if mode2 == 1 then screen:blit(318, 115, dpad3, 0, 228, 0, 87, 87)
elseif mode2 >= 2 then screen:blit(318, 115, dpad3, 0, 315, 0, 87, 87)
end


if pose ~= 21 and loopCount >= 0 and loopCount < 10 then 
screen:blit(207, 120, mikuru, 0, 0, 0, 77, 120)
elseif loopCount >= 10 and loopCount < 20 and pose ~= 21 then 
screen:blit(207, 120, mikuru, 0, 77, 0, 78, 120)
elseif loopCount >= 20 and loopCount < 30 and pose ~= 21 then
screen:blit(207, 120, mikuru, 0, 155, 0, 76, 120)
elseif loopCount >= 30 and loopCount < 40 and pose ~= 21 then
screen:blit(207, 120, mikuru, 0, 231, 0, 77, 120)


elseif loopCount >= 40 and loopCount < 50 and pose ~= 21 then
screen:blit(207, 120, mikuru, 0, 155, 0, 76, 120)
elseif loopCount >= 50 and loopCount < 60 and pose ~= 21 then
screen:blit(207, 120, mikuru, 0, 77, 0, 78, 120) end

if pose ~= 21 and loopCount + 1 >= 60 then loopCount = 0 else loopCount = loopCount + 1 end







pad = Controls.read()

font:setStyle(0.5, pink2, nil_color, IntraFont.ALIGN_LEFT)
font:print(370, 24, "Streak: " .. streak.health)

font:setStyle(0.5, green, nil_color, IntraFont.ALIGN_LEFT)
font:print(370, 36, "R+O = Answer")

font:setStyle(0.5, lightyellow, nil_color, IntraFont.ALIGN_LEFT)
font:print(370, 46, "R+[] = Audio")

font:setStyle(0.5, silver, nil_color, IntraFont.ALIGN_CENTER);
font:print(240, 30, "LEARN JAPANESE")

font:setStyle(0.5, orange, nil_color, IntraFont.ALIGN_CENTER);
font:print(240, 40, "by ponlork")

font:setStyle(0.5, white, nil_color, IntraFont.ALIGN_CENTER);
font:print(240, 70, question[qcount].quest)

font:setStyle(0.5, blue, nil_color, IntraFont.ALIGN_CENTER);
font:print(240, 94, ""..name);

font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(10, 260, "R+Triangle = Menu");


dofile("Cheat.LUA")




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

if pad:left() and oldpad:left() ~=pad:left() and pad:left() ~=pad:r() and mode2 == 2 and mode2ka2 ~= 11
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

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 1 and currentLetter5 ~= 7 and pad:square() ~= pad:r()
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

if pad:cross() and oldpad:cross() ~=pad:cross() and mode2 == 1 and currentLetter7 ~= 7 and qcount ~= 15
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

if pad:square() and oldpad:square() ~=pad:square() and mode2 == 2 and mode2ka5 ~= 11 and pad:square() ~= pad:r()
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
end
end

if pad:r() and pad:triangle() ~= oldpad:triangle() 
then 
lyricsbg:free()
mikuru:free()
dpad3:free()
Mp3.stop(0)
Ogg.stop(0)
Mp3.stop(1)
Ogg.stop(1)
Mp3.unload(0)
Mp3.unload(1)
Ogg.unload(0)
Ogg.load("karaoke/ogg.ogg", 1)
menuprompt = 1
	collectgarbage()
	
break 
end



if answer == 1 then
font:setStyle(0.5, green, transparent, IntraFont.ALIGN_CENTER);
font:print(240, 60, question[qcount].answer);
streak.health = 0
pose = 0
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
font:setStyle(0.5, pink, nil_color, IntraFont.ALIGN_CENTER);
font:print(240, 106, "Correct");
screen.flip()
qcount = qcount + 1
linep = 0
streak.health = streak.health + 1
pose = pose + 1
name = ""
screen.waitVblankStart(70)
else
font:setStyle(0.5, pink, nil_color, IntraFont.ALIGN_CENTER);
font:print(240, 106, "WRONG!");
screen.flip()
streak.health = 0
pose = 0
name = ""
screen.waitVblankStart(30)
end
end

if qcount == 5 and load == 0 then
Mp3.load("karaoke/lyrics/sounds/005.mp3", 0)
Mp3.load("karaoke/lyrics/sounds/006.mp3", 1)
Ogg.load("karaoke/lyrics/sounds/007.ogg", 0)
Ogg.load("karaoke/lyrics/sounds/008.ogg", 1)
load = load + 1
elseif qcount == 9 and load == 0 then
Mp3.load("karaoke/lyrics/sounds/009.mp3", 0)
Mp3.load("karaoke/lyrics/sounds/010.mp3", 1)
Ogg.load("karaoke/lyrics/sounds/011.ogg", 0)
Ogg.load("karaoke/lyrics/sounds/012.ogg", 1)
load = load + 1
elseif qcount == 13 and load == 0 then
Mp3.load("karaoke/lyrics/sounds/013.mp3", 0)
Mp3.load("karaoke/lyrics/sounds/014.mp3", 1)
load = load + 1
end

if qcount == 1 and linep == 0 then
Mp3.play(false, 0)
linep = linep + 1
elseif qcount == 2 and linep == 0 then
Mp3.play(false, 1)
linep = linep + 1
elseif qcount == 3 and linep == 0 then
Ogg.play(false, 0)
linep = linep + 1
elseif qcount == 4 and linep == 0 then
Ogg.play(false, 1)
linep = linep + 1
elseif qcount == 5  and linep == 0 then
Mp3.play(false, 0)
linep = linep + 1
elseif qcount == 6  and linep == 0 then
Mp3.play(false, 1)
linep = linep + 1
load = 0
elseif qcount == 7 and linep == 0 then
Ogg.play(false, 0)
linep = linep + 1
elseif qcount == 8 and linep == 0 then
Ogg.play(false, 1)
linep = linep + 1
elseif qcount == 9  and linep == 0 then
Mp3.play(false, 0)
linep = linep + 1
elseif qcount == 10  and linep == 0 then
Mp3.play(false, 1)
linep = linep + 1
load = 0
elseif qcount == 11 and linep == 0 then
Ogg.play(false, 0)
linep = linep + 1
elseif qcount == 12 and linep == 0 then
Ogg.play(false, 1)
linep = linep + 1
elseif qcount == 13  and linep == 0 then
Mp3.play(false, 0)
linep = linep + 1
elseif qcount == 14  and linep == 0 then
Mp3.play(false, 1)
linep = linep + 1
load = 0
end


if pad:cross() and oldpad:cross() ~=pad:cross() and qcount == 15
then 
Mp3.load("karaoke/lyrics/sounds/001.mp3", 0)
Mp3.load("karaoke/lyrics/sounds/002.mp3", 1)
Ogg.load("karaoke/lyrics/sounds/003.ogg", 0)
Ogg.load("karaoke/lyrics/sounds/004.ogg", 1)
qcount = qcount + 1
end




if pad:r() and pad:square() ~= oldpad:square() and pad:r() ~= oldpad:square() 
then
linep = 0
end



if qcount == 16 then qcount = qcount -15
end

System.endDraw()
screen.flip()
screen.waitVblankStart()
oldpad = pad
end












