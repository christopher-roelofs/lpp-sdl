giallo = Color.new (0,0,0)
rosso = Color.new(255,0,0)
bianco = Color.new(255,255,255)
dofile(System.currentDirectory().."/background.db")
sfondo = Screen.loadBitmap(System.currentDirectory().."/BG/th_bg"..backscreen..".bmp")
sfondo2 = Screen.loadBitmap(System.currentDirectory().."/BG/th2_th_bg"..backscreen..".bmp")
retro = Screen.loadBitmap(System.currentDirectory().."/retro.bmp")
oldpad = Controls.read()
dofile(System.currentDirectory().."/settings.db")
dofile(System.currentDirectory().."/language.db")
dofile(System.currentDirectory().."/point.db")
dofile(System.currentDirectory().."/fix.db")
numberz = 1
numeroan = 1
maxnumberz = 4
number = 1
maxnumber = 3
punti = 0
var = 0
mybestbriscola = 0
yourbestbriscola = 0
myloffabriscola = 90
yourloffabriscola = 90
myrealbestbriscola = 0
yourrealbestbriscola = 0
myrealloffabriscola = 0
yourrealloffabriscola = 0
mybestpresa = 0
yourbestpresa = 0
myprese = 0
yourprese = 0
peppe = 0
inizio2 = 0
base = 0
puntiavv = 0
inizio = 0
basegioco = 1
mycard = 0
yourcard = 0
enemycard = 0
mode = "game"
if fix == 0 then
bastoni = {System.currentDirectory().."/" .. napoli .. "/Bastoni1 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni2 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni3 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni4 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni5 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni6 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni7 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni8 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni9 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni10 [Carte].bmp"}
coppe = {System.currentDirectory().."/" .. napoli .. "/Coppe1 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe2 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe3 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe4 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe5 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe6 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe7 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe8 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe9 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe10 [Carte].bmp"}
denari = {System.currentDirectory().."/" .. napoli .. "/Denari1 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari2 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari3 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari4 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari5 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari6 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari7 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari8 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari9 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari10 [Carte].bmp"}
spade = {System.currentDirectory().."/" .. napoli .. "/Spade1 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade2 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade3 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade4 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade5 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade6 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade7 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade8 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade9 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade10 [Carte].bmp"}
else
bastoni = {System.currentDirectory().."/" .. napoli .. "/Bastoni1 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni2 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni3 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni4 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni5 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni6 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni7 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni9 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni8 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Bastoni10 [Carte].bmp"}
coppe = {System.currentDirectory().."/" .. napoli .. "/Coppe1 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe2 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe3 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe4 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe5 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe6 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe7 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe9 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe8 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Coppe10 [Carte].bmp"}
denari = {System.currentDirectory().."/" .. napoli .. "/Denari1 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari2 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari3 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari4 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari5 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari6 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari7 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari9 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari8 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Denari10 [Carte].bmp"}
spade = {System.currentDirectory().."/" .. napoli .. "/Spade1 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade2 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade3 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade4 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade5 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade6 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade7 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade9 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade8 [Carte].bmp",System.currentDirectory().."/" .. napoli .. "/Spade10 [Carte].bmp"}
end
carte = {bastoni[1],bastoni[2],bastoni[3],bastoni[4],bastoni[5],bastoni[6],bastoni[7],bastoni[8],bastoni[9],bastoni[10],coppe[1],coppe[2],coppe[3],coppe[4],coppe[5],coppe[6],coppe[7],coppe[8],coppe[9],coppe[10],spade[1],spade[2],spade[3],spade[4],spade[5],spade[6],spade[7],spade[8],spade[9],spade[10],denari[1],denari[2],denari[3],denari[4],denari[5],denari[6],denari[7],denari[8],denari[9],denari[10]}
original = {bastoni[1],bastoni[2],bastoni[3],bastoni[4],bastoni[5],bastoni[6],bastoni[7],bastoni[8],bastoni[9],bastoni[10],coppe[1],coppe[2],coppe[3],coppe[4],coppe[5],coppe[6],coppe[7],coppe[8],coppe[9],coppe[10],spade[1],spade[2],spade[3],spade[4],spade[5],spade[6],spade[7],spade[8],spade[9],spade[10],denari[1],denari[2],denari[3],denari[4],denari[5],denari[6],denari[7],denari[8],denari[9],denari[10]}
imgcarte = {Screen.loadBitmap(bastoni[1]),Screen.loadBitmap(bastoni[2]),Screen.loadBitmap(bastoni[3]),Screen.loadBitmap(bastoni[4]),Screen.loadBitmap(bastoni[5]),Screen.loadBitmap(bastoni[6]),Screen.loadBitmap(bastoni[7]),Screen.loadBitmap(bastoni[8]),Screen.loadBitmap(bastoni[9]),Screen.loadBitmap(bastoni[10]),Screen.loadBitmap(coppe[1]),Screen.loadBitmap(coppe[2]),Screen.loadBitmap(coppe[3]),Screen.loadBitmap(coppe[4]),Screen.loadBitmap(coppe[5]),Screen.loadBitmap(coppe[6]),Screen.loadBitmap(coppe[7]),Screen.loadBitmap(coppe[8]),Screen.loadBitmap(coppe[9]),Screen.loadBitmap(coppe[10]),Screen.loadBitmap(spade[1]),Screen.loadBitmap(spade[2]),Screen.loadBitmap(spade[3]),Screen.loadBitmap(spade[4]),Screen.loadBitmap(spade[5]),Screen.loadBitmap(spade[6]),Screen.loadBitmap(spade[7]),Screen.loadBitmap(spade[8]),Screen.loadBitmap(spade[9]),Screen.loadBitmap(spade[10]),Screen.loadBitmap(denari[1]),Screen.loadBitmap(denari[2]),Screen.loadBitmap(denari[3]),Screen.loadBitmap(denari[4]),Screen.loadBitmap(denari[5]),Screen.loadBitmap(denari[6]),Screen.loadBitmap(denari[7]),Screen.loadBitmap(denari[8]),Screen.loadBitmap(denari[9]),Screen.loadBitmap(denari[10])}
originalimg = {Screen.loadBitmap(bastoni[1]),Screen.loadBitmap(bastoni[2]),Screen.loadBitmap(bastoni[3]),Screen.loadBitmap(bastoni[4]),Screen.loadBitmap(bastoni[5]),Screen.loadBitmap(bastoni[6]),Screen.loadBitmap(bastoni[7]),Screen.loadBitmap(bastoni[8]),Screen.loadBitmap(bastoni[9]),Screen.loadBitmap(bastoni[10]),Screen.loadBitmap(coppe[1]),Screen.loadBitmap(coppe[2]),Screen.loadBitmap(coppe[3]),Screen.loadBitmap(coppe[4]),Screen.loadBitmap(coppe[5]),Screen.loadBitmap(coppe[6]),Screen.loadBitmap(coppe[7]),Screen.loadBitmap(coppe[8]),Screen.loadBitmap(coppe[9]),Screen.loadBitmap(coppe[10]),Screen.loadBitmap(spade[1]),Screen.loadBitmap(spade[2]),Screen.loadBitmap(spade[3]),Screen.loadBitmap(spade[4]),Screen.loadBitmap(spade[5]),Screen.loadBitmap(spade[6]),Screen.loadBitmap(spade[7]),Screen.loadBitmap(spade[8]),Screen.loadBitmap(spade[9]),Screen.loadBitmap(spade[10]),Screen.loadBitmap(denari[1]),Screen.loadBitmap(denari[2]),Screen.loadBitmap(denari[3]),Screen.loadBitmap(denari[4]),Screen.loadBitmap(denari[5]),Screen.loadBitmap(denari[6]),Screen.loadBitmap(denari[7]),Screen.loadBitmap(denari[8]),Screen.loadBitmap(denari[9]),Screen.loadBitmap(denari[10])}
function Purge()
for i in ipairs(imgcarte) do
Screen.freeImage(imgcarte[i])
Screen.freeImage(originalimg[i])
end
Screen.freeImage(retro)
Screen.freeImage(sfondo)
Screen.freeImage(sfondo2)
end
mazzo = {}
miecarte = {}
carteavv = {}
carteavvimg = {}
miecarteimg = {}
esd = 1
basemie = 1
baseavv = 1
while true do
Screen.waitVblankStart()
Screen.refresh()
Controls.init()
function EnemyRound()
trovato = 0
if mycard == 0 then
if best == "Bastoni" then
for i in ipairs(carteavv) do
if carteavv[i] == original[12] or carteavv[i] == original[14] or carteavv[i] == original[15] or carteavv[i] == original[16] or carteavv[i] == original[17] or carteavv[i] == original[21] or carteavv[i] == original[22] or carteavv[i] == original[23] or carteavv[i] == original[24] or carteavv[i] == original[25] or carteavv[i] == original[26] or carteavv[i] == original[27] or carteavv[i] == original[31] or carteavv[i] == original[32] or carteavv[i] == original[33] or carteavv[i] == original[34] or carteavv[i] == original[35] or carteavv[i] == original[36] or carteavv[i] == original[37] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
if best == "Coppe" then
for i in ipairs(carteavv) do
if carteavv[i] == original[2] or carteavv[i] == original[4] or carteavv[i] == original[5] or carteavv[i] == original[6] or carteavv[i] == original[7] or carteavv[i] == original[22] or carteavv[i] == original[24] or carteavv[i] == original[25] or carteavv[i] == original[26] or carteavv[i] == original[27] or carteavv[i] == original[32] or carteavv[i] == original[34] or carteavv[i] == original[35] or carteavv[i] == original[36] or carteavv[i] == original[37] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
if best == "Spade" then
for i in ipairs(carteavv) do
if carteavv[i] == carteavv[i] == original[12] or carteavv[i] == original[14] or carteavv[i] == original[15] or carteavv[i] == original[16] or carteavv[i] == original[17] or carteavv[i] == original[2] or carteavv[i] == original[4] or carteavv[i] == original[5] or carteavv[i] == original[6] or carteavv[i] == original[7] or carteavv[i] == original[32] or carteavv[i] == original[34] or carteavv[i] == original[35] or carteavv[i] == original[36] or carteavv[i] == original[37] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
if best == "Denari" then
for i in ipairs(carteavv) do
if carteavv[i] == original[12] or carteavv[i] == original[14] or carteavv[i] == original[15] or carteavv[i] == original[16] or carteavv[i] == original[17] or carteavv[i] == original[22] or carteavv[i] == original[24] or carteavv[i] == original[25] or carteavv[i] == original[26] or carteavv[i] == original[27] or carteavv[i] == original[2] or carteavv[i] == original[4] or carteavv[i] == original[5] or carteavv[i] == original[6] or carteavv[i] == original[7] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
if trovato == 0 then
if best == "Bastoni" then
for i in ipairs(carteavv) do
if carteavv[i] == original[18] or carteavv[i] == original[19] or carteavv[i] == original[20] or carteavv[i] == original[28] or carteavv[i] == original[29] or carteavv[i] == original[30] or carteavv[i] == original[38] or carteavv[i] == original[39] or carteavv[i] == original[40] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- A --
if best == "Coppe" then
for i in ipairs(carteavv) do
if carteavv[i] == original[8] or carteavv[i] == original[9] or carteavv[i] == original[10] or carteavv[i] == original[28] or carteavv[i] == original[29] or carteavv[i] == original[30] or carteavv[i] == original[38] or carteavv[i] == original[39] or carteavv[i] == original[40] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- A --
if best == "Spade" then
for i in ipairs(carteavv) do
if carteavv[i] == original[18] or carteavv[i] == original[19] or carteavv[i] == original[20] or carteavv[i] == original[8] or carteavv[i] == original[9] or carteavv[i] == original[10] or carteavv[i] == original[38] or carteavv[i] == original[39] or carteavv[i] == original[40] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- A --
if best == "Denari" then
for i in ipairs(carteavv) do
if carteavv[i] == original[18] or carteavv[i] == original[19] or carteavv[i] == original[20] or carteavv[i] == original[28] or carteavv[i] == original[29] or carteavv[i] == original[30] or carteavv[i] == original[8] or carteavv[i] == original[9] or carteavv[i] == original[10] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- A --
end
if trovato == 0 then
-- Bastoni
if best == "Bastoni" then
for i in ipairs(carteavv) do
if carteavv[i] == original[2] or carteavv[i] == original[4] or carteavv[i] == original[5] or carteavv[i] == original[6] or carteavv[i] == original[7] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- Coppe
if best == "Coppe" then
for i in ipairs(carteavv) do
if carteavv[i] == original[12] or carteavv[i] == original[14] or carteavv[i] == original[15] or carteavv[i] == original[16] or carteavv[i] == original[17] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- Spade
if best == "Spade" then
for i in ipairs(carteavv) do
if carteavv[i] == original[22] or carteavv[i] == original[24] or carteavv[i] == original[25] or carteavv[i] == original[26] or carteavv[i] == original[27] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- Denari
if best == "Denari" then
for i in ipairs(carteavv) do
if carteavv[i] == original[32] or carteavv[i] == original[34] or carteavv[i] == original[35] or carteavv[i] == original[36] or carteavv[i] == original[37] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
end
if trovato == 0 then
-- Bastoni
if best == "Bastoni" then
for i in ipairs(carteavv) do
if carteavv[i] == original[8] or carteavv[i] == original[9] or carteavv[i] == original[10] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- Coppe
if best == "Coppe" then
for i in ipairs(carteavv) do
if carteavv[i] == original[18] or carteavv[i] == original[19] or carteavv[i] == original[20] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- Spade
if best == "Spade" then
for i in ipairs(carteavv) do
if carteavv[i] == original[28] or carteavv[i] == original[29] or carteavv[i] == original[30] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- Denari
if best == "Denari" then
for i in ipairs(carteavv) do
if carteavv[i] == original[38] or carteavv[i] == original[39] or carteavv[i] == original[40] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
end
if trovato == 0 then
-- Denari
if best == "Denari" then
for i in ipairs(carteavv) do
if carteavv[i] == original[1] or carteavv[i] == original[3] or carteavv[i] == original[11] or carteavv[i] == original[13] or carteavv[i] == original[21] or carteavv[i] == original[23] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- Bastoni
if best == "Bastoni" then
for i in ipairs(carteavv) do
if carteavv[i] == original[31] or carteavv[i] == original[33] or carteavv[i] == original[11] or carteavv[i] == original[13] or carteavv[i] == original[21] or carteavv[i] == original[23] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- Coppe
if best == "Coppe" then
for i in ipairs(carteavv) do
if carteavv[i] == original[1] or carteavv[i] == original[3] or carteavv[i] == original[31] or carteavv[i] == original[33] or carteavv[i] == original[21] or carteavv[i] == original[23] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- Spade
if best == "Spade" then
for i in ipairs(carteavv) do
if carteavv[i] == original[1] or carteavv[i] == original[3] or carteavv[i] == original[11] or carteavv[i] == original[13] or carteavv[i] == original[31] or carteavv[i] == original[33] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
end
if trovato == 0 then
-- Spade
if best == "Spade" then
for i in ipairs(carteavv) do
if carteavv[i] == original[21] or carteavv[i] == original[23] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- Denari
if best == "Denari" then
for i in ipairs(carteavv) do
if carteavv[i] == original[31] or carteavv[i] == original[33] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- Coppe
if best == "Coppe" then
for i in ipairs(carteavv) do
if carteavv[i] == original[11] or carteavv[i] == original[13] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
-- Bastoni
if best == "Bastoni" then
for i in ipairs(carteavv) do
if carteavv[i] == original[1] or carteavv[i] == original[3] then
trovato = 1
enemycard = carteavv[i]
end
if trovato == 1 then
break
end
end
end
end
for i in ipairs(original) do
if enemycard == original[i] then
yourcard = i
end
end
for i in ipairs(carteavv) do
if enemycard == carteavv[i] then
datogliere = i
end
end
enemycardimg = originalimg[yourcard]
enemyvalue = datogliere
table.remove(carteavvimg,enemyvalue)
table.remove(carteavv,enemyvalue)
submode = "player"
elseif mycard > 0 then







valore = {}
for i in ipairs(carteavv) do
for z in ipairs(original) do
if carteavv[i] == original[z] then
valore[i] = z
end
end
end
mycardbase = mycard
mycardextra = 0
if mycard > 10 then
mycardbase = mycard - 10
mycardextra = 10
end
if mycard > 20 then
mycardbase = mycard - 20
mycardextra = 20
end
if mycard > 30 then
mycardbase = mycard - 30
mycardextra = 30
end
-- BRISCOLE --
if isBriscola(mycard) then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase > mycardbase then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
-- CONTINUO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
end
-- CONTINUO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 8 or valorebase == 9 or valorebase == 10 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 8 or valorebase == 9 or valorebase == 10 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 8 or valorebase == 9 or valorebase == 10 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
-- CONTINUO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 8 or valorebase == 9 or valorebase == 10 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 8 or valorebase == 9 or valorebase == 10 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 8 or valorebase == 9 or valorebase == 10 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
end
-- CONTINUO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 8 or valorebase == 9 or valorebase == 10 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 8 or valorebase == 9 or valorebase == 10 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
-- CONTINUO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
-- CONTINUO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
end
-- CONTINUO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
-- CONTINUO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
-- NO BRISCOLE --
else
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if mycard - mycardbase == valore[i] - valorebase and valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if mycard - mycardbase == valore[i] - valorebase and valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if mycard - mycardbase == valore[i] - valorebase and valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
-- CONTINUO NO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if mycard - mycardbase == valore[i] - valorebase and valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if mycard - mycardbase == valore[i] - valorebase and valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 8 or valorebase == 9 or valorebase == 10 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
end
-- CONTINUO NO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if mycard - mycardbase == valore[i] - valorebase and valorebase > mycardbase then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if mycard - mycardbase == valore[i] - valorebase and valorebase > 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 8 or valorebase == 9 or valorebase == 10 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
end
-- CONTINUO NO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if mycard - mycardbase == valore[i] - valorebase and valorebase > 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
end
-- CONTINUO NO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase > 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
-- CONTINUO NO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase > 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase > 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
-- CONTINUO NO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 2 or valorebase == 4 or valorebase == 5 or valorebase == 6 or valorebase == 7 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase > 7 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase > 7 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
-- CONTINUO NO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase > 7 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 1 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
-- CONTINUO NO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 3 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
-- CONTINUO NO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
else
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
-- CONTINUO NO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 3 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
if mycardbase == 2 or mycardbase == 4 or mycardbase == 5 or mycardbase == 6 or mycardbase == 7 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
-- CONTINUO NO BRISCOLE
if trovato == 0 then
if mycardbase == 8 or mycardbase == 9 or mycardbase == 10 then
for i in ipairs(valore) do
if isBriscola(valore[i]) then
else
valorebase = valore[i]
valoreextra = 0
if valore[i] > 10 then
valorebase = valore[i] - 10
valoreextra = 10
end
if valore[i] > 20 then
valorebase = valore[i] - 20
valoreextra = 20
end
if valore[i] > 30 then
valorebase = valore[i] - 30
valoreextra = 30
end
if valorebase == 1 then
trovato = 1
enemycard = carteavv[i]
break
end
end
end
end
end
end
for i in ipairs(original) do
if enemycard == original[i] then
yourcard = i
end
end
for i in ipairs(carteavv) do
if enemycard == carteavv[i] then
datogliere = i
end
end
enemycardimg = originalimg[yourcard]
enemyvalue = datogliere
table.remove(carteavvimg,enemyvalue)
table.remove(carteavv,enemyvalue)
submode = "calcolo"
end
end
function isBriscola(carta)
risultato = false
if best == "Denari" then
if carta > 30 and carta < 41 then
risultato = true
end
end
if best == "Bastoni" then
if carta > 0 and carta < 11 then
risultato = true
end
end
if best == "Coppe" then
if carta > 10 and carta < 21 then
risultato = true
end
end
if best == "Spade" then
if carta > 20 and carta < 31 then
risultato = true
end
end
return risultato
end
function mix_table(tbl)
   math.randomseed(Timer.new())
   for i in ipairs(tbl) do
       r = math.random(1, #tbl)
       temp = tbl[i]
	   temp2 = imgcarte[i]
	   imgcarte[i] = imgcarte[r]
	   imgcarte[r] = temp2
       tbl[i] = tbl[r]
       tbl[r] = temp
   end
   
   return tbl
end
function GiveCard(init)
if init == 0 then
miecarte[basemie] = mazzo[basegioco]
miecarteimg[basemie] = imgcarte[basegioco]
basegioco = basegioco + 1
if basegioco > 39 and basegioco < 42 then
carteavv[baseavv] = briscola
carteavvimg[baseavv] = briscolaimg
basegioco = basegioco + 1
elseif basegioco < 40 then
carteavv[baseavv] = mazzo[basegioco]
carteavvimg[baseavv] = imgcarte[basegioco]
basegioco = basegioco + 1
elseif basegioco > 40 and #miecarte > 0 then
maxnumber = #miecarte
elseif #miecarte < 1 then
submode = "finish"
end
else
carteavv[baseavv] = mazzo[basegioco]
carteavvimg[basemie] = imgcarte[basegioco]
basegioco = basegioco + 1
if basegioco > 39 and basegioco < 42 then
miecarte[basemie] = briscola
miecarteimg[basemie] = briscolaimg
basegioco = basegioco + 1
elseif basegioco < 40 then
miecarte[basemie] = mazzo[basegioco]
miecarteimg[basemie] = imgcarte[basegioco]
basegioco = basegioco + 1
elseif basegioco > 40 and #miecarte > 0 then
maxnumber = #miecarte
elseif #miecarte < 1 then
submode = "finish"
end
end
basemie = basemie + 1
baseavv = baseavv + 1
end
function Briscoleggia()
briscola = mazzo[basegioco]
briscolaimg = imgcarte[basegioco]
for i in ipairs(original) do
if original[i] == briscola then
domindex = i
end
end
if domindex > 0 and domindex < 11 then
best = "Bastoni"
elseif domindex > 10 and domindex < 21 then
best = "Coppe"
elseif domindex > 20 and domindex < 31 then
best = "Spade"
elseif domindex > 30 and domindex < 41 then
best = "Denari"
end
basegioco = basegioco + 1
end
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
if inizio2 == 0 then
mazzo = mix_table(carte)
inizio2 = 1
end
if #mazzo > 39 then
if inizio == 0 then
GiveCard(0)
GiveCard(0)
GiveCard(0)
Briscoleggia()
start = math.random(1,2)
if start == 1 then
submode = "player"
else
submode = "observe"
end
inizio = 1
end
pad = Controls.read()
if viewer == 1 then
Screen.fillEmptyRect(10,300,180,213,giallo,BOTTOM_SCREEN)
Screen.fillRect(11,299,181,212,bianco,BOTTOM_SCREEN)
if lingua == "IT" then
Screen.debugPrint(13,183,"Punti Giocatore: " .. punti,giallo,BOTTOM_SCREEN)
Screen.debugPrint(13,198,"Punti Avversario: " .. puntiavv,giallo,BOTTOM_SCREEN)
end
if lingua == "EN" then
Screen.debugPrint(13,183,"Player Score: " .. punti,giallo,BOTTOM_SCREEN)
Screen.debugPrint(13,198,"Enemy Score: " .. puntiavv,giallo,BOTTOM_SCREEN)
end
else
if submode == "finish" then
Screen.fillEmptyRect(10,300,180,213,giallo,BOTTOM_SCREEN)
Screen.fillRect(11,299,181,212,bianco,BOTTOM_SCREEN)
if lingua == "IT" then
Screen.debugPrint(13,183,"Punti Giocatore: " .. punti,giallo,BOTTOM_SCREEN)
Screen.debugPrint(13,198,"Punti Avversario: " .. puntiavv,giallo,BOTTOM_SCREEN)
end
if lingua == "EN" then
Screen.debugPrint(13,183,"Player Score: " .. punti,giallo,BOTTOM_SCREEN)
Screen.debugPrint(13,198,"Enemy Score: " .. puntiavv,giallo,BOTTOM_SCREEN)
end
end
end
if submode == "observe" then
exround = "observe"
EnemyRound()
end
if enemycard == 0 then
else
Screen.drawImage(50,50,enemycardimg,BOTTOM_SCREEN)
end
if mycard == 0 then
else
Screen.drawImage(150,50,mycardimg,BOTTOM_SCREEN)
end
enemycounter = #carteavv
if enemycounter > 0 then
Screen.drawImage(10,10,retro,TOP_SCREEN)
if enemycounter > 1 then
Screen.drawImage(60,10,retro,TOP_SCREEN)
if enemycounter > 2 then
Screen.drawImage(110,10,retro,TOP_SCREEN)
end
end
end
if (40-(basegioco-1)) > 0 then
if (40-(basegioco-1)) > 1 then
Screen.drawImage(250,100,retro,TOP_SCREEN)
end
Screen.drawImage(255,105,retro,TOP_SCREEN)
Screen.drawImage(190,102,briscolaimg,TOP_SCREEN)
Screen.fillEmptyRect(175,188+60,189,189+15,giallo,TOP_SCREEN)
Screen.fillRect(176,189+58,190,190+13,bianco,TOP_SCREEN)
Screen.debugPrint(178,192,"Briscola",giallo,TOP_SCREEN)
Screen.fillRect(268,268+27,189,189+15,giallo,TOP_SCREEN)
Screen.fillRect(269,269+25,190,190+13,bianco,TOP_SCREEN)
Screen.debugPrint(271,192,40-(basegioco-1),giallo,TOP_SCREEN)
end
if submode == "finish" then
if details == nil then
maxnumeroana = 3
if Controls.check(pad,KEY_DUP) and not Controls.check(oldpad,KEY_DUP) then
numeroan = numeroan - 1
end
if Controls.check(pad,KEY_DDOWN) and not Controls.check(oldpad,KEY_DDOWN) then
numeroan = numeroan + 1
end
if numeroan > maxnumeroana then
numeroan = 1
end
if numeroan <= 0 then
numeroan = maxnumeroana
end
Screen.fillEmptyRect(50,265,50,200,giallo,BOTTOM_SCREEN)
Screen.fillRect(51,264,51,199,bianco,BOTTOM_SCREEN)
mca = {giallo,giallo,giallo}
mca[numeroan] = rosso
if lingua == "IT" then
if punti > puntiavv then
Screen.debugPrint(53,53,"HAI VINTO!!!",rosso,BOTTOM_SCREEN)
elseif puntiavv > punti then
Screen.debugPrint(53,53,"HAI PERSO!!!",rosso,BOTTOM_SCREEN)
else
Screen.debugPrint(53,53,"HAI PAREGGIATO!!!",rosso,BOTTOM_SCREEN)
end
end
if lingua == "EN" then
if punti > puntiavv then
Screen.debugPrint(53,53,"YOU WIN!!!",rosso,BOTTOM_SCREEN)
elseif puntiavv > punti then
Screen.debugPrint(53,53,"YOU LOSE!!!",rosso,BOTTOM_SCREEN)
else
Screen.debugPrint(53,53,"DRAW!!!",rosso,BOTTOM_SCREEN)
end
end
if lingua == "IT" then
Screen.debugPrint(53,75,"Gioca Ancora",mca[1],BOTTOM_SCREEN)
Screen.debugPrint(53,90,"Torna al Menu Principale",mca[2],BOTTOM_SCREEN)
Screen.debugPrint(53,105,"Esci dal Gioco",mca[3],BOTTOM_SCREEN)
end
if lingua == "EN" then
Screen.debugPrint(53,75,"Play Again",mca[1],BOTTOM_SCREEN)
Screen.debugPrint(53,90,"Return to Main Menu",mca[2],BOTTOM_SCREEN)
Screen.debugPrint(53,105,"Exit Game",mca[3],BOTTOM_SCREEN)
end
if Controls.check(pad,KEY_A) and numeroan == 1 and not Controls.check(oldpad,KEY_A) then
Purge()
dofile(System.currentDirectory().."/1VS1.LUA")
end
if Controls.check(pad,KEY_A) and numeroan == 2 and not Controls.check(oldpad,KEY_A) then
Purge()
dofile(System.currentDirectory().."/index.lua")
end
if Controls.check(pad,KEY_A) and numeroan == 3 and not Controls.check(oldpad,KEY_A) then
if (submusic==1) then
Sound.term()
end
System.exit()
end
end
end
if submode == "calcolo" then
if peppe == 0 then
tempo = Timer.new()
peppe = 1
end
if Timer.getTime(tempo) > 2000 then
puntinew = 0
yourbase = yourcard
if yourcard > 10 then
yourbase = yourcard - 10
end
if yourcard > 20 then
yourbase = yourcard - 20
end
if yourcard > 30 then
yourbase = yourcard - 30
end
mybase = mycard
if mycard > 10 then
mybase = mycard - 10
end
if mycard > 20 then
mybase = mycard - 20
end
if mycard > 30 then
mybase = mycard - 30
end
if mybase == 1 then
puntinew = puntinew + 11
end
if mybase == 3 then
puntinew = puntinew + 10
end
if mybase == 8 then
puntinew = puntinew + 2
end
if mybase == 9 then
puntinew = puntinew + 3
end
if mybase == 10 then
puntinew = puntinew + 4
end
if yourbase == 1 then
puntinew = puntinew + 11
end
if yourbase == 3 then
puntinew = puntinew + 10
end
if yourbase == 8 then
puntinew = puntinew + 2
end
if yourbase == 9 then
puntinew = puntinew + 3
end
if yourbase == 10 then
puntinew = puntinew + 4
end
ordinatore = {2,4,5,6,7,8,9,10,3,1}
for i in ipairs(ordinatore) do
if yourbase == ordinatore[i] then
ordinatoretu = i
break
end
end
for i in ipairs(ordinatore) do
if mybase == ordinatore[i] then
ordinatoreio = i
break
end
end
if mycard - mybase == yourcard - yourbase then
if ordinatoretu > ordinatoreio then
presa = "tu"
else
presa = "me"
end
end
if exround == "observe" then
if mycard - mybase == yourcard - yourbase then
else
if isBriscola(yourcard) then
presa = "tu"
else
presa = "me"
end
end
else
end
if exround == "player" then
if mycard - mybase == yourcard - yourbase then
else
if isBriscola(mycard) then
presa = "me"
else
presa = "tu"
end
end
else
end
-- Aggiunta Dettagli Partita --
if isBriscola(mycard) then
if mybase == 1 then
mybase = 12
end
if mybase == 3 then
mybase = 11
end
if mybase > mybestbriscola then
mybestbriscola = mybase
end
if mybase < myloffabriscola then
myloffabriscola = mybase
end
end
if isBriscola(yourcard) then
if yourbase == 1 then
yourbase = 12
end
if yourbase == 3 then
yourbase = 11
end
if yourbase > yourbestbriscola then
yourbestbriscola = yourbase
end
if yourbase < yourloffabriscola then
yourloffabriscola = yourbase
end
end
-- Fine --
peppe = 0
basemie = 3
baseavv = 3
mycard = 0
yourcard = 0
enemycard = 0
if presa == "me" then
myprese = myprese + 1
if puntinew > mybestpresa then
mybestpresa = puntinew
end
punti = punti + puntinew
GiveCard(0)
if #miecarte > 0 then
submode = "player"
end
else
yourprese = yourprese + 1
if puntinew > yourbestpresa then
yourbestpresa = puntinew
end
puntiavv = puntiavv + puntinew
GiveCard(1)
if #miecarte > 0 then
submode = "observe"
end
end
end
end
if submode == "player" then
if going == nil then
if var >= 255 then
going = true
else
var = var + 30
end
else
if var <= 0 then
going = nil
else
var = var - 30
end
end
rossovar = Color.new(255,var,0)
if number == 1 then
Screen.fillRect(8,60,138,138+83,rossovar,TOP_SCREEN)
elseif number == 2 then
Screen.fillRect(58,110,138,138+83,rossovar,TOP_SCREEN)
elseif number == 3 then
Screen.fillRect(108,160,138,138+83,rossovar,TOP_SCREEN)
end
end
if mode == "game" then
if submode == "player" then
exround = "player"
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) then
for i in ipairs(original) do
if miecarte[number] == original[i] then
mycard = i
end
end
mycardimg = originalimg[mycard]
mycardvalue = number
table.remove(miecarteimg,mycardvalue)
table.remove(miecarte,mycardvalue)
if yourcard == 0 then
submode = "observe"
else
submode = "calcolo"
end
end
if Controls.check(pad,KEY_DLEFT) and not Controls.check(oldpad,KEY_DLEFT) then
number = number - 1
end
if Controls.check(pad,KEY_DRIGHT) and not Controls.check(oldpad,KEY_DRIGHT) then
number = number + 1
end
end
if number < 1 then
number = maxnumber
end
if number > maxnumber then
number = 1
end
if Controls.check(pad,KEY_START) and not Controls.check(oldpad,KEY_START) then
if submode == "finish" then
else
mode = "menu"
numberz = 1
end
end
else
if Controls.check(pad,KEY_START) and not Controls.check(oldpad,KEY_START) then
mode = "game"
end
if Controls.check(pad,KEY_DUP) and not Controls.check(oldpad,KEY_DUP) then
numberz = numberz - 1
end
if Controls.check(pad,KEY_DDOWN) and not Controls.check(oldpad,KEY_DDOWN) then
numberz = numberz + 1
end
if numberz > maxnumberz then
numberz = 1
end
if numberz <= 0 then
numberz = maxnumberz
end
Screen.fillEmptyRect(50,265,50,200,giallo,BOTTOM_SCREEN)
Screen.fillRect(51,264,51,199,bianco,BOTTOM_SCREEN)
mca = {giallo,giallo,giallo,giallo}
mca[numberz] = rosso
if lingua == "IT" then
Screen.debugPrint(53,53,"GIOCO IN PAUSA",rosso,BOTTOM_SCREEN)
Screen.debugPrint(53,75,"Riprendi Partita",mca[1],BOTTOM_SCREEN)
Screen.debugPrint(53,90,"Riavvia Partita",mca[2],BOTTOM_SCREEN)
Screen.debugPrint(53,105,"Torna al Menu Principale",mca[3],BOTTOM_SCREEN)
Screen.debugPrint(53,120,"Esci dal Gioco",mca[4],BOTTOM_SCREEN)
end
if lingua == "EN" then
Screen.debugPrint(53,53,"PAUSED GAME",rosso,BOTTOM_SCREEN)
Screen.debugPrint(53,75,"Resume Game",mca[1],BOTTOM_SCREEN)
Screen.debugPrint(53,90,"Restart Game",mca[2],BOTTOM_SCREEN)
Screen.debugPrint(53,105,"Return to Main Menu",mca[3],BOTTOM_SCREEN)
Screen.debugPrint(53,120,"Exit Game",mca[4],BOTTOM_SCREEN)
end
if Controls.check(pad,KEY_A) and numberz == 1 and not Controls.check(oldpad,KEY_A) then
mode = "game"
end
if Controls.check(pad,KEY_A) and numberz == 2 and not Controls.check(oldpad,KEY_A) then
Purge()
dofile(System.currentDirectory().."/1VS1.LUA")
end
if Controls.check(pad,KEY_A) and numberz == 3 and not Controls.check(oldpad,KEY_A) then
Purge()
dofile(System.currentDirectory().."/index.lua")
end
if Controls.check(pad,KEY_A) and numberz == 4 and not Controls.check(oldpad,KEY_A) then
if (submusic==1) then
Sound.term()
end
System.exit()
end
end
if #miecarte > 0 then
Screen.drawImage(10,140,miecarteimg[1],TOP_SCREEN)
if #miecarte > 1 then
Screen.drawImage(60,140,miecarteimg[2],TOP_SCREEN)
if #miecarte > 2 then
Screen.drawImage(110,140,miecarteimg[3],TOP_SCREEN)
end
end
end
if (Controls.check(pad,KEY_L) and not Controls.check(oldpad,KEY_L)) then
System.takeScreenshot("/3DSBriscola.bmp")
end
Screen.flip()
oldpad = pad
end
end
