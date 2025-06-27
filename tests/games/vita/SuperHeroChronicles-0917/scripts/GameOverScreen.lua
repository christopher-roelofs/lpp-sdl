GameOverScreen = {};
GameOverScreenImg = Graphics.loadImage("app0:/Sprites/GameOverScreen.png");

function GameOverScreen:new()
  gameOverScreen = {}
  setmetatable(gameOverScreen, self);
  self.__index = self;
  gameOverScreen.xIsPressed = true;
  gameOverScreen.xCanBePressed = false;
  return gameOverScreen;
end

function GameOverScreen:Draw()
   self.gameOverScreenObj = Graphics.drawPartialImage(38, 0, 0,0,889,544, GameOverScreenImg);
end

function GameOverScreen:CheckButtonPresses()
  if (Controls.check(Controls.read(), SCE_CTRL_CROSS)) then
  self.xIsPressed = true 
  
else
  self.xIsPressed = false;
  end
    
end

function GameOverScreen:ReturnToMainMenu()
  if(self.xCanBePressed == true and self.xIsPressed == true) then
  GameOverMainMenuFunc()
  end
end


 function GameOverScreen:CheckIfButtonCanBePressed()
   
   if(self.xIsPressed == false) then
     self.xCanBePressed = true;
   else
     
     self.xCanBePressed = false;
   end
   
   end

function GameOverScreen:Update()
  self:Draw();
  self:CheckButtonPresses();
  self:ReturnToMainMenu();
  self:CheckIfButtonCanBePressed();
end
