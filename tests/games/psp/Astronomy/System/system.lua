-- v 4.3
-- Menu editing
-- Author: Harpet
-- screen 480 x 272

white = Color.new(255,255,255)
blue = Color.new(0,0,255)
black = Color.new(0,0,0) 
green = Color.new(0, 255, 0)
red = Color.new(255, 0, 0)
red2 = Color.new(155, 0, 0)
yellow = Color.new(255, 255, 0)
yellow2 = Color.new(155, 155, 0)
grey = Color.new(52,52,52)
grey2 = Color.new(152,152,152)

pi=180/3.14159265			-- convert from rad/dec 
kop=1 					-- start header menu
regel=1					-- start of row menu
telkop=5				-- number of menu headers
Date = os.date ("!*t") 			-- get current date
maxtel=0
x=0


centerx2 = -180
centery2 = 180
diepte2 = 1
step = 10

star   = {}
bounds = {}
lines  = {}
cname  = {}
messier = {}
planetra = {}
planetde = {}
planetna = {}

dofile("data/star.lua")
dofile("data/lines.lua")
dofile("data/cname.lua")

					
file = io.open("data/latlon.txt","r")	-- read the latitude longitude from file
	nb = file:read("*l")
	ol = file:read("*l")
file:close() 


mercx = {}				-- main table variables for 3d calculation
mercy = {}
mercz = {}
venux = {}
venuy = {}
venuz = {}
eartx = {}
earty = {}
eartz = {}
marsx = {}
marsy = {}
marsz = {}
jdvar = {}

for x  =1,365 do

	table.insert(mercx,1)
	table.insert(mercy,1)
	table.insert(mercz,1)

	table.insert(venux,1)
	table.insert(venuy,1)
	table.insert(venuz,1)
	
	table.insert(eartx,1)
	table.insert(earty,1)
	table.insert(eartz,1)

	table.insert(marsx,1)
	table.insert(marsy,1)
	table.insert(marsz,1)

	table.insert(jdvar,1)

end

planetra = {}
planetde = {}
planetna = {}

file = io.open("data/planets.txt","r")	
	maxplan= file:read("*l") * 1
file:close() 

for x = 1,maxplan do
	table.insert(planetra,1)
	table.insert(planetde,1)
	table.insert(planetna,1)
end

-- menu variables
startmenu = 0
Menu = { }
Menu[1] = { aantal = 5, a = "System", b = "Info", c = "Position", d = "Date+Time", e = "Events", f = "Exit"}
Menu[2] = { aantal = 4, a = "Date/Time", b = "CD -> JD", c = "ET -> UT", d = "UT -> STG", e = "Easterday"}
Menu[3] = { aantal = 12, a = "Objects", b = "Sun",  c = "Moon", d = "Mercury", e = "Venus", f = "Mars", g = "Jupiter", h = "Saturn", i = "Uranus", j = "Neptune", k = "Pluto", l = "Minor Planets", m = "Comets"}
Menu[4] = { aantal = 7, a = "Events", b = "Peri/Aphelion", c = "Eclipses", d = "Sun Eclips", e = "Phases Moon", f = "Jupiter moons", g = "Saturn moons", h = "Equinox" }
Menu[5] = { aantal = 4, a = "Graphics", b = "Star Chart", c = "Pos Planets", d = "Planets Move", e = "3d graphics"}
selector = { image = Image.createEmpty(80,8), x = 0,y = 0 }
selector.image:clear(blue)

-- general functions


function menu()
	screen:clear()
	screen:blit(0,70, back2)
	screen:print(100,225,"Please set the correct Position and",red)
	screen:print(100,235,"   Date+Time before calculation",red)

	screen:blit(kop*80-70,regel*8,selector.image)	
	for a=1,telkop do        
        	screen:blit(a*80-70,0,selector.image) 
		screen:print(a*80-70,0,Menu[a].a,white)
        	if a==kop then
			if Menu[a].aantal > 0 then
	     			screen:print(a*80-70,8,Menu[a].b,yellow)	
	  		end
			if Menu[a].aantal >1  then
	     			screen:print(a*80-70,16,Menu[a].c,yellow)	
	  		end
			if Menu[a].aantal >2  then
	     			screen:print(a*80-70,24,Menu[a].d,yellow)	
			end
			if Menu[a].aantal >3  then
	     			screen:print(a*80-70,32,Menu[a].e,yellow)	
			end
			if Menu[a].aantal >4  then
	     			screen:print(a*80-70,40,Menu[a].f,yellow)	
			end
			if Menu[a].aantal >5  then
	     			screen:print(a*80-70,48,Menu[a].g,yellow)	
			end
			if Menu[a].aantal >6  then
	     			screen:print(a*80-70,56,Menu[a].h,yellow)	
			end
			if Menu[a].aantal >7  then
	     			screen:print(a*80-70,64,Menu[a].i,yellow)	
			end
			if Menu[a].aantal >8  then
	     			screen:print(a*80-70,72,Menu[a].j,yellow)	
			end
			if Menu[a].aantal >9  then
	     			screen:print(a*80-70,80,Menu[a].k,yellow)	
			end
			if Menu[a].aantal >10  then
	     			screen:print(a*80-70,88,Menu[a].l,yellow)	
			end		
			if Menu[a].aantal >11  then
	     			screen:print(a*80-70,96,Menu[a].m,yellow)	
			end		
					
		end
	end	
end

function drawcircle(target, ux, uy, crad, ccolor)
	degree = 0
	while degree < (6.4) do
		target:pixel((math.floor(crad * math.cos(degree)))+ux, (math.floor(crad * math.sin(degree))) +uy, ccolor)
		degree = degree + 0.005
	end
end 

function poscircle()
	ra = ra - math.floor(ra / 360) * 360
	if ra < 90 then x = (ra / 90) * str end
	if ra >= 90 and ra < 180 then x = ((180 - ra) / 90 ) * str end
	if ra >= 180 and ra < 270 then x = -((ra - 180) / 90) * str end
	if ra >= 270 then x = -((360 - ra) / 90) * str end
	y = math.sqrt(str^2 - x^2)
	if ra > 90 and ra < 270 then y = -y end
	x = math.floor(x)
	drawcircle(screen,-x + 240,- y + 135, 4, white)
	screen:print(-x + 240 + 10,-y + 135,pl,white)
end

function poscircle2()
	ra = ra - math.floor(ra / 360) * 360
	if ra < 90 then x = (ra / 90) * str end
	if ra >= 90 and ra < 180 then x = ((180 - ra) / 90 ) * str end
	if ra >= 180 and ra < 270 then x = -((ra - 180) / 90) * str end
	if ra >= 270 then x = -((360 - ra) / 90) * str end
	y = math.sqrt(str^2 - x^2)
	if ra > 90 and ra < 270 then y = -y end
	x = math.floor(x)
	drawcircle(screen,-x + 240,- y + 135, 2, white)
	screen:print(-x + 240 + 10,-y + 135,pl,white)
end


function calcjd()	
	dd=da + hh/24 + mi / (24 * 60)
	if mm < 3 then yy=yy-1 mm=mm+12 end
	a=math.floor(yy / 100)
	b= 2 - a + math.floor(a / 4)
	if (yy + mm / 100 + dd / 10000) < 1582.1015 then b=0 end
	if yy > 0 then jd=math.floor(365.25 * yy)       + math.floor(30.6001 * (mm+1)) + dd + 1720994.5 + b end
	if yy < 0 then jd=math.floor(365.25 * yy - .75) + math.floor(30.6001 * (mm+1)) + dd + 1720994.5 + b end
end

function calccd()
	jd = jd + .5
	z = math.floor(jd)
	f = jd - math.floor(jd)
	al = math.floor(( z - 1867216.25) / 36524.25)
	a = z + 1 + al - math.floor(al / 4)
	if z < 2299161 then a = z end
	b = a + 1524
	c = math.floor((b - 122.1) / 365.25)
	d = math.floor(365.25 * c)
	e = math.floor((b - d) / 30.6001)
	dd = b - d - math.floor(30.6001 * e) + f
	mm = e - 1
	if e > 13.5 then mm = e - 13 end
	yy = c - 4716
	if mm < 2.5 then yy = c - 4715 end
	hh = (dd - math.floor(dd)) * 24
	mi = (hh - math.floor(hh)) * 60
	jd = jd - .5
	cd = string.format("%04d-%02d-%02d %02d:%02d",yy,mm,dd,hh,mi)
end

function calcet()
	yy=Date.year
        if yy < 1985 then 
		tt = (yy - 1975)
		dt = 45.45 + 1.067 * tt - (tt^2 / 260) - (tt^3 / 718)
 		dt = dt / 60
	end
	if yy < 2005 and yy > 1984 then
		tt = (yy-2000)
                dt = 63.86 + .3345 * tt -.060374 * tt^2 + .0017275 * t^3 + .000651814 * t^4 + .00002373599 * tt^5
                dt = dt / 60
        end 
        if yy > 2004 and yy < 2050 then
        	tt = (yy - 2000)
		dt = 62.92 + .32217 * tt + .005589 * tt^2
        	dt = dt / 60
	end
        if yy > 2049 then	
		dt = -20 + 32 * ((yy - 1820) / 100) ^ 2 - .5628*(2150 - yy)
		dt = dt / 60
	end
end

function calcstg()
	t=(jd - 2415020) / 36525		
	hhh = .276919398 + 100.0021359 * t + .000001075 * t^2
	hhh = hhh + hh / 24 + mi / 1440
	hhh = (hhh - math.floor(hhh)) * 24
	hhh = hhh - math.floor(ol/15)
	if hhh > 24 then hhh = hhh - 24 end
	if hhh < 0 then  hhh = hhh + 24 end
	td = hhh 
	mi = (hhh - math.floor(hhh)) * 60
	se = (mi - math.floor(mi)) * 60
end

function calceaster()
	yy = Date.year
	a = math.mod(yy,19)	
	b = math.floor(yy / 100)
	c = math.mod(yy,100)
	d = math.floor(b / 4) 
	e = math.mod(b,4)
	f = math.floor((b + 8) / 25)
	g = math.floor((b - f + 1) /3)
	h = math.mod((19 * a + b - d - g + 15),30)
	i = math.floor(c / 4)
	k = math.mod(c,4)
	l = math.mod((32 + 2 * e + 2 * i - h - k),7)
	m = math.floor((a + 11 * h + 22 * l) / 451)
	n = math.floor((h + l - 7 * m + 114) / 31)
	p = math.mod((h + l - 7 * m + 114),31)	
	
end

function calcsun()
	t = (jd - 2415020) / 36525
	l = 279.69668 + 36000.76892 * t + .0003025 * t^2
	l = l - (math.floor(l/360)*360)
	m = 358.47583 + 35999.04975 * t - .00015 * t^2 - .0000033 * t^3
	m = m - (math.floor(m/360)*360)
	e = .01675104 - .0000418 * t - .000000126 * t^2
	c = (1.91946 - .004789 * t - .000014 * t^2) * math.sin(m/pi)
	c = c + (.020094 - .0001 *t) * math.sin((2*m) / pi)
	c = c + .000293 * math.sin((3*m) /pi)
	stl = l + c
	v = m + c
	stl = stl - .00569 -.00479 * math.sin((259.18- 1934.142 * t)/pi)
	r = (1.0000002 * (1 - e^2))/ (1 + e * math.cos( v / pi))
	et = 23.452294 - .0130125 * t - .00000164*t^2 + .000000503 * t^3

	ra = (math.cos(et/pi) * math.sin(stl/pi)) / math.cos(stl/pi)
	r1 = math.atan(ra) * pi
	ra = (math.cos(et/pi) * math.sin(stl/pi)) / math.cos(stl/pi)
	r1 = math.atan(ra) * pi
	li = ra
	ra = (math.floor((stl - r1) /90) *90 + r1) /15
	if r1 < 0 then ra = ((math.floor((stl - r1) / 90) + 1) *90 + r1) / 15 end
	de = math.sin(et/pi) * math.sin(stl / pi)
	de = math.atan(de / math.sqrt(-de * de + 1)) * pi
end

function calcrade()
	if ra > 24 then ra = ra - 24 end
	if ra < 0 then ra = ra +24 end
	hr1 = math.floor(ra) 
	mi1 = (ra - math.floor(ra)) * 60
	se1 = math.floor((mi1 - math.floor(mi1)) * 60)
	mi1 = math.floor(mi1)
	hr2 = math.floor(de)
	mi2 = (de - math.floor(de)) * 60
	se2 = math.floor((mi2 - math.floor(mi2)) * 60)
	mi2 = math.floor(mi2)
	if hr2 < 0 then
		hr2 = hr2 + 1
		mi2 = math.abs((de - math.floor(de) - 1) *60)
		se2 = math.floor((mi2 - math.floor(mi2)) * 60)
		mi2 = math.floor(mi2)
	end
end

function polar()
	while a1 < 0 and a2 < 0 and lo < 180 do lo = lo + 90 end
	while a1 > 0 and a2 > 0 and lo < 0 do lo = lo + 90 end
	while a1 > 0 and a2 < 0 and lo < 90 do lo = lo + 90 end
	while a1 < 0 and a2 > 0 and lo < 270 do lo = lo + 90 end
end


function calcmoon()
	t = (jd - 2415020) / 36525
	l = 270.434164 + 481267.8831 * t - .001133 * t^2 + .0000019 * t^3
	m = 358.475833 + 35999.0498 * t - .00015 * t^2 - .0000033 * t^3
	ma = 296.104608 + 477198.8491 * t + .009192 * t^2 + .0000144* t^3
	d = 350.737486 + 445267.1142 * t - .001436 * t^2 + .0000019 * t^3
	f = 11.250889 + 483202.0251 * t - .003211 * t^2 - .0000003 * t^3
	an = 259.183275 - 1934.142 * t + .002078 * t^2 + .0000022 * t^3
	h = .003964 * math.sin((346.56 + 132.87 * t - .0091731 *t^2) / pi)
	l = l + .000233 * math.sin((51.2 + 20.2 * t) / pi) + h + .001964 * math.sin(an / pi)
	l = l - math.floor(l / 360) * 360
	m = m - .001778 * math.sin((51.2 + 20.2 * t) / pi)
	m = m - math.floor(m / 360) * 360
	ma = ma + .000817 * math.sin((51.2 + 20.2 * t) / pi) + h + .002541 * math.sin(an / pi)
	ma = ma - math.floor(ma / 360) * 360
	d = d + .002011 * math.sin((51.2 + 20.2 * t) / pi) + h + .001964 * math.sin(an / pi)
	d = d - math.floor(d / 360) * 360	
	f = f + h - .024691 * math.sin(an / pi) - .004328 * math.sin((an + 275.05 - 2.3 * t) / pi)
	f = f - math.floor(f / 360) * 360
	e = 1 - .002495 * t - .00000752 * t^2

	la = l + 6.28875 * math.sin(ma / pi) + 1.274018 * math.sin((2 * d - ma) / pi)
	la = la + .658309 * math.sin((2 * d) / pi) + .213616 * math.sin((2 * ma) / pi) + e * -.185596 * math.sin(m/pi)
	la = la - .114336 * math.sin((2 * f) / pi) + .058793 * math.sin((2 * d - 2 * ma) / pi)
	la = la + e * .057212 * math.sin((2 * d - m - ma) / pi) + .05332 * math.sin((2 * d + ma) / pi)	
	la = la + e * .045874 * math.sin((2 * d - m) / pi)
	la = la + e * .041024 * math.sin((ma - m) / pi) - .034718 * math.sin(d / pi)
	la = la + e * -.030465 * math.sin((m + ma) / pi) + .015326 * math.sin((2 * d - 2 * f) / pi)
	la = la - .012528 * math.sin((2 * f + ma) / pi) - .010980 * math.sin((2 * f - ma) / pi)
	la = la + .010674 * math.sin((4 * d - ma) / pi) + .010034 * math.sin((3 * ma) / pi)
	la = la + .008548 * math.sin((4 * d - 2 * ma) / pi) + e * -.00791 * math.sin((m - ma + 2 * d) / pi)	
	la = la + e * -.006783 * math.sin((2 * d + m) / pi) + .005162 * math.sin((ma - d) / pi)
	la = la + e * .005 * math.sin((m + d) / pi) + e * .004049 * math.sin((ma - m + 2 * d) / pi)
	la = la + .003996 * math.sin((2 * ma + 2 * d) / pi) + .003862 * math.sin((4 * d) / pi)
	la = la + .003665 * math.sin((2 * d - 3 * ma) / pi) + e * .002695 * math.sin((2 * ma - m) / pi)
	la = la + .002602 * math.sin((ma - 2 * f - 2 * d) / pi) + e * .002396 * math.sin((2 * d - m - 2 * ma) / pi)
	la = la - .002349 * math.sin((ma + d) / pi) + e^2 * .002249 * math.sin((2 * d - 2 * m) / pi	)
	la = la + e * -.002125 * math.sin((2 * ma + m) / pi) + e ^2 * -.002079 * math.sin((2 * m) / pi)
	la = la + e^2 * .002059 * math.sin((2 * d - ma - 2 * m) / pi) - .001773 * math.sin((ma + 2 * d - 2 * f) / pi)	
	la = la - .001595 * math.sin((2 * f + 2 * d) / pi) + e * .00122 * math.sin((4 * d - m - ma) / pi)
	la = la - .00111 * math.sin((2 * ma + 2 * f) / pi) + .000892 * math.sin((ma - 3 * d) / pi)
	la = la + e * -.000811 * math.sin((m + ma + 2 * d) / pi) + e * .000761 * math.sin((4 * d - m - 2 * ma) / pi)
	la = la + e^2 * .000717 * math.sin((ma - 2 * m) / pi) + e ^2 * .000704 * math.sin((ma - 2 * m - 2 * d) / pi)
	la = la + .000693 * math.sin((m - 2 * ma + 2 * d) / pi) + e * .00598 * math.sin((2 * d - m - 2 * f) / pi)
	la = la + .00055  * math.sin((ma + 4 * d) / pi) + .000538 * math.sin((4 * ma) / pi)
	la = la + e * .000521 * math.sin((4 * d - m) / pi) + .000486 * math.sin((2 * ma - d) / pi)	

	b = 5.128189 * math.sin(f / pi) + .280606 * math.sin((ma + f) / pi)
	b = b + .277693 * math.sin((ma - f) / pi) + .173238 * math.sin((2 * d - f) / pi)
	b = b + .055413 * math.sin((2 * d + f - ma) / pi) + .046272 * math.sin((2 * d - f - ma) / pi)
	b = b + .032573 * math.sin((2 * d + f) / pi) + .017198 * math.sin((2 * ma + f) / pi)
	b = b + .009267 * math.sin((2 * d + ma - f) / pi) + .008823 * math.sin((2 * ma - f) / pi)
	b = b + e * .008247 * math.sin((2 * d - m - f) / pi) + .004323 * math.sin((2 * d - f - 2 * ma) / pi)
	b = b + .0042 * math.sin((2 * d + f + ma) / pi) + e * .003372 * math.sin((f - m - 2 * d) / pi)
	b = b + e * .002472 * math.sin((2 * d + f - m - ma) / pi) + e * .002222 * math.sin((2 * d + f - m) / pi)
	b = b + e * .002072 * math.sin((2 * d - f - m - ma) / pi) + e * .001877 * math.sin((f - m + ma) / pi)
	b = b + .001828 * math.sin((4 * d - f - ma) / pi) + e * .001803 * math.sin((f + m) / pi)
	b = b - .00175 * math.sin((3 * f) / pi) + e * .00157 * math.sin((ma - m - f) / pi)
	b = b - .001487 * math.sin((f + f) / pi) + e * -.001481 * math.sin((f + m + ma) / pi)
	b = b + e * .001417 * math.sin((f - m - ma) / pi) + e * .00135 * math.sin((f - m) / pi)
	b = b + .00133 * math.sin((f - d) / pi) + .001106 * math.sin((f + 3 * ma) / pi)
	b = b + .00102 * math.sin((e * d - f) / pi) + .000833 * math.sin((f + 4 * d - ma) / pi)
	b = b + .000781 * math.sin((ma - 3 * f) / pi) + .00067 * math.sin((f + 4 * d - 2 * ma) / pi)
	b = b + .000606 * math.sin((2 * d - 3 * f) / pi) + .000597 * math.sin((2 * d + 2 * ma - f) / pi)
	b = b + e * .000492 * math.sin((2 * d + ma - m - f) / pi) + .00045 * math.sin((2 * ma - f - 2 * d) / pi)
	b = b + .000439 * math.sin((3 * ma - f) / pi) + .000423 * math.sin((f + 2 * d + 2 * ma) / pi)
	b = b + .000422 * math.sin((2 * d - f - 3 * ma) / pi) + e * -.000367 * math.sin((m + f + 2 * d - ma) / pi)
	b = b + e * -.000353 * math.sin((m + f + 2 * d) / pi) + .000331 * math.sin((f + 4 * d) / pi)
	b = b + e * .000317 * math.sin((2 * d + f - m + ma) / pi) + e^2 * .000306 * math.sin((2 * d - 2 * m - f) / pi)
	b = b - .000283 * math.sin((ma + 3 * f) / pi)	
	
	w1 = .0004664 * math.cos(an / pi)
	w2 = .0000754 * math.cos((an + 275.05 - 2.3 * t) / pi)
	be = b * (1 - w1 - w2)

	p = .950724 + .051818 * math.cos(ma / pi) + .009531 * math.cos((2 * d - ma) / pi)
	p = p + .007843 * math.cos((2 * d) / pi) + .002824 * math.cos((2 * ma) / pi)
	p = p + .000857 * math.cos((2 * d + ma) / pi) + e * .000533 * math.cos((2 * d -	m) / pi)
	p = p + e * .000401 * math.cos((2 * d - m - ma) / pi) + e * .00032 * math.cos((ma - m) / pi)
	p = p - .000271 * math.cos(d / pi) + e * .000264 * math.cos((m + ma) /pi)
	p = p - .000198 * math.cos((2 * f - ma) / pi) + .000173 * math.cos((3 * ma) / pi)
	p = p + .000167 * math.cos((4 * d - ma) / pi) + e * -.000111 * math.cos(m / pi)
	p = p + .000103 * math.cos((4 * d - 2 * ma) / pi) - .000084 * math.cos((2 * ma - 2 * d) / pi)
	p = p + e * -.000083 * math.cos((2 * d + m) / pi) + .000079 * math.cos((2 * d + 2 * ma) / pi)
	p = p + .000072 * math.cos((4 * d) / pi) + e * .000064 * math.cos((2 * d - m + ma) / pi)
	p = p + e * -.000063 * math.cos((2 * d + m - ma) / pi) + e * .000041 * math.cos((m + d) / pi)
	p = p + e * .000035 * math.cos((2 * ma - m) / pi) - .000033 * math.cos((3 * ma - 2 * d) / pi)
	p = p - .00003 * math.cos((ma + d) / pi) - .000029 * math.cos((2 * f - 2 * d) / pi)
	p = p + e * -.000029 * math.cos((2 * ma + m) / pi) + e^2 * .000026 * math.cos((2 * d - 2 * m) / pi)
	p = p - .000023 * math.cos((2 * f - 2 * d + ma) / pi) + e * .000019 * math.cos((4 * d - m - ma) / pi)

	ee = 23.452294 - .0130125 * t - .00000164 * t^2 + .000000503* t^3
	a1 = math.sin(la / pi) * math.cos(ee / pi) - math.tan(b / pi) * math.sin(ee / pi)
	a2 = math.cos(la / pi)
	lo = math.atan(a1 / a2) * pi
	polar()
	ra = (lo / 360) * 24
	lo = math.sin(b / pi) * math.cos(ee / pi) + math.cos(b / pi) * math.sin(ee / pi) * math.sin(la / pi)
	de = (math.atan(lo / math.sqrt(-lo * lo + 1))) * pi
	ra1 = ra * 15
	de1 = de
	ram = ra1
	dem = de
	calcsun()
	d = math.cos((la - stl) / pi) * math.cos(be / pi)
	d = (-math.atan(d / math.sqrt(-d * d + 1)) + 1.5708) * pi
	i = 180 - d - .1468 * ((1 - .0549 * math.sin(ma / pi)) / (1 - .0167 * math.sin(m / pi))) * math.sin(d / pi)
	k = (1 + math.cos(i / pi)) / 2	
	
end

function calcelements()
	l = l - (math.floor(l / 360) * 360)
	m = l - w - o
	ov1 = l
	ov2 = e
	ov3 = m
	q1 = a * (1 - e)
	q2 = a * (1 + e)
	equation()
	anomaly()
	vvk = v
	r1 = a * (1 - e * math.cos(e1 / pi))
	u = l + v - m - o
	a1 = math.cos(i / pi) * math.sin(u / pi)
	a2 = math.cos(u / pi)
	lo = math.atan(a1 / a2) * pi
	polar()
	l1 = lo + o	
	b1 = math.sin(u / pi) * math.sin(i / pi)
	b1 = math.atan(b1 / math.sqrt(-b1 * b1 + 1)) * pi
	if b1 > 90 then b1 = b1 - math.floor(b1 / 90) * 90 end
	if b1 < -90 then b1 = b1 - math.floor(b1 / 90) * 90 end
	ls = 279.69668 + 36000.76892 * t + .0003025 * t^2
	l = ls - math.floor(ls / 360) * 360
	ms = 358.47583 + 35999.04975 * t - .00015 * t^2 - .0000033 * t^3
	m = ms - math.floor(ms / 360) * 360
	e = .01675104 - .0000418 * t - .000000126 * t^2	
	x1=m x2=e
	equation()
	anomaly()
	sl = l + v - m
	r = 1.0000002 * (1 - e * math.cos(e1 / pi))
	ee = 23.452294 - .0130125 * t - .000000164 * t^2 + .000000503 * t^3
	a1 = r1 * math.cos(b1 / pi) * math.sin((l1 - sl) / pi)
	a2 = r1 * math.cos(b1 / pi) * math.cos((l1 - sl) / pi) + r
	lo = math.atan(a1 / a2) * pi
	polar()
	dec = math.sqrt(a1^2 + a2^2 + (r1 * math.sin(b1 / pi))^2)
	gl = (r1 / dec) * math.sin(b1 / pi)
	gl = math.atan(gl / math.sqrt(-gl * gl + 1)) * pi
	g1 = lo + sl
	ef = .0057756 * dec
	el = math.cos(gl / pi) * math.cos(lo / pi)
	el = (-math.atan(el / math.sqrt(-el * el + 1)) + 1.5708) * pi
	ill = (r1 + dec + r * math.cos(b1 / pi) * math.cos((l1 - sl) / pi)) / (2 * dec)
	s1 = 0
	s2 = 0
	s1 = sd1 / dec
	if sd2 > 0 then s2 = sd2 / dec end
	a1 = math.sin(g1 / pi) * math.cos(ee / pi) - math.tan(gl / pi) * math.sin(ee / pi)
	a2 = math.cos(g1 / pi)
	lo = math.atan(a1 / a2) * pi
	polar()
	ra = (lo / 360) * 24
	lo = math.sin(gl / pi) * math.cos(ee / pi) + math.cos(gl / pi)* math.sin(ee / pi) * math.sin(g1 / pi)
	de = (math.atan(lo / math.sqrt(-lo * lo + 1)))* pi
end

function equation()
	k = 0
	e0 = m
	while k < 30 do
		e1 = e0 + (m + (e * pi) * math.sin(e0 / pi) - e0) / (1 - e * math.cos(e0 / pi))
		k = k + 1
		if e1 == e0 then k=30 end
		e0 = e1
	end
end

function anomaly()
	a1 = math.sqrt((1 + e) / (1 - e)) * math.tan((e1 / 2) / pi)
	v = math.atan(a1) * pi * 2
	if v < 0 then v = v + 360 end
end



function mer()
	l = 178.179078 + 149474.07078 * t + .0003011 * t^2 + .1323108 * t
	a = .3870977
	e = .20561421 + .00002046 * t -.00000003 * t^2 + .0000014 * t
	i = 7.010678 - .0059556 * t + .00000069 * t^2 - .000000035 * t^3
	w = 28.839814 + .2842765 * t + .00007444 * t^2 + .00000043 * t^3
	o = 48.456876 - .1254715 * t - .00008844 * t^2 - .000000068 * t^3
	pl = "Mercury"
	sd1 = 3.34 
	sd2 = 0
end

function ven()
	l = 342.767053 + 58519.21191 * t + .0003097 * t^2 + .1323436 * t
	a = .7233262
	e = .00682069 - .00004774 * t + .0000000909 * t^2 - .0000039 * t
	i = 3.395459 - .0007913 * t - .0000325 * t^2 + .000000018 * t^3
	w = 54.602827 + .2892764 * t - .00114464 * t^2 - .000000794 * t^3
	o = 76.95774 - .2776656 * t - .0001401 * t^2 + .000000769 * t^3
	pl = "Venus"
	sd1 = 8.41
	sd2 = 0
end

function mar()
	l = 293.737334 + 19141.69551 * t + .0003107 * t^2 + .138504 * t
	a = 1.5237858
	e = .0933129 + .000092064 * t - .000000077 * t^2 - .0000567 * t
	i = 1.857866 - .008156 * t - .00002304 * t^2 - .000000044 * t^3
	w = 285.762379 + .7387251 * t + .00046556 * t^2 + .000006939 * t^3
	o = 49.852347 - .2942821 * t - .00064344 * t^2 - .0000081589 * t^3
	pl = "Mars"
	sd1 = 4.68
	sd2 = 0
end

function jup()
	l = 238.049257 + 3036.301986 * t + .0003347 * t^2 - .00000165 * t^3 + .1693824 * t
	a = 5.2032614
	e = .04833475 + .00016418 * t - .0000004676 * t^2 - .0000000017 * t^3 - .0002799 * t
	i = 1.305288 - .0022374 * t + .00002942 * t^2 + .000000127 * t^3 
	w = 273.829584 + .0478404 * t - .00021857 * t^2 + .000008999 * t^3
	o = 100.287838 + .1659357 * t + .00096672 * t^2 - .00001246 * t^3
	pl = "Jupiter"
	sd1 = 98.47
	sd2 = 91.91
end

function sat()
	l = 266.564377 + 1223.509884 * t + .0003245 * t^2 - .0000058 * t^3 + .0153625 * t
	a = 9.5171546	
	e = .05589232 - .0003455 * t - .000000728 * t^2 + .00000000074 * t^3 - .0006573 * t
	i = 2.486204 + .0024449 * t - .00005017 * t^2 + .000000002 * t^3 
	w = 338.571353 + .9220515 * t + .00070747 * t^2 + .000006177 * t^3
	o = 113.923406 - .2599254 * t - .00018997 * t^2 - .000001589 * t^3
	pl = "Saturn"
	sd1 = 83.33
	sd2 = 74.57
end

function ura()
	l = 244.19747 + 429.863546 * t + .000316 * t^2 - .0000006 * t^3 - .8611257 * t
	a = 19.1730068
	e = .0463444 - .00002658 * t + .000000077 * t^2 + .0020108 * t
	i = .77495 - .001766 * t - .00000027 * t^2 + .000000123 * t^3
	w = 99.021587 + .0337219 * t - .00049812 * t^2 + .000013904 * t^3
	o = 73.923501 + .0545828 * t + .00042674 * t^2 - .000014536 * t^3
	pl = "Uranus"
	sd1 = 34.28
	sd2 = 0
end

function nep()
	l = 84.457994 + 219.885914 * t + .0003205 * t^2 - .0000006 * t^3 + .5980468 * t
	a = 30.0229816
	e = .00899704 + .00000633 * t - .000000002 * t^2 - .0002397 * t
	i = 1.769715 - .0000144 * t - .00000227 * t^2 + .000000018 * t^3
	w = 276.335328 + .0368127 * t + .00003849 * t^2 + .000002226 * t^3
	o = 131.788486 - .0084187 * t + .00004428 * t^2 - .000002858 * t^3
	pl = "Neptune"
	sd1 = 36.56
	sd2 = 0
end

function plu()
	l = 94.244023 + 144.44547 * t
	a = 39.6028268
	e = .2511741
	i = 17.14907
	w = 110.57775 + 3.1528617 * t
	o = 107.52859 + 2.9643115 * t	
	pl = "Pluto"
	sd1 = 4	
	sd2 = 0
end

function calcmplan()
	
	screen:clear()	
	yy=Date.year
	mm=Date.month
	da=Date.day
	hh=0
	mi=0
	calcjd()	
	calccd()
	calcmp()
	calcrade()
	screen:print(50,80,"Coordinates          = "..pl.." for Epoch 2000",red)	
	screen:print(50,90,"For Date ET          = "..cd,red)
	screen:print(50,100,"Right Asscension     = ".. hr1.." hr "..mi1.." mn "..se1.." s Mean", white)
	screen:print(50,110,"Declination          = ".. hr2.." dg "..mi2.." mn "..se2.." s Mean", white)
	screen:print(50,120,"Distance to Earth    = "..d.." AE",white)
	rr = math.sqrt(xx ^2 + yy ^2 + zz ^2)
	r1 = r4
	w = (rr ^2 + d ^2 - r1 ^2)/ (2 * rr * d)
	w = (- math.atan(w / math.sqrt(-w * w + 1)) + 1.5708) * pi

	screen:print(50,130,"Elonguation to Sun   = "..w,white)
	b = (r1 ^2 + d ^2- rr ^2) / (2 * r1 * d)
	b = (- math.atan(b / math.sqrt(-b * b + 1)) + 1.5708) * pi	
	screen:print(50,140,"Angle S-B-E          = "..b,white)
	calcstg()
	ra = ra - td + (ol / 15)
	calcrade()
	screen:print(50,160,"For Position  Lat = "..nb.." Lon = "..ol, red)
	screen:print(50,170,"Planet main          = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
	h = (-.00989 - math.sin(de / pi) * math.sin(nb / pi)) / (math.cos(de / pi) * math.cos(nb / pi))
	h = (-math.atan(h / math.sqrt(-h * h + 1)) + 1.5708) * pi
	sm = ra
	ra = sm - (h / 15)
	calcrade()
	screen:print(50,180,"Planet rise          = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
	ra = sm + (h / 15)
	calcrade()
	screen:print(50,190,"Planet set           = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
	screen.waitVblankStart()
	screen.flip()
	pad = Controls.read()

	while not pad:circle() do
		pad = Controls.read()		
	end
end

function calcmp()
	t = (jd - 2415020) / 36525
	ee = 23.452294 - .0130125 * t - .00000164 * t^2 + .000000503 * t^3
	n=n4 m=m4 a=a4 e=e4 i=i4 w=w4 o=o4
	
	td = jd - tp
	m = m + n * td
	f = math.cos(o / pi)
	g = math.sin(o / pi) * math.cos(ee / pi)
	h = math.sin(o / pi) * math.sin(ee / pi)
	p = -math.sin(o / pi) * math.cos(i / pi)
	q = math.cos(o / pi) * math.cos(i / pi) * math.cos(ee / pi) - math.sin(i / pi) * math.sin(ee / pi)
	r = math.cos(o / pi) * math.cos(i / pi) * math.sin(ee / pi) + math.sin(i / pi) * math.cos(ee / pi)
	aa = math.sqrt(f ^2 + p ^2)
	bb = math.sqrt(g ^2 + q ^2)
	cc = math.sqrt(h ^2 + r ^2)
	a1 = f a2 = p lo = math.atan(f / p) * pi polar() aaa = lo
	a1 = g a2 = q lo = math.atan(g / q) * pi polar() bbb = lo
	a1 = h a2 = r lo = math.atan(h / r) * pi polar() ccc = lo
	
	equation()	
	anomaly()
	
	r1 = a * (1 - e * math.cos(e1 / pi))
	r4=r1
	x = r1 * aa * math.sin((aaa + w + v) / pi)
	y = r1 * bb * math.sin((bbb + w + v) / pi)
	z = r1 * cc * math.sin((ccc + w + v) / pi)
	
	calcsun()
	xx = r * math.cos(stl / pi)
	yy = r * math.sin(stl / pi) * math.cos(ee / pi)
	zz = r * math.sin(stl / pi) * math.sin(ee / pi)
	a1 = yy + y a2 = xx + x lo = math.atan(a1 / a2) * pi
	
	polar() ra = lo / 15
	d = math.sqrt((xx + x) ^2 + (yy + y) ^2 + (zz + z) ^2)
	de = (zz + z) / d
	de = math.atan(de / math.sqrt(-de * de + 1)) * pi

end



function calccometpar()
	
	screen:clear()	
	yy=Date.year
	mm=Date.month
	da=Date.day
	hh=0
	mi=0
	calcjd()	
	calccd()
	t = (jd - 2415020) / 36525
	ee = 23.452294 - .0130125 * t - .00000164 * t^2 + .000000503 * t^3
	qq=q4 i=i4 w=w4 o=o4

	f = math.cos(o / pi)
	g = math.sin(o / pi) * math.cos(ee / pi)
	h = math.sin(o / pi) * math.sin(ee / pi)
	p = -math.sin(o / pi) * math.cos(i / pi)
	q = math.cos(o / pi) * math.cos(i / pi) * math.cos(ee / pi) - math.sin(i / pi) * math.sin(ee / pi)
	r = math.cos(o / pi) * math.cos(i / pi) * math.sin(ee / pi) + math.sin(i / pi) * math.cos(ee / pi)
	
        aa = math.sqrt(f ^2 + p ^2)
	bb = math.sqrt(g ^2 + q ^2)
	cc = math.sqrt(h ^2 + r ^2)
	a1 = f a2 = p lo = math.atan(f / p) * pi polar() aaa = lo
	a1 = g a2 = q lo = math.atan(g / q) * pi polar() bbb = lo
	a1 = h a2 = r lo = math.atan(h / r) * pi polar() ccc = lo
	ww=(.0364911624 / (qq * math.sqrt(qq))) * (jd - tp)
	s=0 s2 = 1 s3 = 0
	mn1 = 1
	
	while s ~= s2 and mn1 < 50 do
		s2 = (2 * s3 ^3 + ww) / (3 * (s3 ^2 + 1))	
		s = s3 s3 = s2
		mn1=mn1+1	
	end
	
	v = math.atan(s) * pi * 2
	r1 = qq * (1 + s ^2)
	r4 = r1

	x = r1 * aa * math.sin((aaa + w + v) / pi)
	y = r1 * bb * math.sin((bbb + w + v) / pi)
	z = r1 * cc * math.sin((ccc + w + v) / pi)
	
	calcsun()
	xx = r * math.cos(stl / pi)
	yy = r * math.sin(stl / pi) * math.cos(ee / pi)
	zz = r * math.sin(stl / pi) * math.sin(ee / pi)

	
	a1 = yy + y a2 = xx + x lo = math.atan(a1 / a2) * pi
	
	polar() ra = lo / 15
	
	d = math.sqrt((xx + x) ^2 + (yy + y) ^2 + (zz + z) ^2)
	de = (zz + z) / d
	de = math.atan(de / math.sqrt(-de * de + 1)) * pi
		

	calcrade()
	screen:print(50,80,"Coordinates  (par)   = "..pl.." E 2000",red)	
	screen:print(50,90,"For Date ET          = "..cd,red)
	screen:print(50,100,"Right Asscension     = ".. hr1.." hr "..mi1.." mn "..se1.." s Mean", white)
	screen:print(50,110,"Declination          = ".. hr2.." dg "..mi2.." mn "..se2.." s Mean", white)
	screen:print(50,120,"Distance to Earth    = "..d.." AE",white)
	rr = math.sqrt(xx ^2 + yy ^2 + zz ^2)
	r1 = r4
	w = (rr ^2 + d ^2 - r1 ^2)/ (2 * rr * d)
	w = (- math.atan(w / math.sqrt(-w * w + 1)) + 1.5708) * pi

	screen:print(50,130,"Elonguation to Sun   = "..w,white)
	b = (r1 ^2 + d ^2- rr ^2) / (2 * r1 * d)
	b = (- math.atan(b / math.sqrt(-b * b + 1)) + 1.5708) * pi	
	screen:print(50,140,"Angle S-B-E          = "..b,white)
	calcstg()
	ra = ra - td + (ol / 15)
	calcrade()
	screen:print(50,160,"For Position  Lat = "..nb.." Lon = "..ol, red)
	screen:print(50,170,"Comet main           = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
	h = (-.00989 - math.sin(de / pi) * math.sin(nb / pi)) / (math.cos(de / pi) * math.cos(nb / pi))
	h = (-math.atan(h / math.sqrt(-h * h + 1)) + 1.5708) * pi
	sm = ra
	ra = sm - (h / 15)
	calcrade()
	screen:print(50,180,"Comet rise           = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
	ra = sm + (h / 15)
	calcrade()
	screen:print(50,190,"Comet set            = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
	screen.waitVblankStart()
	screen.flip()
	pad = Controls.read()
	while not pad:circle() do
		pad = Controls.read()	
		
	end
end

function calccometper()
		
	screen:clear()	
	yy=Date.year
	mm=Date.month
	da=Date.day
	hh=0
	mi=0
	calcjd()	
	calccd()
	t = (jd - 2415020) / 36525
	ee = 23.452294 - .0130125 * t - .00000164 * t^2 + .000000503 * t^3
	a=a4 e=e4 i=i4 w=w4 o=o4 n=n4	

	f = math.cos(o / pi)
	g = math.sin(o / pi) * math.cos(ee / pi)
	h = math.sin(o / pi) * math.sin(ee / pi)
	p = -math.sin(o / pi) * math.cos(i / pi)
	q = math.cos(o / pi) * math.cos(i / pi) * math.cos(ee / pi) - math.sin(i / pi) * math.sin(ee / pi)
	r = math.cos(o / pi) * math.cos(i / pi) * math.sin(ee / pi) + math.sin(i / pi) * math.cos(ee / pi)
	
	aa = math.sqrt(f ^2 + p ^2)
	bb = math.sqrt(g ^2 + q ^2)
	cc = math.sqrt(h ^2 + r ^2)
	a1 = f a2 = p lo = math.atan(f / p) * pi polar() aaa = lo
	a1 = g a2 = q lo = math.atan(g / q) * pi polar() bbb = lo
	a1 = h a2 = r lo = math.atan(h / r) * pi polar() ccc = lo	

	m = (jd - tp) * n
	equation()
	anomaly()
	r1 = a * (1 - e * math.cos(e1 / pi))
	r4=r1
	x = r1 * aa * math.sin((aaa + w + v) / pi)
	y = r1 * bb * math.sin((bbb + w + v) / pi)
	z = r1 * cc * math.sin((ccc + w + v) / pi)
	
	calcsun()
	xx = r * math.cos(stl / pi)
	yy = r * math.sin(stl / pi) * math.cos(ee / pi)
	zz = r * math.sin(stl / pi) * math.sin(ee / pi)
	a1 = yy + y a2 = xx + x lo = math.atan(a1 / a2) * pi
	
	polar() ra = lo / 15
	d = math.sqrt((xx + x) ^2 + (yy + y) ^2 + (zz + z) ^2)
	de = (zz + z) / d
	de = math.atan(de / math.sqrt(-de * de + 1)) * pi
		

	calcrade()
	screen:print(50,80,"Coordinates   (per)  = "..pl.." for Epoch 2000",red)	
	screen:print(50,90,"For Date ET          = "..cd,red)
	screen:print(50,100,"Right Asscension     = ".. hr1.." hr "..mi1.." mn "..se1.." s Mean", white)
	screen:print(50,110,"Declination          = ".. hr2.." dg "..mi2.." mn "..se2.." s Mean", white)
	screen:print(50,120,"Distance to Earth    = "..d.." AE",white)
	rr = math.sqrt(xx ^2 + yy ^2 + zz ^2)
	r1 = r4
	w = (rr ^2 + d ^2 - r1 ^2)/ (2 * rr * d)
	w = (- math.atan(w / math.sqrt(-w * w + 1)) + 1.5708) * pi

	screen:print(50,130,"Elonguation to Sun   = "..w,white)
	b = (r1 ^2 + d ^2- rr ^2) / (2 * r1 * d)
	b = (- math.atan(b / math.sqrt(-b * b + 1)) + 1.5708) * pi	
	screen:print(50,140,"Angle S-B-E          = "..b,white)
	calcstg()
	ra = ra - td + (ol / 15)
	calcrade()
	screen:print(50,160,"For Position  Lat = "..nb.." Lon = "..ol, red)
	screen:print(50,170,"Comet main           = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
	h = (-.00989 - math.sin(de / pi) * math.sin(nb / pi)) / (math.cos(de / pi) * math.cos(nb / pi))
	h = (-math.atan(h / math.sqrt(-h * h + 1)) + 1.5708) * pi
	sm = ra
	ra = sm - (h / 15)
	calcrade()
	screen:print(50,180,"Comet rise           = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
	ra = sm + (h / 15)
	calcrade()
	screen:print(50,190,"Comet set            = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
	screen.waitVblankStart()
	screen.flip()
	
	while not pad:circle() do
		pad = Controls.read()
			
	end
end


function calcber()
	m = 359.2242 + 29.10535608 * x - .0000333 * t^2 - .00000347 * t^3
	m = m - math.floor(m / 360) * 360
	ma = 306.0253 + 385.81691806 * x + .0107306 * t^2 + .00001236 * t^3
	ma= ma - math.floor(ma / 360) * 360
	f = 21.2964 + 390.67050646 * x - .0016528 * t^2 - .00000239 * t^3
	f = f - math.floor(f / 360) * 360
end


function calceclip()
	dt = (.1734 - .000393 * t) * math.sin(m/pi)
	dt = dt + .0021 * math.sin((2 * m) /pi) - .4068 * math.sin(ma / pi)
	dt = dt + .0161 * math.sin((2 * ma) / pi) - .0051 * math.sin((m + ma) / pi)
	dt = dt - .0074 * math.sin((m - ma) / pi) - .0104 * math.sin((2 * f) / pi)
	jd = jd + dt

	s = 5.19595 - .0048 * math.cos(m / pi) + .002 * math.cos((2 * m) / pi)
	s = s - .3283 * math.cos(ma / pi) - .006 * math.cos((m + ma) / pi)
	s = s + .0041 * math.cos((m - ma) / pi)
	
	c = .207 * math.sin(m / pi) + .0024 * math.sin((2 * m) / pi)
	c = c - .039 * math.sin(ma / pi) + .0115 * math.sin((2 * ma) / pi)
	c = c - .0073 * math.sin((m + ma) / pi) - .0067 * math.sin((m - ma) / pi)
	c = c + .0117 * math.sin((2 * f) / pi)
	
	y = s * math.sin(f / pi) + c * math.cos(f / pi)
	u = .0059 + .0046 * math.cos(m / pi) - .0182 * math.cos(ma /pi)
	u = u + .0004 * math.cos((2 * ma) / pi) - .0005 * math.cos((m + ma) / pi)

end


function calcsunecl()	 
	flat = .99664719  --- flattening of the earth
	equ = 6378137     --- equatorial radius earth
	degr = 0.017453293  --- pi / 180
	tt = (dj-2000)
	dt = 62.92 + .32217 * tt + .005589 * tt ^2
	lat = nb
	lon = ol
	ele = 0
	if dm > 12 then dj=dj+1 dm=dm-12 end
	
	rectangle()	
	t=0
	
	for ww =1,8 do
		bereken()
		t=t+tau
	end
	bertijd()

	screen:clear()	
	screen:print(10,10,"Local calculations for upcoming Sun Eclips "..dd.."-"..dm.."-"..dj.." UT",red)	
	screen:print(10,30,"Latitude   = "..lat, white)
	screen:print(10,40,"Longitude  = "..lon, white)
	screen:print(10,50,"Julian day = "..jd ,white)
	screen:print(240,30,"Saros number = "..saros, white)
	screen:print(100,260,"(Press Right Up for graphics)", red)
	screen:print(340,60,"alt", white)
	screen:print(380,60,"P", white)
	screen:print(420,60,"V", white)


	screen:print(10,100,"Max eclips     = "..hh.." hr "..mm.." min "..ss.." sec", white)
	screen:print(340,100,ho, white)
	screen:print(380,100,pm, white)
	screen:print(420,100,vm, white)
	bermin()
	
	t = app1
	for ww =1,8 do
		bereken()
		bereken1()
		t=t+tau
	end
	bertijd()
	
		screen:print(10,80,"First contact  = "..hh.." hr "..mm.." min "..ss.." sec", white)
		screen:print(340,80,ho, white)
		screen:print(380,80,pm, white)
		screen:print(420,80,vm, white)
	

	t = app4
	for ww =1,8 do
		bereken()
		bereken4()
		t=t+tau
	end
	bertijd()
	pm=pm-180
	vm=vm-180
	
		screen:print(10,120,"Last contact   = "..hh.." hr "..mm.." min "..ss.." sec", white)
		screen:print(340,120,ho, white)
		screen:print(380,120,pm, white)
		screen:print(420,120,vm, white)
	

	t = app2
	for ww =1,8 do
		bereken()
		bereken2()
		t=t+tau
	end
	bertijd()
	
		screen:print(10,90,"First interior = "..hh.." hr "..mm.." min "..ss.." sec", white)
		screen:print(340,90,ho, white)
		screen:print(380,90,pm, white)
		screen:print(420,90,vm, white)
	

	t = app3
	for ww =1,8 do
		bereken()
		bereken3()
		t=t+tau
	end
	bertijd()
	pm=pm-180
	vm=vm-180
	
		screen:print(10,110,"Last interior  = "..hh.." hr "..mm.." min "..ss.." sec", white)
		screen:print(340,110,ho, white)
		screen:print(380,110,pm, white)
		screen:print(420,110,vm, white)
	
	
	

	screen.waitVblankStart()
	screen.flip()
end

function rectangle()
	phi = lat / pi
	lam = lon / pi
	tanu = math.tan(phi) * flat
	u = math.atan(tanu)
	rhos = flat * math.sin(u) + ele / equ * math.cos(phi)
	rhoc = math.cos(u) + ele / equ * math.cos(phi)
end

function bereken()

	x = x0 + x1 * t + x2 * t ^ 2 + x3 * t ^ 3
  	y = y0 + y1 * t + y2 * t ^ 2 + y3 * t ^ 3
  	d = (d0 + d1 * t + d2 * t ^ 2) / pi
  	l1 = l10 + l11 * t + l12 * t ^ 2
  	l2 = l20 + l21 * t + l22 * t ^ 2
	M = m0 + m1 * t
	xa = x1 + t * (2 * x2 + 3 * x3 * t)
	ya = y1 + t * (2 * y2 + 3 * y3 * t)
	h = (M - (lam * pi) - .00417807 * dt) / pi
	ksi = rhoc * math.sin(h)
	eta = rhos * math.cos(d) - rhoc * math.cos(h) * math.sin(d)
	zet = rhos * math.sin(d) + rhoc * math.cos(h) * math.cos(d)
	ksi2 = degr * m1 * rhoc * math.cos(h)
  	eta2 = degr * (m1 * ksi * math.sin(d) - zet * d1)
  	u2 = x - ksi
  	v = y - eta
  	l1a = l1 - zet * f1
  	l2a = l2 - zet * f2
  	a = xa - ksi2
  	b = ya - eta2
  	n2 = a * a + b * b
  	tau = -(u2 * a + v * b) / n2

end

function bereken1()
	nn = math.sqrt(n2)
  	sss = (a * v - u2 * b) / (nn * l1a)
  	tau = -(u2 * a + v * b) / n2 - l1a / nn * math.sqrt(1 - sss * sss)
end

function bereken2()
  	nn = math.sqrt(n2)
  	sss = (a * v - u2 * b) / (nn * l2a)
  	tau = -(u2 * a + v * b) / n2 + l2a / nn * math.sqrt(1 - sss * sss)
end

function bereken3()
  	nn = math.sqrt(n2)
  	sss = (a * v - u2 * b) / (nn * l2a)
  	tau = -(u2 * a + v * b) / n2 - l2a / nn * math.sqrt(1 - sss * sss)

end

function bereken4()
 	nn = math.sqrt(n2)
  	sss = (a * v - u2 * b) / (nn * l1a)
  	tau = -(u2 * a + v * b) / n2 + l1a / nn * math.sqrt(1 - sss * sss)

end

function bertijd()
	htdt = tdt + t
   	hut = htdt - dt / 3600
	hh = math.floor(hut)
	xx = (hut - math.floor(hut)) * 60
	mm = math.floor(xx)
	xx = (xx - math.floor(xx)) * 60
	ss = math.floor(xx)
	pm = math.atan(u2 / v) * pi
	if pm < 0 then pm = pm + 360 end
	if pm > 360 then pm = pm - 360 end
	ho = (math.sin(d) * math.sin(phi) + math.cos(d) * math.cos(phi) * math.cos(h))
	ho = math.asin(ho) * pi
	sq = math.cos(phi) * math.sin(h) / math.cos(ho / pi)
	qq = math.asin(sq) * pi   
	vm = pm - qq
	if vm < 0 then vm = vm + 360 end
	if vm > 360 then vm = vm - 360 end
	ho=math.floor(ho)
	pm=math.floor(pm)
	vm=math.floor(vm)	
end


function bermin()
	mm = math.sqrt(u2 * u2 + v * v)
	gg = (l1a - mm) / (l1a + l2a)
	aaa = (l1a - l2a) / (l1a + l2a)
	oo = 1 / math.sqrt(1 - .006694385 * (math.cos(d)) ^ 2)
	pp = m1 / pi
	bb = ya - pp * x * math.sin(d)
	cc = xa + pp * y * math.sin(d)
	yy1 = oo * y
	bb1 = oo * math.sin(d)
	bb2 = x * oo * math.cos(d)

	bbb = math.sqrt(1 - x * x - yy1 * yy1)
	ll2 = l2 - bbb * f2
	aa = cc - pp * bbb * math.cos(d)
	nn = math.sqrt(aa * aa + bb * bb)
	dur = 7200 * math.abs(ll2) / nn 	--- in sec

	kk = bbb * bbb + (x * a + y * b) ^ 2 / n2
	wid = 2 * equ * math.abs(l2a) / math.sqrt(kk) / 1000
	cen = 7200 * math.abs(l2a) / math.sqrt(n2)
	
	tm = t
	nn = math.sqrt(n2)
	sss = (a * v - u2 * b) / (nn * l1a)
	
	tau = l1a / nn * math.sqrt(1 - sss * sss)
	app1 = tm - tau		--- first contact
	app4 = tm + tau		--- last contact
	sss = (a * v - u2 * b) / (nn * l2a)
	
	tau = l2a / nn * math.sqrt(1 - sss * sss)
	app2 = tm + tau		--- first interior contact
	app3 = tm - tau		--- last interior contact

		mm = dur / 60
		ss = (mm - math.floor(mm)) * 60
		mm = math.floor(mm)
		ss = math.floor(ss)
		screen:print(10,180,"Duration   : "..mm.." min "..ss.." sec", white)

		mm = cen / 60
		ss = (mm - math.floor(mm)) * 60
		mm = math.floor(mm)
		ss = math.floor(ss)
		screen:print(10,190,"Dur at cl  : "..mm.." min "..ss.." sec", white)
		screen:print(10,200,"Magnitude  : "..aaa, white)
		screen:print(10,210,"Width      : "..wid.." km", white)
		

end

function graphsun()
	screen:clear()	
	M1=m1
	k=math.floor(((dj + dm / 12) - 1900) * 12.3685)
	t = k / 1236.85
	x = k
	jd = 2415020.75933 + 29.53058868 * x + .0001178 * t^2 - .000000155 * t^3
	jd = jd + .00033 * math.sin((166.56 + 132.87 * t - .009173 * t^2) / pi)
	calcber()
	sunecl2()
	m1=M1
	o0= (11 - (u3 + m3/60)) * 15 --- longitude
 	a0=0 --- latitude
	r= 130
		
	drawcircle(screen,300,136, 130, white)
	file = io.open("data/world.txt","r") 
		for x = 1,1213 do

			lo1= file:read("*l")*1 --- long
			la1= file:read("*l")*1 --- lat
			lo2= file:read("*l")*1 --- long
			la2= file:read("*l")*1 --- lat
			
			xx1 = r * math.cos(la1/pi)*math.sin((lo1-o0)/pi)
			yy1 = r * (math.cos(a0/pi)*math.sin(la1/pi)-math.sin(a0/pi)*math.cos(la1/pi)*math.cos(lo1-o0)/pi)
			xx2 = r * math.cos(la2/pi)*math.sin((lo2-o0)/pi)
			yy2 = r * (math.cos(a0/pi)*math.sin(la2/pi)-math.sin(a0/pi)*math.cos(la2/pi)*math.cos(lo2-o0)/pi)
			
			c = math.sin(a0/pi) * math.sin(la1/pi)+ math.cos(a0/pi)*math.cos(la1/pi)*math.cos((lo1-o0)/pi)
			if c >= 0 then
				screen:drawLine(300+xx1,136-yy1,300+xx2,136-yy2, white)
			end
		
		end

	file:close()

	file = io.open("data/position.txt","r") 
		maxtel= file:read("*l")*1	
		for x = 1,maxtel do
			lname= file:read("*l") --- country
			lname= file:read("*l") --- city
			la1= file:read("*l")*1 --- lat
			lo1= file:read("*l")*1 --- long
			lo1=-lo1		
			
			xx1 = r * math.cos(la1/pi)*math.sin((lo1-o0)/pi)
			yy1 = r * (math.cos(a0/pi)*math.sin(la1/pi)-math.sin(a0/pi)*math.cos(la1/pi)*math.cos(lo1-o0)/pi)
			
			
			c = math.sin(a0/pi) * math.sin(la1/pi)+ math.cos(a0/pi)*math.cos(la1/pi)*math.cos((lo1-o0)/pi)
			if c >= 0 then
				--- drawcircle(screen,300+xx1,136-yy1, 1, red2)
				screen:print(300+xx1-2,136-yy1-2,".", red2)
			end
		
		end

	file:close()


	tt = (dj-2000)
	dt = 62.92 + .32217 * tt + .005589 * tt ^2
	tim1 = (u3+m3/60)-(u2+m2/60)
	if tim1 < 0 then tim1=tim1+24 end
	tim2 = (u4+m4/60)-(u3+m3/60)
	if tim2 < 0 then tim2=tim2+24 end


for ttl = -o0-tim1*30,-o0+tim2*30 do

	lon = ttl
	ele = 0
	lat = 0
	phi = lat / pi
	lam = lon / pi
		
	t=0
	for x=1,8 do
		tanu = math.tan(phi/pi) * flat
		u = math.atan(tanu)
		rhos = flat * math.sin(u) + ele / equ * math.cos(phi)
		rhoc = math.cos(u) + ele / equ * math.cos(phi)
		bereken()
		t = t + tau
		w=(v*a-u2*b)/math.sqrt(n2)
		q=(b*math.sin(h)*rhos+a*(math.cos(h)*math.sin(d)*rhos+math.cos(d)*rhoc))/( pi * math.sqrt(n2))
		phi=phi+w/q
	end
			
			lo1=-lon
			la1=phi
			xx1 = r * math.cos(la1/pi)*math.sin((lo1-o0)/pi)
			yy1 = r * (math.cos(a0/pi)*math.sin(la1/pi)-math.sin(a0/pi)*math.cos(la1/pi)*math.cos(lo1-o0)/pi)
			
			
			c = math.sin(a0/pi) * math.sin(la1/pi)+ math.cos(a0/pi)*math.cos(la1/pi)*math.cos((lo1-o0)/pi)
			if c >= 0 then
				screen:print(300+xx1,136-yy1,"o", yellow)
				if math.floor(ttl) == math.floor(-o0) then screen:print(300+xx1,136-yy1-5,"X", red) end
				end
end	
	screen.waitVblankStart()
	screen.flip()
	
end

function sunecl2()
	calceclip()
	if math.abs(y) <= 1.5432 + u then
		calccd()
		screen:print(1,10,"Solar eclips = "..cd,red)
		ecl = "" pos=""
		if y > 0 then pos = "North" end
		if y < 0 then pos = "South" end
		if math.abs(y) < .9972 then ecl="Central: Annular/Total" end
		if math.abs(y) < .9972 and u < 0 then ecl="Central: Total" end	
		if math.abs(y) < .9972 and u > .0047 then ecl="Central: Annular" end
		if math.abs(y) > .9972 and math.abs(y) < (.9972 + 1.546 + u) then ecl = "Partial" end
		if math.abs(y) > .9972 and math.abs(y) < .9972 + math.abs(u) then ecl="Non-Central" end
		mag = ((1.5432 + u - math.abs(y)) / (.546 + 2 * u))
	
		screen:print(10,30,"Type : "..ecl, white)
		screen:print(10,40,"Mag  : "..math.floor(mag * 100) / 100, white)

		p = 1.5560386 - u
		t = 1.0286123 - u
		n = .5458 + .04 * math.cos(ma / pi)
		sp = 0
		st = 0
		if (p^2 - y^2) > 0 then sp = (60 / n) * math.sqrt(p^2 - y^2) end
		if (t^2 - y^2) > 0 then st = (60 / n) * math.sqrt(t^2 - y^2) end
		
		screen:print(10,60,"UT Time", white)	
		a1 = math.floor(hh) + math.floor(mi)/60 - sp /60 
		if a1 < 0 then a1 = a1 + 24 end
		u1 = math.floor(a1)
		m1 = (a1 - u1) * 60 
		
		a2 = math.floor(hh) + math.floor(mi)/60 - st /60 
		if a2 < 0 then a2 = a2 + 24 end
		u2 = math.floor(a2)
		m2 = (a2 - u2) * 60 
		
		a3 = math.floor(hh) + math.floor(mi)/60
		if a3 < 0 then a3 = a3 + 24 end
		u3 = math.floor(a3)
		m3 = (a3 - u3) * 60 
		
		a4 = math.floor(hh) + math.floor(mi)/60 + st / 60
		if a4 > 24 then a4 = a4 - 24 end
		u4 = math.floor(a4)
		m4 = (a4 - u4) * 60 
		
		a5 = math.floor(hh) + math.floor(mi)/60 + sp / 60
		if a5 > 24 then a5 = a5 - 24 end
		u5 = math.floor(a5)
		m5 = (a5 - u5) * 60 
		
		
		screen:print(10,70,"b part  "..u1.." "..math.floor(m1),white)
		screen:print(10,80,"b total "..u2.." "..math.floor(m2),white)
	        screen:print(10,90,"e total "..u4.." "..math.floor(m4),white)
		screen:print(10,100,"e part  "..u5.." "..math.floor(m5),white)

		screen:print(10,250,"X = Maximum Total", red)
		screen:print(10,260,"O = Path Total", yellow)	

	end
	if math.abs(y) > 1.5432 + u then
				screen:print(1,10,"Solar eclips = "..cd,red)
				screen:print(1,20,"Not visible", white)
	end	
end

-- menu of System
function credits()
	back = Image.load("pics/zonnestelsel.png") 
	back2 = Image.load("pics/moonland.png") 
	back3 = Image.load("pics/ster.png") 
	back4 = Image.load("pics/zon.png")  
	back5 = Image.load("pics/planeet.png") 
	back6 = Image.load("pics/plan.png") 
	moon1 = Image.load("pics/moonnew.png")
	moon2 = Image.load("pics/moonhalf.png")
	moon3 = Image.load("pics/moonfull.png")



		screen:clear()
		screen:blit(0,25, back)
		screen:print(200,120,"    Astronomy v 4.3",white)
		screen:print(200,130,"Created by Harpet 2008",white)
		screen:print(200,140,"       E-Mail",white)
		screen:print(200,150,"  harpetgroup@home.nl ",white)
		screen:print(200,180,"  Press (O) to return",red)
		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end
end

function nbol()
	save = 0
	file = io.open("data/position.txt","r")
		maxtel= file:read("*l")
		maxtel = maxtel * 1
		tel = 1	
		coun= file:read("*l")
		city= file:read("*l")
		vnb= file:read("*l")
		vol= file:read("*l")
		vnb = math.floor(vnb * 100) / 100 
		vol = math.floor(vol * 100) / 100
	
	while not pad:circle() do
		pad = Controls.read()
		screen:clear()
		screen:print(100,80,"Database city locations",red)
		screen:print(100,90,"Country = "..coun,white)
		screen:print(100,100,"City    = "..city,white)
		screen:print(100,110,"Lat = "..vnb.." Lon = "..vol,white)
		screen:print(100,140,"Position for calculation",red)
		screen:print(100,150,"Lattitude  North = " .. nb,white)
		screen:print(100,160,"Longitude  West  = " .. ol,white)
		screen:print(150,200,"(O) = Back (Square) = Save",red)
		screen:print(150,210,"   (Down) = Next City",red)
		
		if pad:down() and tel < maxtel then
			coun= file:read("*l")
			city= file:read("*l")
			vnb= file:read("*l")
			vol= file:read("*l")
			vnb = math.floor(vnb * 100) / 100 
			vol = math.floor(vol * 100) / 100	
			tel = tel + 1
			for a=1,50000 do end	-- slow down menu
		end					
		screen.waitVblankStart()
		screen.flip()

		if pad:square() then
			nb = vnb
			ol = vol
			save = 1
		for a=1,50000 do end	-- slow down menu
		end
		
	end
	file:close() 
	if save == 1 then
		file = io.open("data/latlon.txt","w")
		file:write(nb)
		file:write("\n")
		file:write(ol)
		file:close() 
	end

end

function datum()	
	a = 1
	while not pad:circle() do
		pad = Controls.read()
		screen:clear()
		screen:blit(100,a*10+100,selector.image)
		screen:print(100,100,"Please adjust the Date/Time UT",red)			
		screen:print(100,110,"Year  = " .. Date.year,white)
		screen:print(100,120,"Month = " .. Date.month,white)
		screen:print(100,130,"Day   = " .. Date.day,white)
		screen:print(100,140,"Hour  = " .. Date.hour,white)
		screen:print(100,150,"Minute= " .. Date.min,white)
		screen:print(100,170,"(O) = Back   (Square) = Reset",red)
		
		if pad:right() and a == 1 then Date.year=Date.year+1 end	
		if pad:right() and a == 2 then Date.month=Date.month+1 end
		if pad:right() and a == 3 then Date.day=Date.day+1 end
		if pad:right() and a == 4 then Date.hour=Date.hour+1 end
		if pad:right() and a == 5 then Date.min=Date.min+1 end
		if pad:left() and a == 1 then Date.year=Date.year-1 end	
		if pad:left() and a == 2 then Date.month=Date.month-1 end
		if pad:left() and a == 3 then Date.day=Date.day-1 end
		if pad:left() and a == 4 then Date.hour=Date.hour-1 end
		if pad:left() and a == 5 then Date.min=Date.min-1 end
		if pad:down() then a=a+1 end
		if pad:up() then a=a-1 end
		if pad:square() then Date = os.date ("!*t") end
		if a>5 then a=5 end
		if a<1 then a=1 end
		if Date.month > 12 then Date.month = 12 end
		if Date.month <1 then Date.month = 1 end
		if Date.day > 31 then Date.day = 31 end
		if Date.day < 1 then Date.day = 1 end
		if Date.hour > 23 then Date.hour = 23 end
		if Date.hour < 0 then Date.hour = 0 end
		if Date.min > 59 then Date.min = 59 end
		if Date.min < 0 then Date.min = 0 end
		screen.waitVblankStart()
		screen.flip()
		for a=1,50000 do end	-- slow down menu
	end	
end


function events()
	
		screen:clear()
		screen:print(10,20,"Upcoming events",red)	
		if Date.year < 2015 then		
			file = io.open("data/events.txt","r")
			a1= file:read("*l") * 1
			a2= file:read("*l") * 1
			a3= file:read("*l") * 1
			a4= file:read("*l")
						
			while Date.year > a1  do
				a1= file:read("*l") * 1
				a2= file:read("*l") * 1
				a3= file:read("*l") * 1
				a4= file:read("*l")			
			end	
			while Date.month > a2  do
				a1= file:read("*l") * 1
				a2= file:read("*l") * 1
				a3= file:read("*l") * 1
				a4= file:read("*l")			
			end	
			while Date.day > a3  do
				a1= file:read("*l") * 1
				a2= file:read("*l") * 1
				a3= file:read("*l") * 1
				a4= file:read("*l")			
			end	
			for x = 1,5 do
			   	screen:print(10,30 + x*10,"Date  = "..a1.."-"..a2.."-"..a3.." = "..a4,white)	
				a1= file:read("*l") * 1
				a2= file:read("*l") * 1
				a3= file:read("*l") * 1
				a4= file:read("*l")				
			end
			file:close() 
		end

		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end
end

function calccorfm()
	dt = (.1734 - .000393 * t) * math.sin(m / pi)
	dt = dt + .0021 * math.sin((2 * m) / pi) - .4068 * math.sin(ma / pi)
	dt = dt + .0161 * math.sin((2 * ma) / pi) - .0004 * math.sin((3 * ma) / pi)
	dt = dt + .0104 * math.sin((2 * f) / pi) - .0051 * math.sin((m + ma) / pi)
	dt = dt - .0074 * math.sin((m - ma) / pi) + .0004 * math.sin((2 * f - m) / pi)
	dt = dt - .0004 * math.sin((2 * f - m) / pi) - .0006 * math.sin((2 * f + ma) / pi)
	dt = dt + .001 * math.sin((2 * f - ma) / pi) + .0005 * math.sin((m + 2 * ma) / pi)
	jd = jd + dt
end

-- menu of date/time
function cdjd()
	
		screen:clear()
		yy=Date.year
		mm=Date.month
		da=Date.day
		hh=Date.hour
		mi=Date.min
		calcjd()		
		screen:print(100,100,"Date       = ".. Date.year.."-"..Date.month.."-"..Date.day.." "..Date.hour..":"..Date.min,red)
		screen:print(100,110,"Julian Day = ".. jd,white)
		screen:print(50,130,"is a count of days elapsed since Greenwich",red)
		screen:print(50,140," mean noon on 1 January 4713 B.C., Julian",red)
		screen:print(50,150,"          proleptic calendar",red)
		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end
end

function etut()
	
		screen:clear()
		calcet()
		dtt = math.floor(dt * 60)
		screen:print(50,100,"Difference ET -> U(niversal) Time = ".. dtt.." sec",white)	
		screen.waitVblankStart()
		screen.flip()	
	while not pad:circle() do
		pad = Controls.read()
	end
end

function utstg()
	
		screen:clear()
		yy=Date.year
		mm=Date.month
		da=Date.day
		hh=Date.hour
		mi=Date.min
		calcjd()
		calcstg()
		screen:print(50,100,"Siderial Time Greenwich = ".. math.floor(hhh).."  hr ".. math.floor(mi).." min "..math.floor(se).." sec",white)
		screen:print(50,130,"is mean time on the Prime Meridian. Mean time",red)
		screen:print(50,140,"was derived by observing the true solar time ",red)
		screen:print(50,150,"and then adding to it a calculated correction",red)			
		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end

end

function easter()
	
		screen:clear()
		calceaster()
		screen:print(100,100,"Eastern Day (sunday) = ".. (p+1).."-"..n.."-"..yy,white)
		screen:print(50,130,"Easter falls on the first Sunday following",red)
		screen:print(50,140,"    the first ecclesiastical full moon ",red)
		screen:print(50,150,"     that occurs on or after March 21",red)
		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end
end


-- menu of objects

function sun()
	
		screen:clear()
		yy=Date.year
		mm=Date.month
		da=Date.day
		hh=0
		mi=0
		calcjd()
		calcsun()
		screen:print(50,40,"Solar Coordinates ET = ".. yy.."-"..mm.."-"..da.." 00:00",red)
		screen:print(50,60,"Mean Longitude       = ".. l, white)
		screen:print(50,70,"Mean Anomaly         = ".. m, white)
		screen:print(50,80,"True Longitude       = ".. stl, white)
		screen:print(50,90,"True anomaly         = ".. v, white)
		screen:print(50,100,"Radius Vector        = ".. r.." AE", white)
		screen:print(50,110,"Obliquity ecliptic   = ".. et, white)
		calcrade()
		screen:print(50,130,"Right Asscension     = ".. hr1.." hr "..mi1.." mn "..se1.." s Mean", white)
		screen:print(50,140,"Declination          = ".. hr2.." dg "..mi2.." mn "..se2.." s Mean", white)
		calcstg()
		ra = ra - td + (ol / 15)
		calcrade()
		screen:print(50,160,"For Position  Lat = "..nb.." Lon = "..ol, red)
		screen:print(50,170,"Sun main             = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
		h = (-.01454 - math.sin(de/pi) * math.sin(nb/pi)) / (math.cos(de/pi) * math.cos(nb/pi))
		h = (-math.atan(h / math.sqrt(-h * h + 1)) + 1.5708) * pi
		sm = ra
		ra = sm - (h / 15)
		calcrade()
		screen:print(50,180,"Sun rise             = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
		ra = sm + (h / 15)
		calcrade()
		screen:print(50,190,"Sun set              = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end
end

function moon()
	
		screen:clear()	
		yy=Date.year
		mm=Date.month
		da=Date.day
		hh=0
		mi=0
		calcjd()
		calcmoon()
		screen:print(50,40,"Moon Coordinates ET  = ".. yy.."-"..mm.."-"..da.." 00:00",red)
		de = la
		calcrade()
		screen:print(50,60,"Moon's Geocentric Longitude = ".. hr2.." dg "..mi2.." mn "..se2.." s Mean", white)
		de = be
		calcrade()
		screen:print(50,70,"Moon's Geocentric Latitude  = ".. hr2.." dg "..mi2.." mn "..se2.." s Mean", white)
		de = p
		calcrade()
		screen:print(50,80,"Moon's Geocentric Parralax  = ".. hr2.." dg "..mi2.." mn "..se2.." s Mean", white)
		di = 6378.14 / math.sin(p / pi)
		screen:print(50,90,"Moon's distance to Earth    = ".. math.floor(di) .. " km", white)
		screen:print(50,100,"Moon's Illuminated fraction = ".. k, white)	
		s = 358482800 / di
		screen:print(50,110,"Moon's Semi-diameter        = ".. s, white)
		ra = ra1 / 15
		de = de1
		calcrade()		
		screen:print(50,140,"Right Asscension     = ".. hr1.." hr "..mi1.." mn "..se1.." s Mean", white)
		screen:print(50,150,"Declination          = ".. hr2.." dg "..mi2.." mn "..se2.." s Mean", white)
		calcstg()
		ra = ra - td + (ol / 15)
		calcrade()
		screen:print(50,170,"For Position  Lat = "..nb.." Lon = "..ol, red)
		screen:print(50,180,"Moon main            = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
		h = (-.00989 - math.sin(de / pi) * math.sin(nb / pi)) / (math.cos(de / pi) * math.cos(nb / pi))
		h = (-math.atan(h / math.sqrt(-h * h + 1)) + 1.5708) * pi
		sm = ra
		ra = sm - (h / 15)
		calcrade()
		screen:print(50,190,"Moon rise            = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
		ra = sm + (h / 15)
		calcrade()
		screen:print(50,200,"Moon set             = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
		calcsun()
		ra2 = ra * 15
		de2 = de
		a1 = math.cos(de2 / pi) * math.sin((ra2 - ra1) / pi)
		a2 = math.cos(de1 / pi) * math.sin(de2 / pi) - math.sin(de1 / pi) * math.cos(de2 / pi) * math.cos((ra2 - ra1) /pi)
		lo = math.atan(a1 / a2) * pi		
		polar()
		screen:print(50,120,"Bright Limb angle           = ".. lo, white)
		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end
end

function elements()
	
		screen:clear()	
		yy=Date.year
		mm=Date.month
		da=Date.day
		hh=00
		mi=00
		calcjd()
		t = (jd - 2415020) / 36525
		if startmenu == 303 then mer() end
		if startmenu == 304 then ven() end
		if startmenu == 305 then mar() end
		if startmenu == 306 then jup() end
		if startmenu == 307 then sat() end
		if startmenu == 308 then ura() end
		if startmenu == 309 then nep() end
		if startmenu == 310 then plu() end

		calcelements()
		screen:print(50,0,"Planet               = "..pl,red)
		screen:print(50,10,"Date             ET  = ".. yy.."-"..mm.."-"..da.." 00:00",red)
		screen:print(50,20,"Mean Longitude       = "..ov1,white)
		screen:print(50,30,"Semimajor Axis       = "..a,white)
		screen:print(50,40,"Eccentricity         = "..ov2,white)
		screen:print(50,50,"Inclination          = "..i,white)
		screen:print(50,60,"Arg. Perhelion       = "..w,white)		
		screen:print(50,70,"Long. As. Node       = "..o,white)
		screen:print(50,80,"Perihelion           = "..q1.." AU",white)
		screen:print(50,90,"Aphelion             = "..q2.." AU",white)
		screen:print(50,100,"Mean Anomaly         = "..ov3,white)
		screen:print(50,110,"Radius Vector        = "..r1,white)
		screen:print(50,120,"Heliocentric long.   = "..l1,white)
		screen:print(50,130,"Heliocentric lati.   = "..b1,white)
		screen:print(50,140,"Distance to Earth    = "..dec.." AU",white)
		screen:print(50,150,"Effect Lighttime     = "..ef * (24 * 60).." min",white)
		screen:print(50,160,"Elongation           = "..el,white)
		screen:print(50,170,"Illuminated Fraction = "..ill,white)
		screen:print(50,180,"SDiameter (Equat)    = "..s1 * 2,white)
		screen:print(50,190,"SDiameter (Polar)    = "..s2 * 2,white)
		calcrade()
		screen:print(50,200,"Right Asscension     = ".. hr1.." hr "..mi1.." mn "..se1.." s Mean", white)
		screen:print(50,210,"Declination          = ".. hr2.." dg "..mi2.." mn "..se2.." s Mean", white)
		calcstg()
		ra = ra - td + (ol / 15)
		calcrade()
		screen:print(50,220,"For Position  Lat = "..nb.." Lon = "..ol, red)
		screen:print(50,230,"Planet main          = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
		h = (-.00989 - math.sin(de / pi) * math.sin(nb / pi)) / (math.cos(de / pi) * math.cos(nb / pi))
		h = (-math.atan(h / math.sqrt(-h * h + 1)) + 1.5708) * pi
		sm = ra
		ra = sm - (h / 15)
		calcrade()
		screen:print(50,240,"Planet rise          = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
		ra = sm + (h / 15)
		calcrade()
		screen:print(50,250,"Planet set           = ".. hr1.." hr "..mi1.." mn "..se1.." s", white)
		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end
end


function minorplan()
	screen:clear()	
	file = io.open("data/planets.txt","r")	
	maxtel= file:read("*l")
	tel = 1
	pl= file:read("*l")
	tp= file:read("*l")
	n4= file:read("*l")
	m4= file:read("*l")
	a4= file:read("*l")
	e4= file:read("*l")
	i4= file:read("*l")
	w4= file:read("*l")
	o4= file:read("*l")
	
	while not pad:circle() do
		pad = Controls.read()
		screen:clear()	
		maxtel=maxtel*1
		if pad:down() and tel < maxtel then	
		        pl= file:read("*l")
			tp= file:read("*l")
			n4= file:read("*l")
			m4= file:read("*l")
			a4= file:read("*l")
			e4= file:read("*l")
			i4= file:read("*l")
			w4= file:read("*l")
			o4= file:read("*l")
			tel=tel+1
			
		end
		jd = tp
		calccd()
		screen:print(100,80,"Minor Planet         = "..pl,red)
		screen:print(100,90,"Elements Valid for   = "..cd,white)
		screen:print(100,135,"(O) = Back (Square) = Calculate",red)
		screen:print(100,145,"  (Down) = Next Minor Planet",red)
		screen.flip()		
		for a1=1,50000 do end	-- slow down menu
		if pad:square() then 
			
			calcmplan()
		end
	end	
	file:close() 
end

function comet()
	screen:clear()	
	file = io.open("data/comets.txt","r")	
	maxtel= file:read("*l")
	tel = 1
	pl= file:read("*l")
	tp= file:read("*l")
	q4= file:read("*l")
	a4= file:read("*l")
	e4= file:read("*l")
	i4= file:read("*l")
	w4= file:read("*l")
	o4= file:read("*l")
	
	
	while not pad:circle() do
		pad = Controls.read()
		screen:clear()	
		maxtel=maxtel*1
		if pad:down() and tel < maxtel then	
		      	pl= file:read("*l")
			tp= file:read("*l")
			q4= file:read("*l")
			a4= file:read("*l")
			e4= file:read("*l")
			i4= file:read("*l")
			w4= file:read("*l")
			o4= file:read("*l")
			tel=tel+1
			
		end
		jd = tp
		calccd()
		screen:print(100,80,"Comet              = "..pl,red)
		screen:print(100,90,"Time Perihelion    = "..cd,white)
		screen:print(100,135,"(O) = Back (Square) = Calculate",red)
		screen:print(100,145,"  (Down) = Next Comet",red)
		screen.waitVblankStart()
		screen.flip()		
		for a1=1,50000 do end	-- slow down menu
		if pad:square() then 
			if a4 == "0" then calccometpar() end
			if a4 ~= 0  then n4=.985609 / (a4 * math.sqrt(a4)) calccometper() end
		end
	end	
	file:close() 
end






-- menu events

function peraph()	
	
		screen:clear()	
		yy=Date.year
		l = 50
		screen:print(10,30,"Perihelion ET",red)
		screen:print(250,30,"Aphelion ET",red)
		
		for x = 1,6 do
			if x == 1 then k= 4.15201 * (yy - 1900)  pl = "Mercury" an = 4 end
		if x == 2 then k = 1.62549 * (yy - 1900) pl = "Venus  " an = 3 end
			if x == 3 then k = .99997 * (yy - 1900)  pl = "Earth  " an = 1 end
			if x == 4 then k = .53166 * (yy - 1900)  pl = "Mars   " an = 1 end	
			if x == 5 then k = .0843 * (yy - 1900)   pl = "Jupiter" an = 1 end
			if x == 6 then k = .03393 * (yy - 1900)  pl = "Saturn " an = 1 end
			k = math.floor(k)
			for y = k,k+an do
				if x == 1 then jd = 2414995.007 + 87.96934997 * y end
				if x == 2 then jd = 2415112.001 + 224.7008454 * y - .0000000304 * y^2 end
				if x == 3 then jd = 2415021.546 + 365.2596413 * y + .0000000152 * y^2 end
				if x == 4 then jd = 2415097.251 + 686.9958091 * y - .0000001221 * y^2 end
				if x == 5 then jd = 2416640.884 + 4332.894375 * y + .0001222 * y^2 end
				if x == 6 then jd = 2409773.47 + 10764.1801 * y + .0013033 * y^2 end
				calccd()
				screen:print(10,l,pl.."  "..cd,white)
				y = y + .5
				if x == 1 then jd = 2414995.007 + 87.96934997 * y end
				if x == 2 then jd = 2415112.001 + 224.7008454 * y - .0000000304 * y^2 end
				if x == 3 then jd = 2415021.546 + 365.2596413 * y + .0000000152 * y^2 end
				if x == 4 then jd = 2415097.251 + 686.9958091 * y - .0000001221 * y^2 end
				if x == 5 then jd = 2416640.884 + 4332.894375 * y + .0001222 * y^2 end
				if x == 6 then jd = 2409773.47 + 10764.1801 * y + .0013033 * y^2 end
				calccd()
  				screen:print(250,l,pl.."  "..cd,white)
				l= l + 10
			end
		end
		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end
end

function eclips()

		screen:clear()	
		yy=Date.year
		l = 30
		x = 0
		screen:print(10,10,"Eclipses "..yy,red)
		k=math.floor((yy - 1900) * 12.3685)
		t = k / 1236.85
		for q = k,k + 12 do
			x = q
			jd = 2415020.75933 + 29.53058868 * x + .0001178 * t^2 - .000000155 * t^3
			jd = jd + .00033 * math.sin((166.56 + 132.87 * t - .009173 * t^2) / pi)
			calcber()
			if math.abs(math.sin(f / pi)) < .36 then sunecl() end
			x = x + .5
			jd = 2415020.75933 + 29.53058868 * x + .0001178 * t^2 - .000000155 * t^3
			jd = jd + .00033 * math.sin((166.56 + 132.87 * t - .009173 * t^2) / pi)	
			calcber()
			if math.abs(math.sin(f / pi)) < .36 then moonecl() end			
		end
		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end
end

function sunecl()
	calceclip()
	if math.abs(y) <= 1.5432 + u then
		calccd()
		screen:print(10,l,"Solar eclips = "..cd,red)
		ecl = "" pos=""
		if y > 0 then pos = "North" end
		if y < 0 then pos = "South" end
		if math.abs(y) < .9972 then ecl="Central: Annular/Total" end
		if math.abs(y) < .9972 and u < 0 then ecl="Central: Total" end	
		if math.abs(y) < .9972 and u > .0047 then ecl="Central: Annular" end
		if math.abs(y) > .9972 and math.abs(y) < (.9972 + 1.546 + u) then ecl = "Partial" end
		if math.abs(y) > .9972 and math.abs(y) < .9972 + math.abs(u) then ecl="Non-Central" end
		mag = ((1.5432 + u - math.abs(y)) / (.546 + 2 * u))
	
		screen:print(10,l+10,ecl.."  "..pos.." Mag : "..math.floor(mag * 100) / 100,red)

		p = 1.5560386 - u
		t = 1.0286123 - u
		n = .5458 + .04 * math.cos(ma / pi)
		sp = 0
		st = 0
		if (p^2 - y^2) > 0 then sp = (60 / n) * math.sqrt(p^2 - y^2) end
		if (t^2 - y^2) > 0 then st = (60 / n) * math.sqrt(t^2 - y^2) end
		
		
		screen:print(10,l+20,"b partial b total  maximum  e total  e partial",white)	
		a1 = math.floor(hh) + math.floor(mi)/60 - sp /60 
		if a1 < 0 then a1 = a1 + 24 end
		u1 = math.floor(a1)
		m1 = (a1 - u1) * 60 
		
		a2 = math.floor(hh) + math.floor(mi)/60 - st /60 
		if a2 < 0 then a2 = a2 + 24 end
		u2 = math.floor(a2)
		m2 = (a2 - u2) * 60 
		
		a3 = math.floor(hh) + math.floor(mi)/60
		if a3 < 0 then a3 = a3 + 24 end
		u3 = math.floor(a3)
		m3 = (a3 - u3) * 60 
		
		a4 = math.floor(hh) + math.floor(mi)/60 + st / 60
		if a4 > 24 then a4 = a4 - 24 end
		u4 = math.floor(a4)
		m4 = (a4 - u4) * 60 
		
		a5 = math.floor(hh) + math.floor(mi)/60 + sp / 60
		if a5 > 24 then a5 = a5 - 24 end
		u5 = math.floor(a5)
		m5 = (a5 - u5) * 60 
		
		ecli = string.format("%02d:%02d    %02d:%02d    %02d:%02d   %02d:%02d     %02d:%02d ",u1,m1,u2,m2,u3,m3,u4,m4,u5,m5)
		screen:print(30,l+30,ecli,white)
		l = l + 40	

	end

end

function moonecl()
	calceclip()
	pe = (1.5572 + u - math.abs(y)) / .545
	pu = (1.0129 - u - math.abs(y)) / .545
	if pe >= 0 then
		calccd()
		p = 1.0129 - u
		t = .4679 - u
		n = .5458 + .04 * math.cos(ma / pi)
		sp = 0
		st = 0
		if (p^2 - y^2) > 0 then sp = (60 / n) * math.sqrt(p^2 - y^2) end
		if pu > 0 and (t^2 - y^2) > 0 then st = (60 / n) * math.sqrt(t^2 - y^2) end
		if st == 0 then pu = 0 end
		screen:print(10,l,"Moon eclips = "..cd,red)
		if pu <= 0 then screen:print(300,l,"Penumbral",red) st = 0 end
		if pu > 0 then screen:print(300,l,"Umbral",red) end
		
		screen:print(10,l+10,"b partial b total  maximum  e total  e partial",white)	
		a1 = math.floor(hh) + math.floor(mi)/60 - sp /60 
		if a1 < 0 then a1 = a1 + 24 end
		u1 = math.floor(a1)
		m1 = (a1 - u1) * 60 
		
		a2 = math.floor(hh) + math.floor(mi)/60 - st /60 
		if a2 < 0 then a2 = a2 + 24 end
		u2 = math.floor(a2)
		m2 = (a2 - u2) * 60 
		
		a3 = math.floor(hh) + math.floor(mi)/60
		if a3 < 0 then a3 = a3 + 24 end
		u3 = math.floor(a3)
		m3 = (a3 - u3) * 60 
		
		a4 = math.floor(hh) + math.floor(mi)/60 + st / 60
		if a4 > 24 then a4 = a4 - 24 end
		u4 = math.floor(a4)
		m4 = (a4 - u4) * 60 
		
		a5 = math.floor(hh) + math.floor(mi)/60 + sp / 60
		if a5 > 24 then a5 = a5 - 24 end
		u5 = math.floor(a5)
		m5 = (a5 - u5) * 60 
		
		ecli = string.format("%02d:%02d    %02d:%02d    %02d:%02d   %02d:%02d     %02d:%02d ",u1,m1,u2,m2,u3,m3,u4,m4,u5,m5)
		screen:print(30,l+20,ecli,white)
		l = l + 30	
	end
end


function suneclips()
	dj=0 dm=0
	file = io.open("data/ecl.txt","r")
		while dj < Date.year do
			dj= file:read("*l")*1
			dm= file:read("*l")*1
			dd= file:read("*l")
			jd= file:read("*l")
			x0= file:read("*l")
			x1= file:read("*l")
			x2= file:read("*l")
			x3= file:read("*l")
			y0= file:read("*l")
			y1= file:read("*l")
			y2= file:read("*l")
			y3= file:read("*l")
			d0= file:read("*l")
			d1= file:read("*l")
			d2= file:read("*l")
			m0= file:read("*l")
			m1= file:read("*l")
			l10= file:read("*l")
			l11= file:read("*l")
			l12= file:read("*l")
			l20= file:read("*l")
			l21= file:read("*l")
			l22= file:read("*l")
			f1= file:read("*l")
			f2= file:read("*l")
			tdt= file:read("*l")*1	  
			saros= file:read("*l")*1				
		end

		while dm < Date.month do
			dj= file:read("*l")*1
			dm= file:read("*l")*1
			dd= file:read("*l")
			jd= file:read("*l")
			x0= file:read("*l")
			x1= file:read("*l")
			x2= file:read("*l")
			x3= file:read("*l")
			y0= file:read("*l")
			y1= file:read("*l")
			y2= file:read("*l")
			y3= file:read("*l")
			d0= file:read("*l")
			d1= file:read("*l")
			d2= file:read("*l")
			m0= file:read("*l")
			m1= file:read("*l")
			l10= file:read("*l")
			l11= file:read("*l")
			l12= file:read("*l")
			l20= file:read("*l")
			l21= file:read("*l")
			l22= file:read("*l")
			f1= file:read("*l")
			f2= file:read("*l")
			tdt= file:read("*l")*1
			saros= file:read("*l")*1
			if dj > Date.year then dm = dm + 12 end		
		end

	file:close()

		calcsunecl() 
	while not pad:circle() do
		pad = Controls.read()
		if pad:r() then 
			screen:clear()
			screen:print(120,135,"Wait a second for calculation",red)
			screen.flip()
			graphsun() 
		end
	end
	

end

function moonphase()
	
		screen:clear()	
		yy=Date.year
	
		l = 50
		screen:print(120,20,"Phases of the Moon "..yy,red)
		screen:print(50,40,"New Moon",red)
		screen:print(270,40,"Full Moon",red)
		k = math.floor((yy - 1900 ) * 12.3685)
		t = k / 1236.85
		for q = k, k + 12 do
			x = q
			jd = 2415020.75933 + 29.53058868 * x + .0001178 * t^2 - .000000155 * t^3
			jd = jd + .00033 * math.sin((166.56 + 132.87 * t - .009173* t^2) / pi)
			calcber()
			calccorfm()
			calccd()
			screen:print(50,l,cd,white)
			x = x + .5
			jd = 2415020.75933 + 29.53058868 * x + .0001178 * t^2 - .000000155 * t^3
			jd = jd + .00033 * math.sin((166.56 + 132.87 * t - .009173* t^2) / pi)
			calcber()
			calccorfm()
			calccd()
			screen:print(270,l,cd,white)

			l = l + 10
		end
		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end
end

function moonjup()

		screen:clear()
		screen:print(120,135,"Wait a second for calculation",red)
		screen.flip()
		screen:clear()	
		yy=Date.year
		mm=Date.month
		da=Date.day
		hh=Date.hour
		mi=Date.min
		calcjd()	
		calccd()
		d = jd - 2415020
		m = 358.476 + .9856003 * d
		m = m - math.floor(m / 360) * 360
		n = 225.328 + .0830853 * d
		n = n - math.floor(n / 360) * 360
		j = 221.647 + .9025179 * d
		j = j - math.floor(j / 360) * 360
		a = 1.92 * math.sin(m / pi) + .02 * math.sin((2 * m) /pi)
		b = 5.537 * math.sin(n / pi) + .167 * math.sin((2 * n) /pi)
		k = j + a - b
		de = math.sqrt(28.07 - 10.406 * math.cos(k / pi))
		w = math.sin(k / pi) / de
		w = math.atan(w / math.sqrt(-w * w + 1)) * pi
		d = d - (de / 173)
		u1 = 84.5506 + 203.405863 * d + w - b
		u2 = 41.5015 + 101.2916323 * d + w - b
		u3 = 109.977 + 50.2345169 * d + w - b
		u4 = 176.3586 + 21.4879802 * d + w - b
		x1 = 5.906 * math.sin(u1 / pi)
		x2 = 9.397 * math.sin(u2 / pi)
		x3 = 14.989 * math.sin(u3 / pi)
		x4 = 26.364 * math.sin(u4 / pi)
		screen:print(80,10,"The moon's of Jupiter "..cd.." UT",red)
		screen:blit(240-5,50,Image.load("pics/jupiter.png"))
		screen:print(240 - x1*5,50,"I",white)
		screen:print(240 - x2*5,50,"E",white)
		screen:print(240 - x3*5,50,"G",white)
		screen:print(240 - x4*5,50,"C",white)
		screen:print(20,200,"Center = Jupiter",white)
		screen:print(20,210,"I = IO           ="..x1.." eq radius Jupiter",white)
		screen:print(20,220,"E = Europa       ="..x2.." eq radius Jupiter",white)
		screen:print(20,230,"G = Ganymedes    ="..x3.." eq radius Jupiter",white)
		screen:print(20,240,"C = Callisto     ="..x4.." eq radius Jupiter",white)
		drawcircle(screen,240,135, 15, yellow)
		drawcircle(screen,240,135, 24, blue)
		drawcircle(screen,240,135, 37, red)
		drawcircle(screen,240,135, 66, green)
		drawcircle(screen,240,135, 1, white)
		pl = "I" ra = u1 str = 15 poscircle2()
		pl = "E" ra = u2 str = 24 poscircle2()
		pl = "G" ra = u3 str = 37 poscircle2()
		pl = "C" ra = u4 str = 66 poscircle2()

		screen.waitVblankStart()
		screen.flip()

	while not pad:circle() do
		pad = Controls.read()
	end
end

function moonsat()

		screen:clear()
		screen:print(120,135,"Wait a second for calculation",red)
		screen.flip()
		screen:clear()	
		yy=Date.year
		mm=Date.month
		da=Date.day
		hh=Date.hour
		mi=Date.min
		calcjd()	
		calccd()
		d = jd - 2444238.5
		u1 = 19.094 + (d / .9425059) * 360
		u1 = u1 - math.floor(u1 / 360) * 360
		u2 = 174.5  + (d / 1.3703741) * 360
		u2 = u2 - math.floor(u2 / 360) * 360		
		u3 = 173.313 + (d / 1.888095) * 360
		u3 = u3 - math.floor(u3 / 360) * 360
		u4 = 76.5 + (d / 2.7375229) * 360
		u4 = u4 - math.floor(u4 / 360) * 360
		u5 = 36.969 + (d / 4.5191641) * 360
		u5 = u5 - math.floor(u5 / 360) * 360
		u6 = 57.414 + (d / 15.966903) * 360
		u6 = u6 - math.floor(u6 / 360) * 360
		u7 = 150.781 + (d / 21.379264) * 360
		u7 = u7 - math.floor(u7 / 360) * 360

		screen:print(80,10,"The moon's of Saturn "..cd.." UT",red)
		drawcircle(screen,240,135, 15, yellow)
		drawcircle(screen,240,135, 20, blue)
		drawcircle(screen,240,135, 25, red)
		drawcircle(screen,240,135, 32, green)
		drawcircle(screen,240,135, 1, white)
		drawcircle(screen,240,135, 42, yellow)
		drawcircle(screen,240,135, 82, blue)
		drawcircle(screen,240,135, 102, red)


		pl = "M"     ra = u1 str = 15 poscircle2()
		pl = "E"     ra = u2 str = 20 poscircle2()
		pl = "T"     ra = u3 str = 25 poscircle2()
		pl = "D"     ra = u4 str = 32 poscircle2()
		pl = "R"     ra = u5 str = 42 poscircle2()
		pl = "Ti"    ra = u6 str = 82 poscircle2()
		pl = "H"     ra = u7 str = 102 poscircle2()

		screen:print(20,80,"M  = Mimas",white)
		screen:print(20,90,"E  = Enceladus",white)
		screen:print(20,100,"T  = Tethys",white)
		screen:print(20,110,"D  = Dione",white)
		screen:print(20,120,"R  = Rhea",white)		
		screen:print(20,130,"Ti = Titan",white)
		screen:print(20,140,"H  = Hyperion",white)

		screen.waitVblankStart()
		screen.flip()

	while not pad:circle() do
		pad = Controls.read()
	end

end

function equinox()
	
		screen:clear()	
		yy=Date.year
		screen:print(100,80,"Equinox and Solstice Sun = "..yy,red)
		for kk = 0,3 do
			jd = (yy + kk / 4) * 365.2422 + 1721141.3			
			calcsun()
			if math.floor(stl + .00001) ~= (kk * 90) then
				calcsun()
				stl = stl - math.floor(stl / 360) * 360
				jd = jd + 58 * math.sin((kk * 90 - stl) / pi)
				
			end
			calccd()
			if kk == 0 then screen:print(70,100,"March     Equinox   ="..cd,white) end
			if kk == 1 then screen:print(70,110,"June      Solstice  ="..cd,white) end
			if kk == 2 then screen:print(70,120,"September Equinox   ="..cd,white) end
			if kk == 3 then screen:print(70,130,"December  Solstice  ="..cd,white) end
		end
		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end
end

-- menu graphics



function starchart()
	yy=Date.year
	mm=Date.month
	da=Date.day
	hh=Date.hour
	mi=Date.min
	calcjd()

	calcmoon()
	ramoon = ra1
	demoon = de1
	kmoon=k
	rasun = ra * 15
	desun = de	

	mer() calcelements()
	ramer = ra * 15
	demer = de
	ven() calcelements()
	raven = ra * 15
	deven = de
	mar() calcelements()
	ramar = ra * 15
	demar = de
	jup() calcelements()
	rajup = ra * 15
	dejup = de
	sat() calcelements()
	rasat = ra * 15
	desat = de
	ura() calcelements()
	raura = ra * 15
	deura = de
	nep() calcelements()
	ranep = ra * 15
	denep = de
	plu() calcelements()
	raplu = ra * 15
	deplu = de

	file = io.open("data/planets.txt","r")	
	maxtel= file:read("*l")
	for tel = 1,maxtel do

		pl= file:read("*l")
		tp= file:read("*l")
		n4= file:read("*l")
		m4= file:read("*l")
		a4= file:read("*l")
		e4= file:read("*l")
		i4= file:read("*l")
		w4= file:read("*l")
		o4= file:read("*l")
		calcmp()
		planetra[tel] = ra * 15
		planetde[tel] = de
		planetna[tel] = pl

	end
	file:close() 
	calccd()
	calcstg()
	td = (td * 15) - ol
	p1 = 1 / pi
	sb = math.sin(nb * p1)
	cb = math.cos(nb * p1)


	plot2()

	while not pad:circle() do
		pad = Controls.read()
		if pad:l() and diepte2 <= 7 then diepte2 = diepte2 + 1 plot2() end
		if pad:r() and diepte2 >= 2 then diepte2 = diepte2 - 1 plot2()  end
		if pad:left() then  centerx2 = centerx2 + 10 plot2() end
		if pad:right() then centerx2 = centerx2 - 10 plot2() end
		if pad:up() then  centery2 = centery2 - 10 plot2() end
		if pad:down() then centery2 = centery2 + 10 plot2() end
	end
		
end

function plot2()
		screen:clear()
		screen:print(1,1,"Zoom in (L)",white)
		screen:print(380,1,"Zoom Out (R)",white)
		screen:print(200,1,"Depth = "..diepte2,red)
		screen:print(0,20,"UT  = "..cd,white)
		screen:print(0,30,"Lat = "..nb,white)
		screen:print(0,40,"Lon = "..ol,white)



--lines of the constellations
	if diepte2 >= 2 then				
		for tel = 1,646 do
			re = lines[tel].x
			de = lines[tel].y
			calc()
			r1 = x
			r2 = y
			re = lines[tel].z
			de = lines[tel].w
			calc()
			if y~=0 and x ~= 0 then
				if r1 ~= 0 and r2 ~= 0 then
					screen:drawLine(180+(r1+centerx2)*diepte2,180+(r2-centery2) * diepte2,180+(x+centerx2)*diepte2,180+(y-centery2) * diepte2,red2)
				end
			end
		end
	end

-- the names of the constellation	
	
	if diepte2 >= 2 then
		for tel = 1,89 do
			re = cname[tel].x
			de = cname[tel].y
			calc()
 
			if y~=0 and x ~= 0 then
				screen:print(180+(x+centerx2)*diepte2,180+(y-centery2) * diepte2,cname[tel].z,grey2)
			end
		end
	end



-- Names of star	
	
	if diepte2 >= 1 then
		for tel = 1,218 do
			re = star[tel].x
			de = star[tel].y
			calc()
			if y~=0 and x ~= 0 then
				screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,back3)
				if diepte2 >=4 then
					screen:print(180+(x+centerx2)*diepte2-10,180+(y-centery2) * diepte2+10,star[tel].m,yellow2)
				end
			end
		end
	end

if diepte2 >= 1 then
		re=rasun
		de=desun
		calc()
		if y~=0 and x ~= 0 then
			screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,back4)
			screen:print(180+(x+centerx2) * diepte2-10,180+(y-centery2) * diepte2+15,"Sun",white)
		end
		re=ramoon
		de=demoon
		calc()
		if y~=0 and x ~= 0 then
			if kmoon < .3 then screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,moon1) end
			if kmoon > .3 then screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,moon2) end
			if kmoon > .8 then screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,moon3) end
			screen:print(180+(x+centerx2) * diepte2-10,180+(y-centery2) * diepte2+15,"Moon",white)
		end

		
			re=ramer
			de=demer
			calc()
			if y~=0 and x ~= 0 then
				screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,back5)
				screen:print(180+(x+centerx2) * diepte2-10,180+(y-centery2) * diepte2+15,"Mercury",white)
			end
			re=raven
			de=deven
			calc()
			if y~=0 and x ~= 0 then
				screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,back5)
				screen:print(180+(x+centerx2) * diepte2-10,180+(y-centery2) * diepte2+15,"Venus",white)
			end
			re=ramar
			de=demar
			calc()
			if y~=0 and x ~= 0 then
				screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,back5)
				screen:print(180+(x+centerx2) * diepte2-10,180+(y-centery2) * diepte2+15,"Mars",white)
			end
			re=rajup
			de=dejup
			calc()
			if y~=0 and x ~= 0 then
				screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,back5)
				screen:print(180+(x+centerx2) * diepte2-10,180+(y-centery2) * diepte2+15,"Jupiter",white)
			end
			re=rasat
			de=desat
			calc()
			if y~=0 and x ~= 0 then
				screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,back5)
				screen:print(180+(x+centerx2) * diepte2-10,180+(y-centery2) * diepte2+15,"Saturn",white)
			end
			re=raura
			de=deura
			calc()
			if y~=0 and x ~= 0 then
				screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,back5)
				screen:print(180+(x+centerx2) * diepte2-10,180+(y-centery2) * diepte2+15,"Uranus",white)
			end
			re=ranep
			de=denep
			calc()
			if y~=0 and x ~= 0 then
				screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,back5)
				screen:print(180+(x+centerx2) * diepte2-10,180+(y-centery2) * diepte2+15,"Neptune",white)
			end
			re=raplu
			de=deplu
			calc()
			if y~=0 and x ~= 0 then
				screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,back5)
				screen:print(180+(x+centerx2) * diepte2-10,180+(y-centery2) * diepte2+15,"Pluto",white)
			end
		
	end
	if diepte2 >= 5 then
		for tel = 1,maxplan do
			re = planetra[tel]
			de = planetde[tel]
			calc()
			if y~=0 and x ~= 0 then
				screen:blit(180+(x+centerx2) * diepte2,180+(y-centery2) * diepte2,back6)
				screen:print(180+(x+centerx2)*diepte2-10,180+(y-centery2) * diepte2+10,planetna[tel],blue)
				
			end
		end
	end







		screen.waitVblankStart()
		screen:flip()
end

function calc()
	ppi = 3.1415927
	x=0 y=0
	de = de * p1
	sw = td - re - ol
	sw = (sw - math.floor(sw / 360) * 360) * p1
	h = sb * math.sin(de) + cb * math.cos(de) * math.cos(sw)
	h = math.atan(h / math.sqrt(1 - h * h))
	if h >= 0 then 	
		a = (math.sin(de) - sb * math.sin(h)) / (cb * math.cos(h))
		if math.abs(a) >= 1 then a = a * .9998 end
		a = ppi / 2 - math.atan(a / math.sqrt(1 - a * a))
		if sw < ppi then a = -a end
		r = 99 - h * 198 / ppi
		w = -a - ppi / 2
		x = math.floor(math.cos(w) * r * 1.1 + 159.5)
		y = math.floor(math.sin(w) * r * 2 + 199.5)
		x = (2 * x) * .58 + 45
		y = y * .58 + 20
		end
end

function posplan()	
		screen:clear()
		screen:print(120,135,"Wait a second for calculation",red)
		screen.flip()
		screen:clear()	
		yy=Date.year
		mm=Date.month
		da=Date.day
		hh=00
		mi=00
		calcjd()
		calccd()
		calcstg()
		screen:print(0,0,"Position of the planets (ET)",red)
		screen:print(0,10,cd,red)
		screen:pixel(240,135, white)
		drawcircle(screen,240,135, 5, yellow)
		drawcircle(screen,240,135, 30, white)
		drawcircle(screen,240,135, 50, white)
		drawcircle(screen,240,135, 70, white)
		drawcircle(screen,240,135, 90, white)
		drawcircle(screen,240,135, 130, white)
	
		t = (jd - 2415020) / 36525
		pl = "Earth" ra = td * 15 str = 70 poscircle()
		mer()
		ra = l str = 30 poscircle()
		ven()
		ra = l str = 50 poscircle()
		mar()
		ra = l str = 90 poscircle()
		jup()
		ra = l str = 130 poscircle()
		sat()
		ra = l str = 130 poscircle()
		ura()
		ra = l str = 130 poscircle()
		nep()
		ra = l str = 130 poscircle()
		plu()
		ra = l str = 130 poscircle()
		screen.waitVblankStart()
		screen.flip()
	
	while not pad:circle() do
		pad = Controls.read()
	end
end

function planmov()			-- movements of the planets in 1 year
		screen:clear()
		screen:print(120,135,"Wait a second for calculation",red)
		screen.flip()
		screen:clear()	
		yy=Date.year
		mm=1
		da=1
		hh=0
		mi=0
		calcjd()
		calccd()
		calcstg()
		screen:drawLine(20,45,380,45,white)
		screen:drawLine(20,225,380,225,white)
		screen:drawLine(380,45,380,225,white)
		screen:drawLine(20,45,20,225,white)

		screen:print(20,30,"The planets movement in "..yy,red)	
		file = io.open("data/stars.txt","r")
			for kkk = 1,286 do	
				pl = file:read("*l")
				re = file:read("*l")
				de = file:read("*l")		
				pl = ""
				screen:pixel(re+20,135-de,white)
			end
		file:close() 
		screen:print(390,50,"Mercury",yellow)
		screen:print(390,60,"Venus",blue)
		screen:print(390,70,"Mars",red)
		screen:print(390,80,"Jupiter",white)
		screen:print(390,90,"Saturn",green)


		for hpp = 1, 365 do
			t = (jd - 2415020) / 36525
			mer() calcelements() screen:pixel(ra * 15 + 20,135-de,yellow)
			ven() calcelements() screen:pixel(ra * 15 + 20,135-de,blue)
			mar() calcelements() screen:pixel(ra * 15 + 20,135-de,red)
			jup() calcelements() screen:pixel(ra * 15 + 20,135-de,white)
			sat() calcelements() screen:pixel(ra * 15 + 20,135-de,green)
			jd = jd + 1
		end
		screen.waitVblankStart()
		screen.flip()
	while not pad:circle() do
		pad = Controls.read()
	end


end

function graph3d()
		screen:clear()
		screen:print(120,135,"Wait a second for calculation",red)
		screen.flip()				
		screen:clear()
		yy=Date.year
		mm=1
		da=1
		hh=0
		mi=0
		calcjd()
		calccd()
		calcstg()
				
		for hpp = 1, 365 do
			t = (jd - 2415020) / 36525
			mer() calcelements()
			xh = r1 * (math.cos(o / pi) * math.cos((vvk + w) / pi) - math.sin(o / pi) * math.sin((vvk + w) / pi) * math.cos(i / pi))
			yh = r1 * (math.sin(o / pi) * math.cos((vvk + w) / pi) + math.cos(o / pi) * math.sin((vvk + w) / pi) * math.cos(i / pi))
			zh = r1 * (math.sin((vvk + w) / pi) * math.sin(i / pi))
			mercx[hpp]= math.floor(xh * 60)
			mercy[hpp]= math.floor(yh * 60)
			mercz[hpp]= math.floor(zh * 60)
			
			ven() calcelements()
			xh = r1 * (math.cos(o / pi) * math.cos((vvk + w) / pi) - math.sin(o / pi) * math.sin((vvk + w) / pi) * math.cos(i / pi))
			yh = r1 * (math.sin(o / pi) * math.cos((vvk + w) / pi) + math.cos(o / pi) * math.sin((vvk + w) / pi) * math.cos(i / pi))
			zh = r1 * (math.sin((vvk + w) / pi) * math.sin(i / pi))
			venux[hpp]= math.floor(xh * 60)
			venuy[hpp]= math.floor(yh * 60)
			venuz[hpp]= math.floor(zh * 60)
			
			mar() calcelements()
			xh = r1 * (math.cos(o / pi) * math.cos((vvk + w) / pi) - math.sin(o / pi) * math.sin((vvk + w) / pi) * math.cos(i / pi))
			yh = r1 * (math.sin(o / pi) * math.cos((vvk + w) / pi) + math.cos(o / pi) * math.sin((vvk + w) / pi) * math.cos(i / pi))
			zh = r1 * (math.sin((vvk + w) / pi) * math.sin(i / pi))
			marsx[hpp]= math.floor(xh * 60)
			marsy[hpp]= math.floor(yh * 60)
			marsz[hpp]= math.floor(zh * 60)
			
			calcsun()
			xh = r * math.cos((v + td) / pi)
			yh = r * math.sin((v + td) / pi)
			zh = 0
			eartx[hpp]= math.floor(xh * 60)
			earty[hpp]= math.floor(yh * 60)
			eartz[hpp]= math.floor(zh * 60)

			calccd()
			jdvar[hpp] = cd

			jd = jd + 1
		end
		calcjd()
		dofile("./System/script3d.lua") 
end


pad = Controls.read()

credits()
-- Main menu
while true do
	pad = Controls.read()

	if pad:right()  then
	   	kop=kop+1
		regel=1
	end
	if pad:left()  then
	   	kop=kop-1
		regel=1
	end
	if pad:down()  then
	   	regel=regel+1
	end
	if pad:up()  then
	   	regel=regel-1
	end

	if kop < 1 then 
		kop=1 
	end
	if kop > telkop then 
		kop=telkop	
	end
	if regel<1 then
		regel=1
	end
	if regel> Menu[kop].aantal then
		regel=Menu[kop].aantal
	end
	screen.waitVblankStart()
	screen.flip()
	startmenu=kop*100+regel	
	if pad:cross() then
		if startmenu == 101 then credits() end
		if startmenu == 102 then nbol() end
		if startmenu == 103 then datum() end	
		if startmenu == 104 then end	
		if startmenu == 105 then System.Quit() end
		if startmenu == 201 then cdjd() end	
		if startmenu == 202 then etut() end
		if startmenu == 203 then utstg() end
		if startmenu == 204 then easter() end
		if startmenu == 301 then sun() end
		if startmenu == 302 then moon() end
		if startmenu > 302 and startmenu < 311 then elements() end
		if startmenu == 311 then minorplan() end
		if startmenu == 312 then comet() end
		if startmenu == 401 then peraph() end	
		if startmenu == 402 then eclips() end
		if startmenu == 403 then suneclips() end
		if startmenu == 404 then moonphase() end
		if startmenu == 405 then moonjup() end
		if startmenu == 406 then moonsat() end 
		if startmenu == 407 then equinox() end
		if startmenu == 501 then starchart() end
		if startmenu == 502 then posplan() end
		if startmenu == 503 then planmov() end
		if startmenu == 504 then graph3d() end	
	end
	for a=1,40000 do end	-- slow down menu
	menu()
end 