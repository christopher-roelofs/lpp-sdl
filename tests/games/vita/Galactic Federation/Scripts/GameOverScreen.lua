GameOverScreen = {}

function GameOverScreen:New()
  gameOverScreen = {}
  setmetatable(gameOverScreen, self)
  self.__index = self
  gameOverScreen.screenPosition = 1
  gameOverScreen.isDead = false
  return gameOverScreen
end

function GameOverScreen:Draw()
  
  Graphics.fillRect(0, 960, 0, 544, Color.new(0,0,0)) 
  Font.setPixelSizes(fontObj,64)
  Font.print(fontObj,300,150,"Game Over",Color.new(255,0,0))
  Font.setPixelSizes(fontObj,18)
  if(self.screenPosition == 1) then
    Font.print(fontObj,300,300,"Retry",Color.new(255,0,0))
    Font.print(fontObj,550,300,"Main Menu",Color.new(255,255,255))
  end
  
  if(self.screenPosition == 2) then
    Font.print(fontObj,300,300,"Retry",Color.new(255,255,255))
    Font.print(fontObj,550,300,"Main Menu",Color.new(255,0,0))
  end
  
end

function GameOverScreen:GetLeftPress()
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].padLeftIsPressed == true and controllerObj[i].padLeftCanBePressed == true) then
        self.screenPosition = self.screenPosition - 1
    end
    
  end
  
end

function GameOverScreen:GetRightPress()
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].padRightIsPressed == true and controllerObj[i].padRightCanBePressed == true) then
        self.screenPosition = self.screenPosition + 1
    end
  end
end

function GameOverScreen:GetXPress()
  for i, value in ipairs(controllerObj) do
    
    if(controllerObj[i].crossIsPressed == true and controllerObj[i].crossCanBePressed == true) then
        self.isDead = true
        if(self.screenPosition == 1) then
          NewGame()
        end
        
        if(self.screenPosition == 2) then
          MainMenuScreen()
        end
        
        
    end
    
    
  end
end

function GameOverScreen:GetCorrectPosition()
  
  if(self.screenPosition <= 0) then
    self.screenPosition = 2
  end
  
  if(self.screenPosition >= 3) then
    self.screenPosition = 1
  end
  
  
end


function GameOverScreen:Update()
  self:GetLeftPress()
  self:GetRightPress()
  self:GetCorrectPosition()
  self:GetXPress()
  
  return self.isDead
end
