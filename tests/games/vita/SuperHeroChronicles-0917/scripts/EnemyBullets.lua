EnemyBullets = {};

function EnemyBullets:new(xPos,yPos)
  enemyBullets = {}
  setmetatable(enemyBullets, self);
  self.__index = self;
  enemyBullets.x = xPos;
  enemyBullets.y = yPos;
  enemyBullets.isDead = false;
  enemyBullets.imgWidth = 28;
  enemyBullets.imgHeight = 23;
  return enemyBullets;
end


function EnemyBullets:Move()
  
  
  self.x = self.x - 8;
  
  if(self.x <= -40) then
    self.isDead = true;
    end
end

function EnemyBullets:Draw()
  
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,242,468,28,23,  robotImg);
end

function EnemyBullets:CheckDeath()
  
  return self.isDead;
end


function EnemyBullets:CheckCollision(leftXPos,rightXPos,topYPos,bottomYPos)
    if(leftXPos <= self.x + self.imgWidth and rightXPos >= self.x) then
        if(topYPos <= self.y + self.imgHeight and bottomYPos >= self.y) then
        self.isDead = true;
        PlaySounds("rockDestroy");
        return true
  end
  end
  return false
end

function EnemyBullets:CheckPlayerCollision()
  
  self.checkColliding =  playerObj.CheckCollision(self.x,self.x + 28,self.y,self.y + 23)
 
 if(self.checkColliding == true) then
    self.isDead = true
     PlaySounds("rockDestroy");
 end
  
end


function EnemyBullets:Update()
if(self.isDead == false) then
self:Move()
self:CheckPlayerCollision()
self:Draw();
end
end
