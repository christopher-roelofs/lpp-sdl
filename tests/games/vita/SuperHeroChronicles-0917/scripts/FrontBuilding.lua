FrontBuilding ={};
frontBuildingSpriteSheet = Graphics.loadImage("app0:/Sprites/FrontBuilding.png");

function FrontBuilding:new(xPos, yPos, num)
  frontBuildingObj = {}
  setmetatable(frontBuildingObj, self);
  self.__index = self;
  frontBuildingObj.xPos = xPos;
  frontBuildingObj.yPos = yPos;
  frontBuildingObj.num = num;
  
  return frontBuildingObj;
end

function FrontBuilding:Draw()
  
  if(self.num == 1) then
  self.frontBuildingObjImg = Graphics.drawPartialImage(self.xPos, self.yPos, 0,0, 337, 143, frontBuildingSpriteSheet);
  end
  
  if(self.num == 2) then
  self.frontBuildingObjImg = Graphics.drawPartialImage(self.xPos, self.yPos, 0,143, 335, 143, frontBuildingSpriteSheet);
  end

end


function FrontBuilding:Move()
  
  self.xPos = self.xPos -3;
  
  if(self.xPos <= -350) then
    
    self.xPos = 1000;
    end
  
end

function FrontBuilding:Update()
  
  self:Move();
  self:Draw();
  
end
