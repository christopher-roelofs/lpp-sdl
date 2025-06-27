HealthPack = {};
healthPng = Graphics.loadImage("app0:/Sprites/HealthPickUp.png")

function HealthPack:new(xPos,yPos)
  healthPacks = {}
  setmetatable(healthPacks, self);
  self.__index = self;
  healthPacks.x =xPos;
  healthPacks.y = yPos;
  healthPacks.isDead = false;
  healthPacks.lifeTime = 0;
  
  return healthPacks;
end



function HealthPack:Draw()
self.healthPackSprite = Graphics.drawImage(self.x, self.y, healthPng)
end

function HealthPack:CheckLife()
  
return self.isDead;  
end


function HealthPack:CheckLifeTime()
  
  if(self.lifeTime >= 420) then
  self.isDead = true;  
  end
  
  
end


function HealthPack:Update()
self.lifeTime = self.lifeTime + 1;
self:CheckLifeTime()
self:Draw();
end
