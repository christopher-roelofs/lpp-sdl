Player = {}
marineImage = Graphics.loadImage("app0:/Sprites/Marine.png")

function Player:New(x,y)
  
  player = {}
  setmetatable(player,self)
  self.__index = self
  
  player.health = 100
  player.maxHealth = 100
  player.stamina = 100
  player.maxStamina = 100
  player.directionFacing = "north"
  player.verticleDirectionMoving = "none"
  player.horizontalDirectionMoving = "none"
  player.isSprinting = false
  player.usingSpecial = false
  player.x = x
  player.y = y
  player.walkSpeed = 8
  player.sprintSpeed = 12
  player.frameCount = 0
  player.frameLimit = 0
  player.gunWaitTime = 0
  player.bulletX = 0
  player.bulletY = 0
  player.healthPacksHeld = 9
  player.stimPacksHeld = 9
  player.itemsHeld = {}
  player.specialMoveInUse = ""
  player.canMove = true
  player.specialTimer = 0
  player.damageTimer = 0
  player.headEquiped = ""
  player.bodyEquiped = ""
  player.legsEquiped = ""
  player.handEquiped = ""
  player.feetEquiped = ""
  return player
  
end


function Player:Draw()
  for i, value in ipairs(cameraObj) do
     if (self.frameCount >= self.frameLimit) then
    self.frameCount = 0  
  end
  
  self.frameCount = self.frameCount + 1
  
  if(self.verticleDirectionMoving ~= "none" or self.horizontalDirectionMoving ~= "none") then
    
    self.frameLimit = 12
    
    if(self.directionFacing == "north") then
      
      if(self.frameCount <= 3) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,64,0,32,32,  1, 1, marineImage)
      end
      
      if(self.frameCount >= 4 and self.frameCount <= 6) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,96,0,32,32,  1, 1, marineImage)
      end
      
      if(self.frameCount >= 7 and self.frameCount <= 9) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,64,0,32,32,  1, 1, marineImage)
      end
      
      if(self.frameCount >= 10 and self.frameCount <= 12) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,96,32,32,32,  1, 1, marineImage)
      end
      
      
    end
    
    if(self.directionFacing == "south") then
      
      if(self.frameCount <= 3) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,64,64,32,32,  1, 1, marineImage)
      end
      
      if(self.frameCount >= 4 and self.frameCount <= 6) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,96,64,32,32,  1, 1, marineImage)
      end
      
      if(self.frameCount >= 7 and self.frameCount <= 9) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,64,64,32,32,  1, 1, marineImage)
      end
      
      if(self.frameCount >= 10 and self.frameCount <= 12) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,96,96,32,32,  1, 1, marineImage)
      end
      
    end
    
    if(self.directionFacing == "east") then
      if(self.frameCount <= 3) then
         Graphics.drawImageExtended(self.x  - cameraX,self.y - cameraY,0,64,32,32,  1, 1, marineImage)
      end
      
      if(self.frameCount >= 4 and self.frameCount <= 6) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,32,64,32,32,  1, 1, marineImage)
      end
      
      if(self.frameCount >= 7 and self.frameCount <= 9) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,0,64,32,32,  1, 1, marineImage)
      end
      
      if(self.frameCount >= 10 and self.frameCount <= 12) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,32,96,32,32,  1, 1, marineImage)
      end
    end
    
    if(self.directionFacing == "west") then
      if(self.frameCount <= 3) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,0,0,32,32,  1, 1, marineImage)
      end
      
      if(self.frameCount >= 4 and self.frameCount <= 6) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,32,0,32,32,  1, 1, marineImage)
      end
      
      if(self.frameCount >= 7 and self.frameCount <= 9) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,0,0,32,32,  1, 1, marineImage)
      end
      
      if(self.frameCount >= 10 and self.frameCount <= 12) then
         Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,32,32,32,32,  1, 1, marineImage)
      end
    end
    
    
  end
  
  if(self.verticleDirectionMoving == "none" and self.horizontalDirectionMoving == "none") then
    
    if(self.directionFacing == "north") then 
    Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,64,0,32,32, 1, 1,  marineImage)
  end
  
  if(self.directionFacing == "south") then 
    Graphics.drawImageExtended(self.x - cameraX,self.y  - cameraY,64,64,32,32,  1, 1, marineImage)
  end
  
  if(self.directionFacing == "east") then 
    Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,0,96,32,32, 1, 1, marineImage)
  end
  
  if(self.directionFacing == "west") then 
    Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,0,0,32,32, 1, 1, marineImage)
  end
  
  end
  
 end
end


function Player:Move()
  
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


function Player:Raycast(direction, speed)
    
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
          
          return tileDim[1] - self.x - 32  
            
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
  
  function Player:RayCastEnemy(direction, speed)
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
  
  
function Player:KeepOnScreen()
  
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



function Player:CheckMovementLeftStick()
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

function Player:CheckMovementRightStick()
  
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

function Player:PrimaryAttack()
  
  if(self.canMove == false) then
  return  
  end
  
  
  
  for i, value in ipairs(controllerObj) do
    
    if(controllerObj[i].rightTriggerIsPressed == true ) then
      
      if(self.gunWaitTime >= 0) then
      self.gunWaitTime = -10  
      table.insert(bulletsObj, #bulletsObj + 1, Bullets:New(self.x + self.bulletX, self.y + self.bulletY, self.directionFacing, 24, 1, 16, 4, 4))
      PlaySound('playerLaser')
      end
      
      
    end
    
    
  end
end


function Player:SecondaryAttack()
  
  if(self.canMove == false) then  
    return
  end
  
  
  for i, value in ipairs(controllerObj) do
    
    if(controllerObj[i].leftTriggerIsPressed == true ) then
      
      if(self.gunWaitTime >= 0) then
      self.gunWaitTime = -30  
      table.insert(bulletsObj, #bulletsObj + 1, Bullets:New(self.x + self.bulletX, self.y + self.bulletY, self.directionFacing, 18, 2, 9, 9, 7))
      PlaySound('playerLaser')
      end
      
      
    end
  end
  
  
end

function Player:UpdateGunTime()
  self.gunWaitTime = self.gunWaitTime + 1
  
end

function Player:CheckSprint()
 
  for i, value in ipairs(controllerObj) do
  if(controllerObj[i].circleIsPressed == true) then
    self.isSprinting = true
    
  else
    self.isSprinting = false
    
  end

  
  
  end
  
end


function Player:CheckWorldPosition()
  
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



function Player:GetGunPosition()
  
  if(self.directionFacing == "north") then
    self.bulletX = 22
    self.bulletY = 0
  end
  
  if(self.directionFacing == "south") then
    self.bulletX = 13
    self.bulletY = 4
  end
  
  if(self.directionFacing == "east") then
    self.bulletX = 20
    self.bulletY = 14
  end
  
  if(self.directionFacing == "west") then
    self.bulletX = 5
    self.bulletY = 14
  end
  
  
end

function Player:CheckPause()
  for i, value in ipairs(controllerObj) do
  
  if(controllerObj[i].startIsPressed == true and controllerObj[i].startCanBePressed == true) then
    
  table.insert(pauseObj, #pauseObj + 1, Pause:New())
  isPaused = true
  
  end
  
  
  end
  
end


function Player:CheckMiniMap()
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].selectIsPressed == true and controllerObj[i].selectCanBePressed == true) then
    table.insert(miniMapObj, #miniMapObj + 1, MiniMap:New())
    isPaused = true
    end
  end

end

function Player:TakeDamage(damage)
  
  if(self.damageTimer <= 0) then
    self.health = self.health - damage
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(damage),Color.new(255,0,0)))
    self.damageTimer = 25
  end
  

end

function Player:UpdateDamageTimer()
if(self.damageTimer >0) then
self.damageTimer = self.damageTimer - 1
end

end


function Player:HealDamage(health)
  self.health = self.health + health
  if(self.health > self.maxHealth) then
  self.health = self.maxHealth  
  end
  
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(health),Color.new(0,255,0)))

end

function Player:RestoreEnergy(energy)
  self.stamina = self.stamina + energy
  
  if(self.stamina > self.maxStamina) then
  self.stamina = self.maxStamina  
  end
  
  
      table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(energy),Color.new(0,0,255)))

end



function Player:UpdateHealthBar()
for i, value in ipairs(healthBarObj )do
  healthBarObj[i]:UpdateValues(self.health, self.maxHealth, self.stamina, self.maxStamina)
  end
end



function Player:UseHealthPack()
  if(self.health < self.maxHealth) then
    if(self.healthPacksHeld > 0) then
      self.healthPacksHeld = self.healthPacksHeld - 1
      self:HealDamage(25)
    end
end
  
end

function Player:UseBattery()
  if(self.stamina < self.maxStamina) then
    if(self.stimPacksHeld > 0) then
    self.stimPacksHeld = self.stimPacksHeld - 1  
    self:RestoreEnergy(25)
    end
  end
end

function Player:UseSpecialMove(moveName)
  
  if(moveName == "rapid fire") then
    if(self.stamina >= 20) then
    self.canMove = false
    self.specialTimer = 15
    self.specialMoveInUse = moveName
    self.stamina = self.stamina - 20
    end
  end
  
  
  if(moveName == "grenade") then
    if(self.stamina >= 30) then
    self.canMove = false
    self.specialTimer = 5
    self.specialMoveInUse = moveName
    self.stamina = self.stamina - 30
    end
  end
  
  if(moveName == "earthquake") then
    
  end
  
  
  
end

function Player:RapidFire()
  if(self.specialTimer == 15 or self.specialTimer == 10 or self.specialTimer == 5) then
          table.insert(bulletsObj, #bulletsObj + 1, Bullets:New(self.x + self.bulletX, self.y + self.bulletY, self.directionFacing, 30, 1, 16, 4, 6))
  end
end

function Player:Grenade()
  
end


function Player:FlashBang()
  
end

function Player:FlameThrower()
  
end

function Player:Mine()
  
end

function Player:Missile()
  
end

function Player:TempSpeedBoost()
  
end

function Player:SpecialMove()
  
  if(self.specialMoveInUse == "rapid fire") then
    self:RapidFire()
    
  end
  
  if(self.specialMoveInUse == "grenade") then
    self:Grenade()
  end
  
  if(self.specialMoveInUse == "flash bang") then
    self:FlashBang()
  end
  
  if(self.specialMoveInUse == "flame thrower") then
    self:FlameThrower()
  end
  
  if(self.specialMoveInUse == "mine") then
    self:Mine()
  end
  
  if(self.specialMoveInUse == "missile") then
    self:Missile()
  end
  
  if(self.specialMoveInUse == "temp speed boost") then
    self:TempSpeedBoost()
  end
  self.specialTimer = self.specialTimer - 1
  if(self.specialTimer <= 0) then
  self.specialMoveInUse = ""
  self.canMove = true
  end
  
end

function Player:AddItemToInventory(itemName)
  if(#self.itemsHeld < 144) then
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(cameraX + 5, cameraY + 80, 'Picked up a' .. itemName,Color.new(255,255,255)))
    table.insert(self.itemsHeld, #self.itemsHeld + 1, itemName)
  end
end

function Player:PickUpItem()
  
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

function Player:OpenChest()
  
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

function Player:OpenDoor()
  
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
function Player:SendItemsToSpecialMenu()
  
  for i, value in ipairs(specialMenuObj) do
  specialMenuObj[i]:UpdateItemsHeld(self.healthPacksHeld, self.stimPacksHeld)
  end
  
end

function Player:FastMenuOptions()
  
  for i, value in ipairs(controllerObj) do
  if(controllerObj[i].padUpIsPressed == true and controllerObj[i].padUpCanBePressed == true) then
    self:UseHealthPack()
  end
  
  if(controllerObj[i].padDownIsPressed == true and controllerObj[i].padDownCanBePressed == true) then
    self:UseBattery()
  end
  
  end
  
  
end

function Player:GetDimensions()
  
  return {self.x, self.x + 32, self.y, self.y + 32}
end

function Player:CheckDeath()
  
  if(self.health <= 0) then
    GameOver()  
  end
  
  
end

function Player:Update()
  
  self:FastMenuOptions()
  self:SendItemsToSpecialMenu()
  self:SpecialMove()
  self:CheckSprint()
  self:CheckMovementLeftStick()
  self:CheckMovementRightStick()
  self:Move()
  self:CheckWorldPosition()
  self:KeepOnScreen()
  self:UpdateGunTime()
  self:GetGunPosition()
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
  
end
