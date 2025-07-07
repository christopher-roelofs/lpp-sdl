Tiles = {}
tile1Image = Graphics.loadImage("app0:/Sprites/SandTileSet.png")



function Tiles:New(x, y, tile, canCollide)

tiles = {}
setmetatable(tiles, self)
self.__index = self

tiles.isVisible = false
tiles.currentTile = tile
tiles.isCollidable = canCollide
tiles.x = x
tiles.y = y

return tiles
end


function Tiles:UpdatePosition(xPos, yPos, tileType, collide)
  
  self.x = xPos
  self.y = yPos
  self.currentTile = tileType
  self.isCollidable = collide
  self.isVisible = true
  
 
  
end


function Tiles:Draw()
  
  if(self.isVisible == true) then
    if(self.currentTile == 1) then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,0,0,32,32, tile1Image) 
    end
    
    if(self.currentTile == 2) then
       Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,32,0,32,32, tile1Image) 
    end
    
    if(self.currentTile == 3) then
       Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,64,0,32,32, tile1Image) 
    end
    
    if(self.currentTile == 4) then
       Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,96,0,32,32, tile1Image) 
    end
    
    if(self.currentTile == 5) then
       Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,0,32,32,32, tile1Image) 
    end
    
    if(self.currentTile == 6) then
       Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,32,32,32,32, tile1Image) 
    end
    
    if(self.currentTile == 7) then
       Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,64,32,32,32, tile1Image) 
    end
    if(self.currentTile == 8) then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,96,32,32,32, tile1Image) 
    end
    
    if(self.currentTile == 9) then
       Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,0,64,32,32, tile1Image) 
    end
    
    if(self.currentTile == 10) then
       Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,32,64,32,32, tile1Image) 
    end
    
    if(self.currentTile == 11) then
       Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,64,64,32,32, tile1Image) 
    end
    
    if(self.currentTile == 12) then
       Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,96,64,32,32, tile1Image) 
    end
    
    if(self.currentTile == 13) then
       Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,0,96,32,32, tile1Image) 
    end
    
    if(self.currentTile == 14) then
       Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,32,96,32,32, tile1Image) 
    end
    
    

return true
else
  
  return false
end



end


function Tiles:CheckXPosition()

  for i, value in ipairs(cameraObj) do
      

    if(self.x + 32 >= cameraObj[i].x and self.x <= cameraObj[i].x + 960) then


    self.isVisible = true


    else


    self.isVisible = false


    end

  end

end


function Tiles:GetDimensions()
  
  return {self.x, self.x + 32, self.y, self.y + 32}
end



function Tiles:CheckYPosition()


for i, value in ipairs(cameraObj) do
     
  if(self.y + 32 >= cameraObj[i].y and self.y <= cameraObj[i].y + 544) then


  self.isVisible = true


  else


  self.isVisible = false


  end

  end

end

function Tiles:DisableTile()
  
  self.isVisible = false
  self.x = -100
  self.y = - 100
  
  
end



function Tiles:Update()
self:CheckXPosition()
self:CheckYPosition()


end