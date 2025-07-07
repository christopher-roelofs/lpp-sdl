Camera = {}
cameraX = 0
cameraY = 0


function Camera:New(x,y)
  camera = {}
  setmetatable(camera, self)
  self.__index = self
  
  camera.x = x
  camera.y = y
  
  camera.worldWidth = 1000
  camera.worldHeight = 1000
  
  return camera
  
end

function Camera:GetWorldSize(tempMap)
  
  self.worldHeight = (#tempMap * 32) + 80
    self.worldWidth = #tempMap[1] * 32
  worldHeight = self.worldHeight
  worldWidth = self.worldWidth
  
  
end


function Camera:MoveLeft(distance)
  
  if(self.x - distance < 0) then
    
    self.x = 0
    
  else
    
    self.x = self.x - distance
    
  end
  
  
end

function Camera:MoveRight(distance)
  
  if(self.x + 960 + distance > self.worldWidth) then
  
  self.x = self.worldWidth - 960
  
else
  
  self.x = self.x + distance
  
  end
  
  
end

function Camera:MoveUp(distance)
  
  if(self.y - distance < 0) then
  
  self.y = 0
  
  else
  
  self.y = self.y - distance
    
  end
  
  
end

function Camera:MoveDown(distance)
  
  if(self.y + 544 + distance > self.worldHeight) then
  
  self.y = self.worldHeight - 544
  
  else
    
    self.y = self.y + distance
    
  end

end

function Camera:GetCameraPosition()
  
  cameraX = self.x
  cameraY = self.y
  
end


function Camera:Update()
  
  
end
