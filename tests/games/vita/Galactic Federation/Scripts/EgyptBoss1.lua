EgyptBoss1 = {}
egyptBoss1Img = Graphics.loadImage("app0:/Sprites/Egypt1Boss.png");

function EgyptBoss1:New(x,y) 
  egyptBoss1 = {}
  setmetatable(egyptBoss1, self)
  self.__index = self
  
  egyptBoss1.x = x
  egyptBoss1.y = y
  
  egyptBoss1.health = 300
  egyptBoss1.power = 10
  egyptBoss1.currentFrame = 1
  
  egyptBoss1.walkSpeed = 6
  egyptBoss1.ramSpeed = 18
  egyptBoss1.characterState = "idle"
  egyptBoss1.directionFacing = "south"
  egyptBoss1.hurtTimer = 0
  egyptBoss1.hurtColor = Color.new(255,255,255)
  
  egyptBoss1.timeSinceDirectionChange = 0
  
  egyptBoss1.isDead = false
  
  egyptBoss1.recoveryTime = 0
  egyptBoss1.rushTime = 0
  
  return egyptBoss1
  
end

function EgyptBoss1:Draw()
  
  if(self.directionFacing == "north") then
    Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 320, 160, 160, 1, 1, egyptBoss1Img, self.hurtColor)
  end
  
  if(self.directionFacing == "south") then
    
    if(self.characterState == "ram") then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 160, 0, 160, 160, 1, 1, egyptBoss1Img, self.hurtColor)
    end
    
    if(self.characterState == "walk" or self.characterState == "idle") then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 0, 160, 160, 1, 1, egyptBoss1Img, self.hurtColor)
    end
    
  end
  
  if(self.directionFacing == "east") then
    if(self.characterState == "ram") then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 160, 160, 160, 1, 1, egyptBoss1Img, self.hurtColor)
    end
    
    if(self.characterState == "walk" or self.characterState == "idle") then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 160, 160, 160, 160, 1, 1, egyptBoss1Img, self.hurtColor)
    end
  end
  
  if(self.directionFacing == "west") then
    if(self.characterState == "ram") then
      Graphics.drawImageExtended(self.x - cameraX + 160, self.y - cameraY, 0, 160, 160, 160, -1, 1, egyptBoss1Img, self.hurtColor)
    end
    
    if(self.characterState == "walk" or self.characterState == "idle") then
      Graphics.drawImageExtended(self.x - cameraX + 160, self.y - cameraY, 160, 160, 160, 160, -1, 1, egyptBoss1Img, self.hurtColor)
    end
  end
  
end

function EgyptBoss1:Move()
  
  if(self.characterState == "walk") then
    speed = self:Raycast(self.directionFacing, self.walkSpeed)
    speed = self:RaycastEnemy(self.directionFacing, speed)
    speed = self:RaycastPlayer(self.directionFacing, speed)
    
    if(self.directionFacing == "north") then
      self.y = self.y - speed
    end
    
    if(self.directionFacing == "south") then
      self.y = self.y + speed
    end
    
    if(self.directionFacing == "east") then
      self.x = self.x + speed
    end
    
    if(self.directionFacing == "west") then
      self.x = self.x - speed
    end
    
    
  end
  
  if(self.characterState == "ram") then
    if(self.rushTime >= 46) then
        return
    end
    
    speed = self:Raycast(self.directionFacing, self.ramSpeed)
    speed = self:RaycastEnemy(self.directionFacing, speed)
    speed = self:RaycastPlayer(self.directionFacing, speed)
    
    if(self.directionFacing == "north") then
      self.y = self.y - speed
    end
    
    if(self.directionFacing == "south") then
      self.y = self.y + speed
    end
    
    if(self.directionFacing == "east") then
      self.x = self.x + speed
    end
    
    if(self.directionFacing == "west") then
      self.x = self.x - speed
    end
  end
  
  
end

function EgyptBoss1:Ram()
  if(self.rushTime <= 0 and self.characterState == 'ram') then
    self.recoveryTime = 90
  end
end


function EgyptBoss1:Raycast(direction, speed)
  if(direction == "west") then
      
      for i, value in ipairs(collidableObj) do
        
        
       
          tileDim = collidableObj[i]:GetDimensions()
        if(self.y < tileDim[4] and self.y + 128 > tileDim[3]) then
        
          if(self.x + 40 - speed < tileDim[2] and self.x + 120> tileDim[2]) then
          
          return self.x + 40 - tileDim[2]
            
          end
        
        
        
      end
      
      end
      
      return speed
    end
    
    if(direction == "east") then
      
      for i, value in ipairs(collidableObj) do
        
        
       
          tileDim = collidableObj[i]:GetDimensions()
          
        if(self.y < tileDim[4] and self.y + 128 > tileDim[3]) then
        
          if(self.x + 120 + speed > tileDim[1] and self.x + 40 <= tileDim[1]) then
          
          return tileDim[1] - self.x - 120  
            
          end
        
      
        
        
      end
      
      end
      return speed
    end
    
    
    
    
    if(direction == "north") then
      
      for i, value in ipairs(collidableObj) do
        
       
        
    
        tileDim = collidableObj[i]:GetDimensions()
        if(self.x + 24 < tileDim[2] and self.x + 136 > tileDim[1]) then
        
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
        if(self.x + 24 < tileDim[2] and self.x + 136 > tileDim[1]) then
        
        if(self.y + 128  + speed > tileDim[3] and self.y <= tileDim[3]) then
        
        return tileDim[3] - self.y -128  
   
        
          
        end
        
        
      end
      
      end
      return speed
    end
    
end

function EgyptBoss1:RaycastPlayer(direction, speed)
   if(direction == "west") then
      
      for i, value in ipairs(playerObj) do
        
        
          playerDim = playerObj[i]:GetDimensions()
        if(self.y < playerDim[4] and self.y + 128 > playerDim[3]) then
        
          if(self.x + 40 - speed < playerDim[2] and self.x + 120> playerDim[2]) then
          if(self.characterState == 'ram') then
            playerObj[i]:TakeDamage(self.power)
          end
          return self.x + 40- playerDim[2]
            
          end       
      end
      
      end
      
      return speed
    end
    
    if(direction == "east") then
      
      for i, value in ipairs(playerObj) do
        
          playerDim = playerObj[i]:GetDimensions()
          
        if(self.y < playerDim[4] and self.y + 128 > playerDim[3]) then
        
          if(self.x + 120 + speed > playerDim[1] and self.x + 40 <= playerDim[1]) then
          
          if(self.characterState == 'ram') then
            playerObj[i]:TakeDamage(self.power)
          end
          return playerDim[1] - self.x - 120 
            
          end       
        
      end
      
      end
      return speed
    end
    
    if(direction == "north") then
      
      for i, value in ipairs(playerObj) do
        
        playerDim = playerObj[i]:GetDimensions()
        if(self.x + 24 < playerDim[2] and self.x + 136 > playerDim[1]) then
        
        if(self.y - speed < playerDim[4] and self.y >= playerDim[4]) then
        if(self.characterState == 'ram') then
            playerObj[i]:TakeDamage(self.power)
          end
        return self.y - playerDim[4]
          
        end
        
      end
      
      end
      return speed
    end
    
    if(direction == "south") then
      
      for i, value in ipairs(playerObj) do
        
        playerDim = playerObj[i]:GetDimensions()
        if(self.x + 24 < playerDim[2] and self.x + 136 > playerDim[1]) then
        
        if(self.y + 128  + speed > playerDim[3] and self.y <= playerDim[3]) then
        if(self.characterState == 'ram') then
            playerObj[i]:TakeDamage(self.power)
          end
        return playerDim[3] - self.y - 128 
          
        end
     
      end
      
      end
      return speed
    end
end

function EgyptBoss1:RaycastEnemy(direction, speed)
  if(direction == "west") then
      for i, value in ipairs(enemyObj) do      
        
        if(enemyObj[i] ~= self) then
          enemyDim = enemyObj[i]:GetDimensions()
      if(self.y < enemyDim[4] and self.y + 128 > enemyDim[3]) then
        
        if(self.x + 40 - speed < enemyDim[2] and self.x + 120 > enemyDim[2]) then
          
        speed = self.x + 40 - enemyDim[2] 
        if(speed <= 0) then
        speed = 0  
        end
        end
        end  
      end
      end
    end
    
    if(direction == "east") then
      
      for i, value in ipairs(enemyObj) do

        if(enemyObj[i] ~= self) then
          enemyDim = enemyObj[i]:GetDimensions()
          
        if(self.y < enemyDim[4] and self.y + 128 > enemyDim[3]) then
        
          if(self.x + 120 + speed > enemyDim[1] and self.x + 40 <= enemyDim[1]) then
          
          speed = enemyDim[1] - self.x - 120  
          if(speed <= 0) then
          speed = 0  
          end
          
          
        end  
      end
      end
      end
    end
    
    if(direction == "north") then
      
      for i, value in ipairs(enemyObj) do
        if(enemyObj[i] ~= self) then
        enemyDim = enemyObj[i]:GetDimensions()
        if(self.x + 24 < enemyDim[2] and self.x + 136 > enemyDim[1]) then
        
        if(self.y - speed < enemyDim[4] and self.y >= enemyDim[4]) then
        
        speed = self.y - enemyDim[4]
        
        if(speed <= 0) then
        speed = 0  
        end
        
          
        end
        end
        end
 
      end
    end
    
    if(direction == "south") then
      
      for i, value in ipairs(enemyObj) do
        if(enemyObj[i] ~= self) then
        enemyDim = enemyObj[i]:GetDimensions()
        if(self.x + 24 < enemyDim[2] and self.x + 136 > enemyDim[1]) then
        
        if(self.y + 120  + speed > enemyDim[3] and self.y <= enemyDim[3]) then
        
        speed =  enemyDim[3] - (self.y + 120) 
        
        if(speed <= 0) then
        speed = 0  
        end
        
          
        end
        
          end
        end
        
        end
      end
      return speed
end

function EgyptBoss1:DecideDirection()
  self.timeSinceDirectionChange = self.timeSinceDirectionChange + 1
  
  if(self.timeSinceDirectionChange >= 15) then
  
  if(self.characterState == 'ram' or self.characterState == 'idle') then
      self.timeSinceDirectionChange = 0
      return
  end
  self.timeSinceDirectionChange = 0
  
  for p = 1, #playerObj, 1 do
    
    playerDim = playerObj[p]:GetDimensions()
    
    if(self.y < playerDim[4] - 16 and self.y + 110 > playerDim[4] - 16) then
      
      if(self.x + 60 > playerDim[1] + 16) then
        self.directionFacing = "west"
        self:StartRam()
        return
      end
      
      if(self.x + 100 < playerDim[1] + 16) then
        self.directionFacing = "east"
        self:StartRam()
        return
      end
      
    end
    
    if(self.x + 60 < playerDim[1] + 16 and self.x + 100 > playerDim[1] + 16) then
        if(self.y > playerDim[4] - 16) then
          self.directionFacing = 'north'
          self:StartRam()
          return
        end
        
        if(self.y + 110 < playerDim[4] - 16) then
            self.directionFacing = 'south'
            self:StartRam()
            return
        end
                
    end
    h,m,s = System.getTime() 
    rand = math.randomseed(s)
    rand = math.random(1,2)
    
    if(rand == 1) then
    
      if(self.y > playerDim[4] - 16) then
        self.directionFacing = 'north'
      end
    
    if(self.y - 110 < playerDim[4] - 16) then
        self.directionFacing = 'south'
      end
    
    end
    
    if(rand == 2) then
      
      if(self.x + 60 > playerDim[1] + 16) then
        self.directionFacing = 'west'
      end
      if(self.x + 100 < playerDim[1] + 16) then
        self.directionFacing = 'east'
      end
      
      
    end
    
    
  end
  
  end
  
  
end

function EgyptBoss1:DecideState()
  
  self.characterState = 'walk'
  
  if(self.rushTime > 0) then
    self.rushTime = self.rushTime -1
    self.characterState = 'ram'
  end
  
  
  if(self.recoveryTime > 0) then
    self.characterState = 'idle'
    self.recoveryTime = self.recoveryTime - 1
  end
  
  
end


function EgyptBoss1:StartRam()
  
  self.rushTime = 60
  self.characterState = 'ram'
  
end


function EgyptBoss1:TakeDamage(damage)
  
  self.health = self.health - damage
    table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x + 80,self.y, tostring(damage),Color.new(255,255,255)))
  self.hurtTimer = 3
end

function EgyptBoss1:HurtTimer()
  
  if(self.hurtTimer > 0) then
self.hurtColor = Color.new(255,0,0)
self.hurtTimer = self.hurtTimer - 1
  end
  
  if(self.hurtTimer <= 0) then
self.hurtColor = Color.new(255,255,255)
  end
  
  
end


function EgyptBoss1:GetDimensions()
  
  if(self.directionFacing == "north" or self.directionFacing == "south") then
    return{self.x + 24, self.x + 160 - 24, self.y, self.y + 128}
  end
  
  if(self.directionFacing == "east" or self.directionFacing == "west") then
  return{self.x + 40, self.x + 160 - 40, self.y, self.y + 128}  
  end
  
  
end

function EgyptBoss1:CheckLife()
  if(self.health <= 0) then
    self.isDead = true  
  end

end


function EgyptBoss1:Update()
  self:DecideState()
  self:DecideDirection()
  self:Ram()
  self:HurtTimer()
  self:CheckLife()
  self:Move()
  
  return self.isDead
end
