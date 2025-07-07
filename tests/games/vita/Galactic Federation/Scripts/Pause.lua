Pause = {}
pauseImage = Graphics.loadImage("app0:/Sprites/PauseScreen.png")
selectImage = Graphics.loadImage("app0:/Sprites/SelectBox.png")
listOfItemsImage = Graphics.loadImage("app0:/Sprites/List Of Items.png")

function Pause:SetBlankList()
  tempTable = {}
    
  for y = 1, 12, 1 do
    table.insert(tempTable,y, {})  
    for x = 1, 12, 1 do
    table.insert(tempTable[y],x, "")   
    end
  end
  
  
  
end


function Pause:New()
  
  pause = {}
  setmetatable(pause,self)
  self.__index = self
  pause.isDead = false
  pause.positions = {1,1}
  pause.selectX = 0
  pause.selectY = 0
  pause.itemList = Pause:SetBlankList()
  pause.selectedItem = ""
  pause.secondMenuIsActive = false
  pause.secondScreenObj = nil
  
  
  pause.xPos = {24,59,94,129,164,199,234,269,304,339,374,409,24,59,94,129,164,199,234,269,304,339,374,409,24,59,94,129,164,199,234,269,304,339,374,409,24,59,94,129,164,199,234,269,304,339,374,409,24,59,94,129,164,199,234,269,304,339,374,409,24,59,94,129,164,199,234,269,304,339,374,409,24,59,94,129,164,199,234,269,304,339,374,409,24,59,94,129,164,199,234,269,304,339,374,409,24,59,94,129,164,199,234,269,304,339,374,409,24,59,94,129,164,199,234,269,304,339,374,409,24,59,94,129,164,199,234,269,304,339,374,409,24,59,94,129,164,199,234,269,304,339,374,409}
  
  return pause
  
end


function Pause:Draw()
  
  Graphics.drawImage (12 , 3, pauseImage)
  Graphics.drawImage (496, 3, pauseImage)
  Graphics.drawImage(self.selectX, self.selectY, selectImage)
  Graphics.drawLine(525, 925, 120, 120, Color.new(255,255,255)) 

for p = 1, #playerObj, 1 do

for i = 1, #playerObj[p].itemsHeld, 1 do
  
  self.yPos = 0
  
  if(i <= 12) then
    self.yPos = 24
  end
  
  if(i >= 13 and i <= 24) then
    self.yPos = 59
  end
  
  if(i >= 25 and i <= 36) then
    self.yPos = 94
  end
  
  if(i >= 37 and i <= 48) then
    self.yPos = 129
  end
  
  if(i >= 49 and i <= 60) then
    self.yPos = 164
  end
  
  if(i >= 61 and i <= 72) then
    self.yPos = 199
  end
  
  if(i >= 73 and i <= 84) then
    self.yPos = 234
  end
  
  if(i >= 85 and i <= 96) then
    self.yPos = 269
  end
  
  if(i >= 97 and i <= 108) then
   self.yPos = 304
  end
  
  if(i >=109  and i <= 120) then
    self.yPos = 339
  end
  
  if(i >= 121 and i <= 132) then
    self.yPos = 374
  end
  
  if(i >= 133 and i <= 144) then
    self.yPos = 409
  end
  
  if(playerObj[p].itemsHeld[i] == "Light Armor") then
    Graphics.drawPartialImage(self.xPos[i], self.yPos, 64, 32, 32, 32, listOfItemsImage)
  end
  
   if(playerObj[p].itemsHeld[i] == "Light Boots") then
    Graphics.drawPartialImage(self.xPos[i], self.yPos, 32, 32, 32, 32, listOfItemsImage)
  end
  
   if(playerObj[p].itemsHeld[i] == "Light Pants") then
    Graphics.drawPartialImage(self.xPos[i], self.yPos, 0, 64, 32, 32, listOfItemsImage)
  end
  
   if(playerObj[p].itemsHeld[i] == "Light Gloves") then
    Graphics.drawPartialImage(self.xPos[i], self.yPos, 64, 64, 32, 32, listOfItemsImage)
  end
   if(playerObj[p].itemsHeld[i] == "Light Helmet") then
    Graphics.drawPartialImage(self.xPos[i], self.yPos, 32, 64, 32, 32, listOfItemsImage)
  end
  
  if(playerObj[p].itemsHeld[i] == "Key") then
    Graphics.drawPartialImage(self.xPos[i], self.yPos, 0, 0, 32, 32, listOfItemsImage)
  end
  
  if(playerObj[p].itemsHeld[i] == "Key Lv 1") then
    Graphics.drawPartialImage(self.xPos[i], self.yPos, 32, 0, 32, 32, listOfItemsImage)
  end
  
  if(playerObj[p].itemsHeld[i] == "Key Lv 2") then
    Graphics.drawPartialImage(self.xPos[i], self.yPos, 64, 0, 32, 32, listOfItemsImage)
  end
  if(playerObj[p].itemsHeld[i] == "Key Lv 3") then
    Graphics.drawPartialImage(self.xPos[i], self.yPos, 0, 32, 32, 32, listOfItemsImage)
  end
  
  
end


  
end  
  
Font.print(pauseFont, 530, 20, "Health:", Color.new(255,255,255)) 
Font.print(pauseFont, 750, 20, "Strength:", Color.new(255,255,255)) 
Font.print(pauseFont, 530, 50, "Intelligence:", Color.new(255,255,255)) 
Font.print(pauseFont, 750, 50, "Defense:", Color.new(255,255,255)) 
Font.print(pauseFont, 530, 80, "Agility:", Color.new(255,255,255)) 
Font.print(pauseFont, 750, 80, "Hacking:", Color.new(255,255,255)) 

Font.print(pauseFont, 530, 400, self.selectedItem, Color.new(255,255,255)) 

if(self.secondScreenObj ~= nil) then
self.secondScreenObj:Draw()  
end

  
end

function Pause:CloseMenu()
  
  for i, value in ipairs(controllerObj) do
  
  if(controllerObj[i].startIsPressed == true and controllerObj[i].startCanBePressed == true) then
  
  self.isDead = true
    
  end
  
    
  end
  
  
end

function Pause:Move()
  if(self.secondMenuIsActive == true) then
    return
  end
  
  for i, value in ipairs(controllerObj) do
    
    if(controllerObj[i].padLeftIsPressed == true and controllerObj[i].padLeftCanBePressed == true) then
      self.positions[1] = self.positions[1] - 1
    end
    
    if(controllerObj[i].padRightIsPressed == true and controllerObj[i].padRightCanBePressed == true) then
      self.positions[1] = self.positions[1] + 1
    end
    
    if(controllerObj[i].padUpIsPressed == true and controllerObj[i].padUpCanBePressed == true) then
      
      self.positions[2] = self.positions[2] - 1
    end
    
    if(controllerObj[i].padDownIsPressed == true and controllerObj[i].padDownCanBePressed == true) then
      
      self.positions[2] = self.positions[2] + 1
      
    end
    
  end
  
  if(self.positions[1] > 12) then
    
    self.positions[1] = 1
    
  end
  
  if(self.positions[1] < 1) then
    
    self.positions[1] = 12
    
  end
  
  if(self.positions[2] > 12) then
  
  self.positions[2] = 1
  
end

if(self.positions[2] < 1) then
  
  self.positions[2] = 12
  
  end
  
  
  
  
end

function Pause:ChooseItem()
  
  itemPosition = ((self.positions[2] - 1) * 12) + self.positions[1]
  
  for p = 1, #playerObj, 1 do
  
    self.selectedItem = playerObj[p].itemsHeld[itemPosition]
  
end

if(self.selectedItem == nil) then
  
  self.selectedItem = ""
  
end


  
end



function Pause:AssignValues()
  
    self.selectX = 24 + (32 * (self.positions[1] - 1)) + (3 * (self.positions[1] - 1)) 
    self.selectY = 24 + (32 * (self.positions[2] - 1)) + (3 * (self.positions[2] - 1)) 

end

function Pause:ItemPositions()
  
  
end

function Pause:RemoveItem()
  for i = 1, #playerObj, 1 do
    if(playerObj[i].itemsHeld[((self.positions[2] - 1) * 12) + self.positions[1]] ~= nil) then
      table.remove(playerObj[i].itemsHeld, ((self.positions[2] - 1) * 12) + self.positions[1])
    end
  end
end


function Pause:UseMenu()
  
  for i = 1, #controllerObj, 1 do
    
    if(controllerObj[i].crossIsPressed == true and controllerObj[i].crossCanBePressed == true) then
      
      if(self.secondMenuIsActive == false and self.selectedItem ~= "" and self.selectedItem ~= nil) then
        
        self.secondMenuIsActive = true
        self.secondScreenObj = UseMenu:New(self.selectX,self.selectY,true,true,true)
        
      end
      
    end
    
  end
  
end

function Pause:CloseSecondMenu()
  
  self.secondMenuIsActive = false
  self.secondScreenObj= nil
  
end

function Pause:UpdateSecondScreen()
  
  if(self.secondScreenObj ~= nil) then
    self.secondScreenObj:Update()
  end
  
  
end

function Pause:DropItem()
  for i = 1, #playerObj, 1 do
    table.insert(itemsObj, #itemsObj + 1, Items:New(playerObj[i].x,playerObj[i].y,self.selectedItem))
  end
  
end


function Pause:Update()
  self:Move()
  self:AssignValues()
  self:UpdateSecondScreen()
  self:ChooseItem()
  self:UseMenu()
  self:CloseMenu()
  return self.isDead
end
