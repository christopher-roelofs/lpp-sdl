giallo = Color.new (0,0,0)
rosso = Color.new(255,0,0)
bianco = Color.new(255,255,255)
dofile(System.currentDirectory().."/background.db")
dofile(System.currentDirectory().."/language.db")
dofile(System.currentDirectory().."/music.db")
dofile(System.currentDirectory().."/sound.db")
if (submusic == 1) then
if (initialized == nil) then
Sound.init()
initialized = 1
end
if not (sound == "dis") then
if (initialized == 1) then
bgsound = Sound.openWav(System.currentDirectory().."/"..sound..".wav")
Sound.playWav(bgsound,LOOP,0x08)
initialized = 2
end
end
end
mus1  = Screen.loadBitmap(System.currentDirectory().."/nomusic.bmp")
mus2  = Screen.loadBitmap(System.currentDirectory().."/smt.bmp")
mus3  = Screen.loadBitmap(System.currentDirectory().."/relax.bmp")
tav1  = Screen.loadBitmap(System.currentDirectory().."/bg1ante.bmp")
tav2  = Screen.loadBitmap(System.currentDirectory().."/bg2ante.bmp")
tav3  = Screen.loadBitmap(System.currentDirectory().."/bg3ante.bmp")
tav4  = Screen.loadBitmap(System.currentDirectory().."/bg4ante.bmp")
tav5  = Screen.loadBitmap(System.currentDirectory().."/bg5ante.bmp")
sfondo = Screen.loadBitmap(System.currentDirectory().."/BG/th_bg"..backscreen..".bmp")
sfondo2 = Screen.loadBitmap(System.currentDirectory().."/BG/th2_th_bg"..backscreen..".bmp")
napoli = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari10 [Carte].bmp")
piacenza = Screen.loadBitmap(System.currentDirectory().."/PIA/Denari10 [Carte].bmp")
sicilia = Screen.loadBitmap(System.currentDirectory().."/SIC/Denari10 [Carte].bmp")
bergamo = Screen.loadBitmap(System.currentDirectory().."/BER/Denari10 [Carte].bmp")
roma = Screen.loadBitmap(System.currentDirectory().."/ROM/Denari10 [Carte].bmp")
poker = Screen.loadBitmap(System.currentDirectory().."/POK/Denari10 [Carte].bmp")
poker2 = Screen.loadBitmap(System.currentDirectory().."/PO2/Denari10 [Carte].bmp")
sardegna = Screen.loadBitmap(System.currentDirectory().."/SAR/Denari10 [Carte].bmp")
function Purge()
Screen.freeImage(mus1)
Screen.freeImage(mus2)
Screen.freeImage(mus3)
Screen.freeImage(tav1)
Screen.freeImage(tav2)
Screen.freeImage(tav3)
Screen.freeImage(tav4)
Screen.freeImage(tav5)
Screen.freeImage(sfondo)
Screen.freeImage(sfondo2)
Screen.freeImage(napoli)
Screen.freeImage(piacenza)
Screen.freeImage(sicilia)
Screen.freeImage(bergamo)
Screen.freeImage(roma)
Screen.freeImage(poker)
Screen.freeImage(poker2)
Screen.freeImage(sardegna)
end
dofile(System.currentDirectory().."/point.db")
dofile(System.currentDirectory().."/fix.db")
number = 1
maxnumber = 5
go = 0
extra = 0
oldpad = Controls.read()
function printc(x,y,image,color)
Screen.debugPrint(x,y,image,color,TOP_SCREEN)
end
while true do
Screen.waitVblankStart()
Screen.refresh()
Controls.init()
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
if extra == 0 then
maxnumber=5
if Controls.check(pad,KEY_A) and number == 1 and not Controls.check(oldpad,KEY_A) then
extra = 10
end
if Controls.check(pad,KEY_A) and number == 2 and not Controls.check(oldpad,KEY_A) then
number = 1
extra = 20
end
if Controls.check(pad,KEY_A) and number == 3 and not Controls.check(oldpad,KEY_A) then
go = 7
end
if Controls.check(pad,KEY_A) and number == 4 and not Controls.check(oldpad,KEY_A) then
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 5 and not Controls.check(oldpad,KEY_A) then
if (submusic==1) then
Sound.term()
end
System.exit()
end
mc = {giallo,giallo,giallo,giallo,giallo}
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
Screen.fillEmptyRect(108, 280, 45, 175, giallo, TOP_SCREEN)
Screen.fillRect(109, 279, 46, 174, bianco, TOP_SCREEN)
mc[number] = rosso
Screen.debugPrint(110,48,"3DSBriscola v.1.0",rosso,TOP_SCREEN)
Screen.debugPrint(110,60,"by Rinnegatamante",rosso,TOP_SCREEN)
if lingua=="IT" then
Screen.debugPrint(110,100,"Giocatore Singolo",mc[1],TOP_SCREEN)
Screen.debugPrint(110,115,"Multigiocatore",mc[2],TOP_SCREEN)
Screen.debugPrint(110,130,"Tutorial",mc[3],TOP_SCREEN)
Screen.debugPrint(110,145,"Opzioni",mc[4],TOP_SCREEN)
Screen.debugPrint(110,160,"Esci dal Gioco",mc[5],TOP_SCREEN)
elseif lingua=="EN" then
Screen.debugPrint(110,100,"Single Player",mc[1],TOP_SCREEN)
Screen.debugPrint(110,115,"Multi Player",mc[2],TOP_SCREEN)
Screen.debugPrint(110,130,"Tutorial",mc[3],TOP_SCREEN)
Screen.debugPrint(110,145,"Settings",mc[4],TOP_SCREEN)
Screen.debugPrint(110,160,"Exit Game",mc[5],TOP_SCREEN)
end
elseif extra == 10 then
if Controls.check(pad,KEY_A) and number == 1 and not Controls.check(oldpad,KEY_A) then
go=1
end
if Controls.check(pad,KEY_A) and number == 2 and not Controls.check(oldpad,KEY_A) then
number = 1
extra = 0
end
mc = {giallo,giallo}
maxnumber = 2
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
mc[number] = rosso
Screen.fillEmptyRect(108, 280, 45, 130, giallo, TOP_SCREEN)
Screen.fillRect(109, 279, 46, 129, bianco, TOP_SCREEN)
Screen.debugPrint(110,48,"3DSBriscola v.1.0",rosso,TOP_SCREEN)
Screen.debugPrint(110,60,"by Rinnegatamante",rosso,TOP_SCREEN)
if lingua=="IT" then
Screen.debugPrint(110,100,"1 VS 1",mc[1],TOP_SCREEN)
Screen.debugPrint(110,115,"Torna Indietro",mc[2],TOP_SCREEN)
elseif lingua=="EN" then
Screen.debugPrint(110,100,"1 VS 1",mc[1],TOP_SCREEN)
Screen.debugPrint(110,115,"Go Back",mc[2],TOP_SCREEN)
end
elseif extra == 20 then
mc = {giallo,giallo}
maxnumber = 2
if Controls.check(pad,KEY_A) and number == 1 and not Controls.check(oldpad,KEY_A) then
go=5
end
if Controls.check(pad,KEY_A) and number == 2 and not Controls.check(oldpad,KEY_A) then
maxnumber = 5
number = 1
extra = 0
end
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
Screen.fillEmptyRect(108, 280, 45, 130, giallo, TOP_SCREEN)
Screen.fillRect(109, 279, 46, 129, bianco, TOP_SCREEN)
Screen.debugPrint(110,48,"3DSBriscola v.1.0",rosso,TOP_SCREEN)
Screen.debugPrint(110,60,"by Rinnegatamante",rosso,TOP_SCREEN)
mc[number] = rosso
if lingua == "IT" then
Screen.debugPrint(110,100,"Modalita' Locale",mc[1],TOP_SCREEN)
Screen.debugPrint(110,115,"Torna Indietro",mc[2],TOP_SCREEN)
end
if lingua == "EN" then
Screen.debugPrint(110,100,"Local Mode",mc[1], TOP_SCREEN)
Screen.debugPrint(110,115,"Go Back",mc[2], TOP_SCREEN)
end
elseif extra == 40 then
if Controls.check(pad,KEY_A) and number == 1 and not Controls.check(oldpad,KEY_A) then
number = 1
extra = 30
end
if Controls.check(pad,KEY_A) and number == 2 and not Controls.check(oldpad,KEY_A) then
number = 1
extra = 50
end
if Controls.check(pad,KEY_A) and number == 3 and not Controls.check(oldpad,KEY_A) then
number = 1
extra = 400
end
if Controls.check(pad,KEY_A) and number == 4 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/point.db",FWRITE)
if viewer == 0 then
io.write(file,0,"viewer = 1")
viewer = 1
else
io.write(file,0,"viewer = 0")
viewer = 0
end
io.close(file)
end
if Controls.check(pad,KEY_A) and number == 5 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/fix.db",FWRITE)
if fix == 0 then
io.write(file,0,"fix = 1")
fix = 1
else
io.write(file,0,"fix = 0")
fix = 0
end
io.close(file)
end
if Controls.check(pad,KEY_A) and number == 6 and not Controls.check(oldpad,KEY_A) then
if lingua == "IT" then
file = io.open(System.currentDirectory().."/language.db",FWRITE)
io.write(file,0,"lingua=\"EN\"")
lingua = "EN"
io.close(file)
else
file = io.open(System.currentDirectory().."/language.db",FWRITE)
io.write(file,0,"lingua=\"IT\"")
lingua = "IT"
io.close(file)
end
end
if Controls.check(pad,KEY_A) and number == 7 and not Controls.check(oldpad,KEY_A) then
if submusic == 1 then
file = io.open(System.currentDirectory().."/music.db",FWRITE)
io.write(file,0,"submusic=0")
submusic = 0
io.close(file)
if not (sound == "dis") then
Sound.pause(bgsound)
Sound.closeWav(bgsound)
end
Sound.term()
else
file = io.open(System.currentDirectory().."/music.db",FWRITE)
io.write(file,0,"submusic=1")
submusic = 1
Sound.init()
if not (sound == "dis") then
bgsound = Sound.openWav(System.currentDirectory().."/"..sound..".wav")
Sound.playWav(bgsound,LOOP,0x08)
end
io.close(file)
end
end
if Controls.check(pad,KEY_A) and number == 8 and not Controls.check(oldpad,KEY_A) then
maxnumber = 3
number = 1
extra = 0
end
mc = {giallo,giallo,giallo,giallo,giallo,giallo,giallo,giallo}
maxnumber = 8
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
Screen.fillEmptyRect(109, 370, 45, 220, giallo, TOP_SCREEN)
Screen.fillRect(110, 369, 46, 219, bianco, TOP_SCREEN)
mc[number] = rosso
Screen.debugPrint(110,48,"3DSBriscola v.1.0",rosso,TOP_SCREEN)
Screen.debugPrint(110,60,"by Rinnegatamante",rosso,TOP_SCREEN)
if lingua == "IT" then
Screen.debugPrint(110,100,"Selezione Mazzo",mc[1], TOP_SCREEN)
Screen.debugPrint(110,115,"Selezione Tavolo",mc[2], TOP_SCREEN)
Screen.debugPrint(110,130,"Selezione Musica",mc[3], TOP_SCREEN)
if viewer == 1 then
Screen.debugPrint(110,145,"Visuale Punteggio: Abilitato",mc[4], TOP_SCREEN)
else
Screen.debugPrint(110,145,"Visuale Punteggio: Disabilitato",mc[4], TOP_SCREEN)
end
if fix == 1 then
Screen.debugPrint(110,160,"Fix Poker: Abilitato",mc[5], TOP_SCREEN)
else
Screen.debugPrint(110,160,"Fix Poker: Disabilitato",mc[5], TOP_SCREEN)
end
Screen.debugPrint(110,175,"Lingua: Italiano",mc[6], TOP_SCREEN)
if submusic == 1 then
Screen.debugPrint(110,190,"Audio: Abilitato",mc[7], TOP_SCREEN)
else
Screen.debugPrint(110,190,"Audio: Disabilitato",mc[7], TOP_SCREEN)
end
end
if lingua == "EN" then
Screen.debugPrint(110,100,"Select Deck",mc[1], TOP_SCREEN)
Screen.debugPrint(110,115,"Select Table",mc[2], TOP_SCREEN)
Screen.debugPrint(110,130,"Select Music",mc[3], TOP_SCREEN)
if viewer == 1 then
Screen.debugPrint(110,145,"View Points: Enabled",mc[4], TOP_SCREEN)
else
Screen.debugPrint(110,145,"View Points: Disabled",mc[4], TOP_SCREEN)
end
if fix == 1 then
Screen.debugPrint(110,160,"Fix Poker: Enabled",mc[5], TOP_SCREEN)
else
Screen.debugPrint(110,160,"Fix Poker: Disabled",mc[5], TOP_SCREEN)
end
Screen.debugPrint(110,175,"Language: English",mc[6], TOP_SCREEN)
if submusic == 1 then
Screen.debugPrint(110,190,"Audio: Enabled",mc[7], TOP_SCREEN)
else
Screen.debugPrint(110,190,"Audio: Disabled",mc[7], TOP_SCREEN)
end
end
if number == 5 then
Screen.fillEmptyRect(3, 317, 3, 80, giallo,BOTTOM_SCREEN)
Screen.fillRect(4, 316, 4, 79, bianco,BOTTOM_SCREEN)
if lingua == "IT" then
Screen.debugPrint(5,5,"Il Fix Poker inverte le modalita' di",giallo,BOTTOM_SCREEN)
Screen.debugPrint(5,20,"vittoria e di punteggio delle",giallo,BOTTOM_SCREEN)
Screen.debugPrint(5,35,"carte 8 e 9. Se attivo, l'8 vale",giallo,BOTTOM_SCREEN)
Screen.debugPrint(5,50,"3 punti, il 9 vale 2 punti",giallo,BOTTOM_SCREEN)
Screen.debugPrint(5,65,"e l'8 e' piu grande del 9.",giallo,BOTTOM_SCREEN)
end
if lingua == "EN" then
Screen.debugPrint(5,5,"The Poker Fix reverses victory",giallo,BOTTOM_SCREEN)
Screen.debugPrint(5,20,"modes and scoring for number 8",giallo,BOTTOM_SCREEN)
Screen.debugPrint(5,35,"and 9 cards. If it's enabled,",giallo,BOTTOM_SCREEN)
Screen.debugPrint(5,50,"8 scores 3 points, 9 scores",giallo,BOTTOM_SCREEN)
Screen.debugPrint(5,65,"2 points and 8 is higher than 9.",giallo,BOTTOM_SCREEN)
end
end
if lingua == "IT" then
Screen.debugPrint(110,205,"Torna Indietro",mc[8], TOP_SCREEN)
end
if lingua == "EN" then
Screen.debugPrint(110,205,"Go Back",mc[8], TOP_SCREEN)
end
elseif extra == 400 then
if Controls.check(pad,KEY_A) and number == 1 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/sound.db",FWRITE)
io.write(file,0,"sound = \"dis\"")
sound = "dis"
if (submusic == 1) and not (sound == "dis") then
Sound.pause(bgsound)
Sound.closeWav(bgsound)
end
io.close(file)
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 2 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/sound.db",FWRITE)
io.write(file,0,"sound = \"smt\"")
if not (sound == "dis") then
Sound.pause(bgsound)
Sound.closeWav(bgsound)
end
if (submusic == 1) then
bgsound = Sound.openWav(System.currentDirectory().."/smt.wav")
Sound.playWav(bgsound,LOOP,0x08)
end
sound = "smt"
io.close(file)
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 3 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/sound.db",FWRITE)
io.write(file,0,"sound = \"sim\"")
if not (sound == "dis") then
Sound.pause(bgsound)
Sound.closeWav(bgsound)
end
if (submusic == 1) then
bgsound = Sound.openWav(System.currentDirectory().."/sim.wav")
Sound.playWav(bgsound,LOOP,0x08)
end
sound = "sim"
io.close(file)
number = 1
extra = 40
end
if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
number = 1
extra = 40
end
maxnumber = 3
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
Screen.fillEmptyRect(19, 398, 37, 225, giallo,TOP_SCREEN)
Screen.fillRect(20, 397, 38, 224, bianco,TOP_SCREEN)
mc[number] = rosso
if lingua == "IT" then
printc(40,50,"Selezione Musica",rosso)
printc(40,65,"Temi esistenti: " .. maxnumber,rosso)
if number == 1 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,mus1,TOP_SCREEN)
printc(160,140,"Nessun Tema",giallo)
printc(160,155,"Creato da Rinnegatamante",giallo)
end
if number == 2 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,mus2,TOP_SCREEN)
printc(160,140,"Tema Super Mario",giallo)
printc(160,155,"Creato da Rinnegatamante",giallo)
end
if number == 3 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,mus3,TOP_SCREEN)
printc(160,140,"Tema Relax",giallo)
printc(160,155,"Creato da Rinnegatamante",giallo)
end
printc(40,195,"Premi A per salvare le impostazioni",rosso)
printc(40,210,"Premi B per tornare indietro",rosso)
end
if lingua == "EN" then
printc(40,50,"Select Music",rosso)
printc(40,65,"Available Themes: " .. maxnumber,rosso)
if number == 1 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,mus1,TOP_SCREEN)
printc(160,140,"No Theme",giallo)
printc(160,155,"Created by Rinnegatamante",giallo)
end
if number == 2 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,mus2,TOP_SCREEN)
printc(160,140,"Super Mario Theme",giallo)
printc(160,155,"Created by Rinnegatamante",giallo)
end
if number == 3 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,mus3,TOP_SCREEN)
printc(160,140,"Relax Theme",giallo)
printc(160,155,"Created by Rinnegatamante",giallo)
end
printc(40,195,"Press A to save settings",rosso)
printc(40,210,"Press B to go back",rosso)
end
printc(295,180,number.."/"..maxnumber,giallo)
elseif extra == 50 then
if Controls.check(pad,KEY_A) and number == 1 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/background.db",FWRITE)
io.write(file,0,"backscreen = 1")
io.close(file)
Screen.freeImage(sfondo)
Screen.freeImage(sfondo2)
sfondo = Screen.loadBitmap(System.currentDirectory().."/BG/th_bg1.bmp")
sfondo2 = Screen.loadBitmap(System.currentDirectory().."/BG/th2_th_bg1.bmp")
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 2 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/background.db",FWRITE)
io.write(file,0,"backscreen = 2")
io.close(file)
Screen.freeImage(sfondo)
Screen.freeImage(sfondo2)
sfondo = Screen.loadBitmap(System.currentDirectory().."/BG/th_bg2.bmp")
sfondo2 = Screen.loadBitmap(System.currentDirectory().."/BG/th2_th_bg2.bmp")
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 3 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/background.db",FWRITE)
io.write(file,0,"backscreen = 3")
io.close(file)
Screen.freeImage(sfondo)
Screen.freeImage(sfondo2)
sfondo = Screen.loadBitmap(System.currentDirectory().."/BG/th_bg3.bmp")
sfondo2 = Screen.loadBitmap(System.currentDirectory().."/BG/th2_th_bg3.bmp")
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 4 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/background.db",FWRITE)
io.write(file,0,"backscreen = 4")
io.close(file)
Screen.freeImage(sfondo)
Screen.freeImage(sfondo2)
sfondo = Screen.loadBitmap(System.currentDirectory().."/BG/th_bg4.bmp")
sfondo2 = Screen.loadBitmap(System.currentDirectory().."/BG/th2_th_bg4.bmp")
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 5 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/background.db",FWRITE)
io.write(file,0,"backscreen = 5")
io.close(file)
Screen.freeImage(sfondo)
Screen.freeImage(sfondo2)
sfondo = Screen.loadBitmap(System.currentDirectory().."/BG/th_bg5.bmp")
sfondo2 = Screen.loadBitmap(System.currentDirectory().."/BG/th2_th_bg5.bmp")
number = 1
extra = 40
end
if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
number = 1
extra = 40
end
maxnumber = 5
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
Screen.fillEmptyRect(19, 398, 37, 225, giallo,TOP_SCREEN)
Screen.fillRect(20, 397, 38, 224, bianco,TOP_SCREEN)
mc[number] = rosso
if lingua == "IT" then
printc(40,50,"Selezione Tavolo",rosso)
printc(40,65,"Tavoli esistenti: " .. maxnumber,rosso)
if number == 1 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,tav1,TOP_SCREEN)
printc(160,140,"Tavolo Poker Base",giallo)
printc(160,155,"Creato da Rinnegatamante",giallo)
end
if number == 2 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,tav2,TOP_SCREEN)
printc(160,140,"Tavolo Legno Base",giallo)
printc(160,155,"Creato da Rinnegatamante",giallo)
end
if number == 3 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,tav3,TOP_SCREEN)
printc(160,140,"Tavolo Base Blu",giallo)
printc(160,155,"Creato da Brian User",giallo)
end
if number == 4 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,tav4,TOP_SCREEN)
printc(160,140,"Tavolo Base Viola",giallo)
printc(160,155,"Creato da Brian User",giallo)
end
if number == 5 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,tav5,TOP_SCREEN)
printc(160,140,"Tavolo Base Verde",giallo)
printc(160,155,"Creato da Brian User",giallo)
end
printc(40,195,"Premi A per salvare le impostazioni",rosso)
printc(40,210,"Premi B per tornare indietro",rosso)
end
if lingua == "EN" then
printc(40,50,"Select Table",rosso)
printc(40,65,"Available Tables: " .. maxnumber,rosso)
if number == 1 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,tav1,TOP_SCREEN)
printc(160,140,"Standard Poker Table",giallo)
printc(160,155,"Created by Rinnegatamante",giallo)
end
if number == 2 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,tav2,TOP_SCREEN)
printc(160,140,"Standard Wood Table",giallo)
printc(160,155,"Created by Rinnegatamante",giallo)
end
if number == 3 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,tav3,TOP_SCREEN)
printc(160,140,"Standard Blue Table",giallo)
printc(160,155,"Created by Brian User",giallo)
end
if number == 4 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,tav4,TOP_SCREEN)
printc(160,140,"Standard Violet Table",giallo)
printc(160,155,"Created by Brian User",giallo)
end
if number == 5 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,tav5,TOP_SCREEN)
printc(160,140,"Standard Green Table",giallo)
printc(160,155,"Created by Brian User",giallo)
end
printc(40,195,"Press A to save settings",rosso)
printc(40,210,"Press B to go back",rosso)
end
printc(295,180,number.."/"..maxnumber,giallo)
elseif extra == 30 then
if Controls.check(pad,KEY_A) and number == 1 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/settings.db",FWRITE)
io.write(file,0,"napoli = \"NAP\"")
io.close(file)
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 2 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/settings.db",FWRITE)
io.write(file,0,"napoli = \"PIA\"")
io.close(file)
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 3 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/settings.db",FWRITE)
io.write(file,0,"napoli = \"SIC\"")
io.close(file)
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 4 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/settings.db",FWRITE)
io.write(file,0,"napoli = \"BER\"")
io.close(file)
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 5 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/settings.db",FWRITE)
io.write(file,0,"napoli = \"POK\"")
io.close(file)
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 2 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/settings.db",FWRITE)
io.write(file,0,"napoli = \"ROM\"")
io.close(file)
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 2 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/settings.db",FWRITE)
io.write(file,0,"napoli = \"SAR\"")
io.close(file)
number = 1
extra = 40
end
if Controls.check(pad,KEY_A) and number == 2 and not Controls.check(oldpad,KEY_A) then
file = io.open(System.currentDirectory().."/settings.db",FWRITE)
io.write(file,0,"napoli = \"PO2\"")
io.close(file)
number = 1
extra = 40
end
if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
number = 1
extra = 40
end
maxnumber = 8
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
Screen.fillEmptyRect(19, 398, 37, 225, giallo,TOP_SCREEN)
Screen.fillRect(20, 397, 38, 224, bianco,TOP_SCREEN)
mc[number] = rosso
if lingua == "IT" then
printc(40,45,"Selezione Mazzo",rosso)
printc(40,60,"Mazzi esistenti: " .. maxnumber,rosso)
if number == 1 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,napoli,TOP_SCREEN)
printc(160,140,"Set Napoletane",giallo)
printc(160,155,"Creato da Rinnegatamante",giallo)
end
if number == 2 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,piacenza,TOP_SCREEN)
printc(160,140,"Set Piacentine",giallo)
printc(160,155,"Creato da Rinnegatamante",giallo)
end
if number == 3 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,sicilia,TOP_SCREEN)
printc(160,140,"Set Siciliane",giallo)
printc(160,155,"Creato da shadow_95",giallo)
end
if number == 4 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,bergamo,TOP_SCREEN)
printc(160,140,"Set Bergamasche",giallo)
printc(160,155,"Creato da Simoncrue",giallo)
end
if number == 5 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,poker,TOP_SCREEN)
printc(160,140,"Set Poker #1",giallo)
printc(160,155,"Creato da Rinnegatamante",giallo)
end
if number == 6 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,roma,TOP_SCREEN)
printc(160,140,"Set Romagnole",giallo)
printc(160,155,"Creato da shadow_95",giallo)
end
if number == 7 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,sardegna,TOP_SCREEN)
printc(160,140,"Set Sarde",giallo)
printc(160,155,"Creato da Brian User",giallo)
end
if number == 8 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,poker2,TOP_SCREEN)
printc(160,140,"Set Poker #2",giallo)
printc(160,155,"Creato da Rinnegatamante",giallo)
end
printc(40,195,"Premi A per salvare le impostazioni",rosso)
printc(40,210,"Premi B per tornare indietro",rosso)
printc(295,180,number.."/"..maxnumber,giallo)
end
if lingua == "EN" then
printc(40,45,"Select Deck",rosso)
printc(40,60,"Available Decks: " .. maxnumber,rosso)
if number == 1 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,napoli,TOP_SCREEN)
printc(160,140,"Neapolitan Set",giallo)
printc(160,155,"Created by Rinnegatamante",giallo)
end
if number == 2 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,piacenza,TOP_SCREEN)
printc(160,140,"Piacenza's Set",giallo)
printc(160,155,"Created by Rinnegatamante",giallo)
end
if number == 3 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,sicilia,TOP_SCREEN)
printc(160,140,"Sicilian Set",giallo)
printc(160,155,"Created by shadow_95",giallo)
end
if number == 4 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,bergamo,TOP_SCREEN)
printc(160,140,"Bergamo's Set",giallo)
printc(160,155,"Created by Simoncrue",giallo)
end
if number == 5 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,poker,TOP_SCREEN)
printc(160,140,"Poker #1 Set",giallo)
printc(160,155,"Created by Rinnegatamante",giallo)
end
if number == 6 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,roma,TOP_SCREEN)
printc(160,140,"Roman Set",giallo)
printc(160,155,"Created by shadow_95",giallo)
end
if number == 7 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,sardegna,TOP_SCREEN)
printc(160,140,"Sardinian Set",giallo)
printc(160,155,"Created by Brian User",giallo)
end
if number == 8 then
Screen.fillEmptyRect(109, 158, 105, 185, giallo, TOP_SCREEN)
Screen.drawImage(110,106,poker2,TOP_SCREEN)
printc(160,140,"Poker #2 Set",giallo)
printc(160,155,"Created by Rinnegatamante",giallo)
end
printc(40,195,"Press A to save settings",rosso)
printc(40,210,"Premi B to go back",rosso)
printc(295,180,number.."/"..maxnumber,giallo)
end
end
if go == 2 then
Purge()
dofile(System.currentDirectory().."/1VS1.LUA")
end
if go == 1 then
Screen.fillEmptyRect(6,290,131,150,giallo,BOTTOM_SCREEN)
Screen.fillRect(7,289,132,149,bianco,BOTTOM_SCREEN)
if lingua == "IT" then
Screen.debugPrint(9,134,"Avvio partita in corso...",rosso,BOTTOM_SCREEN)
end
if lingua == "EN" then
Screen.debugPrint(9,134,"Please wait...",rosso,BOTTOM_SCREEN)
end
go = 2
end
if go == 6 then
Purge()
dofile(System.currentDirectory().."/LOCALE.LUA")
end
if go == 5 then
Screen.fillEmptyRect(6,290,131,150,giallo,BOTTOM_SCREEN)
Screen.fillRect(7,289,132,149,bianco,BOTTOM_SCREEN)
if lingua == "IT" then
Screen.debugPrint(9,134,"Avvio partita in corso...",rosso,BOTTOM_SCREEN)
end
if lingua == "EN" then
Screen.debugPrint(9,134,"Please wait...",rosso,BOTTOM_SCREEN)
end
go = 6
end
if go == 8 then
Purge()
dofile(System.currentDirectory().."/tutorial.lua")
end
if go == 7 then
Screen.fillEmptyRect(6,252,131,150,giallo,BOTTOM_SCREEN)
Screen.fillRect(7,251,132,149,bianco,BOTTOM_SCREEN)
if lingua == "IT" then
Screen.debugPrint(9,134,"Caricamento in corso...",rosso,BOTTOM_SCREEN)
end
if lingua == "EN" then
Screen.debugPrint(9,134,"Please wait...",rosso,BOTTOM_SCREEN)
end
go = 8
end
Screen.flip()
oldpad = pad
end