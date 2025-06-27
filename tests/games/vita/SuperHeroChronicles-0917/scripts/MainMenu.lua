MainMenu = {};


function MainMenu:new()
  mainMenu = {}
  setmetatable(mainMenu, self);
  self.__index = self;
  mainMenu.mainMenuImg = Graphics.loadImage("app0:/Sprites/MainMenu.png");
  mainMenu.endMainMenuState = false;
  
  return mainMenu;
end

function MainMenu:RemoveMainMenu()
  
 -- Graphics.freeImage(self.mainMenuImg)
  
end



function MainMenu:Draw()
  mainMenuObj = Graphics.drawPartialImage(62, 15, 0,0,836,514, self.mainMenuImg);
end

function MainMenu:CheckForButtonPress()
  if (startIsPressed == true) then
    self.endMainMenuState = true;
  end
  
  
end


function MainMenu:Update()
  self:CheckForButtonPress();
  self:Draw();
  return self.endMainMenuState;
end
