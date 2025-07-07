TextBox = {}
textBoxImg = Graphics.loadImage("app0:/Sprites/TextBox.png")
portraitImg = Graphics.loadImage("app0:/Sprites/Portrait.png")

function TextBox:New(conversationTable)
  textBox = {}
  setmetatable(textBox, self)
  self.__index = self
  textBox.textToDisplay = ""
  textBox.listOfTextItems = conversationTable
  textBox.shouldClose = false
  textBox.wordsToGo = 0
  isPaused = true
  return textBox
end


function TextBox:Draw()
  
Graphics.drawImage(0, 360, textBoxImg)
Graphics.drawImage(6, 366, portraitImg)
Font.print(fontObj, 200, 366, self.textToDisplay, Color.new(0,0,0))
Font.print(fontObj, 10, 10, self.listOfTextItems[1], Color.new(255,0,0)) 
end


function TextBox:UpdateText()
  
  if(self.textToDisplay ~= "") then
  return  
  end
  
  
  self:StartConversation()
end

function TextBox:StartConversation()
  
  for i = 7, 1, -1 do
    for w = 80, 1, -1 do
      if(w > string.len(self.listOfTextItems[1])) then
        w = string.len(self.listOfTextItems[1])  
        end
        
        if(w == string.len(self.listOfTextItems[1])) then
        self.textToDisplay = self.textToDisplay .. string.sub(self.listOfTextItems[1],1,w) .. "\n"
        self.listOfTextItems[1] = string.sub(self.listOfTextItems[1], w + 1, #self.listOfTextItems[1])
        break
      elseif(w == 80) then
        if(string.sub(self.listOfTextItems[1], w+1, w+1) == " ") then
        self.textToDisplay = self.textToDisplay .. string.sub(self.listOfTextItems[1],1,w + 1) .. "\n"
        self.listOfTextItems[1] = string.sub(self.listOfTextItems[1], w + 2, #self.listOfTextItems[1])
        break
            
      elseif(string.sub(self.listOfTextItems[1], w, w) == " ") then
        self.textToDisplay = self.textToDisplay .. string.sub(self.listOfTextItems[1],1,w) .. "\n"
        self.listOfTextItems[1] = string.sub(self.listOfTextItems[1], w + 1, #self.listOfTextItems[1])
        break
        end
      else
        if(string.sub(self.listOfTextItems[1], w, w ) == " ") then
        self.textToDisplay = self.textToDisplay .. string.sub(self.listOfTextItems[1],1,w) .. "\n"
        self.listOfTextItems[1] = string.sub(self.listOfTextItems[1], w + 1, #self.listOfTextItems[1])
        break
        end
    end
  end
  end
  
  self.wordsToGo = string.len(self.listOfTextItems[1]) 
end


function TextBox:ContinueConversation()
  self.textToDisplay = ""
  if(#self.listOfTextItems > 0 and string.len(self.listOfTextItems[1]) <= 0 ) then
  
  table.remove(self.listOfTextItems,1)
  table.remove(self.listOfTextItems,1)
end

if(#self.listOfTextItems <= 0) then
self.shouldClose = true  

else

self:UpdateText()
end

  
end


function TextBox:CheckForButtonPresses()
  for i, value in ipairs(controllerObj) do
    
    if(controllerObj[i].crossIsPressed == true and controllerObj[i].crossCanBePressed == true or controllerObj[i].circleIsPressed == true and controllerObj[i].circleCanBePressed == true) then
      self:ContinueConversation()
    end
    
    
  end
  
end


function TextBox:Update()
  self:UpdateText()
self:CheckForButtonPresses()  
return self.shouldClose
end

--tempTextBox = TextBox:New({'There is said to be an artifact somewhere in this ancient temple. I want you to find the artifcat and return it to the ship for research purposes. I need you to return it undamaged, so be careful. This temple is said to be full of threats, the neutopians were said to be overly protective about their belongings, even in death.', 'Commander'})
--tempTextBox:Update()
