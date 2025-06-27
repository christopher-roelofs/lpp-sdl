Scooter ={};
scooterSpriteImg = Graphics.loadImage("app0:/Sprites/ScooterEnemy.png");

function Scooter:new (xPos, yPos)
  scooterObj = {}
  setmetatable(scooterObj, self);
  self.__index = self;
  scooterObj.playerScale = 1;
  scooterObj.x = xPos;
  scooterObj.y = yPos;
  scooterObj.health = 8;
  scooterObj.characterState = "moveForward";
  scooterObj.currentFrame = 0;
  scooterObj.imgHeight = 136;
  scooterObj.imgWidth = 104;
    scooterObj.isDead = false;
    scooterObj.hitTimer = 10;
    scooterObj.color = Color.new(255,255,255);
  
  return scooterObj;
end

function Scooter:Move()
  
  if(self.characterState == "moveForward") then
  self.x = self.x -5;
  self.playerScale = 1;
  
  if(self.x < 0) then
  self.x = 0 + 104
  self.playerScale = -1;
  self.characterState = "attack";
  PlaySounds("comeOn");
  return;
  end
  
  
end

if(self.characterState == "retreat" or self.characterState == "attack") then
  self.x = self.x + 7;
  self.playerScale = -1;
  
  if(self.x > 960) then
  self.characterState = "moveForward";
  self.x = 960 - 104
  self.playerScale = 1;
  end
  
end

  
end

function Scooter:Draw()
  
  if(self.currentFrame >= 10) then
 self.currentFrame = 0;   
  end
  
  self.currentFrame = self.currentFrame + 1;
  
  if(self.characterState == "moveForward" or self.characterState == "retreat") then
  if(self.currentFrame == 1) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,213,272,104,136, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 2) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,214,136,104,136, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 3) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,317,0,104,136, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 4) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,525,0,100,136, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 5) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,422,136,101,136, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 6) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,625,137,98,136,self.playerScale,1,   scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 7) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,317,272,104,136,self.playerScale,1,   scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 8) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,104,0,107,136, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 9) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,211,0,106,136, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 10) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,0,280,107,136, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
  end
  
   if(self.characterState == "attack") then
  if(self.currentFrame == 1) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,318,136,104,136, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 2) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,421,0,104,136,self.playerScale,1,   scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 3) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,421,272,104,136,self.playerScale,1,   scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 4) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,525,272,100,136, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 5) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,523,136,101,136, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 6) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,625,0,98,137, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 7) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,0,0,104,143, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 8) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,0,143,107,137, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 9) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,107,272,106,136, self.playerScale,1,  scooterSpriteImg, self.color);
  end
  
   if(self.currentFrame == 10) then
    self.scooterSprite = Graphics.drawImageExtended(self.x, self.y,107,136,107,136,self.playerScale,1,   scooterSpriteImg, self.color);
    self:CallOutEnemies();
  end
  
end

if(self.currentFrame >= 10 and self.characterState == "attack") then
  
  self.characterState = "retreat";
  self.currentFrame = 0;
end

  
end

function Scooter:CallOutEnemies()
  
  self.randomNumber = math.random(0,7);
  
  if(self.randomNumber == 0) then
    waveManagerObj.Monster1();
  end
  
  if(self.randomNumber == 1) then
     waveManagerObj.Monster2();
  end
  
  if(self.randomNumber == 2) then
     waveManagerObj.Monster3();
  end
  
  if(self.randomNumber == 3) then
     waveManagerObj.Monster4();
  end
  
  if(self.randomNumber == 4) then
     waveManagerObj.Monster5();
  end
  
  if(self.randomNumber == 5) then
     waveManagerObj.Monster6();
  end
  
  if(self.randomNumber == 6) then
     waveManagerObj.Monster7();
  end
  
  if(self.randomNumber == 7) then
     waveManagerObj.Monster8();
  end

end


function Scooter:CheckDeath()
  if(self.health <= 0) then
  waveManager.enemiesAlive = waveManager.enemiesAlive - 1
  self.isDead = true;
  self:DecideIfShouldMakeHealthPack()
  end
  return self.isDead;
  
end

function Scooter:DecideIfShouldMakeHealthPack()
    
    self.randomNum = math.random(1,100);
    
    if(self.randomNum >= 51 and self.randomNum <= 55) then
    CreateHealthPack(self.x,self.y)  
    end
  end


function Scooter:TakeDamage() 
  
  self.health = self.health -1 
  
end



function Scooter:CheckCollision(leftXPos,rightXPos,topYPos,bottomYPos)
  if(self.playerScale == 1) then
  if(leftXPos <= self.x + self.imgWidth and rightXPos >= self.x) then
      if(topYPos <= self.y + self.imgHeight and bottomYPos >= self.y) then
      self:TakeDamage();
      self.hitTimer = 0;
      PlaySounds("metalHit");
      return true
    end
    
  end
end

if(self.playerScale == -1) then
  if(rightXPos >= self.x - self.imgWidth and leftXPos <= self.x) then
      if(topYPos <= self.y + self.imgHeight and bottomYPos >= self.y) then
      self:TakeDamage();
      self.hitTimer = 0;
      return true
    end
    
  end
end

  return false
end

function Scooter:Update()
   if(self.hitTimer < 6) then
     self.hitTimer = self.hitTimer + 1;
     self.color = Color.new(255,0,0)
   else 
     self.color = Color.new(255,255,255)
   end
  self:Move();
  self:Draw();
end