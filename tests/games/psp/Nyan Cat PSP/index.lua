--Nyan Cat PSP

--save files

file = io.open("saveone.txt", "r") 
s = file:read() 
file:close()

file = io.open("savetwo.txt", "r")
min = file:read()
file:close()

file = io.open("savethree.txt", "r")
hr = file:read()
file:close()

--variables and asset loading
c = 1
bg = 0
h = 0
m = 0
a = 1
t = 0
tt = 0
r = Color.new(255,0,0)
w = Color.new(255,255,255)
b = Color.new(100,100,255)
bl = Color.new(0,0,0)
tr = Color.new(0,0,0,0)
g = Color.new(0,255,0)
ifont = IntraFont.load("font.pgf", 1);
ifont:setStyle(1.0, b, r, IntraFont.ALIGN_CENTER);

cpu = IntraFont.load("font.pgf", 0);
cpu:setStyle(1.0, w, bl, IntraFont.ALIGN_RIGHT);

bat = IntraFont.load("font.pgf", 0);
bat:setStyle(1.0, g, tr , IntraFont.ALIGN_CENTER);

batt = IntraFont.load("font.pgf", 0);
batt:setStyle(1.0, g, b , IntraFont.ALIGN_LEFT);

nyan = IntraFont.load("font.pgf", 0);
nyan:setStyle(1.0, g, b, IntraFont.ALIGN_CENTER);

a1 = Image.load("images/1.png")
a2 = Image.load("images/2.png")
a3 = Image.load("images/3.png")
a4 = Image.load("images/4.png")
a5 = Image.load("images/5.png")
a6 = Image.load("images/6.png")
a7 = Image.load("images/7.png")
a8 = Image.load("images/8.png")
a9 = Image.load("images/9.png")
a10 = Image.load("images/10.png")
a11 = Image.load("images/11.png")
a12 = Image.load("images/12.png")
gen = Image.load("images/intro.png")

Mp3.load("song.mp3", 0)
Mp3.play(true, 0)
 

 
 while true do
 
 System.draw()

 --Data
 if t == 0 then
--save1
 file = io.open("saveone.txt", "w")
file:write(tt)
file:close()

file = io.open("savetwo.txt", "w")
file:write(m)
file:close()

file = io.open("savethree.txt", "w")
file:write(h)
file:close()
 
screen:blit(0, 0,gen)
 screen.flip()
 screen.waitVblankStart(210)
 screen:slowClear()
end
 --lua sound error workaround
  
pad = Controls.read()

if pad:start() and pad:select() then
bg = 2   
end

if bg >= 2 then
bg = bg + 2
end

if bg == 62 then

Mp3.load("song.mp3", 0)
Mp3.play(true, 0)
bg = 0

end
 
if pad:cross() and pad:left() then
System.setCpuSpeed(222) 
c = 1    
end

if pad:cross() and pad:right() then
System.setCpuSpeed(333)
c = 2 
end
 
 System.powerTick()
 
 --animation loop
 a = a + c

 
 if a == 1 then
 screen:blit(0, 0,a1)
 end
 
 if a == 2 then
 screen:blit(0, 0,a1)
 end
 
 if a == 3 then
 screen:blit(0, 0,a1)
 end
 
 if a == 4 then
 screen:blit(0, 0,a1)
 end
 
 if a == 5 then
 screen:blit(0, 0,a2)
 end
 
 if a == 6 then
 screen:blit(0, 0,a2)
 end
 
 if a == 7 then
 screen:blit(0, 0,a2)
 end
 
 if a == 8 then
 screen:blit(0, 0,a2)
 end
 
 if a == 9 then
 screen:blit(0, 0,a3)
 end
 
 if a == 10 then
 screen:blit(0, 0,a3)
 end
 
 if a == 11 then
 screen:blit(0, 0,a3)
 end
 
 if a == 12 then
 screen:blit(0, 0,a3)
 end
 
 if a == 13 then
 screen:blit(0, 0,a4)
 end
 
 if a == 14 then
 screen:blit(0, 0,a4)
 end
 
 if a == 15 then
 screen:blit(0, 0,a4)
 end
 
 if a == 16 then
 screen:blit(0, 0,a4)
 end
 
 if a == 17 then
 screen:blit(0, 0,a5)
 end
 
 if a == 18 then
 screen:blit(0, 0,a5)
 end
 
 if a == 19 then
 screen:blit(0, 0,a5)
 end
 
 if a == 20 then
 screen:blit(0, 0,a5)
 end
 
 if a == 21 then
 screen:blit(0, 0,a6)
 end
 
 if a == 22 then
 screen:blit(0, 0,a6)
 end
 
 if a == 23 then
 screen:blit(0, 0,a6)
 end
 
 if a == 24 then
 screen:blit(0, 0,a6)
 end
 
 if a == 25 then
 screen:blit(0, 0,a7)
 end
 
 if a == 26 then
 screen:blit(0, 0,a7)
 end
 
 if a == 27 then
 screen:blit(0, 0,a7)
 end
 
 if a == 28 then
 screen:blit(0, 0,a7)
 end
 
 if a == 29 then
 screen:blit(0, 0,a8)
 end
 
 if a == 30 then
 screen:blit(0, 0,a8)
 end
 
 if a == 31 then
 screen:blit(0, 0,a8)
 end
 
 if a == 32 then
 screen:blit(0, 0,a8)
 end
 
 if a == 33 then
 screen:blit(0, 0,a9)
 end
 
 if a == 34 then
 screen:blit(0, 0,a9)
 end
 
 if a == 35 then
 screen:blit(0, 0,a9)
 end
 
 if a == 36 then
 screen:blit(0, 0,a9)
 end
 
 if a == 37 then
 screen:blit(0, 0,a10)
 end
 
 if a == 38 then
 screen:blit(0, 0,a10)
 end
 
 if a == 39 then
 screen:blit(0, 0,a10)
 end
 
 if a == 40 then
 screen:blit(0, 0,a10)
 end
 
 if a == 41 then
 screen:blit(0, 0,a11)
 end
 
 if a == 42 then
 screen:blit(0, 0,a11)
 end
 
 if a == 43 then
 screen:blit(0, 0,a11)
 end
 
 if a == 44 then
 screen:blit(0, 0,a11)
 end
 
 if a == 45 then
 screen:blit(0, 0,a12)
 end
 
 if a == 46 then
 screen:blit(0, 0,a12)
 end
 
 if a == 47 then
 screen:blit(0, 0,a12)
 end
 
 if a == 48 then
 screen:blit(0, 0,a12)
 a = 1
 end
 
 if a == 49 then
 screen:blit(0, 0,a12)
 a = 1
 end
 --just in case
 if a == 50 then
 a = 1
 end
 if a == 51 then
 a = 1
 end
 if a == 52 then
 a = 1
 end
 

--time engine
 
 t = t + 1
 if t % 60 == 0 then
 tt = tt + 1
 end 
 
 if tt == 60 then
 tt = 0
 end
 
 if m == 60 then
 m = 0
 end
 
 if t % 216000 == 0 then
 h = h + 1
 end
 
 if t % 3600 == 0 then
 m = m + 1
 end
 

--text output


bat:print(245, 15,"Go Nyan Go!")
bat:print(245, 25,"by FouadtjuhMaster")
bat:print(245, 35,"")
 

if c == 1 then 
 cpu:print(479, 10,"")
 
end

if c == 2 then 
 cpu:print(479, 10,"")
end 
 
batt:print(10, 235,"")
batt:print(10, 250,"")
batt:print(10, 260,"")
batt:print(10, 270,"")
batt:print(75, 250,"")
batt:print(75, 260,"")
batt:print(75, 270,"")

per = System.powerGetBatteryLifePercent()
ifont:print(245,258,"")
ifont:print(260,270,"")
ifont:print(235,270,"")



batt:print(390, 235,"")
batt:print(390, 250,"")
batt:print(390, 260,"")
batt:print(390, 270,"")
batt:print(443, 250,"")
batt:print(443, 260,"")
batt:print(443, 270,"")
System.endDraw()

screen.flip()
 screen:clear()
--save2

if t % 18000 == 0 then
file = io.open("saveone.txt", "w")
file:write(tt)
file:close()

file = io.open("savetwo.txt", "w")
file:write(m)
file:close()

file = io.open("savethree.txt", "w")
file:write(h)
file:close()

--time correction
t = t + 30

end
 
 end
 