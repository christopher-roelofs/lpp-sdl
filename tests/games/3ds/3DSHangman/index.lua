giallo = Color.new (255,255,255)
rosso = Color.new(255,0,0)
if System.isGWMode() then
	System.currentDirectory("")
end
stat1 = Screen.loadImage(System.currentDirectory().."/STATO1.png")
stat2 = Screen.loadImage(System.currentDirectory().."/STATO2.png")
stat3 = Screen.loadImage(System.currentDirectory().."/STATO3.png")
stat4 = Screen.loadImage(System.currentDirectory().."/STATO4.png")
stat5 = Screen.loadImage(System.currentDirectory().."/STATO5.png")
stat6 = Screen.loadImage(System.currentDirectory().."/STATO6.png")
stat7 = Screen.loadImage(System.currentDirectory().."/STATO7.png")
number = 1
maxnumber = 3
function GarbageCollection()
	Screen.freeImage(stat1)
	Screen.freeImage(stat2)
	Screen.freeImage(stat3)
	Screen.freeImage(stat4)
	Screen.freeImage(stat5)
	Screen.freeImage(stat6)
	Screen.freeImage(stat7)
end
go = 0
oldpad = Controls.read()
while true do
Controls.init()
Screen.refresh()
Screen.clear(TOP_SCREEN)
pad = Controls.read()
if Controls.check(pad,KEY_DUP) and not Controls.check(oldpad,KEY_DUP) then
number = number - 1
end
if Controls.check(pad,KEY_DDOWN) and not Controls.check(oldpad,KEY_DDOWN) then
number = number + 1
end
if number > maxnumber then
number = 1
end
if number <= 0 then
number = maxnumber
end
Screen.clear(BOTTOM_SCREEN)
mc = {giallo,giallo,giallo}
mc[number] = rosso
Screen.debugPrint(0,0,"3DS Hangman v.1.0",rosso,BOTTOM_SCREEN)
Screen.debugPrint(0,50,"New Game",mc[1],BOTTOM_SCREEN)
Screen.debugPrint(0,65,"Add word to database",mc[2],BOTTOM_SCREEN)
Screen.debugPrint(0,80,"Exit Game",mc[3],BOTTOM_SCREEN)
if go == 1 then
dofile(System.currentDirectory().."/GIOCO.LUA")
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 1 then
go = 1
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 2 then
word = System.startKeyboard("MyWord")
database = io.open(System.currentDirectory().."/WORDS.TXT",FWRITE)
offset = io.size(database)
io.write(database,offset,"\nAddWord(\""..word.."\")",string.len(word)+12) 
io.close(database)
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) and number == 3 then
GarbageCollection()
System.exit()
end
Screen.flip()
Screen.waitVblankStart()
oldpad = pad
end
