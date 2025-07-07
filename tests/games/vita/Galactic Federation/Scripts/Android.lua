Android = {}
androidImage = Graphics.loadImage("app0:/Sprites/Android.png");

function Android:New(x,y)
android = {}
setmetatable(android, self)
self.__index = self
-- State related variables
-- Stat related
  android.health = 80
  android.maxHealth = 80
  android.stamina = 200
  android.maxStamina = 200
  android.stimPacksHeld = 9
  android.healthPacksHeld = 9
  android.itemsHeld = {}


-- Movement Related variables
android.walkSpeed = 7
android.sprintSpeed = 13
android.isSprinting = false
android.x = x
android.y = y
android.directionFacing = "north"
android.verticleDirectionMoving = "none"
android.horizontalDirectionMoving = "none"
  
android.currentFrame = 0  
android.whipObj = nil 
android.repairObj = nil
android.whipX = 0
android.whipY = 0
android.isDead = false
android.damageTimer = 0
android.canUsePrimaryTimer = 0
android.canUseSecondaryTimer = 0

return android
end

function Android:Draw()

if(self.verticleDirectionMoving ~= "none" or android.horizontalDirectionMoving ~= "none") then
  self.currentFrame = self.currentFrame + 1
  if(self.directionFacing == "north") then
    
    if(self.currentFrame >=1 and self.currentFrame <= 3) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 32, 64, 32, 32, 1, 1, androidImage)
    end
    
    if(self.currentFrame >=4 and self.currentFrame <= 6) then
      Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 0, 64, 32, 32, 1, 1, androidImage)
    end
    
    if(self.currentFrame >=7 and self.currentFrame <= 9) then
      Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 32, 96, 32, 32, 1, 1, androidImage)
    end
    
    if(self.currentFrame >=10 and self.currentFrame <= 12) then
      Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 0, 64, 32, 32, 1, 1, androidImage)
    end
    
    
  end
  
   if(self.directionFacing == "south") then
    if(self.currentFrame >=1 and self.currentFrame <= 3) then
      Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 32, 0, 32, 32, 1, 1, androidImage)
    end
    
    if(self.currentFrame >=4 and self.currentFrame <= 6) then
      Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 0, 0, 32, 32, 1, 1, androidImage)
    end
    
    if(self.currentFrame >=7 and self.currentFrame <= 9) then
      Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 32, 32, 32, 32, 1, 1, androidImage)
    end
    
    if(self.currentFrame >=10 and self.currentFrame <= 12) then
      Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 0, 0, 32, 32, 1, 1, androidImage)
    end
  end
  
   if(self.directionFacing == "east") then
    if(self.currentFrame >=1 and self.currentFrame <= 3) then
      Graphics.drawImageExtended(self.x- cameraX + 32, self.y- cameraY, 96, 0, 32, 32, -1, 1, androidImage)
    end
    
    if(self.currentFrame >=4 and self.currentFrame <= 6) then
      Graphics.drawImageExtended(self.x- cameraX + 32, self.y- cameraY, 64, 0, 32, 32, -1, 1, androidImage)
    end
    
    if(self.currentFrame >=7 and self.currentFrame <= 9) then
      Graphics.drawImageExtended(self.x- cameraX + 32, self.y- cameraY, 96, 32, 32, 32, -1, 1, androidImage)
    end
    
    if(self.currentFrame >=10 and self.currentFrame <= 12) then
      Graphics.drawImageExtended(self.x- cameraX + 32, self.y- cameraY, 64, 0, 32, 32, -1, 1, androidImage)
    end
  end
  
   if(self.directionFacing == "west") then
    if(self.currentFrame >=1 and self.currentFrame <= 3) then
      Graphics.drawImageExtended(self.x - cameraX, self.y- cameraY, 96, 0, 32, 32, 1, 1, androidImage)
    end
    
    if(self.currentFrame >=4 and self.currentFrame <= 6) then
      Graphics.drawImageExtended(self.x - cameraX, self.y- cameraY, 64, 0, 32, 32, 1, 1, androidImage)
    end
    
    if(self.currentFrame >=7 and self.currentFrame <= 9) then
      Graphics.drawImageExtended(self.x - cameraX, self.y- cameraY, 96, 32, 32, 32, 1, 1, androidImage)
    end
    
    if(self.currentFrame >=10 and self.currentFrame <= 12) then
      Graphics.drawImageExtended(self.x - cameraX, self.y- cameraY, 64, 0, 32, 32, 1, 1, androidImage)
    end
  end
  if(self.currentFrame >= 12) then
  self.currentFrame = 0  
  end
  
  
end

if(self.verticleDirectionMoving == "none" and android.horizontalDirectionMoving == "none") then
  self.currentFrame = 0
  if(self.directionFacing == "north") then
    Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 0, 64, 32, 32, 1, 1, androidImage)
  end
  
  if(self.directionFacing == "south") then
    Graphics.drawImageExtended(self.x- cameraX, self.y - cameraY, 0, 0, 32, 32, 1, 1, androidImage)
  end
  
  if(self.directionFacing == "east") then
    Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 64, 0, 32, 32, -1, 1, androidImage)
  end
  
  if(self.directionFacing == "west") then
    Graphics.drawImageExtended(self.x - cameraX, self.y- cameraY, 64, 0, 32, 32, 1, 1, androidImage)
  end
  
end

  
  
  
end


function Android:Move()
  
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


function Android:Raycast(direction, speed)
    
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
  
  function Android:RayCastEnemy(direction, speed)
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
  
  
function Android:KeepOnScreen()
  
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



function Android:CheckMovementLeftStick()
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

function Android:CheckMovementRightStick()
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

function Android:TakeDamage(damage)
  
  if(self.damageTimer <= 0) then
    self.health = self.health - damage
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(damage),Color.new(255,0,0)))
    self.damageTimer = 25
  end
  

end

function Android:UpdateDamageTimer()
if(self.damageTimer >0) then
self.damageTimer = self.damageTimer - 1
end

end


function Android:UpdateHealthBar()
for i, value in ipairs(healthBarObj )do
  healthBarObj[i]:UpdateValues(self.health, self.maxHealth, self.stamina, self.maxStamina)
  end
end

function Android:SendItemsToSpecialMenu()
  
  for i, value in ipairs(specialMenuObj) do
  specialMenuObj[i]:UpdateItemsHeld(self.healthPacksHeld, self.stimPacksHeld)
  end
  
end

function Android:HealDamage(health)
  self.health = self.health + health
  if(self.health > self.maxHealth) then
  self.health = self.maxHealth  
  end
  
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(health),Color.new(0,255,0)))

end

function Android:RestoreEnergy(energy)
  self.stamina = self.stamina + energy
  
  if(self.stamina > self.maxStamina) then
  self.stamina = self.maxStamina  
  end
  
  
      table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(energy),Color.new(0,0,255)))

end

function Android:UseHealthPack()
  if(self.health < self.maxHealth) then
    if(self.healthPacksHeld > 0) then
      self.healthPacksHeld = self.healthPacksHeld - 1
      self:HealDamage(25)
    end
end
  
end

function Android:UseBattery()
  if(self.stamina < self.maxStamina) then
    if(self.stimPacksHeld > 0) then
    self.stimPacksHeld = self.stimPacksHeld - 1  
    self:RestoreEnergy(25)
    end
  end
end

function Android:FastMenuOptions()
  
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].padUpIsPressed == true and controllerObj[i].padUpCanBePressed == true) then
      self:UseHealthPack()
    end
    
    if(controllerObj[i].padDownIsPressed == true and controllerObj[i].padDownCanBePressed == true) then
      self:UseBattery()
    end

  end
end

function Android:CheckSprint()
 
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].circleIsPressed == true) then
      self.isSprinting = true
      
    else
      self.isSprinting = false
      
    end

  end
  
end

function Android:CheckWorldPosition()
  
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

function Android:PrimaryAttack()
  
  if(self.canUsePrimaryTimer < 0) then
  self.canUsePrimaryTimer = self.canUsePrimaryTimer + 1
  return
  end
  
  
  for i, value in ipairs(controllerObj) do
    
    if(self.repairObj == nil) then
    if(controllerObj[i].rightTriggerIsPressed == true and controllerObj[i].rightTriggerCanBePressed == true) then
      
      self.whipObj = LaserWhip:New(self.x + self.whipX,self.y + self.whipY,self.directionFacing)
      table.insert(bulletsObj, #bulletsObj + 1, self.whipObj:GetSelf())
      
    end
    
    if(controllerObj[i].rightTriggerIsPressed == false and controllerObj[i].rightTriggerCanBePressed == false and self.whipObj ~= nil) then
      self.whipObj:KillSelf()
      self.canUsePrimaryTimer = -20
      self.whipObj = nil
    end
    end
  end 
end

function Android:SecondaryAttack()
  
  if(self.canUseSecondaryTimer < 0) then
  self.canUseSecondaryTimer = self.canUseSecondaryTimer + 1  
  return
  end
  
  
  for i, value in ipairs(controllerObj) do
    if(self.whipObj == nil) then
      if(controllerObj[i].leftTriggerIsPressed == true and controllerObj[i].leftTriggerCanBePressed == true) then
        self.repairObj = RepairBeam:New(self.x + self.whipX, self.y + self.whipY, self.directionFacing)
        table.insert(bulletsObj, #bulletsObj + 1, self.repairObj:GetSelf())
      end
      
      if(controllerObj[i].leftTriggerIsPressed == false and controllerObj[i].leftTriggerCanBePressed == false and self.repairObj ~= nil) then
        
        self.repairObj:KillSelf()
        self.canUseSecondaryTimer = -60
        self.repairObj = nil
      end
    
    end
  end
end

function Android:UpdateWhipPosition()
  
  if(self.whipObj ~= nil) then
  self.whipObj:UpdatePosition(self.x + self.whipX,self.y +self.whipY, self.directionFacing)  
  end
  
end

function Android:UpdateRepairPosition()
  
  if(self.repairObj ~= nil) then
    if(self.directionFacing == "east" or self.directionFacing == "west") then
      self.repairObj:UpdatePosition(self.x + self.whipX,self.y +self.whipY + 8, self.directionFacing) 
    end
    
    if(self.directionFacing == "south") then
      self.repairObj:UpdatePosition(self.x + self.whipX + 8,self.y +self.whipY - 49, self.directionFacing) 
    end
    
    if(self.directionFacing == "north") then
      self.repairObj:UpdatePosition(self.x + self.whipX + 8,self.y +self.whipY +49, self.directionFacing) 
    end
  end
  
end

function Android:GetWeaponPosition()
  
  if(self.directionFacing == "north") then
    self.whipX = 16
    self.whipY = -45
  end
  
  if(self.directionFacing == "south") then
    self.whipX = 3
    self.whipY = 60
  end
  
  if(self.directionFacing == "east") then
    self.whipX = 29
    self.whipY = 5
  end
  
  if(self.directionFacing == "west") then
    self.whipX = 3
    self.whipY = 5
  end
  
  
end


function Android:CheckMiniMap()
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].selectIsPressed == true and controllerObj[i].selectCanBePressed == true) then
    table.insert(miniMapObj, #miniMapObj + 1, MiniMap:New())
    isPaused = true
    end
  end

end

function Android:CheckPause()
  for i, value in ipairs(controllerObj) do
  
  if(controllerObj[i].startIsPressed == true and controllerObj[i].startCanBePressed == true) then
    
  table.insert(pauseObj, #pauseObj + 1, Pause:New())
  isPaused = true
  
  end
  
  
  end
  
end

function Android:GetDimensions()
  
  return {self.x, self.x + 32, self.y, self.y + 32}
end

function Android:UseSpecialMove(moveName)
  
if(moveName == "teleport") then
  
end

if(moveName == "gun turrent") then
  
end

  
end

function Android:AddItemToInventory(itemName)
  if(#self.itemsHeld < 144) then
    table.insert(self.itemsHeld, #self.itemsHeld + 1, itemName)
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(cameraX + 5, cameraY + 80, 'Picked up a' .. itemName,Color.new(255,255,255)))
  end
end

function Android:PickUpItem()
  
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

function Android:OpenChest()
  
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

function Android:OpenDoor()
  
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


function Android:CheckDeath()
  
  if(self.health <= 0) then
    GameOver()  
  end
  
  
end


function Android:Update()
  
self:FastMenuOptions()
self:SendItemsToSpecialMenu()

self:CheckSprint()
  self:CheckMovementLeftStick()
  self:CheckMovementRightStick()
  self:Move()
  self:CheckWorldPosition()
  self:KeepOnScreen()
  self:GetWeaponPosition()
  

self:PrimaryAttack()
self:SecondaryAttack()
self:PickUpItem()
  self:OpenChest()
  self:OpenDoor()
self:UpdateWhipPosition()
  self:UpdateRepairPosition()
self:UpdateHealthBar()
self:UpdateDamageTimer()
self:CheckPause()
self:CheckMiniMap()
self:CheckDeath()
return self.isDead
end
