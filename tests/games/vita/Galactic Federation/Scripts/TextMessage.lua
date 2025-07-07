TextMessage = {}

function TextMessage:New(x,y,text)
  textMessage  = {}
  setmetatable(textMessage,self)
  self.__index = self
  
  textMessage.x = x
  textMessage.y = y
  textMessage.text = text
  textMessage.lifeTime = 0
  textMessage.isDead = false
  return textMessage
end

function TextMessage:Draw()
  Font.print(fontObj, self.x, self.y, self.text, Color.new(255,255,255)) 
end

function TextMessage:Update()
  self.lifeTime = self.lifeTime + 1
  
  if(self.lifeTime > 90) then
      self.isDead = true
  end
  
  return self.isDead
end
