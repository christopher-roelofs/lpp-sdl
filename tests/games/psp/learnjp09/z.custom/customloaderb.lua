cusback = Image.load("z.custom/cusmenu.png") 
isuzu = Image.load("z.custom/isuzu.png")
cusbg = Image.load("z.custom/bg.png")

oldpad = pad
menu1 = 1
submenu = 0
name3 = "  "

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
screen:blit(0, 0, cusback) 

if menu1 == 1 then screen:blit(26, 73, dpad3, 0, 0, 96, 103, 40)
end

if menu1 == 2 then screen:blit(26, 103, dpad3, 0, 0, 96, 103, 40)
end

if menu1 == 3 then screen:blit(26, 133, dpad3, 0, 0, 96, 103, 40)
end

if menu1 == 4 then screen:blit(26, 163, dpad3, 0, 0, 96, 103, 40)
end

if menu1 == 6 then screen:blit(166, 90, dpad3, 0, 103, 110, 22, 26)
end

if menu1 == 7 then screen:blit(166, 100, dpad3, 0, 103, 110, 22, 26)
end

if menu1 == 8 then screen:blit(166, 110, dpad3, 0, 103, 110, 22, 26)
end

if menu1 == 9 then screen:blit(166, 120, dpad3, 0, 103, 110, 22, 26)
end

if menu1 == 10 then screen:blit(166, 130, dpad3, 0, 103, 110, 22, 26)
end

if menu1 == 11 then screen:blit(166, 140, dpad3, 0, 103, 110, 22, 26)
end

if menu1 == 12 then screen:blit(166, 150, dpad3, 0, 103, 110, 22, 26)
end

if menu1 == 13 then screen:blit(166, 160, dpad3, 0, 103, 110, 22, 26)
end

if menu1 == 14 then screen:blit(166, 170, dpad3, 0, 103, 110, 22, 26)
end

if menu1 == 15 then screen:blit(166, 180, dpad3, 0, 103, 110, 22, 26)
end

	--System.endDraw()

	pad = Controls.read()	
pose = 0


if pad:down() and oldpad:down() ~=pad:down() and submenu == 0 then 
menu1 = menu1 + 1
elseif menu1 == 5 and submenu == 0 then menu1 = menu1 - 4
end

if pad:up() and oldpad:up() ~=pad:up() and submenu == 0 then 
menu1 = menu1 - 1
elseif menu1 == 0 and submenu == 0 then menu1 = menu1 + 4
end

if pad:right() and oldpad:right() ~=pad:right() and submenu == 0 then 
submenu = 1
if submenu == 1 then menu1 = 6
end
end

if pad:left() and oldpad:left() ~=pad:left() and submenu == 1 then 
submenu = 0
if submenu == 0 then menu1 = 1
end
end

if pad:down() and oldpad:down() ~=pad:down() and submenu == 1 then 
menu1 = menu1 + 1
elseif menu1 == 16 then menu1 = menu1 - 10
end

if pad:up() and oldpad:up() ~=pad:up() and submenu == 1 then 
menu1 = menu1 - 1
elseif menu1 == 5 and submenu == 1 then menu1 = menu1 + 10
end


if pad:cross() and oldpad:cross() ~=pad:cross() and menu1 == 1
then dofile("./z.custom/entertextb.lua")
end




if pad:triangle() and pad:triangle() ~= oldpad:triangle() 
then 
cusback:free()
isuzu:free()
cusbg:free()
break 
end


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

if cusq1 ~= nil and cusa1 ~= nil then
font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(185, 108, cusq1..name3..cusa1);
end

if cusq2 ~= nil and cusa2 ~= nil then
font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(185, 118, cusq2..name3..cusa2);
end

if cusq3 ~= nil and cusa3 ~= nil then
font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(185, 128, cusq3..name3..cusa3);
end

if cusq4 ~= nil and cusa4 ~= nil then
font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(185, 138, cusq4..name3..cusa4);
end

if cusq5 ~= nil and cusa5 ~= nil then
font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(185, 148, cusq5..name3..cusa5);
end

if cusq6 ~= nil and cusa6 ~= nil then
font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(185, 158, cusq6..name3..cusa6);
end

if cusq7 ~= nil and cusa7 ~= nil then
font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(185, 168, cusq7..name3..cusa7);
end

if cusq8 ~= nil and cusa8 ~= nil then
font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(185, 178, cusq8..name3..cusa8);
end

if cusq9 ~= nil and cusa9 ~= nil then
font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(185, 188, cusq9..name3..cusa9);
end

if cusq10 ~= nil and cusa10 ~= nil then
font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(185, 198, cusq10..name3..cusa10);
end

System.endDraw()

if pad:cross() and oldpad:cross() ~=pad:cross() and menu1 == 6
then
file = io.open("write.txt", "w+") 
myText = "\n"
if cusq2 ~= nil then
file:write(cusq2..myText)
file:write(cusa2..myText)

if cusq3 ~= nil then
file:write(cusq3..myText)
file:write(cusa3..myText)

if cusq4 ~= nil then
file:write(cusq4..myText)
file:write(cusa4..myText)

if cusq5 ~= nil then
file:write(cusq5..myText)
file:write(cusa5..myText)

if cusq6 ~= nil then
file:write(cusq6..myText)
file:write(cusa6..myText)

if cusq7 ~= nil then
file:write(cusq7..myText)
file:write(cusa7..myText)

if cusq8 ~= nil then
file:write(cusq8..myText)
file:write(cusa8..myText)

if cusq9 ~= nil then
file:write(cusq9..myText)
file:write(cusa9..myText)

if cusq10 ~= nil then
file:write(cusq10..myText)
file:write(cusa10..myText)
end
end
end
end
end
end
end
end
end
file:close()
end

if pad:cross() and oldpad:cross() ~=pad:cross() and menu1 == 7
then
file = io.open("write.txt", "w+") 
myText = "\n"
if cusq1 ~= nil then
file:write(cusq1..myText)
file:write(cusa1..myText)

if cusq3 ~= nil then
file:write(cusq3..myText)
file:write(cusa3..myText)

if cusq4 ~= nil then
file:write(cusq4..myText)
file:write(cusa4..myText)

if cusq5 ~= nil then
file:write(cusq5..myText)
file:write(cusa5..myText)

if cusq6 ~= nil then
file:write(cusq6..myText)
file:write(cusa6..myText)

if cusq7 ~= nil then
file:write(cusq7..myText)
file:write(cusa7..myText)

if cusq8 ~= nil then
file:write(cusq8..myText)
file:write(cusa8..myText)

if cusq9 ~= nil then
file:write(cusq9..myText)
file:write(cusa9..myText)

if cusq10 ~= nil then
file:write(cusq10..myText)
file:write(cusa10..myText)
end
end
end
end
end
end
end
end
end
file:close()
end

if pad:cross() and oldpad:cross() ~=pad:cross() and menu1 == 8
then
file = io.open("write.txt", "w+") 
myText = "\n"
if cusq1 ~= nil then
file:write(cusq1..myText)
file:write(cusa1..myText)

if cusq2 ~= nil then
file:write(cusq2..myText)
file:write(cusa2..myText)

if cusq4 ~= nil then
file:write(cusq4..myText)
file:write(cusa4..myText)

if cusq5 ~= nil then
file:write(cusq5..myText)
file:write(cusa5..myText)

if cusq6 ~= nil then
file:write(cusq6..myText)
file:write(cusa6..myText)

if cusq7 ~= nil then
file:write(cusq7..myText)
file:write(cusa7..myText)

if cusq8 ~= nil then
file:write(cusq8..myText)
file:write(cusa8..myText)

if cusq9 ~= nil then
file:write(cusq9..myText)
file:write(cusa9..myText)

if cusq10 ~= nil then
file:write(cusq10..myText)
file:write(cusa10..myText)
end
end
end
end
end
end
end
end
end
file:close()
end


if pad:cross() and oldpad:cross() ~=pad:cross() and menu1 == 9
then
file = io.open("write.txt", "w+") 
myText = "\n"
if cusq1 ~= nil then
file:write(cusq1..myText)
file:write(cusa1..myText)

if cusq2 ~= nil then
file:write(cusq2..myText)
file:write(cusa2..myText)

if cusq3 ~= nil then
file:write(cusq3..myText)
file:write(cusa3..myText)

if cusq5 ~= nil then
file:write(cusq5..myText)
file:write(cusa5..myText)

if cusq6 ~= nil then
file:write(cusq6..myText)
file:write(cusa6..myText)

if cusq7 ~= nil then
file:write(cusq7..myText)
file:write(cusa7..myText)

if cusq8 ~= nil then
file:write(cusq8..myText)
file:write(cusa8..myText)

if cusq9 ~= nil then
file:write(cusq9..myText)
file:write(cusa9..myText)

if cusq10 ~= nil then
file:write(cusq10..myText)
file:write(cusa10..myText)
end
end
end
end
end
end
end
end
end
file:close()
end


if pad:cross() and oldpad:cross() ~=pad:cross() and menu1 == 10
then
file = io.open("write.txt", "w+") 
myText = "\n"
if cusq1 ~= nil then
file:write(cusq1..myText)
file:write(cusa1..myText)

if cusq2 ~= nil then
file:write(cusq2..myText)
file:write(cusa2..myText)

if cusq3 ~= nil then
file:write(cusq3..myText)
file:write(cusa3..myText)

if cusq4 ~= nil then
file:write(cusq4..myText)
file:write(cusa4..myText)

if cusq6 ~= nil then
file:write(cusq6..myText)
file:write(cusa6..myText)

if cusq7 ~= nil then
file:write(cusq7..myText)
file:write(cusa7..myText)

if cusq8 ~= nil then
file:write(cusq8..myText)
file:write(cusa8..myText)

if cusq9 ~= nil then
file:write(cusq9..myText)
file:write(cusa9..myText)

if cusq10 ~= nil then
file:write(cusq10..myText)
file:write(cusa10..myText)
end
end
end
end
end
end
end
end
end
file:close()
end


if pad:cross() and oldpad:cross() ~=pad:cross() and menu1 == 11
then
file = io.open("write.txt", "w+") 
myText = "\n"
if cusq1 ~= nil then
file:write(cusq1..myText)
file:write(cusa1..myText)

if cusq2 ~= nil then
file:write(cusq2..myText)
file:write(cusa2..myText)

if cusq3 ~= nil then
file:write(cusq3..myText)
file:write(cusa3..myText)

if cusq4 ~= nil then
file:write(cusq4..myText)
file:write(cusa4..myText)

if cusq5 ~= nil then
file:write(cusq5..myText)
file:write(cusa5..myText)

if cusq7 ~= nil then
file:write(cusq7..myText)
file:write(cusa7..myText)

if cusq8 ~= nil then
file:write(cusq8..myText)
file:write(cusa8..myText)

if cusq9 ~= nil then
file:write(cusq9..myText)
file:write(cusa9..myText)

if cusq10 ~= nil then
file:write(cusq10..myText)
file:write(cusa10..myText)
end
end
end
end
end
end
end
end
end
file:close()
end


if pad:cross() and oldpad:cross() ~=pad:cross() and menu1 == 12
then
file = io.open("write.txt", "w+") 
myText = "\n"
if cusq1 ~= nil then
file:write(cusq1..myText)
file:write(cusa1..myText)

if cusq2 ~= nil then
file:write(cusq2..myText)
file:write(cusa2..myText)

if cusq3 ~= nil then
file:write(cusq3..myText)
file:write(cusa3..myText)

if cusq4 ~= nil then
file:write(cusq4..myText)
file:write(cusa4..myText)

if cusq5 ~= nil then
file:write(cusq5..myText)
file:write(cusa5..myText)

if cusq6 ~= nil then
file:write(cusq6..myText)
file:write(cusa6..myText)

if cusq8 ~= nil then
file:write(cusq8..myText)
file:write(cusa8..myText)

if cusq9 ~= nil then
file:write(cusq9..myText)
file:write(cusa9..myText)

if cusq10 ~= nil then
file:write(cusq10..myText)
file:write(cusa10..myText)
end
end
end
end
end
end
end
end
end
file:close()
end


if pad:cross() and oldpad:cross() ~=pad:cross() and menu1 == 13
then
file = io.open("write.txt", "w+") 
myText = "\n"
if cusq1 ~= nil then
file:write(cusq1..myText)
file:write(cusa1..myText)

if cusq2 ~= nil then
file:write(cusq2..myText)
file:write(cusa2..myText)

if cusq3 ~= nil then
file:write(cusq3..myText)
file:write(cusa3..myText)

if cusq4 ~= nil then
file:write(cusq4..myText)
file:write(cusa4..myText)

if cusq5 ~= nil then
file:write(cusq5..myText)
file:write(cusa5..myText)

if cusq6 ~= nil then
file:write(cusq6..myText)
file:write(cusa6..myText)

if cusq7 ~= nil then
file:write(cusq7..myText)
file:write(cusa7..myText)

if cusq9 ~= nil then
file:write(cusq9..myText)
file:write(cusa9..myText)

if cusq10 ~= nil then
file:write(cusq10..myText)
file:write(cusa10..myText)
end
end
end
end
end
end
end
end
end
file:close()
end

if pad:cross() and oldpad:cross() ~=pad:cross() and menu1 == 14
then
file = io.open("write.txt", "w+") 
myText = "\n"
if cusq1 ~= nil then
file:write(cusq1..myText)
file:write(cusa1..myText)

if cusq2 ~= nil then
file:write(cusq2..myText)
file:write(cusa2..myText)

if cusq3 ~= nil then
file:write(cusq3..myText)
file:write(cusa3..myText)

if cusq4 ~= nil then
file:write(cusq4..myText)
file:write(cusa4..myText)

if cusq5 ~= nil then
file:write(cusq5..myText)
file:write(cusa5..myText)

if cusq6 ~= nil then
file:write(cusq6..myText)
file:write(cusa6..myText)

if cusq7 ~= nil then
file:write(cusq7..myText)
file:write(cusa7..myText)

if cusq8 ~= nil then
file:write(cusq8..myText)
file:write(cusa8..myText)

if cusq10 ~= nil then
file:write(cusq10..myText)
file:write(cusa10..myText)

end
end
end
end
end
end
end
end
end
file:close()
end

if pad:cross() and oldpad:cross() ~=pad:cross() and menu1 == 15
then
file = io.open("write.txt", "w+") 
myText = "\n"
if cusq1 ~= nil then
file:write(cusq1..myText)
file:write(cusa1..myText)

if cusq2 ~= nil then
file:write(cusq2..myText)
file:write(cusa2..myText)

if cusq3 ~= nil then
file:write(cusq3..myText)
file:write(cusa3..myText)

if cusq4 ~= nil then
file:write(cusq4..myText)
file:write(cusa4..myText)

if cusq5 ~= nil then
file:write(cusq5..myText)
file:write(cusa5..myText)

if cusq6 ~= nil then
file:write(cusq6..myText)
file:write(cusa6..myText)

if cusq7 ~= nil then
file:write(cusq7..myText)
file:write(cusa7..myText)

if cusq8 ~= nil then
file:write(cusq8..myText)
file:write(cusa8..myText)

if cusq9 ~= nil then
file:write(cusq9..myText)
file:write(cusa9..myText)

end
end
end
end
end
end
end
end
end
file:close()
end



if mode2 == 1 then mode2 = 1
elseif mode2 == 2 then mode2 = 2
else mode2 = 1
end

if pad:cross() and oldpad:cross() ~=pad:cross() and menu1 == 4 and cusq1 ~= nil and cusa1 ~= nil
then dofile("./z.custom/customb.lua")
end

screen.waitVblankStart()
oldpad = pad
screen.flip()

end


