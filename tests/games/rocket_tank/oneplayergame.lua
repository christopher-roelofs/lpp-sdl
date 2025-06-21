OnePlayer = {}

function OnePlayer:render()
  if(leftTank.hp>0) then
  	joyX, joyY = Controls.readRightAnalog()
  	if(range(joyX-128,joyY-128)>deadzone) then
  		leftTank.gunFacing = math.atan(joyY-128, joyX-128) - math.atan(-1, 0)
  	end
  	joyX, joyY = Controls.readLeftAnalog()
  	if(range(joyX-128,joyY-128)>deadzone)then
  		leftTank.tankFacing = math.atan(joyY-128, joyX-128) - math.atan(-1, 0)
  		leftTank.x = leftTank.x + math.sin(leftTank.tankFacing)*range(joyX-128,joyY-128)/100
  		leftTank.y = leftTank.y - math.cos(leftTank.tankFacing)*range(joyX-128,joyY-128)/100
  	end

		if Controls.check(Controls.read(), SCE_CTRL_RTRIGGER) then
			leftTank:shoot()
		end

	end

  if Controls.check(Controls.read(), SCE_CTRL_LEFT) then
    leftTank:newColor()
  end

	if Controls.check(Controls.read(), SCE_CTRL_SELECT) then
    leftTank.y = 262
    rightTank.y = 262
    leftTank.x = 245
    rightTank.x = 900-200
		leftTank.hp = 500
		rightTank.hp = 500
    rightTank:newColor()
    --5 second cooldown before he starts shooting
    rightTank.bullet.lifetime = 60*5
	end
	leftTank.bullet:update()
	rightTank.bullet:update()

	-- 960x544 #PongPhysics will replace with actual AI when I can figure out what on earth that class structure is
if(rightTank.hp>0)then
	spin = spin - 0.1
	rightTank.x = rightTank.x + enemy.xv
	rightTank.y = rightTank.y + enemy.yv
  rightTank.gunFacing = lookAt(rightTank.x,rightTank.y,leftTank.x,leftTank.y)
  rightTank.tankFacing = lookAt(rightTank.x,rightTank.y,rightTank.x+enemy.xv,rightTank.y+enemy.yv)
  if(leftTank.hp>0)then
    if(rightTank.bullet.active == false)then
      --difficulty
      rightTank.gunFacing = rightTank.gunFacing-math.random()/4
      rightTank.gunFacing = rightTank.gunFacing+math.random()/4
    end
    rightTank:shoot()
  end
	if(math.random()>0.7) then
		if(rightTank.x > 960 or rightTank.x < 0 or rightTank.y > 544 or rightTank.y < 0 ) then
			if(rightTank.x>leftTank.x) then
				enemy.xv = -1+math.random()
			else
				enemy.xv = 1+math.random()
			end
			if(enemy.y>leftTank.y) then
				enemy.yv = -1+math.random()
			else
				enemy.yv = 1+math.random()
			end
		end
	else
		if(rightTank.x > 960) then
			enemy.xv = -1
		end
		if(rightTank.x < 0) then
			enemy.xv = 1
		end
		if(rightTank.y > 544) then
			enemy.yv = -1
		end
		if(rightTank.y < 0) then
			enemy.yv = 1
		end
	end

end
	if(distance(rightTank.x,rightTank.y,leftTank.bullet.x,leftTank.bullet.y)<=64 and leftTank.bullet.active)then
		rightTank.hp = rightTank.hp - 100
		leftTank.bullet.x = -5000
		if(rightTank.hp<=0)then
			playSound(Sound.openWav("resources/explode.wav"))
		else
			playSound(Sound.openWav("resources/impact.wav"))
		end
	end
	if(distance(leftTank.x,leftTank.y,rightTank.bullet.x,rightTank.bullet.y)<=64 and rightTank.bullet.active)then
		leftTank.hp = leftTank.hp - 100
		rightTank.bullet.x = -5000
		if(leftTank.hp<=0)then
      playSound(Sound.openWav("resources/explode.wav"))
		else
			playSound(Sound.openWav("resources/impact.wav"))
		end
	end

	--Graphics.drawScaleImage(x,y,block,joyX/128,joyY/128,red)
	floor(-9.0,-3.0)
	leftTank:draw()
	rightTank:draw()
	Graphics.drawImage(0,0,overlay)
	Graphics.debugPrint(5, 5, "Third release c: Defeat the other tank! Press Select to reset Start to reurn to main menu", red)
	Graphics.debugPrint(5, 30, "Enemies Healh "..rightTank.hp, red)
end
