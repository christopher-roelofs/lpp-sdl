local a = 0
local b = 0
local c = 0
local d = 0
local e = 0
local f = 0
local g = 0
local h = 0

while true do
a = a + 0
b = b + 0
c = c + 0
d = d + 0
e = e + 1
f = f + 0
g = g + 33
h = g + 33

if e>=0 and e<=9 then
file = io.open("1Devoutput.lua","a")
file:write("elseif currentTime >= ",g," and currentTime <= ",h ," then","\n")
file:write('frame1 = Image.load("TOD/vlcsnap-',a,b,c,d,e,'.png")',"\n")
file:write("screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)","\n")
file:write("frame1:free()","\n")
file:close()
end

if e>=10 and e<=99 then
file = io.open("1Devoutput.lua","a")
file:write("elseif currentTime >= ",g," and currentTime <= ",h ," then","\n")
file:write('frame1 = Image.load("TOD/vlcsnap-',a,b,c,e,'.png")',"\n")
file:write("screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)","\n")
file:write("frame1:free()","\n")
file:close()
end

--if e>=100 and e<=999 then
if e>=100 and e<=345 then
file = io.open("1Devoutput.lua","a")
file:write("elseif currentTime >= ",g," and currentTime <= ",h ," then","\n")
file:write('frame1 = Image.load("TOD/vlcsnap-',a,b,e,'.png")',"\n")
file:write("screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)","\n")
file:write("frame1:free()","\n")
file:close()
end

--if e>=1000 and e<=1946 then
--file = io.open("1Devoutput.lua","a")
--file:write("elseif currentTime >= ",g," and currentTime <= ",h ," then","\n")
--file:write('frame1 = Image.load("TOD/vlcsnap-',a,e,'.png")',"\n")
--file:write("screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)","\n")
--file:write("frame1:free()","\n")
--file:close()
--end

--if e>=10000 and e<=99999 then
--file = io.open("1Devoutput.lua","a")
--file:write("elseif currentTime >= ",g," and currentTime <= ",h ," then","\n")
--file:write('frame1 = Image.load("WT/vlcsnap-',e,'.png")',"\n")
--file:write("screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)","\n")
--file:write("frame1:free()","\n")
--file:close()
--end

end







