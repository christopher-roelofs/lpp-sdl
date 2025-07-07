MainMenu = {}
mainMenuImg = Graphics.loadImage("app0:/Sprites/MainMenu.png");
function MainMenu:New()
  mainMenu = {}
  setmetatable(mainMenu, self)
  self.__index = self
 
  mainMenu.menuPosition = 1
  mainMenu.isDead = false
  
  return mainMenu
end


function MainMenu:Draw()
  Font.setPixelSizes(textBoxFont, 32)
  Graphics.drawPartialImage(0, 0, 0, 0, 960, 544, mainMenuImg)
  if(self.menuPosition == 1) then
  Font.print(textBoxFont, 440, 320, "New Game", Color.new(255,0,0))
  Font.print(textBoxFont, 440, 350, "Load Game", Color.new(255,255,255))
  Font.print(textBoxFont, 455, 380, "Options", Color.new(255,255,255))
end

if(self.menuPosition == 2) then
  Font.print(textBoxFont, 440, 320, "New Game", Color.new(255,255,255))
  Font.print(textBoxFont, 440, 350, "Load Game", Color.new(255,0,0))
  Font.print(textBoxFont, 455, 380, "Options", Color.new(255,255,255))
end

if(self.menuPosition == 3) then
  Font.print(textBoxFont, 440, 320, "New Game", Color.new(255,255,255))
  Font.print(textBoxFont, 440, 350, "Load Game", Color.new(255,255,255))
  Font.print(textBoxFont, 455, 380, "Options", Color.new(255,0,0))
end

end

function MainMenu:MoveUp()
  
  for i, value in ipairs(controllerObj) do
  
  if(controllerObj[i].padUpIsPressed == true and controllerObj[i].padUpCanBePressed == true) then
  self.menuPosition = self.menuPosition -1
  end
  
  end
  
  if(self.menuPosition < 1) then
  
  self.menuPosition = 3
  
  end
  
  
end


function MainMenu:MoveDown()
  
  for i, value in ipairs(controllerObj) do
  if(controllerObj[i].padDownIsPressed == true and controllerObj[i].padDownCanBePressed == true) then
  self.menuPosition = self.menuPosition + 1
  end
  
end

  if(self.menuPosition > 3) then
  
  self.menuPosition = 1
  
  end
  
end

function MainMenu:Select()
  
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].crossIsPressed == true and controllerObj[i].crossCanBePressed == true) then
      
      if(self.menuPosition == 1) then
        CharacterSelectScreen()
        
      end
      
      
      if(self.menuPosition == 2) then
        
        
      end
      
      
      if(self.menuPosition == 3) then
        OptionsScreen()
      end
      
      
    end
    
  end
  
end

function MainMenu:Update()
  self:MoveUp()
  self:MoveDown()
  self:Select()
  
  return self.isDead
end
 