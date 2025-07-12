Mp3.stop(0)
haruhibg = Image.load("karaoke/haruhibg.png")
collectgarbage()

select = 0



while true do
screen:clear()
System.draw()
        screen:blit(0, 0, haruhibg)



pad = Controls.read()

font:setStyle(0.5, blue, transparent, IntraFont.ALIGN_LEFT);
font:print(50, 50, "Hare Hare Yukai (TV-Size)")

font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(100, 100, "learn lyrics")

font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(100, 120, "Play Karaoke")

font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(100, 140, "Watch Video")

font:setStyle(0.5, white, transparent, IntraFont.ALIGN_LEFT);
font:print(100, 180, "Main Menu")




if select == 1 then
font:setStyle(0.5, pink, transparent, IntraFont.ALIGN_LEFT);
font:print(100, 100, "learn lyrics")
end



if select == 2 then
font:setStyle(0.5, pink, transparent, IntraFont.ALIGN_LEFT);
font:print(100, 120, "Play Karaoke")
end



if select == 3 then 
font:setStyle(0.5, pink, transparent, IntraFont.ALIGN_LEFT);
font:print(100, 140, "Watch Video")
font:setStyle(0.5, silver, transparent, IntraFont.ALIGN_LEFT);
font:print(220, 30, "MP4 playback only works on Ver 0.9A")
font:setStyle(0.5, silver, transparent, IntraFont.ALIGN_LEFT);
font:print(234, 50, "You can switch to it in the options menu")
end



if select == 4 then 
font:setStyle(0.5, pink, transparent, IntraFont.ALIGN_LEFT);
font:print(100, 180, "Main Menu")
end





if pad:down() and oldpad:down() ~=pad:down() and select < 4 then
select = select + 1
end

if pad:up() and oldpad:up() ~=pad:up() and select > 1 then
select = select - 1
end


if pad:cross() and oldpad:cross() ~=pad:cross() and select == 1 then
collectgarbage()
dofile("karaoke/lyrics/lyricsb.lua")
end




if pad:cross() and oldpad:cross() ~=pad:cross() and select == 2 then
collectgarbage()
dofile("karaoke/karaoke.lua")
end




if pad:cross() and oldpad:cross() ~=pad:cross() and select == 3 then
collectgarbage()
dofile("karaoke/mp4.lua")
end




if pad:cross() and oldpad:cross() ~=pad:cross() and select == 4 then
haruhibg:free()
load = 0
collectgarbage()
dofile("menu.lua")
end







System.endDraw()
screen.flip()
screen.waitVblankStart()
oldpad = pad
end