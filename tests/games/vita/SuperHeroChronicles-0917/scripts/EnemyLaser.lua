EnemyLaser = {}
enemyLaserImg = Graphics.loadImage("app0:/Sprites/Bullet.png")

function EnemyLaser:new(xPos,yPos)
  enemyLaserObj = {}
  setmetatable(enemyLaserObj, self);
  self.__index = self;
  enemyLaserObj.x = xPos;
  enemyLaserObj.y = yPos;
  enemyLaserObj.isDead = false;
  return enemyLaserObj;
end

function EnemyLaser:Draw()
  self.enemyLaserSprite = Graphics.drawImage(self.x, self.y, enemyLaserImg);
end

function EnemyLaser:Move()
  
  self.x = self.x -10;
  
  if(self.x <= -10) then
  self.isDead = true;  
  end
  
end

function EnemyLaser:CheckCollision()
 self.checkColliding =  playerObj.CheckCollision(self.x,self.x + 10,self.y,self.y + 2)
 
 if(self.checkColliding == true) then
    self.isDead = true
 end
 
 
end


function EnemyLaser:CheckDeath()
  
return self.isDead;  
end


function EnemyLaser:Update()
self:Move();
self:CheckCollision();
self:Draw();

  end