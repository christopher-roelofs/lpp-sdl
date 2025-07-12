--System.setCpuSpeed(222)

Ogg.load("karaoke/ogg.ogg", 1)

counter = Timer.new()



while true do
oldpad = pad
pad = Controls.read()
System.draw()
screen:clear()

currentTime = counter:time()

--Ogg.speed(1.105,1)
Ogg.speed(1.021,1)
Ogg.play(false, 1)

if currentTime >= 0 and currentTime <= 33 then
frame1 = Image.load("harehare/vlcsnap-00000.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33 and currentTime <= 66 then
frame1 = Image.load("harehare/vlcsnap-00001.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 66 and currentTime <= 99 then
frame1 = Image.load("harehare/vlcsnap-00002.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 99 and currentTime <= 132 then
frame1 = Image.load("harehare/vlcsnap-00003.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 132 and currentTime <= 165 then
frame1 = Image.load("harehare/vlcsnap-00004.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 165 and currentTime <= 198 then
frame1 = Image.load("harehare/vlcsnap-00005.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 198 and currentTime <= 231 then
frame1 = Image.load("harehare/vlcsnap-00006.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 231 and currentTime <= 264 then
frame1 = Image.load("harehare/vlcsnap-00007.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 264 and currentTime <= 297 then
frame1 = Image.load("harehare/vlcsnap-00008.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 297 and currentTime <= 330 then
frame1 = Image.load("harehare/vlcsnap-00009.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 330 and currentTime <= 363 then
frame1 = Image.load("harehare/vlcsnap-00010.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 363 and currentTime <= 396 then
frame1 = Image.load("harehare/vlcsnap-00011.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 396 and currentTime <= 429 then
frame1 = Image.load("harehare/vlcsnap-00012.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 429 and currentTime <= 462 then
frame1 = Image.load("harehare/vlcsnap-00013.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 462 and currentTime <= 495 then
frame1 = Image.load("harehare/vlcsnap-00014.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 495 and currentTime <= 528 then
frame1 = Image.load("harehare/vlcsnap-00015.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 528 and currentTime <= 561 then
frame1 = Image.load("harehare/vlcsnap-00016.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 561 and currentTime <= 594 then
frame1 = Image.load("harehare/vlcsnap-00017.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 594 and currentTime <= 627 then
frame1 = Image.load("harehare/vlcsnap-00018.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 627 and currentTime <= 660 then
frame1 = Image.load("harehare/vlcsnap-00019.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 660 and currentTime <= 693 then
frame1 = Image.load("harehare/vlcsnap-00020.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 693 and currentTime <= 726 then
frame1 = Image.load("harehare/vlcsnap-00021.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 726 and currentTime <= 759 then
frame1 = Image.load("harehare/vlcsnap-00022.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 759 and currentTime <= 792 then
frame1 = Image.load("harehare/vlcsnap-00023.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 792 and currentTime <= 825 then
frame1 = Image.load("harehare/vlcsnap-00024.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 825 and currentTime <= 858 then
frame1 = Image.load("harehare/vlcsnap-00025.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 858 and currentTime <= 891 then
frame1 = Image.load("harehare/vlcsnap-00026.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 891 and currentTime <= 924 then
frame1 = Image.load("harehare/vlcsnap-00027.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 924 and currentTime <= 957 then
frame1 = Image.load("harehare/vlcsnap-00028.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 957 and currentTime <= 990 then
frame1 = Image.load("harehare/vlcsnap-00029.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 990 and currentTime <= 1023 then
frame1 = Image.load("harehare/vlcsnap-00030.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1023 and currentTime <= 1056 then
frame1 = Image.load("harehare/vlcsnap-00031.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1056 and currentTime <= 1089 then
frame1 = Image.load("harehare/vlcsnap-00032.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1089 and currentTime <= 1122 then
frame1 = Image.load("harehare/vlcsnap-00033.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1122 and currentTime <= 1155 then
frame1 = Image.load("harehare/vlcsnap-00034.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1155 and currentTime <= 1188 then
frame1 = Image.load("harehare/vlcsnap-00035.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1188 and currentTime <= 1221 then
frame1 = Image.load("harehare/vlcsnap-00036.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1221 and currentTime <= 1254 then
frame1 = Image.load("harehare/vlcsnap-00037.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1254 and currentTime <= 1287 then
frame1 = Image.load("harehare/vlcsnap-00038.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1287 and currentTime <= 1320 then
frame1 = Image.load("harehare/vlcsnap-00039.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1320 and currentTime <= 1353 then
frame1 = Image.load("harehare/vlcsnap-00040.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1353 and currentTime <= 1386 then
frame1 = Image.load("harehare/vlcsnap-00041.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1386 and currentTime <= 1419 then
frame1 = Image.load("harehare/vlcsnap-00042.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1419 and currentTime <= 1452 then
frame1 = Image.load("harehare/vlcsnap-00043.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1452 and currentTime <= 1485 then
frame1 = Image.load("harehare/vlcsnap-00044.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1485 and currentTime <= 1518 then
frame1 = Image.load("harehare/vlcsnap-00045.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1518 and currentTime <= 1551 then
frame1 = Image.load("harehare/vlcsnap-00046.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1551 and currentTime <= 1584 then
frame1 = Image.load("harehare/vlcsnap-00047.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1584 and currentTime <= 1617 then
frame1 = Image.load("harehare/vlcsnap-00048.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1617 and currentTime <= 1650 then
frame1 = Image.load("harehare/vlcsnap-00049.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1650 and currentTime <= 1683 then
frame1 = Image.load("harehare/vlcsnap-00050.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1683 and currentTime <= 1716 then
frame1 = Image.load("harehare/vlcsnap-00051.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1716 and currentTime <= 1749 then
frame1 = Image.load("harehare/vlcsnap-00052.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1749 and currentTime <= 1782 then
frame1 = Image.load("harehare/vlcsnap-00053.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1782 and currentTime <= 1815 then
frame1 = Image.load("harehare/vlcsnap-00054.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1815 and currentTime <= 1848 then
frame1 = Image.load("harehare/vlcsnap-00055.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1848 and currentTime <= 1881 then
frame1 = Image.load("harehare/vlcsnap-00056.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1881 and currentTime <= 1914 then
frame1 = Image.load("harehare/vlcsnap-00057.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1914 and currentTime <= 1947 then
frame1 = Image.load("harehare/vlcsnap-00058.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1947 and currentTime <= 1980 then
frame1 = Image.load("harehare/vlcsnap-00059.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1980 and currentTime <= 2013 then
frame1 = Image.load("harehare/vlcsnap-00060.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2013 and currentTime <= 2046 then
frame1 = Image.load("harehare/vlcsnap-00061.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2046 and currentTime <= 2079 then
frame1 = Image.load("harehare/vlcsnap-00062.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2079 and currentTime <= 2112 then
frame1 = Image.load("harehare/vlcsnap-00063.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2112 and currentTime <= 2145 then
frame1 = Image.load("harehare/vlcsnap-00064.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2145 and currentTime <= 2178 then
frame1 = Image.load("harehare/vlcsnap-00065.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2178 and currentTime <= 2211 then
frame1 = Image.load("harehare/vlcsnap-00066.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2211 and currentTime <= 2244 then
frame1 = Image.load("harehare/vlcsnap-00067.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2244 and currentTime <= 2277 then
frame1 = Image.load("harehare/vlcsnap-00068.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2277 and currentTime <= 2310 then
frame1 = Image.load("harehare/vlcsnap-00069.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2310 and currentTime <= 2343 then
frame1 = Image.load("harehare/vlcsnap-00070.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2343 and currentTime <= 2376 then
frame1 = Image.load("harehare/vlcsnap-00071.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2376 and currentTime <= 2409 then
frame1 = Image.load("harehare/vlcsnap-00072.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2409 and currentTime <= 2442 then
frame1 = Image.load("harehare/vlcsnap-00073.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2442 and currentTime <= 2475 then
frame1 = Image.load("harehare/vlcsnap-00074.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2475 and currentTime <= 2508 then
frame1 = Image.load("harehare/vlcsnap-00075.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2508 and currentTime <= 2541 then
frame1 = Image.load("harehare/vlcsnap-00076.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2541 and currentTime <= 2574 then
frame1 = Image.load("harehare/vlcsnap-00077.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2574 and currentTime <= 2607 then
frame1 = Image.load("harehare/vlcsnap-00078.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2607 and currentTime <= 2640 then
frame1 = Image.load("harehare/vlcsnap-00079.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2640 and currentTime <= 2673 then
frame1 = Image.load("harehare/vlcsnap-00080.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2673 and currentTime <= 2706 then
frame1 = Image.load("harehare/vlcsnap-00081.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2706 and currentTime <= 2739 then
frame1 = Image.load("harehare/vlcsnap-00082.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2739 and currentTime <= 2772 then
frame1 = Image.load("harehare/vlcsnap-00083.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2772 and currentTime <= 2805 then
frame1 = Image.load("harehare/vlcsnap-00084.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2805 and currentTime <= 2838 then
frame1 = Image.load("harehare/vlcsnap-00085.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2838 and currentTime <= 2871 then
frame1 = Image.load("harehare/vlcsnap-00086.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2871 and currentTime <= 2904 then
frame1 = Image.load("harehare/vlcsnap-00087.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2904 and currentTime <= 2937 then
frame1 = Image.load("harehare/vlcsnap-00088.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2937 and currentTime <= 2970 then
frame1 = Image.load("harehare/vlcsnap-00089.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2970 and currentTime <= 3003 then
frame1 = Image.load("harehare/vlcsnap-00090.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3003 and currentTime <= 3036 then
frame1 = Image.load("harehare/vlcsnap-00091.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3036 and currentTime <= 3069 then
frame1 = Image.load("harehare/vlcsnap-00092.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3069 and currentTime <= 3102 then
frame1 = Image.load("harehare/vlcsnap-00093.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3102 and currentTime <= 3135 then
frame1 = Image.load("harehare/vlcsnap-00094.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3135 and currentTime <= 3168 then
frame1 = Image.load("harehare/vlcsnap-00095.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3168 and currentTime <= 3201 then
frame1 = Image.load("harehare/vlcsnap-00096.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3201 and currentTime <= 3234 then
frame1 = Image.load("harehare/vlcsnap-00097.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3234 and currentTime <= 3267 then
frame1 = Image.load("harehare/vlcsnap-00098.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3267 and currentTime <= 3300 then
frame1 = Image.load("harehare/vlcsnap-00099.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3300 and currentTime <= 3333 then
frame1 = Image.load("harehare/vlcsnap-00100.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3333 and currentTime <= 3366 then
frame1 = Image.load("harehare/vlcsnap-00101.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3366 and currentTime <= 3399 then
frame1 = Image.load("harehare/vlcsnap-00102.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3399 and currentTime <= 3432 then
frame1 = Image.load("harehare/vlcsnap-00103.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3432 and currentTime <= 3465 then
frame1 = Image.load("harehare/vlcsnap-00104.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3465 and currentTime <= 3498 then
frame1 = Image.load("harehare/vlcsnap-00105.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3498 and currentTime <= 3531 then
frame1 = Image.load("harehare/vlcsnap-00106.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3531 and currentTime <= 3564 then
frame1 = Image.load("harehare/vlcsnap-00107.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3564 and currentTime <= 3597 then
frame1 = Image.load("harehare/vlcsnap-00108.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3597 and currentTime <= 3630 then
frame1 = Image.load("harehare/vlcsnap-00109.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3630 and currentTime <= 3663 then
frame1 = Image.load("harehare/vlcsnap-00110.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3663 and currentTime <= 3696 then
frame1 = Image.load("harehare/vlcsnap-00111.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3696 and currentTime <= 3729 then
frame1 = Image.load("harehare/vlcsnap-00112.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3729 and currentTime <= 3762 then
frame1 = Image.load("harehare/vlcsnap-00113.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3762 and currentTime <= 3795 then
frame1 = Image.load("harehare/vlcsnap-00114.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3795 and currentTime <= 3828 then
frame1 = Image.load("harehare/vlcsnap-00115.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3828 and currentTime <= 3861 then
frame1 = Image.load("harehare/vlcsnap-00116.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3861 and currentTime <= 3894 then
frame1 = Image.load("harehare/vlcsnap-00117.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3894 and currentTime <= 3927 then
frame1 = Image.load("harehare/vlcsnap-00118.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3927 and currentTime <= 3960 then
frame1 = Image.load("harehare/vlcsnap-00119.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3960 and currentTime <= 3993 then
frame1 = Image.load("harehare/vlcsnap-00120.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3993 and currentTime <= 4026 then
frame1 = Image.load("harehare/vlcsnap-00121.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4026 and currentTime <= 4059 then
frame1 = Image.load("harehare/vlcsnap-00122.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4059 and currentTime <= 4092 then
frame1 = Image.load("harehare/vlcsnap-00123.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4092 and currentTime <= 4125 then
frame1 = Image.load("harehare/vlcsnap-00124.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4125 and currentTime <= 4158 then
frame1 = Image.load("harehare/vlcsnap-00125.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4158 and currentTime <= 4191 then
frame1 = Image.load("harehare/vlcsnap-00126.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4191 and currentTime <= 4224 then
frame1 = Image.load("harehare/vlcsnap-00127.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4224 and currentTime <= 4257 then
frame1 = Image.load("harehare/vlcsnap-00128.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4257 and currentTime <= 4290 then
frame1 = Image.load("harehare/vlcsnap-00129.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4290 and currentTime <= 4323 then
frame1 = Image.load("harehare/vlcsnap-00130.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4323 and currentTime <= 4356 then
frame1 = Image.load("harehare/vlcsnap-00131.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4356 and currentTime <= 4389 then
frame1 = Image.load("harehare/vlcsnap-00132.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4389 and currentTime <= 4422 then
frame1 = Image.load("harehare/vlcsnap-00133.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4422 and currentTime <= 4455 then
frame1 = Image.load("harehare/vlcsnap-00134.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4455 and currentTime <= 4488 then
frame1 = Image.load("harehare/vlcsnap-00135.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4488 and currentTime <= 4521 then
frame1 = Image.load("harehare/vlcsnap-00136.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4521 and currentTime <= 4554 then
frame1 = Image.load("harehare/vlcsnap-00137.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4554 and currentTime <= 4587 then
frame1 = Image.load("harehare/vlcsnap-00138.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4587 and currentTime <= 4620 then
frame1 = Image.load("harehare/vlcsnap-00139.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4620 and currentTime <= 4653 then
frame1 = Image.load("harehare/vlcsnap-00140.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4653 and currentTime <= 4686 then
frame1 = Image.load("harehare/vlcsnap-00141.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4686 and currentTime <= 4719 then
frame1 = Image.load("harehare/vlcsnap-00142.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4719 and currentTime <= 4752 then
frame1 = Image.load("harehare/vlcsnap-00143.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4752 and currentTime <= 4785 then
frame1 = Image.load("harehare/vlcsnap-00144.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4785 and currentTime <= 4818 then
frame1 = Image.load("harehare/vlcsnap-00145.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4818 and currentTime <= 4851 then
frame1 = Image.load("harehare/vlcsnap-00146.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4851 and currentTime <= 4884 then
frame1 = Image.load("harehare/vlcsnap-00147.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4884 and currentTime <= 4917 then
frame1 = Image.load("harehare/vlcsnap-00148.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4917 and currentTime <= 4950 then
frame1 = Image.load("harehare/vlcsnap-00149.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4950 and currentTime <= 4983 then
frame1 = Image.load("harehare/vlcsnap-00150.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4983 and currentTime <= 5016 then
frame1 = Image.load("harehare/vlcsnap-00151.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5016 and currentTime <= 5049 then
frame1 = Image.load("harehare/vlcsnap-00152.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5049 and currentTime <= 5082 then
frame1 = Image.load("harehare/vlcsnap-00153.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5082 and currentTime <= 5115 then
frame1 = Image.load("harehare/vlcsnap-00154.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5115 and currentTime <= 5148 then
frame1 = Image.load("harehare/vlcsnap-00155.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5148 and currentTime <= 5181 then
frame1 = Image.load("harehare/vlcsnap-00156.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5181 and currentTime <= 5214 then
frame1 = Image.load("harehare/vlcsnap-00157.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5214 and currentTime <= 5247 then
frame1 = Image.load("harehare/vlcsnap-00158.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5247 and currentTime <= 5280 then
frame1 = Image.load("harehare/vlcsnap-00159.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5280 and currentTime <= 5313 then
frame1 = Image.load("harehare/vlcsnap-00160.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5313 and currentTime <= 5346 then
frame1 = Image.load("harehare/vlcsnap-00161.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5346 and currentTime <= 5379 then
frame1 = Image.load("harehare/vlcsnap-00162.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5379 and currentTime <= 5412 then
frame1 = Image.load("harehare/vlcsnap-00163.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5412 and currentTime <= 5445 then
frame1 = Image.load("harehare/vlcsnap-00164.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5445 and currentTime <= 5478 then
frame1 = Image.load("harehare/vlcsnap-00165.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5478 and currentTime <= 5511 then
frame1 = Image.load("harehare/vlcsnap-00166.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5511 and currentTime <= 5544 then
frame1 = Image.load("harehare/vlcsnap-00167.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5544 and currentTime <= 5577 then
frame1 = Image.load("harehare/vlcsnap-00168.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5577 and currentTime <= 5610 then
frame1 = Image.load("harehare/vlcsnap-00169.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5610 and currentTime <= 5643 then
frame1 = Image.load("harehare/vlcsnap-00170.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5643 and currentTime <= 5676 then
frame1 = Image.load("harehare/vlcsnap-00171.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5676 and currentTime <= 5709 then
frame1 = Image.load("harehare/vlcsnap-00172.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5709 and currentTime <= 5742 then
frame1 = Image.load("harehare/vlcsnap-00173.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5742 and currentTime <= 5775 then
frame1 = Image.load("harehare/vlcsnap-00174.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5775 and currentTime <= 5808 then
frame1 = Image.load("harehare/vlcsnap-00175.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5808 and currentTime <= 5841 then
frame1 = Image.load("harehare/vlcsnap-00176.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5841 and currentTime <= 5874 then
frame1 = Image.load("harehare/vlcsnap-00177.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5874 and currentTime <= 5907 then
frame1 = Image.load("harehare/vlcsnap-00178.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5907 and currentTime <= 5940 then
frame1 = Image.load("harehare/vlcsnap-00179.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5940 and currentTime <= 5973 then
frame1 = Image.load("harehare/vlcsnap-00180.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5973 and currentTime <= 6006 then
frame1 = Image.load("harehare/vlcsnap-00181.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6006 and currentTime <= 6039 then
frame1 = Image.load("harehare/vlcsnap-00182.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6039 and currentTime <= 6072 then
frame1 = Image.load("harehare/vlcsnap-00183.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6072 and currentTime <= 6105 then
frame1 = Image.load("harehare/vlcsnap-00184.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6105 and currentTime <= 6138 then
frame1 = Image.load("harehare/vlcsnap-00185.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6138 and currentTime <= 6171 then
frame1 = Image.load("harehare/vlcsnap-00186.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6171 and currentTime <= 6204 then
frame1 = Image.load("harehare/vlcsnap-00187.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6204 and currentTime <= 6237 then
frame1 = Image.load("harehare/vlcsnap-00188.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6237 and currentTime <= 6270 then
frame1 = Image.load("harehare/vlcsnap-00189.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6270 and currentTime <= 6303 then
frame1 = Image.load("harehare/vlcsnap-00190.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6303 and currentTime <= 6336 then
frame1 = Image.load("harehare/vlcsnap-00191.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6336 and currentTime <= 6369 then
frame1 = Image.load("harehare/vlcsnap-00192.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6369 and currentTime <= 6402 then
frame1 = Image.load("harehare/vlcsnap-00193.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6402 and currentTime <= 6435 then
frame1 = Image.load("harehare/vlcsnap-00194.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6435 and currentTime <= 6468 then
frame1 = Image.load("harehare/vlcsnap-00195.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6468 and currentTime <= 6501 then
frame1 = Image.load("harehare/vlcsnap-00196.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6501 and currentTime <= 6534 then
frame1 = Image.load("harehare/vlcsnap-00197.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6534 and currentTime <= 6567 then
frame1 = Image.load("harehare/vlcsnap-00198.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6567 and currentTime <= 6600 then
frame1 = Image.load("harehare/vlcsnap-00199.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6600 and currentTime <= 6633 then
frame1 = Image.load("harehare/vlcsnap-00200.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6633 and currentTime <= 6666 then
frame1 = Image.load("harehare/vlcsnap-00201.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6666 and currentTime <= 6699 then
frame1 = Image.load("harehare/vlcsnap-00202.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6699 and currentTime <= 6732 then
frame1 = Image.load("harehare/vlcsnap-00203.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6732 and currentTime <= 6765 then
frame1 = Image.load("harehare/vlcsnap-00204.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6765 and currentTime <= 6798 then
frame1 = Image.load("harehare/vlcsnap-00205.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6798 and currentTime <= 6831 then
frame1 = Image.load("harehare/vlcsnap-00206.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6831 and currentTime <= 6864 then
frame1 = Image.load("harehare/vlcsnap-00207.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6864 and currentTime <= 6897 then
frame1 = Image.load("harehare/vlcsnap-00208.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6897 and currentTime <= 6930 then
frame1 = Image.load("harehare/vlcsnap-00209.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6930 and currentTime <= 6963 then
frame1 = Image.load("harehare/vlcsnap-00210.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6963 and currentTime <= 6996 then
frame1 = Image.load("harehare/vlcsnap-00211.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6996 and currentTime <= 7029 then
frame1 = Image.load("harehare/vlcsnap-00212.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7029 and currentTime <= 7062 then
frame1 = Image.load("harehare/vlcsnap-00213.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7062 and currentTime <= 7095 then
frame1 = Image.load("harehare/vlcsnap-00214.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7095 and currentTime <= 7128 then
frame1 = Image.load("harehare/vlcsnap-00215.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7128 and currentTime <= 7161 then
frame1 = Image.load("harehare/vlcsnap-00216.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7161 and currentTime <= 7194 then
frame1 = Image.load("harehare/vlcsnap-00217.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7194 and currentTime <= 7227 then
frame1 = Image.load("harehare/vlcsnap-00218.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7227 and currentTime <= 7260 then
frame1 = Image.load("harehare/vlcsnap-00219.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7260 and currentTime <= 7293 then
frame1 = Image.load("harehare/vlcsnap-00220.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7293 and currentTime <= 7326 then
frame1 = Image.load("harehare/vlcsnap-00221.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7326 and currentTime <= 7359 then
frame1 = Image.load("harehare/vlcsnap-00222.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7359 and currentTime <= 7392 then
frame1 = Image.load("harehare/vlcsnap-00223.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7392 and currentTime <= 7425 then
frame1 = Image.load("harehare/vlcsnap-00224.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7425 and currentTime <= 7458 then
frame1 = Image.load("harehare/vlcsnap-00225.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7458 and currentTime <= 7491 then
frame1 = Image.load("harehare/vlcsnap-00226.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7491 and currentTime <= 7524 then
frame1 = Image.load("harehare/vlcsnap-00227.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7524 and currentTime <= 7557 then
frame1 = Image.load("harehare/vlcsnap-00228.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7557 and currentTime <= 7590 then
frame1 = Image.load("harehare/vlcsnap-00229.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7590 and currentTime <= 7623 then
frame1 = Image.load("harehare/vlcsnap-00230.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7623 and currentTime <= 7656 then
frame1 = Image.load("harehare/vlcsnap-00231.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7656 and currentTime <= 7689 then
frame1 = Image.load("harehare/vlcsnap-00232.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7689 and currentTime <= 7722 then
frame1 = Image.load("harehare/vlcsnap-00233.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7722 and currentTime <= 7755 then
frame1 = Image.load("harehare/vlcsnap-00234.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7755 and currentTime <= 7788 then
frame1 = Image.load("harehare/vlcsnap-00235.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7788 and currentTime <= 7821 then
frame1 = Image.load("harehare/vlcsnap-00236.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7821 and currentTime <= 7854 then
frame1 = Image.load("harehare/vlcsnap-00237.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7854 and currentTime <= 7887 then
frame1 = Image.load("harehare/vlcsnap-00238.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7887 and currentTime <= 7920 then
frame1 = Image.load("harehare/vlcsnap-00239.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7920 and currentTime <= 7953 then
frame1 = Image.load("harehare/vlcsnap-00240.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7953 and currentTime <= 7986 then
frame1 = Image.load("harehare/vlcsnap-00241.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7986 and currentTime <= 8019 then
frame1 = Image.load("harehare/vlcsnap-00242.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8019 and currentTime <= 8052 then
frame1 = Image.load("harehare/vlcsnap-00243.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8052 and currentTime <= 8085 then
frame1 = Image.load("harehare/vlcsnap-00244.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8085 and currentTime <= 8118 then
frame1 = Image.load("harehare/vlcsnap-00245.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8118 and currentTime <= 8151 then
frame1 = Image.load("harehare/vlcsnap-00246.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8151 and currentTime <= 8184 then
frame1 = Image.load("harehare/vlcsnap-00247.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8184 and currentTime <= 8217 then
frame1 = Image.load("harehare/vlcsnap-00248.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8217 and currentTime <= 8250 then
frame1 = Image.load("harehare/vlcsnap-00249.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8250 and currentTime <= 8283 then
frame1 = Image.load("harehare/vlcsnap-00250.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8283 and currentTime <= 8316 then
frame1 = Image.load("harehare/vlcsnap-00251.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8316 and currentTime <= 8349 then
frame1 = Image.load("harehare/vlcsnap-00252.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8349 and currentTime <= 8382 then
frame1 = Image.load("harehare/vlcsnap-00253.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8382 and currentTime <= 8415 then
frame1 = Image.load("harehare/vlcsnap-00254.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8415 and currentTime <= 8448 then
frame1 = Image.load("harehare/vlcsnap-00255.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8448 and currentTime <= 8481 then
frame1 = Image.load("harehare/vlcsnap-00256.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8481 and currentTime <= 8514 then
frame1 = Image.load("harehare/vlcsnap-00257.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8514 and currentTime <= 8547 then
frame1 = Image.load("harehare/vlcsnap-00258.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8547 and currentTime <= 8580 then
frame1 = Image.load("harehare/vlcsnap-00259.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8580 and currentTime <= 8613 then
frame1 = Image.load("harehare/vlcsnap-00260.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8613 and currentTime <= 8646 then
frame1 = Image.load("harehare/vlcsnap-00261.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8646 and currentTime <= 8679 then
frame1 = Image.load("harehare/vlcsnap-00262.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8679 and currentTime <= 8712 then
frame1 = Image.load("harehare/vlcsnap-00263.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8712 and currentTime <= 8745 then
frame1 = Image.load("harehare/vlcsnap-00264.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8745 and currentTime <= 8778 then
frame1 = Image.load("harehare/vlcsnap-00265.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8778 and currentTime <= 8811 then
frame1 = Image.load("harehare/vlcsnap-00266.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8811 and currentTime <= 8844 then
frame1 = Image.load("harehare/vlcsnap-00267.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8844 and currentTime <= 8877 then
frame1 = Image.load("harehare/vlcsnap-00268.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8877 and currentTime <= 8910 then
frame1 = Image.load("harehare/vlcsnap-00269.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8910 and currentTime <= 8943 then
frame1 = Image.load("harehare/vlcsnap-00270.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8943 and currentTime <= 8976 then
frame1 = Image.load("harehare/vlcsnap-00271.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8976 and currentTime <= 9009 then
frame1 = Image.load("harehare/vlcsnap-00272.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9009 and currentTime <= 9042 then
frame1 = Image.load("harehare/vlcsnap-00273.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9042 and currentTime <= 9075 then
frame1 = Image.load("harehare/vlcsnap-00274.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9075 and currentTime <= 9108 then
frame1 = Image.load("harehare/vlcsnap-00275.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9108 and currentTime <= 9141 then
frame1 = Image.load("harehare/vlcsnap-00276.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9141 and currentTime <= 9174 then
frame1 = Image.load("harehare/vlcsnap-00277.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9174 and currentTime <= 9207 then
frame1 = Image.load("harehare/vlcsnap-00278.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9207 and currentTime <= 9240 then
frame1 = Image.load("harehare/vlcsnap-00279.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9240 and currentTime <= 9273 then
frame1 = Image.load("harehare/vlcsnap-00280.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9273 and currentTime <= 9306 then
frame1 = Image.load("harehare/vlcsnap-00281.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9306 and currentTime <= 9339 then
frame1 = Image.load("harehare/vlcsnap-00282.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9339 and currentTime <= 9372 then
frame1 = Image.load("harehare/vlcsnap-00283.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9372 and currentTime <= 9405 then
frame1 = Image.load("harehare/vlcsnap-00284.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9405 and currentTime <= 9438 then
frame1 = Image.load("harehare/vlcsnap-00285.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9438 and currentTime <= 9471 then
frame1 = Image.load("harehare/vlcsnap-00286.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9471 and currentTime <= 9504 then
frame1 = Image.load("harehare/vlcsnap-00287.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9504 and currentTime <= 9537 then
frame1 = Image.load("harehare/vlcsnap-00288.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9537 and currentTime <= 9570 then
frame1 = Image.load("harehare/vlcsnap-00289.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9570 and currentTime <= 9603 then
frame1 = Image.load("harehare/vlcsnap-00290.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9603 and currentTime <= 9636 then
frame1 = Image.load("harehare/vlcsnap-00291.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9636 and currentTime <= 9669 then
frame1 = Image.load("harehare/vlcsnap-00292.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9669 and currentTime <= 9702 then
frame1 = Image.load("harehare/vlcsnap-00293.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9702 and currentTime <= 9735 then
frame1 = Image.load("harehare/vlcsnap-00294.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9735 and currentTime <= 9768 then
frame1 = Image.load("harehare/vlcsnap-00295.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9768 and currentTime <= 9801 then
frame1 = Image.load("harehare/vlcsnap-00296.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9801 and currentTime <= 9834 then
frame1 = Image.load("harehare/vlcsnap-00297.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9834 and currentTime <= 9867 then
frame1 = Image.load("harehare/vlcsnap-00298.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9867 and currentTime <= 9900 then
frame1 = Image.load("harehare/vlcsnap-00299.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9900 and currentTime <= 9933 then
frame1 = Image.load("harehare/vlcsnap-00300.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9933 and currentTime <= 9966 then
frame1 = Image.load("harehare/vlcsnap-00301.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9966 and currentTime <= 9999 then
frame1 = Image.load("harehare/vlcsnap-00302.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9999 and currentTime <= 10032 then
frame1 = Image.load("harehare/vlcsnap-00303.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10032 and currentTime <= 10065 then
frame1 = Image.load("harehare/vlcsnap-00304.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10065 and currentTime <= 10098 then
frame1 = Image.load("harehare/vlcsnap-00305.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10098 and currentTime <= 10131 then
frame1 = Image.load("harehare/vlcsnap-00306.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10131 and currentTime <= 10164 then
frame1 = Image.load("harehare/vlcsnap-00307.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10164 and currentTime <= 10197 then
frame1 = Image.load("harehare/vlcsnap-00308.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10197 and currentTime <= 10230 then
frame1 = Image.load("harehare/vlcsnap-00309.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10230 and currentTime <= 10263 then
frame1 = Image.load("harehare/vlcsnap-00310.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10263 and currentTime <= 10296 then
frame1 = Image.load("harehare/vlcsnap-00311.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10296 and currentTime <= 10329 then
frame1 = Image.load("harehare/vlcsnap-00312.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10329 and currentTime <= 10362 then
frame1 = Image.load("harehare/vlcsnap-00313.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10362 and currentTime <= 10395 then
frame1 = Image.load("harehare/vlcsnap-00314.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10395 and currentTime <= 10428 then
frame1 = Image.load("harehare/vlcsnap-00315.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10428 and currentTime <= 10461 then
frame1 = Image.load("harehare/vlcsnap-00316.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10461 and currentTime <= 10494 then
frame1 = Image.load("harehare/vlcsnap-00317.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10494 and currentTime <= 10527 then
frame1 = Image.load("harehare/vlcsnap-00318.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10527 and currentTime <= 10560 then
frame1 = Image.load("harehare/vlcsnap-00319.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10560 and currentTime <= 10593 then
frame1 = Image.load("harehare/vlcsnap-00320.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10593 and currentTime <= 10626 then
frame1 = Image.load("harehare/vlcsnap-00321.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10626 and currentTime <= 10659 then
frame1 = Image.load("harehare/vlcsnap-00322.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10659 and currentTime <= 10692 then
frame1 = Image.load("harehare/vlcsnap-00323.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10692 and currentTime <= 10725 then
frame1 = Image.load("harehare/vlcsnap-00324.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10725 and currentTime <= 10758 then
frame1 = Image.load("harehare/vlcsnap-00325.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10758 and currentTime <= 10791 then
frame1 = Image.load("harehare/vlcsnap-00326.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10791 and currentTime <= 10824 then
frame1 = Image.load("harehare/vlcsnap-00327.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10824 and currentTime <= 10857 then
frame1 = Image.load("harehare/vlcsnap-00328.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10857 and currentTime <= 10890 then
frame1 = Image.load("harehare/vlcsnap-00329.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10890 and currentTime <= 10923 then
frame1 = Image.load("harehare/vlcsnap-00330.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10923 and currentTime <= 10956 then
frame1 = Image.load("harehare/vlcsnap-00331.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10956 and currentTime <= 10989 then
frame1 = Image.load("harehare/vlcsnap-00332.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10989 and currentTime <= 11022 then
frame1 = Image.load("harehare/vlcsnap-00333.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11022 and currentTime <= 11055 then
frame1 = Image.load("harehare/vlcsnap-00334.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11055 and currentTime <= 11088 then
frame1 = Image.load("harehare/vlcsnap-00335.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11088 and currentTime <= 11121 then
frame1 = Image.load("harehare/vlcsnap-00336.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11121 and currentTime <= 11154 then
frame1 = Image.load("harehare/vlcsnap-00337.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11154 and currentTime <= 11187 then
frame1 = Image.load("harehare/vlcsnap-00338.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11187 and currentTime <= 11220 then
frame1 = Image.load("harehare/vlcsnap-00339.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11220 and currentTime <= 11253 then
frame1 = Image.load("harehare/vlcsnap-00340.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11253 and currentTime <= 11286 then
frame1 = Image.load("harehare/vlcsnap-00341.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11286 and currentTime <= 11319 then
frame1 = Image.load("harehare/vlcsnap-00342.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11319 and currentTime <= 11352 then
frame1 = Image.load("harehare/vlcsnap-00343.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11352 and currentTime <= 11385 then
frame1 = Image.load("harehare/vlcsnap-00344.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11385 and currentTime <= 11418 then
frame1 = Image.load("harehare/vlcsnap-00345.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11418 and currentTime <= 11451 then
frame1 = Image.load("harehare/vlcsnap-00346.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11451 and currentTime <= 11484 then
frame1 = Image.load("harehare/vlcsnap-00347.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11484 and currentTime <= 11517 then
frame1 = Image.load("harehare/vlcsnap-00348.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11517 and currentTime <= 11550 then
frame1 = Image.load("harehare/vlcsnap-00349.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11550 and currentTime <= 11583 then
frame1 = Image.load("harehare/vlcsnap-00350.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11583 and currentTime <= 11616 then
frame1 = Image.load("harehare/vlcsnap-00351.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11616 and currentTime <= 11649 then
frame1 = Image.load("harehare/vlcsnap-00352.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11649 and currentTime <= 11682 then
frame1 = Image.load("harehare/vlcsnap-00353.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11682 and currentTime <= 11715 then
frame1 = Image.load("harehare/vlcsnap-00354.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11715 and currentTime <= 11748 then
frame1 = Image.load("harehare/vlcsnap-00355.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11748 and currentTime <= 11781 then
frame1 = Image.load("harehare/vlcsnap-00356.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11781 and currentTime <= 11814 then
frame1 = Image.load("harehare/vlcsnap-00357.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11814 and currentTime <= 11847 then
frame1 = Image.load("harehare/vlcsnap-00358.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11847 and currentTime <= 11880 then
frame1 = Image.load("harehare/vlcsnap-00359.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11880 and currentTime <= 11913 then
frame1 = Image.load("harehare/vlcsnap-00360.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11913 and currentTime <= 11946 then
frame1 = Image.load("harehare/vlcsnap-00361.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11946 and currentTime <= 11979 then
frame1 = Image.load("harehare/vlcsnap-00362.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11979 and currentTime <= 12012 then
frame1 = Image.load("harehare/vlcsnap-00363.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12012 and currentTime <= 12045 then
frame1 = Image.load("harehare/vlcsnap-00364.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12045 and currentTime <= 12078 then
frame1 = Image.load("harehare/vlcsnap-00365.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12078 and currentTime <= 12111 then
frame1 = Image.load("harehare/vlcsnap-00366.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12111 and currentTime <= 12144 then
frame1 = Image.load("harehare/vlcsnap-00367.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12144 and currentTime <= 12177 then
frame1 = Image.load("harehare/vlcsnap-00368.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12177 and currentTime <= 12210 then
frame1 = Image.load("harehare/vlcsnap-00369.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12210 and currentTime <= 12243 then
frame1 = Image.load("harehare/vlcsnap-00370.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12243 and currentTime <= 12276 then
frame1 = Image.load("harehare/vlcsnap-00371.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12276 and currentTime <= 12309 then
frame1 = Image.load("harehare/vlcsnap-00372.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12309 and currentTime <= 12342 then
frame1 = Image.load("harehare/vlcsnap-00373.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12342 and currentTime <= 12375 then
frame1 = Image.load("harehare/vlcsnap-00374.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12375 and currentTime <= 12408 then
frame1 = Image.load("harehare/vlcsnap-00375.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12408 and currentTime <= 12441 then
frame1 = Image.load("harehare/vlcsnap-00376.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12441 and currentTime <= 12474 then
frame1 = Image.load("harehare/vlcsnap-00377.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12474 and currentTime <= 12507 then
frame1 = Image.load("harehare/vlcsnap-00378.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12507 and currentTime <= 12540 then
frame1 = Image.load("harehare/vlcsnap-00379.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12540 and currentTime <= 12573 then
frame1 = Image.load("harehare/vlcsnap-00380.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12573 and currentTime <= 12606 then
frame1 = Image.load("harehare/vlcsnap-00381.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12606 and currentTime <= 12639 then
frame1 = Image.load("harehare/vlcsnap-00382.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12639 and currentTime <= 12672 then
frame1 = Image.load("harehare/vlcsnap-00383.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12672 and currentTime <= 12705 then
frame1 = Image.load("harehare/vlcsnap-00384.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12705 and currentTime <= 12738 then
frame1 = Image.load("harehare/vlcsnap-00385.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12738 and currentTime <= 12771 then
frame1 = Image.load("harehare/vlcsnap-00386.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12771 and currentTime <= 12804 then
frame1 = Image.load("harehare/vlcsnap-00387.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12804 and currentTime <= 12837 then
frame1 = Image.load("harehare/vlcsnap-00388.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12837 and currentTime <= 12870 then
frame1 = Image.load("harehare/vlcsnap-00389.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12870 and currentTime <= 12903 then
frame1 = Image.load("harehare/vlcsnap-00390.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12903 and currentTime <= 12936 then
frame1 = Image.load("harehare/vlcsnap-00391.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12936 and currentTime <= 12969 then
frame1 = Image.load("harehare/vlcsnap-00392.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 12969 and currentTime <= 13002 then
frame1 = Image.load("harehare/vlcsnap-00393.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13002 and currentTime <= 13035 then
frame1 = Image.load("harehare/vlcsnap-00394.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13035 and currentTime <= 13068 then
frame1 = Image.load("harehare/vlcsnap-00395.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13068 and currentTime <= 13101 then
frame1 = Image.load("harehare/vlcsnap-00396.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13101 and currentTime <= 13134 then
frame1 = Image.load("harehare/vlcsnap-00397.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13134 and currentTime <= 13167 then
frame1 = Image.load("harehare/vlcsnap-00398.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13167 and currentTime <= 13200 then
frame1 = Image.load("harehare/vlcsnap-00399.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13200 and currentTime <= 13233 then
frame1 = Image.load("harehare/vlcsnap-00400.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13233 and currentTime <= 13266 then
frame1 = Image.load("harehare/vlcsnap-00401.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13266 and currentTime <= 13299 then
frame1 = Image.load("harehare/vlcsnap-00402.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13299 and currentTime <= 13332 then
frame1 = Image.load("harehare/vlcsnap-00403.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13332 and currentTime <= 13365 then
frame1 = Image.load("harehare/vlcsnap-00404.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13365 and currentTime <= 13398 then
frame1 = Image.load("harehare/vlcsnap-00405.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13398 and currentTime <= 13431 then
frame1 = Image.load("harehare/vlcsnap-00406.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13431 and currentTime <= 13464 then
frame1 = Image.load("harehare/vlcsnap-00407.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13464 and currentTime <= 13497 then
frame1 = Image.load("harehare/vlcsnap-00408.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13497 and currentTime <= 13530 then
frame1 = Image.load("harehare/vlcsnap-00409.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13530 and currentTime <= 13563 then
frame1 = Image.load("harehare/vlcsnap-00410.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13563 and currentTime <= 13596 then
frame1 = Image.load("harehare/vlcsnap-00411.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13596 and currentTime <= 13629 then
frame1 = Image.load("harehare/vlcsnap-00412.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13629 and currentTime <= 13662 then
frame1 = Image.load("harehare/vlcsnap-00413.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13662 and currentTime <= 13695 then
frame1 = Image.load("harehare/vlcsnap-00414.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13695 and currentTime <= 13728 then
frame1 = Image.load("harehare/vlcsnap-00415.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13728 and currentTime <= 13761 then
frame1 = Image.load("harehare/vlcsnap-00416.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13761 and currentTime <= 13794 then
frame1 = Image.load("harehare/vlcsnap-00417.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13794 and currentTime <= 13827 then
frame1 = Image.load("harehare/vlcsnap-00418.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13827 and currentTime <= 13860 then
frame1 = Image.load("harehare/vlcsnap-00419.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13860 and currentTime <= 13893 then
frame1 = Image.load("harehare/vlcsnap-00420.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13893 and currentTime <= 13926 then
frame1 = Image.load("harehare/vlcsnap-00421.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13926 and currentTime <= 13959 then
frame1 = Image.load("harehare/vlcsnap-00422.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13959 and currentTime <= 13992 then
frame1 = Image.load("harehare/vlcsnap-00423.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 13992 and currentTime <= 14025 then
frame1 = Image.load("harehare/vlcsnap-00424.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14025 and currentTime <= 14058 then
frame1 = Image.load("harehare/vlcsnap-00425.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14058 and currentTime <= 14091 then
frame1 = Image.load("harehare/vlcsnap-00426.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14091 and currentTime <= 14124 then
frame1 = Image.load("harehare/vlcsnap-00427.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14124 and currentTime <= 14157 then
frame1 = Image.load("harehare/vlcsnap-00428.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14157 and currentTime <= 14190 then
frame1 = Image.load("harehare/vlcsnap-00429.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14190 and currentTime <= 14223 then
frame1 = Image.load("harehare/vlcsnap-00430.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14223 and currentTime <= 14256 then
frame1 = Image.load("harehare/vlcsnap-00431.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14256 and currentTime <= 14289 then
frame1 = Image.load("harehare/vlcsnap-00432.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14289 and currentTime <= 14322 then
frame1 = Image.load("harehare/vlcsnap-00433.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14322 and currentTime <= 14355 then
frame1 = Image.load("harehare/vlcsnap-00434.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14355 and currentTime <= 14388 then
frame1 = Image.load("harehare/vlcsnap-00435.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14388 and currentTime <= 14421 then
frame1 = Image.load("harehare/vlcsnap-00436.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14421 and currentTime <= 14454 then
frame1 = Image.load("harehare/vlcsnap-00437.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14454 and currentTime <= 14487 then
frame1 = Image.load("harehare/vlcsnap-00438.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14487 and currentTime <= 14520 then
frame1 = Image.load("harehare/vlcsnap-00439.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14520 and currentTime <= 14553 then
frame1 = Image.load("harehare/vlcsnap-00440.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14553 and currentTime <= 14586 then
frame1 = Image.load("harehare/vlcsnap-00441.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14586 and currentTime <= 14619 then
frame1 = Image.load("harehare/vlcsnap-00442.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14619 and currentTime <= 14652 then
frame1 = Image.load("harehare/vlcsnap-00443.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14652 and currentTime <= 14685 then
frame1 = Image.load("harehare/vlcsnap-00444.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14685 and currentTime <= 14718 then
frame1 = Image.load("harehare/vlcsnap-00445.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14718 and currentTime <= 14751 then
frame1 = Image.load("harehare/vlcsnap-00446.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14751 and currentTime <= 14784 then
frame1 = Image.load("harehare/vlcsnap-00447.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14784 and currentTime <= 14817 then
frame1 = Image.load("harehare/vlcsnap-00448.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14817 and currentTime <= 14850 then
frame1 = Image.load("harehare/vlcsnap-00449.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14850 and currentTime <= 14883 then
frame1 = Image.load("harehare/vlcsnap-00450.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14883 and currentTime <= 14916 then
frame1 = Image.load("harehare/vlcsnap-00451.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14916 and currentTime <= 14949 then
frame1 = Image.load("harehare/vlcsnap-00452.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14949 and currentTime <= 14982 then
frame1 = Image.load("harehare/vlcsnap-00453.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 14982 and currentTime <= 15015 then
frame1 = Image.load("harehare/vlcsnap-00454.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15015 and currentTime <= 15048 then
frame1 = Image.load("harehare/vlcsnap-00455.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15048 and currentTime <= 15081 then
frame1 = Image.load("harehare/vlcsnap-00456.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15081 and currentTime <= 15114 then
frame1 = Image.load("harehare/vlcsnap-00457.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15114 and currentTime <= 15147 then
frame1 = Image.load("harehare/vlcsnap-00458.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15147 and currentTime <= 15180 then
frame1 = Image.load("harehare/vlcsnap-00459.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15180 and currentTime <= 15213 then
frame1 = Image.load("harehare/vlcsnap-00460.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15213 and currentTime <= 15246 then
frame1 = Image.load("harehare/vlcsnap-00461.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15246 and currentTime <= 15279 then
frame1 = Image.load("harehare/vlcsnap-00462.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15279 and currentTime <= 15312 then
frame1 = Image.load("harehare/vlcsnap-00463.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15312 and currentTime <= 15345 then
frame1 = Image.load("harehare/vlcsnap-00464.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15345 and currentTime <= 15378 then
frame1 = Image.load("harehare/vlcsnap-00465.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15378 and currentTime <= 15411 then
frame1 = Image.load("harehare/vlcsnap-00466.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15411 and currentTime <= 15444 then
frame1 = Image.load("harehare/vlcsnap-00467.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15444 and currentTime <= 15477 then
frame1 = Image.load("harehare/vlcsnap-00468.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15477 and currentTime <= 15510 then
frame1 = Image.load("harehare/vlcsnap-00469.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15510 and currentTime <= 15543 then
frame1 = Image.load("harehare/vlcsnap-00470.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15543 and currentTime <= 15576 then
frame1 = Image.load("harehare/vlcsnap-00471.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15576 and currentTime <= 15609 then
frame1 = Image.load("harehare/vlcsnap-00472.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15609 and currentTime <= 15642 then
frame1 = Image.load("harehare/vlcsnap-00473.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15642 and currentTime <= 15675 then
frame1 = Image.load("harehare/vlcsnap-00474.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15675 and currentTime <= 15708 then
frame1 = Image.load("harehare/vlcsnap-00475.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15708 and currentTime <= 15741 then
frame1 = Image.load("harehare/vlcsnap-00476.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15741 and currentTime <= 15774 then
frame1 = Image.load("harehare/vlcsnap-00477.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15774 and currentTime <= 15807 then
frame1 = Image.load("harehare/vlcsnap-00478.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15807 and currentTime <= 15840 then
frame1 = Image.load("harehare/vlcsnap-00479.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15840 and currentTime <= 15873 then
frame1 = Image.load("harehare/vlcsnap-00480.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15873 and currentTime <= 15906 then
frame1 = Image.load("harehare/vlcsnap-00481.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15906 and currentTime <= 15939 then
frame1 = Image.load("harehare/vlcsnap-00482.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15939 and currentTime <= 15972 then
frame1 = Image.load("harehare/vlcsnap-00483.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 15972 and currentTime <= 16005 then
frame1 = Image.load("harehare/vlcsnap-00484.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16005 and currentTime <= 16038 then
frame1 = Image.load("harehare/vlcsnap-00485.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16038 and currentTime <= 16071 then
frame1 = Image.load("harehare/vlcsnap-00486.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16071 and currentTime <= 16104 then
frame1 = Image.load("harehare/vlcsnap-00487.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16104 and currentTime <= 16137 then
frame1 = Image.load("harehare/vlcsnap-00488.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16137 and currentTime <= 16170 then
frame1 = Image.load("harehare/vlcsnap-00489.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16170 and currentTime <= 16203 then
frame1 = Image.load("harehare/vlcsnap-00490.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16203 and currentTime <= 16236 then
frame1 = Image.load("harehare/vlcsnap-00491.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16236 and currentTime <= 16269 then
frame1 = Image.load("harehare/vlcsnap-00492.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16269 and currentTime <= 16302 then
frame1 = Image.load("harehare/vlcsnap-00493.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16302 and currentTime <= 16335 then
frame1 = Image.load("harehare/vlcsnap-00494.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16335 and currentTime <= 16368 then
frame1 = Image.load("harehare/vlcsnap-00495.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16368 and currentTime <= 16401 then
frame1 = Image.load("harehare/vlcsnap-00496.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16401 and currentTime <= 16434 then
frame1 = Image.load("harehare/vlcsnap-00497.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16434 and currentTime <= 16467 then
frame1 = Image.load("harehare/vlcsnap-00498.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16467 and currentTime <= 16500 then
frame1 = Image.load("harehare/vlcsnap-00499.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16500 and currentTime <= 16533 then
frame1 = Image.load("harehare/vlcsnap-00500.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16533 and currentTime <= 16566 then
frame1 = Image.load("harehare/vlcsnap-00501.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16566 and currentTime <= 16599 then
frame1 = Image.load("harehare/vlcsnap-00502.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16599 and currentTime <= 16632 then
frame1 = Image.load("harehare/vlcsnap-00503.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16632 and currentTime <= 16665 then
frame1 = Image.load("harehare/vlcsnap-00504.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16665 and currentTime <= 16698 then
frame1 = Image.load("harehare/vlcsnap-00505.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16698 and currentTime <= 16731 then
frame1 = Image.load("harehare/vlcsnap-00506.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16731 and currentTime <= 16764 then
frame1 = Image.load("harehare/vlcsnap-00507.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16764 and currentTime <= 16797 then
frame1 = Image.load("harehare/vlcsnap-00508.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16797 and currentTime <= 16830 then
frame1 = Image.load("harehare/vlcsnap-00509.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16830 and currentTime <= 16863 then
frame1 = Image.load("harehare/vlcsnap-00510.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16863 and currentTime <= 16896 then
frame1 = Image.load("harehare/vlcsnap-00511.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16896 and currentTime <= 16929 then
frame1 = Image.load("harehare/vlcsnap-00512.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16929 and currentTime <= 16962 then
frame1 = Image.load("harehare/vlcsnap-00513.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16962 and currentTime <= 16995 then
frame1 = Image.load("harehare/vlcsnap-00514.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 16995 and currentTime <= 17028 then
frame1 = Image.load("harehare/vlcsnap-00515.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17028 and currentTime <= 17061 then
frame1 = Image.load("harehare/vlcsnap-00516.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17061 and currentTime <= 17094 then
frame1 = Image.load("harehare/vlcsnap-00517.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17094 and currentTime <= 17127 then
frame1 = Image.load("harehare/vlcsnap-00518.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17127 and currentTime <= 17160 then
frame1 = Image.load("harehare/vlcsnap-00519.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17160 and currentTime <= 17193 then
frame1 = Image.load("harehare/vlcsnap-00520.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17193 and currentTime <= 17226 then
frame1 = Image.load("harehare/vlcsnap-00521.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17226 and currentTime <= 17259 then
frame1 = Image.load("harehare/vlcsnap-00522.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17259 and currentTime <= 17292 then
frame1 = Image.load("harehare/vlcsnap-00523.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17292 and currentTime <= 17325 then
frame1 = Image.load("harehare/vlcsnap-00524.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17325 and currentTime <= 17358 then
frame1 = Image.load("harehare/vlcsnap-00525.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17358 and currentTime <= 17391 then
frame1 = Image.load("harehare/vlcsnap-00526.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17391 and currentTime <= 17424 then
frame1 = Image.load("harehare/vlcsnap-00527.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17424 and currentTime <= 17457 then
frame1 = Image.load("harehare/vlcsnap-00528.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17457 and currentTime <= 17490 then
frame1 = Image.load("harehare/vlcsnap-00529.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17490 and currentTime <= 17523 then
frame1 = Image.load("harehare/vlcsnap-00530.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17523 and currentTime <= 17556 then
frame1 = Image.load("harehare/vlcsnap-00531.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17556 and currentTime <= 17589 then
frame1 = Image.load("harehare/vlcsnap-00532.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17589 and currentTime <= 17622 then
frame1 = Image.load("harehare/vlcsnap-00533.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17622 and currentTime <= 17655 then
frame1 = Image.load("harehare/vlcsnap-00534.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17655 and currentTime <= 17688 then
frame1 = Image.load("harehare/vlcsnap-00535.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17688 and currentTime <= 17721 then
frame1 = Image.load("harehare/vlcsnap-00536.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17721 and currentTime <= 17754 then
frame1 = Image.load("harehare/vlcsnap-00537.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17754 and currentTime <= 17787 then
frame1 = Image.load("harehare/vlcsnap-00538.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17787 and currentTime <= 17820 then
frame1 = Image.load("harehare/vlcsnap-00539.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17820 and currentTime <= 17853 then
frame1 = Image.load("harehare/vlcsnap-00540.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17853 and currentTime <= 17886 then
frame1 = Image.load("harehare/vlcsnap-00541.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17886 and currentTime <= 17919 then
frame1 = Image.load("harehare/vlcsnap-00542.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17919 and currentTime <= 17952 then
frame1 = Image.load("harehare/vlcsnap-00543.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17952 and currentTime <= 17985 then
frame1 = Image.load("harehare/vlcsnap-00544.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 17985 and currentTime <= 18018 then
frame1 = Image.load("harehare/vlcsnap-00545.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18018 and currentTime <= 18051 then
frame1 = Image.load("harehare/vlcsnap-00546.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18051 and currentTime <= 18084 then
frame1 = Image.load("harehare/vlcsnap-00547.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18084 and currentTime <= 18117 then
frame1 = Image.load("harehare/vlcsnap-00548.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18117 and currentTime <= 18150 then
frame1 = Image.load("harehare/vlcsnap-00549.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18150 and currentTime <= 18183 then
frame1 = Image.load("harehare/vlcsnap-00550.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18183 and currentTime <= 18216 then
frame1 = Image.load("harehare/vlcsnap-00551.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18216 and currentTime <= 18249 then
frame1 = Image.load("harehare/vlcsnap-00552.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18249 and currentTime <= 18282 then
frame1 = Image.load("harehare/vlcsnap-00553.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18282 and currentTime <= 18315 then
frame1 = Image.load("harehare/vlcsnap-00554.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18315 and currentTime <= 18348 then
frame1 = Image.load("harehare/vlcsnap-00555.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18348 and currentTime <= 18381 then
frame1 = Image.load("harehare/vlcsnap-00556.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18381 and currentTime <= 18414 then
frame1 = Image.load("harehare/vlcsnap-00557.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18414 and currentTime <= 18447 then
frame1 = Image.load("harehare/vlcsnap-00558.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18447 and currentTime <= 18480 then
frame1 = Image.load("harehare/vlcsnap-00559.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18480 and currentTime <= 18513 then
frame1 = Image.load("harehare/vlcsnap-00560.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18513 and currentTime <= 18546 then
frame1 = Image.load("harehare/vlcsnap-00561.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18546 and currentTime <= 18579 then
frame1 = Image.load("harehare/vlcsnap-00562.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18579 and currentTime <= 18612 then
frame1 = Image.load("harehare/vlcsnap-00563.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18612 and currentTime <= 18645 then
frame1 = Image.load("harehare/vlcsnap-00564.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18645 and currentTime <= 18678 then
frame1 = Image.load("harehare/vlcsnap-00565.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18678 and currentTime <= 18711 then
frame1 = Image.load("harehare/vlcsnap-00566.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18711 and currentTime <= 18744 then
frame1 = Image.load("harehare/vlcsnap-00567.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18744 and currentTime <= 18777 then
frame1 = Image.load("harehare/vlcsnap-00568.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18777 and currentTime <= 18810 then
frame1 = Image.load("harehare/vlcsnap-00569.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18810 and currentTime <= 18843 then
frame1 = Image.load("harehare/vlcsnap-00570.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18843 and currentTime <= 18876 then
frame1 = Image.load("harehare/vlcsnap-00571.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18876 and currentTime <= 18909 then
frame1 = Image.load("harehare/vlcsnap-00572.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18909 and currentTime <= 18942 then
frame1 = Image.load("harehare/vlcsnap-00573.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18942 and currentTime <= 18975 then
frame1 = Image.load("harehare/vlcsnap-00574.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 18975 and currentTime <= 19008 then
frame1 = Image.load("harehare/vlcsnap-00575.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19008 and currentTime <= 19041 then
frame1 = Image.load("harehare/vlcsnap-00576.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19041 and currentTime <= 19074 then
frame1 = Image.load("harehare/vlcsnap-00577.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19074 and currentTime <= 19107 then
frame1 = Image.load("harehare/vlcsnap-00578.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19107 and currentTime <= 19140 then
frame1 = Image.load("harehare/vlcsnap-00579.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19140 and currentTime <= 19173 then
frame1 = Image.load("harehare/vlcsnap-00580.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19173 and currentTime <= 19206 then
frame1 = Image.load("harehare/vlcsnap-00581.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19206 and currentTime <= 19239 then
frame1 = Image.load("harehare/vlcsnap-00582.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19239 and currentTime <= 19272 then
frame1 = Image.load("harehare/vlcsnap-00583.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19272 and currentTime <= 19305 then
frame1 = Image.load("harehare/vlcsnap-00584.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19305 and currentTime <= 19338 then
frame1 = Image.load("harehare/vlcsnap-00585.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19338 and currentTime <= 19371 then
frame1 = Image.load("harehare/vlcsnap-00586.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19371 and currentTime <= 19404 then
frame1 = Image.load("harehare/vlcsnap-00587.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19404 and currentTime <= 19437 then
frame1 = Image.load("harehare/vlcsnap-00588.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19437 and currentTime <= 19470 then
frame1 = Image.load("harehare/vlcsnap-00589.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19470 and currentTime <= 19503 then
frame1 = Image.load("harehare/vlcsnap-00590.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19503 and currentTime <= 19536 then
frame1 = Image.load("harehare/vlcsnap-00591.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19536 and currentTime <= 19569 then
frame1 = Image.load("harehare/vlcsnap-00592.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19569 and currentTime <= 19602 then
frame1 = Image.load("harehare/vlcsnap-00593.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19602 and currentTime <= 19635 then
frame1 = Image.load("harehare/vlcsnap-00594.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19635 and currentTime <= 19668 then
frame1 = Image.load("harehare/vlcsnap-00595.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19668 and currentTime <= 19701 then
frame1 = Image.load("harehare/vlcsnap-00596.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19701 and currentTime <= 19734 then
frame1 = Image.load("harehare/vlcsnap-00597.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19734 and currentTime <= 19767 then
frame1 = Image.load("harehare/vlcsnap-00598.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19767 and currentTime <= 19800 then
frame1 = Image.load("harehare/vlcsnap-00599.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19800 and currentTime <= 19833 then
frame1 = Image.load("harehare/vlcsnap-00600.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19833 and currentTime <= 19866 then
frame1 = Image.load("harehare/vlcsnap-00601.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19866 and currentTime <= 19899 then
frame1 = Image.load("harehare/vlcsnap-00602.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19899 and currentTime <= 19932 then
frame1 = Image.load("harehare/vlcsnap-00603.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19932 and currentTime <= 19965 then
frame1 = Image.load("harehare/vlcsnap-00604.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19965 and currentTime <= 19998 then
frame1 = Image.load("harehare/vlcsnap-00605.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 19998 and currentTime <= 20031 then
frame1 = Image.load("harehare/vlcsnap-00606.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20031 and currentTime <= 20064 then
frame1 = Image.load("harehare/vlcsnap-00607.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20064 and currentTime <= 20097 then
frame1 = Image.load("harehare/vlcsnap-00608.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20097 and currentTime <= 20130 then
frame1 = Image.load("harehare/vlcsnap-00609.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20130 and currentTime <= 20163 then
frame1 = Image.load("harehare/vlcsnap-00610.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20163 and currentTime <= 20196 then
frame1 = Image.load("harehare/vlcsnap-00611.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20196 and currentTime <= 20229 then
frame1 = Image.load("harehare/vlcsnap-00612.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20229 and currentTime <= 20262 then
frame1 = Image.load("harehare/vlcsnap-00613.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20262 and currentTime <= 20295 then
frame1 = Image.load("harehare/vlcsnap-00614.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20295 and currentTime <= 20328 then
frame1 = Image.load("harehare/vlcsnap-00615.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20328 and currentTime <= 20361 then
frame1 = Image.load("harehare/vlcsnap-00616.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20361 and currentTime <= 20394 then
frame1 = Image.load("harehare/vlcsnap-00617.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20394 and currentTime <= 20427 then
frame1 = Image.load("harehare/vlcsnap-00618.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20427 and currentTime <= 20460 then
frame1 = Image.load("harehare/vlcsnap-00619.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20460 and currentTime <= 20493 then
frame1 = Image.load("harehare/vlcsnap-00620.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20493 and currentTime <= 20526 then
frame1 = Image.load("harehare/vlcsnap-00621.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20526 and currentTime <= 20559 then
frame1 = Image.load("harehare/vlcsnap-00622.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20559 and currentTime <= 20592 then
frame1 = Image.load("harehare/vlcsnap-00623.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20592 and currentTime <= 20625 then
frame1 = Image.load("harehare/vlcsnap-00624.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20625 and currentTime <= 20658 then
frame1 = Image.load("harehare/vlcsnap-00625.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20658 and currentTime <= 20691 then
frame1 = Image.load("harehare/vlcsnap-00626.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20691 and currentTime <= 20724 then
frame1 = Image.load("harehare/vlcsnap-00627.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20724 and currentTime <= 20757 then
frame1 = Image.load("harehare/vlcsnap-00628.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20757 and currentTime <= 20790 then
frame1 = Image.load("harehare/vlcsnap-00629.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20790 and currentTime <= 20823 then
frame1 = Image.load("harehare/vlcsnap-00630.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20823 and currentTime <= 20856 then
frame1 = Image.load("harehare/vlcsnap-00631.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20856 and currentTime <= 20889 then
frame1 = Image.load("harehare/vlcsnap-00632.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20889 and currentTime <= 20922 then
frame1 = Image.load("harehare/vlcsnap-00633.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20922 and currentTime <= 20955 then
frame1 = Image.load("harehare/vlcsnap-00634.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20955 and currentTime <= 20988 then
frame1 = Image.load("harehare/vlcsnap-00635.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 20988 and currentTime <= 21021 then
frame1 = Image.load("harehare/vlcsnap-00636.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21021 and currentTime <= 21054 then
frame1 = Image.load("harehare/vlcsnap-00637.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21054 and currentTime <= 21087 then
frame1 = Image.load("harehare/vlcsnap-00638.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21087 and currentTime <= 21120 then
frame1 = Image.load("harehare/vlcsnap-00639.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21120 and currentTime <= 21153 then
frame1 = Image.load("harehare/vlcsnap-00640.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21153 and currentTime <= 21186 then
frame1 = Image.load("harehare/vlcsnap-00641.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21186 and currentTime <= 21219 then
frame1 = Image.load("harehare/vlcsnap-00642.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21219 and currentTime <= 21252 then
frame1 = Image.load("harehare/vlcsnap-00643.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21252 and currentTime <= 21285 then
frame1 = Image.load("harehare/vlcsnap-00644.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21285 and currentTime <= 21318 then
frame1 = Image.load("harehare/vlcsnap-00645.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21318 and currentTime <= 21351 then
frame1 = Image.load("harehare/vlcsnap-00646.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21351 and currentTime <= 21384 then
frame1 = Image.load("harehare/vlcsnap-00647.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21384 and currentTime <= 21417 then
frame1 = Image.load("harehare/vlcsnap-00648.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21417 and currentTime <= 21450 then
frame1 = Image.load("harehare/vlcsnap-00649.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21450 and currentTime <= 21483 then
frame1 = Image.load("harehare/vlcsnap-00650.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21483 and currentTime <= 21516 then
frame1 = Image.load("harehare/vlcsnap-00651.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21516 and currentTime <= 21549 then
frame1 = Image.load("harehare/vlcsnap-00652.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21549 and currentTime <= 21582 then
frame1 = Image.load("harehare/vlcsnap-00653.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21582 and currentTime <= 21615 then
frame1 = Image.load("harehare/vlcsnap-00654.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21615 and currentTime <= 21648 then
frame1 = Image.load("harehare/vlcsnap-00655.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21648 and currentTime <= 21681 then
frame1 = Image.load("harehare/vlcsnap-00656.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21681 and currentTime <= 21714 then
frame1 = Image.load("harehare/vlcsnap-00657.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21714 and currentTime <= 21747 then
frame1 = Image.load("harehare/vlcsnap-00658.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21747 and currentTime <= 21780 then
frame1 = Image.load("harehare/vlcsnap-00659.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21780 and currentTime <= 21813 then
frame1 = Image.load("harehare/vlcsnap-00660.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21813 and currentTime <= 21846 then
frame1 = Image.load("harehare/vlcsnap-00661.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21846 and currentTime <= 21879 then
frame1 = Image.load("harehare/vlcsnap-00662.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21879 and currentTime <= 21912 then
frame1 = Image.load("harehare/vlcsnap-00663.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21912 and currentTime <= 21945 then
frame1 = Image.load("harehare/vlcsnap-00664.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21945 and currentTime <= 21978 then
frame1 = Image.load("harehare/vlcsnap-00665.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 21978 and currentTime <= 22011 then
frame1 = Image.load("harehare/vlcsnap-00666.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22011 and currentTime <= 22044 then
frame1 = Image.load("harehare/vlcsnap-00667.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22044 and currentTime <= 22077 then
frame1 = Image.load("harehare/vlcsnap-00668.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22077 and currentTime <= 22110 then
frame1 = Image.load("harehare/vlcsnap-00669.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22110 and currentTime <= 22143 then
frame1 = Image.load("harehare/vlcsnap-00670.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22143 and currentTime <= 22176 then
frame1 = Image.load("harehare/vlcsnap-00671.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22176 and currentTime <= 22209 then
frame1 = Image.load("harehare/vlcsnap-00672.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22209 and currentTime <= 22242 then
frame1 = Image.load("harehare/vlcsnap-00673.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22242 and currentTime <= 22275 then
frame1 = Image.load("harehare/vlcsnap-00674.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22275 and currentTime <= 22308 then
frame1 = Image.load("harehare/vlcsnap-00675.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22308 and currentTime <= 22341 then
frame1 = Image.load("harehare/vlcsnap-00676.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22341 and currentTime <= 22374 then
frame1 = Image.load("harehare/vlcsnap-00677.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22374 and currentTime <= 22407 then
frame1 = Image.load("harehare/vlcsnap-00678.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22407 and currentTime <= 22440 then
frame1 = Image.load("harehare/vlcsnap-00679.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22440 and currentTime <= 22473 then
frame1 = Image.load("harehare/vlcsnap-00680.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22473 and currentTime <= 22506 then
frame1 = Image.load("harehare/vlcsnap-00681.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22506 and currentTime <= 22539 then
frame1 = Image.load("harehare/vlcsnap-00682.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22539 and currentTime <= 22572 then
frame1 = Image.load("harehare/vlcsnap-00683.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22572 and currentTime <= 22605 then
frame1 = Image.load("harehare/vlcsnap-00684.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22605 and currentTime <= 22638 then
frame1 = Image.load("harehare/vlcsnap-00685.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22638 and currentTime <= 22671 then
frame1 = Image.load("harehare/vlcsnap-00686.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22671 and currentTime <= 22704 then
frame1 = Image.load("harehare/vlcsnap-00687.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22704 and currentTime <= 22737 then
frame1 = Image.load("harehare/vlcsnap-00688.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22737 and currentTime <= 22770 then
frame1 = Image.load("harehare/vlcsnap-00689.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22770 and currentTime <= 22803 then
frame1 = Image.load("harehare/vlcsnap-00690.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22803 and currentTime <= 22836 then
frame1 = Image.load("harehare/vlcsnap-00691.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22836 and currentTime <= 22869 then
frame1 = Image.load("harehare/vlcsnap-00692.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22869 and currentTime <= 22902 then
frame1 = Image.load("harehare/vlcsnap-00693.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22902 and currentTime <= 22935 then
frame1 = Image.load("harehare/vlcsnap-00694.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22935 and currentTime <= 22968 then
frame1 = Image.load("harehare/vlcsnap-00695.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 22968 and currentTime <= 23001 then
frame1 = Image.load("harehare/vlcsnap-00696.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23001 and currentTime <= 23034 then
frame1 = Image.load("harehare/vlcsnap-00697.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23034 and currentTime <= 23067 then
frame1 = Image.load("harehare/vlcsnap-00698.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23067 and currentTime <= 23100 then
frame1 = Image.load("harehare/vlcsnap-00699.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23100 and currentTime <= 23133 then
frame1 = Image.load("harehare/vlcsnap-00700.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23133 and currentTime <= 23166 then
frame1 = Image.load("harehare/vlcsnap-00701.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23166 and currentTime <= 23199 then
frame1 = Image.load("harehare/vlcsnap-00702.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23199 and currentTime <= 23232 then
frame1 = Image.load("harehare/vlcsnap-00703.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23232 and currentTime <= 23265 then
frame1 = Image.load("harehare/vlcsnap-00704.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23265 and currentTime <= 23298 then
frame1 = Image.load("harehare/vlcsnap-00705.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23298 and currentTime <= 23331 then
frame1 = Image.load("harehare/vlcsnap-00706.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23331 and currentTime <= 23364 then
frame1 = Image.load("harehare/vlcsnap-00707.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23364 and currentTime <= 23397 then
frame1 = Image.load("harehare/vlcsnap-00708.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23397 and currentTime <= 23430 then
frame1 = Image.load("harehare/vlcsnap-00709.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23430 and currentTime <= 23463 then
frame1 = Image.load("harehare/vlcsnap-00710.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23463 and currentTime <= 23496 then
frame1 = Image.load("harehare/vlcsnap-00711.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23496 and currentTime <= 23529 then
frame1 = Image.load("harehare/vlcsnap-00712.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23529 and currentTime <= 23562 then
frame1 = Image.load("harehare/vlcsnap-00713.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23562 and currentTime <= 23595 then
frame1 = Image.load("harehare/vlcsnap-00714.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23595 and currentTime <= 23628 then
frame1 = Image.load("harehare/vlcsnap-00715.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23628 and currentTime <= 23661 then
frame1 = Image.load("harehare/vlcsnap-00716.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23661 and currentTime <= 23694 then
frame1 = Image.load("harehare/vlcsnap-00717.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23694 and currentTime <= 23727 then
frame1 = Image.load("harehare/vlcsnap-00718.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23727 and currentTime <= 23760 then
frame1 = Image.load("harehare/vlcsnap-00719.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23760 and currentTime <= 23793 then
frame1 = Image.load("harehare/vlcsnap-00720.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23793 and currentTime <= 23826 then
frame1 = Image.load("harehare/vlcsnap-00721.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23826 and currentTime <= 23859 then
frame1 = Image.load("harehare/vlcsnap-00722.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23859 and currentTime <= 23892 then
frame1 = Image.load("harehare/vlcsnap-00723.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23892 and currentTime <= 23925 then
frame1 = Image.load("harehare/vlcsnap-00724.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23925 and currentTime <= 23958 then
frame1 = Image.load("harehare/vlcsnap-00725.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23958 and currentTime <= 23991 then
frame1 = Image.load("harehare/vlcsnap-00726.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 23991 and currentTime <= 24024 then
frame1 = Image.load("harehare/vlcsnap-00727.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24024 and currentTime <= 24057 then
frame1 = Image.load("harehare/vlcsnap-00728.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24057 and currentTime <= 24090 then
frame1 = Image.load("harehare/vlcsnap-00729.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24090 and currentTime <= 24123 then
frame1 = Image.load("harehare/vlcsnap-00730.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24123 and currentTime <= 24156 then
frame1 = Image.load("harehare/vlcsnap-00731.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24156 and currentTime <= 24189 then
frame1 = Image.load("harehare/vlcsnap-00732.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24189 and currentTime <= 24222 then
frame1 = Image.load("harehare/vlcsnap-00733.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24222 and currentTime <= 24255 then
frame1 = Image.load("harehare/vlcsnap-00734.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24255 and currentTime <= 24288 then
frame1 = Image.load("harehare/vlcsnap-00735.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24288 and currentTime <= 24321 then
frame1 = Image.load("harehare/vlcsnap-00736.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24321 and currentTime <= 24354 then
frame1 = Image.load("harehare/vlcsnap-00737.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24354 and currentTime <= 24387 then
frame1 = Image.load("harehare/vlcsnap-00738.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24387 and currentTime <= 24420 then
frame1 = Image.load("harehare/vlcsnap-00739.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24420 and currentTime <= 24453 then
frame1 = Image.load("harehare/vlcsnap-00740.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24453 and currentTime <= 24486 then
frame1 = Image.load("harehare/vlcsnap-00741.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24486 and currentTime <= 24519 then
frame1 = Image.load("harehare/vlcsnap-00742.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24519 and currentTime <= 24552 then
frame1 = Image.load("harehare/vlcsnap-00743.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24552 and currentTime <= 24585 then
frame1 = Image.load("harehare/vlcsnap-00744.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24585 and currentTime <= 24618 then
frame1 = Image.load("harehare/vlcsnap-00745.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24618 and currentTime <= 24651 then
frame1 = Image.load("harehare/vlcsnap-00746.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24651 and currentTime <= 24684 then
frame1 = Image.load("harehare/vlcsnap-00747.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24684 and currentTime <= 24717 then
frame1 = Image.load("harehare/vlcsnap-00748.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24717 and currentTime <= 24750 then
frame1 = Image.load("harehare/vlcsnap-00749.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24750 and currentTime <= 24783 then
frame1 = Image.load("harehare/vlcsnap-00750.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24783 and currentTime <= 24816 then
frame1 = Image.load("harehare/vlcsnap-00751.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24816 and currentTime <= 24849 then
frame1 = Image.load("harehare/vlcsnap-00752.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24849 and currentTime <= 24882 then
frame1 = Image.load("harehare/vlcsnap-00753.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24882 and currentTime <= 24915 then
frame1 = Image.load("harehare/vlcsnap-00754.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24915 and currentTime <= 24948 then
frame1 = Image.load("harehare/vlcsnap-00755.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24948 and currentTime <= 24981 then
frame1 = Image.load("harehare/vlcsnap-00756.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 24981 and currentTime <= 25014 then
frame1 = Image.load("harehare/vlcsnap-00757.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25014 and currentTime <= 25047 then
frame1 = Image.load("harehare/vlcsnap-00758.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25047 and currentTime <= 25080 then
frame1 = Image.load("harehare/vlcsnap-00759.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25080 and currentTime <= 25113 then
frame1 = Image.load("harehare/vlcsnap-00760.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25113 and currentTime <= 25146 then
frame1 = Image.load("harehare/vlcsnap-00761.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25146 and currentTime <= 25179 then
frame1 = Image.load("harehare/vlcsnap-00762.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25179 and currentTime <= 25212 then
frame1 = Image.load("harehare/vlcsnap-00763.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25212 and currentTime <= 25245 then
frame1 = Image.load("harehare/vlcsnap-00764.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25245 and currentTime <= 25278 then
frame1 = Image.load("harehare/vlcsnap-00765.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25278 and currentTime <= 25311 then
frame1 = Image.load("harehare/vlcsnap-00766.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25311 and currentTime <= 25344 then
frame1 = Image.load("harehare/vlcsnap-00767.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25344 and currentTime <= 25377 then
frame1 = Image.load("harehare/vlcsnap-00768.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25377 and currentTime <= 25410 then
frame1 = Image.load("harehare/vlcsnap-00769.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25410 and currentTime <= 25443 then
frame1 = Image.load("harehare/vlcsnap-00770.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25443 and currentTime <= 25476 then
frame1 = Image.load("harehare/vlcsnap-00771.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25476 and currentTime <= 25509 then
frame1 = Image.load("harehare/vlcsnap-00772.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25509 and currentTime <= 25542 then
frame1 = Image.load("harehare/vlcsnap-00773.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25542 and currentTime <= 25575 then
frame1 = Image.load("harehare/vlcsnap-00774.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25575 and currentTime <= 25608 then
frame1 = Image.load("harehare/vlcsnap-00775.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25608 and currentTime <= 25641 then
frame1 = Image.load("harehare/vlcsnap-00776.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25641 and currentTime <= 25674 then
frame1 = Image.load("harehare/vlcsnap-00777.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25674 and currentTime <= 25707 then
frame1 = Image.load("harehare/vlcsnap-00778.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25707 and currentTime <= 25740 then
frame1 = Image.load("harehare/vlcsnap-00779.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25740 and currentTime <= 25773 then
frame1 = Image.load("harehare/vlcsnap-00780.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25773 and currentTime <= 25806 then
frame1 = Image.load("harehare/vlcsnap-00781.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25806 and currentTime <= 25839 then
frame1 = Image.load("harehare/vlcsnap-00782.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25839 and currentTime <= 25872 then
frame1 = Image.load("harehare/vlcsnap-00783.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25872 and currentTime <= 25905 then
frame1 = Image.load("harehare/vlcsnap-00784.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25905 and currentTime <= 25938 then
frame1 = Image.load("harehare/vlcsnap-00785.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25938 and currentTime <= 25971 then
frame1 = Image.load("harehare/vlcsnap-00786.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 25971 and currentTime <= 26004 then
frame1 = Image.load("harehare/vlcsnap-00787.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26004 and currentTime <= 26037 then
frame1 = Image.load("harehare/vlcsnap-00788.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26037 and currentTime <= 26070 then
frame1 = Image.load("harehare/vlcsnap-00789.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26070 and currentTime <= 26103 then
frame1 = Image.load("harehare/vlcsnap-00790.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26103 and currentTime <= 26136 then
frame1 = Image.load("harehare/vlcsnap-00791.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26136 and currentTime <= 26169 then
frame1 = Image.load("harehare/vlcsnap-00792.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26169 and currentTime <= 26202 then
frame1 = Image.load("harehare/vlcsnap-00793.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26202 and currentTime <= 26235 then
frame1 = Image.load("harehare/vlcsnap-00794.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26235 and currentTime <= 26268 then
frame1 = Image.load("harehare/vlcsnap-00795.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26268 and currentTime <= 26301 then
frame1 = Image.load("harehare/vlcsnap-00796.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26301 and currentTime <= 26334 then
frame1 = Image.load("harehare/vlcsnap-00797.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26334 and currentTime <= 26367 then
frame1 = Image.load("harehare/vlcsnap-00798.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26367 and currentTime <= 26400 then
frame1 = Image.load("harehare/vlcsnap-00799.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26400 and currentTime <= 26433 then
frame1 = Image.load("harehare/vlcsnap-00800.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26433 and currentTime <= 26466 then
frame1 = Image.load("harehare/vlcsnap-00801.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26466 and currentTime <= 26499 then
frame1 = Image.load("harehare/vlcsnap-00802.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26499 and currentTime <= 26532 then
frame1 = Image.load("harehare/vlcsnap-00803.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26532 and currentTime <= 26565 then
frame1 = Image.load("harehare/vlcsnap-00804.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26565 and currentTime <= 26598 then
frame1 = Image.load("harehare/vlcsnap-00805.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26598 and currentTime <= 26631 then
frame1 = Image.load("harehare/vlcsnap-00806.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26631 and currentTime <= 26664 then
frame1 = Image.load("harehare/vlcsnap-00807.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26664 and currentTime <= 26697 then
frame1 = Image.load("harehare/vlcsnap-00808.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26697 and currentTime <= 26730 then
frame1 = Image.load("harehare/vlcsnap-00809.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26730 and currentTime <= 26763 then
frame1 = Image.load("harehare/vlcsnap-00810.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26763 and currentTime <= 26796 then
frame1 = Image.load("harehare/vlcsnap-00811.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26796 and currentTime <= 26829 then
frame1 = Image.load("harehare/vlcsnap-00812.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26829 and currentTime <= 26862 then
frame1 = Image.load("harehare/vlcsnap-00813.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26862 and currentTime <= 26895 then
frame1 = Image.load("harehare/vlcsnap-00814.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26895 and currentTime <= 26928 then
frame1 = Image.load("harehare/vlcsnap-00815.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26928 and currentTime <= 26961 then
frame1 = Image.load("harehare/vlcsnap-00816.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26961 and currentTime <= 26994 then
frame1 = Image.load("harehare/vlcsnap-00817.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 26994 and currentTime <= 27027 then
frame1 = Image.load("harehare/vlcsnap-00818.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27027 and currentTime <= 27060 then
frame1 = Image.load("harehare/vlcsnap-00819.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27060 and currentTime <= 27093 then
frame1 = Image.load("harehare/vlcsnap-00820.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27093 and currentTime <= 27126 then
frame1 = Image.load("harehare/vlcsnap-00821.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27126 and currentTime <= 27159 then
frame1 = Image.load("harehare/vlcsnap-00822.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27159 and currentTime <= 27192 then
frame1 = Image.load("harehare/vlcsnap-00823.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27192 and currentTime <= 27225 then
frame1 = Image.load("harehare/vlcsnap-00824.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27225 and currentTime <= 27258 then
frame1 = Image.load("harehare/vlcsnap-00825.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27258 and currentTime <= 27291 then
frame1 = Image.load("harehare/vlcsnap-00826.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27291 and currentTime <= 27324 then
frame1 = Image.load("harehare/vlcsnap-00827.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27324 and currentTime <= 27357 then
frame1 = Image.load("harehare/vlcsnap-00828.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27357 and currentTime <= 27390 then
frame1 = Image.load("harehare/vlcsnap-00829.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27390 and currentTime <= 27423 then
frame1 = Image.load("harehare/vlcsnap-00830.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27423 and currentTime <= 27456 then
frame1 = Image.load("harehare/vlcsnap-00831.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27456 and currentTime <= 27489 then
frame1 = Image.load("harehare/vlcsnap-00832.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27489 and currentTime <= 27522 then
frame1 = Image.load("harehare/vlcsnap-00833.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27522 and currentTime <= 27555 then
frame1 = Image.load("harehare/vlcsnap-00834.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27555 and currentTime <= 27588 then
frame1 = Image.load("harehare/vlcsnap-00835.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27588 and currentTime <= 27621 then
frame1 = Image.load("harehare/vlcsnap-00836.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27621 and currentTime <= 27654 then
frame1 = Image.load("harehare/vlcsnap-00837.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27654 and currentTime <= 27687 then
frame1 = Image.load("harehare/vlcsnap-00838.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27687 and currentTime <= 27720 then
frame1 = Image.load("harehare/vlcsnap-00839.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27720 and currentTime <= 27753 then
frame1 = Image.load("harehare/vlcsnap-00840.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27753 and currentTime <= 27786 then
frame1 = Image.load("harehare/vlcsnap-00841.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27786 and currentTime <= 27819 then
frame1 = Image.load("harehare/vlcsnap-00842.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27819 and currentTime <= 27852 then
frame1 = Image.load("harehare/vlcsnap-00843.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27852 and currentTime <= 27885 then
frame1 = Image.load("harehare/vlcsnap-00844.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27885 and currentTime <= 27918 then
frame1 = Image.load("harehare/vlcsnap-00845.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27918 and currentTime <= 27951 then
frame1 = Image.load("harehare/vlcsnap-00846.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27951 and currentTime <= 27984 then
frame1 = Image.load("harehare/vlcsnap-00847.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 27984 and currentTime <= 28017 then
frame1 = Image.load("harehare/vlcsnap-00848.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28017 and currentTime <= 28050 then
frame1 = Image.load("harehare/vlcsnap-00849.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28050 and currentTime <= 28083 then
frame1 = Image.load("harehare/vlcsnap-00850.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28083 and currentTime <= 28116 then
frame1 = Image.load("harehare/vlcsnap-00851.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28116 and currentTime <= 28149 then
frame1 = Image.load("harehare/vlcsnap-00852.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28149 and currentTime <= 28182 then
frame1 = Image.load("harehare/vlcsnap-00853.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28182 and currentTime <= 28215 then
frame1 = Image.load("harehare/vlcsnap-00854.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28215 and currentTime <= 28248 then
frame1 = Image.load("harehare/vlcsnap-00855.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28248 and currentTime <= 28281 then
frame1 = Image.load("harehare/vlcsnap-00856.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28281 and currentTime <= 28314 then
frame1 = Image.load("harehare/vlcsnap-00857.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28314 and currentTime <= 28347 then
frame1 = Image.load("harehare/vlcsnap-00858.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28347 and currentTime <= 28380 then
frame1 = Image.load("harehare/vlcsnap-00859.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28380 and currentTime <= 28413 then
frame1 = Image.load("harehare/vlcsnap-00860.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28413 and currentTime <= 28446 then
frame1 = Image.load("harehare/vlcsnap-00861.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28446 and currentTime <= 28479 then
frame1 = Image.load("harehare/vlcsnap-00862.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28479 and currentTime <= 28512 then
frame1 = Image.load("harehare/vlcsnap-00863.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28512 and currentTime <= 28545 then
frame1 = Image.load("harehare/vlcsnap-00864.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28545 and currentTime <= 28578 then
frame1 = Image.load("harehare/vlcsnap-00865.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28578 and currentTime <= 28611 then
frame1 = Image.load("harehare/vlcsnap-00866.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28611 and currentTime <= 28644 then
frame1 = Image.load("harehare/vlcsnap-00867.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28644 and currentTime <= 28677 then
frame1 = Image.load("harehare/vlcsnap-00868.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28677 and currentTime <= 28710 then
frame1 = Image.load("harehare/vlcsnap-00869.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28710 and currentTime <= 28743 then
frame1 = Image.load("harehare/vlcsnap-00870.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28743 and currentTime <= 28776 then
frame1 = Image.load("harehare/vlcsnap-00871.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28776 and currentTime <= 28809 then
frame1 = Image.load("harehare/vlcsnap-00872.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28809 and currentTime <= 28842 then
frame1 = Image.load("harehare/vlcsnap-00873.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28842 and currentTime <= 28875 then
frame1 = Image.load("harehare/vlcsnap-00874.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28875 and currentTime <= 28908 then
frame1 = Image.load("harehare/vlcsnap-00875.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28908 and currentTime <= 28941 then
frame1 = Image.load("harehare/vlcsnap-00876.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28941 and currentTime <= 28974 then
frame1 = Image.load("harehare/vlcsnap-00877.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 28974 and currentTime <= 29007 then
frame1 = Image.load("harehare/vlcsnap-00878.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29007 and currentTime <= 29040 then
frame1 = Image.load("harehare/vlcsnap-00879.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29040 and currentTime <= 29073 then
frame1 = Image.load("harehare/vlcsnap-00880.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29073 and currentTime <= 29106 then
frame1 = Image.load("harehare/vlcsnap-00881.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29106 and currentTime <= 29139 then
frame1 = Image.load("harehare/vlcsnap-00882.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29139 and currentTime <= 29172 then
frame1 = Image.load("harehare/vlcsnap-00883.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29172 and currentTime <= 29205 then
frame1 = Image.load("harehare/vlcsnap-00884.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29205 and currentTime <= 29238 then
frame1 = Image.load("harehare/vlcsnap-00885.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29238 and currentTime <= 29271 then
frame1 = Image.load("harehare/vlcsnap-00886.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29271 and currentTime <= 29304 then
frame1 = Image.load("harehare/vlcsnap-00887.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29304 and currentTime <= 29337 then
frame1 = Image.load("harehare/vlcsnap-00888.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29337 and currentTime <= 29370 then
frame1 = Image.load("harehare/vlcsnap-00889.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29370 and currentTime <= 29403 then
frame1 = Image.load("harehare/vlcsnap-00890.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29403 and currentTime <= 29436 then
frame1 = Image.load("harehare/vlcsnap-00891.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29436 and currentTime <= 29469 then
frame1 = Image.load("harehare/vlcsnap-00892.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29469 and currentTime <= 29502 then
frame1 = Image.load("harehare/vlcsnap-00893.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29502 and currentTime <= 29535 then
frame1 = Image.load("harehare/vlcsnap-00894.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29535 and currentTime <= 29568 then
frame1 = Image.load("harehare/vlcsnap-00895.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29568 and currentTime <= 29601 then
frame1 = Image.load("harehare/vlcsnap-00896.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29601 and currentTime <= 29634 then
frame1 = Image.load("harehare/vlcsnap-00897.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29634 and currentTime <= 29667 then
frame1 = Image.load("harehare/vlcsnap-00898.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29667 and currentTime <= 29700 then
frame1 = Image.load("harehare/vlcsnap-00899.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29700 and currentTime <= 29733 then
frame1 = Image.load("harehare/vlcsnap-00900.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29733 and currentTime <= 29766 then
frame1 = Image.load("harehare/vlcsnap-00901.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29766 and currentTime <= 29799 then
frame1 = Image.load("harehare/vlcsnap-00902.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29799 and currentTime <= 29832 then
frame1 = Image.load("harehare/vlcsnap-00903.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29832 and currentTime <= 29865 then
frame1 = Image.load("harehare/vlcsnap-00904.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29865 and currentTime <= 29898 then
frame1 = Image.load("harehare/vlcsnap-00905.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29898 and currentTime <= 29931 then
frame1 = Image.load("harehare/vlcsnap-00906.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29931 and currentTime <= 29964 then
frame1 = Image.load("harehare/vlcsnap-00907.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29964 and currentTime <= 29997 then
frame1 = Image.load("harehare/vlcsnap-00908.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 29997 and currentTime <= 30030 then
frame1 = Image.load("harehare/vlcsnap-00909.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30030 and currentTime <= 30063 then
frame1 = Image.load("harehare/vlcsnap-00910.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30063 and currentTime <= 30096 then
frame1 = Image.load("harehare/vlcsnap-00911.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30096 and currentTime <= 30129 then
frame1 = Image.load("harehare/vlcsnap-00912.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30129 and currentTime <= 30162 then
frame1 = Image.load("harehare/vlcsnap-00913.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30162 and currentTime <= 30195 then
frame1 = Image.load("harehare/vlcsnap-00914.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30195 and currentTime <= 30228 then
frame1 = Image.load("harehare/vlcsnap-00915.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30228 and currentTime <= 30261 then
frame1 = Image.load("harehare/vlcsnap-00916.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30261 and currentTime <= 30294 then
frame1 = Image.load("harehare/vlcsnap-00917.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30294 and currentTime <= 30327 then
frame1 = Image.load("harehare/vlcsnap-00918.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30327 and currentTime <= 30360 then
frame1 = Image.load("harehare/vlcsnap-00919.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30360 and currentTime <= 30393 then
frame1 = Image.load("harehare/vlcsnap-00920.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30393 and currentTime <= 30426 then
frame1 = Image.load("harehare/vlcsnap-00921.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30426 and currentTime <= 30459 then
frame1 = Image.load("harehare/vlcsnap-00922.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30459 and currentTime <= 30492 then
frame1 = Image.load("harehare/vlcsnap-00923.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30492 and currentTime <= 30525 then
frame1 = Image.load("harehare/vlcsnap-00924.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30525 and currentTime <= 30558 then
frame1 = Image.load("harehare/vlcsnap-00925.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30558 and currentTime <= 30591 then
frame1 = Image.load("harehare/vlcsnap-00926.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30591 and currentTime <= 30624 then
frame1 = Image.load("harehare/vlcsnap-00927.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30624 and currentTime <= 30657 then
frame1 = Image.load("harehare/vlcsnap-00928.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30657 and currentTime <= 30690 then
frame1 = Image.load("harehare/vlcsnap-00929.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30690 and currentTime <= 30723 then
frame1 = Image.load("harehare/vlcsnap-00930.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30723 and currentTime <= 30756 then
frame1 = Image.load("harehare/vlcsnap-00931.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30756 and currentTime <= 30789 then
frame1 = Image.load("harehare/vlcsnap-00932.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30789 and currentTime <= 30822 then
frame1 = Image.load("harehare/vlcsnap-00933.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30822 and currentTime <= 30855 then
frame1 = Image.load("harehare/vlcsnap-00934.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30855 and currentTime <= 30888 then
frame1 = Image.load("harehare/vlcsnap-00935.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30888 and currentTime <= 30921 then
frame1 = Image.load("harehare/vlcsnap-00936.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30921 and currentTime <= 30954 then
frame1 = Image.load("harehare/vlcsnap-00937.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30954 and currentTime <= 30987 then
frame1 = Image.load("harehare/vlcsnap-00938.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 30987 and currentTime <= 31020 then
frame1 = Image.load("harehare/vlcsnap-00939.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31020 and currentTime <= 31053 then
frame1 = Image.load("harehare/vlcsnap-00940.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31053 and currentTime <= 31086 then
frame1 = Image.load("harehare/vlcsnap-00941.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31086 and currentTime <= 31119 then
frame1 = Image.load("harehare/vlcsnap-00942.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31119 and currentTime <= 31152 then
frame1 = Image.load("harehare/vlcsnap-00943.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31152 and currentTime <= 31185 then
frame1 = Image.load("harehare/vlcsnap-00944.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31185 and currentTime <= 31218 then
frame1 = Image.load("harehare/vlcsnap-00945.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31218 and currentTime <= 31251 then
frame1 = Image.load("harehare/vlcsnap-00946.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31251 and currentTime <= 31284 then
frame1 = Image.load("harehare/vlcsnap-00947.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31284 and currentTime <= 31317 then
frame1 = Image.load("harehare/vlcsnap-00948.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31317 and currentTime <= 31350 then
frame1 = Image.load("harehare/vlcsnap-00949.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31350 and currentTime <= 31383 then
frame1 = Image.load("harehare/vlcsnap-00950.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31383 and currentTime <= 31416 then
frame1 = Image.load("harehare/vlcsnap-00951.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31416 and currentTime <= 31449 then
frame1 = Image.load("harehare/vlcsnap-00952.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31449 and currentTime <= 31482 then
frame1 = Image.load("harehare/vlcsnap-00953.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31482 and currentTime <= 31515 then
frame1 = Image.load("harehare/vlcsnap-00954.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31515 and currentTime <= 31548 then
frame1 = Image.load("harehare/vlcsnap-00955.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31548 and currentTime <= 31581 then
frame1 = Image.load("harehare/vlcsnap-00956.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31581 and currentTime <= 31614 then
frame1 = Image.load("harehare/vlcsnap-00957.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31614 and currentTime <= 31647 then
frame1 = Image.load("harehare/vlcsnap-00958.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31647 and currentTime <= 31680 then
frame1 = Image.load("harehare/vlcsnap-00959.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31680 and currentTime <= 31713 then
frame1 = Image.load("harehare/vlcsnap-00960.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31713 and currentTime <= 31746 then
frame1 = Image.load("harehare/vlcsnap-00961.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31746 and currentTime <= 31779 then
frame1 = Image.load("harehare/vlcsnap-00962.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31779 and currentTime <= 31812 then
frame1 = Image.load("harehare/vlcsnap-00963.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31812 and currentTime <= 31845 then
frame1 = Image.load("harehare/vlcsnap-00964.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31845 and currentTime <= 31878 then
frame1 = Image.load("harehare/vlcsnap-00965.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31878 and currentTime <= 31911 then
frame1 = Image.load("harehare/vlcsnap-00966.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31911 and currentTime <= 31944 then
frame1 = Image.load("harehare/vlcsnap-00967.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31944 and currentTime <= 31977 then
frame1 = Image.load("harehare/vlcsnap-00968.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 31977 and currentTime <= 32010 then
frame1 = Image.load("harehare/vlcsnap-00969.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32010 and currentTime <= 32043 then
frame1 = Image.load("harehare/vlcsnap-00970.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32043 and currentTime <= 32076 then
frame1 = Image.load("harehare/vlcsnap-00971.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32076 and currentTime <= 32109 then
frame1 = Image.load("harehare/vlcsnap-00972.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32109 and currentTime <= 32142 then
frame1 = Image.load("harehare/vlcsnap-00973.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32142 and currentTime <= 32175 then
frame1 = Image.load("harehare/vlcsnap-00974.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32175 and currentTime <= 32208 then
frame1 = Image.load("harehare/vlcsnap-00975.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32208 and currentTime <= 32241 then
frame1 = Image.load("harehare/vlcsnap-00976.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32241 and currentTime <= 32274 then
frame1 = Image.load("harehare/vlcsnap-00977.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32274 and currentTime <= 32307 then
frame1 = Image.load("harehare/vlcsnap-00978.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32307 and currentTime <= 32340 then
frame1 = Image.load("harehare/vlcsnap-00979.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32340 and currentTime <= 32373 then
frame1 = Image.load("harehare/vlcsnap-00980.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32373 and currentTime <= 32406 then
frame1 = Image.load("harehare/vlcsnap-00981.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32406 and currentTime <= 32439 then
frame1 = Image.load("harehare/vlcsnap-00982.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32439 and currentTime <= 32472 then
frame1 = Image.load("harehare/vlcsnap-00983.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32472 and currentTime <= 32505 then
frame1 = Image.load("harehare/vlcsnap-00984.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32505 and currentTime <= 32538 then
frame1 = Image.load("harehare/vlcsnap-00985.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32538 and currentTime <= 32571 then
frame1 = Image.load("harehare/vlcsnap-00986.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32571 and currentTime <= 32604 then
frame1 = Image.load("harehare/vlcsnap-00987.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32604 and currentTime <= 32637 then
frame1 = Image.load("harehare/vlcsnap-00988.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32637 and currentTime <= 32670 then
frame1 = Image.load("harehare/vlcsnap-00989.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32670 and currentTime <= 32703 then
frame1 = Image.load("harehare/vlcsnap-00990.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32703 and currentTime <= 32736 then
frame1 = Image.load("harehare/vlcsnap-00991.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32736 and currentTime <= 32769 then
frame1 = Image.load("harehare/vlcsnap-00992.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32769 and currentTime <= 32802 then
frame1 = Image.load("harehare/vlcsnap-00993.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32802 and currentTime <= 32835 then
frame1 = Image.load("harehare/vlcsnap-00994.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32835 and currentTime <= 32868 then
frame1 = Image.load("harehare/vlcsnap-00995.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32868 and currentTime <= 32901 then
frame1 = Image.load("harehare/vlcsnap-00996.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32901 and currentTime <= 32934 then
frame1 = Image.load("harehare/vlcsnap-00997.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32934 and currentTime <= 32967 then
frame1 = Image.load("harehare/vlcsnap-00998.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 32967 and currentTime <= 33000 then
frame1 = Image.load("harehare/vlcsnap-00999.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33000 and currentTime <= 33033 then
frame1 = Image.load("harehare/vlcsnap-01000.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33033 and currentTime <= 33066 then
frame1 = Image.load("harehare/vlcsnap-01001.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33066 and currentTime <= 33099 then
frame1 = Image.load("harehare/vlcsnap-01002.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33099 and currentTime <= 33132 then
frame1 = Image.load("harehare/vlcsnap-01003.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33132 and currentTime <= 33165 then
frame1 = Image.load("harehare/vlcsnap-01004.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33165 and currentTime <= 33198 then
frame1 = Image.load("harehare/vlcsnap-01005.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33198 and currentTime <= 33231 then
frame1 = Image.load("harehare/vlcsnap-01006.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33231 and currentTime <= 33264 then
frame1 = Image.load("harehare/vlcsnap-01007.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33264 and currentTime <= 33297 then
frame1 = Image.load("harehare/vlcsnap-01008.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33297 and currentTime <= 33330 then
frame1 = Image.load("harehare/vlcsnap-01009.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33330 and currentTime <= 33363 then
frame1 = Image.load("harehare/vlcsnap-01010.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33363 and currentTime <= 33396 then
frame1 = Image.load("harehare/vlcsnap-01011.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33396 and currentTime <= 33429 then
frame1 = Image.load("harehare/vlcsnap-01012.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33429 and currentTime <= 33462 then
frame1 = Image.load("harehare/vlcsnap-01013.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33462 and currentTime <= 33495 then
frame1 = Image.load("harehare/vlcsnap-01014.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33495 and currentTime <= 33528 then
frame1 = Image.load("harehare/vlcsnap-01015.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33528 and currentTime <= 33561 then
frame1 = Image.load("harehare/vlcsnap-01016.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33561 and currentTime <= 33594 then
frame1 = Image.load("harehare/vlcsnap-01017.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33594 and currentTime <= 33627 then
frame1 = Image.load("harehare/vlcsnap-01018.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33627 and currentTime <= 33660 then
frame1 = Image.load("harehare/vlcsnap-01019.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33660 and currentTime <= 33693 then
frame1 = Image.load("harehare/vlcsnap-01020.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33693 and currentTime <= 33726 then
frame1 = Image.load("harehare/vlcsnap-01021.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33726 and currentTime <= 33759 then
frame1 = Image.load("harehare/vlcsnap-01022.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33759 and currentTime <= 33792 then
frame1 = Image.load("harehare/vlcsnap-01023.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33792 and currentTime <= 33825 then
frame1 = Image.load("harehare/vlcsnap-01024.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33825 and currentTime <= 33858 then
frame1 = Image.load("harehare/vlcsnap-01025.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33858 and currentTime <= 33891 then
frame1 = Image.load("harehare/vlcsnap-01026.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33891 and currentTime <= 33924 then
frame1 = Image.load("harehare/vlcsnap-01027.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33924 and currentTime <= 33957 then
frame1 = Image.load("harehare/vlcsnap-01028.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33957 and currentTime <= 33990 then
frame1 = Image.load("harehare/vlcsnap-01029.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33990 and currentTime <= 34023 then
frame1 = Image.load("harehare/vlcsnap-01030.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34023 and currentTime <= 34056 then
frame1 = Image.load("harehare/vlcsnap-01031.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34056 and currentTime <= 34089 then
frame1 = Image.load("harehare/vlcsnap-01032.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34089 and currentTime <= 34122 then
frame1 = Image.load("harehare/vlcsnap-01033.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34122 and currentTime <= 34155 then
frame1 = Image.load("harehare/vlcsnap-01034.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34155 and currentTime <= 34188 then
frame1 = Image.load("harehare/vlcsnap-01035.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34188 and currentTime <= 34221 then
frame1 = Image.load("harehare/vlcsnap-01036.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34221 and currentTime <= 34254 then
frame1 = Image.load("harehare/vlcsnap-01037.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34254 and currentTime <= 34287 then
frame1 = Image.load("harehare/vlcsnap-01038.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34287 and currentTime <= 34320 then
frame1 = Image.load("harehare/vlcsnap-01039.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34320 and currentTime <= 34353 then
frame1 = Image.load("harehare/vlcsnap-01040.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34353 and currentTime <= 34386 then
frame1 = Image.load("harehare/vlcsnap-01041.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34386 and currentTime <= 34419 then
frame1 = Image.load("harehare/vlcsnap-01042.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34419 and currentTime <= 34452 then
frame1 = Image.load("harehare/vlcsnap-01043.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34452 and currentTime <= 34485 then
frame1 = Image.load("harehare/vlcsnap-01044.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34485 and currentTime <= 34518 then
frame1 = Image.load("harehare/vlcsnap-01045.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34518 and currentTime <= 34551 then
frame1 = Image.load("harehare/vlcsnap-01046.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34551 and currentTime <= 34584 then
frame1 = Image.load("harehare/vlcsnap-01047.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34584 and currentTime <= 34617 then
frame1 = Image.load("harehare/vlcsnap-01048.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34617 and currentTime <= 34650 then
frame1 = Image.load("harehare/vlcsnap-01049.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34650 and currentTime <= 34683 then
frame1 = Image.load("harehare/vlcsnap-01050.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34683 and currentTime <= 34716 then
frame1 = Image.load("harehare/vlcsnap-01051.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34716 and currentTime <= 34749 then
frame1 = Image.load("harehare/vlcsnap-01052.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34749 and currentTime <= 34782 then
frame1 = Image.load("harehare/vlcsnap-01053.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34782 and currentTime <= 34815 then
frame1 = Image.load("harehare/vlcsnap-01054.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34815 and currentTime <= 34848 then
frame1 = Image.load("harehare/vlcsnap-01055.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34848 and currentTime <= 34881 then
frame1 = Image.load("harehare/vlcsnap-01056.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34881 and currentTime <= 34914 then
frame1 = Image.load("harehare/vlcsnap-01057.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34914 and currentTime <= 34947 then
frame1 = Image.load("harehare/vlcsnap-01058.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34947 and currentTime <= 34980 then
frame1 = Image.load("harehare/vlcsnap-01059.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 34980 and currentTime <= 35013 then
frame1 = Image.load("harehare/vlcsnap-01060.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35013 and currentTime <= 35046 then
frame1 = Image.load("harehare/vlcsnap-01061.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35046 and currentTime <= 35079 then
frame1 = Image.load("harehare/vlcsnap-01062.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35079 and currentTime <= 35112 then
frame1 = Image.load("harehare/vlcsnap-01063.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35112 and currentTime <= 35145 then
frame1 = Image.load("harehare/vlcsnap-01064.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35145 and currentTime <= 35178 then
frame1 = Image.load("harehare/vlcsnap-01065.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35178 and currentTime <= 35211 then
frame1 = Image.load("harehare/vlcsnap-01066.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35211 and currentTime <= 35244 then
frame1 = Image.load("harehare/vlcsnap-01067.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35244 and currentTime <= 35277 then
frame1 = Image.load("harehare/vlcsnap-01068.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35277 and currentTime <= 35310 then
frame1 = Image.load("harehare/vlcsnap-01069.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35310 and currentTime <= 35343 then
frame1 = Image.load("harehare/vlcsnap-01070.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35343 and currentTime <= 35376 then
frame1 = Image.load("harehare/vlcsnap-01071.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35376 and currentTime <= 35409 then
frame1 = Image.load("harehare/vlcsnap-01072.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35409 and currentTime <= 35442 then
frame1 = Image.load("harehare/vlcsnap-01073.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35442 and currentTime <= 35475 then
frame1 = Image.load("harehare/vlcsnap-01074.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35475 and currentTime <= 35508 then
frame1 = Image.load("harehare/vlcsnap-01075.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35508 and currentTime <= 35541 then
frame1 = Image.load("harehare/vlcsnap-01076.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35541 and currentTime <= 35574 then
frame1 = Image.load("harehare/vlcsnap-01077.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35574 and currentTime <= 35607 then
frame1 = Image.load("harehare/vlcsnap-01078.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35607 and currentTime <= 35640 then
frame1 = Image.load("harehare/vlcsnap-01079.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35640 and currentTime <= 35673 then
frame1 = Image.load("harehare/vlcsnap-01080.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35673 and currentTime <= 35706 then
frame1 = Image.load("harehare/vlcsnap-01081.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35706 and currentTime <= 35739 then
frame1 = Image.load("harehare/vlcsnap-01082.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35739 and currentTime <= 35772 then
frame1 = Image.load("harehare/vlcsnap-01083.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35772 and currentTime <= 35805 then
frame1 = Image.load("harehare/vlcsnap-01084.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35805 and currentTime <= 35838 then
frame1 = Image.load("harehare/vlcsnap-01085.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35838 and currentTime <= 35871 then
frame1 = Image.load("harehare/vlcsnap-01086.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35871 and currentTime <= 35904 then
frame1 = Image.load("harehare/vlcsnap-01087.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35904 and currentTime <= 35937 then
frame1 = Image.load("harehare/vlcsnap-01088.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35937 and currentTime <= 35970 then
frame1 = Image.load("harehare/vlcsnap-01089.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 35970 and currentTime <= 36003 then
frame1 = Image.load("harehare/vlcsnap-01090.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36003 and currentTime <= 36036 then
frame1 = Image.load("harehare/vlcsnap-01091.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36036 and currentTime <= 36069 then
frame1 = Image.load("harehare/vlcsnap-01092.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36069 and currentTime <= 36102 then
frame1 = Image.load("harehare/vlcsnap-01093.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36102 and currentTime <= 36135 then
frame1 = Image.load("harehare/vlcsnap-01094.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36135 and currentTime <= 36168 then
frame1 = Image.load("harehare/vlcsnap-01095.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36168 and currentTime <= 36201 then
frame1 = Image.load("harehare/vlcsnap-01096.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36201 and currentTime <= 36234 then
frame1 = Image.load("harehare/vlcsnap-01097.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36234 and currentTime <= 36267 then
frame1 = Image.load("harehare/vlcsnap-01098.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36267 and currentTime <= 36300 then
frame1 = Image.load("harehare/vlcsnap-01099.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36300 and currentTime <= 36333 then
frame1 = Image.load("harehare/vlcsnap-01100.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36333 and currentTime <= 36366 then
frame1 = Image.load("harehare/vlcsnap-01101.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36366 and currentTime <= 36399 then
frame1 = Image.load("harehare/vlcsnap-01102.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36399 and currentTime <= 36432 then
frame1 = Image.load("harehare/vlcsnap-01103.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36432 and currentTime <= 36465 then
frame1 = Image.load("harehare/vlcsnap-01104.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36465 and currentTime <= 36498 then
frame1 = Image.load("harehare/vlcsnap-01105.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36498 and currentTime <= 36531 then
frame1 = Image.load("harehare/vlcsnap-01106.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36531 and currentTime <= 36564 then
frame1 = Image.load("harehare/vlcsnap-01107.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36564 and currentTime <= 36597 then
frame1 = Image.load("harehare/vlcsnap-01108.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36597 and currentTime <= 36630 then
frame1 = Image.load("harehare/vlcsnap-01109.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36630 and currentTime <= 36663 then
frame1 = Image.load("harehare/vlcsnap-01110.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36663 and currentTime <= 36696 then
frame1 = Image.load("harehare/vlcsnap-01111.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36696 and currentTime <= 36729 then
frame1 = Image.load("harehare/vlcsnap-01112.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36729 and currentTime <= 36762 then
frame1 = Image.load("harehare/vlcsnap-01113.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36762 and currentTime <= 36795 then
frame1 = Image.load("harehare/vlcsnap-01114.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36795 and currentTime <= 36828 then
frame1 = Image.load("harehare/vlcsnap-01115.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36828 and currentTime <= 36861 then
frame1 = Image.load("harehare/vlcsnap-01116.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36861 and currentTime <= 36894 then
frame1 = Image.load("harehare/vlcsnap-01117.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36894 and currentTime <= 36927 then
frame1 = Image.load("harehare/vlcsnap-01118.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36927 and currentTime <= 36960 then
frame1 = Image.load("harehare/vlcsnap-01119.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36960 and currentTime <= 36993 then
frame1 = Image.load("harehare/vlcsnap-01120.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 36993 and currentTime <= 37026 then
frame1 = Image.load("harehare/vlcsnap-01121.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37026 and currentTime <= 37059 then
frame1 = Image.load("harehare/vlcsnap-01122.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37059 and currentTime <= 37092 then
frame1 = Image.load("harehare/vlcsnap-01123.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37092 and currentTime <= 37125 then
frame1 = Image.load("harehare/vlcsnap-01124.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37125 and currentTime <= 37158 then
frame1 = Image.load("harehare/vlcsnap-01125.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37158 and currentTime <= 37191 then
frame1 = Image.load("harehare/vlcsnap-01126.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37191 and currentTime <= 37224 then
frame1 = Image.load("harehare/vlcsnap-01127.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37224 and currentTime <= 37257 then
frame1 = Image.load("harehare/vlcsnap-01128.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37257 and currentTime <= 37290 then
frame1 = Image.load("harehare/vlcsnap-01129.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37290 and currentTime <= 37323 then
frame1 = Image.load("harehare/vlcsnap-01130.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37323 and currentTime <= 37356 then
frame1 = Image.load("harehare/vlcsnap-01131.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37356 and currentTime <= 37389 then
frame1 = Image.load("harehare/vlcsnap-01132.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37389 and currentTime <= 37422 then
frame1 = Image.load("harehare/vlcsnap-01133.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37422 and currentTime <= 37455 then
frame1 = Image.load("harehare/vlcsnap-01134.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37455 and currentTime <= 37488 then
frame1 = Image.load("harehare/vlcsnap-01135.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37488 and currentTime <= 37521 then
frame1 = Image.load("harehare/vlcsnap-01136.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37521 and currentTime <= 37554 then
frame1 = Image.load("harehare/vlcsnap-01137.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37554 and currentTime <= 37587 then
frame1 = Image.load("harehare/vlcsnap-01138.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37587 and currentTime <= 37620 then
frame1 = Image.load("harehare/vlcsnap-01139.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37620 and currentTime <= 37653 then
frame1 = Image.load("harehare/vlcsnap-01140.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37653 and currentTime <= 37686 then
frame1 = Image.load("harehare/vlcsnap-01141.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37686 and currentTime <= 37719 then
frame1 = Image.load("harehare/vlcsnap-01142.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37719 and currentTime <= 37752 then
frame1 = Image.load("harehare/vlcsnap-01143.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37752 and currentTime <= 37785 then
frame1 = Image.load("harehare/vlcsnap-01144.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37785 and currentTime <= 37818 then
frame1 = Image.load("harehare/vlcsnap-01145.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37818 and currentTime <= 37851 then
frame1 = Image.load("harehare/vlcsnap-01146.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37851 and currentTime <= 37884 then
frame1 = Image.load("harehare/vlcsnap-01147.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37884 and currentTime <= 37917 then
frame1 = Image.load("harehare/vlcsnap-01148.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37917 and currentTime <= 37950 then
frame1 = Image.load("harehare/vlcsnap-01149.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37950 and currentTime <= 37983 then
frame1 = Image.load("harehare/vlcsnap-01150.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 37983 and currentTime <= 38016 then
frame1 = Image.load("harehare/vlcsnap-01151.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38016 and currentTime <= 38049 then
frame1 = Image.load("harehare/vlcsnap-01152.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38049 and currentTime <= 38082 then
frame1 = Image.load("harehare/vlcsnap-01153.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38082 and currentTime <= 38115 then
frame1 = Image.load("harehare/vlcsnap-01154.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38115 and currentTime <= 38148 then
frame1 = Image.load("harehare/vlcsnap-01155.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38148 and currentTime <= 38181 then
frame1 = Image.load("harehare/vlcsnap-01156.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38181 and currentTime <= 38214 then
frame1 = Image.load("harehare/vlcsnap-01157.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38214 and currentTime <= 38247 then
frame1 = Image.load("harehare/vlcsnap-01158.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38247 and currentTime <= 38280 then
frame1 = Image.load("harehare/vlcsnap-01159.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38280 and currentTime <= 38313 then
frame1 = Image.load("harehare/vlcsnap-01160.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38313 and currentTime <= 38346 then
frame1 = Image.load("harehare/vlcsnap-01161.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38346 and currentTime <= 38379 then
frame1 = Image.load("harehare/vlcsnap-01162.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38379 and currentTime <= 38412 then
frame1 = Image.load("harehare/vlcsnap-01163.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38412 and currentTime <= 38445 then
frame1 = Image.load("harehare/vlcsnap-01164.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38445 and currentTime <= 38478 then
frame1 = Image.load("harehare/vlcsnap-01165.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38478 and currentTime <= 38511 then
frame1 = Image.load("harehare/vlcsnap-01166.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38511 and currentTime <= 38544 then
frame1 = Image.load("harehare/vlcsnap-01167.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38544 and currentTime <= 38577 then
frame1 = Image.load("harehare/vlcsnap-01168.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38577 and currentTime <= 38610 then
frame1 = Image.load("harehare/vlcsnap-01169.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38610 and currentTime <= 38643 then
frame1 = Image.load("harehare/vlcsnap-01170.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38643 and currentTime <= 38676 then
frame1 = Image.load("harehare/vlcsnap-01171.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38676 and currentTime <= 38709 then
frame1 = Image.load("harehare/vlcsnap-01172.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38709 and currentTime <= 38742 then
frame1 = Image.load("harehare/vlcsnap-01173.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38742 and currentTime <= 38775 then
frame1 = Image.load("harehare/vlcsnap-01174.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38775 and currentTime <= 38808 then
frame1 = Image.load("harehare/vlcsnap-01175.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38808 and currentTime <= 38841 then
frame1 = Image.load("harehare/vlcsnap-01176.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38841 and currentTime <= 38874 then
frame1 = Image.load("harehare/vlcsnap-01177.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38874 and currentTime <= 38907 then
frame1 = Image.load("harehare/vlcsnap-01178.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38907 and currentTime <= 38940 then
frame1 = Image.load("harehare/vlcsnap-01179.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38940 and currentTime <= 38973 then
frame1 = Image.load("harehare/vlcsnap-01180.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 38973 and currentTime <= 39006 then
frame1 = Image.load("harehare/vlcsnap-01181.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39006 and currentTime <= 39039 then
frame1 = Image.load("harehare/vlcsnap-01182.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39039 and currentTime <= 39072 then
frame1 = Image.load("harehare/vlcsnap-01183.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39072 and currentTime <= 39105 then
frame1 = Image.load("harehare/vlcsnap-01184.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39105 and currentTime <= 39138 then
frame1 = Image.load("harehare/vlcsnap-01185.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39138 and currentTime <= 39171 then
frame1 = Image.load("harehare/vlcsnap-01186.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39171 and currentTime <= 39204 then
frame1 = Image.load("harehare/vlcsnap-01187.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39204 and currentTime <= 39237 then
frame1 = Image.load("harehare/vlcsnap-01188.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39237 and currentTime <= 39270 then
frame1 = Image.load("harehare/vlcsnap-01189.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39270 and currentTime <= 39303 then
frame1 = Image.load("harehare/vlcsnap-01190.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39303 and currentTime <= 39336 then
frame1 = Image.load("harehare/vlcsnap-01191.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39336 and currentTime <= 39369 then
frame1 = Image.load("harehare/vlcsnap-01192.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39369 and currentTime <= 39402 then
frame1 = Image.load("harehare/vlcsnap-01193.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39402 and currentTime <= 39435 then
frame1 = Image.load("harehare/vlcsnap-01194.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39435 and currentTime <= 39468 then
frame1 = Image.load("harehare/vlcsnap-01195.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39468 and currentTime <= 39501 then
frame1 = Image.load("harehare/vlcsnap-01196.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39501 and currentTime <= 39534 then
frame1 = Image.load("harehare/vlcsnap-01197.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39534 and currentTime <= 39567 then
frame1 = Image.load("harehare/vlcsnap-01198.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39567 and currentTime <= 39600 then
frame1 = Image.load("harehare/vlcsnap-01199.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39600 and currentTime <= 39633 then
frame1 = Image.load("harehare/vlcsnap-01200.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39633 and currentTime <= 39666 then
frame1 = Image.load("harehare/vlcsnap-01201.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39666 and currentTime <= 39699 then
frame1 = Image.load("harehare/vlcsnap-01202.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39699 and currentTime <= 39732 then
frame1 = Image.load("harehare/vlcsnap-01203.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39732 and currentTime <= 39765 then
frame1 = Image.load("harehare/vlcsnap-01204.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39765 and currentTime <= 39798 then
frame1 = Image.load("harehare/vlcsnap-01205.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39798 and currentTime <= 39831 then
frame1 = Image.load("harehare/vlcsnap-01206.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39831 and currentTime <= 39864 then
frame1 = Image.load("harehare/vlcsnap-01207.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39864 and currentTime <= 39897 then
frame1 = Image.load("harehare/vlcsnap-01208.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39897 and currentTime <= 39930 then
frame1 = Image.load("harehare/vlcsnap-01209.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39930 and currentTime <= 39963 then
frame1 = Image.load("harehare/vlcsnap-01210.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39963 and currentTime <= 39996 then
frame1 = Image.load("harehare/vlcsnap-01211.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 39996 and currentTime <= 40029 then
frame1 = Image.load("harehare/vlcsnap-01212.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40029 and currentTime <= 40062 then
frame1 = Image.load("harehare/vlcsnap-01213.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40062 and currentTime <= 40095 then
frame1 = Image.load("harehare/vlcsnap-01214.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40095 and currentTime <= 40128 then
frame1 = Image.load("harehare/vlcsnap-01215.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40128 and currentTime <= 40161 then
frame1 = Image.load("harehare/vlcsnap-01216.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40161 and currentTime <= 40194 then
frame1 = Image.load("harehare/vlcsnap-01217.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40194 and currentTime <= 40227 then
frame1 = Image.load("harehare/vlcsnap-01218.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40227 and currentTime <= 40260 then
frame1 = Image.load("harehare/vlcsnap-01219.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40260 and currentTime <= 40293 then
frame1 = Image.load("harehare/vlcsnap-01220.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40293 and currentTime <= 40326 then
frame1 = Image.load("harehare/vlcsnap-01221.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40326 and currentTime <= 40359 then
frame1 = Image.load("harehare/vlcsnap-01222.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40359 and currentTime <= 40392 then
frame1 = Image.load("harehare/vlcsnap-01223.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40392 and currentTime <= 40425 then
frame1 = Image.load("harehare/vlcsnap-01224.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40425 and currentTime <= 40458 then
frame1 = Image.load("harehare/vlcsnap-01225.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40458 and currentTime <= 40491 then
frame1 = Image.load("harehare/vlcsnap-01226.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40491 and currentTime <= 40524 then
frame1 = Image.load("harehare/vlcsnap-01227.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40524 and currentTime <= 40557 then
frame1 = Image.load("harehare/vlcsnap-01228.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40557 and currentTime <= 40590 then
frame1 = Image.load("harehare/vlcsnap-01229.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40590 and currentTime <= 40623 then
frame1 = Image.load("harehare/vlcsnap-01230.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40623 and currentTime <= 40656 then
frame1 = Image.load("harehare/vlcsnap-01231.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40656 and currentTime <= 40689 then
frame1 = Image.load("harehare/vlcsnap-01232.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40689 and currentTime <= 40722 then
frame1 = Image.load("harehare/vlcsnap-01233.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40722 and currentTime <= 40755 then
frame1 = Image.load("harehare/vlcsnap-01234.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40755 and currentTime <= 40788 then
frame1 = Image.load("harehare/vlcsnap-01235.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40788 and currentTime <= 40821 then
frame1 = Image.load("harehare/vlcsnap-01236.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40821 and currentTime <= 40854 then
frame1 = Image.load("harehare/vlcsnap-01237.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40854 and currentTime <= 40887 then
frame1 = Image.load("harehare/vlcsnap-01238.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40887 and currentTime <= 40920 then
frame1 = Image.load("harehare/vlcsnap-01239.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40920 and currentTime <= 40953 then
frame1 = Image.load("harehare/vlcsnap-01240.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40953 and currentTime <= 40986 then
frame1 = Image.load("harehare/vlcsnap-01241.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 40986 and currentTime <= 41019 then
frame1 = Image.load("harehare/vlcsnap-01242.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41019 and currentTime <= 41052 then
frame1 = Image.load("harehare/vlcsnap-01243.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41052 and currentTime <= 41085 then
frame1 = Image.load("harehare/vlcsnap-01244.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41085 and currentTime <= 41118 then
frame1 = Image.load("harehare/vlcsnap-01245.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41118 and currentTime <= 41151 then
frame1 = Image.load("harehare/vlcsnap-01246.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41151 and currentTime <= 41184 then
frame1 = Image.load("harehare/vlcsnap-01247.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41184 and currentTime <= 41217 then
frame1 = Image.load("harehare/vlcsnap-01248.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41217 and currentTime <= 41250 then
frame1 = Image.load("harehare/vlcsnap-01249.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41250 and currentTime <= 41283 then
frame1 = Image.load("harehare/vlcsnap-01250.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41283 and currentTime <= 41316 then
frame1 = Image.load("harehare/vlcsnap-01251.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41316 and currentTime <= 41349 then
frame1 = Image.load("harehare/vlcsnap-01252.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41349 and currentTime <= 41382 then
frame1 = Image.load("harehare/vlcsnap-01253.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41382 and currentTime <= 41415 then
frame1 = Image.load("harehare/vlcsnap-01254.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41415 and currentTime <= 41448 then
frame1 = Image.load("harehare/vlcsnap-01255.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41448 and currentTime <= 41481 then
frame1 = Image.load("harehare/vlcsnap-01256.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41481 and currentTime <= 41514 then
frame1 = Image.load("harehare/vlcsnap-01257.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41514 and currentTime <= 41547 then
frame1 = Image.load("harehare/vlcsnap-01258.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41547 and currentTime <= 41580 then
frame1 = Image.load("harehare/vlcsnap-01259.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41580 and currentTime <= 41613 then
frame1 = Image.load("harehare/vlcsnap-01260.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41613 and currentTime <= 41646 then
frame1 = Image.load("harehare/vlcsnap-01261.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41646 and currentTime <= 41679 then
frame1 = Image.load("harehare/vlcsnap-01262.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41679 and currentTime <= 41712 then
frame1 = Image.load("harehare/vlcsnap-01263.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41712 and currentTime <= 41745 then
frame1 = Image.load("harehare/vlcsnap-01264.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41745 and currentTime <= 41778 then
frame1 = Image.load("harehare/vlcsnap-01265.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41778 and currentTime <= 41811 then
frame1 = Image.load("harehare/vlcsnap-01266.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41811 and currentTime <= 41844 then
frame1 = Image.load("harehare/vlcsnap-01267.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41844 and currentTime <= 41877 then
frame1 = Image.load("harehare/vlcsnap-01268.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41877 and currentTime <= 41910 then
frame1 = Image.load("harehare/vlcsnap-01269.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41910 and currentTime <= 41943 then
frame1 = Image.load("harehare/vlcsnap-01270.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41943 and currentTime <= 41976 then
frame1 = Image.load("harehare/vlcsnap-01271.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 41976 and currentTime <= 42009 then
frame1 = Image.load("harehare/vlcsnap-01272.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42009 and currentTime <= 42042 then
frame1 = Image.load("harehare/vlcsnap-01273.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42042 and currentTime <= 42075 then
frame1 = Image.load("harehare/vlcsnap-01274.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42075 and currentTime <= 42108 then
frame1 = Image.load("harehare/vlcsnap-01275.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42108 and currentTime <= 42141 then
frame1 = Image.load("harehare/vlcsnap-01276.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42141 and currentTime <= 42174 then
frame1 = Image.load("harehare/vlcsnap-01277.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42174 and currentTime <= 42207 then
frame1 = Image.load("harehare/vlcsnap-01278.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42207 and currentTime <= 42240 then
frame1 = Image.load("harehare/vlcsnap-01279.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42240 and currentTime <= 42273 then
frame1 = Image.load("harehare/vlcsnap-01280.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42273 and currentTime <= 42306 then
frame1 = Image.load("harehare/vlcsnap-01281.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42306 and currentTime <= 42339 then
frame1 = Image.load("harehare/vlcsnap-01282.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42339 and currentTime <= 42372 then
frame1 = Image.load("harehare/vlcsnap-01283.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42372 and currentTime <= 42405 then
frame1 = Image.load("harehare/vlcsnap-01284.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42405 and currentTime <= 42438 then
frame1 = Image.load("harehare/vlcsnap-01285.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42438 and currentTime <= 42471 then
frame1 = Image.load("harehare/vlcsnap-01286.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42471 and currentTime <= 42504 then
frame1 = Image.load("harehare/vlcsnap-01287.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42504 and currentTime <= 42537 then
frame1 = Image.load("harehare/vlcsnap-01288.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42537 and currentTime <= 42570 then
frame1 = Image.load("harehare/vlcsnap-01289.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42570 and currentTime <= 42603 then
frame1 = Image.load("harehare/vlcsnap-01290.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42603 and currentTime <= 42636 then
frame1 = Image.load("harehare/vlcsnap-01291.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42636 and currentTime <= 42669 then
frame1 = Image.load("harehare/vlcsnap-01292.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42669 and currentTime <= 42702 then
frame1 = Image.load("harehare/vlcsnap-01293.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42702 and currentTime <= 42735 then
frame1 = Image.load("harehare/vlcsnap-01294.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42735 and currentTime <= 42768 then
frame1 = Image.load("harehare/vlcsnap-01295.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42768 and currentTime <= 42801 then
frame1 = Image.load("harehare/vlcsnap-01296.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42801 and currentTime <= 42834 then
frame1 = Image.load("harehare/vlcsnap-01297.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42834 and currentTime <= 42867 then
frame1 = Image.load("harehare/vlcsnap-01298.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42867 and currentTime <= 42900 then
frame1 = Image.load("harehare/vlcsnap-01299.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42900 and currentTime <= 42933 then
frame1 = Image.load("harehare/vlcsnap-01300.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42933 and currentTime <= 42966 then
frame1 = Image.load("harehare/vlcsnap-01301.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42966 and currentTime <= 42999 then
frame1 = Image.load("harehare/vlcsnap-01302.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 42999 and currentTime <= 43032 then
frame1 = Image.load("harehare/vlcsnap-01303.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43032 and currentTime <= 43065 then
frame1 = Image.load("harehare/vlcsnap-01304.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43065 and currentTime <= 43098 then
frame1 = Image.load("harehare/vlcsnap-01305.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43098 and currentTime <= 43131 then
frame1 = Image.load("harehare/vlcsnap-01306.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43131 and currentTime <= 43164 then
frame1 = Image.load("harehare/vlcsnap-01307.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43164 and currentTime <= 43197 then
frame1 = Image.load("harehare/vlcsnap-01308.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43197 and currentTime <= 43230 then
frame1 = Image.load("harehare/vlcsnap-01309.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43230 and currentTime <= 43263 then
frame1 = Image.load("harehare/vlcsnap-01310.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43263 and currentTime <= 43296 then
frame1 = Image.load("harehare/vlcsnap-01311.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43296 and currentTime <= 43329 then
frame1 = Image.load("harehare/vlcsnap-01312.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43329 and currentTime <= 43362 then
frame1 = Image.load("harehare/vlcsnap-01313.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43362 and currentTime <= 43395 then
frame1 = Image.load("harehare/vlcsnap-01314.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43395 and currentTime <= 43428 then
frame1 = Image.load("harehare/vlcsnap-01315.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43428 and currentTime <= 43461 then
frame1 = Image.load("harehare/vlcsnap-01316.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43461 and currentTime <= 43494 then
frame1 = Image.load("harehare/vlcsnap-01317.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43494 and currentTime <= 43527 then
frame1 = Image.load("harehare/vlcsnap-01318.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43527 and currentTime <= 43560 then
frame1 = Image.load("harehare/vlcsnap-01319.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43560 and currentTime <= 43593 then
frame1 = Image.load("harehare/vlcsnap-01320.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43593 and currentTime <= 43626 then
frame1 = Image.load("harehare/vlcsnap-01321.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43626 and currentTime <= 43659 then
frame1 = Image.load("harehare/vlcsnap-01322.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43659 and currentTime <= 43692 then
frame1 = Image.load("harehare/vlcsnap-01323.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43692 and currentTime <= 43725 then
frame1 = Image.load("harehare/vlcsnap-01324.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43725 and currentTime <= 43758 then
frame1 = Image.load("harehare/vlcsnap-01325.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43758 and currentTime <= 43791 then
frame1 = Image.load("harehare/vlcsnap-01326.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43791 and currentTime <= 43824 then
frame1 = Image.load("harehare/vlcsnap-01327.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43824 and currentTime <= 43857 then
frame1 = Image.load("harehare/vlcsnap-01328.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43857 and currentTime <= 43890 then
frame1 = Image.load("harehare/vlcsnap-01329.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43890 and currentTime <= 43923 then
frame1 = Image.load("harehare/vlcsnap-01330.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43923 and currentTime <= 43956 then
frame1 = Image.load("harehare/vlcsnap-01331.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43956 and currentTime <= 43989 then
frame1 = Image.load("harehare/vlcsnap-01332.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 43989 and currentTime <= 44022 then
frame1 = Image.load("harehare/vlcsnap-01333.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44022 and currentTime <= 44055 then
frame1 = Image.load("harehare/vlcsnap-01334.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44055 and currentTime <= 44088 then
frame1 = Image.load("harehare/vlcsnap-01335.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44088 and currentTime <= 44121 then
frame1 = Image.load("harehare/vlcsnap-01336.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44121 and currentTime <= 44154 then
frame1 = Image.load("harehare/vlcsnap-01337.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44154 and currentTime <= 44187 then
frame1 = Image.load("harehare/vlcsnap-01338.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44187 and currentTime <= 44220 then
frame1 = Image.load("harehare/vlcsnap-01339.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44220 and currentTime <= 44253 then
frame1 = Image.load("harehare/vlcsnap-01340.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44253 and currentTime <= 44286 then
frame1 = Image.load("harehare/vlcsnap-01341.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44286 and currentTime <= 44319 then
frame1 = Image.load("harehare/vlcsnap-01342.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44319 and currentTime <= 44352 then
frame1 = Image.load("harehare/vlcsnap-01343.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44352 and currentTime <= 44385 then
frame1 = Image.load("harehare/vlcsnap-01344.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44385 and currentTime <= 44418 then
frame1 = Image.load("harehare/vlcsnap-01345.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44418 and currentTime <= 44451 then
frame1 = Image.load("harehare/vlcsnap-01346.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44451 and currentTime <= 44484 then
frame1 = Image.load("harehare/vlcsnap-01347.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44484 and currentTime <= 44517 then
frame1 = Image.load("harehare/vlcsnap-01348.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44517 and currentTime <= 44550 then
frame1 = Image.load("harehare/vlcsnap-01349.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44550 and currentTime <= 44583 then
frame1 = Image.load("harehare/vlcsnap-01350.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44583 and currentTime <= 44616 then
frame1 = Image.load("harehare/vlcsnap-01351.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44616 and currentTime <= 44649 then
frame1 = Image.load("harehare/vlcsnap-01352.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44649 and currentTime <= 44682 then
frame1 = Image.load("harehare/vlcsnap-01353.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44682 and currentTime <= 44715 then
frame1 = Image.load("harehare/vlcsnap-01354.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44715 and currentTime <= 44748 then
frame1 = Image.load("harehare/vlcsnap-01355.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44748 and currentTime <= 44781 then
frame1 = Image.load("harehare/vlcsnap-01356.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44781 and currentTime <= 44814 then
frame1 = Image.load("harehare/vlcsnap-01357.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44814 and currentTime <= 44847 then
frame1 = Image.load("harehare/vlcsnap-01358.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44847 and currentTime <= 44880 then
frame1 = Image.load("harehare/vlcsnap-01359.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44880 and currentTime <= 44913 then
frame1 = Image.load("harehare/vlcsnap-01360.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44913 and currentTime <= 44946 then
frame1 = Image.load("harehare/vlcsnap-01361.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44946 and currentTime <= 44979 then
frame1 = Image.load("harehare/vlcsnap-01362.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 44979 and currentTime <= 45012 then
frame1 = Image.load("harehare/vlcsnap-01363.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45012 and currentTime <= 45045 then
frame1 = Image.load("harehare/vlcsnap-01364.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45045 and currentTime <= 45078 then
frame1 = Image.load("harehare/vlcsnap-01365.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45078 and currentTime <= 45111 then
frame1 = Image.load("harehare/vlcsnap-01366.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45111 and currentTime <= 45144 then
frame1 = Image.load("harehare/vlcsnap-01367.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45144 and currentTime <= 45177 then
frame1 = Image.load("harehare/vlcsnap-01368.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45177 and currentTime <= 45210 then
frame1 = Image.load("harehare/vlcsnap-01369.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45210 and currentTime <= 45243 then
frame1 = Image.load("harehare/vlcsnap-01370.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45243 and currentTime <= 45276 then
frame1 = Image.load("harehare/vlcsnap-01371.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45276 and currentTime <= 45309 then
frame1 = Image.load("harehare/vlcsnap-01372.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45309 and currentTime <= 45342 then
frame1 = Image.load("harehare/vlcsnap-01373.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45342 and currentTime <= 45375 then
frame1 = Image.load("harehare/vlcsnap-01374.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45375 and currentTime <= 45408 then
frame1 = Image.load("harehare/vlcsnap-01375.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45408 and currentTime <= 45441 then
frame1 = Image.load("harehare/vlcsnap-01376.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45441 and currentTime <= 45474 then
frame1 = Image.load("harehare/vlcsnap-01377.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45474 and currentTime <= 45507 then
frame1 = Image.load("harehare/vlcsnap-01378.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45507 and currentTime <= 45540 then
frame1 = Image.load("harehare/vlcsnap-01379.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45540 and currentTime <= 45573 then
frame1 = Image.load("harehare/vlcsnap-01380.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45573 and currentTime <= 45606 then
frame1 = Image.load("harehare/vlcsnap-01381.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45606 and currentTime <= 45639 then
frame1 = Image.load("harehare/vlcsnap-01382.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45639 and currentTime <= 45672 then
frame1 = Image.load("harehare/vlcsnap-01383.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45672 and currentTime <= 45705 then
frame1 = Image.load("harehare/vlcsnap-01384.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45705 and currentTime <= 45738 then
frame1 = Image.load("harehare/vlcsnap-01385.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45738 and currentTime <= 45771 then
frame1 = Image.load("harehare/vlcsnap-01386.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45771 and currentTime <= 45804 then
frame1 = Image.load("harehare/vlcsnap-01387.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45804 and currentTime <= 45837 then
frame1 = Image.load("harehare/vlcsnap-01388.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45837 and currentTime <= 45870 then
frame1 = Image.load("harehare/vlcsnap-01389.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45870 and currentTime <= 45903 then
frame1 = Image.load("harehare/vlcsnap-01390.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45903 and currentTime <= 45936 then
frame1 = Image.load("harehare/vlcsnap-01391.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45936 and currentTime <= 45969 then
frame1 = Image.load("harehare/vlcsnap-01392.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 45969 and currentTime <= 46002 then
frame1 = Image.load("harehare/vlcsnap-01393.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46002 and currentTime <= 46035 then
frame1 = Image.load("harehare/vlcsnap-01394.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46035 and currentTime <= 46068 then
frame1 = Image.load("harehare/vlcsnap-01395.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46068 and currentTime <= 46101 then
frame1 = Image.load("harehare/vlcsnap-01396.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46101 and currentTime <= 46134 then
frame1 = Image.load("harehare/vlcsnap-01397.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46134 and currentTime <= 46167 then
frame1 = Image.load("harehare/vlcsnap-01398.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46167 and currentTime <= 46200 then
frame1 = Image.load("harehare/vlcsnap-01399.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46200 and currentTime <= 46233 then
frame1 = Image.load("harehare/vlcsnap-01400.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46233 and currentTime <= 46266 then
frame1 = Image.load("harehare/vlcsnap-01401.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46266 and currentTime <= 46299 then
frame1 = Image.load("harehare/vlcsnap-01402.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46299 and currentTime <= 46332 then
frame1 = Image.load("harehare/vlcsnap-01403.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46332 and currentTime <= 46365 then
frame1 = Image.load("harehare/vlcsnap-01404.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46365 and currentTime <= 46398 then
frame1 = Image.load("harehare/vlcsnap-01405.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46398 and currentTime <= 46431 then
frame1 = Image.load("harehare/vlcsnap-01406.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46431 and currentTime <= 46464 then
frame1 = Image.load("harehare/vlcsnap-01407.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46464 and currentTime <= 46497 then
frame1 = Image.load("harehare/vlcsnap-01408.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46497 and currentTime <= 46530 then
frame1 = Image.load("harehare/vlcsnap-01409.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46530 and currentTime <= 46563 then
frame1 = Image.load("harehare/vlcsnap-01410.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46563 and currentTime <= 46596 then
frame1 = Image.load("harehare/vlcsnap-01411.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46596 and currentTime <= 46629 then
frame1 = Image.load("harehare/vlcsnap-01412.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46629 and currentTime <= 46662 then
frame1 = Image.load("harehare/vlcsnap-01413.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46662 and currentTime <= 46695 then
frame1 = Image.load("harehare/vlcsnap-01414.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46695 and currentTime <= 46728 then
frame1 = Image.load("harehare/vlcsnap-01415.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46728 and currentTime <= 46761 then
frame1 = Image.load("harehare/vlcsnap-01416.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46761 and currentTime <= 46794 then
frame1 = Image.load("harehare/vlcsnap-01417.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46794 and currentTime <= 46827 then
frame1 = Image.load("harehare/vlcsnap-01418.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46827 and currentTime <= 46860 then
frame1 = Image.load("harehare/vlcsnap-01419.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46860 and currentTime <= 46893 then
frame1 = Image.load("harehare/vlcsnap-01420.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46893 and currentTime <= 46926 then
frame1 = Image.load("harehare/vlcsnap-01421.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46926 and currentTime <= 46959 then
frame1 = Image.load("harehare/vlcsnap-01422.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46959 and currentTime <= 46992 then
frame1 = Image.load("harehare/vlcsnap-01423.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 46992 and currentTime <= 47025 then
frame1 = Image.load("harehare/vlcsnap-01424.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47025 and currentTime <= 47058 then
frame1 = Image.load("harehare/vlcsnap-01425.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47058 and currentTime <= 47091 then
frame1 = Image.load("harehare/vlcsnap-01426.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47091 and currentTime <= 47124 then
frame1 = Image.load("harehare/vlcsnap-01427.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47124 and currentTime <= 47157 then
frame1 = Image.load("harehare/vlcsnap-01428.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47157 and currentTime <= 47190 then
frame1 = Image.load("harehare/vlcsnap-01429.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47190 and currentTime <= 47223 then
frame1 = Image.load("harehare/vlcsnap-01430.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47223 and currentTime <= 47256 then
frame1 = Image.load("harehare/vlcsnap-01431.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47256 and currentTime <= 47289 then
frame1 = Image.load("harehare/vlcsnap-01432.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47289 and currentTime <= 47322 then
frame1 = Image.load("harehare/vlcsnap-01433.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47322 and currentTime <= 47355 then
frame1 = Image.load("harehare/vlcsnap-01434.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47355 and currentTime <= 47388 then
frame1 = Image.load("harehare/vlcsnap-01435.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47388 and currentTime <= 47421 then
frame1 = Image.load("harehare/vlcsnap-01436.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47421 and currentTime <= 47454 then
frame1 = Image.load("harehare/vlcsnap-01437.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47454 and currentTime <= 47487 then
frame1 = Image.load("harehare/vlcsnap-01438.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47487 and currentTime <= 47520 then
frame1 = Image.load("harehare/vlcsnap-01439.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47520 and currentTime <= 47553 then
frame1 = Image.load("harehare/vlcsnap-01440.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47553 and currentTime <= 47586 then
frame1 = Image.load("harehare/vlcsnap-01441.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47586 and currentTime <= 47619 then
frame1 = Image.load("harehare/vlcsnap-01442.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47619 and currentTime <= 47652 then
frame1 = Image.load("harehare/vlcsnap-01443.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47652 and currentTime <= 47685 then
frame1 = Image.load("harehare/vlcsnap-01444.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47685 and currentTime <= 47718 then
frame1 = Image.load("harehare/vlcsnap-01445.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47718 and currentTime <= 47751 then
frame1 = Image.load("harehare/vlcsnap-01446.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47751 and currentTime <= 47784 then
frame1 = Image.load("harehare/vlcsnap-01447.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47784 and currentTime <= 47817 then
frame1 = Image.load("harehare/vlcsnap-01448.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47817 and currentTime <= 47850 then
frame1 = Image.load("harehare/vlcsnap-01449.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47850 and currentTime <= 47883 then
frame1 = Image.load("harehare/vlcsnap-01450.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47883 and currentTime <= 47916 then
frame1 = Image.load("harehare/vlcsnap-01451.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47916 and currentTime <= 47949 then
frame1 = Image.load("harehare/vlcsnap-01452.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47949 and currentTime <= 47982 then
frame1 = Image.load("harehare/vlcsnap-01453.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 47982 and currentTime <= 48015 then
frame1 = Image.load("harehare/vlcsnap-01454.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48015 and currentTime <= 48048 then
frame1 = Image.load("harehare/vlcsnap-01455.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48048 and currentTime <= 48081 then
frame1 = Image.load("harehare/vlcsnap-01456.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48081 and currentTime <= 48114 then
frame1 = Image.load("harehare/vlcsnap-01457.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48114 and currentTime <= 48147 then
frame1 = Image.load("harehare/vlcsnap-01458.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48147 and currentTime <= 48180 then
frame1 = Image.load("harehare/vlcsnap-01459.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48180 and currentTime <= 48213 then
frame1 = Image.load("harehare/vlcsnap-01460.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48213 and currentTime <= 48246 then
frame1 = Image.load("harehare/vlcsnap-01461.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48246 and currentTime <= 48279 then
frame1 = Image.load("harehare/vlcsnap-01462.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48279 and currentTime <= 48312 then
frame1 = Image.load("harehare/vlcsnap-01463.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48312 and currentTime <= 48345 then
frame1 = Image.load("harehare/vlcsnap-01464.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48345 and currentTime <= 48378 then
frame1 = Image.load("harehare/vlcsnap-01465.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48378 and currentTime <= 48411 then
frame1 = Image.load("harehare/vlcsnap-01466.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48411 and currentTime <= 48444 then
frame1 = Image.load("harehare/vlcsnap-01467.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48444 and currentTime <= 48477 then
frame1 = Image.load("harehare/vlcsnap-01468.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48477 and currentTime <= 48510 then
frame1 = Image.load("harehare/vlcsnap-01469.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48510 and currentTime <= 48543 then
frame1 = Image.load("harehare/vlcsnap-01470.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48543 and currentTime <= 48576 then
frame1 = Image.load("harehare/vlcsnap-01471.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48576 and currentTime <= 48609 then
frame1 = Image.load("harehare/vlcsnap-01472.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48609 and currentTime <= 48642 then
frame1 = Image.load("harehare/vlcsnap-01473.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48642 and currentTime <= 48675 then
frame1 = Image.load("harehare/vlcsnap-01474.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48675 and currentTime <= 48708 then
frame1 = Image.load("harehare/vlcsnap-01475.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48708 and currentTime <= 48741 then
frame1 = Image.load("harehare/vlcsnap-01476.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48741 and currentTime <= 48774 then
frame1 = Image.load("harehare/vlcsnap-01477.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48774 and currentTime <= 48807 then
frame1 = Image.load("harehare/vlcsnap-01478.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48807 and currentTime <= 48840 then
frame1 = Image.load("harehare/vlcsnap-01479.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48840 and currentTime <= 48873 then
frame1 = Image.load("harehare/vlcsnap-01480.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48873 and currentTime <= 48906 then
frame1 = Image.load("harehare/vlcsnap-01481.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48906 and currentTime <= 48939 then
frame1 = Image.load("harehare/vlcsnap-01482.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48939 and currentTime <= 48972 then
frame1 = Image.load("harehare/vlcsnap-01483.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 48972 and currentTime <= 49005 then
frame1 = Image.load("harehare/vlcsnap-01484.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49005 and currentTime <= 49038 then
frame1 = Image.load("harehare/vlcsnap-01485.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49038 and currentTime <= 49071 then
frame1 = Image.load("harehare/vlcsnap-01486.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49071 and currentTime <= 49104 then
frame1 = Image.load("harehare/vlcsnap-01487.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49104 and currentTime <= 49137 then
frame1 = Image.load("harehare/vlcsnap-01488.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49137 and currentTime <= 49170 then
frame1 = Image.load("harehare/vlcsnap-01489.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49170 and currentTime <= 49203 then
frame1 = Image.load("harehare/vlcsnap-01490.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49203 and currentTime <= 49236 then
frame1 = Image.load("harehare/vlcsnap-01491.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49236 and currentTime <= 49269 then
frame1 = Image.load("harehare/vlcsnap-01492.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49269 and currentTime <= 49302 then
frame1 = Image.load("harehare/vlcsnap-01493.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49302 and currentTime <= 49335 then
frame1 = Image.load("harehare/vlcsnap-01494.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49335 and currentTime <= 49368 then
frame1 = Image.load("harehare/vlcsnap-01495.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49368 and currentTime <= 49401 then
frame1 = Image.load("harehare/vlcsnap-01496.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49401 and currentTime <= 49434 then
frame1 = Image.load("harehare/vlcsnap-01497.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49434 and currentTime <= 49467 then
frame1 = Image.load("harehare/vlcsnap-01498.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49467 and currentTime <= 49500 then
frame1 = Image.load("harehare/vlcsnap-01499.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49500 and currentTime <= 49533 then
frame1 = Image.load("harehare/vlcsnap-01500.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49533 and currentTime <= 49566 then
frame1 = Image.load("harehare/vlcsnap-01501.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49566 and currentTime <= 49599 then
frame1 = Image.load("harehare/vlcsnap-01502.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49599 and currentTime <= 49632 then
frame1 = Image.load("harehare/vlcsnap-01503.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49632 and currentTime <= 49665 then
frame1 = Image.load("harehare/vlcsnap-01504.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49665 and currentTime <= 49698 then
frame1 = Image.load("harehare/vlcsnap-01505.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49698 and currentTime <= 49731 then
frame1 = Image.load("harehare/vlcsnap-01506.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49731 and currentTime <= 49764 then
frame1 = Image.load("harehare/vlcsnap-01507.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49764 and currentTime <= 49797 then
frame1 = Image.load("harehare/vlcsnap-01508.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49797 and currentTime <= 49830 then
frame1 = Image.load("harehare/vlcsnap-01509.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49830 and currentTime <= 49863 then
frame1 = Image.load("harehare/vlcsnap-01510.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49863 and currentTime <= 49896 then
frame1 = Image.load("harehare/vlcsnap-01511.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49896 and currentTime <= 49929 then
frame1 = Image.load("harehare/vlcsnap-01512.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49929 and currentTime <= 49962 then
frame1 = Image.load("harehare/vlcsnap-01513.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49962 and currentTime <= 49995 then
frame1 = Image.load("harehare/vlcsnap-01514.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 49995 and currentTime <= 50028 then
frame1 = Image.load("harehare/vlcsnap-01515.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50028 and currentTime <= 50061 then
frame1 = Image.load("harehare/vlcsnap-01516.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50061 and currentTime <= 50094 then
frame1 = Image.load("harehare/vlcsnap-01517.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50094 and currentTime <= 50127 then
frame1 = Image.load("harehare/vlcsnap-01518.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50127 and currentTime <= 50160 then
frame1 = Image.load("harehare/vlcsnap-01519.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50160 and currentTime <= 50193 then
frame1 = Image.load("harehare/vlcsnap-01520.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50193 and currentTime <= 50226 then
frame1 = Image.load("harehare/vlcsnap-01521.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50226 and currentTime <= 50259 then
frame1 = Image.load("harehare/vlcsnap-01522.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50259 and currentTime <= 50292 then
frame1 = Image.load("harehare/vlcsnap-01523.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50292 and currentTime <= 50325 then
frame1 = Image.load("harehare/vlcsnap-01524.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50325 and currentTime <= 50358 then
frame1 = Image.load("harehare/vlcsnap-01525.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50358 and currentTime <= 50391 then
frame1 = Image.load("harehare/vlcsnap-01526.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50391 and currentTime <= 50424 then
frame1 = Image.load("harehare/vlcsnap-01527.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50424 and currentTime <= 50457 then
frame1 = Image.load("harehare/vlcsnap-01528.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50457 and currentTime <= 50490 then
frame1 = Image.load("harehare/vlcsnap-01529.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50490 and currentTime <= 50523 then
frame1 = Image.load("harehare/vlcsnap-01530.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50523 and currentTime <= 50556 then
frame1 = Image.load("harehare/vlcsnap-01531.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50556 and currentTime <= 50589 then
frame1 = Image.load("harehare/vlcsnap-01532.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50589 and currentTime <= 50622 then
frame1 = Image.load("harehare/vlcsnap-01533.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50622 and currentTime <= 50655 then
frame1 = Image.load("harehare/vlcsnap-01534.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50655 and currentTime <= 50688 then
frame1 = Image.load("harehare/vlcsnap-01535.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50688 and currentTime <= 50721 then
frame1 = Image.load("harehare/vlcsnap-01536.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50721 and currentTime <= 50754 then
frame1 = Image.load("harehare/vlcsnap-01537.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50754 and currentTime <= 50787 then
frame1 = Image.load("harehare/vlcsnap-01538.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50787 and currentTime <= 50820 then
frame1 = Image.load("harehare/vlcsnap-01539.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50820 and currentTime <= 50853 then
frame1 = Image.load("harehare/vlcsnap-01540.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50853 and currentTime <= 50886 then
frame1 = Image.load("harehare/vlcsnap-01541.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50886 and currentTime <= 50919 then
frame1 = Image.load("harehare/vlcsnap-01542.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50919 and currentTime <= 50952 then
frame1 = Image.load("harehare/vlcsnap-01543.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50952 and currentTime <= 50985 then
frame1 = Image.load("harehare/vlcsnap-01544.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 50985 and currentTime <= 51018 then
frame1 = Image.load("harehare/vlcsnap-01545.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51018 and currentTime <= 51051 then
frame1 = Image.load("harehare/vlcsnap-01546.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51051 and currentTime <= 51084 then
frame1 = Image.load("harehare/vlcsnap-01547.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51084 and currentTime <= 51117 then
frame1 = Image.load("harehare/vlcsnap-01548.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51117 and currentTime <= 51150 then
frame1 = Image.load("harehare/vlcsnap-01549.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51150 and currentTime <= 51183 then
frame1 = Image.load("harehare/vlcsnap-01550.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51183 and currentTime <= 51216 then
frame1 = Image.load("harehare/vlcsnap-01551.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51216 and currentTime <= 51249 then
frame1 = Image.load("harehare/vlcsnap-01552.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51249 and currentTime <= 51282 then
frame1 = Image.load("harehare/vlcsnap-01553.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51282 and currentTime <= 51315 then
frame1 = Image.load("harehare/vlcsnap-01554.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51315 and currentTime <= 51348 then
frame1 = Image.load("harehare/vlcsnap-01555.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51348 and currentTime <= 51381 then
frame1 = Image.load("harehare/vlcsnap-01556.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51381 and currentTime <= 51414 then
frame1 = Image.load("harehare/vlcsnap-01557.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51414 and currentTime <= 51447 then
frame1 = Image.load("harehare/vlcsnap-01558.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51447 and currentTime <= 51480 then
frame1 = Image.load("harehare/vlcsnap-01559.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51480 and currentTime <= 51513 then
frame1 = Image.load("harehare/vlcsnap-01560.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51513 and currentTime <= 51546 then
frame1 = Image.load("harehare/vlcsnap-01561.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51546 and currentTime <= 51579 then
frame1 = Image.load("harehare/vlcsnap-01562.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51579 and currentTime <= 51612 then
frame1 = Image.load("harehare/vlcsnap-01563.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51612 and currentTime <= 51645 then
frame1 = Image.load("harehare/vlcsnap-01564.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51645 and currentTime <= 51678 then
frame1 = Image.load("harehare/vlcsnap-01565.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51678 and currentTime <= 51711 then
frame1 = Image.load("harehare/vlcsnap-01566.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51711 and currentTime <= 51744 then
frame1 = Image.load("harehare/vlcsnap-01567.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51744 and currentTime <= 51777 then
frame1 = Image.load("harehare/vlcsnap-01568.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51777 and currentTime <= 51810 then
frame1 = Image.load("harehare/vlcsnap-01569.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51810 and currentTime <= 51843 then
frame1 = Image.load("harehare/vlcsnap-01570.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51843 and currentTime <= 51876 then
frame1 = Image.load("harehare/vlcsnap-01571.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51876 and currentTime <= 51909 then
frame1 = Image.load("harehare/vlcsnap-01572.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51909 and currentTime <= 51942 then
frame1 = Image.load("harehare/vlcsnap-01573.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51942 and currentTime <= 51975 then
frame1 = Image.load("harehare/vlcsnap-01574.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 51975 and currentTime <= 52008 then
frame1 = Image.load("harehare/vlcsnap-01575.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52008 and currentTime <= 52041 then
frame1 = Image.load("harehare/vlcsnap-01576.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52041 and currentTime <= 52074 then
frame1 = Image.load("harehare/vlcsnap-01577.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52074 and currentTime <= 52107 then
frame1 = Image.load("harehare/vlcsnap-01578.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52107 and currentTime <= 52140 then
frame1 = Image.load("harehare/vlcsnap-01579.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52140 and currentTime <= 52173 then
frame1 = Image.load("harehare/vlcsnap-01580.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52173 and currentTime <= 52206 then
frame1 = Image.load("harehare/vlcsnap-01581.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52206 and currentTime <= 52239 then
frame1 = Image.load("harehare/vlcsnap-01582.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52239 and currentTime <= 52272 then
frame1 = Image.load("harehare/vlcsnap-01583.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52272 and currentTime <= 52305 then
frame1 = Image.load("harehare/vlcsnap-01584.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52305 and currentTime <= 52338 then
frame1 = Image.load("harehare/vlcsnap-01585.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52338 and currentTime <= 52371 then
frame1 = Image.load("harehare/vlcsnap-01586.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52371 and currentTime <= 52404 then
frame1 = Image.load("harehare/vlcsnap-01587.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52404 and currentTime <= 52437 then
frame1 = Image.load("harehare/vlcsnap-01588.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52437 and currentTime <= 52470 then
frame1 = Image.load("harehare/vlcsnap-01589.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52470 and currentTime <= 52503 then
frame1 = Image.load("harehare/vlcsnap-01590.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52503 and currentTime <= 52536 then
frame1 = Image.load("harehare/vlcsnap-01591.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52536 and currentTime <= 52569 then
frame1 = Image.load("harehare/vlcsnap-01592.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52569 and currentTime <= 52602 then
frame1 = Image.load("harehare/vlcsnap-01593.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52602 and currentTime <= 52635 then
frame1 = Image.load("harehare/vlcsnap-01594.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52635 and currentTime <= 52668 then
frame1 = Image.load("harehare/vlcsnap-01595.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52668 and currentTime <= 52701 then
frame1 = Image.load("harehare/vlcsnap-01596.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52701 and currentTime <= 52734 then
frame1 = Image.load("harehare/vlcsnap-01597.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52734 and currentTime <= 52767 then
frame1 = Image.load("harehare/vlcsnap-01598.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52767 and currentTime <= 52800 then
frame1 = Image.load("harehare/vlcsnap-01599.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52800 and currentTime <= 52833 then
frame1 = Image.load("harehare/vlcsnap-01600.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52833 and currentTime <= 52866 then
frame1 = Image.load("harehare/vlcsnap-01601.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52866 and currentTime <= 52899 then
frame1 = Image.load("harehare/vlcsnap-01602.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52899 and currentTime <= 52932 then
frame1 = Image.load("harehare/vlcsnap-01603.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52932 and currentTime <= 52965 then
frame1 = Image.load("harehare/vlcsnap-01604.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52965 and currentTime <= 52998 then
frame1 = Image.load("harehare/vlcsnap-01605.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 52998 and currentTime <= 53031 then
frame1 = Image.load("harehare/vlcsnap-01606.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53031 and currentTime <= 53064 then
frame1 = Image.load("harehare/vlcsnap-01607.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53064 and currentTime <= 53097 then
frame1 = Image.load("harehare/vlcsnap-01608.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53097 and currentTime <= 53130 then
frame1 = Image.load("harehare/vlcsnap-01609.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53130 and currentTime <= 53163 then
frame1 = Image.load("harehare/vlcsnap-01610.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53163 and currentTime <= 53196 then
frame1 = Image.load("harehare/vlcsnap-01611.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53196 and currentTime <= 53229 then
frame1 = Image.load("harehare/vlcsnap-01612.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53229 and currentTime <= 53262 then
frame1 = Image.load("harehare/vlcsnap-01613.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53262 and currentTime <= 53295 then
frame1 = Image.load("harehare/vlcsnap-01614.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53295 and currentTime <= 53328 then
frame1 = Image.load("harehare/vlcsnap-01615.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53328 and currentTime <= 53361 then
frame1 = Image.load("harehare/vlcsnap-01616.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53361 and currentTime <= 53394 then
frame1 = Image.load("harehare/vlcsnap-01617.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53394 and currentTime <= 53427 then
frame1 = Image.load("harehare/vlcsnap-01618.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53427 and currentTime <= 53460 then
frame1 = Image.load("harehare/vlcsnap-01619.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53460 and currentTime <= 53493 then
frame1 = Image.load("harehare/vlcsnap-01620.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53493 and currentTime <= 53526 then
frame1 = Image.load("harehare/vlcsnap-01621.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53526 and currentTime <= 53559 then
frame1 = Image.load("harehare/vlcsnap-01622.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53559 and currentTime <= 53592 then
frame1 = Image.load("harehare/vlcsnap-01623.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53592 and currentTime <= 53625 then
frame1 = Image.load("harehare/vlcsnap-01624.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53625 and currentTime <= 53658 then
frame1 = Image.load("harehare/vlcsnap-01625.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53658 and currentTime <= 53691 then
frame1 = Image.load("harehare/vlcsnap-01626.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53691 and currentTime <= 53724 then
frame1 = Image.load("harehare/vlcsnap-01627.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53724 and currentTime <= 53757 then
frame1 = Image.load("harehare/vlcsnap-01628.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53757 and currentTime <= 53790 then
frame1 = Image.load("harehare/vlcsnap-01629.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53790 and currentTime <= 53823 then
frame1 = Image.load("harehare/vlcsnap-01630.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53823 and currentTime <= 53856 then
frame1 = Image.load("harehare/vlcsnap-01631.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53856 and currentTime <= 53889 then
frame1 = Image.load("harehare/vlcsnap-01632.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53889 and currentTime <= 53922 then
frame1 = Image.load("harehare/vlcsnap-01633.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53922 and currentTime <= 53955 then
frame1 = Image.load("harehare/vlcsnap-01634.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53955 and currentTime <= 53988 then
frame1 = Image.load("harehare/vlcsnap-01635.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 53988 and currentTime <= 54021 then
frame1 = Image.load("harehare/vlcsnap-01636.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54021 and currentTime <= 54054 then
frame1 = Image.load("harehare/vlcsnap-01637.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54054 and currentTime <= 54087 then
frame1 = Image.load("harehare/vlcsnap-01638.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54087 and currentTime <= 54120 then
frame1 = Image.load("harehare/vlcsnap-01639.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54120 and currentTime <= 54153 then
frame1 = Image.load("harehare/vlcsnap-01640.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54153 and currentTime <= 54186 then
frame1 = Image.load("harehare/vlcsnap-01641.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54186 and currentTime <= 54219 then
frame1 = Image.load("harehare/vlcsnap-01642.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54219 and currentTime <= 54252 then
frame1 = Image.load("harehare/vlcsnap-01643.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54252 and currentTime <= 54285 then
frame1 = Image.load("harehare/vlcsnap-01644.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54285 and currentTime <= 54318 then
frame1 = Image.load("harehare/vlcsnap-01645.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54318 and currentTime <= 54351 then
frame1 = Image.load("harehare/vlcsnap-01646.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54351 and currentTime <= 54384 then
frame1 = Image.load("harehare/vlcsnap-01647.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54384 and currentTime <= 54417 then
frame1 = Image.load("harehare/vlcsnap-01648.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54417 and currentTime <= 54450 then
frame1 = Image.load("harehare/vlcsnap-01649.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54450 and currentTime <= 54483 then
frame1 = Image.load("harehare/vlcsnap-01650.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54483 and currentTime <= 54516 then
frame1 = Image.load("harehare/vlcsnap-01651.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54516 and currentTime <= 54549 then
frame1 = Image.load("harehare/vlcsnap-01652.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54549 and currentTime <= 54582 then
frame1 = Image.load("harehare/vlcsnap-01653.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54582 and currentTime <= 54615 then
frame1 = Image.load("harehare/vlcsnap-01654.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54615 and currentTime <= 54648 then
frame1 = Image.load("harehare/vlcsnap-01655.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54648 and currentTime <= 54681 then
frame1 = Image.load("harehare/vlcsnap-01656.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54681 and currentTime <= 54714 then
frame1 = Image.load("harehare/vlcsnap-01657.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54714 and currentTime <= 54747 then
frame1 = Image.load("harehare/vlcsnap-01658.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54747 and currentTime <= 54780 then
frame1 = Image.load("harehare/vlcsnap-01659.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54780 and currentTime <= 54813 then
frame1 = Image.load("harehare/vlcsnap-01660.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54813 and currentTime <= 54846 then
frame1 = Image.load("harehare/vlcsnap-01661.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54846 and currentTime <= 54879 then
frame1 = Image.load("harehare/vlcsnap-01662.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54879 and currentTime <= 54912 then
frame1 = Image.load("harehare/vlcsnap-01663.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54912 and currentTime <= 54945 then
frame1 = Image.load("harehare/vlcsnap-01664.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54945 and currentTime <= 54978 then
frame1 = Image.load("harehare/vlcsnap-01665.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 54978 and currentTime <= 55011 then
frame1 = Image.load("harehare/vlcsnap-01666.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55011 and currentTime <= 55044 then
frame1 = Image.load("harehare/vlcsnap-01667.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55044 and currentTime <= 55077 then
frame1 = Image.load("harehare/vlcsnap-01668.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55077 and currentTime <= 55110 then
frame1 = Image.load("harehare/vlcsnap-01669.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55110 and currentTime <= 55143 then
frame1 = Image.load("harehare/vlcsnap-01670.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55143 and currentTime <= 55176 then
frame1 = Image.load("harehare/vlcsnap-01671.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55176 and currentTime <= 55209 then
frame1 = Image.load("harehare/vlcsnap-01672.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55209 and currentTime <= 55242 then
frame1 = Image.load("harehare/vlcsnap-01673.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55242 and currentTime <= 55275 then
frame1 = Image.load("harehare/vlcsnap-01674.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55275 and currentTime <= 55308 then
frame1 = Image.load("harehare/vlcsnap-01675.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55308 and currentTime <= 55341 then
frame1 = Image.load("harehare/vlcsnap-01676.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55341 and currentTime <= 55374 then
frame1 = Image.load("harehare/vlcsnap-01677.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55374 and currentTime <= 55407 then
frame1 = Image.load("harehare/vlcsnap-01678.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55407 and currentTime <= 55440 then
frame1 = Image.load("harehare/vlcsnap-01679.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55440 and currentTime <= 55473 then
frame1 = Image.load("harehare/vlcsnap-01680.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55473 and currentTime <= 55506 then
frame1 = Image.load("harehare/vlcsnap-01681.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55506 and currentTime <= 55539 then
frame1 = Image.load("harehare/vlcsnap-01682.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55539 and currentTime <= 55572 then
frame1 = Image.load("harehare/vlcsnap-01683.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55572 and currentTime <= 55605 then
frame1 = Image.load("harehare/vlcsnap-01684.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55605 and currentTime <= 55638 then
frame1 = Image.load("harehare/vlcsnap-01685.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55638 and currentTime <= 55671 then
frame1 = Image.load("harehare/vlcsnap-01686.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55671 and currentTime <= 55704 then
frame1 = Image.load("harehare/vlcsnap-01687.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55704 and currentTime <= 55737 then
frame1 = Image.load("harehare/vlcsnap-01688.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55737 and currentTime <= 55770 then
frame1 = Image.load("harehare/vlcsnap-01689.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55770 and currentTime <= 55803 then
frame1 = Image.load("harehare/vlcsnap-01690.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55803 and currentTime <= 55836 then
frame1 = Image.load("harehare/vlcsnap-01691.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55836 and currentTime <= 55869 then
frame1 = Image.load("harehare/vlcsnap-01692.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55869 and currentTime <= 55902 then
frame1 = Image.load("harehare/vlcsnap-01693.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55902 and currentTime <= 55935 then
frame1 = Image.load("harehare/vlcsnap-01694.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55935 and currentTime <= 55968 then
frame1 = Image.load("harehare/vlcsnap-01695.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 55968 and currentTime <= 56001 then
frame1 = Image.load("harehare/vlcsnap-01696.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56001 and currentTime <= 56034 then
frame1 = Image.load("harehare/vlcsnap-01697.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56034 and currentTime <= 56067 then
frame1 = Image.load("harehare/vlcsnap-01698.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56067 and currentTime <= 56100 then
frame1 = Image.load("harehare/vlcsnap-01699.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56100 and currentTime <= 56133 then
frame1 = Image.load("harehare/vlcsnap-01700.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56133 and currentTime <= 56166 then
frame1 = Image.load("harehare/vlcsnap-01701.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56166 and currentTime <= 56199 then
frame1 = Image.load("harehare/vlcsnap-01702.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56199 and currentTime <= 56232 then
frame1 = Image.load("harehare/vlcsnap-01703.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56232 and currentTime <= 56265 then
frame1 = Image.load("harehare/vlcsnap-01704.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56265 and currentTime <= 56298 then
frame1 = Image.load("harehare/vlcsnap-01705.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56298 and currentTime <= 56331 then
frame1 = Image.load("harehare/vlcsnap-01706.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56331 and currentTime <= 56364 then
frame1 = Image.load("harehare/vlcsnap-01707.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56364 and currentTime <= 56397 then
frame1 = Image.load("harehare/vlcsnap-01708.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56397 and currentTime <= 56430 then
frame1 = Image.load("harehare/vlcsnap-01709.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56430 and currentTime <= 56463 then
frame1 = Image.load("harehare/vlcsnap-01710.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56463 and currentTime <= 56496 then
frame1 = Image.load("harehare/vlcsnap-01711.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56496 and currentTime <= 56529 then
frame1 = Image.load("harehare/vlcsnap-01712.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56529 and currentTime <= 56562 then
frame1 = Image.load("harehare/vlcsnap-01713.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56562 and currentTime <= 56595 then
frame1 = Image.load("harehare/vlcsnap-01714.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56595 and currentTime <= 56628 then
frame1 = Image.load("harehare/vlcsnap-01715.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56628 and currentTime <= 56661 then
frame1 = Image.load("harehare/vlcsnap-01716.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56661 and currentTime <= 56694 then
frame1 = Image.load("harehare/vlcsnap-01717.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56694 and currentTime <= 56727 then
frame1 = Image.load("harehare/vlcsnap-01718.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56727 and currentTime <= 56760 then
frame1 = Image.load("harehare/vlcsnap-01719.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56760 and currentTime <= 56793 then
frame1 = Image.load("harehare/vlcsnap-01720.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56793 and currentTime <= 56826 then
frame1 = Image.load("harehare/vlcsnap-01721.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56826 and currentTime <= 56859 then
frame1 = Image.load("harehare/vlcsnap-01722.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56859 and currentTime <= 56892 then
frame1 = Image.load("harehare/vlcsnap-01723.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56892 and currentTime <= 56925 then
frame1 = Image.load("harehare/vlcsnap-01724.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56925 and currentTime <= 56958 then
frame1 = Image.load("harehare/vlcsnap-01725.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56958 and currentTime <= 56991 then
frame1 = Image.load("harehare/vlcsnap-01726.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 56991 and currentTime <= 57024 then
frame1 = Image.load("harehare/vlcsnap-01727.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57024 and currentTime <= 57057 then
frame1 = Image.load("harehare/vlcsnap-01728.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57057 and currentTime <= 57090 then
frame1 = Image.load("harehare/vlcsnap-01729.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57090 and currentTime <= 57123 then
frame1 = Image.load("harehare/vlcsnap-01730.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57123 and currentTime <= 57156 then
frame1 = Image.load("harehare/vlcsnap-01731.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57156 and currentTime <= 57189 then
frame1 = Image.load("harehare/vlcsnap-01732.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57189 and currentTime <= 57222 then
frame1 = Image.load("harehare/vlcsnap-01733.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57222 and currentTime <= 57255 then
frame1 = Image.load("harehare/vlcsnap-01734.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57255 and currentTime <= 57288 then
frame1 = Image.load("harehare/vlcsnap-01735.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57288 and currentTime <= 57321 then
frame1 = Image.load("harehare/vlcsnap-01736.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57321 and currentTime <= 57354 then
frame1 = Image.load("harehare/vlcsnap-01737.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57354 and currentTime <= 57387 then
frame1 = Image.load("harehare/vlcsnap-01738.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57387 and currentTime <= 57420 then
frame1 = Image.load("harehare/vlcsnap-01739.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57420 and currentTime <= 57453 then
frame1 = Image.load("harehare/vlcsnap-01740.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57453 and currentTime <= 57486 then
frame1 = Image.load("harehare/vlcsnap-01741.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57486 and currentTime <= 57519 then
frame1 = Image.load("harehare/vlcsnap-01742.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57519 and currentTime <= 57552 then
frame1 = Image.load("harehare/vlcsnap-01743.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57552 and currentTime <= 57585 then
frame1 = Image.load("harehare/vlcsnap-01744.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57585 and currentTime <= 57618 then
frame1 = Image.load("harehare/vlcsnap-01745.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57618 and currentTime <= 57651 then
frame1 = Image.load("harehare/vlcsnap-01746.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57651 and currentTime <= 57684 then
frame1 = Image.load("harehare/vlcsnap-01747.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57684 and currentTime <= 57717 then
frame1 = Image.load("harehare/vlcsnap-01748.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57717 and currentTime <= 57750 then
frame1 = Image.load("harehare/vlcsnap-01749.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57750 and currentTime <= 57783 then
frame1 = Image.load("harehare/vlcsnap-01750.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57783 and currentTime <= 57816 then
frame1 = Image.load("harehare/vlcsnap-01751.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57816 and currentTime <= 57849 then
frame1 = Image.load("harehare/vlcsnap-01752.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57849 and currentTime <= 57882 then
frame1 = Image.load("harehare/vlcsnap-01753.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57882 and currentTime <= 57915 then
frame1 = Image.load("harehare/vlcsnap-01754.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57915 and currentTime <= 57948 then
frame1 = Image.load("harehare/vlcsnap-01755.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57948 and currentTime <= 57981 then
frame1 = Image.load("harehare/vlcsnap-01756.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 57981 and currentTime <= 58014 then
frame1 = Image.load("harehare/vlcsnap-01757.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58014 and currentTime <= 58047 then
frame1 = Image.load("harehare/vlcsnap-01758.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58047 and currentTime <= 58080 then
frame1 = Image.load("harehare/vlcsnap-01759.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58080 and currentTime <= 58113 then
frame1 = Image.load("harehare/vlcsnap-01760.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58113 and currentTime <= 58146 then
frame1 = Image.load("harehare/vlcsnap-01761.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58146 and currentTime <= 58179 then
frame1 = Image.load("harehare/vlcsnap-01762.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58179 and currentTime <= 58212 then
frame1 = Image.load("harehare/vlcsnap-01763.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58212 and currentTime <= 58245 then
frame1 = Image.load("harehare/vlcsnap-01764.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58245 and currentTime <= 58278 then
frame1 = Image.load("harehare/vlcsnap-01765.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58278 and currentTime <= 58311 then
frame1 = Image.load("harehare/vlcsnap-01766.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58311 and currentTime <= 58344 then
frame1 = Image.load("harehare/vlcsnap-01767.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58344 and currentTime <= 58377 then
frame1 = Image.load("harehare/vlcsnap-01768.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58377 and currentTime <= 58410 then
frame1 = Image.load("harehare/vlcsnap-01769.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58410 and currentTime <= 58443 then
frame1 = Image.load("harehare/vlcsnap-01770.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58443 and currentTime <= 58476 then
frame1 = Image.load("harehare/vlcsnap-01771.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58476 and currentTime <= 58509 then
frame1 = Image.load("harehare/vlcsnap-01772.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58509 and currentTime <= 58542 then
frame1 = Image.load("harehare/vlcsnap-01773.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58542 and currentTime <= 58575 then
frame1 = Image.load("harehare/vlcsnap-01774.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58575 and currentTime <= 58608 then
frame1 = Image.load("harehare/vlcsnap-01775.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58608 and currentTime <= 58641 then
frame1 = Image.load("harehare/vlcsnap-01776.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58641 and currentTime <= 58674 then
frame1 = Image.load("harehare/vlcsnap-01777.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58674 and currentTime <= 58707 then
frame1 = Image.load("harehare/vlcsnap-01778.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58707 and currentTime <= 58740 then
frame1 = Image.load("harehare/vlcsnap-01779.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58740 and currentTime <= 58773 then
frame1 = Image.load("harehare/vlcsnap-01780.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58773 and currentTime <= 58806 then
frame1 = Image.load("harehare/vlcsnap-01781.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58806 and currentTime <= 58839 then
frame1 = Image.load("harehare/vlcsnap-01782.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58839 and currentTime <= 58872 then
frame1 = Image.load("harehare/vlcsnap-01783.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58872 and currentTime <= 58905 then
frame1 = Image.load("harehare/vlcsnap-01784.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58905 and currentTime <= 58938 then
frame1 = Image.load("harehare/vlcsnap-01785.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58938 and currentTime <= 58971 then
frame1 = Image.load("harehare/vlcsnap-01786.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 58971 and currentTime <= 59004 then
frame1 = Image.load("harehare/vlcsnap-01787.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59004 and currentTime <= 59037 then
frame1 = Image.load("harehare/vlcsnap-01788.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59037 and currentTime <= 59070 then
frame1 = Image.load("harehare/vlcsnap-01789.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59070 and currentTime <= 59103 then
frame1 = Image.load("harehare/vlcsnap-01790.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59103 and currentTime <= 59136 then
frame1 = Image.load("harehare/vlcsnap-01791.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59136 and currentTime <= 59169 then
frame1 = Image.load("harehare/vlcsnap-01792.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59169 and currentTime <= 59202 then
frame1 = Image.load("harehare/vlcsnap-01793.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59202 and currentTime <= 59235 then
frame1 = Image.load("harehare/vlcsnap-01794.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59235 and currentTime <= 59268 then
frame1 = Image.load("harehare/vlcsnap-01795.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59268 and currentTime <= 59301 then
frame1 = Image.load("harehare/vlcsnap-01796.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59301 and currentTime <= 59334 then
frame1 = Image.load("harehare/vlcsnap-01797.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59334 and currentTime <= 59367 then
frame1 = Image.load("harehare/vlcsnap-01798.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59367 and currentTime <= 59400 then
frame1 = Image.load("harehare/vlcsnap-01799.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59400 and currentTime <= 59433 then
frame1 = Image.load("harehare/vlcsnap-01800.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59433 and currentTime <= 59466 then
frame1 = Image.load("harehare/vlcsnap-01801.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59466 and currentTime <= 59499 then
frame1 = Image.load("harehare/vlcsnap-01802.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59499 and currentTime <= 59532 then
frame1 = Image.load("harehare/vlcsnap-01803.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59532 and currentTime <= 59565 then
frame1 = Image.load("harehare/vlcsnap-01804.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59565 and currentTime <= 59598 then
frame1 = Image.load("harehare/vlcsnap-01805.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59598 and currentTime <= 59631 then
frame1 = Image.load("harehare/vlcsnap-01806.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59631 and currentTime <= 59664 then
frame1 = Image.load("harehare/vlcsnap-01807.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59664 and currentTime <= 59697 then
frame1 = Image.load("harehare/vlcsnap-01808.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59697 and currentTime <= 59730 then
frame1 = Image.load("harehare/vlcsnap-01809.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59730 and currentTime <= 59763 then
frame1 = Image.load("harehare/vlcsnap-01810.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59763 and currentTime <= 59796 then
frame1 = Image.load("harehare/vlcsnap-01811.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59796 and currentTime <= 59829 then
frame1 = Image.load("harehare/vlcsnap-01812.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59829 and currentTime <= 59862 then
frame1 = Image.load("harehare/vlcsnap-01813.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59862 and currentTime <= 59895 then
frame1 = Image.load("harehare/vlcsnap-01814.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59895 and currentTime <= 59928 then
frame1 = Image.load("harehare/vlcsnap-01815.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59928 and currentTime <= 59961 then
frame1 = Image.load("harehare/vlcsnap-01816.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59961 and currentTime <= 59994 then
frame1 = Image.load("harehare/vlcsnap-01817.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 59994 and currentTime <= 60027 then
frame1 = Image.load("harehare/vlcsnap-01818.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60027 and currentTime <= 60060 then
frame1 = Image.load("harehare/vlcsnap-01819.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60060 and currentTime <= 60093 then
frame1 = Image.load("harehare/vlcsnap-01820.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60093 and currentTime <= 60126 then
frame1 = Image.load("harehare/vlcsnap-01821.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60126 and currentTime <= 60159 then
frame1 = Image.load("harehare/vlcsnap-01822.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60159 and currentTime <= 60192 then
frame1 = Image.load("harehare/vlcsnap-01823.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60192 and currentTime <= 60225 then
frame1 = Image.load("harehare/vlcsnap-01824.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60225 and currentTime <= 60258 then
frame1 = Image.load("harehare/vlcsnap-01825.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60258 and currentTime <= 60291 then
frame1 = Image.load("harehare/vlcsnap-01826.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60291 and currentTime <= 60324 then
frame1 = Image.load("harehare/vlcsnap-01827.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60324 and currentTime <= 60357 then
frame1 = Image.load("harehare/vlcsnap-01828.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60357 and currentTime <= 60390 then
frame1 = Image.load("harehare/vlcsnap-01829.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60390 and currentTime <= 60423 then
frame1 = Image.load("harehare/vlcsnap-01830.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60423 and currentTime <= 60456 then
frame1 = Image.load("harehare/vlcsnap-01831.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60456 and currentTime <= 60489 then
frame1 = Image.load("harehare/vlcsnap-01832.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60489 and currentTime <= 60522 then
frame1 = Image.load("harehare/vlcsnap-01833.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60522 and currentTime <= 60555 then
frame1 = Image.load("harehare/vlcsnap-01834.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60555 and currentTime <= 60588 then
frame1 = Image.load("harehare/vlcsnap-01835.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60588 and currentTime <= 60621 then
frame1 = Image.load("harehare/vlcsnap-01836.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60621 and currentTime <= 60654 then
frame1 = Image.load("harehare/vlcsnap-01837.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60654 and currentTime <= 60687 then
frame1 = Image.load("harehare/vlcsnap-01838.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60687 and currentTime <= 60720 then
frame1 = Image.load("harehare/vlcsnap-01839.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60720 and currentTime <= 60753 then
frame1 = Image.load("harehare/vlcsnap-01840.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60753 and currentTime <= 60786 then
frame1 = Image.load("harehare/vlcsnap-01841.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60786 and currentTime <= 60819 then
frame1 = Image.load("harehare/vlcsnap-01842.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60819 and currentTime <= 60852 then
frame1 = Image.load("harehare/vlcsnap-01843.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60852 and currentTime <= 60885 then
frame1 = Image.load("harehare/vlcsnap-01844.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60885 and currentTime <= 60918 then
frame1 = Image.load("harehare/vlcsnap-01845.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60918 and currentTime <= 60951 then
frame1 = Image.load("harehare/vlcsnap-01846.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60951 and currentTime <= 60984 then
frame1 = Image.load("harehare/vlcsnap-01847.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 60984 and currentTime <= 61017 then
frame1 = Image.load("harehare/vlcsnap-01848.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61017 and currentTime <= 61050 then
frame1 = Image.load("harehare/vlcsnap-01849.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61050 and currentTime <= 61083 then
frame1 = Image.load("harehare/vlcsnap-01850.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61083 and currentTime <= 61116 then
frame1 = Image.load("harehare/vlcsnap-01851.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61116 and currentTime <= 61149 then
frame1 = Image.load("harehare/vlcsnap-01852.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61149 and currentTime <= 61182 then
frame1 = Image.load("harehare/vlcsnap-01853.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61182 and currentTime <= 61215 then
frame1 = Image.load("harehare/vlcsnap-01854.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61215 and currentTime <= 61248 then
frame1 = Image.load("harehare/vlcsnap-01855.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61248 and currentTime <= 61281 then
frame1 = Image.load("harehare/vlcsnap-01856.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61281 and currentTime <= 61314 then
frame1 = Image.load("harehare/vlcsnap-01857.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61314 and currentTime <= 61347 then
frame1 = Image.load("harehare/vlcsnap-01858.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61347 and currentTime <= 61380 then
frame1 = Image.load("harehare/vlcsnap-01859.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61380 and currentTime <= 61413 then
frame1 = Image.load("harehare/vlcsnap-01860.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61413 and currentTime <= 61446 then
frame1 = Image.load("harehare/vlcsnap-01861.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61446 and currentTime <= 61479 then
frame1 = Image.load("harehare/vlcsnap-01862.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61479 and currentTime <= 61512 then
frame1 = Image.load("harehare/vlcsnap-01863.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61512 and currentTime <= 61545 then
frame1 = Image.load("harehare/vlcsnap-01864.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61545 and currentTime <= 61578 then
frame1 = Image.load("harehare/vlcsnap-01865.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61578 and currentTime <= 61611 then
frame1 = Image.load("harehare/vlcsnap-01866.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61611 and currentTime <= 61644 then
frame1 = Image.load("harehare/vlcsnap-01867.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61644 and currentTime <= 61677 then
frame1 = Image.load("harehare/vlcsnap-01868.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61677 and currentTime <= 61710 then
frame1 = Image.load("harehare/vlcsnap-01869.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61710 and currentTime <= 61743 then
frame1 = Image.load("harehare/vlcsnap-01870.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61743 and currentTime <= 61776 then
frame1 = Image.load("harehare/vlcsnap-01871.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61776 and currentTime <= 61809 then
frame1 = Image.load("harehare/vlcsnap-01872.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61809 and currentTime <= 61842 then
frame1 = Image.load("harehare/vlcsnap-01873.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61842 and currentTime <= 61875 then
frame1 = Image.load("harehare/vlcsnap-01874.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61875 and currentTime <= 61908 then
frame1 = Image.load("harehare/vlcsnap-01875.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61908 and currentTime <= 61941 then
frame1 = Image.load("harehare/vlcsnap-01876.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61941 and currentTime <= 61974 then
frame1 = Image.load("harehare/vlcsnap-01877.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 61974 and currentTime <= 62007 then
frame1 = Image.load("harehare/vlcsnap-01878.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62007 and currentTime <= 62040 then
frame1 = Image.load("harehare/vlcsnap-01879.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62040 and currentTime <= 62073 then
frame1 = Image.load("harehare/vlcsnap-01880.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62073 and currentTime <= 62106 then
frame1 = Image.load("harehare/vlcsnap-01881.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62106 and currentTime <= 62139 then
frame1 = Image.load("harehare/vlcsnap-01882.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62139 and currentTime <= 62172 then
frame1 = Image.load("harehare/vlcsnap-01883.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62172 and currentTime <= 62205 then
frame1 = Image.load("harehare/vlcsnap-01884.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62205 and currentTime <= 62238 then
frame1 = Image.load("harehare/vlcsnap-01885.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62238 and currentTime <= 62271 then
frame1 = Image.load("harehare/vlcsnap-01886.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62271 and currentTime <= 62304 then
frame1 = Image.load("harehare/vlcsnap-01887.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62304 and currentTime <= 62337 then
frame1 = Image.load("harehare/vlcsnap-01888.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62337 and currentTime <= 62370 then
frame1 = Image.load("harehare/vlcsnap-01889.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62370 and currentTime <= 62403 then
frame1 = Image.load("harehare/vlcsnap-01890.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62403 and currentTime <= 62436 then
frame1 = Image.load("harehare/vlcsnap-01891.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62436 and currentTime <= 62469 then
frame1 = Image.load("harehare/vlcsnap-01892.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62469 and currentTime <= 62502 then
frame1 = Image.load("harehare/vlcsnap-01893.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62502 and currentTime <= 62535 then
frame1 = Image.load("harehare/vlcsnap-01894.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62535 and currentTime <= 62568 then
frame1 = Image.load("harehare/vlcsnap-01895.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62568 and currentTime <= 62601 then
frame1 = Image.load("harehare/vlcsnap-01896.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62601 and currentTime <= 62634 then
frame1 = Image.load("harehare/vlcsnap-01897.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62634 and currentTime <= 62667 then
frame1 = Image.load("harehare/vlcsnap-01898.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62667 and currentTime <= 62700 then
frame1 = Image.load("harehare/vlcsnap-01899.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62700 and currentTime <= 62733 then
frame1 = Image.load("harehare/vlcsnap-01900.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62733 and currentTime <= 62766 then
frame1 = Image.load("harehare/vlcsnap-01901.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62766 and currentTime <= 62799 then
frame1 = Image.load("harehare/vlcsnap-01902.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62799 and currentTime <= 62832 then
frame1 = Image.load("harehare/vlcsnap-01903.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62832 and currentTime <= 62865 then
frame1 = Image.load("harehare/vlcsnap-01904.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62865 and currentTime <= 62898 then
frame1 = Image.load("harehare/vlcsnap-01905.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62898 and currentTime <= 62931 then
frame1 = Image.load("harehare/vlcsnap-01906.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62931 and currentTime <= 62964 then
frame1 = Image.load("harehare/vlcsnap-01907.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62964 and currentTime <= 62997 then
frame1 = Image.load("harehare/vlcsnap-01908.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 62997 and currentTime <= 63030 then
frame1 = Image.load("harehare/vlcsnap-01909.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63030 and currentTime <= 63063 then
frame1 = Image.load("harehare/vlcsnap-01910.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63063 and currentTime <= 63096 then
frame1 = Image.load("harehare/vlcsnap-01911.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63096 and currentTime <= 63129 then
frame1 = Image.load("harehare/vlcsnap-01912.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63129 and currentTime <= 63162 then
frame1 = Image.load("harehare/vlcsnap-01913.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63162 and currentTime <= 63195 then
frame1 = Image.load("harehare/vlcsnap-01914.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63195 and currentTime <= 63228 then
frame1 = Image.load("harehare/vlcsnap-01915.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63228 and currentTime <= 63261 then
frame1 = Image.load("harehare/vlcsnap-01916.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63261 and currentTime <= 63294 then
frame1 = Image.load("harehare/vlcsnap-01917.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63294 and currentTime <= 63327 then
frame1 = Image.load("harehare/vlcsnap-01918.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63327 and currentTime <= 63360 then
frame1 = Image.load("harehare/vlcsnap-01919.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63360 and currentTime <= 63393 then
frame1 = Image.load("harehare/vlcsnap-01920.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63393 and currentTime <= 63426 then
frame1 = Image.load("harehare/vlcsnap-01921.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63426 and currentTime <= 63459 then
frame1 = Image.load("harehare/vlcsnap-01922.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63459 and currentTime <= 63492 then
frame1 = Image.load("harehare/vlcsnap-01923.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63492 and currentTime <= 63525 then
frame1 = Image.load("harehare/vlcsnap-01924.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63525 and currentTime <= 63558 then
frame1 = Image.load("harehare/vlcsnap-01925.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63558 and currentTime <= 63591 then
frame1 = Image.load("harehare/vlcsnap-01926.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63591 and currentTime <= 63624 then
frame1 = Image.load("harehare/vlcsnap-01927.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63624 and currentTime <= 63657 then
frame1 = Image.load("harehare/vlcsnap-01928.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63657 and currentTime <= 63690 then
frame1 = Image.load("harehare/vlcsnap-01929.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63690 and currentTime <= 63723 then
frame1 = Image.load("harehare/vlcsnap-01930.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63723 and currentTime <= 63756 then
frame1 = Image.load("harehare/vlcsnap-01931.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63756 and currentTime <= 63789 then
frame1 = Image.load("harehare/vlcsnap-01932.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63789 and currentTime <= 63822 then
frame1 = Image.load("harehare/vlcsnap-01933.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63822 and currentTime <= 63855 then
frame1 = Image.load("harehare/vlcsnap-01934.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63855 and currentTime <= 63888 then
frame1 = Image.load("harehare/vlcsnap-01935.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63888 and currentTime <= 63921 then
frame1 = Image.load("harehare/vlcsnap-01936.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63921 and currentTime <= 63954 then
frame1 = Image.load("harehare/vlcsnap-01937.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63954 and currentTime <= 63987 then
frame1 = Image.load("harehare/vlcsnap-01938.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 63987 and currentTime <= 64020 then
frame1 = Image.load("harehare/vlcsnap-01939.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 64020 and currentTime <= 64053 then
frame1 = Image.load("harehare/vlcsnap-01940.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 64053 and currentTime <= 64086 then
frame1 = Image.load("harehare/vlcsnap-01941.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 64086 and currentTime <= 64119 then
frame1 = Image.load("harehare/vlcsnap-01942.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 64119 and currentTime <= 64152 then
frame1 = Image.load("harehare/vlcsnap-01943.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 64152 and currentTime <= 64185 then
frame1 = Image.load("harehare/vlcsnap-01944.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 64185 and currentTime <= 64218 then
frame1 = Image.load("harehare/vlcsnap-01945.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 64218 and currentTime <= 64251 then
frame1 = Image.load("harehare/vlcsnap-01946.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
end

if currentTime >= 64251 then
Ogg.stop(1)
Ogg.unload(1)
dofile("karaoke/mp4.LUA")
end



System.endDraw()
screen.flip()
screen.waitVblankStart()
oldpad = pad
end
