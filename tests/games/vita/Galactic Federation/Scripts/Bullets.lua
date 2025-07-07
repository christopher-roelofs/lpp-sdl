Bullets = {}
bulletImages = Graphics.loadImage("app0:/Sprites/Bullets.png")
acidSpitImage = Graphics.loadImage("app0:/Sprites/AcidSpit.png")

function Bullets:New(x,y,direction,speed, bulletType, height, width, power)
  bullets = {}
  setmetatable(bullets,self)
  self.__index = self
  
  bullets.x = x
  bullets.y = y
  bullets.height = height
  bullets.width = width
  if(direction == "east" or direction == "west") then
  
  bullets.height = width
  bullets.width = height
  
  end
  bullets.power = power
  bullets.isDead = false
  bullets.direction = direction
  bullets.speed = speed
  bullets.bulletType = bulletType
  bullets.currentFrame = 0
  
  return bullets
end


function Bullets:Draw()
  
  if(self.bulletType == 1) then
    
    if(self.direction == "east" or self.direction == "west") then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 0, 12, 16, 4, bulletImages)
    end
    
    if(self.direction == "north" or self.direction == "south") then
      
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 0, 0, 4, 16, bulletImages) 
    end
    
    
    
  end
  
  
  if(self.bulletType == 2) then
    
    Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 7, 0, 9, 9, bulletImages) 
  end
  
  if(self.bulletType == 3) then
  
    if(self.direction =="east" or self.direction == "west") then
      Graphics.fillRect(self.x - cameraX, self.x + 6 - cameraX, self.y - cameraY, self.y + 3 - cameraY, Color.new(111,218,2)) 
    end
    
    if(self.direction == "north" or self.direction == "south") then
      Graphics.fillRect(self.x - cameraX, self.x + 3 - cameraX, self.y - cameraY, self.y + 6 - cameraY, Color.new(111,218,2)) 
    end
  
  
end

if(self.bulletType == 4) then
  self.currentFrame = self.currentFrame + 1
  if(self.direction == "east" or self.direction == "west") then
    if(self.currentFrame == 1) then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 0, 32, 16, 16, acidSpitImage)
    end
    
    if(self.currentFrame == 2) then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 16, 32, 16, 16, acidSpitImage)
    end
    
    if(self.currentFrame == 3) then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 0, 48, 16, 16, acidSpitImage)
    end
    
    if(self.currentFrame == 4) then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 16, 48, 16, 16, acidSpitImage)
    end
    
  end
  
  if(self.direction == "north" or self.direction == "south") then
    
    if(self.currentFrame == 1) then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 0, 0, 16, 16, acidSpitImage)
    end
    
    if(self.currentFrame == 2) then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 16, 0, 16, 16, acidSpitImage)
    end
    
    if(self.currentFrame == 3) then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 0, 16, 16, 16, acidSpitImage)
    end
    
    if(self.currentFrame == 4) then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 16, 16, 16, 16, acidSpitImage)
    end
    
  end
  if(self.currentFrame >= 4) then
  self.currentFrame = 0  
  end
  
  
end

  
  
  
end

function Bullets:Move()
  
  if(self.direction == "west") then
    
    distance = self:Raycast(self.direction, self.speed)
    distance = self:RaycastEnemy(self.direction, distance)
    self.x = self.x - distance
    
  end
  
  if(self.direction == "east") then
    
    distance = self:Raycast(self.direction, self.speed)
    distance = self:RaycastEnemy(self.direction, distance)
    self.x = self.x + distance
    
  end
  
  if(self.direction == "north") then
    
    distance = self:Raycast(self.direction, self.speed)
    distance = self:RaycastEnemy(self.direction, distance)
    self.y = self.y - distance
    
  end
  
  if(self.direction == "south") then
    
    distance = self:Raycast(self.direction, self.speed)
    distance = self:RaycastEnemy(self.direction, distance)
    self.y = self.y + distance
    
  end
  
  
end

function Bullets:RaycastEnemy(direction, speed) 
  tempEnemyObj = nil
  if(direction == "north") then
    for i, value in ipairs(enemyObj) do
    enemyDim = enemyObj[i]:GetDimensions()
    
    if(self.x <= enemyDim[2] and self.x + self.width >= enemyDim[1]) then
      if(self.y - speed <= enemyDim[4] and self.y + self.height >= enemyDim[3]) then
        tempEnemyObj = enemyObj[i]
        speed = self.y - enemyDim[4]
          
          if(speed < 0) then
          speed = 0  
          end
        
      end
    end
    
    end
  end
 
  
  if(direction == "south") then
    for i, value in ipairs(enemyObj) do
    enemyDim = enemyObj[i]:GetDimensions()
    
    if(self.x <= enemyDim[2] and self.x + self.width >= enemyDim[1]) then
      if(self.y  <= enemyDim[4] and self.y + self.height + speed >= enemyDim[3]) then
        
        tempEnemyObj = enemyObj[i]
        speed = (self.y + self.height) - enemyDim[3] 
        
        if(speed < 0) then
        speed = 0  
        end
        
        
      end
    end
    
    end
 end
  
  if(direction == "east") then
    for i, value in ipairs(enemyObj) do
    enemyDim = enemyObj[i]:GetDimensions()
    if(self.y<= enemyDim[4] and self.y + self.height >= enemyDim[3]) then
  if(self.x <= enemyDim[2] and self.x + self.width + speed >= enemyDim[1]) then
    tempEnemyObj = enemyObj[i]
    speed = enemyDim[1] - self.x - self.width
    if(speed < 0) then
    speed = 0  
    end
    
    end
    end

    end
  
    end

   
 
  
  if(direction == "west") then
    for i, value in ipairs(enemyObj) do
      enemyDim = enemyObj[i]:GetDimensions()
    if(self.y<= enemyDim[4] and self.y + self.height >= enemyDim[3]) then
  if(self.x - speed <= enemyDim[2] and self.x + self.width >= enemyDim[1]) then
    tempEnemyObj = enemyObj[i]
    speed = self.x - enemyDim[2]
    if(speed < 0) then
    speed = 0  
    end
    end
    end
    end
    end
if(tempEnemyObj ~= nil) then
  PlaySound('playerLaserHit')  
tempEnemyObj:TakeDamage(self.power)
self.isDead = true
return speed
end

return speed
  end

function Bullets:Raycast(direction, speed)
    
    if(direction == "west") then
      
       for i = #collidableObj, 1, -1 do
        
        
          tileDim = collidableObj[i]:GetDimensions()
        if(self.y < tileDim[4] and self.y + self.height > tileDim[3]) then
        
          if(self.x - speed < tileDim[2] and self.x + self.width> tileDim[2]) then
           PlaySound('playerLaserHitWall')
         self.isDead = true
          return self.x - tileDim[2]
            
          
        
            
        end
        
        
      end
      
      end
      
      return speed
    end
    
    if(direction == "east") then
      
       for i = #collidableObj, 1, -1 do
        
        
          tileDim = collidableObj[i]:GetDimensions()
          
        if(self.y < tileDim[4] and self.y + self.height > tileDim[3]) then
        
          if(self.x + self.width + speed > tileDim[1] and self.x <= tileDim[1]) then
            PlaySound('playerLaserHitWall')
           self.isDead = true
          return  tileDim[1] - self.x - self.width 
            
        
        
          
        end
        
        
      end
      
      end
      return speed
    end
    
    if(direction == "north") then
      
       for i = #collidableObj, 1, -1 do
        
       
        tileDim = collidableObj[i]:GetDimensions()
        if(self.x < tileDim[2] and self.x + self.width > tileDim[1]) then
        
        if(self.y - speed < tileDim[4] and self.y >= tileDim[4]) then
          PlaySound('playerLaserHitWall')
         self.isDead = true
        return self.y - tileDim[4]
          
        end
        
 
        
      end
      
      end
      return speed
    end
    
    if(direction == "south") then
      
       for i = #collidableObj, 1, -1 do
        
        
        tileDim = collidableObj[i]:GetDimensions()
        if(self.x < tileDim[2] and self.x + self.width > tileDim[1]) then
        
        if(self.y + self.height  + speed > tileDim[3] and self.y <= tileDim[3]) then
        PlaySound('playerLaserHitWall')
         self.isDead = true
        return tileDim[3] - self.y -32  
          
        end
        
      
        
      end
      
      end
      return speed
    end
    
    
  end
  
  function Bullets:CheckIfOnScreen()
    if(self.x - cameraX < - 20 or self.x - cameraX > 960) then
   self.isDead = true   
  end
  
  if(self.y - cameraY < - 20 or self.y - cameraY > 544) then
  self.isDead = true  
  end
  
    
  end
  

function Bullets:Update()
  
  self:Move()
  self:CheckIfOnScreen()
  return self.isDead
  end