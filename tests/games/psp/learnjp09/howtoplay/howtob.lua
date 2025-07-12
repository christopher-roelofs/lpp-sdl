howto = Image.load("howtoplay/background.png")

oldpad = pad


while true do
System.draw()
screen:clear()
   screen:blit(0, 0, howto) 

System.endDraw()

pad = Controls.read()


if pad:triangle() and pad:triangle() ~= oldpad:triangle() 
then 
howto:free()
break 
end


screen.flip()
screen.waitVblankStart()
oldpad = pad
end










