EnemyGenerator = {}
enemyGeneratorImage = Graphics.loadImage("app0:/Sprites/EnemyGenerator.png");

function EnemyGenerator:New(x,y,max,enemyTypeToCreate, health, orgin)
  enemyGenerator = {}
  setmetatable(enemyGenerator, self)
  self.__index = self
  
  enemyGenerator.x = x + 3;
  enemyGenerator.y = y + 3;
  enemyGenerator.timer = 30;
  enemyGenerator.timerLimit = 60;
  enemyGenerator.enemiesAlive = 0;
  enemyGenerator.maxEnemiesCreated = max;
  enemyGenerator.health = health;
  enemyGenerator.enemyTypeToCreate = enemyTypeToCreate
  enemyGenerator.isDead = false
  enemyGenerator.isOnScreen = true
  enemyGenerator.orgin = orgin
  
  
  return enemyGenerator;
end

function EnemyGenerator:Draw()
  
  if(self.isOnScreen == true) then
    
    if(self.enemyTypeToCreate == "bug1") then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 0, 0, 24, 24, enemyGeneratorImage)
    end
    
    if(self.enemyTypeToCreate == "bat1") then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 24, 0, 24, 24, enemyGeneratorImage)
    end
    
    if(self.enemyTypeToCreate == "slime1") then
      Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 0, 24, 24, 24, enemyGeneratorImage)
    end
    
    
  end
  
  
end

function EnemyGenerator:CreateNewEnemy()
  
  if(self.enemiesAlive >= self.maxEnemiesCreated) then
  return  
  end
  
  
  if(self.enemyTypeToCreate == "bat1") then
    table.insert(enemyObj, #enemyObj + 1, Bat:New(self.x, self.y + 24,true,self,nil))
  end
  
  if(self.enemyTypeToCreate == "slime1") then
    table.insert(enemyObj, #enemyObj + 1, Slime:New(self.x, self.y + 24,true,self,nil))
  end
  
  if(self.enemyTypeToCreate == "bug1") then
  table.insert(enemyObj, #enemyObj + 1, Bug:New(self.x, self.y + 24,true,self,nil))
end

  
  self.enemiesAlive = self.enemiesAlive + 1
end

function EnemyGenerator:CheckTimer()
  self.timer = self.timer + 1;
  
  if(self.timer >= self.timerLimit) then
  self:CreateNewEnemy()
  self.timer = 0
  end
  
  
end


function EnemyGenerator:TakeDamage(damage)
   table.insert(onScreenTextPopUpObj, #onScreenTextPopUpObj + 1, OnScreenTextPopUps:New(self.x,self.y, tostring(damage),Color.new(255,255,255)))
  self.health = self.health - damage
  
  if(self.health <= 0) then
  self.isDead = true  
  end
  
  
end

function EnemyGenerator:RemoveOneEnemy()
  
  self.enemiesAlive = self.enemiesAlive - 1
  
end


function EnemyGenerator:GetDimensions()
  
  return {self.x, self.x + 24, self.y, self.y + 24}
end

 function EnemyGenerator:NotOnScreen()
 
   if(math.floor((self.x +  24) / 32) + 1 < math.floor(cameraX / 32) + 1 or math.floor(self.x/32) > (math.floor(cameraX / 32) + 1) + 32
     or math.floor((self.y + 24)/32) + 1 < math.floor(cameraY/32) + 1 or math.floor(self.y/32) > (math.floor(cameraY/32)+1) + 19) then
     for i, value in ipairs(mapObj) do
      mapObj[i].currentItems[self.orgin[2]][self.orgin[1]] = self.orgin[3]
     end
     
     self.isDead = true
   end
 end

function EnemyGenerator:Update()
  self:CheckTimer()
  self:NotOnScreen()
  
  return self.isDead
end
