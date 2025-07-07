HealBeam = {}
healBeamImg = Graphics.loadImage("app0:/Sprites/HealEffect.png")

function HealBeam:New(x,y,direction, parent)
  healBeam = {}
  setmetatable(healBeam, self)
  self.__index = self
  
  healBeam.x = x
  healBeam.y = y
  healBeam.directionFacing = direction
  healBeam.isDead = false
  healBeam.currentFrame = 0
  healBeam.speed = 12
  healBeam.healPower = 2
  healBeam.height = 8
  healBeam.width = 16
  healBeam.parent = parent
  return healBeam
end

function HealBeam:Draw()
  
  self.currentFrame = self.currentFrame + 1
  
  if(self.directionFacing == "north") then
    if(self.currentFrame >= 1 and self.currentFrame <= 3) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 0, 16, 8, 1, 1, healBeamImg)
    end
    
    if(self.currentFrame >= 4 and self.currentFrame <= 6) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 16, 0, 16, 8, 1, 1, healBeamImg)
    end
    
    if(self.currentFrame >= 7 and self.currentFrame <= 9) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 8, 16, 8, 1, 1, healBeamImg)
    end
    
    if(self.currentFrame >= 10 and self.currentFrame <= 12) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 16, 8, 16, 8, 1, 1, healBeamImg)
    end
    
    if(self.currentFrame >= 13) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 0, 16, 16, 8, 1, 1, healBeamImg)
    end
  
  end
  
  if(self.directionFacing == "south") then
    if(self.currentFrame >= 1 and self.currentFrame <= 3) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY + 16, 0, 0, 16, 8, 1, -1, healBeamImg)
    end
    
    if(self.currentFrame >= 4 and self.currentFrame <= 6) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY + 16, 16, 0, 16, 8, 1, -1, healBeamImg)
    end
    
    if(self.currentFrame >= 7 and self.currentFrame <= 9) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY + 16, 0, 8, 16, 8, 1, -1, healBeamImg)
    end
    
    if(self.currentFrame >= 10 and self.currentFrame <= 12) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY + 16, 16, 8, 16, 8, 1, -1, healBeamImg)
    end
    
    if(self.currentFrame >= 13) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY + 16, 0, 16, 16, 8, 1, -1, healBeamImg)
    end
  end
  
  if(self.directionFacing == "east") then
    if(self.currentFrame >= 1 and self.currentFrame <= 3) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY , 32, 0, 8, 16, 1, 1, healBeamImg)
    end
    
    if(self.currentFrame >= 4 and self.currentFrame <= 6) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 40, 0, 8, 16, 1, 1, healBeamImg)
    end
    
    if(self.currentFrame >= 7 and self.currentFrame <= 9) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 32, 16, 8, 16, 1, 1, healBeamImg)
    end
    
    if(self.currentFrame >= 10 and self.currentFrame <= 12) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 40, 16, 8, 16, 1, 1, healBeamImg)
    end
    
    if(self.currentFrame >= 13) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 32, 32, 8, 16, 1, 1, healBeamImg)
    end
  end
  
  if(self.directionFacing == "west") then
    if(self.currentFrame >= 1 and self.currentFrame <= 3) then
      Graphics.drawImageExtended(self.x - cameraX + 8, self.y - cameraY , 32, 0, 8, 16, -1, 1, healBeamImg)
    end
    
    if(self.currentFrame >= 4 and self.currentFrame <= 6) then
      Graphics.drawImageExtended(self.x - cameraX + 8, self.y - cameraY, 40, 0, 8, 16, -1, 1, healBeamImg)
    end
    
    if(self.currentFrame >= 7 and self.currentFrame <= 9) then
      Graphics.drawImageExtended(self.x - cameraX + 8, self.y - cameraY, 32, 16, 8, 16, -1, 1, healBeamImg)
    end
    
    if(self.currentFrame >= 10 and self.currentFrame <= 12) then
      Graphics.drawImageExtended(self.x - cameraX + 8, self.y - cameraY, 40, 16, 8, 16, -1, 1, healBeamImg)
    end
    
    if(self.currentFrame >= 13) then
      Graphics.drawImageExtended(self.x - cameraX + 8, self.y - cameraY, 32, 32, 8, 16, -1, 1, healBeamImg)
    end
  end
  
end

function HealBeam:Move()
   if(self.directionFacing == "west") then
    
    distance = self:Raycast(self.directionFacing, self.speed)
    distance = self:RaycastEnemy(self.directionFacing, distance)
    self.x = self.x - distance
    
  end
  
  if(self.directionFacing == "east") then
    
    distance = self:Raycast(self.directionFacing, self.speed)
    distance = self:RaycastEnemy(self.directionFacing, distance)
    self.x = self.x + distance
    
  end
  
  if(self.directionFacing == "north") then
    
    distance = self:Raycast(self.directionFacing, self.speed)
    distance = self:RaycastEnemy(self.directionFacing, distance)
    self.y = self.y - distance
    
  end
  
  if(self.directionFacing == "south") then
    
    distance = self:Raycast(self.directionFacing, self.speed)
    distance = self:RaycastEnemy(self.directionFacing, distance)
    self.y = self.y + distance
    
  end
end

function HealBeam:CheckLife()
  
  if(self.currentFrame >= 20) then
  self.isDead = true  
  end
  
  
end


function HealBeam:RaycastEnemy(direction, speed) 
  tempEnemyObj = nil
  speed = speed
  if(direction == "north") then
    for i, value in ipairs(playerObj) do
    enemyDim = playerObj[i]:GetDimensions()
      if(self.parent ~= playerObj[i]) then
          if(self.x <= enemyDim[2] and self.x + self.width >= enemyDim[1]) then
            if(self.y - speed <= enemyDim[4] and self.y + self.height >= enemyDim[3]) then
              
              tempEnemyObj = playerObj[i]
              speed = self.y - enemyDim[4]
                
                if(speed < 0) then
                speed = 0  
                end
              
            end
          end
      end
    end
  end
 
  
  if(direction == "south") then
    for i, value in ipairs(playerObj) do
    enemyDim = playerObj[i]:GetDimensions()
    if(self.parent ~= playerObj[i]) then
    if(self.x <= enemyDim[2] and self.x + self.width >= enemyDim[1]) then
      if(self.y  <= enemyDim[4] and self.y + self.height + speed >= enemyDim[3]) then
        
        tempEnemyObj = playerObj[i]
        speed = enemyDim[4] - self.y + self.height
        
        if(speed < 0) then
        speed = 0  
        end
        
        
      end
    end
    end
    end
 end
  
  if(direction == "east") then
    for i, value in ipairs(playerObj) do
    enemyDim = playerObj[i]:GetDimensions()
    if(self.parent ~= playerObj[i]) then
      if(self.y<= enemyDim[4] and self.y + self.height >= enemyDim[3]) then
        if(self.x <= enemyDim[2] and self.x + self.width + speed >= enemyDim[1]) then
          tempEnemyObj = playerObj[i]
          speed = enemyDim[1] - self.x + self.width
          if(speed < 0) then
          speed = 0  
          end
          
        end
      end
      end
    end
  
    end

   
 
  
  if(direction == "west") then
    for i, value in ipairs(playerObj) do
      enemyDim = playerObj[i]:GetDimensions()
      if(self.parent ~= playerObj[i]) then
        if(self.y<= enemyDim[4] and self.y + self.height >= enemyDim[3]) then
          if(self.x - speed <= enemyDim[2] and self.x + self.width >= enemyDim[1]) then
            tempEnemyObj = playerObj[i]
            speed = self.x - enemyDim[2]
              if(speed < 0) then
              speed = 0  
              end
            end
        end
      end
    end
    end
if(tempEnemyObj ~= nil) then
tempEnemyObj:HealWave(self.healPower)
self.isDead = true
return speed
end

return speed
  end

function HealBeam:Raycast(direction, speed)
    
    if(direction == "west") then
      
      for i, value in ipairs(tileObj) do
        
        if(tileObj[i].isVisible == false) then
          
        break  
        end
        
        
        if(tileObj[i].isCollidable == true) then
          tileDim = tileObj[i]:GetDimensions()
        if(self.y < tileDim[4] and self.y + self.height > tileDim[3]) then
        
          if(self.x - speed < tileDim[2] and self.x + self.width> tileDim[2]) then
          self.isDead = true
          return self.x - tileDim[2]
            
          end
        
            
        end
        
        
      end
      
      end
      
      return speed
    end
    
    if(direction == "east") then
      
      for i, value in ipairs(tileObj) do
        
        if(tileObj[i].isVisible == false) then
          
        break  
        end
        
        if(tileObj[i].isCollidable == true) then
          tileDim = tileObj[i]:GetDimensions()
          
        if(self.y < tileDim[4] and self.y + self.height > tileDim[3]) then
        
          if(self.x + self.width + speed > tileDim[1] and self.x <= tileDim[1]) then
          
           self.isDead = true
          return  self.x + self.width - tileDim[1]
            
          end
        
          
        end
        
        
      end
      
      end
      return speed
    end
    
    if(direction == "north") then
      
      for i, value in ipairs(tileObj) do
        
        if(tileObj[i].isVisible == false) then
          
        break  
        end
        
        if(tileObj[i].isCollidable == true) then
        tileDim = tileObj[i]:GetDimensions()
        if(self.x < tileDim[2] and self.x + self.width > tileDim[1]) then
        
        if(self.y - speed < tileDim[4] and self.y >= tileDim[4]) then
        
         self.isDead = true
        return self.y - tileDim[4]
          
        end
        
          
        end
        
        
      end
      
      end
      return speed
    end
    
    if(direction == "south") then
      
      for i, value in ipairs(tileObj) do
        
        if(tileObj[i].isVisible == false) then
          
          break  
        end
        
        if(tileObj[i].isCollidable == true) then
          tileDim = tileObj[i]:GetDimensions()
          if(self.x < tileDim[2] and self.x + self.width > tileDim[1]) then
            if(self.y + self.height  + speed > tileDim[3] and self.y <= tileDim[3]) then
              self.isDead = true
              return tileDim[3] - self.y -32  
            end
          end 
        end
      end
      
    end
    
    return speed
  end
  
  function HealBeam:CheckIfOnScreen()
    if(self.x - cameraX < - 20 or self.x - cameraX > 960) then
   self.isDead = true   
  end
  
  if(self.y - cameraY < - 20 or self.y - cameraY > 544) then
  self.isDead = true  
  end
  
    
  end


function HealBeam:Update()
  self:Move()
  self:CheckLife()
  
  
  return self.isDead
  end

