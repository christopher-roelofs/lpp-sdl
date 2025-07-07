AlienPunchEffect = {}
alienPunchEffectImg = Graphics.loadImage("app0:/Sprites/Alien Attack Effect.png");

function AlienPunchEffect:New(x,y,directionFacing)
alienPunchEffect = {}
setmetatable(alienPunchEffect,self)
self.__index = self
alienPunchEffect.x = x
alienPunchEffect.y = y
alienPunchEffect.currentFrame = 0
alienPunchEffect.directionFacing = directionFacing
alienPunchEffect.isDead = false
alienPunchEffect.isActive = true
alienPunchEffect.power = 8
return alienPunchEffect
end

function AlienPunchEffect:GetSelf()
return self  
end




function AlienPunchEffect:Draw()
  
  self.currentFrame = self.currentFrame + 1
  
  if(self.directionFacing == "north") then
  
      if(self.currentFrame <= 2) then
        Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,0,0,12,16,1,1,alienPunchEffectImg)
      end
      
      if(self.currentFrame >= 3 and self.currentFrame <= 4) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,12,0,12,16,1,1,alienPunchEffectImg)
    end

     if(self.currentFrame >= 5 and self.currentFrame <= 6) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,24,0,12,16,1,1,alienPunchEffectImg)
       end
       
       if(self.currentFrame >= 7 and self.currentFrame <= 8) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,0,16,12,16,1,1,alienPunchEffectImg)
    end

     if(self.currentFrame >= 9 and self.currentFrame <= 10) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,12,16,12,16,1,1,alienPunchEffectImg)
    end

     if(self.currentFrame >= 11 and self.currentFrame <= 12) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,24,16,12,16,1,1,alienPunchEffectImg)
    end

     if(self.currentFrame >= 13 and self.currentFrame <= 14) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,0,32,12,16,1,1,alienPunchEffectImg)
    end


     if(self.currentFrame >= 15 and self.currentFrame <= 16) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,12,32,12,16,1,1,alienPunchEffectImg)
    end

     if(self.currentFrame >= 17 and self.currentFrame <= 18) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,24,32,12,16,1,1,alienPunchEffectImg)
      end
end


  if(self.directionFacing == "south") then
  
      if(self.currentFrame <= 2) then
        Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY + 16,0,0,12,16,1,-1,alienPunchEffectImg)
      end
      
      if(self.currentFrame >= 3 and self.currentFrame <= 4) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY + 16,12,0,12,16,1,-1,alienPunchEffectImg)
    end

     if(self.currentFrame >= 5 and self.currentFrame <= 6) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY + 16,24,0,12,16,1,-1,alienPunchEffectImg)
       end
       
       if(self.currentFrame >= 7 and self.currentFrame <= 8) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY + 16,0,16,12,16,1,-1,alienPunchEffectImg)
    end

     if(self.currentFrame >= 9 and self.currentFrame <= 10) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY + 16,12,16,12,16,1,-1,alienPunchEffectImg)
    end

     if(self.currentFrame >= 11 and self.currentFrame <= 12) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY + 16,24,16,12,16,1,-1,alienPunchEffectImg)
    end

     if(self.currentFrame >= 13 and self.currentFrame <= 14) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY + 16,0,32,12,16,1,-1,alienPunchEffectImg)
    end


     if(self.currentFrame >= 15 and self.currentFrame <= 16) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY + 16,12,32,12,16,1,-1,alienPunchEffectImg)
    end

     if(self.currentFrame >= 17 and self.currentFrame <= 18) then
      Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY + 16,24,32,12,16,1,-1,alienPunchEffectImg)
      end
end

if(self.directionFacing == "east") then
  if(self.currentFrame <= 2) then
    Graphics.drawImageExtended(self.x - cameraX,self.y,36,0,16,12,1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 3 and self.currentFrame <= 4) then
    Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,52,0,16,12,1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 5 and self.currentFrame <= 6) then
    Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,68,0,16,12,1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 7 and self.currentFrame <= 8) then
    Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,36,12,16,12,1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 9 and self.currentFrame <= 10) then
    Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,52,12,16,12,1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 11 and self.currentFrame <= 12) then
    Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,68,12,16,12,1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 13 and self.currentFrame <= 14) then
    Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,36,24,16,12,1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 15 and self.currentFrame <= 16) then
    Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,52,24,16,12,1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 17 and self.currentFrame <= 18) then
    Graphics.drawImageExtended(self.x - cameraX,self.y - cameraY,68,24,16,12,1,1,alienPunchEffectImg)
    end
  end
  
  if(self.directionFacing == "west") then
  if(self.currentFrame <= 2) then
    Graphics.drawImageExtended(self.x - cameraX + 16,self.y - cameraY,36,0,16,12,-1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 3 and self.currentFrame <= 4) then
    Graphics.drawImageExtended(self.x - cameraX + 16,self.y - cameraY,52,0,16,12,-1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 5 and self.currentFrame <= 6) then
    Graphics.drawImageExtended(self.x - cameraX + 16,self.y - cameraY,68,0,16,12,-1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 7 and self.currentFrame <= 8) then
    Graphics.drawImageExtended(self.x - cameraX + 16,self.y - cameraY,36,12,16,12,-1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 9 and self.currentFrame <= 10) then
    Graphics.drawImageExtended(self.x - cameraX + 16,self.y - cameraY,52,12,16,12,-1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 11 and self.currentFrame <= 12) then
    Graphics.drawImageExtended(self.x - cameraX + 16,self.y - cameraY,68,12,16,12,-1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 13 and self.currentFrame <= 14) then
    Graphics.drawImageExtended(self.x - cameraX + 16,self.y - cameraY,36,24,16,12,-1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 15 and self.currentFrame <= 16) then
    Graphics.drawImageExtended(self.x - cameraX + 16,self.y - cameraY,52,24,16,12,-1,1,alienPunchEffectImg)
    end
    if(self.currentFrame >= 17 and self.currentFrame <= 18) then
    Graphics.drawImageExtended(self.x - cameraX + 16,self.y - cameraY,68,24,16,12,-1,1,alienPunchEffectImg)
    end
  end
  
  
end

function AlienPunchEffect:SetPosition(x,y)
  
  self.x = x
  self.y = y
  
end


function AlienPunchEffect:CheckEnemyCollision()
  
  if(self.isActive == false) then
    
    return
  end
  
  
  if(self.directionFacing == 'north') then
    for i, value in ipairs(enemyObj) do
      enemyDim = enemyObj[i]:GetDimensions()
      
      if(self.x <= enemyDim[2] and self.x + 12 >= enemyDim[1]) then
        
        if(self.y <= enemyDim[4] and self.y + 16 >= enemyDim[3]) then
          
          enemyObj[i]:TakeDamage(self.power)
          self.isActive = false
          
        end
        
      end
            
    end
  end
  
  if(self.directionFacing == 'south') then
    
    for i, value in ipairs(enemyObj) do
      enemyDim = enemyObj[i]:GetDimensions()
      
      if(self.x <= enemyDim[2] and self.x + 12 >= enemyDim[1]) then
        
        if(self.y <= enemyDim[4] and self.y + 16 >= enemyDim[3]) then
          
          enemyObj[i]:TakeDamage(self.power)
           self.isActive = false
          
        end
        
      end
            
    end
    
  end
  
  if(self.directionFacing == 'east' or self.directionFacing == 'west') then
    
     for i, value in ipairs(enemyObj) do
      enemyDim = enemyObj[i]:GetDimensions()
      
      if(self.x <= enemyDim[2] and self.x + 16 >= enemyDim[1]) then
        
        if(self.y <= enemyDim[4] and self.y + 12 >= enemyDim[3]) then
          
          enemyObj[i]:TakeDamage(self.power)
          self.isActive = false
          
        end
        
      end
            
    end
    
  end
  
  
  
  
end


function AlienPunchEffect:Update()
  self:CheckEnemyCollision()
  
  return self.isDead
end
