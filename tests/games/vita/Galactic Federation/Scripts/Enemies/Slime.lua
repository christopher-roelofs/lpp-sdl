Slime = {}
slimeImage = Graphics.loadImage("app0:/Sprites/Slime.png");
function Slime:New(x,y, created, enemyGeneratorParent, orgin)
  slime = {}
  setmetatable(slime, self)
  self.__index = self
  slime.x = x
  slime.y = y
  slime.health = 20
  slime.hitConfirmTimer = 0
  slime.moveDirection = ""
  slime.moveDirectionTimer = 0
  slime.canDecideMoveDirection = false
  slime.speed = 5
  slime.tintColor = Color.new(255,255,255)
  slime.isDead = false
  slime.power = 8
  slime.orgin = orgin
  
  slime.generatorCreated = created
  slime.parent = enemyGeneratorParent
  
  return slime
end

function Slime:Draw()
  Graphics.drawImage(self.x - cameraX, self.y - cameraY, slimeImage, self.tintColor)
end

function Slime:TakeDamage(damage)
  self.health = self.health - damage
  self.hitConfirmTimer = 3
  table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(damage),Color.new(255,255,255)))
  if(self.health <= 0) then
    
    if(self.generatorCreated == true) then
    self.parent:RemoveOneEnemy()  
    end
    
    
  self.isDead = true  
  end
  
  
end

function Slime:Move()
   if(self.moveDirection == "north") then
    
    speed = self:Raycast("north", self.speed)
    speed = self:RayCastEnemy("north", speed)
    speed = self:RaycastPlayer("north", speed)
    self.y = self.y - speed
    
  end
  
  if(self.moveDirection == "south") then
    speed = self:Raycast("south", self.speed)
    speed = self:RayCastEnemy("south", speed)
    speed = self:RaycastPlayer("south", speed)
    self.y = self.y + speed
  end
  
  if(self.moveDirection == "east") then
    speed = self:Raycast("east", self.speed)
    speed = self:RayCastEnemy("east", speed)
    speed = self:RaycastPlayer("east", speed)
    self.x = self.x + speed
  end
  
  if(self.moveDirection == "west") then
    speed = self:Raycast("west", self.speed)
    speed = self:RayCastEnemy("west", speed)
    speed = self:RaycastPlayer("west", speed)
    self.x = self.x - speed
  end
end

function Slime:CheckRelationToPlayer()

    for i, value in ipairs(playerObj) do
      
      if(playerObj[i].x < self.x + 24 and self.moveDirection == "east") then
        
       self.moveDirectionTimer = 20
        
      end
      
      if(playerObj[i].x + 32 > self.x and self.moveDirection == "west") then
        self.moveDirectionTimer = 20
      end
      
      if(playerObj[i].y < self.y + 24 and self.moveDirection == "south") then
        self.moveDirectionTimer = 20
      end
      
      
      if(playerObj[i].y + 32 > self.y and self.moveDirection == "north") then
        self.moveDirectionTimer = 20
      end
      
      
      
    end
   
end

function Slime:CheckMoveBoundries()
if(self.x < 0) then
  self.x = 0
end

if(self.y < 0) then
  self.y = 0
end

for i, value in ipairs(cameraObj) do

  if(self.x + 24 > cameraObj[i].worldWidth) then
  self.x = cameraObj[i].worldWidth - 24  
  end

  if(self.y + 24 > cameraObj[i].worldHeight) then
  self.y = cameraObj[i].worldHeight - 24  
  end

end


end

function Slime:DecideMoveDirection()
  self.moveDirectionTimer = self.moveDirectionTimer + 1
  if(self.moveDirectionTimer > 20) then
    self.canDecideMoveDirection = true
    self.moveDirectionTimer = 0
    self.moveDirection = ""
  end
  
  if(self.moveDirection == "") then
    for i, value in ipairs(playerObj) do
      
      if(playerObj[i].x > self.x + 24) then
        
        self.moveDirection = "east"
        
      end
      
      if(playerObj[i].x + 32 < self.x) then
        self.moveDirection = "west"
      end
      
      if(playerObj[i].y > self.y + 24) then
        self.moveDirection = "south"
      end
      
      
      if(playerObj[i].y + 32 < self.y) then
        self.moveDirection = "north"
      end
      
      
      
    end
  end
  
  
  
  
end

function Slime:Raycast(direction, speed)
    
    
    if(direction == "west") then
      
     
      
      for i = #collidableObj, 1, -1 do
        
    
          tileDim = collidableObj[i]:GetDimensions()
        if(self.y < tileDim[4] and self.y + 32 > tileDim[3]) then
        
          if(self.x - speed < tileDim[2] and self.x + 32> tileDim[2]) then
          
          return self.x - tileDim[2]
            
          end        
        
      end
      
      end
      
      return speed
    end
    
    if(direction == "east") then
      
     
      
     for i = #collidableObj, 1, -1 do
        
       
          tileDim = collidableObj[i]:GetDimensions()
          
        if(self.y < tileDim[4] and self.y + 32 > tileDim[3]) then
        
          if(self.x + 32 + speed > tileDim[1] and self.x <= tileDim[1]) then
          
          return tileDim[1] - self.x - 32  
            
          end

        
      end
      
      end
      return speed
    end
    
    if(direction == "north") then
      
  
      
      for i = #collidableObj, 1, -1 do
        
        tileDim = collidableObj[i]:GetDimensions()
        if(self.x < tileDim[2] and self.x + 32 > tileDim[1]) then
        
        if(self.y - speed < tileDim[4] and self.y >= tileDim[4]) then
        
        return self.y - tileDim[4]
          
        end
        
      end
      
      end
      return speed
    end
    
    if(direction == "south") then
      
      
      
      for i = #collidableObj, 1, -1 do
        
       
        tileDim = collidableObj[i]:GetDimensions()
        if(self.x < tileDim[2] and self.x + 32 > tileDim[1]) then
        
        if(self.y + 32  + speed > tileDim[3] and self.y <= tileDim[3]) then
        
        return tileDim[3] - self.y -32  
          
        end
        
      end
      
      end
      return speed
    end
    
    
  end

function Slime:RaycastPlayer(direction, speed) 
   
    if(direction == "west") then
      
      for i, value in ipairs(playerObj) do
        
        
          playerDim = playerObj[i]:GetDimensions()
        if(self.y < playerDim[4] and self.y + 32 > playerDim[3]) then
        
          if(self.x - speed < playerDim[2] and self.x + 32> playerDim[2]) then
          playerObj[i]:TakeDamage(self.power)
          return self.x - playerDim[2]
            
          end       
      end
      
      end
      
      return speed
    end
    
    if(direction == "east") then
      
      for i, value in ipairs(playerObj) do
        
          playerDim = playerObj[i]:GetDimensions()
          
        if(self.y < playerDim[4] and self.y + 32 > playerDim[3]) then
        
          if(self.x + 32 + speed > playerDim[1] and self.x <= playerDim[1]) then
          
          playerObj[i]:TakeDamage(self.power)
          return playerDim[1] - self.x - 32  
            
          end       
        
      end
      
      end
      return speed
    end
    
    if(direction == "north") then
      
      for i, value in ipairs(playerObj) do
        
        playerDim = playerObj[i]:GetDimensions()
        if(self.x < playerDim[2] and self.x + 32 > playerDim[1]) then
        
        if(self.y - speed < playerDim[4] and self.y >= playerDim[4]) then
        playerObj[i]:TakeDamage(self.power)
        return self.y - playerDim[4]
          
        end
        
      end
      
      end
      return speed
    end
    
    if(direction == "south") then
      
      for i, value in ipairs(playerObj) do
        
        playerDim = playerObj[i]:GetDimensions()
        if(self.x < playerDim[2] and self.x + 32 > playerDim[1]) then
        
        if(self.y + 32  + speed > playerDim[3] and self.y <= playerDim[3]) then
        playerObj[i]:TakeDamage(self.power)
        return playerDim[3] - self.y -32  
          
        end
     
      end
      
      end
      return speed
    end
end

function Slime:RayCastEnemy(direction, speed)
   if(direction == "west") then
      for i = #enemyObj, 1, -1 do  
        
        if(enemyObj[i] ~= self) then
          
        
          enemyDim = enemyObj[i]:GetDimensions()
      if(self.y < enemyDim[4] and self.y + 32 > enemyDim[3]) then
        
        if(self.x - speed < enemyDim[2] and self.x + 32> enemyDim[2]) then
          
        speed = self.x - enemyDim[2] 
        if(speed <= 0) then
        speed = 0  
        end
        
        end  
      end
      end
    end
    end
    if(direction == "east") then
      
      for i = #enemyObj, 1, -1 do  
          
          if(enemyObj[i] ~= self) then

          enemyDim = enemyObj[i]:GetDimensions()
          
        if(self.y < enemyDim[4] and self.y + 32 > enemyDim[3]) then
        
          if(self.x + 32 + speed > enemyDim[1] and self.x <= enemyDim[1]) then
          
          speed = enemyDim[1] - self.x - 32
          if(speed <= 0) then
          speed = 0  
          end
          
          
        end  
      end
      
      end
    end
    end
    if(direction == "north") then
      for i = #enemyObj, 1, -1 do  
        if(enemyObj[i] ~= self) then
        enemyDim = enemyObj[i]:GetDimensions()
        if(self.x < enemyDim[2] and self.x + 32 > enemyDim[1]) then
        
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
      
      
         
      
      for i = #enemyObj, 1, -1 do  
        if(enemyObj[i] ~= self) then
        enemyDim = enemyObj[i]:GetDimensions()
        if(self.x < enemyDim[2] and self.x + 32 > enemyDim[1]) then
        
        if(self.y + 32  + speed > enemyDim[3] and self.y <= enemyDim[3]) then
        
        speed =  enemyDim[3] - (self.y +32) 
        
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

function Slime:GetDimensions()
  return {self.x + 2, self.x + 28, self.y, self.y + 32}
  
end

function Slime:HitConfirmTimer()
  if(self.hitConfirmTimer > 0) then
  self.tintColor = Color.new(255,0,0)
  self.hitConfirmTimer = self.hitConfirmTimer - 1
  else
  self.tintColor = Color.new(255,255,255)
  end
  
end

 function Slime:NotOnScreen()
 
   if(math.floor((self.x +  32) / 32) + 1 < math.floor(cameraX / 32) + 1 or math.floor(self.x/32) > (math.floor(cameraX / 32) + 1) + 32
     or math.floor((self.y + 32)/32) + 1 < math.floor(cameraY/32) + 1 or math.floor(self.y/32) > (math.floor(cameraY/32)+1) + 19) then
     if(self.orgin ~= nil) then
       for i, value in ipairs(mapObj) do
        mapObj[i].currentItems[self.orgin[2]][self.orgin[1]] = self.orgin[3]
       end
     end
     
     self.isDead = true
   end
 end


function Slime:Update()
  self:HitConfirmTimer()
  self:DecideMoveDirection()
  self:Move()
  self:CheckRelationToPlayer()
  self:CheckMoveBoundries()
  self:NotOnScreen()
  
  return self.isDead
end
