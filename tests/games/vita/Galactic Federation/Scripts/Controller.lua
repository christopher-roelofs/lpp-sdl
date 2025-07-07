Controller = {}

function Controller:New()
  controller = {}
  setmetatable(controller, self)
  self.__index = self
  
  controller.padLeftIsPressed = false
  controller.padRightIsPressed = false
  controller.padUpIsPressed = false
  controller.padDownIsPressed = false
  
  controller.leftIsPressed = false
  controller.rightIsPressed = false
  controller.upIsPressed = false
  controller.downIsPressed = false
  
  controller.rightLeftIsPressed = false
  controller.rightRightIsPressed = false
  controller.rightUpIsPressed = false
  controller.rightDownIsPressed = false
  
  controller.squareIsPressed = false
  controller.triangleIsPressed = false
  controller.circleIsPressed = false
  controller.crossIsPressed = false
  controller.startIsPressed = false
  controller.selectIsPressed = false
  controller.leftTriggerIsPressed = false
  controller.rightTriggerIsPressed = false
  
  
  controller.padLeftCanBePressed = false
  controller.padRightCanBePressed = false
  controller.padUpCanBePressed = false
  controller.padDownCanBePressed = false
  controller.squareCanBePressed = false
  controller.crossCanBePressed = false
  controller.circleCanBePressed = false
  controller.triangleCanBePressed = false
  controller.leftTriggerCanBePressed = false
  controller.rightTriggerCanBePressed = false
  controller.startCanBePressed = false
  controller.selectCanBePressed = false
  controller.rightStickPressed = false
  
  return controller
end

function Controller:GetButtonPresses()
  
  -- Check if buttons are pressed if they are then it sets the boolean to true, if buttons are released it sets the boolean to false
  lx, ly = Controls.readLeftAnalog();
  rx, ry = Controls.readRightAnalog();
  
  if(ly > 180) then
    
    self.downIsPressed = true
  else
    
    self.downIsPressed = false
    
  end
  
  if(ly < 64) then
    
    self.upIsPressed = true
  else
    
    self.upIsPressed = false
  end
  
  
  if(lx > 180) then
    
    self.rightIsPressed = true
  else
    
    self.rightIsPressed = false
  end
  
  
  if(lx < 64) then
    
    self.leftIsPressed = true
  else
    
    self.leftIsPressed = false
  end
  
  
  if(ry > 180) then
    
    self.rightDownIsPressed = true
  else
    
    self.rightDownIsPressed = false
  end
  
  
  if(ry < 64) then
    self.rightUpIsPressed = true
  else
    self.rightUpIsPressed = false
  end
  
  
  if(rx > 180) then
    self.rightRightIsPressed = true
  else
    self.rightRightIsPressed = false
  end
  
  
  if(rx < 64) then
    self.rightLeftIsPressed = true
  else
     self.rightLeftIsPressed = false
  end
  
  
  
     if(Controls.check(Controls.read(),SCE_CTRL_UP)) then
      self.padUpIsPressed = true
    else
      self.padUpIsPressed = false
    end
    
     if(Controls.check(Controls.read(),SCE_CTRL_DOWN)) then
      self.padDownIsPressed = true
    else
      self.padDownIsPressed = false
    end
    
     if(Controls.check(Controls.read(),SCE_CTRL_LEFT)) then
    self.padLeftIsPressed = true
    else
      self.padLeftIsPressed = false
    end
    
     if(Controls.check(Controls.read(),SCE_CTRL_RIGHT)) then
      self.padRightIsPressed = true
    else
      self.padRightIsPressed = false
    end
    
     if(Controls.check(Controls.read(),SCE_CTRL_CROSS)) then
      self.crossIsPressed = true
    else
      self.crossIsPressed = false
    end
    
     if(Controls.check(Controls.read(),SCE_CTRL_TRIANGLE)) then
      self.triangleIsPressed = true
    else
      self.triangleIsPressed = false
    end
    
     if(Controls.check(Controls.read(),SCE_CTRL_SQUARE)) then
      self.squareIsPressed = true
    else
      self.squareIsPressed = false
    end
  if(Controls.check(Controls.read(),SCE_CTRL_CIRCLE)) then
      self.circleIsPressed = true
    else
      self.circleIsPressed = false
    end  
    
    if(Controls.check(Controls.read(),SCE_CTRL_START)) then
      self.startIsPressed = true
    else
      self.startIsPressed = false
    end  
    
    if(Controls.check(Controls.read(),SCE_CTRL_SELECT)) then
      self.selectIsPressed = true
    else
      self.selectIsPressed = false
    end  
    
    if(Controls.check(Controls.read(),SCE_CTRL_RTRIGGER)) then
      self.rightTriggerIsPressed = true
    else
      self.rightTriggerIsPressed = false
    end
    
    if(Controls.check(Controls.read(),SCE_CTRL_LTRIGGER)) then
      self.leftTriggerIsPressed = true
    else
      self.leftTriggerIsPressed = false
    end
    
  
end

function Controller:GetCanPresses()
  
  -- The can be pressed ensures that an action is only done once per button press, instead of each frame the button is pressed.
  -- In some cases you will want an action to be executed each frame of a button press such as in movement.
  
  if(self.squareIsPressed == false) then
    self.squareCanBePressed = true
  else
    self.squareCanBePressed = false
  end
  
  if(self.crossIsPressed == false) then
    self.crossCanBePressed = true
  else
    self.crossCanBePressed = false
  end
  
  if(self.circleIsPressed == false) then
    self.circleCanBePressed = true
  else
    self.circleCanBePressed = false
  end
  
  if(self.triangleIsPressed == false) then
    self.triangleCanBePressed = true
  else
    self.triangleCanBePressed = false
  end
  
  
  if(self.startIsPressed == false) then
    self.startCanBePressed = true
  else
    self.startCanBePressed = false
  end
  
  if(self.selectIsPressed == false) then
    self.selectCanBePressed = true
  else
    self.selectCanBePressed = false
  end
  
  if(self.padLeftIsPressed == false) then
    self.padLeftCanBePressed = true
  else
    self.padLeftCanBePressed = false
  end
  
  if(self.padRightIsPressed == false) then
    self.padRightCanBePressed = true
  else
    self.padRightCanBePressed = false
  end
  
  if(self.padUpIsPressed == false) then
    self.padUpCanBePressed = true
  else
    self.padUpCanBePressed = false
  end
  
  if(self.padDownIsPressed == false) then
    self.padDownCanBePressed = true
  else
    self.padDownCanBePressed = false
  end
  
  if(self.rightLeftIsPressed == false and self.rightRightIsPressed == false and self.rightUpIsPressed == false and self.rightDownIsPressed == false) then
  self.rightStickPressed = false
else
  self.rightStickPressed = true
  end
  
  
  if(self.leftTriggerIsPressed == false) then
    self.leftTriggerCanBePressed = true
  else
    
    self.leftTriggerCanBePressed = false
  end
  
  
  if(self.rightTriggerIsPressed == false) then
    self.rightTriggerCanBePressed = true
  else
    self.rightTriggerCanBePressed = false
  end
  
  
end
