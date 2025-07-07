ClassSelectionScreen = {}
classSelectionScreenImg = Graphics.loadImage("app0:/Sprites/Portraits/portraits.png");

function ClassSelectionScreen:New()
  classSelectionScreen = {}
  setmetatable(classSelectionScreen, self)
  self.__index = self
  
  classSelectionScreen.currentPosition = 1
  classSelectionScreen.isDead = false
  classSelectionScreen.textToDisplay = "";
  classSelectionScreen.isDead = false
  return classSelectionScreen
end

function ClassSelectionScreen:Draw()
  self.portrait1 = Graphics.drawPartialImage(178, 50, 128, 0, 64, 64, classSelectionScreenImg)
  self.portrait2 = Graphics.drawPartialImage(356, 50, 0, 0, 64, 64, classSelectionScreenImg)
  self.portrait3 = Graphics.drawPartialImage(534, 50, 64, 0, 64, 64, classSelectionScreenImg)
  self.portrait4 = Graphics.drawPartialImage(712, 50, 192, 0, 64, 64, classSelectionScreenImg)
  self.topText = Font.print(fontObj, 400, 10, "Pick Your Class", Color.new(255, 255, 255))
  self.bottomText = Font.print(fontObj, 10, 130, self.textToDisplay, Color.new(255, 255, 255))
  
  if(self.currentPosition == 1) then
  self.rect = Graphics.fillRect(179, 241, 51, 113, Color.new(255,0,0, 35)) 
end

if(self.currentPosition == 2) then
  self.rect = Graphics.fillRect(357, 419, 51, 113, Color.new(255,0,0, 35)) 
  end


if(self.currentPosition == 3) then
  self.rect = Graphics.fillRect(535, 597, 51, 113, Color.new(255,0,0, 35)) 
  end


if(self.currentPosition == 4) then
  self.rect = Graphics.fillRect(713, 775, 51, 113, Color.new(255,0,0, 35)) 
  end


  
end

function ClassSelectionScreen:MoveLeft()
  
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].padLeftIsPressed == true and controllerObj[i].padLeftCanBePressed == true) then
  
  self.currentPosition = self.currentPosition - 1
  
  end
  
  end
  
  if(self.currentPosition <= 0) then
  self.currentPosition = 4  
  end
  
  
end

function ClassSelectionScreen:ClassText()
  
  if(self.currentPosition == 1) then
self.textToDisplay = " Created from the merger of early Cro Magnon and Anunnaki DNA, Humans are the youngest civilization \n \n in Galaxy 6918BD. The species are still higly primative, but have advanced fast, because of Anunnaki \n \n DNA which has increased the species cognative ability. Despite this, the species is highly violent, \n \n and self-absorbed. The species continues to war within itself over physical difference and \n \n geographical boundries. It is advised that that Planet 717MW (Earth)  be avoided, and interaction \n \n stay limited. The species themselves are physical weak, and of average height. They mostly \n \n rely on tools and inteligence for survival."
end

if(self.currentPosition == 2) then
self.textToDisplay = " The Nuh-Ku are a warrior race, and the military arm of the Galactic Federation. They are from the \n \n Planet 810MW, which was destroyed by the star Cero when it went super nova. The wealthiest and \n \n strongest of the  Nuh-Ku escacped the planet before its destruction and now inhabit 7589MW. The \n \n average height of a Nuh-Ku is 9 feet, with a mass 6 times larger than even the most fit humans. Nuh-Ku\n \n are extremely fast, and with nearly inpenatrable skin. Despite their size and strength the species \n \n is extremly level headed, even in stressful situations. They are excelent tacticians on the battlefield, and when \n \n paired with other species they are best leading the squad."
end

if(self.currentPosition == 3) then
self.textToDisplay = " The Neo-Naki's are a sub-species of the Anunnaki. The Neo-Naki were once the Anunnaki's political \n\n elite, but mergered their bodies with machines. Soon after the merger the Neo-Naki's found \n\n themselves uninterested with the day to day dwellings of the Anunnaki's and left Planet 010MW. Since \n\n their depature they have scoured the galaxy cataloging each planet, and all of their life forms. \n\n The Neo-Naki's serve as the researchers of the Galactic federation. The Neo-Naki's detest violence, \n\n but will defend themselves when out in the field. Since they have mergered their bodies with \n\n technology they are essentially immune to most organic illnesses and aging."
end

if(self.currentPosition == 4) then
self.textToDisplay = " The Sorobt's are a cybernetic race created by the governing board of the Galactic Federation. They \n\n serve one purpose and that is to provide health services while out in the field. They are equiped with \n\n defense mechinisms to defend themselves, but since combat is not their primary function, their \n\n combat skills are not optimal for direct combat. Sorobt's are relativley quiet, but also self aware. It is \n\n said that after many years of operations  Sorobt's will develop quirks that some might deem as a \n\n  personality."
end

  
end


function ClassSelectionScreen:MoveRight()
  
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].padRightIsPressed == true and controllerObj[i].padRightCanBePressed == true) then
  
  self.currentPosition = self.currentPosition + 1
end

end

  
  if(self.currentPosition > 4) then
  self.currentPosition = 1  
  end
  
  
end

function ClassSelectionScreen:Select()
  for i, value in ipairs(controllerObj) do
    if(controllerObj[i].crossIsPressed == true and controllerObj[i].crossCanBePressed == true) then
  if(self.currentPosition == 1) then
    classIsSelected = "human"
  end
  
  if(self.currentPosition == 2) then
    classIsSelected = "alien"
  end
  
  if(self.currentPosition == 3) then
    classIsSelected = "android"
  end
  
  if(self.currentPosition == 4) then
    classIsSelected = "robot"
  end
  NewGame()
CloseClassSelectScreen()
  end
end

end


function ClassSelectionScreen:Update()
self:MoveLeft()
self:MoveRight()
self:ClassText()
self:Select()
  return self.isDead
end
