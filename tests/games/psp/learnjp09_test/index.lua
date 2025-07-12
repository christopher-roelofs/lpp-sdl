--System.setCpuSpeed(333)

--dofile("Dev/1Dev harehare.LUA")
--dofile("harehareframes.LUA")

Mp3.load("opmp3.mp3", 0)
White = Color.new(255, 255, 255)
silver = Color.new(192, 192, 192)
lightyellow = Color.new(250, 250, 210)
midnightblue = Color.new(25, 25, 112)
black = Color.new(0, 0, 0)
white = Color.new(255, 255, 255) 
blue = Color.new(100, 149, 237)
pink = Color.new(255, 0 , 153)
orange = Color.new(255, 228, 196)
pink2 = Color.new(255, 20, 147)
green = Color.new(60, 179, 113)
green2 = Color.new(108, 189, 124)
loopCount3 = 0


dofile("MDATA.LUA")
dofile("SDATA.LUA")
dofile("OGSPD.LUA")




activate = 0
prompt = 0
oggload = 0
skipintro = 0


--Mp3.speed(1,0)
Mp3.play(false, 0)

oldpad = pad






while true do
screen:clear()

pad = Controls.read()


if pad:r() and modetype ~= 1 and skipintro == 0 then
skipintro = 1
end

if modetype == 0 then modetype = 0
elseif modetype == 1 then modetype = 1
else modetype = 0
end

if modetype == 1 and activate == 0 then
frame1 = Image.load("tod1.png")
frame2 = Image.load("tod2.png")
frame3 = Image.load("tod3.png")
frame4 = Image.load("tod4.png")
frame5 = Image.load("tod5.png")
frame6 = Image.load("tod6.png")
frame7 = Image.load("tod7.png")
activate = 1

end

if activate == 1 then 
System.draw()
loopCount3 = loopCount3 + 1 end

if modetype == 1 and activate == 1 and loopCount3 >= 0 and loopCount3 < 4 then 
screen:blit(0, 0, frame1, false, 0, 0, 480, 272)
elseif loopCount3 >= 4 and loopCount3 < 8 then 
screen:blit(0, 0, frame1, false, 0, 272, 480, 240)
screen:blit(0, 240, frame1, false, 480, 0, 32, 32)
screen:blit(32, 240, frame1, false, 480, 32, 32, 32)
screen:blit(64, 240, frame1, false, 480, 64, 32, 32)
screen:blit(96, 240, frame1, false, 480, 96, 32, 32)
screen:blit(128, 240, frame1, false, 480, 128, 32, 32)
screen:blit(160, 240, frame1, false, 480, 160, 32, 32)
screen:blit(192, 240, frame1, false, 480, 192, 32, 32)
screen:blit(224, 240, frame1, false, 480, 224, 32, 32)
screen:blit(256, 240, frame1, false, 480, 256, 32, 32)
screen:blit(288, 240, frame1, false, 480, 288, 32, 32)
screen:blit(320, 240, frame1, false, 480, 320, 32, 32)
screen:blit(352, 240, frame1, false, 480, 352, 32, 32)
screen:blit(384, 240, frame1, false, 480, 384, 32, 32)
screen:blit(416, 240, frame1, false, 480, 416, 32, 32)
screen:blit(448, 240, frame1, false, 480, 448, 32, 32)
elseif loopCount3 >= 8 and loopCount3 < 12 then 
screen:blit(0, 0, frame2, false, 0, 0, 480, 272)
elseif loopCount3 >= 12 and loopCount3 < 16 then 
screen:blit(0, 0, frame2, false, 0, 272, 480, 240)
screen:blit(0, 240, frame2, false, 480, 0, 32, 32)
screen:blit(32, 240, frame2, false, 480, 32, 32, 32)
screen:blit(64, 240, frame2, false, 480, 64, 32, 32)
screen:blit(96, 240, frame2, false, 480, 96, 32, 32)
screen:blit(128, 240, frame2, false, 480, 128, 32, 32)
screen:blit(160, 240, frame2, false, 480, 160, 32, 32)
screen:blit(192, 240, frame2, false, 480, 192, 32, 32)
screen:blit(224, 240, frame2, false, 480, 224, 32, 32)
screen:blit(256, 240, frame2, false, 480, 256, 32, 32)
screen:blit(288, 240, frame2, false, 480, 288, 32, 32)
screen:blit(320, 240, frame2, false, 480, 320, 32, 32)
screen:blit(352, 240, frame2, false, 480, 352, 32, 32)
screen:blit(384, 240, frame2, false, 480, 384, 32, 32)
screen:blit(416, 240, frame2, false, 480, 416, 32, 32)
screen:blit(448, 240, frame2, false, 480, 448, 32, 32)
elseif loopCount3 >= 16 and loopCount3 < 20 then 
screen:blit(0, 0, frame3, false, 0, 0, 480, 272)
elseif loopCount3 >= 20 and loopCount3 < 24 then 
screen:blit(0, 0, frame3, false, 0, 272, 480, 240)
screen:blit(0, 240, frame3, false, 480, 0, 32, 32)
screen:blit(32, 240, frame3, false, 480, 32, 32, 32)
screen:blit(64, 240, frame3, false, 480, 64, 32, 32)
screen:blit(96, 240, frame3, false, 480, 96, 32, 32)
screen:blit(128, 240, frame3, false, 480, 128, 32, 32)
screen:blit(160, 240, frame3, false, 480, 160, 32, 32)
screen:blit(192, 240, frame3, false, 480, 192, 32, 32)
screen:blit(224, 240, frame3, false, 480, 224, 32, 32)
screen:blit(256, 240, frame3, false, 480, 256, 32, 32)
screen:blit(288, 240, frame3, false, 480, 288, 32, 32)
screen:blit(320, 240, frame3, false, 480, 320, 32, 32)
screen:blit(352, 240, frame3, false, 480, 352, 32, 32)
screen:blit(384, 240, frame3, false, 480, 384, 32, 32)
screen:blit(416, 240, frame3, false, 480, 416, 32, 32)
screen:blit(448, 240, frame3, false, 480, 448, 32, 32)
elseif loopCount3 >= 24 and loopCount3 < 28 then 
screen:blit(0, 0, frame4, false, 0, 0, 480, 272)
elseif loopCount3 >= 28 and loopCount3 < 32 then 
screen:blit(0, 0, frame4, false, 0, 272, 480, 240)
screen:blit(0, 240, frame4, false, 480, 0, 32, 32)
screen:blit(32, 240, frame4, false, 480, 32, 32, 32)
screen:blit(64, 240, frame4, false, 480, 64, 32, 32)
screen:blit(96, 240, frame4, false, 480, 96, 32, 32)
screen:blit(128, 240, frame4, false, 480, 128, 32, 32)
screen:blit(160, 240, frame4, false, 480, 160, 32, 32)
screen:blit(192, 240, frame4, false, 480, 192, 32, 32)
screen:blit(224, 240, frame4, false, 480, 224, 32, 32)
screen:blit(256, 240, frame4, false, 480, 256, 32, 32)
screen:blit(288, 240, frame4, false, 480, 288, 32, 32)
screen:blit(320, 240, frame4, false, 480, 320, 32, 32)
screen:blit(352, 240, frame4, false, 480, 352, 32, 32)
screen:blit(384, 240, frame4, false, 480, 384, 32, 32)
screen:blit(416, 240, frame4, false, 480, 416, 32, 32)
screen:blit(448, 240, frame4, false, 480, 448, 32, 32)
elseif loopCount3 >= 32 and loopCount3 < 36 then 
screen:blit(0, 0, frame5, false, 0, 0, 480, 272)
elseif loopCount3 >= 36 and loopCount3 < 40 then 
screen:blit(0, 0, frame5, false, 0, 272, 480, 240)
screen:blit(0, 240, frame5, false, 480, 0, 32, 32)
screen:blit(32, 240, frame5, false, 480, 32, 32, 32)
screen:blit(64, 240, frame5, false, 480, 64, 32, 32)
screen:blit(96, 240, frame5, false, 480, 96, 32, 32)
screen:blit(128, 240, frame5, false, 480, 128, 32, 32)
screen:blit(160, 240, frame5, false, 480, 160, 32, 32)
screen:blit(192, 240, frame5, false, 480, 192, 32, 32)
screen:blit(224, 240, frame5, false, 480, 224, 32, 32)
screen:blit(256, 240, frame5, false, 480, 256, 32, 32)
screen:blit(288, 240, frame5, false, 480, 288, 32, 32)
screen:blit(320, 240, frame5, false, 480, 320, 32, 32)
screen:blit(352, 240, frame5, false, 480, 352, 32, 32)
screen:blit(384, 240, frame5, false, 480, 384, 32, 32)
screen:blit(416, 240, frame5, false, 480, 416, 32, 32)
screen:blit(448, 240, frame5, false, 480, 448, 32, 32)
elseif loopCount3 >= 40 and loopCount3 < 44 then 
screen:blit(0, 0, frame6, false, 0, 0, 480, 272)
elseif loopCount3 >= 44 and loopCount3 < 48 then 
screen:blit(0, 0, frame6, false, 0, 272, 480, 240)
screen:blit(0, 240, frame6, false, 480, 0, 32, 32)
screen:blit(32, 240, frame6, false, 480, 32, 32, 32)
screen:blit(64, 240, frame6, false, 480, 64, 32, 32)
screen:blit(96, 240, frame6, false, 480, 96, 32, 32)
screen:blit(128, 240, frame6, false, 480, 128, 32, 32)
screen:blit(160, 240, frame6, false, 480, 160, 32, 32)
screen:blit(192, 240, frame6, false, 480, 192, 32, 32)
screen:blit(224, 240, frame6, false, 480, 224, 32, 32)
screen:blit(256, 240, frame6, false, 480, 256, 32, 32)
screen:blit(288, 240, frame6, false, 480, 288, 32, 32)
screen:blit(320, 240, frame6, false, 480, 320, 32, 32)
screen:blit(352, 240, frame6, false, 480, 352, 32, 32)
screen:blit(384, 240, frame6, false, 480, 384, 32, 32)
screen:blit(416, 240, frame6, false, 480, 416, 32, 32)
screen:blit(448, 240, frame6, false, 480, 448, 32, 32)
elseif loopCount3 >= 48 and loopCount3 < 52 then 
screen:blit(0, 0, frame7, false, 0, 0, 480, 272)
elseif loopCount3 >= 52 and loopCount3 < 56 then 
screen:blit(0, 0, frame7, false, 0, 272, 480, 240)
screen:blit(0, 240, frame7, false, 480, 0, 32, 32)
screen:blit(32, 240, frame7, false, 480, 32, 32, 32)
screen:blit(64, 240, frame7, false, 480, 64, 32, 32)
screen:blit(96, 240, frame7, false, 480, 96, 32, 32)
screen:blit(128, 240, frame7, false, 480, 128, 32, 32)
screen:blit(160, 240, frame7, false, 480, 160, 32, 32)
screen:blit(192, 240, frame7, false, 480, 192, 32, 32)
screen:blit(224, 240, frame7, false, 480, 224, 32, 32)
screen:blit(256, 240, frame7, false, 480, 256, 32, 32)
screen:blit(288, 240, frame7, false, 480, 288, 32, 32)
screen:blit(320, 240, frame7, false, 480, 320, 32, 32)
screen:blit(352, 240, frame7, false, 480, 352, 32, 32)
screen:blit(384, 240, frame7, false, 480, 384, 32, 32)
screen:blit(416, 240, frame7, false, 480, 416, 32, 32)
screen:blit(448, 240, frame7, false, 480, 448, 32, 32)

end


if modetype == 1 then
System.endDraw()
end


if loopCount3 == 56 then
frame1:free()
frame2:free()
frame3:free()
frame4:free()
frame5:free()
frame6:free()
frame7:free()
	collectgarbage("collect")
		collectgarbage()
	--dofile("menub.lua")
	dofile("menu.lua")
end


if n == nil and modetype ~= 1 then
n = 1
end


if videostart == 0 and oggload == 0 and modetype ~= 1 then
Ogg.load("karaoke/ogg.ogg", 1)
oggload = oggload + 1
end

Ogg.speed(n,1)

pad = Controls.read()


if videostart == 0 and modetype ~= 1 then
Mp3.stop(0)
Ogg.play(false, 1)
System.playMP4("karaoke/harehare.mp4", 0)
Ogg.stop(1)
videostart = 1
end

if modetype ~= 1 and videostart == 1 then
file = io.open("sdata.lua","w")
file:write("")
file:close()
videostart = 3
prompt = 1
end	

if modetype ~= 1 and prompt == 1 then
dofile("karaoke/mp4.lua")
end


if skipintro == 1 and modetype ~= 1 then
dofile("menu.lua")
skipintro = skipintro + 1
end

if modetype ~= 1 and videostart ~= 0 and videostart ~= 1 and prompt ~= 1 and skipintro ~= 1 then
dofile("Intro Video.lua")
end 

screen.flip()
screen.waitVblankStart()
  oldpad = pad
  
  
  
  
  
  
  
end
