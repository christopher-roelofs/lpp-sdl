UseMenu = {}
useMenuImg = Graphics.loadImage("app0:/Sprites/EquipMenu.png")

function UseMenu:New(x,y,use,equip,drop)
useMenu = {}
setmetatable(useMenu, self)
self.__index = self

useMenu.x = x
useMenu.y = y
useMenu.use = use
useMenu.equip = equip
useMenu.drop = drop
useMenu.currentPosition = 1
useMenu.isDead = false

return useMenu
end

function UseMenu:Draw()
  
  Graphics.drawImage(self.x, self.y, useMenuImg) 
  
  if(self.use == true) then
    Font.print(pauseFont, self.x + 5 + 10, self.y + 5 + 3, "Use", Color.new(0,0,0)) 
    else
    Font.print(pauseFont, self.x + 5 + 10, self.y + 5 + 3, "Use", Color.new(155,155,155)) 
  end
  
  if(self.equip == true) then
    Font.print(pauseFont, self.x + 5 + 5, self.y + 5 + 33, "Equip", Color.new(0,0,0)) 
    else
     Font.print(pauseFont, self.x + 5 + 5, self.y + 5 + 33, "Equip", Color.new(155,155,155))
  end
  
  if(self.drop == true) then
     Font.print(pauseFont, self.x + 5 + 7, self.y + 5 + 63, "Drop", Color.new(0,0,0))
    else
     Font.print(pauseFont, self.x + 5 + 7, self.y + 5 + 63, "Drop", Color.new(155,155,155))
  end
  
  
  if(self.currentPosition == 1) then
    Graphics.fillRect(self.x + 5, self.x + 55,self.y + 6, self.y + 35, Color.new(255,169,63,100)) 
  end
  
  if(self.currentPosition == 2) then
    Graphics.fillRect(self.x + 5, self.x + 55,self.y + 36, self.y + 65, Color.new(255,169,63,100)) 
  end
  
  if(self.currentPosition == 3) then
    Graphics.fillRect(self.x + 5, self.x + 55,self.y + 66, self.y + 95, Color.new(255,169,63,100)) 
  end
  
  
end

function UseMenu:UseItem()
  if(self.use == false) then
    return
  end
  
end

function UseMenu:EquipItem()
  if(self.equip == false) then
    return
  end
  
end

function UseMenu:DropItem()
  if(self.drop == false) then
    return
  end
  
  for i = 1, #pauseObj, 1 do
      pauseObj[i]:DropItem()
      pauseObj[i]:RemoveItem()
      self.isDead = true
    end
  
end

function UseMenu:CrossPress()
  
  if(self.currentPosition == 1) then
    self:UseItem()
  end
  
  if(self.currentPosition == 2) then
    self:EquipItem()
  end
  
  if(self.currentPosition == 3) then
    self:DropItem()
  end
  
end
function UseMenu:Move()

for i = 1, #controllerObj, 1 do
  if(controllerObj[i].padUpIsPressed == true and controllerObj[i].padUpCanBePressed == true) then
    self.currentPosition = self.currentPosition - 1
  end
  
  if(controllerObj[i].padDownIsPressed == true and controllerObj[i].padDownCanBePressed == true) then
    self.currentPosition = self.currentPosition + 1
  end
  
  if(controllerObj[i].crossIsPressed == true and controllerObj[i].crossCanBePressed == true) then
    self:CrossPress()
  end
  
  if(controllerObj[i].circleIsPressed == true and controllerObj[i].circleCanBePressed == true) then
    self.isDead = true
  end
end

if(self.currentPosition < 1) then
  self.currentPosition = 3
end

if(self.currentPosition > 3) then
self.currentPosition = 1  
end


end

function UseMenu:CloseMenu()
  
  if(self.isDead == true) then
    
    for i = 1, #pauseObj, 1 do
      
      pauseObj[i]:CloseSecondMenu()
      for i = 1, #controllerObj, 1 do
    -- Gets button presses and releases
    controllerObj[i]:GetCanPresses()
    end
      
    end
    
  end
  
end

function UseMenu:Update()
  self:Move()
  self:CloseMenu()
end
