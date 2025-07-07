RepairBeam = {}

function RepairBeam:New(x,y,direction)
  repairBeam = {}
  setmetatable(repairBeam, self)
  self.__index = self
  
  repairBeam.x = x
  repairBeam.y = y
  repairBeam.endX = 0
  repairBeam.endY = 0
  repairBeam.directionFacing = direction
  repairBeam.isDead = false
  
  
  return repairBeam
end

function RepairBeam:Draw()
  Graphics.drawLine(self.x - cameraX,  self.endX - cameraX, self.y - cameraY, self.endY - cameraY, Color.new(0,255,0)) 
end

function RepairBeam:LookForSomethingToRepair()
  
end

function RepairBeam:GetEndXAndY()
  
  if(self.directionFacing == "north") then
    self.endX = self.x
    self.endY = self.y - 96
  end
  
  if(self.directionFacing == "south") then
    self.endX = self.x
    self.endY = self.y + 96
  end
  
  if(self.directionFacing == "east") then
    self.endX = self.x + 96
    self.endY = self.y
  end
  
  if(self.directionFacing == "west") then
    self.endX = self.x - 96
    self.endY = self.y
  end 
end

function RepairBeam:KillSelf()
self.isDead = true  
end

function RepairBeam:GetSelf()
return self  
end

function RepairBeam:UpdatePosition(x,y, direction)
  self.x = x
  self.y = y
  self.directionFacing = direction
end



function RepairBeam:Update()
  self:GetEndXAndY()
  
  return self.isDead
end

