optionbk = Image.load("options/background.png") 
nihongo = Image.load("options/nihongo.png") 

optionmenu = 1
cursor = 1
rename1 = 0
rename2 = 0

oldpad = pad


while true do
System.draw()
screen:clear()

screen:blit(0, 0, optionbk) 


if optionselect == 1 then optionselect = 1
elseif optionselect == 2 then optionselect = 2
else optionselect = 1
end
	

if optionselect == 2 then
screen:blit(154, 57, nihongo)
end
	
if optionselect <= 2 and optionmenu == 1 then
screen:blit(163, 93, dpad3, 0, 139, 109, 30, 3)
end

if optionmenu == 2 and cursor == 1 then
screen:blit(126, 131, dpad3, 0, 139, 109, 30, 3)
end

if optionmenu == 2 and cursor == 2 then
screen:blit(186, 131, dpad3, 0, 139, 109, 30, 3)
end

if optionmenu == 3 and cursor == 1 then
screen:blit(126, 161, dpad3, 0, 139, 109, 30, 3)
end

if optionmenu == 3 and cursor == 2 then
screen:blit(172, 161, dpad3, 0, 139, 109, 30, 3)
end

if optionmenu == 4 and cursor == 1 then
screen:blit(126, 194, dpad3, 0, 139, 109, 30, 3)
end

if optionmenu == 4 and cursor == 2 then
screen:blit(173, 194, dpad3, 0, 139, 109, 30, 3)
end


if rename1 == 2 then
screen:blit(50, 50, dpad3, 0, 0, 171, 293, 146)
font:print(101, 116, "Please restart the software")
end



if rename2 == 2 then
font:print(101, 116, "Please restart the software")
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

if pad:right() and oldpad:right() ~=pad:right() and optionmenu == 1 and optionselect == 1 then 
optionselect = 2
end


if pad:left() and oldpad:left() ~=pad:left() and optionmenu == 1 and optionselect == 2 then 
optionselect = 1
end


if pad:down() and oldpad:down() ~=pad:down() and optionmenu < 4 then 
optionmenu = optionmenu + 1
end

if pad:up() and oldpad:up() ~=pad:up() and optionmenu > 1 then 
optionmenu = optionmenu - 1
end


if pad:right() and oldpad:right() ~=pad:right() and optionmenu == 2 then 
cursor = cursor + 1
elseif cursor >= 2 then cursor = 2
end

if pad:left() and oldpad:left() ~=pad:left() and optionmenu == 2 then 
cursor = cursor - 1
elseif cursor <= 1 then cursor = 1
end

if pad:right() and oldpad:right() ~=pad:right() and optionmenu == 3 then 
cursor = cursor + 1
elseif cursor >= 2 then cursor = 2
end

if pad:left() and oldpad:left() ~=pad:left() and optionmenu == 3 then 
cursor = cursor - 1
elseif cursor <= 1 then cursor = 1
end


if pad:right() and oldpad:right() ~=pad:right() and optionmenu == 4 then 
cursor = cursor + 1
elseif cursor >= 2 then cursor = 2
end


if pad:left() and oldpad:left() ~=pad:left() and optionmenu == 4 then 
cursor = cursor - 1
elseif cursor <= 1 then cursor = 1
end



if pad:cross() and optionmenu == 1 and optionselect == 1 
then nippon = 0
mode2 = 1
end


if pad:cross() and optionmenu == 1 and optionselect == 2 
then nippon = 1
mode2 = 1
end

if pad:cross() and optionmenu == 2 and cursor == 1 
then
dofile("./save/save.lua") 
end

if pad:cross() and optionmenu == 2 and cursor == 2 
then
dofile("./save/delete.lua") 
end

if pad:cross() and optionmenu == 3 and cursor == 1 
then
randomnum = 1
end

if pad:cross() and optionmenu == 3 and cursor == 2 
then
randomnum = 0
end

if pad:cross() and optionmenu == 4 and cursor == 1 and modetype ~= 0
then
file = io.open("mdata.lua","w")
file:write("modetype = 0")
file:close()
rename1 = 1
modetype = 0
end

if pad:cross() and optionmenu == 4 and cursor == 2 and modetype ~= 1
then
file = io.open("mdata.lua","w")
file:write("modetype = 1")
file:close()
rename2 = 1
modetype = 1
end

if modetype == 0 and rename1 == 1 then
System.rename("EBOOT.PBP", "typeb.PBP") 
System.rename("typea.PBP", "EBOOT.PBP") 
rename1 = rename1 + 1
end

if modetype == 1 and rename2 == 1 then
System.rename("EBOOT.PBP", "typea.PBP") 
System.rename("typeb.PBP", "EBOOT.PBP") 
rename2 = rename2 + 1
end

if pad:r() and pad:triangle() ~= oldpad:triangle() and nippon == 0 then
optionselect = 1
optionbk:free()
nihongo:free()

break 
end

if pad:r() and pad:triangle() ~= oldpad:triangle() and nippon == 1 then
optionselect = 2
optionbk:free()
nihongo:free()
break 
end








screen.waitVblankStart()
oldpad = pad
screen.flip()
end