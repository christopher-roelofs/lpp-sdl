require("bullet")

Tank = {
  hp = 0.0,
	x  = 0.0,
	y  = 0.0,
  tankFacing = 0,
  gunFacing = 0,
  bullet = Bullet:new(nil,-50,-50,0,0,false),
  color = Color.new(128,128,128,255)
}

gunBase = Graphics.loadImage("resources/tanktopBase.png")
tankBase = Graphics.loadImage("resources/tankbottomBase.png")

gunColor = Graphics.loadImage("resources/tanktopColor.png")
tankColor = Graphics.loadImage("resources/tankbottomColor.png")

-- Derived class method new

function Tank:new (o,x,y,color)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   self.x = x or 0.0
   self.y = y or 0.0
   self.hp = 500.0
   self.bullet = Bullet:new(nil,-50,-50,0,0,false)
   self.color = color or Color.new(128,128,128,255)
   return o
end
function Tank:newColor()
  self.color = Color.new(
  math.floor(math.random(255)),
  math.floor(math.random(255)),
  math.floor(math.random(255)),255)
end
function Tank:shoot()
  if(self.bullet.active == false) then
    self.bullet:shoot()
    self.bullet.x  = self.x-16
    self.bullet.y  = self.y-16
    self.bullet.xv =  math.sin(self.gunFacing)*10
    self.bullet.yv = -math.cos(self.gunFacing)*10
    self.bullet.active = true
    self.bullet.lifetime = 60*2
  end
end

function Tank:draw()
  Graphics.drawRotateImage(self.x,self.y,tankColor,self.tankFacing,self.color)
  Graphics.drawRotateImage(self.x,self.y,tankBase,self.tankFacing)
  self.bullet:draw()
  if(self.hp>0) then
    Graphics.drawRotateImage(self.x,self.y,gunColor,self.gunFacing,self.color)
    Graphics.drawRotateImage(self.x,self.y,gunBase,self.gunFacing)
	end
  Graphics.debugPrint(math.floor(self.x-70),math.floor(self.y-100),"HP: "..math.floor(self.hp),self.color)
end
