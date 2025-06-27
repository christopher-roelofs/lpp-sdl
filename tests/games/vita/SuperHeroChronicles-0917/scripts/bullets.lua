bullets = {}
bulletImage = Graphics.loadImage("app0:/Sprites/Bullet.png");


function bullets:new  (xPos, yPos, vert, hort,rot)
  bulletsObj = {}
  setmetatable(bulletsObj, self);
  self.__index = self;
  
  bulletsObj.xPosition = xPos;
  bulletsObj.yPosition = yPos;
  bulletsObj.imgWidth = Graphics.getImageWidth(bulletImage)
  bulletsObj.imgHeight = Graphics.getImageHeight(bulletImage)
  bulletsObj.isDead = false;
  bulletsObj.verticleSpeed = vert;
  bulletsObj.horizontalSpeed =hort
  bulletsObj.rotation = rot;
  
  return bulletsObj;
  
 
  end
  
  function bullets:Movement()

self.xPosition = self.xPosition + self.verticleSpeed;
self.yPosition = self.yPosition + self.horizontalSpeed;
end

function bullets:CheckCollision()
  
  for i, value in ipairs(waveManager.ListOfEnemy1) do
  self.xRight = self.xPosition + self.imgWidth
  self.yBottom = self.yPosition + self.imgHeight
  self.isDead = waveManager.ListOfEnemy1[i]:CheckCollision(self.xPosition,self.xRight,self.yPosition,self.yBottom);
  
  if(self.isDead == true) then
    
    break
    end
  
end
if(self.isDead == true) then
    playerObj.AddToComboMeter();
    return
    end

for i, value in ipairs(waveManager.ListOfRobots) do
  self.xRight = self.xPosition + self.imgWidth
  self.yBottom = self.yPosition + self.imgHeight
  self.isDead = waveManager.ListOfRobots[i]:CheckCollision(self.xPosition,self.xRight,self.yPosition,self.yBottom);
  
  if(self.isDead == true) then
    
    break
  end
  
end
if(self.isDead == true) then
   playerObj.AddToComboMeter();
    return
    end

for i, value in ipairs(listOfEnemyBullets) do
  self.xRight = self.xPosition + self.imgWidth
  self.yBottom = self.yPosition + self.imgHeight
  self.isDead = listOfEnemyBullets[i]:CheckCollision(self.xPosition,self.xRight,self.yPosition,self.yBottom);
  
  if(self.isDead == true) then
    
    break
    end
  end
  if(self.isDead == true) then
  playerObj.AddToComboMeter();
    return
  end
  
  for i, value in ipairs(waveManager.ListOfShips) do
  self.xRight = self.xPosition + self.imgWidth
  self.yBottom = self.yPosition + self.imgHeight
  self.isDead = waveManager.ListOfShips[i]:CheckCollision(self.xPosition,self.xRight,self.yPosition,self.yBottom);
  
  if(self.isDead == true) then
    
    break
    end
  end
  if(self.isDead == true) then
    playerObj.AddToComboMeter();
    return
  end
  
  
    for i, value in ipairs(waveManager.ListOfScooters) do
  self.xRight = self.xPosition + self.imgWidth
  self.yBottom = self.yPosition + self.imgHeight
  self.isDead = waveManager.ListOfScooters[i]:CheckCollision(self.xPosition,self.xRight,self.yPosition,self.yBottom);
  
  if(self.isDead == true) then
    
    break
    end
  end
  if(self.isDead == true) then
   playerObj.AddToComboMeter();
    return
  end
  
    for i, value in ipairs(waveManager.ListOfBosses) do
  self.xRight = self.xPosition + self.imgWidth
  self.yBottom = self.yPosition + self.imgHeight
  self.isDead = waveManager.ListOfBosses[i]:CheckCollision(self.xPosition,self.xRight,self.yPosition,self.yBottom);
  
  if(self.isDead == true) then
    
    break
    end
  end
  if(self.isDead == true) then
   playerObj.AddToComboMeter();
    return
  end
  
  if(self.isDead == nil) then
  self.isDead = true;  
  end
  
  
  end


function bullets:Draw()
  
 --Graphics.initBlend()
--Screen.clear()
  self.bulletSprite = Graphics.drawRotateImage( self.xPosition, self.yPosition, bulletImage, self.rotation)
 --
 --Screen.flip()
 
 --Graphics.termBlend()
end

function bullets:CheckDestroy()
  
  
  
end

function bullets:CheckXPosition()
  if(self.xPosition >= 960) then
  self.isDead = true
  end
end



function bullets:Update()
  
  if(self.isDead == false) then
  self:Movement();
  self:CheckCollision();
  self:Draw();
  self:CheckXPosition();
  return false
end
return true
 
end
 
  

 