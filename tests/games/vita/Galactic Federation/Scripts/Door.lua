Door = {}

function Door:New(x,y, orgin, direction)
  door = {}
  setmetatable(door, self)
  self.__index = self
  door.x = x
  door.y = y
  door.direction = direction
  door.lockType = ""
  door.orgin = orgin
  
  door.isDead = false
  
  return door
end

function Door:Draw()
  
  if(self.direction == "north") then
    Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,64,96,32,32, tile1Image) 
    Graphics.drawPartialImage(self.x + 32 - cameraX, self.y - cameraY,64,96,32,32, tile1Image) 
  end
  
  if(self.direction == "east") then
     Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,96,96,32,32, tile1Image) 
    Graphics.drawPartialImage(self.x  - cameraX, self.y + 32 - cameraY,96,96,32,32, tile1Image) 
  end
  
  
end

function Door:GetLockType()
  
  if(self.lockType ~= "") then
    return
  end
  
  
  
  for i = #mapLoaderObj, 1, -1 do
    
      if(mapLoaderObj[i].name == "egypt1") then
        
        if(self.orgin[1] == 579 and self.orgin[2] == 165) then
          self.lockType = "Key"
        end
        
        if(self.orgin[1] == 548 and self.orgin[2] == 147) then
          self.lockType = "Key"
        end
        
        if(self.orgin[1] == 617 and self.orgin[2] == 111) then
          self.lockType = "Key"
        end
        
        -- Need orgin for these 2
        if(self.orgin[1] == 744 and self.orgin[2] == 67) then
          self.lockType = "Key Lv 1"
        end
        
        if(self.orgin[1] == 597 and self.orgin[2] == 159) then
          self.lockType = "Key Lv 1"
        end
        -- Boss key
        if(self.orgin[1] == 438 and self.orgin[2] == 118) then
          self.lockType = "Key Lv 2"
        end
        
      end
    end
    
  
end

function Door:Unlock()
  
end

function Door:CheckLock()
  
end

function Door:GetDimensions()
  
  if(self.direction == "north") then
    return{self.x, self.x + 64, self.y + 16, self.y + 32}
  end
  
  if(self.direction == "east") then
    return{self.x, self.x + 16, self.y, self.y + 64}
  end
  
end


function Door:Update()
  self:GetLockType()
  table.insert(collidableObj, #collidableObj + 1, self)
  return self.isDead
end

