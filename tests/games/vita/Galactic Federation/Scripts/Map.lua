Map = {}



function SetCameraWidth(map)
  for i, value in ipairs(cameraObj) do
  
  cameraObj[i]:GetWorldSize(map)
  
  end
  
end


function Map:New(currentMap,currentItems)
  map = {}
  setmetatable(map, self)
  self.__index = self
  map.currentMap = currentMap
  map.currentItems = currentItems
  SetCameraWidth(currentMap)
  return map
end





function Map:DrawMap()
  xRange = math.floor(cameraX / 32) + 1
  yRange = math.floor(cameraY / 32) + 1
  
  for i = #collidableParentObj, 1, -1 do
    
    collidableParentObj[i]:GetRange(xRange,yRange)
    
  end
  
  
  currentTileNumber = 1
for y = yRange, yRange + 19, 1 do
  if( y >#self.currentMap) then
  break  
  end
  
  for x = xRange, xRange + 32, 1 do
    if(x > #self.currentMap[y]) then
    break  
    end
    
    coll = false
    if(self.currentMap[y][x] == 7 or self.currentMap[y][x] == 8 or self.currentMap[y][x] == 9 or self.currentMap[y][x] == 10 or self.currentMap[y][x] == 11 or self.currentMap[y][x] == 12 or self.currentMap[y][x] == 14) then
      coll = true
      
      for i = #collidableParentObj, 1, -1 do
        
        collidableParentObj[i].array[y - yRange + 1][x - xRange + 1] = 1
        
      end
      
      
    else
      coll = false
      
      for i = #collidableParentObj, 1, -1 do
        
        collidableParentObj[i].array[y - yRange + 1][x - xRange + 1] = 0
        
      end
      
    end
    
    tileObj[currentTileNumber]:UpdatePosition((x-1) * 32, (y-1) * 32, self.currentMap[y][x], coll)
    currentTileNumber = currentTileNumber + 1
    
  end
end

for i = currentTileNumber, 1, #tileObj do
tileObj[currentTileNumber]:DisableTile()
end


end

function Map:DrawItems()
  xRange = math.floor(cameraX / 32) + 1
  yRange = math.floor(cameraY / 32) + 1
  
  
  for y = yRange, yRange + 19, 1 do
  if( y >#self.currentItems) then
  break  
  end
  
  for x = xRange, xRange + 32, 1 do
    if(x > #self.currentItems[y]) then
    break  
    end
    
    
    if(self.currentItems[y][x] == 15) then
      table.insert(doorObj, #doorObj + 1, Door:New((x - 1) * 32, (y - 1) * 32, {x,y}, "north"))
      self.currentItems[y][x] = 0
    end
    
    if(self.currentItems[y][x] == 16) then
      table.insert(enemyObj, #enemyObj + 1, Bat:New((x - 1) * 32, (y - 1)* 32, false, nil, {x,y,16}))
      self.currentItems[y][x] = 0
    end
    
    if(self.currentItems[y][x] == 17) then
      table.insert(enemyObj, #enemyObj + 1, Bug:New((x - 1) * 32, (y - 1)* 32, false, nil, {x,y, 17}))
      self.currentItems[y][x] = 0
    end
    
    if(self.currentItems[y][x] == 18) then
      table.insert(enemyObj, #enemyObj + 1, Slime:New((x - 1) * 32, (y - 1)* 32, false, nil, {x,y,18}))
      self.currentItems[y][x] = 0
    end
    
    if(self.currentItems[y][x] == 19) then
      table.insert(enemyObj, #enemyObj + 1, EnemyGenerator:New((x - 1) * 32, (y - 1)* 32, 5, 'bat1', 10, {x,y,19}))
      self.currentItems[y][x] = 0
    end
    
    if(self.currentItems[y][x] == 20) then
      
      table.insert(enemyObj, #enemyObj + 1, EnemyGenerator:New((x - 1) * 32, (y - 1)* 32, 3, 'slime1', 25, {x,y,20}))
     self.currentItems[y][x] = 0
    end
    
    if(self.currentItems[y][x] == 21) then
      table.insert(enemyObj, #enemyObj + 1, EnemyGenerator:New((x - 1) * 32, (y - 1)* 32, 4, 'bug1', 17, {x,y,21}))
      self.currentItems[y][x] = 0
    end
    
    if(self.currentItems[y][x] == 22) then
      table.insert(chestObj, #chestObj + 1, Chest:New((x - 1) * 32, (y - 1) * 32,false,{x,y}))
        self.currentItems[y][x] = 0
    end
    
    if(self.currentItems[y][x] == 23) then
      table.insert(chestObj, #chestObj + 1, Chest:New((x - 1) * 32, (y - 1) * 32,true,{x,y}))
        self.currentItems[y][x] = 0
    end
    
    if(self.currentItems[y][x] == 24) then
      table.insert(doorObj, #doorObj + 1, Door:New((x - 1) * 32, (y - 1) * 32, {x,y}, "east"))
      self.currentItems[y][x] = 0
    end
    
    if(self.currentItems[y][x] == 25) then
      table.insert(enemyObj, #enemyObj + 1, EgyptBoss1:New((x - 1) * 32, (y - 1) * 32))
      self.currentItems[y][x] = 0
    end
    
   -- tileObj[currentTileNumber]:UpdatePosition((x-1) * 32, (y-1) * 32, self.currentMap[y][x], coll)
    --currentTileNumber = currentTileNumber + 1
    
  end
end
  
end
