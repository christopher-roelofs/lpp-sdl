Boss = {};
bossSprite = Graphics.loadImage("app0:/Sprites/Boss.png");
bossLaserSprite = Graphics.loadImage("app0:/Sprites/BossLaser.png")
chargeBubble = Graphics.loadImage("app0:/Sprites/ChargeBubble.png");
explosionBubble = Graphics.loadImage("app0:/Sprites/ExplosionBubble.png");

function Boss:new()
   bossObj = {}
  setmetatable(bossObj, self);
  self.__index = self;
  bossObj.topLaserHealth = 50;
  bossObj.bottomLaserHealth = 50;
  bossObj.bodyHealth = 100;
  bossObj.x =1000;
  bossObj.y=100;
  bossObj.topLaserX = 0;
  bossObj.topLaserY = 0;
  bossObj.bottomLaserX = 0;
  bossObj.bottomLaserY = 0;
  bossObj.bottomLaserHitTimer = 10;
  bossObj.topLaserHitTimer = 10;
  bossObj.bodyHitTimer = 10;
  bossObj.topLaserColor = Color.new(255,255,255);
  bossObj.bottomLaserColor = Color.new(255,255,255);
  bossObj.bodyColor = Color.new(255,255,255);
  bossObj.isDead = false;
  bossObj.characterState = "moveForward";
  bossObj.topLaserTime = 0;
  bossObj.bottomLaserTime = 0;
  bossObj.topLaserIsActive = false;
  bossObj.bottomLaserIsActive = false;
  bossObj.widthOfTopLaser = 0;
  bossObj.widthOfBottomLaser = 0;
  bossObj.topLaserRangeTime = 0;
  bossObj.bottomLaserRangeTime = 0;
  bossObj.bottomBossLaserCanHurt = false;
  bossObj.topBossLaserCanHurt = false;
  bossObj.waitTimeToSendOutEnemies = 0;
  bossObj.isDeadTimer = 0;
  return bossObj;
end


function Boss:Draw()
  
   self.topLaserX = self.x - 48;
  self.topLaserY = self.y + 50;
  self.bottomLaserX = self.x - 22;
  self.bottomLaserY = self.y + 225;
  
  if(self.topLaserHealth > 0) then
  self.topLaserSprite = Graphics.drawPartialImage( self.topLaserX, self.topLaserY, 0, 250, 132, 76, bossSprite, self.topLaserColor)
end

if(self.bottomLaserHealth > 0) then
   self.bottomLaserSprite = Graphics.drawPartialImage( self.bottomLaserX, self.bottomLaserY , 132, 250, 95, 72, bossSprite, self.bottomLaserColor)
 end
 
   
  self.bodySprite = Graphics.drawPartialImage( self.x, self.y, 0, 0, 299, 250, bossSprite, self.bodyColor) 
 
end

function Boss:DrawLaser()
  if(self.isDead == true) then
    return;  
  end

  
  if(self.topLaserIsActive == true and self.topLaserHealth > 0) then
    self.waitTimeToSendOutEnemies = 0;
    self.topLaserTime = self.topLaserTime + 1;
    if(self.topLaserTime == 90) then
      PlaySounds("bossLaser");
    end
    
    
    if(self.topLaserTime > 90) then
           
           if(self.topLaserTime == 91) then
            self.topBossLaserCanHurt = true; 
           end
           
           
      topLaser1 = Graphics.drawImageExtended(self.topLaserX - (293 * 3) +100, self.y + 32,0,0,293,114, 3, 1,bossLaserSprite)
        
  self:CheckTopLaserCollision()
     
     if(self.topLaserTime >= 390) then
       
     self.topLaserIsActive = false;  
     self.topBossLaserCanHurt = false; 
     end
     
     
    end
    
    
  else
    
    self.topLaserTime = 0;
    
  end
  
  if(self.bottomLaserIsActive == true and self.bottomLaserHealth > 0) then
   self.waitTimeToSendOutEnemies = 0;
   self.bottomLaserTime = self.bottomLaserTime + 1;
   
   if(self.bottomLaserTime == 90) then
      PlaySounds("bossLaser");
    end
   
   if(self.bottomLaserTime > 90) then
          
          if(self.bottomLaserTime == 91) then
            self.bottomBossLaserCanHurt = true;
          end
          
          
     bottomLaser1 = Graphics.drawImageExtended(self.bottomLaserX - (266 * 3) +100, self.y + 212,0,114,266,114,3,1,bossLaserSprite)
     self:CheckBottomLaserCollision()
   
   if(self.bottomLaserTime >= 390) then
   self.bottomLaserIsActive = false;  
   self.bottomBossLaserCanHurt = false;
   end
   
     
   end
   
   
 else
   
   self.bottomLaserTime = 0;

    
  end
  
  
end

function Boss:DrawChargeBubble()  
  
  if(self.isDead == true) then
    return;  
  end
  
  
  if(self.topLaserIsActive == true and self.topLaserHealth > 0) then
    
    if(self.topLaserTime  < 30) then
      self.chargeBubbleSprite = Graphics.drawImage(self.topLaserX - 50, self.topLaserY - 20, chargeBubble);
    end
    
    if(self.topLaserTime > 30 and self.topLaserTime < 60) then
      
      self.chargeBubbleSprite = Graphics.drawImage(self.topLaserX + 50, self.topLaserY + 90, chargeBubble);
    end
    
    
    if(self.topLaserTime > 60 and self.topLaserTime < 90) then
      
      self.chargeBubbleSprite = Graphics.drawImage(self.topLaserX + 130, self.topLaserY, chargeBubble);
    end
    
    
  end
  
  
  if(self.bottomLaserIsActive == true and self.bottomLaserHealth > 0) then
    
    if(self.bottomLaserTime  < 30 ) then
      self.chargeBubbleSprite = Graphics.drawImage(self.bottomLaserX - 50, self.bottomLaserY - 20, chargeBubble);
    end
    
    if(self.bottomLaserTime > 30 and self.bottomLaserTime < 60) then
      
      self.chargeBubbleSprite = Graphics.drawImage(self.bottomLaserX + 50, self.bottomLaserY + 90, chargeBubble);
    end
    
    
    if(self.bottomLaserTime > 60 and self.bottomLaserTime < 90) then
      
      self.chargeBubbleSprite = Graphics.drawImage(self.bottomLaserX + 130, self.bottomLaserY, chargeBubble);
    end
    
  end
  
end



function Boss:DecideIfShouldActivateLaser()
  
  if(self.isDead == true) then
    return;  
  end
  
  if(self.topLaserIsActive == false and self.bottomLaserIsActive == false and self.topLaserHealth > 0) then 
    
    if(playerObj.playerY + 46 > self.topLaserY - 20 and playerObj.playerY < self.topLaserY + 76 + 30) then
      
      self.topLaserRangeTime = self.topLaserRangeTime + 1;
    else
      
      self.topLaserRangeTime = 0
    end
    
    if(self.topLaserRangeTime >= 30) then
    self.topLaserRangeTime = 0;
    self.bottomLaserRangeTime = 0
    self.topLaserIsActive = true;
    
    end
    
    
  end
  
  
  if(self.bottomLaserIsActive == false and self.topLaserIsActive == false and self.bottomLaserHealth > 0) then
    
  
  if(playerObj.playerY < self.bottomLaserY + 72 and playerObj.playerY + 46 + 20 > self.bottomLaserY + 25) then
  self.bottomLaserRangeTime = self.bottomLaserRangeTime + 1;  
  end
  
  
  
  if(self.bottomLaserRangeTime >= 45) then
  self.bottomLaserIsActive = true;
  self.topLaserRangeTime = 0;
  self.bottomLaserRangeTime = 0;
    
  end
  
  
  end
  
  
end



function Boss:CheckDeath()
  
  return self.isDead;
  
end

function Boss:MoveForward()
  
  if(self.isDead == true) then
    return;  
  end
if(self.characterState == "moveForward") then  
  if(self.x > 620) then 
  self.x  = self.x - 3;  
end

if(self.x < 660) then
  
self.x = 660;  
self.characterState = "moveUp";

end
end
  
  
end

function Boss:MoveUp()
 if(self.isDead == true) then
    return;  
  end
 if(self.characterState == "moveUp") then
 self.y = self.y - 2;
  
  if(self.y <= 20) then
  self.y = 20;
  self.characterState = "moveDown";
  end
  
  end
end


function Boss:MoveDown()
  if(self.isDead == true) then
    return;  
  end
  if(self.characterState == "moveDown") then
  self.y = self.y + 2;
  
  if(self.y >= 250) then 
  self.y = 250;
  self.characterState = "moveUp";
  end
  end
end


function Boss:CheckCollision(leftXPos,rightXPos,topYPos,bottomYPos) 
  if(self.isDead == true) then
    return false;  
  end
  if(self.topLaserHealth > 0 and leftXPos <= self.topLaserX + 132 and rightXPos >= self.topLaserX) then
      if(topYPos <= self.topLaserY + 76 and bottomYPos >= self.topLaserY) then
      self:TakeDamageTopLaser();
      
      return true
    end
  end
  
  if(self.bottomLaserHealth > 0 and leftXPos <= self.bottomLaserX + 95 and rightXPos >= self.bottomLaserX) then
      if(topYPos <= self.bottomLaserY + 72 and bottomYPos >= self.bottomLaserY) then
      self:TakeDamageBottomLaser();
      
      return true
    end
  end
  
    
    if(leftXPos <= self.x + 299 and rightXPos >= self.x) then
      if(topYPos <= self.y + 250 and bottomYPos >= self.y) then
      self:TakeDamageBody();
      if(self.bottomLaserHealth > 0 or self.topLaserHealth > 0) then
        PlaySounds("metalHit");
      return nil;  
      end
      
      return true
    end
  end
  
  return false;
  
  end
  
  function Boss:TakeDamageTopLaser()
    if(self.isDead == true) then
    return;  
  end
    self.topLaserHitTimer = 0;
    self.topLaserHealth = self.topLaserHealth -1;
    PlaySounds("metalHit");
    
  end
  
  function Boss:TakeDamageBottomLaser()
    if(self.isDead == true) then
    return;  
  end
    self.bottomLaserHitTimer = 0;
    self.bottomLaserHealth = self.bottomLaserHealth -1;
    PlaySounds("metalHit");
    
  end
  
  function Boss:TakeDamageBody()
    if(self.isDead == true) then
    return;  
  end
    if(self.bottomLaserHealth <= 0 and self.topLaserHealth <= 0) then
    self.bodyHitTimer = 0;
    self.bodyHealth = self.bodyHealth - 1;
    
    if(self.bodyHealth < 0) then
    self.bodyHealth = 0;  
    self.isDead = true;
    PlaySounds("metalHit");
    end
    
    
    end
  end
  

  
  function Boss:CheckTopLaserCollision()
    if(self.isDead == true) then
    return;  
  end
    
    if(self.topBossLaserCanHurt == true) then
      
      if(playerObj.playerY < self.y + 32 + 114 and playerObj.playerY + 46 > self.y + 32) then
        
        self.topBossLaserCanHurt = false;
         playerObj.TakeDamage()
          playerObj.TakeDamage()
      end
      
      
    end
    
    
  end
  
  
  function Boss:CheckBottomLaserCollision()
    if(self.isDead == true) then
    return;  
  end
    
    
    if(self.bottomBossLaserCanHurt == true) then
      
      if(playerObj.playerY < self.y + 212 + 114 and playerObj.playerY + 46 > self.y + 212) then
        
      self.bottomBossLaserCanHurt = false;
      playerObj.TakeDamage()
       playerObj.TakeDamage()
      end
      
    end
    
    
  end
  
  function Boss:CallOutEnemies()
    if(self.isDead == true) then
    return;  
  end
    
    
    if(self.waitTimeToSendOutEnemies < 600) then
      return;
    end
    
  self.waitTimeToSendOutEnemies = -300;
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


function Boss:DrawHealthBar()
  
  self.enemyHealthBarGraphic = Graphics.drawImageExtended(162, 514, 0, 18, 600, 14, self.bodyHealth/100, 1, healthbarImages)
  self.enemyHealthBarOutline = Graphics.drawPartialImage( 160, 510, 0, 0, 604, 18, healthbarImages)
  
end

function Boss:DeadUpdate()
  
  if(self.isDead == true) then
  
  self.isDeadTimer = self.isDeadTimer + 1;
    
  end
  
  
  if(self.isDeadTimer > 300) then
  
  self.y = self.y + 1.5;
  self.x = self.x - .33;
    
  end
  
  if(self.y > 700) then
  GameComplete();  
  end
  

  
end


function Boss:DrawExplosions()
  
  if(self.isDead == false) then
    
  return;  
  end
  
  if(self.isDeadTimer == 60) then
    PlaySounds("finalExplosion1");
    
  end
   if(self.isDeadTimer == 180) then
    
     PlaySounds("finalExplosion2");
  end
  
   if(self.isDeadTimer == 300) then
    
     PlaySounds("finalExplosion3");
  end
  
  
 if(self.isDeadTimer < 60) then
    self.drawExplosionBubble = Graphics.drawImage(self.x + 50, self.y +30, explosionBubble)
  end
  
  if(self.isDeadTimer > 60 and self.isDeadTimer < 120) then
    self.drawExplosionBubble = Graphics.drawImage(self.x +100, self.y + 80, explosionBubble)
  end
  
  if(self.isDeadTimer > 120 and self.isDeadTimer < 180) then
    self.drawExplosionBubble = Graphics.drawImage(self.x + 30, self.y +135, explosionBubble)
  end
  
  if(self.isDeadTimer > 180 and self.isDeadTimer < 240) then
    self.drawExplosionBubble = Graphics.drawImage(self.x + 160, self.y + 50, explosionBubble)
  end
  
  if(self.isDeadTimer > 240 and self.isDeadTimer < 300) then
    self.drawExplosionBubble = Graphics.drawImage(self.x + 40, self.y + 30, explosionBubble)
  end

  
  
end



function Boss:Update()
self.waitTimeToSendOutEnemies = self.waitTimeToSendOutEnemies + 1;
  if(self.topLaserHitTimer < 8) then
  
  self.topLaserColor = Color.new(255,0,0);
  self.topLaserHitTimer = self.topLaserHitTimer + 1;
  else
  self.topLaserColor = Color.new(255,255,255);
  end
  
  if(self.bottomLaserHitTimer < 8) then
    self.bottomLaserColor = Color.new (255,0,0)
    self.bottomLaserHitTimer = self.bottomLaserHitTimer + 1
  else
    
     self.bottomLaserColor = Color.new (255,255,255)
  end
  
  
  if(self.bodyHitTimer < 8) then
    
    self.bodyColor = Color.new(255,0,0)
    self.bodyHitTimer = self.bodyHitTimer + 1;
  else
    
    self.bodyColor = Color.new(255,255,255)
  end
  self:MoveUp();
  self:MoveDown();
  self:DecideIfShouldActivateLaser();
  self:MoveForward();
  self:DrawLaser();
  self:CallOutEnemies();
  self:DeadUpdate();
  self:Draw()
  self:DrawHealthBar()
  self:DrawChargeBubble();
  self:DrawExplosions()
  
end


