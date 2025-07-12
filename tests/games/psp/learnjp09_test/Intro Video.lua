--System.setCpuSpeed(222)
counter = Timer.new()

while true do
oldpad = pad
pad = Controls.read()
System.draw()
screen:clear()

currentTime = counter:time()

if currentTime >= 0 and currentTime <=33 then
frame1 = Image.load("TOD/vlcsnap-00001.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 33 and currentTime <= 66 then
frame1 = Image.load("TOD/vlcsnap-00001.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 66 and currentTime <= 99 then
frame1 = Image.load("TOD/vlcsnap-00002.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 99 and currentTime <= 132 then
frame1 = Image.load("TOD/vlcsnap-00003.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 132 and currentTime <= 165 then
frame1 = Image.load("TOD/vlcsnap-00004.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 165 and currentTime <= 198 then
frame1 = Image.load("TOD/vlcsnap-00005.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 198 and currentTime <= 231 then
frame1 = Image.load("TOD/vlcsnap-00006.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 231 and currentTime <= 264 then
frame1 = Image.load("TOD/vlcsnap-00007.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 264 and currentTime <= 297 then
frame1 = Image.load("TOD/vlcsnap-00008.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 297 and currentTime <= 330 then
frame1 = Image.load("TOD/vlcsnap-00009.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 330 and currentTime <= 363 then
frame1 = Image.load("TOD/vlcsnap-00010.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 363 and currentTime <= 396 then
frame1 = Image.load("TOD/vlcsnap-00011.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 396 and currentTime <= 429 then
frame1 = Image.load("TOD/vlcsnap-00012.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 429 and currentTime <= 462 then
frame1 = Image.load("TOD/vlcsnap-00013.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 462 and currentTime <= 495 then
frame1 = Image.load("TOD/vlcsnap-00014.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 495 and currentTime <= 528 then
frame1 = Image.load("TOD/vlcsnap-00015.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 528 and currentTime <= 561 then
frame1 = Image.load("TOD/vlcsnap-00016.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 561 and currentTime <= 594 then
frame1 = Image.load("TOD/vlcsnap-00017.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 594 and currentTime <= 627 then
frame1 = Image.load("TOD/vlcsnap-00018.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 627 and currentTime <= 660 then
frame1 = Image.load("TOD/vlcsnap-00019.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 660 and currentTime <= 693 then
frame1 = Image.load("TOD/vlcsnap-00020.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 693 and currentTime <= 726 then
frame1 = Image.load("TOD/vlcsnap-00021.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 726 and currentTime <= 759 then
frame1 = Image.load("TOD/vlcsnap-00022.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 759 and currentTime <= 792 then
frame1 = Image.load("TOD/vlcsnap-00023.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 792 and currentTime <= 825 then
frame1 = Image.load("TOD/vlcsnap-00024.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 825 and currentTime <= 858 then
frame1 = Image.load("TOD/vlcsnap-00025.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 858 and currentTime <= 891 then
frame1 = Image.load("TOD/vlcsnap-00026.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 891 and currentTime <= 924 then
frame1 = Image.load("TOD/vlcsnap-00027.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 924 and currentTime <= 957 then
frame1 = Image.load("TOD/vlcsnap-00028.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 957 and currentTime <= 990 then
frame1 = Image.load("TOD/vlcsnap-00029.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 990 and currentTime <= 1023 then
frame1 = Image.load("TOD/vlcsnap-00030.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1023 and currentTime <= 1056 then
frame1 = Image.load("TOD/vlcsnap-00031.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1056 and currentTime <= 1089 then
frame1 = Image.load("TOD/vlcsnap-00032.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1089 and currentTime <= 1122 then
frame1 = Image.load("TOD/vlcsnap-00033.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1122 and currentTime <= 1155 then
frame1 = Image.load("TOD/vlcsnap-00034.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1155 and currentTime <= 1188 then
frame1 = Image.load("TOD/vlcsnap-00035.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1188 and currentTime <= 1221 then
frame1 = Image.load("TOD/vlcsnap-00036.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1221 and currentTime <= 1254 then
frame1 = Image.load("TOD/vlcsnap-00037.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1254 and currentTime <= 1287 then
frame1 = Image.load("TOD/vlcsnap-00038.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1287 and currentTime <= 1320 then
frame1 = Image.load("TOD/vlcsnap-00039.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1320 and currentTime <= 1353 then
frame1 = Image.load("TOD/vlcsnap-00040.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1353 and currentTime <= 1386 then
frame1 = Image.load("TOD/vlcsnap-00041.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1386 and currentTime <= 1419 then
frame1 = Image.load("TOD/vlcsnap-00042.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1419 and currentTime <= 1452 then
frame1 = Image.load("TOD/vlcsnap-00043.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1452 and currentTime <= 1485 then
frame1 = Image.load("TOD/vlcsnap-00044.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1485 and currentTime <= 1518 then
frame1 = Image.load("TOD/vlcsnap-00045.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1518 and currentTime <= 1551 then
frame1 = Image.load("TOD/vlcsnap-00046.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1551 and currentTime <= 1584 then
frame1 = Image.load("TOD/vlcsnap-00047.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1584 and currentTime <= 1617 then
frame1 = Image.load("TOD/vlcsnap-00048.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1617 and currentTime <= 1650 then
frame1 = Image.load("TOD/vlcsnap-00049.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1650 and currentTime <= 1683 then
frame1 = Image.load("TOD/vlcsnap-00050.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1683 and currentTime <= 1716 then
frame1 = Image.load("TOD/vlcsnap-00051.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1716 and currentTime <= 1749 then
frame1 = Image.load("TOD/vlcsnap-00052.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1749 and currentTime <= 1782 then
frame1 = Image.load("TOD/vlcsnap-00053.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1782 and currentTime <= 1815 then
frame1 = Image.load("TOD/vlcsnap-00054.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1815 and currentTime <= 1848 then
frame1 = Image.load("TOD/vlcsnap-00055.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1848 and currentTime <= 1881 then
frame1 = Image.load("TOD/vlcsnap-00056.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1881 and currentTime <= 1914 then
frame1 = Image.load("TOD/vlcsnap-00057.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1914 and currentTime <= 1947 then
frame1 = Image.load("TOD/vlcsnap-00058.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1947 and currentTime <= 1980 then
frame1 = Image.load("TOD/vlcsnap-00059.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 1980 and currentTime <= 2013 then
frame1 = Image.load("TOD/vlcsnap-00060.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2013 and currentTime <= 2046 then
frame1 = Image.load("TOD/vlcsnap-00061.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2046 and currentTime <= 2079 then
frame1 = Image.load("TOD/vlcsnap-00062.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2079 and currentTime <= 2112 then
frame1 = Image.load("TOD/vlcsnap-00063.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2112 and currentTime <= 2145 then
frame1 = Image.load("TOD/vlcsnap-00064.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2145 and currentTime <= 2178 then
frame1 = Image.load("TOD/vlcsnap-00065.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2178 and currentTime <= 2211 then
frame1 = Image.load("TOD/vlcsnap-00066.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2211 and currentTime <= 2244 then
frame1 = Image.load("TOD/vlcsnap-00067.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2244 and currentTime <= 2277 then
frame1 = Image.load("TOD/vlcsnap-00068.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2277 and currentTime <= 2310 then
frame1 = Image.load("TOD/vlcsnap-00069.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2310 and currentTime <= 2343 then
frame1 = Image.load("TOD/vlcsnap-00070.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2343 and currentTime <= 2376 then
frame1 = Image.load("TOD/vlcsnap-00071.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2376 and currentTime <= 2409 then
frame1 = Image.load("TOD/vlcsnap-00072.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2409 and currentTime <= 2442 then
frame1 = Image.load("TOD/vlcsnap-00073.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2442 and currentTime <= 2475 then
frame1 = Image.load("TOD/vlcsnap-00074.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2475 and currentTime <= 2508 then
frame1 = Image.load("TOD/vlcsnap-00075.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2508 and currentTime <= 2541 then
frame1 = Image.load("TOD/vlcsnap-00076.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2541 and currentTime <= 2574 then
frame1 = Image.load("TOD/vlcsnap-00077.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2574 and currentTime <= 2607 then
frame1 = Image.load("TOD/vlcsnap-00078.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2607 and currentTime <= 2640 then
frame1 = Image.load("TOD/vlcsnap-00079.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2640 and currentTime <= 2673 then
frame1 = Image.load("TOD/vlcsnap-00080.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2673 and currentTime <= 2706 then
frame1 = Image.load("TOD/vlcsnap-00081.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2706 and currentTime <= 2739 then
frame1 = Image.load("TOD/vlcsnap-00082.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2739 and currentTime <= 2772 then
frame1 = Image.load("TOD/vlcsnap-00083.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2772 and currentTime <= 2805 then
frame1 = Image.load("TOD/vlcsnap-00084.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2805 and currentTime <= 2838 then
frame1 = Image.load("TOD/vlcsnap-00085.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2838 and currentTime <= 2871 then
frame1 = Image.load("TOD/vlcsnap-00086.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2871 and currentTime <= 2904 then
frame1 = Image.load("TOD/vlcsnap-00087.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2904 and currentTime <= 2937 then
frame1 = Image.load("TOD/vlcsnap-00088.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2937 and currentTime <= 2970 then
frame1 = Image.load("TOD/vlcsnap-00089.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 2970 and currentTime <= 3003 then
frame1 = Image.load("TOD/vlcsnap-00090.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3003 and currentTime <= 3036 then
frame1 = Image.load("TOD/vlcsnap-00091.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3036 and currentTime <= 3069 then
frame1 = Image.load("TOD/vlcsnap-00092.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3069 and currentTime <= 3102 then
frame1 = Image.load("TOD/vlcsnap-00093.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3102 and currentTime <= 3135 then
frame1 = Image.load("TOD/vlcsnap-00094.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3135 and currentTime <= 3168 then
frame1 = Image.load("TOD/vlcsnap-00095.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3168 and currentTime <= 3201 then
frame1 = Image.load("TOD/vlcsnap-00096.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3201 and currentTime <= 3234 then
frame1 = Image.load("TOD/vlcsnap-00097.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3234 and currentTime <= 3267 then
frame1 = Image.load("TOD/vlcsnap-00098.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3267 and currentTime <= 3300 then
frame1 = Image.load("TOD/vlcsnap-00099.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3300 and currentTime <= 3333 then
frame1 = Image.load("TOD/vlcsnap-00100.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3333 and currentTime <= 3366 then
frame1 = Image.load("TOD/vlcsnap-00101.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3366 and currentTime <= 3399 then
frame1 = Image.load("TOD/vlcsnap-00102.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3399 and currentTime <= 3432 then
frame1 = Image.load("TOD/vlcsnap-00103.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3432 and currentTime <= 3465 then
frame1 = Image.load("TOD/vlcsnap-00104.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3465 and currentTime <= 3498 then
frame1 = Image.load("TOD/vlcsnap-00105.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3498 and currentTime <= 3531 then
frame1 = Image.load("TOD/vlcsnap-00106.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3531 and currentTime <= 3564 then
frame1 = Image.load("TOD/vlcsnap-00107.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3564 and currentTime <= 3597 then
frame1 = Image.load("TOD/vlcsnap-00108.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3597 and currentTime <= 3630 then
frame1 = Image.load("TOD/vlcsnap-00109.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3630 and currentTime <= 3663 then
frame1 = Image.load("TOD/vlcsnap-00110.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3663 and currentTime <= 3696 then
frame1 = Image.load("TOD/vlcsnap-00111.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3696 and currentTime <= 3729 then
frame1 = Image.load("TOD/vlcsnap-00112.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3729 and currentTime <= 3762 then
frame1 = Image.load("TOD/vlcsnap-00113.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3762 and currentTime <= 3795 then
frame1 = Image.load("TOD/vlcsnap-00114.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3795 and currentTime <= 3828 then
frame1 = Image.load("TOD/vlcsnap-00115.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3828 and currentTime <= 3861 then
frame1 = Image.load("TOD/vlcsnap-00116.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3861 and currentTime <= 3894 then
frame1 = Image.load("TOD/vlcsnap-00117.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3894 and currentTime <= 3927 then
frame1 = Image.load("TOD/vlcsnap-00118.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3927 and currentTime <= 3960 then
frame1 = Image.load("TOD/vlcsnap-00119.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3960 and currentTime <= 3993 then
frame1 = Image.load("TOD/vlcsnap-00120.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 3993 and currentTime <= 4026 then
frame1 = Image.load("TOD/vlcsnap-00121.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4026 and currentTime <= 4059 then
frame1 = Image.load("TOD/vlcsnap-00122.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4059 and currentTime <= 4092 then
frame1 = Image.load("TOD/vlcsnap-00123.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4092 and currentTime <= 4125 then
frame1 = Image.load("TOD/vlcsnap-00124.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4125 and currentTime <= 4158 then
frame1 = Image.load("TOD/vlcsnap-00125.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4158 and currentTime <= 4191 then
frame1 = Image.load("TOD/vlcsnap-00126.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4191 and currentTime <= 4224 then
frame1 = Image.load("TOD/vlcsnap-00127.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4224 and currentTime <= 4257 then
frame1 = Image.load("TOD/vlcsnap-00128.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4257 and currentTime <= 4290 then
frame1 = Image.load("TOD/vlcsnap-00129.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4290 and currentTime <= 4323 then
frame1 = Image.load("TOD/vlcsnap-00130.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4323 and currentTime <= 4356 then
frame1 = Image.load("TOD/vlcsnap-00131.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4356 and currentTime <= 4389 then
frame1 = Image.load("TOD/vlcsnap-00132.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4389 and currentTime <= 4422 then
frame1 = Image.load("TOD/vlcsnap-00133.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4422 and currentTime <= 4455 then
frame1 = Image.load("TOD/vlcsnap-00134.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4455 and currentTime <= 4488 then
frame1 = Image.load("TOD/vlcsnap-00135.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4488 and currentTime <= 4521 then
frame1 = Image.load("TOD/vlcsnap-00136.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4521 and currentTime <= 4554 then
frame1 = Image.load("TOD/vlcsnap-00137.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4554 and currentTime <= 4587 then
frame1 = Image.load("TOD/vlcsnap-00138.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4587 and currentTime <= 4620 then
frame1 = Image.load("TOD/vlcsnap-00139.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4620 and currentTime <= 4653 then
frame1 = Image.load("TOD/vlcsnap-00140.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4653 and currentTime <= 4686 then
frame1 = Image.load("TOD/vlcsnap-00141.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4686 and currentTime <= 4719 then
frame1 = Image.load("TOD/vlcsnap-00142.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4719 and currentTime <= 4752 then
frame1 = Image.load("TOD/vlcsnap-00143.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4752 and currentTime <= 4785 then
frame1 = Image.load("TOD/vlcsnap-00144.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4785 and currentTime <= 4818 then
frame1 = Image.load("TOD/vlcsnap-00145.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4818 and currentTime <= 4851 then
frame1 = Image.load("TOD/vlcsnap-00146.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4851 and currentTime <= 4884 then
frame1 = Image.load("TOD/vlcsnap-00147.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4884 and currentTime <= 4917 then
frame1 = Image.load("TOD/vlcsnap-00148.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4917 and currentTime <= 4950 then
frame1 = Image.load("TOD/vlcsnap-00149.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4950 and currentTime <= 4983 then
frame1 = Image.load("TOD/vlcsnap-00150.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 4983 and currentTime <= 5016 then
frame1 = Image.load("TOD/vlcsnap-00151.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5016 and currentTime <= 5049 then
frame1 = Image.load("TOD/vlcsnap-00152.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5049 and currentTime <= 5082 then
frame1 = Image.load("TOD/vlcsnap-00153.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5082 and currentTime <= 5115 then
frame1 = Image.load("TOD/vlcsnap-00154.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5115 and currentTime <= 5148 then
frame1 = Image.load("TOD/vlcsnap-00155.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5148 and currentTime <= 5181 then
frame1 = Image.load("TOD/vlcsnap-00156.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5181 and currentTime <= 5214 then
frame1 = Image.load("TOD/vlcsnap-00157.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5214 and currentTime <= 5247 then
frame1 = Image.load("TOD/vlcsnap-00158.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5247 and currentTime <= 5280 then
frame1 = Image.load("TOD/vlcsnap-00159.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5280 and currentTime <= 5313 then
frame1 = Image.load("TOD/vlcsnap-00160.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5313 and currentTime <= 5346 then
frame1 = Image.load("TOD/vlcsnap-00161.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5346 and currentTime <= 5379 then
frame1 = Image.load("TOD/vlcsnap-00162.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5379 and currentTime <= 5412 then
frame1 = Image.load("TOD/vlcsnap-00163.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5412 and currentTime <= 5445 then
frame1 = Image.load("TOD/vlcsnap-00164.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5445 and currentTime <= 5478 then
frame1 = Image.load("TOD/vlcsnap-00165.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5478 and currentTime <= 5511 then
frame1 = Image.load("TOD/vlcsnap-00166.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5511 and currentTime <= 5544 then
frame1 = Image.load("TOD/vlcsnap-00167.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5544 and currentTime <= 5577 then
frame1 = Image.load("TOD/vlcsnap-00168.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5577 and currentTime <= 5610 then
frame1 = Image.load("TOD/vlcsnap-00169.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5610 and currentTime <= 5643 then
frame1 = Image.load("TOD/vlcsnap-00170.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5643 and currentTime <= 5676 then
frame1 = Image.load("TOD/vlcsnap-00171.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5676 and currentTime <= 5709 then
frame1 = Image.load("TOD/vlcsnap-00172.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5709 and currentTime <= 5742 then
frame1 = Image.load("TOD/vlcsnap-00173.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5742 and currentTime <= 5775 then
frame1 = Image.load("TOD/vlcsnap-00174.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5775 and currentTime <= 5808 then
frame1 = Image.load("TOD/vlcsnap-00175.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5808 and currentTime <= 5841 then
frame1 = Image.load("TOD/vlcsnap-00176.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5841 and currentTime <= 5874 then
frame1 = Image.load("TOD/vlcsnap-00177.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5874 and currentTime <= 5907 then
frame1 = Image.load("TOD/vlcsnap-00178.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5907 and currentTime <= 5940 then
frame1 = Image.load("TOD/vlcsnap-00179.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5940 and currentTime <= 5973 then
frame1 = Image.load("TOD/vlcsnap-00180.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 5973 and currentTime <= 6006 then
frame1 = Image.load("TOD/vlcsnap-00181.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6006 and currentTime <= 6039 then
frame1 = Image.load("TOD/vlcsnap-00182.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6039 and currentTime <= 6072 then
frame1 = Image.load("TOD/vlcsnap-00183.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6072 and currentTime <= 6105 then
frame1 = Image.load("TOD/vlcsnap-00184.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6105 and currentTime <= 6138 then
frame1 = Image.load("TOD/vlcsnap-00185.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6138 and currentTime <= 6171 then
frame1 = Image.load("TOD/vlcsnap-00186.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6171 and currentTime <= 6204 then
frame1 = Image.load("TOD/vlcsnap-00187.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6204 and currentTime <= 6237 then
frame1 = Image.load("TOD/vlcsnap-00188.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6237 and currentTime <= 6270 then
frame1 = Image.load("TOD/vlcsnap-00189.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6270 and currentTime <= 6303 then
frame1 = Image.load("TOD/vlcsnap-00190.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6303 and currentTime <= 6336 then
frame1 = Image.load("TOD/vlcsnap-00191.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6336 and currentTime <= 6369 then
frame1 = Image.load("TOD/vlcsnap-00192.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6369 and currentTime <= 6402 then
frame1 = Image.load("TOD/vlcsnap-00193.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6402 and currentTime <= 6435 then
frame1 = Image.load("TOD/vlcsnap-00194.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6435 and currentTime <= 6468 then
frame1 = Image.load("TOD/vlcsnap-00195.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6468 and currentTime <= 6501 then
frame1 = Image.load("TOD/vlcsnap-00196.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6501 and currentTime <= 6534 then
frame1 = Image.load("TOD/vlcsnap-00197.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6534 and currentTime <= 6567 then
frame1 = Image.load("TOD/vlcsnap-00198.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6567 and currentTime <= 6600 then
frame1 = Image.load("TOD/vlcsnap-00199.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6600 and currentTime <= 6633 then
frame1 = Image.load("TOD/vlcsnap-00200.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6633 and currentTime <= 6666 then
frame1 = Image.load("TOD/vlcsnap-00201.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6666 and currentTime <= 6699 then
frame1 = Image.load("TOD/vlcsnap-00202.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6699 and currentTime <= 6732 then
frame1 = Image.load("TOD/vlcsnap-00203.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6732 and currentTime <= 6765 then
frame1 = Image.load("TOD/vlcsnap-00204.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6765 and currentTime <= 6798 then
frame1 = Image.load("TOD/vlcsnap-00205.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6798 and currentTime <= 6831 then
frame1 = Image.load("TOD/vlcsnap-00206.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6831 and currentTime <= 6864 then
frame1 = Image.load("TOD/vlcsnap-00207.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6864 and currentTime <= 6897 then
frame1 = Image.load("TOD/vlcsnap-00208.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6897 and currentTime <= 6930 then
frame1 = Image.load("TOD/vlcsnap-00209.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6930 and currentTime <= 6963 then
frame1 = Image.load("TOD/vlcsnap-00210.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6963 and currentTime <= 6996 then
frame1 = Image.load("TOD/vlcsnap-00211.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 6996 and currentTime <= 7029 then
frame1 = Image.load("TOD/vlcsnap-00212.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7029 and currentTime <= 7062 then
frame1 = Image.load("TOD/vlcsnap-00213.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7062 and currentTime <= 7095 then
frame1 = Image.load("TOD/vlcsnap-00214.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7095 and currentTime <= 7128 then
frame1 = Image.load("TOD/vlcsnap-00215.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7128 and currentTime <= 7161 then
frame1 = Image.load("TOD/vlcsnap-00216.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7161 and currentTime <= 7194 then
frame1 = Image.load("TOD/vlcsnap-00217.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7194 and currentTime <= 7227 then
frame1 = Image.load("TOD/vlcsnap-00218.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7227 and currentTime <= 7260 then
frame1 = Image.load("TOD/vlcsnap-00219.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7260 and currentTime <= 7293 then
frame1 = Image.load("TOD/vlcsnap-00220.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7293 and currentTime <= 7326 then
frame1 = Image.load("TOD/vlcsnap-00221.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7326 and currentTime <= 7359 then
frame1 = Image.load("TOD/vlcsnap-00222.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7359 and currentTime <= 7392 then
frame1 = Image.load("TOD/vlcsnap-00223.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7392 and currentTime <= 7425 then
frame1 = Image.load("TOD/vlcsnap-00224.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7425 and currentTime <= 7458 then
frame1 = Image.load("TOD/vlcsnap-00225.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7458 and currentTime <= 7491 then
frame1 = Image.load("TOD/vlcsnap-00226.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7491 and currentTime <= 7524 then
frame1 = Image.load("TOD/vlcsnap-00227.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7524 and currentTime <= 7557 then
frame1 = Image.load("TOD/vlcsnap-00228.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7557 and currentTime <= 7590 then
frame1 = Image.load("TOD/vlcsnap-00229.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7590 and currentTime <= 7623 then
frame1 = Image.load("TOD/vlcsnap-00230.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7623 and currentTime <= 7656 then
frame1 = Image.load("TOD/vlcsnap-00231.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7656 and currentTime <= 7689 then
frame1 = Image.load("TOD/vlcsnap-00232.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7689 and currentTime <= 7722 then
frame1 = Image.load("TOD/vlcsnap-00233.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7722 and currentTime <= 7755 then
frame1 = Image.load("TOD/vlcsnap-00234.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7755 and currentTime <= 7788 then
frame1 = Image.load("TOD/vlcsnap-00235.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7788 and currentTime <= 7821 then
frame1 = Image.load("TOD/vlcsnap-00236.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7821 and currentTime <= 7854 then
frame1 = Image.load("TOD/vlcsnap-00237.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7854 and currentTime <= 7887 then
frame1 = Image.load("TOD/vlcsnap-00238.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7887 and currentTime <= 7920 then
frame1 = Image.load("TOD/vlcsnap-00239.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7920 and currentTime <= 7953 then
frame1 = Image.load("TOD/vlcsnap-00240.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7953 and currentTime <= 7986 then
frame1 = Image.load("TOD/vlcsnap-00241.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 7986 and currentTime <= 8019 then
frame1 = Image.load("TOD/vlcsnap-00242.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8019 and currentTime <= 8052 then
frame1 = Image.load("TOD/vlcsnap-00243.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8052 and currentTime <= 8085 then
frame1 = Image.load("TOD/vlcsnap-00244.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8085 and currentTime <= 8118 then
frame1 = Image.load("TOD/vlcsnap-00245.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8118 and currentTime <= 8151 then
frame1 = Image.load("TOD/vlcsnap-00246.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8151 and currentTime <= 8184 then
frame1 = Image.load("TOD/vlcsnap-00247.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8184 and currentTime <= 8217 then
frame1 = Image.load("TOD/vlcsnap-00248.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8217 and currentTime <= 8250 then
frame1 = Image.load("TOD/vlcsnap-00249.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8250 and currentTime <= 8283 then
frame1 = Image.load("TOD/vlcsnap-00250.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8283 and currentTime <= 8316 then
frame1 = Image.load("TOD/vlcsnap-00251.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8316 and currentTime <= 8349 then
frame1 = Image.load("TOD/vlcsnap-00252.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8349 and currentTime <= 8382 then
frame1 = Image.load("TOD/vlcsnap-00253.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8382 and currentTime <= 8415 then
frame1 = Image.load("TOD/vlcsnap-00254.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8415 and currentTime <= 8448 then
frame1 = Image.load("TOD/vlcsnap-00255.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8448 and currentTime <= 8481 then
frame1 = Image.load("TOD/vlcsnap-00256.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8481 and currentTime <= 8514 then
frame1 = Image.load("TOD/vlcsnap-00257.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8514 and currentTime <= 8547 then
frame1 = Image.load("TOD/vlcsnap-00258.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8547 and currentTime <= 8580 then
frame1 = Image.load("TOD/vlcsnap-00259.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8580 and currentTime <= 8613 then
frame1 = Image.load("TOD/vlcsnap-00260.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8613 and currentTime <= 8646 then
frame1 = Image.load("TOD/vlcsnap-00261.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8646 and currentTime <= 8679 then
frame1 = Image.load("TOD/vlcsnap-00262.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8679 and currentTime <= 8712 then
frame1 = Image.load("TOD/vlcsnap-00263.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8712 and currentTime <= 8745 then
frame1 = Image.load("TOD/vlcsnap-00264.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8745 and currentTime <= 8778 then
frame1 = Image.load("TOD/vlcsnap-00265.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8778 and currentTime <= 8811 then
frame1 = Image.load("TOD/vlcsnap-00266.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8811 and currentTime <= 8844 then
frame1 = Image.load("TOD/vlcsnap-00267.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8844 and currentTime <= 8877 then
frame1 = Image.load("TOD/vlcsnap-00268.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8877 and currentTime <= 8910 then
frame1 = Image.load("TOD/vlcsnap-00269.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8910 and currentTime <= 8943 then
frame1 = Image.load("TOD/vlcsnap-00270.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8943 and currentTime <= 8976 then
frame1 = Image.load("TOD/vlcsnap-00271.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 8976 and currentTime <= 9009 then
frame1 = Image.load("TOD/vlcsnap-00272.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9009 and currentTime <= 9042 then
frame1 = Image.load("TOD/vlcsnap-00273.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9042 and currentTime <= 9075 then
frame1 = Image.load("TOD/vlcsnap-00274.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9075 and currentTime <= 9108 then
frame1 = Image.load("TOD/vlcsnap-00275.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9108 and currentTime <= 9141 then
frame1 = Image.load("TOD/vlcsnap-00276.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9141 and currentTime <= 9174 then
frame1 = Image.load("TOD/vlcsnap-00277.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9174 and currentTime <= 9207 then
frame1 = Image.load("TOD/vlcsnap-00278.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9207 and currentTime <= 9240 then
frame1 = Image.load("TOD/vlcsnap-00279.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9240 and currentTime <= 9273 then
frame1 = Image.load("TOD/vlcsnap-00280.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9273 and currentTime <= 9306 then
frame1 = Image.load("TOD/vlcsnap-00281.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9306 and currentTime <= 9339 then
frame1 = Image.load("TOD/vlcsnap-00282.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9339 and currentTime <= 9372 then
frame1 = Image.load("TOD/vlcsnap-00283.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9372 and currentTime <= 9405 then
frame1 = Image.load("TOD/vlcsnap-00284.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9405 and currentTime <= 9438 then
frame1 = Image.load("TOD/vlcsnap-00285.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9438 and currentTime <= 9471 then
frame1 = Image.load("TOD/vlcsnap-00286.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9471 and currentTime <= 9504 then
frame1 = Image.load("TOD/vlcsnap-00287.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9504 and currentTime <= 9537 then
frame1 = Image.load("TOD/vlcsnap-00288.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9537 and currentTime <= 9570 then
frame1 = Image.load("TOD/vlcsnap-00289.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9570 and currentTime <= 9603 then
frame1 = Image.load("TOD/vlcsnap-00290.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9603 and currentTime <= 9636 then
frame1 = Image.load("TOD/vlcsnap-00291.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9636 and currentTime <= 9669 then
frame1 = Image.load("TOD/vlcsnap-00292.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9669 and currentTime <= 9702 then
frame1 = Image.load("TOD/vlcsnap-00293.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9702 and currentTime <= 9735 then
frame1 = Image.load("TOD/vlcsnap-00294.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9735 and currentTime <= 9768 then
frame1 = Image.load("TOD/vlcsnap-00295.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9768 and currentTime <= 9801 then
frame1 = Image.load("TOD/vlcsnap-00296.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9801 and currentTime <= 9834 then
frame1 = Image.load("TOD/vlcsnap-00297.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9834 and currentTime <= 9867 then
frame1 = Image.load("TOD/vlcsnap-00298.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9867 and currentTime <= 9900 then
frame1 = Image.load("TOD/vlcsnap-00299.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9900 and currentTime <= 9933 then
frame1 = Image.load("TOD/vlcsnap-00300.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9933 and currentTime <= 9966 then
frame1 = Image.load("TOD/vlcsnap-00301.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9966 and currentTime <= 9999 then
frame1 = Image.load("TOD/vlcsnap-00302.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 9999 and currentTime <= 10032 then
frame1 = Image.load("TOD/vlcsnap-00303.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10032 and currentTime <= 10065 then
frame1 = Image.load("TOD/vlcsnap-00304.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10065 and currentTime <= 10098 then
frame1 = Image.load("TOD/vlcsnap-00305.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10098 and currentTime <= 10131 then
frame1 = Image.load("TOD/vlcsnap-00306.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10131 and currentTime <= 10164 then
frame1 = Image.load("TOD/vlcsnap-00307.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10164 and currentTime <= 10197 then
frame1 = Image.load("TOD/vlcsnap-00308.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10197 and currentTime <= 10230 then
frame1 = Image.load("TOD/vlcsnap-00309.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10230 and currentTime <= 10263 then
frame1 = Image.load("TOD/vlcsnap-00310.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10263 and currentTime <= 10296 then
frame1 = Image.load("TOD/vlcsnap-00311.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10296 and currentTime <= 10329 then
frame1 = Image.load("TOD/vlcsnap-00312.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10329 and currentTime <= 10362 then
frame1 = Image.load("TOD/vlcsnap-00313.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10362 and currentTime <= 10395 then
frame1 = Image.load("TOD/vlcsnap-00314.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10395 and currentTime <= 10428 then
frame1 = Image.load("TOD/vlcsnap-00315.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10428 and currentTime <= 10461 then
frame1 = Image.load("TOD/vlcsnap-00316.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10461 and currentTime <= 10494 then
frame1 = Image.load("TOD/vlcsnap-00317.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10494 and currentTime <= 10527 then
frame1 = Image.load("TOD/vlcsnap-00318.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10527 and currentTime <= 10560 then
frame1 = Image.load("TOD/vlcsnap-00319.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10560 and currentTime <= 10593 then
frame1 = Image.load("TOD/vlcsnap-00320.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10593 and currentTime <= 10626 then
frame1 = Image.load("TOD/vlcsnap-00321.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10626 and currentTime <= 10659 then
frame1 = Image.load("TOD/vlcsnap-00322.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10659 and currentTime <= 10692 then
frame1 = Image.load("TOD/vlcsnap-00323.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10692 and currentTime <= 10725 then
frame1 = Image.load("TOD/vlcsnap-00324.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10725 and currentTime <= 10758 then
frame1 = Image.load("TOD/vlcsnap-00325.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10758 and currentTime <= 10791 then
frame1 = Image.load("TOD/vlcsnap-00326.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10791 and currentTime <= 10824 then
frame1 = Image.load("TOD/vlcsnap-00327.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10824 and currentTime <= 10857 then
frame1 = Image.load("TOD/vlcsnap-00328.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10857 and currentTime <= 10890 then
frame1 = Image.load("TOD/vlcsnap-00329.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10890 and currentTime <= 10923 then
frame1 = Image.load("TOD/vlcsnap-00330.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10923 and currentTime <= 10956 then
frame1 = Image.load("TOD/vlcsnap-00331.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10956 and currentTime <= 10989 then
frame1 = Image.load("TOD/vlcsnap-00332.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 10989 and currentTime <= 11022 then
frame1 = Image.load("TOD/vlcsnap-00333.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11022 and currentTime <= 11055 then
frame1 = Image.load("TOD/vlcsnap-00334.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11055 and currentTime <= 11088 then
frame1 = Image.load("TOD/vlcsnap-00335.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11088 and currentTime <= 11121 then
frame1 = Image.load("TOD/vlcsnap-00336.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11121 and currentTime <= 11154 then
frame1 = Image.load("TOD/vlcsnap-00337.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11154 and currentTime <= 11187 then
frame1 = Image.load("TOD/vlcsnap-00338.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11187 and currentTime <= 11220 then
frame1 = Image.load("TOD/vlcsnap-00339.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11220 and currentTime <= 11253 then
frame1 = Image.load("TOD/vlcsnap-00340.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11253 and currentTime <= 11286 then
frame1 = Image.load("TOD/vlcsnap-00341.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11286 and currentTime <= 11319 then
frame1 = Image.load("TOD/vlcsnap-00342.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11319 and currentTime <= 11352 then
frame1 = Image.load("TOD/vlcsnap-00343.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11352 and currentTime <= 11385 then
frame1 = Image.load("TOD/vlcsnap-00344.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
elseif currentTime >= 11385 and currentTime <= 11418 then
frame1 = Image.load("TOD/vlcsnap-00345.png")
screen:blit(0, 0, frame1, 0, 0, 0, 480, 272)
frame1:free()
end

--00000-00345  29.97fps
--347 Yes -30fps

if currentTime >= 11418 then
dofile("Intro.lua")
end




System.endDraw()
screen.flip()
screen.waitVblankStart()
oldpad = pad
end