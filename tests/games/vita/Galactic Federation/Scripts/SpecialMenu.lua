SpecialMenu = {}
deselectedImage = Graphics.loadImage("app0:/Sprites/SpecialBox.png")
selectedImage = Graphics.loadImage("app0:/Sprites/SpecialBoxSelected.png")
specialBackgroundImage = Graphics.loadImage("app0:/Sprites/BottomBox.png")
imagesToSelect = Graphics.loadImage("app0:/Sprites/ListOfSpecialMoves.png")

function SpecialMenu:New()
specialMenu = {}
setmetatable(specialMenu,self)
self.__index = self
specialMenu.currentSelected = 0
specialMenu.listOfMoves = {"","","","","","","",}
specialMenu.healthPacks = 0
specialMenu.stimPacks = 0

return specialMenu
end

function SpecialMenu:DecideSpecial(classSelected)
  
  if(classSelected  == "human") then
    self.listOfMoves = {"rapid fire","grenade","","","","","",}
  end
  
  if(classSelected == "robot") then
    self.listOfMoves = {"group shield","group heal","","","","","",}
  end
  
  if(classSelected == "alien") then
    self.listOfMoves = {"dash","solo shield","","","","","",}
  end
  
  if(classSelected == "android") then
    self.listOfMoves = {"teleport","gun turrent","","","","","",}
  end
  
  
end

function SpecialMenu:Draw()
  
  Graphics.drawImage(0,464, specialBackgroundImage)
  
  for i = 0, 8, 1 do
  
    if(i ~= self.currentSelected) then
      Graphics.drawImage(180 + (88 * i), 478, deselectedImage) 
    else
      Graphics.drawImage(180 + (88 * i), 478, selectedImage) 
    end
    
  end
  
  
  for i = 0, 6, 1 do
    if(self.listOfMoves[i] == "") then
      
    elseif(self.listOfMoves[i] == "rapid fire") then
      Graphics.drawPartialImage(180 + ((88 * i) + 4) - 88, 482, 0, 0, 40, 40, imagesToSelect) 
        
    elseif(self.listOfMoves[i] == "grenade") then
      Graphics.drawPartialImage(180 + ((88 * i) + 4) - 88, 482, 40, 0, 40, 40, imagesToSelect)
      
      elseif(self.listOfMoves[i] == "dash") then
      Graphics.drawPartialImage(180 + ((88 * i) + 4) - 88, 482, 0, 40, 40, 40, imagesToSelect)
         
    elseif(self.listOfMoves[i] == "teleport") then
            Graphics.drawPartialImage(180 + ((88 * i) + 4) - 88, 482, 40, 40, 40, 40, imagesToSelect)

          
    elseif(self.listOfMoves[i] == "gun turrent") then
            Graphics.drawPartialImage(180 + ((88 * i) + 4) - 88, 482, 80, 40, 40, 40, imagesToSelect)

             
    elseif(self.listOfMoves[i] == "solo shield") then
      Graphics.drawPartialImage(180 + ((88 * i) + 4) - 88, 482, 80, 0, 40, 40, imagesToSelect)
              
    elseif(self.listOfMoves[i] == "group shield") then
               Graphics.drawPartialImage(180 + ((88 * i) + 4) - 88, 482, 120, 0, 40, 40, imagesToSelect)
    elseif(self.listOfMoves[i] == "dash") then
                
    elseif(self.listOfMoves[i] == "group heal") then
      Graphics.drawPartialImage(180 + ((88 * i) + 4) - 88, 482, 160, 0, 40, 40, imagesToSelect)
      else
      
    end  
    end
          Graphics.drawPartialImage(180 + ((88 * 7) + 4), 482, 160, 40, 40, 40, imagesToSelect)
          Graphics.drawPartialImage(180 + ((88 * 8) + 4), 482, 120, 40, 40, 40, imagesToSelect)
          Font.print(screenFont, 830, 505, tostring(self.healthPacks), Color.new(0,0,0))
          Font.print(screenFont, 916, 505, tostring(self.stimPacks), Color.new(0,0,0))

  -- Need to draw red squares for move recharge
  
  
end

function SpecialMenu:Move()
  for i, value in ipairs(controllerObj) do
   
   if(controllerObj[i].padLeftIsPressed == true and controllerObj[i].padLeftCanBePressed == true) then
     self.currentSelected = self.currentSelected - 1
   end
   
   if(controllerObj[i].padRightIsPressed == true and controllerObj[i].padRightCanBePressed == true) then
     self.currentSelected = self.currentSelected + 1
   end
   
   if(self.currentSelected < 0) then
     self.currentSelected = 8
   end
   
   if(self.currentSelected > 6) then
   self.currentSelected = 0  
   end
   
   
    end
end

function SpecialMenu:UseSpecialMove()
  
  for i, value in ipairs(controllerObj) do
  
    if(controllerObj[i].squareIsPressed == true and controllerObj[i].squareCanBePressed == true) then
      if(self.listOfMoves[self.currentSelected + 1] ~= "") then
        for p, value in ipairs(playerObj) do
        playerObj[p]:UseSpecialMove(self.listOfMoves[self.currentSelected + 1])  
        end
        
      end
      
    end
  end
  
  
end

function SpecialMenu:UpdateItemsHeld(health, stim)
  self.healthPacks = health
  self.stimPacks = stim
end


function SpecialMenu:Update()
  self:Move()
  self:UseSpecialMove()
  
end
