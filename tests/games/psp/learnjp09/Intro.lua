loopCount3 = 0
modetype = 1

activate = 0
prompt = 0
oggload = 0
skipintro = 0

while true do
oldpad = pad
pad = Controls.read()
System.draw()
screen:clear()


if modetype == 0 then modetype = 0
elseif modetype == 1 then modetype = 1
else modetype = 0
end


if activate == 1 then 
--System.draw()
loopCount3 = loopCount3 + 1 end

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

if modetype == 1 and activate == 0 and loopCount3 >= 0 and loopCount3 < 4 then 
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
elseif loopCount3 >= 4 and loopCount3 < 8 then 
screen:blit(0, 0, frame1, 0, 0, 272, 480, 240)
screen:blit(0, 240, frame1, 0, 480, 0, 32, 32)
screen:blit(32, 240, frame1, 0, 480, 32, 32, 32)
screen:blit(64, 240, frame1, 0, 480, 64, 32, 32)
screen:blit(96, 240, frame1, 0, 480, 96, 32, 32)
screen:blit(128, 240, frame1, 0, 480, 128, 32, 32)
screen:blit(160, 240, frame1, 0, 480, 160, 32, 32)
screen:blit(192, 240, frame1, 0, 480, 192, 32, 32)
screen:blit(224, 240, frame1, 0, 480, 224, 32, 32)
screen:blit(256, 240, frame1, 0, 480, 256, 32, 32)
screen:blit(288, 240, frame1, 0, 480, 288, 32, 32)
screen:blit(320, 240, frame1, 0, 480, 320, 32, 32)
screen:blit(352, 240, frame1, 0, 480, 352, 32, 32)
screen:blit(384, 240, frame1, 0, 480, 384, 32, 32)
screen:blit(416, 240, frame1, 0, 480, 416, 32, 32)
screen:blit(448, 240, frame1, 0, 480, 448, 32, 32)
elseif loopCount3 >= 8 and loopCount3 < 12 then 
screen:blit(0, 0, frame2, 0, 0, 0, 480, 272)
elseif loopCount3 >= 12 and loopCount3 < 16 then 
screen:blit(0, 0, frame2, 0, 0, 272, 480, 240)
screen:blit(0, 240, frame2, 0, 480, 0, 32, 32)
screen:blit(32, 240, frame2, 0, 480, 32, 32, 32)
screen:blit(64, 240, frame2, 0, 480, 64, 32, 32)
screen:blit(96, 240, frame2, 0, 480, 96, 32, 32)
screen:blit(128, 240, frame2, 0, 480, 128, 32, 32)
screen:blit(160, 240, frame2, 0, 480, 160, 32, 32)
screen:blit(192, 240, frame2, 0, 480, 192, 32, 32)
screen:blit(224, 240, frame2, 0, 480, 224, 32, 32)
screen:blit(256, 240, frame2, 0, 480, 256, 32, 32)
screen:blit(288, 240, frame2, 0, 480, 288, 32, 32)
screen:blit(320, 240, frame2, 0, 480, 320, 32, 32)
screen:blit(352, 240, frame2, 0, 480, 352, 32, 32)
screen:blit(384, 240, frame2, 0, 480, 384, 32, 32)
screen:blit(416, 240, frame2, 0, 480, 416, 32, 32)
screen:blit(448, 240, frame2, 0, 480, 448, 32, 32)
elseif loopCount3 >= 16 and loopCount3 < 20 then 
screen:blit(0, 0, frame3, 0, 0, 0, 480, 272)
elseif loopCount3 >= 20 and loopCount3 < 24 then 
screen:blit(0, 0, frame3, 0, 0, 272, 480, 240)
screen:blit(0, 240, frame3, 0, 480, 0, 32, 32)
screen:blit(32, 240, frame3, 0, 480, 32, 32, 32)
screen:blit(64, 240, frame3, 0, 480, 64, 32, 32)
screen:blit(96, 240, frame3, 0, 480, 96, 32, 32)
screen:blit(128, 240, frame3, 0, 480, 128, 32, 32)
screen:blit(160, 240, frame3, 0, 480, 160, 32, 32)
screen:blit(192, 240, frame3, 0, 480, 192, 32, 32)
screen:blit(224, 240, frame3, 0, 480, 224, 32, 32)
screen:blit(256, 240, frame3, 0, 480, 256, 32, 32)
screen:blit(288, 240, frame3, 0, 480, 288, 32, 32)
screen:blit(320, 240, frame3, 0, 480, 320, 32, 32)
screen:blit(352, 240, frame3, 0, 480, 352, 32, 32)
screen:blit(384, 240, frame3, 0, 480, 384, 32, 32)
screen:blit(416, 240, frame3, 0, 480, 416, 32, 32)
screen:blit(448, 240, frame3, 0, 480, 448, 32, 32)
elseif loopCount3 >= 24 and loopCount3 < 28 then 
screen:blit(0, 0, frame4, 0, 0, 0, 480, 272)
elseif loopCount3 >= 28 and loopCount3 < 32 then 
screen:blit(0, 0, frame4, 0, 0, 272, 480, 240)
screen:blit(0, 240, frame4, 0, 480, 0, 32, 32)
screen:blit(32, 240, frame4, 0, 480, 32, 32, 32)
screen:blit(64, 240, frame4, 0, 480, 64, 32, 32)
screen:blit(96, 240, frame4, 0, 480, 96, 32, 32)
screen:blit(128, 240, frame4, 0, 480, 128, 32, 32)
screen:blit(160, 240, frame4, 0, 480, 160, 32, 32)
screen:blit(192, 240, frame4, 0, 480, 192, 32, 32)
screen:blit(224, 240, frame4, 0, 480, 224, 32, 32)
screen:blit(256, 240, frame4, 0, 480, 256, 32, 32)
screen:blit(288, 240, frame4, 0, 480, 288, 32, 32)
screen:blit(320, 240, frame4, 0, 480, 320, 32, 32)
screen:blit(352, 240, frame4, 0, 480, 352, 32, 32)
screen:blit(384, 240, frame4, 0, 480, 384, 32, 32)
screen:blit(416, 240, frame4, 0, 480, 416, 32, 32)
screen:blit(448, 240, frame4, 0, 480, 448, 32, 32)
elseif loopCount3 >= 32 and loopCount3 < 36 then 
screen:blit(0, 0, frame5, 0, 0, 0, 480, 272)
elseif loopCount3 >= 36 and loopCount3 < 40 then 
screen:blit(0, 0, frame5, 0, 0, 272, 480, 240)
screen:blit(0, 240, frame5, 0, 480, 0, 32, 32)
screen:blit(32, 240, frame5, 0, 480, 32, 32, 32)
screen:blit(64, 240, frame5, 0, 480, 64, 32, 32)
screen:blit(96, 240, frame5, 0, 480, 96, 32, 32)
screen:blit(128, 240, frame5, 0, 480, 128, 32, 32)
screen:blit(160, 240, frame5, 0, 480, 160, 32, 32)
screen:blit(192, 240, frame5, 0, 480, 192, 32, 32)
screen:blit(224, 240, frame5, 0, 480, 224, 32, 32)
screen:blit(256, 240, frame5, 0, 480, 256, 32, 32)
screen:blit(288, 240, frame5, 0, 480, 288, 32, 32)
screen:blit(320, 240, frame5, 0, 480, 320, 32, 32)
screen:blit(352, 240, frame5, 0, 480, 352, 32, 32)
screen:blit(384, 240, frame5, 0, 480, 384, 32, 32)
screen:blit(416, 240, frame5, 0, 480, 416, 32, 32)
screen:blit(448, 240, frame5, 0, 480, 448, 32, 32)
elseif loopCount3 >= 40 and loopCount3 < 44 then 
screen:blit(0, 0, frame6, 0, 0, 0, 480, 272)
elseif loopCount3 >= 44 and loopCount3 < 48 then 
screen:blit(0, 0, frame6, 0, 0, 272, 480, 240)
screen:blit(0, 240, frame6, 0, 480, 0, 32, 32)
screen:blit(32, 240, frame6, 0, 480, 32, 32, 32)
screen:blit(64, 240, frame6, 0, 480, 64, 32, 32)
screen:blit(96, 240, frame6, 0, 480, 96, 32, 32)
screen:blit(128, 240, frame6, 0, 480, 128, 32, 32)
screen:blit(160, 240, frame6, 0, 480, 160, 32, 32)
screen:blit(192, 240, frame6, 0, 480, 192, 32, 32)
screen:blit(224, 240, frame6, 0, 480, 224, 32, 32)
screen:blit(256, 240, frame6, 0, 480, 256, 32, 32)
screen:blit(288, 240, frame6, 0, 480, 288, 32, 32)
screen:blit(320, 240, frame6, 0, 480, 320, 32, 32)
screen:blit(352, 240, frame6, 0, 480, 352, 32, 32)
screen:blit(384, 240, frame6, 0, 480, 384, 32, 32)
screen:blit(416, 240, frame6, 0, 480, 416, 32, 32)
screen:blit(448, 240, frame6, 0, 480, 448, 32, 32)
elseif loopCount3 >= 48 and loopCount3 < 52 then 
screen:blit(0, 0, frame7, 0, 0, 0, 480, 272)
elseif loopCount3 >= 52 and loopCount3 < 56 then 
screen:blit(0, 0, frame7, 0, 0, 272, 480, 240)
screen:blit(0, 240, frame7, 0, 480, 0, 32, 32)
screen:blit(32, 240, frame7, 0, 480, 32, 32, 32)
screen:blit(64, 240, frame7, 0, 480, 64, 32, 32)
screen:blit(96, 240, frame7, 0, 480, 96, 32, 32)
screen:blit(128, 240, frame7, 0, 480, 128, 32, 32)
screen:blit(160, 240, frame7, 0, 480, 160, 32, 32)
screen:blit(192, 240, frame7, 0, 480, 192, 32, 32)
screen:blit(224, 240, frame7, 0, 480, 224, 32, 32)
screen:blit(256, 240, frame7, 0, 480, 256, 32, 32)
screen:blit(288, 240, frame7, 0, 480, 288, 32, 32)
screen:blit(320, 240, frame7, 0, 480, 320, 32, 32)
screen:blit(352, 240, frame7, 0, 480, 352, 32, 32)
screen:blit(384, 240, frame7, 0, 480, 384, 32, 32)
screen:blit(416, 240, frame7, 0, 480, 416, 32, 32)
screen:blit(448, 240, frame7, 0, 480, 448, 32, 32)
end


if loopCount3 == 56 then
frame1:free()
frame2:free()
frame3:free()
frame4:free()
frame5:free()
frame6:free()
frame7:free()
dofile("menu.lua")
end



System.endDraw()
screen.flip()
screen.waitVblankStart()
oldpad = pad
end
