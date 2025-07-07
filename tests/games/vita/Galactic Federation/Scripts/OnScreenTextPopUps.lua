OnScreenTextPopUps = {}
screenFont = Font.load("app0:/Fonts/Reactor7.ttf") 

function OnScreenTextPopUps:New(x,y,text, color)
  
  onScreenTexPopUps = {}
  setmetatable(onScreenTexPopUps, self)
  self.__index = self
  onScreenTexPopUps.x = x + 16
  onScreenTexPopUps.y = y
  onScreenTexPopUps.text = text
  onScreenTexPopUps.time = 0
  onScreenTexPopUps.color = color
  return onScreenTexPopUps
  
end


function OnScreenTextPopUps:Draw()
  
  Font.print(screenFont, self.x - cameraX, self.y - cameraY, self.text, self.color)
end

function OnScreenTextPopUps:Update()
  
  self.time = self.time + 1
  self.y = self.y - 1
  
  if(self.time > 20) then
  return true  
  end
  return false
  
end
