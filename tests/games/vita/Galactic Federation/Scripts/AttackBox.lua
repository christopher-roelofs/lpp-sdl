AttackBox = {}

function AttackBox:New(x,y,length,width)
  attackBox = {}
  setmetatable(attackBox, self)
  self.__index = self
  attackBox.x = x
  attackBox.y = y
  attackBox.length = length
  attackBox.width = width
  
  return attackBox
end
function AttackBox:Draw()
  
end

function AttackBox:ReadjustSize()
  
end


function AttackBox:Update()
  
end

