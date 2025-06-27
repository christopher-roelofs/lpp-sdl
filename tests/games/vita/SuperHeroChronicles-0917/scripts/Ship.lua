Ship = {};
shipSprite = Graphics.loadImage("app0:/Sprites/Ship.png");
listOfShipBullets = {};
function Ship:new(xpos,ypos)
  shipObj = {}
  setmetatable(shipObj, self);
  self.__index = self;
  shipObj.animationFrame = 0;
  shipObj.x = xpos;
  shipObj.y = ypos;
  shipObj.health = 5;
  shipObj.width = 111;
  shipObj.height = 69;
  shipObj.canShootTimer = 180;
  shipObj.isDead = false;
  shipObj.color = Color.new(255,255,255);
  shipObj.hitTimer = 10;
  
  return shipObj;
end


function Ship:Draw()
  
  if(self.animationFrame >= 10) then
  
  self.animationFrame = 0;
  end
  
  
  self.animationFrame = self.animationFrame +1;
  
  if(self.animationFrame ==1) then
    
    self.shipSpriteImg = Graphics.drawPartialImage(self.x,self.y,0,0,111,69,shipSprite, self.color);
  end
  
  if(self.animationFrame ==2) then
    
    self.shipSpriteImg = Graphics.drawPartialImage(self.x,self.y,0,69,111,69,shipSprite, self.color);
  end
  
  if(self.animationFrame ==3) then
    
    self.shipSpriteImg = Graphics.drawPartialImage(self.x,self.y,0,138,111,69,shipSprite, self.color);
    
  end
  
  if(self.animationFrame ==4) then
    
    self.shipSpriteImg = Graphics.drawPartialImage(self.x,self.y,111,0,111,69,shipSprite, self.color);
  end
  
  if(self.animationFrame ==5) then
    self.shipSpriteImg = Graphics.drawPartialImage(self.x,self.y,111,69,111,69,shipSprite, self.color);
    
  end
  
  if(self.animationFrame ==6) then
    self.shipSpriteImg = Graphics.drawPartialImage(self.x,self.y,111,138,111,69,shipSprite, self.color);
    
  end
  
  if(self.animationFrame ==7) then
    self.shipSpriteImg = Graphics.drawPartialImage(self.x,self.y,222,0,111,69,shipSprite, self.color);
    
  end
  
  if(self.animationFrame ==8) then
    self.shipSpriteImg = Graphics.drawPartialImage(self.x,self.y,333,0,111,69,shipSprite, self.color);
    
  end
  
  if(self.animationFrame ==9) then
    self.shipSpriteImg = Graphics.drawPartialImage(self.x,self.y,222,69,111,69,shipSprite, self.color);
    
  end
  
  if(self.animationFrame ==10) then
    
    self.shipSpriteImg = Graphics.drawPartialImage(self.x,self.y,222,138,111,69,shipSprite, self.color);
  end 
end


function Ship:Move()
  
  self.x = self.x -5;
  
  if (self.x > playerObj.playerX and self.x - playerObj.playerX < 300) then
    
    if self.y + 35 < playerObj.playerY + 10 then
      
      self.y = self.y + 3
      
    elseif (self.y + 35 > playerObj.playerY + 36) then
      self.y = self.y -3
          
    else
      self:Shoot()
    end
      
  end
  
  
  if(self.x <= -111) then
  self.isDead = true;
  self.health = 0;
  playerObj.cityHealth = playerObj.cityHealth -1;
  end
  
  
end

function Ship:Shoot()
  
  if(self.canShootTimer <= 0) then
    PlaySounds("enemyLaser");
  table.insert(listOfShipBullets, #listOfShipBullets + 1, EnemyLaser:new(self.x,self.y+ 30))
  self.canShootTimer = 210;  
  end
  
  
end

function Ship:TakeDamage()
  
  self.health =  self.health -1;
  
  if(self.health <= 0) then
  self.isDead = true;  
  end
  
  
end


function Ship:CheckDeath()
  if(self.isDead == true) then
  waveManager.enemiesAlive = waveManager.enemiesAlive - 1
  self:DecideIfShouldMakeHealthPack()
  end
  return self.isDead;
end

function Ship:CheckCollision(leftXPos,rightXPos,topYPos,bottomYPos)
  if(leftXPos <= self.x + self.width and rightXPos >= self.x) then
      if(topYPos <= self.y + self.height and bottomYPos >= self.y) then
      self:TakeDamage();
      PlaySounds("metalHit");
      self.hitTimer = 0;
      return true
    end
    
  end
  return false
end

function Ship:DecideIfShouldMakeHealthPack()
    
    self.randomNum = math.random(1,100);
    
    if(self.randomNum >= 51 and self.randomNum <= 55) then
    CreateHealthPack(self.x,self.y)  
    end
  end

function Ship:Update()
  
   if(self.hitTimer < 6) then
     self.hitTimer = self.hitTimer + 1;
     self.color = Color.new(255,0,0)
   else 
     self.color = Color.new(255,255,255)
   end
  
  self.canShootTimer = self.canShootTimer -1;
  self:Move();
  self:Shoot();
  self:Draw();
  
end
