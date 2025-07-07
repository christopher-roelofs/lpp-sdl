RectangleCollision = {}

function RectangleCollision:New(x,y,width,length)
  rectangleCollision = {}
  setmetatable(rectangleCollision,self)
  self.__index = self
  
  rectangleCollision.x = x
  rectangleCollision.y = y
  rectangleCollision.width = width
  rectangleCollision.length = length
  
  return rectangleCollision
end

function RectangleCollision:Draw()
  
  Graphics.fillRect(self.x - cameraX, self.x + (self.width * 32) - cameraX, self.y - cameraY, self.y + (self.length * 32) - cameraY, Color.new(255,0,0,100))
  
end

function RectangleCollision:GetDimensions()
  
  return{self.x, self.x + (self.width * 32), self.y, self.y + (self.length * 32)}
  
end


function RectangleCollision:Update()
  
end

