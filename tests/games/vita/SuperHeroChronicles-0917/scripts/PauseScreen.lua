PauseScreen = {}


function PauseScreen:new()
   pauseScreen = {}
  setmetatable(pauseScreen, self);
  self.__index = self;
  
  return pauseScreen
end



function PauseScreen:Draw()
  self.rect = Graphics.fillRect(0, 0, 960, 544, Color.new(0,0,0)) 
  Font.print(myFont, 400, 250, "Game Paused", Color.new(255,255,255))  
end



function PauseScreen:Update()
  
  self:Draw()
end
