TwoPlayer = {}

-- Main loop
function TwoPlayer:render()
	--LEFT TANK CONTROLS
	if(leftTank.hp>0) then
		if Controls.check(Controls.read(), SCE_CTRL_UP) then
			leftTank.gunFacing = leftTank.gunFacing - 0.03
		end
		if Controls.check(Controls.read(), SCE_CTRL_DOWN) then
			leftTank.gunFacing = leftTank.gunFacing + 0.03
		end
			joyX, joyY = Controls.readLeftAnalog()
			if(range(joyX-128,joyY-128)>deadzone)then
				leftTank.tankFacing = math.atan(joyY-128, joyX-128) - math.atan(-1, 0)
				leftTank.x = leftTank.x + math.sin(leftTank.tankFacing)*range(joyX-128,joyY-128)/100
				leftTank.y = leftTank.y - math.cos(leftTank.tankFacing)*range(joyX-128,joyY-128)/100
			end

		if Controls.check(Controls.read(), SCE_CTRL_RIGHT) then
			leftTank:shoot()
		end

		if Controls.check(Controls.read(), SCE_CTRL_LEFT) then
			leftTank:newColor()
		end
	end
	--RIGHT TANK
	if(rightTank.hp>0) then
		if Controls.check(Controls.read(), SCE_CTRL_TRIANGLE) then
			rightTank.gunFacing = rightTank.gunFacing + 0.03
		end
		if Controls.check(Controls.read(), SCE_CTRL_CROSS) then
			rightTank.gunFacing = rightTank.gunFacing - 0.03
		end
			joyX, joyY = Controls.readRightAnalog()
			if(range(joyX-128,joyY-128)>deadzone)then
				rightTank.tankFacing = math.atan(joyY-128, joyX-128) - math.atan(-1, 0)
				rightTank.x = rightTank.x + math.sin(rightTank.tankFacing)*range(joyX-128,joyY-128)/100
				rightTank.y = rightTank.y - math.cos(rightTank.tankFacing)*range(joyX-128,joyY-128)/100
			end

		if Controls.check(Controls.read(), SCE_CTRL_SQUARE) then
			rightTank:shoot()
		end
		if Controls.check(Controls.read(), SCE_CTRL_CIRCLE) then
			rightTank:newColor()
		end
	end

	if Controls.check(Controls.read(), SCE_CTRL_SELECT) then
    leftTank.y = 262
    rightTank.y = 262
    leftTank.x = 245
    rightTank.x = 900-200
    leftTank.hp = 500
    rightTank.hp = 500
    enemy.hp = 0
		enemy.x = -5000
		leftTank.hp = 500
		rightTank.hp = 500
	end
	leftTank.bullet:update()
	rightTank.bullet:update()

	-- 960x544 #PongPhysics will replace with actual AI when I can figure out what on earth that class structure is
if(enemy.hp>0)then
	spin = spin - 0.1
	enemy.x = enemy.x + enemy.xv
	enemy.y = enemy.y + enemy.yv
	if(math.random()>0.7) then
		if(enemy.x > 960 or enemy.x < 0 or enemy.y > 544 or enemy.y < 0 ) then
			if(enemy.x>leftTank.x) then
				enemy.xv = -2+math.random()
			else
				enemy.xv = 2+math.random()
			end
			if(enemy.y>leftTank.y) then
				enemy.yv = -2+math.random()
			else
				enemy.yv = 2+math.random()
			end
		end
	else
		if(enemy.x > 960) then
			enemy.xv = -2
		end
		if(enemy.x < 0) then
			enemy.xv = 2
		end
		if(enemy.y > 544) then
			enemy.yv = -2
		end
		if(enemy.y < 0) then
			enemy.yv = 2
		end
	end
	--will turn into a for loop when i dont have a few days to finish a game
	if(distance(enemy.x,enemy.y,leftTank.x,leftTank.y)<=64)then
		leftTank.hp = leftTank.hp - 2
	end
	if(distance(enemy.x,enemy.y,leftTank.bullet.x,leftTank.bullet.y)<=64 and leftTank.bullet.active)then
		enemy.hp = enemy.hp - 100
		leftTank.bullet.x = -5000
    playSound(explode)
	end
	if(distance(enemy.x,enemy.y,rightTank.x,rightTank.y)<=64)then
		rightTank.hp = rightTank.hp - 2
	end
	if(distance(enemy.x,enemy.y,rightTank.bullet.x,rightTank.bullet.y)<=64 and rightTank.bullet.active)then
		enemy.hp = enemy.hp - 100
		rightTank.bullet.x = -5000
    playSound(impact)
	end
end
	if(distance(rightTank.x,rightTank.y,leftTank.bullet.x,leftTank.bullet.y)<=64 and leftTank.bullet.active)then
		rightTank.hp = rightTank.hp - 100
		leftTank.bullet.x = -5000
		if(rightTank.hp<=0)then
      playSound(explode)
		else
			playSound(impact)
		end
	end
	if(distance(leftTank.x,leftTank.y,rightTank.bullet.x,rightTank.bullet.y)<=64 and rightTank.bullet.active)then
		leftTank.hp = leftTank.hp - 100
		rightTank.bullet.x = -5000
		if(leftTank.hp<=0)then
      playSound(explode)
		else
			playSound(impact)
		end
	end

	--Graphics.drawScaleImage(x,y,block,joyX/128,joyY/128,red)
	leftTank:draw()
	rightTank:draw()
	Graphics.drawRotateImage(enemy.x,enemy.y,enemy.sprite,spin)
	Graphics.drawImage(0,0,overlay)
	Graphics.debugPrint(5, 5, "Second release c: Press select to kill the enemy for a 1v1 or work together to defeat it. Press start to return to menu", red)
	Graphics.debugPrint(5, 30, "Enemies Healh "..enemy.hp, red)
end
