white = Color.new(255, 255, 255) 


oldpad = pad


while true do
screen:clear()
pad = Controls.read()

screen:print(10,236,"Please restart the softare",white)


if pad:cross() and oldpad:cross() ~=pad:cross() then
file = io.open("mdata.lua","w")
file:write("modetype = 0")
file:close()
System.rename("EBOOT.PBP", "typeb.PBP") 
System.rename("typea.PBP", "EBOOT.PBP") 
end




screen.waitVblankStart()

screen.flip()
oldpad = pad
end

