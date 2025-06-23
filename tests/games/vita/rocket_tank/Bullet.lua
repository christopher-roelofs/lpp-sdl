Bullet = {
	x  = 0,
	y  = 0,
	xv = 0,
	yv = 0,
	active = false,
  lifetime = 0
}
sprite = Graphics.loadImage("resources/bullet.png")
shoot = Sound.openWav("resources/shoot.wav")
-- Derived class method new

function Bullet:new (o,x,y,xv,yv,active)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   self.x = x or 0
   self.y = y or 0
   self.xv = xv or 0
   self.yv = yv or 0
   self.active = active or false
   self.lifetime = 60*3
   return o
end
function Bullet:shoot()
  playSound(shoot)
end
-- Derived class method printArea
function Bullet:update()
  self.lifetime = self.lifetime - 1
  if(self.lifetime <=0)then
    self.active = false
  end
  if(self.active) then
    self.x = self.x + self.xv
    self.y = self.y + self.yv
  end
end

function Bullet:draw ()
  if(self.active) then
     Graphics.drawImage(self.x,self.y,sprite)
  end
end
