Ogg.load("karaoke/ogg.ogg", 1)

reload = 0
oldpad = pad


function round(num,range) --range is optional. 1 is the defalt for range.
range = range or 1
if (num%range < range/2) then
return num-(num%range)
else 
return (num-(num%range))+range
end
end





while true do
System.draw()
screen:clear()


if n == nil then
n = 1
end

Ogg.speed(n,1)

pad = Controls.read()	

font:setStyle(0.5, white, transparent, IntraFont.ALIGN_CENTER);
font:print(240, 30, "Audio Speed: "..round(n*100).."%")

font:setStyle(0.5, blue, transparent, IntraFont.ALIGN_CENTER);
font:print(240, 40, "Left / Right to adjust audio speed")

font:setStyle(0.5, blue, transparent, IntraFont.ALIGN_CENTER);
font:print(240, 80, "Analog Up: harehareframes")

font:setStyle(0.5, white, transparent, IntraFont.ALIGN_CENTER);
font:print(240, 180, "Press O to play video")

font:setStyle(0.5, white, transparent, IntraFont.ALIGN_CENTER);
font:print(240, 190, "Reducing the audio speed may help sync the video better")

font:setStyle(0.5, white, transparent, IntraFont.ALIGN_CENTER);
font:print(240, 200, "Press Start to Reload MP4 Decoder (in case of crash)")

font:setStyle(0.5, blue, transparent, IntraFont.ALIGN_LEFT);
font:print(10, 260, "R+Triangle to Exit")



if pad:left() and oldpad:left() ~=pad:left() and n >= .70 then
n = n - .01
end


if pad:right() and oldpad:right() ~=pad:right() and n < 1 then
n = n + .01
end

if pad:circle() and oldpad:circle() ~=pad:circle() then
Ogg.play(false, 1)
System.playMP4("karaoke/harehare.mp4", 0)
Ogg.stop(1)
end

--
if pad:analogY() < -120 and pad:analogY() then
dofile("./harehareframes.lua")
end
--

if pad:start() and oldpad:start() ~=pad:start() then
file = io.open("sdata.lua","w")
file:write("videostart = 0")
file:close()
file = io.open("OGSPD.LUA","w")
file:write("n = "..n)
file:close()
--System.startPBP("ms0:/PSP/GAME/learnjp09/EBOOT.PBP")
System.startPBP("learnjp09/EBOOT.PBP")
--System.startPBP("learnjp09/typeb.PBP")

end




if pad:r() and pad:triangle() ~= oldpad:triangle() 
then 
collectgarbage()
dofile("karaoke/indexb.lua")
end




System.endDraw()
screen.flip()
screen.waitVblankStart()
oldpad = pad
end
