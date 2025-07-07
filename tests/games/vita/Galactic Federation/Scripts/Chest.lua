Chest = {}
chestImg = Graphics.loadImage("app0:/Sprites/Chest.png")

function Chest:New(x,y,open,orgin)
  chest = {}
  setmetatable(chest,self)
  self.__index = self
  chest.x = x
  chest.y = y
  chest.isOpen = open
  chest.itemType = ""
  chest.currentFrame = 0
  chest.orgin = orgin
  chest.isDead = false
  return chest
end

function Chest:Draw()
 
 --Font.print(pauseFont, 5, 5, tostring(self.orgin[1]), Color.new(255,255,255)) 
 
  if(self.isOpen == false) then
    self.currentFrame = self.currentFrame + 1
    if(self.currentFrame <= 6) then
          Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,0,0,32,32,chestImg)

    end
    
    if(self.currentFrame >=7) then
          Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,32,0,32,32,chestImg)

    end
    
    if(self.currentFrame > 12) then
    self.currentFrame = 0  
    end

  end
  
  
  if(self.isOpen == true) then
    Graphics.drawPartialImage(self.x - cameraX, self.y - cameraY,0,32,32,32,chestImg)
  end
  
  
end

function Chest:DecideItem()
  
  if(self.isOpen == false and self.itemType == "") then
  
    for i = #mapLoaderObj, 1, -1 do
    
      if(mapLoaderObj[i].name == "egypt1") then
        
        if(self.orgin[1] == 576 and self.orgin[2] == 188) then
          self.itemType = "Key"
        end
        
        if(self.orgin[1] == 499 and self.orgin[2] == 167) then
          self.itemType = "Key"
        end
        
        if(self.orgin[1] == 533 and self.orgin[2] == 108) then
          self.itemType = "Key"
        end
        
        if(self.orgin[1] == 550 and self.orgin[2] == 34) then
          self.itemType = "Key Lv 1"
        end
        
        if(self.orgin[1] == 766 and self.orgin[2] == 68) then
          self.itemType = "Key Lv 2"
        end
        
        if(self.orgin[1] == 598 and self.orgin[2] == 185) then
          self.itemType = "Health Pack"
        end
        
      end
    
    end
  end

  
end

function Chest:Open()
  
  if(self.isOpen == true) then
    return
  end
  
  if(self.itemType == "Key") then
    table.insert(itemsObj, #itemsObj + 1, Items:New(self.x , self.y + 32, "Key"))
  end
  
  if(self.itemType == "Key Lv 1") then
    table.insert(itemsObj, #itemsObj + 1, Items:New(self.x, self.y + 32, "Key Lv 1"))
  end
  
  if(self.itemType == "Key Lv 2") then
    table.insert(itemsObj, #itemsObj + 1, Items:New(self.x, self.y + 32, "Key Lv 2"))
  end
  
  if(self.itemType == "Key Lv 3") then
    table.insert(itemsObj, #itemsObj + 1, Items:New(self.x , self.y + 32, "Key Lv 3"))
  end
  
  if(self.itemType == "Key Lv 4") then
    table.insert(itemsObj, #itemsObj + 1, Items:New(self.x , self.y + 32, "Key Lv 4"))
  end
  
  if(self.itemType == "Key Lv 5") then
    table.insert(itemsObj, #itemsObj + 1, Items:New(self.x , self.y + 32, "Key Lv 5"))
  end
  
  if(self.itemType == "translator") then
    table.insert(itemsObj, #itemsObj + 1, Items:New(self.x , self.y + 32, "Translator"))
  end
  
  if(self.itemType == "Health Pack") then
    table.insert(itemsObj, #itemsObj + 1, Items:New(self.x, self.y + 32, "Health Pack"))
  end
  
  self.isOpen = true
  
end

function Chest:GetDimensions()
  
  return {self.x, self.x + 32, self.y, self.y + 32}
end



function Chest:Update()
  table.insert(collidableObj, #collidableObj + 1, self)  
  self:DecideItem()
  return self.isDead
end

