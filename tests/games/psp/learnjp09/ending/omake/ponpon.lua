ponlork = Image.load("ending/omake/msg.png")



while true do

        screen:clear()

screen:blit(0, 0, ponlork)

pad = Controls.read()

if pad:circle() and oldpad:circle() ~=pad:circle() then
System.playMP4("ending/omake/nanikore.mp4", 0)
end

if pad:square() and oldpad:square() ~=pad:square() and renamepon == 1 then
Mp3.stop(0)
ponlork = nil
collectgarbage()
dofile("menu.lua")
end

screen.flip();
screen.waitVblankStart()
oldpad = pad   
end
