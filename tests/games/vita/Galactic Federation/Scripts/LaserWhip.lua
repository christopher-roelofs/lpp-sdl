LaserWhip = {}
laserWhipImage = Graphics.loadImage("app0:/Sprites/AndroidLaserWhip.png");

function LaserWhip:New(x,y,direction)
  laserWhip = {}
  setmetatable(laserWhip, self)
  self.__index = self
  laserWhip.directionFacing = direction
  laserWhip.currentFrame = 0
  laserWhip.isDead = false
  laserWhip.x = x
  laserWhip.y = y
  laserWhip.power = 3
  laserWhip.speed = 0
  laserWhip.height = 148
  laserWhip.width = 16
  laserWhip.hurtTime = 0
  return laserWhip
end

function LaserWhip:GetSelf()
  
  return self
end

function LaserWhip:KillSelf()
self.isDead = true  
end



function LaserWhip:Draw()
  self.currentFrame = self.currentFrame + 1
  
if(self.directionFacing == "north") then  
  
    if(self.currentFrame >= 1 and self.currentFrame <=2) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,0,0,16,48,1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 3 and self.currentFrame <=4) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,16,0,16,48,1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 5 and self.currentFrame <=6) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,0,48,16,48,1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 7 and self.currentFrame <=8) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,16,48,16,48,1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 9 and self.currentFrame <=10) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,0,96,16,48,1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 11 and self.currentFrame <=12) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,16,96,16,48,1,1, laserWhipImage)
    end
  end
  
  
  if(self.directionFacing == "south") then  
  
    if(self.currentFrame >= 1 and self.currentFrame <=2) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,0,0,16,48,1,-1, laserWhipImage)
    end
    
    if(self.currentFrame >= 3 and self.currentFrame <=4) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,16,0,16,48,1,-1, laserWhipImage)
    end
    
    if(self.currentFrame >= 5 and self.currentFrame <=6) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,0,48,16,48,1,-1, laserWhipImage)
    end
    
    if(self.currentFrame >= 7 and self.currentFrame <=8) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,16,48,16,48,1,-1, laserWhipImage)
    end
    
    if(self.currentFrame >= 9 and self.currentFrame <=10) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,0,96,16,48,1,-1, laserWhipImage)
    end
    
    if(self.currentFrame >= 11 and self.currentFrame <=12) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,16,96,16,48,1,-1, laserWhipImage)
    end
  end
  
  if(self.directionFacing == "east") then
    
    if(self.currentFrame >= 1 and self.currentFrame <=2) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,32,0,48,16,1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 3 and self.currentFrame <=4) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,32,16,48,16,1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 5 and self.currentFrame <=6) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,32,32,48,16,1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 7 and self.currentFrame <=8) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,32,48,48,16,1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 9 and self.currentFrame <=10) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,32,64,48,16,1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 11 and self.currentFrame <=12) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,32,80,48,16,1,1, laserWhipImage)
    end
    
  end
  
  
  if(self.directionFacing == "west") then
    if(self.currentFrame >= 1 and self.currentFrame <=2) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,32,0,48,16,-1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 3 and self.currentFrame <=4) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,32,16,48,16,-1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 5 and self.currentFrame <=6) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,32,32,48,16,-1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 7 and self.currentFrame <=8) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,32,48,48,16,-1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 9 and self.currentFrame <=10) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,32,64,48,16,-1,1, laserWhipImage)
    end
    
    if(self.currentFrame >= 11 and self.currentFrame <=12) then
      Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY,32,80,48,16,-1,1, laserWhipImage)
    end
  end
  
    
  
  if(self.currentFrame >= 12) then
  self.currentFrame = 0  
  end
  
  
  
end

function LaserWhip:UpdatePosition(x,y,direction)
  
  self.x = x
  self.y = y
  self.directionFacing = direction
  
end



function LaserWhip:RaycastEnemy(direction, speed) 
  tempEnemyObj = nil
  if(direction == "north") then
    for i, value in ipairs(enemyObj) do
    enemyDim = enemyObj[i]:GetDimensions()
    
    if(self.x <= enemyDim[2] and self.x + self.width >= enemyDim[1]) then
      if(self.y  <= enemyDim[4] and self.y + self.height >= enemyDim[3]) then
        tempEnemyObj = enemyObj[i]

      end
    end
    
    end
  end
 
  
  if(direction == "south") then
    for i, value in ipairs(enemyObj) do
    enemyDim = enemyObj[i]:GetDimensions()
    
    if(self.x <= enemyDim[2] and self.x + self.width >= enemyDim[1]) then
      if(self.y - self.height  <= enemyDim[4] and self.y  >= enemyDim[3]) then
        
        tempEnemyObj = enemyObj[i]

      end
    end
    
    end
 end
  
  if(direction == "east") then
    for i, value in ipairs(enemyObj) do
    enemyDim = enemyObj[i]:GetDimensions()
    if(self.y<= enemyDim[4] and self.y + self.height >= enemyDim[3]) then
  if(self.x <= enemyDim[2] and self.x + self.width  >= enemyDim[1]) then
    tempEnemyObj = enemyObj[i]
    
    
    end
    end

    end
  
    end

   
 
  
  if(direction == "west") then
    for i, value in ipairs(enemyObj) do
      enemyDim = enemyObj[i]:GetDimensions()
    if(self.y<= enemyDim[4] and self.y + self.height >= enemyDim[3]) then
  if(self.x - self.width <= enemyDim[2] and self.x  >= enemyDim[1]) then
    tempEnemyObj = enemyObj[i]
    
    end
    end
    end
    end
if(tempEnemyObj ~= nil) then
  if(self.hurtTime <= 0) then
tempEnemyObj:TakeDamage(self.power)
self.hurtTime = 20
end



end


end

function LaserWhip:UpdateTime()
  
  if(self.hurtTime > 0) then
  self.hurtTime = self.hurtTime - 1  
  end
  
  
end


function LaserWhip:UpdateHeightAndWidth()
  if(self.directionFacing == "north" or self.directionFacing == "south") then
    self.width = 16
    self.height = 48
  end
  
  if(self.directionFacing == "east" or self.directionFacing == "west") then
    self.width = 48
    self.height = 16
  end
  
end




function LaserWhip:Update()
  self:UpdateTime()
  self:UpdateHeightAndWidth()
  self:RaycastEnemy(self.directionFacing, 0)
  return self.isDead
end
