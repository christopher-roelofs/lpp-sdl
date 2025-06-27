MidBuilding = {};
midBuildingSprite = Graphics.loadImage("app0:/Sprites/MidBackground.png");

function MidBuilding:new(xPos,yPos,types)
   midBuildingObj = {}
  setmetatable(midBuildingObj, self);
  self.__index = self;
  midBuildingObj.x = xPos;
  midBuildingObj.y = yPos;
  midBuildingObj.typeOfBil = types;
  midBuildingObj.width = nil;
  
  return midBuildingObj;
end


function MidBuilding:Draw()
  if(self.typeOfBil == 1) then
  self.frontBuildingObjImg = Graphics.drawPartialImage(self.x, self.y, 387,345, 188, 414, midBuildingSprite);  
  self.width = 188;
end

if(self.typeOfBil == 2) then
  self.frontBuildingObjImg = Graphics.drawPartialImage(self.x, self.y, 0,438, 196, 374, midBuildingSprite); 
  self.width = 196;
end

if(self.typeOfBil == 3) then
  self.frontBuildingObjImg = Graphics.drawPartialImage(self.x, self.y, 387,0, 343, 345, midBuildingSprite); 
  self.width = 343;
end

if(self.typeOfBil == 4) then
  self.frontBuildingObjImg = Graphics.drawPartialImage(self.x, self.y, 575,345, 162, 362, midBuildingSprite);  
  self.width =162;
end

if(self.typeOfBil == 5) then
  self.frontBuildingObjImg = Graphics.drawPartialImage(self.x, self.y, 196,438, 188, 361, midBuildingSprite); 
  self.width = 188;
end

if(self.typeOfBil == 6) then
  self.frontBuildingObjImg = Graphics.drawPartialImage(self.x, self.y, 0,0, 387, 438, midBuildingSprite);
  self.width = 387;
  end
  
end


function MidBuilding:ResetPosition()
  
  self.biggestxPos = nil;
  if(self.x < -self.width) then
  self.biggestxPos = midObj1.x + midObj1.width;
  
  if(midObj2.x + midObj2.width > self.biggestxPos) then
    
    self.biggestxPos = midObj2.x + midObj2.width;
    
  end
  
  if(midObj3.x + midObj3.width > self.biggestxPos) then
    
    self.biggestxPos = midObj3.x + midObj3.width;
    
  end
  
  if(midObj4.x + midObj4.width > self.biggestxPos) then
    
    self.biggestxPos = midObj4.x + midObj4.width;
    
  end
  
  if(midObj5.x + midObj5.width > self.biggestxPos) then
    
    self.biggestxPos = midObj5.x + midObj5.width;
    
  end
  
  if(midObj6.x + midObj6.width > self.biggestxPos) then
    
    self.biggestxPos = midObj6.x + midObj6.width;
    
  end
self.x = self.biggestxPos;  

end

  
  
end



function MidBuilding:Move()
  
  self.x = self.x - 2;
 
  
  end




function MidBuilding:Update()
  
  self:Move();
  self:Draw();
   self:ResetPosition();
  
  end