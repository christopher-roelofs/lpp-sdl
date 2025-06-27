giallo = Color.new (0,0,0)
bianco = Color.new(255,255,255)
dofile(System.currentDirectory().."/fix.db")
sfondo = Screen.loadBitmap(System.currentDirectory().."/BG/th_bg"..backscreen..".bmp")
sfondo2 = Screen.loadBitmap(System.currentDirectory().."/BG/th2_th_bg"..backscreen..".bmp")
n1 = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari1 [Carte].bmp")
n2 = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari2 [Carte].bmp")
n3 = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari3 [Carte].bmp")
n4 = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari4 [Carte].bmp")
n5 = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari5 [Carte].bmp")
n6 = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari6 [Carte].bmp")
n7 = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari7 [Carte].bmp")
if fix == 0 then
n8 = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari8 [Carte].bmp")
n9 = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari9 [Carte].bmp")
else
n8 = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari9 [Carte].bmp")
n9 = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari8 [Carte].bmp")
end
n10 = Screen.loadBitmap(System.currentDirectory().."/NAP/Denari10 [Carte].bmp")
extra = 0
function Purge()
Screen.freeImage(n1)
Screen.freeImage(n2)
Screen.freeImage(n3)
Screen.freeImage(n4)
Screen.freeImage(n5)
Screen.freeImage(n6)
Screen.freeImage(n7)
Screen.freeImage(n8)
Screen.freeImage(n9)
Screen.freeImage(n10)
Screen.freeImage(sfondo)
Screen.freeImage(sfondo2)
end
oldpad = Controls.read()
to_stamp = true
while true do
Screen.waitVblankStart()
Screen.refresh()
Controls.init()
pad = Controls.read()
if extra == 0 then
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
Screen.fillEmptyRect(1, 399, 1, 123, giallo,TOP_SCREEN)
Screen.fillRect(2, 398, 2, 122, bianco,TOP_SCREEN)
if lingua == "IT" then
printc(3,3,"Benvenuto nel Tutorial di 3DSBriscola!",rosso)
printc(3,18,"Tramite questa semplice guida potrai",giallo)
printc(3,33,"imparare le basi del gioco della",giallo)
printc(3,48,"Briscola. Per tornare alle pagine",giallo)
printc(3,63,"precedenti durante la guida premere",giallo)
printc(3,78,"il tasto B. Per iniziare questo",giallo)
printc(3,93,"percorso di apprendimento premere",giallo)
printc(3,108,"il tasto A.",giallo)
end
if lingua == "EN" then
printc(3,3,"Welcome to the 3DSBriscola's Tutorial!",rosso)
printc(3,18,"With this simple guide you will",giallo)
printc(3,33,"learn to play at Briscola.",giallo)
printc(3,48,"To return to previous pages",giallo)
printc(3,63,"during the guide, press B.",giallo)
printc(3,78,"To begin to read the guide, press A.",giallo)
end
elseif extra == 10 then
if (to_stamp) then
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
to_stamp = false
end
Screen.fillEmptyRect(1, 399, 1, 239, giallo,TOP_SCREEN)
Screen.fillRect(2, 398, 2, 238, bianco,TOP_SCREEN)
if lingua == "IT" then
printc(3,3,"Regole Base",rosso)
printc(3,18,"Nella Briscola si utilizza un mazzo",giallo)
printc(3,33,"da 40 carte di 4 semi diversi numerate",giallo)
printc(3,48,"da 1 a 10. Per vincere bisogna",giallo)
printc(3,63,"totalizzare piu' punti dei propri",giallo)
printc(3,78,"avversari. Solo alcune carte permettono",giallo)
printc(3,93,"di totalizzare dei punti. Qui sotto",giallo)
printc(3,108,"e' possibile vedere quali carte",giallo)
printc(3,123,"(NOTA: Vale per qualsiasi seme).",giallo)
printc(3,138,"Ogni giocatore pesca 3 carte ad",giallo)
printc(3,153,"inizio partita e ne pesca una ad",giallo)
printc(3,168,"ogni turno. Il turno finisce quando",giallo)
printc(3,183,"tutti i giocatori hanno giocato una",giallo)
printc(3,198,"carta. Ad inizio partita viene inoltre",giallo)
printc(3,213,"messa una carta scoperta per terra",giallo)
printc(3,228,"chiamata Briscola.",giallo)
if fix == 0 then
Screen.drawImage(40,20,n8,BOTTOM_SCREEN)
else
Screen.drawImage(40,20,n9,BOTTOM_SCREEN)
end
Screen.fillEmptyRect(30,30+65,20+87,20+87+15,giallo,BOTTOM_SCREEN)
Screen.fillRect(31,30+64,20+88,20+87+14,bianco,BOTTOM_SCREEN)
Screen.debugPrint(32,20+89,"2 Punti",giallo,BOTTOM_SCREEN)
if fix == 0 then
Screen.drawImage(110,20,n9,BOTTOM_SCREEN)
else
Screen.drawImage(110,20,n8,BOTTOM_SCREEN)
end
Screen.fillEmptyRect(100,100+65,20+87,20+87+15,giallo,BOTTOM_SCREEN)
Screen.fillRect(101,100+64,20+88,20+87+14,bianco,BOTTOM_SCREEN)
Screen.debugPrint(102,20+89,"3 Punti",giallo,BOTTOM_SCREEN)
Screen.drawImage(180,20,n10,BOTTOM_SCREEN)
Screen.fillEmptyRect(170,170+65,20+87,20+87+15,giallo,BOTTOM_SCREEN)
Screen.fillRect(171,170+64,20+88,20+87+14,bianco,BOTTOM_SCREEN)
Screen.debugPrint(172,20+89,"4 Punti",giallo,BOTTOM_SCREEN)
Screen.drawImage(250,20,n3,BOTTOM_SCREEN)
Screen.fillEmptyRect(240,240+75,20+87,20+87+15,giallo,BOTTOM_SCREEN)
Screen.fillRect(241,240+74,20+88,20+87+14,bianco,BOTTOM_SCREEN)
Screen.debugPrint(242,20+89,"10 Punti",giallo,BOTTOM_SCREEN)
Screen.drawImage(150,130,n1,BOTTOM_SCREEN)
Screen.fillEmptyRect(140,140+75,130+87,130+87+15,giallo,BOTTOM_SCREEN)
Screen.fillRect(141,140+74,130+88,130+87+14,bianco,BOTTOM_SCREEN)
Screen.debugPrint(142,130+89,"11 Punti",giallo,BOTTOM_SCREEN)
end
if lingua == "EN" then
printc(3,3,"Basic Rules",rosso)
printc(3,18,"In Briscola is used a deck of 40 cards",giallo)
printc(3,33,"of 4 different suits numbered from 1 to 10.",giallo)
printc(3,48,"To win, you must score more points than",giallo)
printc(3,63,"your enemies. Only some cards permit you",giallo)
printc(3,78,"to score some points. Under here, you can",giallo)
printc(3,93,"see which cards (NOTE: This is right for",giallo)
printc(3,108,"any suit). Each player draw 3 cards at",giallo)
printc(3,123,"the beginning and draw ones a round.",giallo)
printc(3,138,"The round finish when all players have",giallo)
printc(3,153,"played a card. At the beginning, a card",giallo)
printc(3,168,"is putted discovered on the field.",giallo)
printc(3,183,"This card will be called Briscola.",giallo)
Screen.drawImage(40,20,n8,BOTTOM_SCREEN)
Screen.fillEmptyRect(30,30+65,20+87,20+87+15,giallo,BOTTOM_SCREEN)
Screen.fillRect(31,30+64,20+88,20+87+14,bianco,BOTTOM_SCREEN)
Screen.debugPrint(32,20+89,"2 P.nts",giallo,BOTTOM_SCREEN)
Screen.drawImage(110,20,n9,BOTTOM_SCREEN)
Screen.fillEmptyRect(100,100+65,20+87,20+87+15,giallo,BOTTOM_SCREEN)
Screen.fillRect(101,100+64,20+88,20+87+14,bianco,BOTTOM_SCREEN)
Screen.debugPrint(102,20+89,"3 P.nts",giallo,BOTTOM_SCREEN)
Screen.drawImage(180,20,n10,BOTTOM_SCREEN)
Screen.fillEmptyRect(170,170+65,20+87,20+87+15,giallo,BOTTOM_SCREEN)
Screen.fillRect(171,170+64,20+88,20+87+14,bianco,BOTTOM_SCREEN)
Screen.debugPrint(172,20+89,"4 P.nts",giallo,BOTTOM_SCREEN)
Screen.drawImage(250,20,n3,BOTTOM_SCREEN)
Screen.fillEmptyRect(240,240+75,20+87,20+87+15,giallo,BOTTOM_SCREEN)
Screen.fillRect(241,240+74,20+88,20+87+14,bianco,BOTTOM_SCREEN)
Screen.debugPrint(242,20+89,"10 P.nts",giallo,BOTTOM_SCREEN)
Screen.drawImage(150,130,n1,BOTTOM_SCREEN)
Screen.fillEmptyRect(140,140+75,130+87,130+87+15,giallo,BOTTOM_SCREEN)
Screen.fillRect(141,140+74,130+88,130+87+14,bianco,BOTTOM_SCREEN)
Screen.debugPrint(142,130+89,"11 P.nts",giallo,BOTTOM_SCREEN)
end
elseif extra == 20 then
to_stamp = true
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
Screen.fillRect(1, 399, 1, 153, giallo,TOP_SCREEN)
Screen.fillRect(2, 398, 2, 152, bianco,TOP_SCREEN)
if lingua == "IT" then
printc(3,3,"Definizione di Briscola",rosso)
printc(3,18,"La Briscola e' una carta che viene posata",giallo)
printc(3,33,"scoperta per terra ad inizio partita.",giallo)
printc(3,48,"Quando le carte del mazzo sono esaurite, il", giallo)
printc(3,63,"giocatore che avrebbe dovuto pescare",giallo)
printc(3,78,"prende questa carta anziche' pescare.",giallo)
printc(3,93,"Se un giocatore gioca una carta di un seme",giallo)
printc(3,108,"diverso dalla Briscola, qualsiasi carta del",giallo)
printc(3,123,"seme della Briscola permette di prendere",giallo)
printc(3,138,"la carta avversaria.",giallo)
end
if lingua == "EN" then
printc(3,3,"Definition of Briscola",rosso)
printc(3,18,"The Briscola is a card putted on the field",giallo)
printc(3,33,"discovered at the beginning of the game.",giallo)
printc(3,48,"When the cards of the deck are finished,",giallo)
printc(3,63,"the player who would draw, take this card",giallo)
printc(3,78,"instead drawing a card. If a player plays",giallo)
printc(3,93,"a card which isn't Briscola's suit, any",giallo) 
printc(3,108,"card of Briscola's suit permits to take",giallo)
printc(3,123,"the opponent card.",giallo)
end
elseif extra == 30 then
if (to_stamp) then
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
to_stamp = false
end
Screen.fillRect(1, 399, 1, 198, giallo,TOP_SCREEN)
Screen.fillRect(2, 398, 2, 197, bianco,TOP_SCREEN)
if lingua == "IT" then
printc(3,3,"Incremento dei Punti",rosso)
printc(3,18,"Per aumentare il proprio punteggio e'",giallo)
printc(3,33,"necessario prendere carte che valgono punti.",giallo)
printc(3,48,"Per prendere carte la prima regola valida",giallo)
printc(3,63,"e' quella della Briscola. La seconda regola",giallo)
printc(3,78,"e' dovuta alla grandezza della carta giocata.",giallo)
printc(3,93,"La carta di maggior valore giocata vince e",giallo)
printc(3,108,"il giocatore relativo prende le carte",giallo)
printc(3,123,"giocate. Questa regola vale se i semi delle",giallo)
printc(3,138,"carte sono uguali. Se i semi sono diversi ed",giallo)
printc(3,153,"entrambi non del seme della Briscola, vince",giallo)
printc(3,168,"il primo giocatore ad aver giocato. In basso",giallo)
printc(3,183,"e' visibile l'ordine di grandezza delle carte.",giallo)
end
if lingua == "EN" then
printc(3,3,"Scoring Points",rosso)
printc(3,18,"To increase your score, you must take cards",giallo)
printc(3,33,"which score points. To take cards, the first",giallo)
printc(3,48,"rule is the Briscola's rule previously shown.",giallo)
printc(3,63,"The second rule is dictated from the height",giallo)
printc(3,78,"of the played card. The higher card played",giallo)
printc(3,93,"win and the relative player get played cards.",giallo)
printc(3,108,"This rule is right only if the suits of the",giallo)
printc(3,123,"played cards are the same. If the suits are",giallo)
printc(3,138,"different and everyone is different from",giallo)
printc(3,153,"Briscola's suit, the first player who",giallo)
printc(3,168,"played will win. Under here is visible",giallo)
printc(3,183,"the heights scale.",giallo)
end
Screen.drawImage(20,10,n2,BOTTOM_SCREEN)
Screen.drawImage(69,10,n4,BOTTOM_SCREEN)
Screen.drawImage(118,10,n5,BOTTOM_SCREEN)
Screen.drawImage(167,10,n6,BOTTOM_SCREEN)
Screen.drawImage(216,10,n7,BOTTOM_SCREEN)
if fix == 0 then
Screen.drawImage(265,10,n8,BOTTOM_SCREEN)
Screen.drawImage(69,100,n9,BOTTOM_SCREEN)
else
Screen.drawImage(265,10,n9,BOTTOM_SCREEN)
Screen.drawImage(69,100,n8,BOTTOM_SCREEN)
end
Screen.drawImage(118,100,n10,BOTTOM_SCREEN)
Screen.drawImage(167,100,n3,BOTTOM_SCREEN)
Screen.drawImage(216,100,n1,BOTTOM_SCREEN)
elseif extra == 40 then
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
Screen.fillRect(1, 399, 1, 153, giallo,TOP_SCREEN)
Screen.fillRect(2, 398, 2, 152, bianco,TOP_SCREEN)
if lingua == "IT" then
printc(3,3,"Sequenza di Gioco",rosso)
printc(3,18,"All'inizio della partita verra' scelto",giallo)
printc(3,33,"casualmente un giocatore. Tale giocatore",giallo)
printc(3,48,"sara' il primo a giocare per il primo turno.",giallo)
printc(3,63,"Alla fine del turno, il giocatore che",giallo)
printc(3,78,"prende le carte (ovvero vince la mano)",giallo)
printc(3,93,"giochera' per primo nel prossimo turno e",giallo)
printc(3,108,"sara' il primo a pescare la carta. Tutti",giallo)
printc(3,123,"i giocatori seguenti giocheranno in un",giallo)
printc(3,138,"ordine orario.",giallo)
end
if lingua == "EN" then
printc(3,3,"Sequence Game",rosso)
printc(3,18,"At the beginning, a random player is",giallo)
printc(3,33,"selected. This player is the first",giallo)
printc(3,48,"who plays for the first round. At the",giallo)
printc(3,63,"end of the round, the player who take",giallo)
printc(3,78,"the played cards will plays first on",giallo)
printc(3,93,"the next round and will draw a card",giallo)
printc(3,108,"first. Next players will plays",giallo)
printc(3,123,"in an order time.",giallo)
end
elseif extra == 50 then
Screen.drawImage(0,0,sfondo,TOP_SCREEN)
Screen.drawImage(0,0,sfondo2,BOTTOM_SCREEN)
Screen.fillRect(1, 399, 1, 108, giallo,TOP_SCREEN)
Screen.fillRect(2, 398, 2, 107, bianco,TOP_SCREEN)
if lingua == "IT" then
printc(3,3,"Conclusione",rosso)
printc(3,18,"Queste sono le regole della Briscola.",giallo)
printc(3,33,"Adesso sei pronto per gettarti nelle",giallo)
printc(3,48,"avvincenti partite di 3DSBriscola.",giallo)
printc(3,63,"Per qualsiasi dubbio potrai riconsultare",giallo)
printc(3,78,"questo guida in qualsiasi momento.",giallo)
printc(3,93,"Premi A per tornare al Menu Principale.",giallo)
end
if lingua == "EN" then
printc(3,3,"Conclusion",rosso)
printc(3,18,"These are the Briscola's rules.",giallo)
printc(3,33,"Now, you're ready to begin your matches",giallo)
printc(3,48,"on 3DSBriscola. For any further",giallo)
printc(3,63,"question, you can read again this",giallo)
printc(3,78,"guide any time.",giallo)
printc(3,93,"Press A to return to the Main Menu.",giallo)
end
end
if extra == 0 then
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) then
extra = 10
end
if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
Purge()
dofile(System.currentDirectory().."/index.lua")
end
elseif extra == 10 then
maxnumber = 3
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) then
extra = 20
end
if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
extra = 0
end
elseif extra == 20 then
if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
extra = 10
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) then
extra = 30
end
elseif extra == 30 then
if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
extra = 20
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) then
extra = 40
end
elseif extra == 40 then
if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
extra = 30
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) then
extra = 50
end
elseif extra == 50 then
if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
extra = 40
end
if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) then
Purge()
dofile(System.currentDirectory().."/index.lua")
end
end
Screen.flip()
oldpad = pad
end
