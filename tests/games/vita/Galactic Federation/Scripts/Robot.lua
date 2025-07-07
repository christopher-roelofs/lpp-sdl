Robot = {}
robotImage = Graphics.loadImage("app0:/Sprites/Robot.png");

function Robot:New(x,y)
  robot = {}
  setmetatable(robot, self)
  self.__index = self
  -- Stat related
  robot.health = 150
  robot.maxHealth = 150
  robot.stamina = 150
  robot.maxStamina = 150
  robot.stimPacksHeld = 9
  robot.healthPacksHeld = 9
  robot.itemsHeld = {}
  
  -- Movement Related
  robot.walkSpeed = 5
  robot.sprintSpeed = 8
  robot.isSprinting = false
  robot.x = x
  robot.y = y
  robot.directionFacing = "north"
  robot.verticleDirectionMoving = "none"
  robot.horizontalDirectionMoving = "none"
  
  -- Attack related stuff
  robot.usingSecondaryAttack = false
  robot.primaryAttackTimer = 0
  robot.secondaryAttackTimer = 0
  robot.bulletX = 0
  robot.bulletY = 0
  robot.hand = "left"
  robot.damageTimer = 0
  -- Special attack related
  robot.specialMoveInUse = ""
  robot.specialTimer = 0
  robot.canMove = true
  
  robot.currentFrame = 0
  
  robot.isDead = false
  return robot
end

function Robot:Draw()
  
  if(self.verticleDirectionMoving ~= "none" or self.horizontalDirectionMoving ~= "none") then
    self.currentFrame = self.currentFrame + 1
    if(self.directionFacing == "north") then
      
      if(self.currentFrame >=1 and self.currentFrame <=3) then
        Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 32, 64, 32, 32, 1, 1, robotImage)
      end
      
      if(self.currentFrame >=4 and self.currentFrame<=6) then
      
        Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 0, 64, 32, 32, 1, 1, robotImage)
      end
      
      if(self.currentFrame >=7 and self.currentFrame<=9) then
        Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 32, 96, 32, 32, 1, 1, robotImage)
      end
      
      if(self.currentFrame >=10 and self.currentFrame<=12) then
                Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 0, 64, 32, 32, 1, 1, robotImage)
      end
      
    end
    
    if(self.directionFacing == "south") then
      if(self.currentFrame >=1 and self.currentFrame<=3) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 32, 0, 32, 32, 1, 1, robotImage)
      end
      
      if(self.currentFrame >=4 and self.currentFrame<=6) then
      Graphics.drawImageExtended(self.x - cameraX, self.y  - cameraY, 0, 0, 32, 32, 1, 1, robotImage)

      end
      
      if(self.currentFrame >=7 and self.currentFrame<=9) then
      Graphics.drawImageExtended(self.x - cameraX, self.y  - cameraY, 32, 32, 32, 32, 1, 1, robotImage)
      end
            
      if(self.currentFrame >=10 and self.currentFrame<=12) then
      Graphics.drawImageExtended(self.x - cameraX, self.y  - cameraY, 0, 0, 32, 32, 1, 1, robotImage)
   
      end
    end
    
    if(self.directionFacing == "east") then
      if(self.currentFrame >=1 and self.currentFrame<=3) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 96, 0, 32, 32, 1, 1, robotImage)
      end
      if(self.currentFrame >=4 and self.currentFrame<=6) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 64, 0, 32, 32, 1, 1, robotImage)
      end
      if(self.currentFrame >=7 and self.currentFrame<=9) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 96, 32, 32, 32, 1, 1, robotImage)
      end
      if(self.currentFrame >=10 and self.currentFrame<=12) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 64, 0, 32, 32, 1, 1, robotImage)
      end
    end
    
    if(self.directionFacing == "west") then
      if(self.currentFrame >=1 and self.currentFrame<=3) then
        Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 96, 0, 32, 32, -1, 1, robotImage)
      end
      if(self.currentFrame >=4 and self.currentFrame<=6) then
        Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 64, 0, 32, 32, -1, 1, robotImage)
      end
      if(self.currentFrame >=7 and self.currentFrame<=9) then
        Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 96, 32, 32, 32, -1, 1, robotImage)
      end
      if(self.currentFrame >=10 and self.currentFrame<=12) then
        Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 64, 0, 32, 32, -1, 1, robotImage)
      end
      
    
  end
  
  if(self.currentFrame >= 12) then
  self.currentFrame = 0  
  end
  
  end
  
  
  if(self.verticleDirectionMoving == "none" and self.horizontalDirectionMoving == "none") then
self.currentFrame = 0
    if(self.directionFacing == "north") then
      Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 0, 64, 32, 32, 1, 1, robotImage)
    end
    
    if(self.directionFacing == "south") then
      Graphics.drawImageExtended(self.x - cameraX, self.y  - cameraY, 0, 0, 32, 32, 1, 1, robotImage)
    end
    
    if(self.directionFacing == "east") then
     Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 64, 0, 32, 32, 1, 1, robotImage)

    end
    
    if(self.directionFacing == "west") then
    Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 64, 0, 32, 32, -1, 1, robotImage)
    end
  end
end


function Robot:Move()
  
  if(self.isSprinting == false) then
  
  if(self.verticleDirectionMoving == "north") then
    
    currentWalkSpeed = self:Raycast("north", self.walkSpeed)
    currentWalkSpeed = self:RayCastEnemy("north", currentWalkSpeed)
    
    self.y = self.y - currentWalkSpeed
  end
  
  if(self.verticleDirectionMoving == "south") then
    
    currentWalkSpeed = self:Raycast("south", self.walkSpeed)
    currentWalkSpeed = self:RayCastEnemy("south", currentWalkSpeed)
    self.y = self.y + currentWalkSpeed
  end
  
  if(self.horizontalDirectionMoving == "east") then
    
    currentWalkSpeed = self:Raycast("east", self.walkSpeed)
    currentWalkSpeed = self:RayCastEnemy("east", currentWalkSpeed)
    self.x = self.x + currentWalkSpeed
  end
  
  if(self.horizontalDirectionMoving == "west") then
    
    currentWalkSpeed = self:Raycast("west", self.walkSpeed)
    currentWalkSpeed = self:RayCastEnemy("west", currentWalkSpeed)
    self.x = self.x - currentWalkSpeed
  end
  
  else
  if(self.verticleDirectionMoving == "north") then
    
    currentWalkSpeed = self:Raycast("north", self.sprintSpeed)
     currentWalkSpeed = self:RayCastEnemy("north", currentWalkSpeed)
    self.y = self.y - currentWalkSpeed
  end
  
  if(self.verticleDirectionMoving == "south") then
    
    currentWalkSpeed = self:Raycast("south", self.sprintSpeed)
     currentWalkSpeed = self:RayCastEnemy("south", currentWalkSpeed)
    self.y = self.y + currentWalkSpeed
  end
  
  if(self.horizontalDirectionMoving == "east") then
    
    currentWalkSpeed = self:Raycast("east", self.sprintSpeed)
     currentWalkSpeed = self:RayCastEnemy("east", currentWalkSpeed)
    self.x = self.x + currentWalkSpeed
  end
  
  if(self.horizontalDirectionMoving == "west") then
    
    currentWalkSpeed = self:Raycast("west", self.sprintSpeed)
     currentWalkSpeed = self:RayCastEnemy("west", currentWalkSpeed)
    self.x = self.x - currentWalkSpeed
  end
end

  
end


function Robot:Raycast(direction, speed)
    
    if(direction == "west") then
      
      for i, value in ipairs(collidableObj) do
                
          tileDim = collidableObj[i]:GetDimensions()
        if(self.y < tileDim[4] and self.y + 32 > tileDim[3]) then
        
          if(self.x - speed < tileDim[2] and self.x + 32> tileDim[2]) then
          
          return self.x - tileDim[2]
            
        end
        
        
      end
      
      end
      
      return speed
    end
    
    if(direction == "east") then
      
      for i, value in ipairs(collidableObj) do
 
          tileDim = collidableObj[i]:GetDimensions()
          
        if(self.y < tileDim[4] and self.y + 32 > tileDim[3]) then
        
          if(self.x + 32 + speed > tileDim[1] and self.x <= tileDim[1]) then
          
          return  tileDim[1] - self.x - 32
            
          end       
      end
      
      end
      return speed
    end
    
    if(direction == "north") then
      
      for i, value in ipairs(collidableObj) do
                
     
        tileDim = collidableObj[i]:GetDimensions()
        if(self.x < tileDim[2] and self.x + 32 > tileDim[1]) then
        
        if(self.y - speed < tileDim[4] and self.y >= tileDim[4]) then
        
        return self.y - tileDim[4]
          
        end
        
        
      end
      
      end
      return speed
    end
    
    if(direction == "south") then
      
      for i, value in ipairs(collidableObj) do
       
        
        tileDim = collidableObj[i]:GetDimensions()
        if(self.x < tileDim[2] and self.x + 32 > tileDim[1]) then
        
        if(self.y + 32  + speed > tileDim[3] and self.y <= tileDim[3]) then
        
        return tileDim[3] - self.y -32  
          
        end

        
      end
      
      end
      return speed
    end
    
    
  end
  
  function Robot:RayCastEnemy(direction, speed)
   if(direction == "west") then
      for i, value in ipairs(enemyObj) do      
        
        
          enemyDim = enemyObj[i]:GetDimensions()
      if(self.y < enemyDim[4] and self.y + 32 > enemyDim[3]) then
        
        if(self.x - speed < enemyDim[2] and self.x + 32> enemyDim[2]) then
          
        speed = self.x - enemyDim[2] 
        if(speed <= 0) then
        speed = 0  
        end
        
        end  
      end
      end
    end
    
    if(direction == "east") then
      
      for i, value in ipairs(enemyObj) do

          enemyDim = enemyObj[i]:GetDimensions()
          
        if(self.y < enemyDim[4] and self.y + 32 > enemyDim[3]) then
        
          if(self.x + 32 + speed > enemyDim[1] and self.x <= enemyDim[1]) then
          
          speed = enemyDim[1] - self.x - 32
          if(speed <= 0) then
          speed = 0  
          end
          
          
        end  
      end
      
      end
    end
    
    if(direction == "north") then
      
      for i, value in ipairs(enemyObj) do
        enemyDim = enemyObj[i]:GetDimensions()
        if(self.x < enemyDim[2] and self.x + 32 > enemyDim[1]) then
        
        if(self.y - speed < enemyDim[4] and self.y >= enemyDim[4]) then
        
        speed = self.y - enemyDim[4]
        
        if(speed <= 0) then
        speed = 0  
        end
        
          
        end
        
        end
 
      end
    end
    
    if(direction == "south") then
      
      for i, value in ipairs(enemyObj) do
        enemyDim = enemyObj[i]:GetDimensions()
        if(self.x < enemyDim[2] and self.x + 32 > enemyDim[1]) then
        
        if(self.y + 32  + speed > enemyDim[3] and self.y <= enemyDim[3]) then
        
        speed =  enemyDim[3] - (self.y +32) 
        
        if(speed <= 0) then
        speed = 0  
        end
        
          
        end
        
          
        end
        
        end
      end
      return speed
  end
  
  
function Robot:KeepOnScreen()
  
  if(self.x - cameraX < 0) then
    self.x = cameraX
  end
  
  
  if(self.x - cameraX > 960-32) then
  
  self.x = cameraX + 960 - 32
    
  end
  
  if(self.y - cameraY < 0) then
    
    self.y = cameraY
    
  end
  
  if(self.y - cameraY > 544 - 32 - 80) then
  
  self.y = cameraY + 544 - 32 - 80
end

end



function Robot:CheckMovementLeftStick()
  self.verticleDirectionMoving = "none"
  self.horizontalDirectionMoving = "none"
  
  if(self.canMove == false) then
  return  
  end
  
  
  for i, value in ipairs(controllerObj) do
    
    if(controlType == "a") then
      if(controllerObj[i].leftIsPressed == true) then
        self.directionFacing = "west"
        if(controllerObj[i].rightStickPressed == false) then
        self.horizontalDirectionMoving = "west"
        end
      end
      
      if(controllerObj[i].rightIsPressed == true) then
        self.directionFacing = "east"
        if(controllerObj[i].rightStickPressed == false) then
        self.horizontalDirectionMoving = "east"
        end
      end
      
      if(controllerObj[i].upIsPressed == true) then
        self.directionFacing = "north"
        if(controllerObj[i].rightStickPressed == false) then
        self.verticleDirectionMoving = "north"
        end
      end
      
      if(controllerObj[i].downIsPressed == true) then
      self.directionFacing = "south" 
      if(controllerObj[i].rightStickPressed == false) then
      self.verticleDirectionMoving = "south"
    end
  end
  end
   if(controlType == "b") then
      if(controllerObj[i].leftIsPressed == true) then
       
        self.horizontalDirectionMoving = "west"
        
      end
      
      if(controllerObj[i].rightIsPressed == true) then
        
        self.horizontalDirectionMoving = "east"
      
      end
      
      if(controllerObj[i].upIsPressed == true) then
       
        self.verticleDirectionMoving = "north"
        
      end
      
      if(controllerObj[i].downIsPressed == true) then
      
      self.verticleDirectionMoving = "south"
    
  end
    end
    
  end
end

function Robot:CheckMovementRightStick()
  if(self.canMove == false) then
  return  
  end
  
  
  
  for i, value in ipairs(controllerObj) do
    
    if(controlType == "a") then
    if(controllerObj[i].rightLeftIsPressed == true) then
      self.horizontalDirectionMoving = "west"
    end
    
    if(controllerObj[i].rightRightIsPressed == true) then
      self.horizontalDirectionMoving = "east"
    end
    
    if(controllerObj[i].rightUpIsPressed == true) then
      self.verticleDirectionMoving = "north"
    end
    
    if(controllerObj[i].rightDownIsPressed == true) then
      self.verticleDirectionMoving = "south"
    end
    end
    
    if(controlType == "b") then
    if(controllerObj[i].rightLeftIsPressed == true) then
      self.directionFacing = "west"
    end
    
    if(controllerObj[i].rightRightIsPressed == true) then
      self.directionFacing = "east"
    end
    
    if(controllerObj[i].rightUpIsPressed == true) then
      self.directionFacing= "north"
    end
    
    if(controllerObj[i].rightDownIsPressed == true) then
      self.directionFacing = "south"
    end
    end
    
  end
end

function Robot:CheckSprint()
 
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].circleIsPressed == true) then
      self.isSprinting = true
      
    else
      self.isSprinting = false
      
    end

  end
  
end

function Robot:TakeDamage(damage)
  
  if(self.damageTimer <= 0) then
    self.health = self.health - damage
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(damage),Color.new(255,0,0)))
    self.damageTimer = 25
  end
  

end

function Robot:UpdateDamageTimer()
if(self.damageTimer >0) then
self.damageTimer = self.damageTimer - 1
end

end

function Robot:GroupShield()
  
end


function Robot:GroupHeal()
  
end



function Robot:HealDamage(health)
  self.health = self.health + health
  if(self.health > self.maxHealth) then
  self.health = self.maxHealth  
  end
  
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(health),Color.new(0,255,0)))

end

function Robot:RestoreEnergy(energy)
  self.stamina = self.stamina + energy
  
  if(self.stamina > self.maxStamina) then
  self.stamina = self.maxStamina  
  end
  
  
      table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(energy),Color.new(0,0,255)))

end


function Robot:UseHealthPack()
  if(self.health < self.maxHealth) then
    if(self.healthPacksHeld > 0) then
      self.healthPacksHeld = self.healthPacksHeld - 1
      self:HealDamage(25)
    end
end
  
end

function Robot:UseBattery()
  if(self.stamina < self.maxStamina) then
    if(self.stimPacksHeld > 0) then
    self.stimPacksHeld = self.stimPacksHeld - 1  
    self:RestoreEnergy(25)
    end
  end
end


function Robot:SendItemsToSpecialMenu()
  
  for i, value in ipairs(specialMenuObj) do
  specialMenuObj[i]:UpdateItemsHeld(self.healthPacksHeld, self.stimPacksHeld)
  end
  
end

function Robot:FastMenuOptions()
  
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].padUpIsPressed == true and controllerObj[i].padUpCanBePressed == true) then
      self:UseHealthPack()
    end
    
    if(controllerObj[i].padDownIsPressed == true and controllerObj[i].padDownCanBePressed == true) then
      self:UseBattery()
    end

  end
end

function Robot:UpdateHealthBar()
for i, value in ipairs(healthBarObj )do
  healthBarObj[i]:UpdateValues(self.health, self.maxHealth, self.stamina, self.maxStamina)
  end
end

function Robot:ChangeHand()
  
  if(self.hand == "right") then
    self.hand = "left"
    return
  end
  
  if(self.hand == "left") then
    self.hand = "right"
    return
  end
end

function Robot:SetBulletArea()
  
  if(self.hand == "left") then
    
    if(self.directionFacing == "north") then
      self.bulletX = 4
      self.bulletY = 6
    end
    
    if(self.directionFacing == "south") then
      self.bulletX = 6
      self.bulletY = 16
    end
    
    if(self.directionFacing == "east") then
      self.bulletX = 22
      self.bulletY = 8
    end
    
    if(self.directionFacing == "west") then
      self.bulletX = 8
      self.bulletY = 8
    end
    
    
  end
  
  if(self.hand == "right") then
    
    if(self.directionFacing == "north") then
      self.bulletX = 28
      self.bulletY = 6
    end
    
    if(self.directionFacing == "south") then
      self.bulletX = 28
      self.bulletY = 16
    end
    
    if(self.directionFacing == "east") then
      self.bulletX = 22
      self.bulletY = 8
    end
    
    if(self.directionFacing == "west") then
      self.bulletX = 8
      self.bulletY = 8
    end
    
  end
  
  
end


function Robot:PrimaryAttack()
  for i, value in ipairs(controllerObj) do
    
    if(controllerObj[i].rightTriggerIsPressed == true) then
        
        if(self.primaryAttackTimer <= 0) then
          self:SetBulletArea()
      
          if(self.directionFacing == "north" or self.directionFacing == "south") then
            table.insert(bulletsObj, #bulletsObj + 1, Bullets:New(self.x + self.bulletX,self.y + self.bulletY,self.directionFacing,20, 3, 6, 3, 2))
          end

          if(self.directionFacing == "east" or self.directionFacing == "west") then
            table.insert(bulletsObj, #bulletsObj + 1, Bullets:New(self.x + self.bulletX,self.y + self.bulletY,self.directionFacing,20, 3, 3, 6, 2))
          end
          self:ChangeHand()
          self.primaryAttackTimer = 10
        end
    end
  end


end

function Robot:SecondaryAttack()
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].leftTriggerIsPressed == true) then
      
      if(self.secondaryAttackTimer <= 0) then
        table.insert(bulletsObj, #bulletsObj + 1, HealBeam:New(self.x, self.y, self.directionFacing, self))
        self.secondaryAttackTimer = 30
      
      end
    end
end

  
  
end

function Robot:CheckMiniMap()
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].selectIsPressed == true and controllerObj[i].selectCanBePressed == true) then
    table.insert(miniMapObj, #miniMapObj + 1, MiniMap:New())
    isPaused = true
    end
  end

end


function Robot:CheckPause()
  for i, value in ipairs(controllerObj) do
  
  if(controllerObj[i].startIsPressed == true and controllerObj[i].startCanBePressed == true) then
    
  table.insert(pauseObj, #pauseObj + 1, Pause:New())
  isPaused = true
  
  end
  
  
  end
  
end

function Robot:CheckWorldPosition()
  
  for i, value in ipairs(cameraObj) do
  
  if(self.x - cameraObj[i].x < 250) then
  
  cameraObj[i]:MoveLeft(250 - (self.x - cameraObj[i].x))
    
  end
  
  
  if(self.x - cameraObj[i].x > 710) then
    
    cameraObj[i]:MoveRight((self.x - cameraObj[i].x) - 710)
    
  end
  
  
  if(self.y - cameraObj[i].y < 180) then
    
    cameraObj[i]:MoveUp( 180 - (self.y - cameraObj[i].y))
    
  end
  
  
  if(self.y - cameraObj[i].y > 364) then
    
    cameraObj[i]:MoveDown((self.y - cameraObj[i].y) - 364)
    
  end
  
  cameraObj[i]:GetCameraPosition()
end

  
end

function Robot:UseSpecialMove(moveName)
  
  if(moveName == "group sheild") then
    
  end
  
  
  if(moveName == "group heal") then
    
  end
  
  if(moveName == "group attack boost") then
    
  end
  
  if(moveName == "cure ailments") then
    
  end
  
  if(moveName == "charge shot") then
    
  end
  
  if(moveName == "self heal") then
    
  end
  
  if(moveName == "mass confusion") then
    
  end
  
  
  
end

function Robot:GetDimensions()
  
  return {self.x, self.x + 32, self.y, self.y + 32}
end

function Robot:AddItemToInventory(itemName)
  if(#self.itemsHeld < 144) then
    table.insert(self.itemsHeld, #self.itemsHeld + 1, itemName)
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(cameraX + 5,cameraY + 80, 'Picked up a' .. itemName,Color.new(255,255,255)))
  end
end

function Robot:PickUpItem()
  
  for c = 1, #controllerObj, 1 do
    
      for i = 1, #itemsObj, 1 do
          itemDimension = itemsObj[i]:GetDimensions()
        if(self.x <= itemDimension[2] and self.x + 32 >= itemDimension[1]) then
          if(self.y <= itemDimension[4] and self.y + 32 >= itemDimension[3]) then
            table.insert(textMessageObj, #textMessageObj + 1, TextMessage:New(200,350, 'Press the Triangle button to pick up the ' .. itemsObj[i].name))  
            if(controllerObj[c].triangleIsPressed == true and controllerObj[c].triangleCanBePressed == true) then
            if(itemsObj[i].name == "Health Pack") then
              self.healthPacksHeld = self.healthPacksHeld + 1
              itemsObj[i].isDead = true
              return
            end
            
            self:AddItemToInventory(itemsObj[i].name)
            itemsObj[i].isDead = true
            
          end
        end
      end
    end
  end
end

function Robot:OpenChest()
  
  for c = 1, #controllerObj, 1 do
      for i = 1, #chestObj, 1 do
        chestDimension = chestObj[i]:GetDimensions()
        if(self.x <= chestDimension[2] + 16 and self.x + 32 >= chestDimension[1] - 16) then
          if(self.y <= chestDimension[4] + 16 and self.y + 32 >= chestDimension[3] - 16) then
            
            if(chestObj[i].isOpen == false) then
            table.insert(textMessageObj, #textMessageObj + 1, TextMessage:New(200,350, 'Press the Triangle button to open the chest'))  
            end
            
            if(controllerObj[c].triangleIsPressed == true and controllerObj[c].triangleCanBePressed == true) then
            chestObj[i]:Open()
            return
          end
        end
      end
    end
  end
end

function Robot:OpenDoor()
  
  for c = 1, #controllerObj, 1 do
    
      for d = 1, #doorObj, 1 do
        doorDimension = doorObj[d]:GetDimensions()
        if(self.x <= doorDimension[2] + 16 and self.x + 32 >= doorDimension[1] - 16) then
          if(self.y <= doorDimension[4] + 16 and self.y + 32 >= doorDimension[3] - 16) then
            
            table.insert(textMessageObj, #textMessageObj + 1, TextMessage:New(200,350, 'Press the Triangle button to open the door'))  
            if(controllerObj[c].triangleIsPressed == true and controllerObj[c].triangleCanBePressed == true) then
            lockType = doorObj[d].lockType
        
            for i = 1, #self.itemsHeld, 1 do
              if(lockType == self.itemsHeld[i]) then
                doorObj[d].isDead = true
                if(self.itemsHeld[i] == 'Key') then
                  table.remove(self.itemsHeld, i)
                end
                break
              end
            end
          end
        end
      end
    end
  end
end

function Robot:CheckDeath()
  
  if(self.health <= 0) then
    GameOver()  
  end
  
  
end

function Robot:Update()
  self.primaryAttackTimer = self.primaryAttackTimer - 1
  self.secondaryAttackTimer = self.secondaryAttackTimer - 1
  self:FastMenuOptions()
  self:SendItemsToSpecialMenu()
  
  self:CheckSprint()
  self:CheckMovementLeftStick()
  self:CheckMovementRightStick()
  self:Move()
  self:CheckWorldPosition()
  self:KeepOnScreen()
  
  self:PrimaryAttack()
  self:SecondaryAttack()
  self:PickUpItem()
  self:OpenChest()
  self:OpenDoor()
  self:UpdateHealthBar()
  self:UpdateDamageTimer()
  self:CheckPause()
  self:CheckMiniMap()
  self:CheckDeath()
  return self.isDead
end
