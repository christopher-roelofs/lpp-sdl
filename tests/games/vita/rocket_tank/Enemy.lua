-- Meta class
Enemy = {
  hp = 500,
	x = 500,
	y = 500,
	xv = 1,
	yv = 1,
}
sprite = Graphics.loadImage("resources/enemy.png")

-- Derived class method new

function Enemy:new (o,length,breadth)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   self.length = length or 0
   self.breadth = breadth or 0
   self.area = length*breadth;
   return o
end

-- Derived class method printArea

function Enemy:printArea ()
   print("The area of Enemy is ",self.area)
end
function Enemy:draw ()
  if(self.active) then
     Graphics.drawImage(self.x,self.y,sprite)
  end
end
