-- Create a new color
System.setCpuSpeed(444)
talajkep = Graphics.loadImage("app0:/talaj.jpg")
talajkepjobb = Graphics.loadImage("app0:/talajj.jpg")
gagyi = Graphics.loadImage("app0:/gagyi.png")
chari = Graphics.loadImage("app0:/Char.png")
charif = Graphics.loadImage("app0:/Charf.png")
again = Graphics.loadImage("app0:/again.png")
platform = Graphics.loadImage("app0:/patform.png")
flag = Graphics.loadImage("app0:/flag.png")
flagbot = Graphics.loadImage("app0:/flagpalca.png")
cactus = Graphics.loadImage("app0:/cactus.png")
hatter = Graphics.loadImage("app0:/hatter.jpg")
lava = Graphics.loadImage("app0:/lava.png")
ver = Graphics.loadImage("app0:/ver.png")
font = Font.load("app0:/font.ttf")
white = Color.new(0,0,0) 
xp = 1
yp = 60
gts=0
jobbx = 945
jobby = 1
pocak={}
pocak[1]={1100,240,100,1,0}
pocak[2]={1800,240,100,2,0}
fps=0
stimer=0
timer=Timer.new()
mx=100
cm=100
cym=270
ptfrek=1
ptx_mogz=0
kamerx=0
num=0
alap=2
jump=0
pnum=0
draw=1
endekakuk=false
playery_act=true
playerx_act=true
txc=1
txy=1
plyry=0
plyrx2=0
plat=false
ugras=false
refpont=0
-- Main loop
while true do
	
	-- Draw a string on the screen
	Graphics.initBlend()
	Screen.clear()
	--freezer
	if endekakuk==true then
		playery_act=false
		playerx_act=false
	end
	--unfreezer
	if endekakuk==false then
		playery_act=true
		playerx_act=true
	end
	--jobb analog
	if jobbx > 960 then
		jobbx = jobbx-(jobbx-960)
	end
	if jobbx < 0 then
		jobbx = jobbx-jobbx
	end
	if jobby > 544 then
		jobby = jobby-(jobby-544)
	end
	if jobby < 0 then
		jobby = jobby-jobby
	end
	xj,yj = Controls.readRightAnalog()
	if xj > 200 then
		jobbx = jobbx + 10
	end
	if xj < 60 then
		jobbx = jobbx - 10
	end
	if yj > 200 then
		jobby = jobby + 10
	end
	if yj < 60 then
		jobby = jobby - 10
	end
	
	--bal analog
	if xp > 960 then
		xp = xp-(xp-960)
	end
	if xp < 0 then
		xp = xp-xp
	end
	if yp > 544 then
		yp = yp-(yp-544)
	end
	if yp < 0 then
		yp = yp-yp
	end
	--player jobbra-balra mozgás
	x,y = Controls.readLeftAnalog()
	if x > 200 and playerx_act==true then
		xp = xp + 10
		mx=mx+10
		if refpont>=400-130 then
			cm=400-130
			else cm=cm+10
		end
	end
	if x < 60 and playerx_act==true then
		xp = xp - 10
		mx=mx-10
		if refpont>400-130 then
			cm=400-130
			else cm=cm-10
		end
	end
	refpont=cm+kamerx-10
	local reflab=refpont+130
	if y > 200 then
		yp = yp + 10
	end
	if y < 60 then
		yp = yp - 10
	end
	Graphics.drawImage(0-kamerx,0,hatter)
	hx=0
	for k=1,3 do
		hx=hx+960
		Graphics.drawImage(hx-kamerx,0,hatter)
	end
	--fps-meter
	fps=fps+1
	time = Timer.getTime(timer)
	if time-stimer>1000 then
		stimer=time
		gts=fps
		fps=0
	end
	Graphics.debugPrint(5, 15,"FPS:"..gts, white,2)
	tcx,tcy=Controls.readTouch()
	Graphics.drawPixel(jobbx, jobby, Color.new(79,211,211))
	-- Graphics.debugPrint(5, 5, x, white)
	-- Graphics.debugPrint(5, 30, y, white)
	-- Graphics.debugPrint(5, 60, xp, white)
	-- Graphics.debugPrint(5, 85, yp, white)
	-- Graphics.debugPrint(900, 5, xj, white)
	-- Graphics.debugPrint(900, 30, yj, white)
	-- Graphics.debugPrint(900, 60, jobbx, white)
	-- Graphics.debugPrint(900, 85, jobby, white)
	if tcx~=nil then
		Graphics.debugPrint(810, 105, tcx, white)
		Graphics.debugPrint(900, 105, tcy, white)
	end
	Graphics.drawPixel(xp, yp, Color.new(255,0,0))
	Graphics.drawImage(440-kamerx,399,cactus)
	Graphics.drawImage(2300-kamerx,399,cactus)
	Graphics.drawImage(2390-kamerx,399,cactus)
	if finish_erint==true then
		zaszloy=zaszloy-1
		if zaszloy<=240-70-60 then
			zaszloy=240-70-60
		end
		else zaszloy=240-70
	end
	Graphics.drawImage(2520-kamerx,zaszloy,flag)
	Graphics.drawImage(2520-kamerx,240-70,flagbot)
	Graphics.debugPrint(5, 135, reflab, white)
	--Graphics.debugPrint(60, 135, cm, white)
	Graphics.debugPrint(800 , 15, "Test Build531", white)
	plyrx2=cm+130
	plyrx1=cm+33
	plyry=cym+200
	mapx=mx+130
	Graphics.debugPrint(5, 70, "PlayerX: "..plyrx2, white)
	Graphics.debugPrint(5, 100, "PlayerY: "..plyry, white)
	--kamera
	if mapx>400 then
		kamerx=mapx-400
	end
	--növény def
	-- Graphics.drawImage(300-kamerx,365,gagyi)
	-- if cm>=230-kamerx and cm<=340-kamerx and cym>=380-200 then
		-- Graphics.debugPrint(180, 100, "You Died Dude!:(", white,4)
		-- Graphics.drawImage(440,190,again)
		-- --endekakuk=true
		-- noveny_erint=true
		-- else noveny_erint=false
	-- end
	noveny_erint=false
	function novenymaker(nx, ny)
		Graphics.drawImage(nx-kamerx,ny,gagyi)
		if not(platform_erint) and plyrx2>=nx-kamerx and plyrx2<=nx+100+70-kamerx and plyry>=ny+36 then
			Font.setPixelSizes(font,60)
			Graphics.drawImage(0,0,ver)
			Font.print(font, 250, 100, "You Died Dude! :I", Color.new(251,4,4))
			--Graphics.debugPrint(180, 100, "You Died Dude!:(", white,4)
			Graphics.drawImage(440,190,again)
			noveny_erint=true
		end
	end	
	--balra néz
	if x < 60 then
		draw=2
	end
	--talaj érintés def
	if plyrx2>-200-kamerx and plyrx2<1100-kamerx and plyry>=468 or (plyrx2>1970-kamerx and plyrx2<2700-kamerx and plyry>=468) then
		talaj_erint=true
		else talaj_erint=false
	end
	--ugribugri
	if Controls.check(Controls.read(), SCE_CTRL_CROSS) and playery_act==true and (talaj_erint==true or platform_erint==true) then
		ugras=true
		if jump==0 then 
			jump=1
		end
	end
	if jump ==1 then 
		num=num+7
		if num>=133 then
			ugras=false
			num=0
			jump=0
		end
	end
	if num>0 then
		cym=cym-10
	end
	--jobbra néz
	if x > 200 then
		draw=1
	end
	--platform def
	platform_erint=false
	function pmaker(px, py)
		Graphics.drawImage(px-kamerx,py,platform)
		if not(platform_erint) and plyrx2>=px-kamerx and plyrx2<=px+290-kamerx and plyry>=py and plyry<=py+10 then
			platform_erint=true
		end
	end	
	pmaker(600, 340)
	pmaker(610, 150)
	pmaker(840, 240)
	pmaker(1750+650,240)
	novenymaker(830,399)
	novenymaker(2010,399)
	pnum=pnum+2
	if pnum>=100 then
		pnum=0
	end
	--mozgo platform
	for i=1,#pocak do
		local p=pocak[i]
		local ptx_mogz=p[5]
		if pnum<p[3]/2 then
			if p[4]==2 then
			ptx_mogz=ptx_mogz-10
			else ptx_mogz=ptx_mogz+10
			end
		end
		if pnum>=p[3]/2 then
			if p[4]==2 then
			ptx_mogz=ptx_mogz+10
			else ptx_mogz=ptx_mogz-10
			end
		end
		p[5]=ptx_mogz
		Graphics.drawImage(p[1]-kamerx+ptx_mogz,p[2],platform)
		if not(platform_erint) and plyrx2>=p[1]-kamerx+ptx_mogz and plyrx2<=p[1]+290-kamerx+ptx_mogz and plyry>=p[2] and plyry<=p[2]+10 then
			platform_erint=true
		end
	end	
	--esés
	if talaj_erint==false and platform_erint==false and ugras==false and lava_erint==false then
		cym=cym+10
	end
	--lava érintés
	if plyrx2>1100-kamerx and plyrx2<=1970-kamerx and plyry>=650 and plyry<=680 then
		lava_erint=true
		Graphics.drawImage(0,0,ver)
		Font.setPixelSizes(font,60)
		Font.print(font, 250, 100, "You Died Dude! :I", Color.new(251,4,4))
		Graphics.drawImage(440,190,again)
		else lava_erint=false
	end
	if draw==1 then
		Graphics.drawImage(cm,cym,chari)
	end
	if draw==2 then
		Graphics.drawImage(cm,cym,charif)
	end
	if noveny_erint==true or lava_erint==true or finish_erint==true then
		endekakuk=true
	end
	--finish
	if plyrx2>=2500-kamerx and plyrx2<=2600-kamerx and plyry>=230 and plyry<=270 then
		Font.setPixelSizes(font,60)
		Font.print(font, 65, 120, "Wow Dude You're Awesome!", Color.new(255,128,0))
		Graphics.drawImage(440,190,again)
		finish_erint=true
		else finish_erint=false
	end
	local tx=0
	Graphics.drawImage(0-kamerx,469,talajkep)
	for k=1,3 do
		tx=tx+200
		Graphics.drawImage(tx-kamerx,469,talajkep)
	end
	Graphics.drawImage(800-kamerx,469,talajkepjobb)
	local lx=1000
	Graphics.drawImage(1000-kamerx,479,lava)
	for lk=1,6 do
		lx=lx+140
		Graphics.drawImage(lx-kamerx,479,lava)
	end
	local t2x=1970
	Graphics.drawImage(1970-kamerx,469,talajkep)
	for k=1,2 do
		t2x=t2x+200
		Graphics.drawImage(t2x-kamerx,469,talajkep)
	end
	if tcx~=nil and tcx>=410 and tcx<=510 and tcy>=180 and tcy<=250 then
		endekakuk=false
		kamerx=0
		mapx=0
		mx=100
		draw=1
		cm=100
		cym=270
	end

	
	
	--pocak[#pocak+1]={xp,yp}
	--for i=1,#pocak do
	--local p=pocak[i]
	--local ax,ay=p[1],p[2]
	--Graphics.drawPixel(ax, ay, Color.new(255,0,0))
	--end
	Graphics.termBlend()
	
	-- Update screen (For double buffering)
	Screen.flip()
	
	-- Check controls for exiting
	
end