MiniMap = {}

function MiniMap:New()
  miniMap = {}
  setmetatable(miniMap, self)
  self.__index = self
  miniMap.x = 0
  miniMap.y = 0
  miniMap.isDead = false
  miniMap.img = nil
  return miniMap
end

function MiniMap:Draw()
  
  if(self.img ~= nil) then
    Graphics.drawImage(10, 10, self.img) 
  end
  
  
    Graphics.fillRect(0, 960, 0, 544, Color.new(0,0,0)) 
  if (self.img == nil) then
    self.img =  Graphics.createImage(10, 10) 
  
  
  

  
  for i = 1, #mapLoaderObj, 1 do
    
    for y = 1, #mapLoaderObj[i].tiles, 1 do
      
      for x = 1, #mapLoaderObj[i].tiles[y], 1 do
      
        if(mapLoaderObj[i].tiles[y][x] >= 1 and mapLoaderObj[i].tiles[y][x] <= 6 or mapLoaderObj[i].tiles[y][x] == 13) then
         self.img =  Graphics.drawPixel(x- self.x, y - self.y, Color.new(160,160,33)) 
        end
        
        if( mapLoaderObj[i].tiles[y][x] == 7 or mapLoaderObj[i].tiles[y][x] == 8 or mapLoaderObj[i].tiles[y][x] == 9 or mapLoaderObj[i].tiles[y][x] == 10 or mapLoaderObj[i].tiles[y][x] == 11 or mapLoaderObj[i].tiles[y][x] == 12) then
          self.img = Graphics.drawPixel(x - self.x, y-self.y, Color.new(255,0,0)) 
        end
        
      
      end
      
    end
    
  end
end
for i = 1, #playerObj, 1 do
  Graphics.fillRect(math.ceil(playerObj[i].x/32), math.ceil(playerObj[i].x/32) + 4, math.ceil(playerObj[i].y/32), math.ceil(playerObj[i].y/32) + 4, Color.new(0,0,255)) 
end


end

function MiniMap:MoveMap()
  
  for i = 1, #controllerObj, 1 do
    
    if(controllerObj[i].padUpIsPressed == true) then
      
      self.y = self.y - 1
      
    end
    
    if(controllerObj[i].padDownIsPressed == true) then
      
      self.y = self.y + 1
      
    end
    
    
    if(controllerObj[i].padLeftIsPressed == true) then
      self.x = self.x - 1
    end
    
     if(controllerObj[i].padRightIsPressed == true) then
      self.x = self.x + 1
    end
    
    
  end

  
end


function MiniMap:Close()
  
   for i = 1, #controllerObj, 1 do
     
     if(controllerObj[i].selectIsPressed == true and controllerObj[i].selectCanBePressed == true) then
     self.isDead = true  
     end
     
     
   end
   
  
end


function MiniMap:Update()
  self:Close()
  --self:MoveMap()
  return self.isDead
end

