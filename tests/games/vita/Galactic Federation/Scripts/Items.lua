Items = {}

function Items:New(x,y,name)
  items = {}
  setmetatable(items, self)
  self.__index = self
  
  items.x = x
  items.y = y
  items.name = name
  items.isDead = false
  
  return items
end

function Items:Draw()
  
  if(self.name == "Light Armor") then
    Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 64, 32, 32, 32, listOfItemsImage)
  end
  
   if(self.name == "Light Boots") then
    Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 32, 32, 32, 32, listOfItemsImage)
  end
  
   if(self.name == "Light Pants") then
    Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 0, 64, 32, 32, listOfItemsImage)
  end
  
   if(self.name == "Light Gloves") then
    Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 64, 64, 32, 32, listOfItemsImage)
  end
   if(self.name == "Light Helmet") then
    Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 32, 64, 32, 32, listOfItemsImage)
  end
  
  if(self.name == "Key") then
    Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 0, 0, 32, 32, listOfItemsImage)
  end
  
  if(self.name == "Key Lv 1") then
    Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 32, 0, 32, 32, listOfItemsImage)
  end
  
  if(self.name == "Key Lv 2") then
    Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 64, 0, 32, 32, listOfItemsImage)
  end
  if(self.name == "Key Lv 3") then
    Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY, 0, 32, 32, 32, listOfItemsImage)
  end
  
   if(self.name == "Health Pack") then
    Graphics.drawImageExtended(self.x - cameraX, self.y - cameraY, 160, 40, 40, 40, .75,.75, imagesToSelect)
  end
  
end

function GetItemStats(itemName)
  -- Use,Equipable,Drop
  if(itemName == 'Translator') then
    return{false,false,false}
  end
  
   if(itemName == 'Key') then
    return{false,false,true}
  end
  
   if(itemName == 'Key Lv 1') then
    return{false, false, true}
  end
  
   if(itemName == 'Key Lv 2') then
    return{false,false,true}
  end
  
   if(itemName == 'Key Lv 3') then
    return{false,false,true}
  end
  
   if(itemName == 'Light Jacket') then
    return{false,true,true}
  end
  
  if(itemName == 'Light Pants') then
    return{false,true,true}
  end
  
  if(itemName == 'Light Boots') then
    return{false,true,true}
  end
  
  if(itemName == 'Light Gloves') then
    return{false,true,true}
  end
  
  if(itemName == 'Light Helmet') then
    return{false,true,true}
  end
  
end

function Items:GetDimensions()
return{self.x, self.x + 32, self.y, self.y + 32}  
end


function Items:Update()
  
  
  return self.isDead
end
