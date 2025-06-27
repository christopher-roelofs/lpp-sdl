Robot = {};
listOfEnemyBullets = {};
robotImg = Graphics.loadImage("app0:/Sprites/Robot.png");

function Robot:new(xPos, yPos, pat, shootTimer)
  robot = {}
  setmetatable(robot, self);
  self.__index = self;
  
  robot.x = xPos;
  robot.y = yPos;
  robot.pattern = pat
  robot.health = 3
  robot.timer = shootTimer;
  robot.shootLimit = 360;
  robot.frameCount = 0;
  robot.characterState = "move";
  robot.isDead = false;
  robot.imgWidth = 121;
  robot.imgHeight = 66;
  robot.hitTimer = 15;
  robot.color = Color.new(255,255,255)
  
  return robot;
  
end

function Robot:ShootBullet ()
  table.insert(listOfEnemyBullets,#listOfEnemyBullets + 1, EnemyBullets:new(self.x,self.y));
  self.characterState = "attack";
  PlaySounds("robotCanon");
  self.frameCount = 0;
  self.timer = 0;
end



function Robot:Move()
  
  if(self.pattern == 1) then
    
    if(self.x == 270 and self.y < 450) then
    self.y = self.y + 2.5;
    
    end
  
    if(self.x == 270 and self.y == 100) then
    self:ShootBullet();  
    end
  
    if(self.x < 770 and self.y == 450) then
    self.x = self.x +2.5;  
  end
  
  if(self.y == 250 and self.x == 270) then
    self:ShootBullet();
  end
  
  if(self.x == 770 and self. y > 0) then
     self.y = self.y - 2.5;
    end
    
    if(self.y == 200 and self.x == 770) then
    self:ShootBullet();  
  end
  
  if(self.x > 270 and self.y == 0) then
 self.x = self.x -2.5;   
  end
  
    
    
    
  end
  
  
  if(self.pattern == 2) then
    self.x = self.x -2;
    
    
    if(self.timer >= self.shootLimit) then
    self:ShootBullet();
    --self.timer = 0;
    end
    
    
  end
  if(self.x < -121) then
    self.isDead = true;
    self.health = 0;
    playerObj.cityHealth = playerObj.cityHealth -1;
    end
  
end

function Robot:TakeDamage()
  self.health = self.health - 1
  PlaySounds("metalHit");
end

function Robot:CheckDeath()
  if(self.health <= 0) then
    
    self.isDead = true;
    PlaySounds("robotBlowUp");
    end
  
end

function Robot:Draw()
  
  if(self.characterState == "move") then
  
  if(self.frameCount >= 5) then
    
    self.frameCount = 0;
  end
  
  
  self.frameCount = self.frameCount +1;
  
  
  
  if(self.frameCount == 1) then
     self.enemySprite = Graphics.drawPartialImage(self.x, self.y,242,138,121,66,  robotImg, self.color);
  end
   if(self.frameCount == 2) then
     self.enemySprite = Graphics.drawPartialImage(self.x, self.y,242,204,121,66,  robotImg, self.color);
  end
   if(self.frameCount == 3) then
     self.enemySprite = Graphics.drawPartialImage(self.x, self.y,242,270,121,66,  robotImg, self.color);
  end
   if(self.frameCount == 4) then
     self.enemySprite = Graphics.drawPartialImage(self.x, self.y,242,336,121,66,  robotImg, self.color);
  end
   if(self.frameCount == 5) then
     self.enemySprite = Graphics.drawPartialImage(self.x, self.y,242,402,121,66,  robotImg, self.color);
  end
  
    
  
end

if(self.characterState == "attack") then

self.frameCount = self.frameCount + 1;

if(self.frameCount == 1) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,0,0,121,69,  robotImg, self.color);
end
if(self.frameCount == 2) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,0,69,121,69,  robotImg, self.color);
end
if(self.frameCount == 3) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,0,138,121,69,  robotImg, self.color);
end
if(self.frameCount == 4) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,0,207,121,69,  robotImg, self.color);
end
if(self.frameCount == 5) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,0,276,121,69,  robotImg, self.color);
end
if(self.frameCount == 6) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,0,345,121,69,  robotImg, self.color);
end
if(self.frameCount == 7) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,0,414,121,69,  robotImg, self.color);
end
if(self.frameCount == 8) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,121,0,121,69,  robotImg, self.color);
end
if(self.frameCount == 9) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,121,69,121,69,  robotImg, self.color);
end
if(self.frameCount == 10) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,121,138,121,69,  robotImg, self.color);
end
if(self.frameCount == 11) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,121,207,121,69,  robotImg, self.color);
end
if(self.frameCount == 12) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,121,276,121,69,  robotImg, self.color);
end
if(self.frameCount == 13) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,121,345,121,69,  robotImg, self.color);
end
if(self.frameCount == 14) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,121,414,121,69,  robotImg, self.color);
end
if(self.frameCount == 15) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,242,0,121,69,  robotImg, self.color);
end
if(self.frameCount == 16) then
  self.enemySprite = Graphics.drawPartialImage(self.x, self.y,242,69,121,69,  robotImg, self.color);
end
if(self.frameCount >= 16) then
self.characterState = "move";
end


end

end

function Robot:CheckCollision(leftXPos,rightXPos,topYPos,bottomYPos)
 
 if(leftXPos <= self.x + self.imgWidth and rightXPos >= self.x) then
      if(topYPos <= self.y + self.imgHeight and bottomYPos >= self.y) then
      self:TakeDamage();
      self.hitTimer = 0;
      return true
end
end
return false
end

function Robot:CheckIfAlive()
  if(self.health <= 0) then
      waveManager.enemiesAlive = waveManager.enemiesAlive - 1
      self:DecideIfShouldMakeHealthPack()
    return true 
    
  end
  return false
  
end

function Robot:DecideIfShouldMakeHealthPack()
    
    self.randomNum = math.random(1,100);
    
    if(self.randomNum >= 51 and self.randomNum <= 55) then
    CreateHealthPack(self.x,self.y)  
    end
    
    
  end

function Robot:Update()
 if(self.isDead == false) then
   
   
   if(self.hitTimer < 6) then
     self.hitTimer = self.hitTimer + 1;
     self.color = Color.new(255,0,0)
   else 
     self.color = Color.new(255,255,255)
   end
   
   
 --if(self.chracterState == "move") then
    
  self.timer = self.timer + 1;
--end
  self:CheckDeath();
  self:Move();
  self:Draw();
  
end

end
