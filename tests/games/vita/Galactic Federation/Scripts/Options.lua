Options = {}

controlAImg = Graphics.loadImage("app0:/Sprites/Screens/Controls1.png");
controlBImg = Graphics.loadImage("app0:/Sprites/Screens/Controls2.png");

function Options:New()
  options = {}
  setmetatable(options, self)
  self.__index = self
  
  return options
end

function Options:Draw()
  
  if(controlType == 'a') then
Graphics.drawImage(0,0,controlAImg) 
  end
  
  if(controlType == 'b') then
    Graphics.drawImage(0,0,controlBImg) 
  end
  
  
end

function Options:ButtonInputs()
  
  for i = 1, #controllerObj, 1 do
    
    if(controllerObj[i].startIsPressed == true and controllerObj[i].startCanBePressed == true) then
      
      MainMenuScreen()
      self.isDead = true
      return
    end
    
    
    
    if(controllerObj[i].padLeftIsPressed == true and controllerObj[i].padLeftCanBePressed == true) then
      
      if(controlType == 'a') then
        controlType = 'b'
        return
      end
      
      if(controlType == 'b') then
        controlType = 'a'
        return
      end
      
      
    end
    
    if(controllerObj[i].padRightIsPressed == true and controllerObj[i].padRightCanBePressed == true) then
      
      if(controlType == 'a') then
        controlType = 'b'
        return
      end
      
      if(controlType == 'b') then
        controlType = 'a'
        return
      end
      
    end
    
    
  end
  
  
end

function Options:Update()
  
  self:ButtonInputs()
  
  return self.isDead
end
