v=1.3
System.setCpuSpeed(444)
fnt = Font.load("data/font.ttf")
Sound.init()
pSound = Sound.openOgg("data/sfx_point.ogg")
pSounds={pSound,pSound,pSound}
wSound = Sound.openOgg("data/sfx_wing.ogg")
wSounds={wSound,wSound,wSound,wSound,wSound}
hSound = Sound.openOgg("data/sfx_hit.ogg")
hSounds={hSound,hSound}
dSound = Sound.openOgg("data/sfx_hit.ogg")
swooshSound = Sound.openOgg("data/sfx_swooshing.ogg")
o1 = Graphics.loadImage("data/obst.png");
o2 = Graphics.loadImage("data/obst2.png");
bgImg = Graphics.loadImage("data/bg.jpg");
getReadyImg = Graphics.loadImage("data/getReady.png");
flppyBirdImg = Graphics.loadImage("data/flppyBird.png");
gameOverImg = Graphics.loadImage("data/gameOver.png");
tapToFlyImg  = Graphics.loadImage("data/tapFly.png");
batteryImg  = Graphics.loadImage("data/battery.png");
batteryChargeImg  = Graphics.loadImage("data/batteryCharge.png");
--endPanelImg = Graphics.loadImage("data/endPanel.png");
tapToStartImg  = Graphics.loadImage("data/taptostart.png");
RtriggerImg  = Graphics.loadImage("data/RTRIGGER.png");
bestScoreImg = Graphics.loadImage("data/bestscore.png");
newBestScoreImg = Graphics.loadImage("data/newbestscore.png");
groundImg = Graphics.loadImage("data/ground.jpg");
_playerImg = {Graphics.loadImage("data/player.png"),Graphics.loadImage("data/player1.png"),Graphics.loadImage("data/player2.png")};
img=1
imgTime=0
obstX={-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100}
passDist={50,50,50,50,50,50,50,50,50,50,50,50}
obstY={300,300,300,300,300,300,300,300,300,300,300,300}
groundX={0,336,672,1008,1344}
persoPosX = 350
persoPosY = 272
fallSpeed = 0;
gravity = 0
gravityMax = 0.9
jumpSpeed = -12
maxFallSpeed = 20
speed = 3
maxSpeed=3
dead=false
spawnObstTime=0;
obstPassed=0
persoRot=0
--getImageHeight
lastYobst=0
points=0
lastObst=0
startedGame=false
upFly=0
upF=true
deadTime=50
justStarted=true
newScore=false
saved=false
rearEnabled=false
function TextDraw(tFont,tTextSize,tX,tY,midle,tText,tColor,tOutline,tSizeOut,tColorOut)
	Font.setPixelSizes(tFont,tTextSize) 
	scoreLenght=0
	if midle then
		for w in string.gmatch(tText, ".") do 
				scoreLenght=scoreLenght+1
		end
		scoreLenght=(scoreLenght*tTextSize*0.5)/2
	end
	if tOutline then
		Font.print(tFont, tX+tSizeOut-scoreLenght, tY, ""..tText, tColorOut) 
		Font.print(tFont, tX-tSizeOut-scoreLenght, tY, ""..tText, tColorOut) 
		Font.print(tFont, tX-scoreLenght, tY+tSizeOut, ""..tText, tColorOut) 
		Font.print(tFont, tX-scoreLenght, tY-tSizeOut, ""..tText, tColorOut) 
		
		Font.print(tFont, tX+tSizeOut-scoreLenght, tY+tSizeOut, ""..tText, tColorOut) 
		Font.print(tFont, tX-tSizeOut-scoreLenght, tY+tSizeOut, ""..tText, tColorOut) 
		Font.print(tFont, tX+tSizeOut-scoreLenght, tY-tSizeOut, ""..tText, tColorOut) 
		Font.print(tFont, tX-tSizeOut-scoreLenght, tY-tSizeOut, ""..tText, tColorOut) 
	end
	Font.print(tFont, tX-scoreLenght, tY, ""..tText, tColor) 
end
function jump ()
	if dead==false and startedGame and persoPosY>0 then
		fallSpeed = jumpSpeed
		persoRot=-0.5
		gravity=0
		for s=1,5 do
			if wSounds[s]==nil then
				wSounds[s] = Sound.openOgg("data/sfx_wing.ogg")
				Sound.play(wSounds[s],NOLOOP)
				break
			end
		end
	end
end
function spawnObst(p,o)
	obstPassed=obstPassed+1
	for i=1,#obstX do
		if obstX[i]<=-80 then
			obstX[i]=1000
			if p==0 then
				passDist[i]=math.random(170,171)
			elseif p==1 then
				passDist[i]=math.random(150,200)
			elseif p==2 then
				passDist[i]=math.random(170,171)
			end
			
			if o==0 then
				obstY[i]=math.random(130,370)
			elseif o==1 then
				obstY[i]=math.random(160,340)
			elseif o==2 then
				obstY[i]=math.random(lastYobst-20,lastYobst+20)
				if obstY[i]<140 then
					obstY[i]=140
				elseif obstY[i]>360 then
					obstY[i]=360
				end
			end
			lastYobst=obstY[i]
			break
		end
	end
end
function obstCollision(x,y)
	  pColX1=persoPosX-25
	  pColX2=persoPosX+25
	  pColY1=persoPosY-25
	  pColY2=persoPosY+25
	if (pColX1>x and pColX1<x+80 and  (pColY1>y and pColY1<y+400 or pColY2>y and pColY2<y+400)) or 
	(pColX2>x and pColX2<x+80 and  (pColY1>y and pColY1<y+400 or pColY2>y and pColY2<y+400)) or 
	(pColX1>x and pColX1<x+80 and  (pColY1>y and pColY1<y+400 or pColY2>y and pColY2<y+400)) or
	(pColX2>x and pColX2<x+80 and  (pColY1>y and pColY1<y+400 or pColY2>y and pColY2<y+400)) then
		dead=true
		fallSpeed=0
		hitCollision()
	end
end
function hitCollision()
	for s=1,2 do
		if hSounds[s]==nil then
			hSounds[s] = Sound.openOgg("data/sfx_hit.ogg")
			Sound.play(hSounds[s],NOLOOP)
			break
		end
	end
	--dat = io.open("data/dat.txt",FRDWR)
	--bestScore = io.read(dat,2) 
	--bS = tonumber(""..bestScore)
	--if bS and bS<points then
	--	io.write(dat,""..points, 2) 
	--elseif bS==nil then
	--io.write(dat,""..points, 2) 
	--end
end
function restart()
	startedGame=false
	persoPosY=272
	persoRot=0
	speed=3
	maxSpeed=3
	obstPassed=0
	spawnObstTime=0
	gravity=0
	fallSpeed=0
	lastObst=0
	points=0
	upF=true
	upFly=0
	deadTime=50
	saved=false
	for i=1,#obstX do
		obstX[i]=-80
	end
	dead=false
end
while true do
	if justStarted then
		restart()
		justStarted=false
		bestScore=0
		if not System.doesFileExist("data/flppyBird")  then
			System.createDirectory("data/flppyBird") 
		end
		scripts = System.listDirectory("data/flppyBird/")
		for j, file in pairs(scripts) do
			if ".score"==string.match(file.name, '%.score-$') then
				bestScore = tonumber(string.match(file.name, '%d+'))
				break
			end
		end
	end
	if dSound and not Sound.isPlaying(dSound) then
		Sound.close(dSound)
		dSound=nil
	end
	if swooshSound and not Sound.isPlaying(swooshSound) then
		Sound.close(swooshSound)
		swooshSound=nil
	end
	for i=1,3 do
		if pSounds[i] and not Sound.isPlaying(pSounds[i]) then
			Sound.close(pSounds[i])
			pSounds[i]=nil
		end
	end
	for i=1,2 do
		if hSounds[i] and not Sound.isPlaying(hSounds[i]) then
			Sound.close(hSounds[i])
			hSounds[i]=nil
		end
	end
	for i=1,5 do
		if wSounds[i] and not Sound.isPlaying(wSounds[i]) then
			Sound.close(wSounds[i])
			wSounds[i]=nil
		end
	end
	Graphics.initBlend()
	Screen.clear()
	Graphics.drawImage(0, 0, bgImg)
	Graphics.drawImage(288, 0, bgImg)
	Graphics.drawImage(576, 0, bgImg)
	Graphics.drawImage(862, 0, bgImg)
	for i=1,#obstX do
		y1=obstY[i]+passDist[i]/2
		y2=obstY[i]-400-passDist[i]/2
		if obstX[i]>-80 then
			Graphics.drawImage(obstX[i], y1, o1)
			Graphics.drawImage(obstX[i], y2, o2)
		end
		if dead==false then
			if persoPosX>obstX[i]+80 and persoPosX<obstX[i]+100 and lastObst~=i then
				lastObst=i
				points=points+1
				for s=1,3 do
					if pSounds[s]==nil then
						pSounds[s] = Sound.openOgg("data/sfx_point.ogg")
						Sound.play(pSounds[s],NOLOOP)
						break
					end
				end
			end
			if obstX[i]>-80 then
				obstX[i]=obstX[i]-speed
				obstCollision(obstX[i],y1)
				obstCollision(obstX[i],y2)
			end
		end
	end
	for i=1,#groundX do
		Graphics.drawImage(groundX[i], 500, groundImg)
		if dead==false then
			groundX[i]=groundX[i]-speed
		end
		if groundX[i]<=-336 then
			groundX[i]=(#groundX-1)*336-2
		end
	end
	Graphics.drawRotateImage(persoPosX, persoPosY,persoRot, _playerImg[img])
	if startedGame==false then
		TextDraw(fnt,90,480,-120,true,bestScore,Color.new(255,255,255),true,5,Color.new(70,70,70))
		TextDraw(fnt,20,10,-20,false,"By Gambikules  v"..v,Color.new(255,255,255),true,1,Color.new(0,0,0))
		Graphics.drawRotateImage(480, 160,0, flppyBirdImg)
		Graphics.drawRotateImage(480, 250,0, getReadyImg)
		Graphics.drawRotateImage(480, 370,0, tapToFlyImg)
		batteryPower = System.getBatteryPercentage() 
		if batteryPower and batteryPower>0 then
			Graphics.fillRect(948-36*(batteryPower/100), 948, 10, 30, Color.new(0,255,0))
			Graphics.drawRotateImage(928, 20,0, batteryImg)
			 if System.isBatteryCharging() then
				Graphics.drawRotateImage(928, 20,0, batteryChargeImg)
			 end 
			TextDraw(fnt,22,932, 6,true,math.floor (batteryPower).."%",Color.new(255,255,255),true,1,Color.new(0,0,0))
		end
		Graphics.drawImage(5, 460, RtriggerImg)
		if  rearEnabled then
			TextDraw(fnt,25,75,435,false,"Rear touch pad  Enabled",Color.new(250,250,250),true,1,Color.new(70,70,70))
		else
			TextDraw(fnt,25,75,435,false,"Rear touch pad  Disabled",Color.new(230,230,230),true,1,Color.new(70,70,70))
		end
	else
		TextDraw(fnt,90,480,-120,true,points,Color.new(255,255,255),true,5,Color.new(70,70,70))
		if dead then
			deadTime=deadTime-1
			if deadTime>27 and deadTime<30 and dSound==nil then
				dSound = Sound.openOgg("data/sfx_die.ogg")
				Sound.play(dSound,NOLOOP)
			end
			if deadTime<=0 then
				if not saved then
					newScore=false
					if bestScore<points then
						bS="data/flppyBird/"..bestScore..".score"
						NbS="data/flppyBird/"..points..".score"
						System.deleteDirectory(bS) 
						System.createDirectory(NbS) 
						bestScore=points		
						newScore=true
					end
					saved=true
				end
				if deadTime>-5 and swooshSound==nil then
					swooshSound = Sound.openOgg("data/sfx_swooshing.ogg")
					Sound.play(swooshSound,NOLOOP)
				end
				Graphics.drawRotateImage(480, 200,0, gameOverImg)
				Graphics.drawRotateImage(480, 280,0, tapToStartImg)
				if not newScore then
					Graphics.drawRotateImage(480, 350,0, bestScoreImg)
				else
					Graphics.drawRotateImage(480, 350,0, newBestScoreImg)
				end
				TextDraw(fnt,80,480,270,true,bestScore,Color.new(255,255,255),true,4,Color.new(70,70,70))
			end
		end
	end
	Graphics.termBlend()

	x1,y1,x2,y2 = Controls.readTouch() 
	if not x1 and not y1 and rearEnabled then
		x1,y1,x2,y2 = Controls.readRetroTouch()
	end
	pad = Controls.read()
	
	if y1 and x1 then
		TouchX=x1
		TouchY=y1
		if touched==false then
			jump ()
			touched=true
		end
	else
		if touched then
			click=true
		end
		touched=false
	end
	if startedGame then
		if Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS) then
			jump ()
		end
		if Controls.check(pad, SCE_CTRL_START) and not Controls.check(oldpad, SCE_CTRL_START) then
			restart()
		end
		if dead==false then
			spawnObstTime=spawnObstTime-1
			if spawnObstTime<0 then
				if obstPassed<20 then
					spawnObstTime=100
					spawnObst(0,0)
				elseif obstPassed>=20 and obstPassed<40 then
					spawnObstTime=80
					spawnObst(1,1)
				elseif obstPassed>=40 and obstPassed<60 then
					spawnObstTime=80
					spawnObst(1,2)
				elseif obstPassed>=60 and obstPassed<80 then
					spawnObstTime=40
					spawnObst(2,2)
				elseif obstPassed>=80 and obstPassed<100  then
					spawnObstTime=65
					spawnObst(2,1)
				elseif obstPassed>=100 then
					spawnObstTime=35
					spawnObst(2,2)
				end
			end
		end
		if dead and (click or (Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS))) and deadTime<=0 then
			restart()
			click=false
		end
		persoPosY=persoPosY+fallSpeed
		if persoPosY>480 then
			persoPosY=480
			if dead==false then
				dead=true
				fallSpeed=0
				hitCollision()
			end
		end
		if fallSpeed<0 then
			fallSpeed=fallSpeed+1.0
		else
			if persoRot<1.5 then
				persoRot=persoRot+0.08
			end
			if(fallSpeed<maxFallSpeed)then
				fallSpeed=fallSpeed+gravity
			end
			if gravity<gravityMax then
				gravity=gravity+0.005+gravity
			end
		end
	else
		persoRot=0
		if click or (Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS)) then
			startedGame=true
			jump()
		end
		if upF then
			if upFly<-2 then
				upF=false
			end
			upFly=upFly-0.25
		else
			if upFly>2 then
				upF=true
			end
			upFly=upFly+0.25
		end
		persoPosY=persoPosY+upFly
		if Controls.check(pad, SCE_CTRL_RTRIGGER) and not Controls.check(oldpad, SCE_CTRL_RTRIGGER) then
			rearEnabled = not rearEnabled
		end
	end
	if dead==false then
		imgTime=imgTime+1
		if imgTime>10 then
			img=img+1
			if img>#_playerImg then
				img=1
			end
			imgTime=0
		end
	end
	if click then
		click=false
	end
	oldpad = pad
	Screen.flip()
end