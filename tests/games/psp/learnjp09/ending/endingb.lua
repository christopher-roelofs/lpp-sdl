mitsuki = Image.load("ending/mitsuki.png")
Ogg.load("ending/end.ogg", 0)
white = Color.new(255, 255, 255)
black = Color.new(0, 0, 0)
font = IntraFont.load("font.pgf", 0) 
font:setStyle(0.5, white, blue, IntraFont.CACHE_ALL);

ending = 1
loopCount = 0
weez = 1
edx = 150
edy = 272
scroll = 0



while true do
oldpad = pad
pad = Controls.read()
System.draw()
screen:clear()
 

screen:blit(0, 70, mitsuki)

font:print(edx, edy, "Thank you for Playing")



	      

if scroll <= 0 and edy >= 80 then edy = edy - 1
end 		

if scroll <= 0 then loopCount = loopCount + 1
elseif loopCount + 1 == 600 then loopCount = 600
end 		

if loopCount >= 300 then	
font:print(200, 103, "Developed by Ponlork Heng")	
end
		
		




if weez == 1 then
Ogg.play(false, 0)
end

if weez == 1 then weez = weez + 1
elseif weez == 3 then weez = 2
end		




if pad:r() and pad:triangle() ~= oldpad:triangle() 
then 
Ogg.unload(0)
mitsuki:free()
dofile("menu.LUA")
break 
end




System.endDraw()
screen.flip()
screen.waitVblankStart()
oldpad = pad
end