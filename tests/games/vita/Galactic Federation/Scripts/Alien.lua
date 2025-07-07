Alien = {}
alienImage = Graphics.loadImage("app0:/Sprites/Alien.png");

function Alien:New(x,y)
  alien = {}
  setmetatable(alien,self)
  self.__index = self
  alien.health = 100
  alien.maxHealth = 100
  alien.stamina = 100
  alien.maxStamina = 100
  alien.itemsHeld = {}
  alien.directionFacing = "north"
  alien.verticleDirectionMoving = "none"
  alien.horizontalDirectionMoving = "none"
  alien.isSprinting = false
  alien.x = x
  alien.y = y
  
  alien.canMove = true
  alien.walkSpeed = 6
  alien.sprintSpeed = 9
  alien.frameCount = 0
  alien.frameLimit = 0
  alien.gunWaitTime = 0
  alien.attackRechargeTime = 0
  alien.healthPacksHeld = 9
  alien.stimPacksHeld = 9
  alien.itemsHeld = {}
  alien.characterState = "idle"
  alien.damageTimer = 0
  
  alien.attackEffect = nil
  
  alien.attackX = 0
  alien.attackY = 0
  
  return alien
end

function Alien:Draw()
  
  self.frameCount = self.frameCount + 1
  
  if(self.characterState == "idle") then
    self.frameLimit = 1
    if(self.directionFacing == "north") then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 0, 32, 32, 1, 1, alienImage)
    end
    
    if(self.directionFacing == "south") then
      Graphics.drawImageExtended(self.x - cameraX, self.y  - cameraY, 128, 64, 32, 32, 1, 1, alienImage)
    end
    
    if(self.directionFacing == "east") then
      Graphics.drawImageExtended(self.x - cameraX, self.y  - cameraY, 128, 128, 32, 32, 1, 1, alienImage)
    end
    
    if(self.directionFacing == "west") then
      Graphics.drawImageExtended(self.x - cameraX + 32, self.y - cameraY, 128, 128, 32, 32, -1, 1, alienImage)
    end
    
  end
  
  if(self.characterState == "walk") then
    self.frameLimit = 12
    if(self.directionFacing == "north") then
      
      if(self.frameCount >= 1 and self.frameCount <= 3) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 32, 0, 32, 32, 1, 1, alienImage)
    end
    
    if(self.frameCount >= 7 and self.frameCount <= 9) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 32, 32, 32, 32, 1, 1, alienImage)
      end
      
      
      if(self.frameCount >= 4 and self.frameCount <= 6 or self.frameCount >= 10 and self.frameCount <= 12) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 0, 32, 32, 1, 1, alienImage)
      end
    end
    
    if(self.directionFacing == "south") then
      
      if(self.frameCount >= 1 and self.frameCount <= 3) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY , 160, 64, 32, 32, 1, 1, alienImage)
    end
    
    if(self.frameCount >= 7 and self.frameCount <= 9) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY , 160, 96, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 4 and self.frameCount <= 6 or self.frameCount >= 10 and self.frameCount <= 12) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY , 128, 64, 32, 32, 1, 1, alienImage)
      end
    end
    
    if(self.directionFacing == "east") then
      if(self.frameCount >= 1 and self.frameCount <= 3) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 160, 128, 32, 32, 1, 1, alienImage)
    end
    
    if(self.frameCount >= 7 and self.frameCount <= 9) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 160, 160, 32, 32, 1, 1, alienImage)
      end
      if(self.frameCount >= 4 and self.frameCount <= 6 or self.frameCount >= 10 and self.frameCount <= 12) then
      Graphics.drawImageExtended(self.x - cameraX, self.y  - cameraY, 128, 128, 32, 32, 1, 1, alienImage)
      end
    end
    
    if(self.directionFacing == "west") then
      
      if(self.frameCount >= 1 and self.frameCount <= 3) then
      Graphics.drawImageExtended(self.x - cameraX + 32, self.y - cameraY, 160, 128, 32, 32, -1, 1, alienImage)
    end
    
    if(self.frameCount >= 7 and self.frameCount <= 9) then
        Graphics.drawImageExtended(self.x - cameraX + 32, self.y - cameraY, 160, 160, 32, 32, -1, 1, alienImage)
      end
      
      if(self.frameCount >= 4 and self.frameCount <= 6 or self.frameCount >= 10 and self.frameCount <= 12) then
      Graphics.drawImageExtended(self.x - cameraX + 32, self.y - cameraY, 128, 128, 32, 32, -1, 1, alienImage)
      end
    end
    
  end
  
  if(self.characterState == "attack") then
    if(self.directionFacing == "north") then
    
      if(self.frameCount >= 1 and self.frameCount <= 4) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 128, 0, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 5 and self.frameCount <= 6) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 160, 0, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 7 and self.frameCount <= 10) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 128, 32, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 11 and self.frameCount <= 12) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 160, 32, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 13 and self.frameCount <= 14) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 64, 0, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 15 and self.frameCount <= 16) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 96, 0, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 17 and self.frameCount <= 18) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 64, 32, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 19 and self.frameCount <= 20) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 64, 32, 32, 32, 1, 1, alienImage)
      end
      

  end
  
  if(self.directionFacing == "south") then
    
      if(self.frameCount >= 1 and self.frameCount <= 4) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY , 64, 64, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 5 and self.frameCount <= 6) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY , 96, 64, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 7 and self.frameCount <= 10) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY , 64, 96, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 11 and self.frameCount <= 12) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY , 96, 96, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 13 and self.frameCount <= 14) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY , 0, 64, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 15 and self.frameCount <= 16) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 32, 64, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 17 and self.frameCount <= 18) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 96, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 19 and self.frameCount <= 20) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 96, 32, 32, 1, 1, alienImage)
      end

  end
  
  
  if(self.directionFacing == "east") then
    
      if(self.frameCount >= 1 and self.frameCount <= 4) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 64, 128, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 5 and self.frameCount <= 6) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 96, 128, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 7 and self.frameCount <= 10) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 64, 160, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 11 and self.frameCount <= 12) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 96, 160, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 13 and self.frameCount <= 14) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 128, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 15 and self.frameCount <= 16) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 32, 128, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 17 and self.frameCount <= 18) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 160, 32, 32, 1, 1, alienImage)
      end
      
      if(self.frameCount >= 19 and self.frameCount <= 20) then
        Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 160, 32, 32, 1, 1, alienImage)
      end

  end
  
  if(self.directionFacing == "west") then
    
     if(self.frameCount >= 1 and self.frameCount <= 4) then
        Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 64, 128, 32, 32, -1, 1, alienImage)
      end
      
      if(self.frameCount >= 5 and self.frameCount <= 6) then
        Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 96, 128, 32, 32, -1, 1, alienImage)
      end
      
      if(self.frameCount >= 7 and self.frameCount <= 10) then
        Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 64, 160, 32, 32, -1, 1, alienImage)
      end
      
      if(self.frameCount >= 11 and self.frameCount <= 12) then
        Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 96, 160, 32, 32, -1, 1, alienImage)
      end
      
      if(self.frameCount >= 13 and self.frameCount <= 14) then
        Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 0, 128, 32, 32, -1, 1, alienImage)
      end
      
      if(self.frameCount >= 15 and self.frameCount <= 16) then
        Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 32, 128, 32, 32, -1, 1, alienImage)
      end
      
      if(self.frameCount >= 17 and self.frameCount <= 18) then
        Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 0, 160, 32, 32, -1, 1, alienImage)
      end
      
      if(self.frameCount >= 19 and self.frameCount <= 20) then
        Graphics.drawImageExtended(self.x + 32 - cameraX, self.y - cameraY, 0, 160, 32, 32, -1, 1, alienImage)
      end

    end

end


if(self.characterState == "spitAcid") then
    
    self.frameLimit = 6
    
    if(self.directionFacing == "north") then
    
    Graphics.drawImageExtended(self.x - cameraX , self.y - cameraY, 96, 0, 32, 32, 1, 1, alienImage)
    
  end
  
  if(self.directionFacing == "south") then
    Graphics.drawImageExtended(self.x - cameraX , self.y - cameraY , 0, 96, 32, 32, 1, 1, alienImage)
  end
  
  
  if(self.directionFacing == "east") then 
    Graphics.drawImageExtended(self.x - cameraX , self.y - cameraY, 32, 128, 32, 32, 1, 1, alienImage)
  end
  
  if(self.directionFacing == "west") then
    Graphics.drawImageExtended(self.x - cameraX + 32, self.y - cameraY, 32, 128, 32, 32, -1, 1, alienImage)
    end
    end
  
  
  if(self.frameCount >= self.frameLimit) then
  
  if(self.characterState == "attack" or self.characterState == "spitAcid") then
  self.characterState = "idle"  
  
    if(self.attackEffect ~= nil) then
      self.attackEffect.isDead = true
      self.attackEffect = nil
    end
  end
  
  
  self.frameCount = 0
  end
  
  
end

function Alien:Move()
  
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


function Alien:Raycast(direction, speed)
    
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
  
  function Alien:RayCastEnemy(direction, speed)
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
  
function Alien:KeepOnScreen()
  
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



function Alien:CheckMovementLeftStick()
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

function Alien:CheckMovementRightStick()
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

function Alien:UseSpecialMove(moveName)
  
  if(moveName == "dash") then
    
  end
  
  if(moveName == "solo sheild") then
    
  end
  
  
end
  

function Alien:PrimaryAttack()
  
   for i, value in ipairs(controllerObj) do
     
     if(controllerObj[i].rightTriggerIsPressed == true and controllerObj[i].rightTriggerCanBePressed == true) then
       
       
       if(self.characterState ~= "attack") then
        self.characterState = "attack"
        self.frameLimit = 6 
        self.canMove = false
        self.attackEffect = AlienPunchEffect:New(self.x,self.y,self.directionFacing)
        table.insert(bulletsObj, #bulletsObj + 1, self.attackEffect:GetSelf())
        return
        end
     
       
       if(self.frameLimit == 6) then
         self.characterState = "attack"
         self.frameLimit = 12
         self.canMove = false
         return
       end
       
       if(self.frameLimit == 12) then
         self.characterState = "attack"
         self.frameLimit = 20
         self.canMove = false
         return
         
       end
       
       
       end
     
     
     
   end
   
  
end

function Alien:SecondaryAttack()
  
  for i, value in ipairs(controllerObj) do
     if(controllerObj[i].leftTriggerIsPressed == true and controllerObj[i].leftTriggerCanBePressed == true) then
       if(self.attackRechargeTime >=0) then
       self.characterState = "spitAcid"
       self.currentFrame = 0
       table.insert(bulletsObj, #bulletsObj + 1, Bullets:New(self.x, self.y, self.directionFacing, 16, 4, 16, 16, 8))
       self.attackRechargeTime = -40
     end
     
     end
   end
  self.attackRechargeTime = self.attackRechargeTime + 1
end


function Alien:TakeDamage(damage)
  
  if(self.damageTimer <= 0) then
    self.health = self.health - damage
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(damage),Color.new(255,0,0)))
    self.damageTimer = 25
  end
  

end

function Alien:UpdateDamageTimer()
if(self.damageTimer >0) then
self.damageTimer = self.damageTimer - 1
end

end


function Alien:UpdateHealthBar()
for i, value in ipairs(healthBarObj )do
  healthBarObj[i]:UpdateValues(self.health, self.maxHealth, self.stamina, self.maxStamina)
  end
end

function Alien:CheckMiniMap()
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].selectIsPressed == true and controllerObj[i].selectCanBePressed == true) then
    table.insert(miniMapObj, #miniMapObj + 1, MiniMap:New())
    isPaused = true
    end
  end

end

function Alien:CheckPause()
  for i, value in ipairs(controllerObj) do
  
  if(controllerObj[i].startIsPressed == true and controllerObj[i].startCanBePressed == true) then
    
  table.insert(pauseObj, #pauseObj + 1, Pause:New())
  isPaused = true
  
  end
  
  
  end
  
end

function Alien:CheckSprint()
 
  for i, value in ipairs(controllerObj) do
  if(controllerObj[i].circleIsPressed == true) then
    self.isSprinting = true
    
  else
    self.isSprinting = false
    
  end
  end
  
end

function Alien:CheckWorldPosition()
  
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

function Alien:AdjustAcidSpitLocation()
  
end


function Alien:AdjustAttackBox()
  if(self.attackEffect ~= nil) then
  
    if(self.directionFacing == "north") then
        
      if(self.frameCount <= 6) then
        self.attackEffect:SetPosition(self.x + 22, self.y - 18)
      end
      
      if(self.frameCount >= 7 and self.frameCount <= 12) then
        self.attackEffect:SetPosition(self.x - 3, self.y - 18)
        if(self.frameCount == 7) then
          self.attackEffect.isActive = true
        end
        
      end
      
      if(self.frameCount >= 13 and self.frameCount <= 20) then
        self.attackEffect:SetPosition(self.x + 11, self.y - 18)
        if(self.frameCount == 13) then
          self.attackEffect.isActive = true
        end
      end

    end
    
    if(self.directionFacing == "south") then
        
      if(self.frameCount <= 6) then
        self.attackEffect:SetPosition(self.x + 22, self.y + 34)
      end
      
      if(self.frameCount >= 7 and self.frameCount <= 12) then
        self.attackEffect:SetPosition(self.x - 3, self.y + 34)
        if(self.frameCount == 7) then
          self.attackEffect.isActive = true
        end
      end
      
      if(self.frameCount >= 13 and self.frameCount <= 20) then
        self.attackEffect:SetPosition(self.x + 11, self.y + 34)
        if(self.frameCount == 13) then
          self.attackEffect.isActive = true
        end
      end
      
    end
    
    if(self.directionFacing == "east") then
        
        if(self.frameCount <= 6) then
        self.attackEffect:SetPosition(self.x + 34, self.y + 12)
      end
      
      if(self.frameCount >= 7 and self.frameCount <= 12) then
        self.attackEffect:SetPosition(self.x + 34, self.y + 8)
        if(self.frameCount == 7) then
          self.attackEffect.isActive = true
        end
      end
      
      if(self.frameCount >= 13 and self.frameCount <= 20) then
        self.attackEffect:SetPosition(self.x + 34, self.y + 10)
        if(self.frameCount == 13) then
          self.attackEffect.isActive = true
        end
      end
      
    end
    
    if(self.directionFacing == "west") then
        
        if(self.frameCount <= 6) then
        self.attackEffect:SetPosition(self.x - 19, self.y + 12)
      end
      
      if(self.frameCount >= 7 and self.frameCount <= 12) then
        self.attackEffect:SetPosition(self.x - 19, self.y + 8)
        if(self.frameCount == 7) then
          self.attackEffect.isActive = true
        end
      end
      
      if(self.frameCount >= 13 and self.frameCount <= 20) then
        self.attackEffect:SetPosition(self.x - 19, self.y + 10)
        if(self.frameCount == 13) then
          self.attackEffect.isActive = true
        end
      end
      
    end
   
  end
  
end

function Alien:UpdateGunTime()
  
end

function Alien:GetState()
  
  if(self.verticleDirectionMoving ~= "none" or self.horizontalDirectionMoving ~= "none") then
    
    if(self.characterState ~= "attack" and self.characterState ~= "spitAcid") then
      self.characterState = "walk"
      self.canMove = true
    end
    
   else
    if(self.characterState ~= "attack" and self.characterState ~= "spitAcid") then
      self.characterState = "idle"
      self.canMove = true
    end 
    
  end
  
  
  
end

function Alien:HealDamage(health)
  self.health = self.health + health
  if(self.health > self.maxHealth) then
  self.health = self.maxHealth  
  end
  
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(health),Color.new(0,255,0)))

end

function Alien:RestoreEnergy(energy)
  self.stamina = self.stamina + energy
  
  if(self.stamina > self.maxStamina) then
  self.stamina = self.maxStamina  
  end
  
  
      table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(energy),Color.new(0,0,255)))

end


function Alien:UseHealthPack()
  if(self.health < self.maxHealth) then
    if(self.healthPacksHeld > 0) then
      self.healthPacksHeld = self.healthPacksHeld - 1
      self:HealDamage(25)
    end
end
  
end

function Alien:UseBattery()
  if(self.stamina < self.maxStamina) then
    if(self.stimPacksHeld > 0) then
    self.stimPacksHeld = self.stimPacksHeld - 1  
    self:RestoreEnergy(25)
    end
  end
end

function Alien:FastMenuOptions()
  
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].padUpIsPressed == true and controllerObj[i].padUpCanBePressed == true) then
      self:UseHealthPack()
    end
    
    if(controllerObj[i].padDownIsPressed == true and controllerObj[i].padDownCanBePressed == true) then
      self:UseBattery()
    end

  end
end

function Alien:SendItemsToSpecialMenu()
  
  for i, value in ipairs(specialMenuObj) do
  specialMenuObj[i]:UpdateItemsHeld(self.healthPacksHeld, self.stimPacksHeld)
  end
  
end

function Alien:AddItemToInventory(itemName)
  if(#self.itemsHeld < 144) then
    table.insert(self.itemsHeld, #self.itemsHeld + 1, itemName)
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(cameraX + 5,cameraY + 80, 'Picked up a' .. itemName,Color.new(255,255,255)))
  end
end

function Alien:PickUpItem()
  
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

function Alien:OpenChest()
  
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

function Alien:OpenDoor()
  
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


function Alien:GetDimensions()
  
  return {self.x, self.x + 32, self.y, self.y + 32}
end

function Alien:CheckDeath()
  
  if(self.health <= 0) then
    GameOver()  
  end
  
  
end


function Alien:Update()
   self:FastMenuOptions()
  self:CheckSprint()
  self:CheckMovementLeftStick()
  self:CheckMovementRightStick()
  self:Move()
  self:GetState()
  self:CheckWorldPosition()
  self:KeepOnScreen()
  self:UpdateGunTime()
  self:PrimaryAttack()
  self:SecondaryAttack()
  self:PickUpItem()
  self:OpenChest()
  self:OpenDoor()
  self:AdjustAttackBox()
  self:UpdateDamageTimer()
  self:UpdateHealthBar()
  self:CheckPause()
  self:CheckMiniMap()
  self:SendItemsToSpecialMenu()
  self:CheckDeath()
  
end
