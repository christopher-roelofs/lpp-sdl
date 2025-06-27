Enemy1 = {};
enemyImg = Graphics.loadImage("app0:/Sprites/Monster.png");

function Enemy1:new(xPos, yPos, pat)
  enemy1Object = {}
  setmetatable(enemy1Object, self);
  self.__index = self;
  enemy1Object.xPosition = xPos;
  enemy1Object.yPosition = yPos;
  enemy1Object.patterns = pat;
  enemy1Object.imgWidth = 53
  enemy1Object.imgHeight = 65
  enemy1Object.health = 1;
  enemy1Object.animationFrame = 0;
  enemy1Object.characterState = "move"
  enemy1Object.canStillHurtPlayer = true;
  
  
  return enemy1Object;
  end
  function Enemy1:Move()
     
     if(self.characterState == "attack") then
     self.xPosition = self.xPosition - 8;
     return
     end
     
     
    if(self.patterns == 1) then
      
     if(self.xPosition > 600) then
        
      self.xPosition = self.xPosition - 3;
    
    else
      self.xPosition = self.xPosition - 5;
      end
      
    end
    
    if(self.patterns == 2) then
      self.xPosition = self.xPosition - 5;
    end
    
    if(self.patterns == 3) then
      self.xPosition = self.xPosition - 3;
      
      if(self.yPosition < 20) then
        
        self.yPosition = self.yPosition + 4;
      end
      
       if(self.yPosition > 335) then
        
        self.yPosition = self.yPosition - 4;
      end
      
      
      
    end
    
   
    
    if(self.patterns == 4) then
      
      if(self.xPosition > 500) then
        
        self.xPosition = self.xPosition -4;
      else
        
        self.xPosition = self.xPosition -7;
      end
      
      
      
    end
    
    if(self.patterns == 5) then
      
      if(self.xPosition >= 200) then
        
        self.xPosition = self.xPosition - 5;
      end
      if(self.xPosition < 200 and self.yPosition >= 100) then
        
        self.yPosition = self.yPosition - 4;
      end
      
      if(self.xPosition < 200 and self.yPosition < 100) then
        self.xPosition = self.xPosition - 5;
      end
      
      
      
      
    end
    
    if(self.patterns == 6) then
      
      
      if (self.xPosition > 350 and self.yPosition == 330) then
				
					self.xPosition = self.xPosition -5;     
        end
        
				if (self.xPosition == 350 and self.yPosition > 100) then    
					self.yPosition = self.yPosition -5;
					
				
        end

				if (self.xPosition <= 350 and self.xPosition >= 200 and self.yPosition == 100) then
				
					
					self.xPosition = self.xPosition -5;
			end

				if (self.xPosition == 200 and self.yPosition < 295)then
				
					
					self.yPosition = self.yPosition + 15;
				end

				if (self.xPosition <= 200 and self.yPosition == 295)then
				
					
					self.xPosition = self.xPosition -10;
				end
      
    end
    
    
    if(self.xPosition < -56) then
    self.health = 0;  
    playerObj.cityHealth = playerObj.cityHealth -1;
    end
    
   
    
  end
  
  function Enemy1:TakeDamage()
  self.health = self.health - 1  
  PlaySounds("pop");
  end
  
  
  function Enemy1:CheckPlayerCollision()
    self.checkColliding = false;
  if(self.canStillHurtPlayer == true) then
  self.checkColliding =  playerObj.CheckCollision(self.xPosition,self.xPosition + 98,self.yPosition,self.yPosition + 114)
  end
 
 if(self.checkColliding == true) then
    self.canStillHurtPlayer = false;
 end
  
end
  
  function Enemy1:CheckCollision(leftXPos,rightXPos,topYPos,bottomYPos)
    if(leftXPos <= self.xPosition + self.imgWidth and rightXPos >= self.xPosition) then
      if(topYPos <= self.yPosition + self.imgHeight and bottomYPos >= self.yPosition) then
      self:TakeDamage();
      return true
    end
    
  end
  return false
  end
  
  function Enemy1:CheckIfAlive()
    if(self.health <= 0) then
      waveManager.enemiesAlive = waveManager.enemiesAlive - 1
      self:DecideIfShouldMakeHealthPack()
    return true 
    
  end
  return false
    
    end
  
  function Enemy1:DecideIfShouldMakeHealthPack()
    
    self.randomNum = math.random(1,100);
    
    if(self.randomNum >= 51 and self.randomNum <= 55) then
    CreateHealthPack(self.xPosition,self.yPosition)  
    end
    
    
  end
  
  
  function Enemy1:Draw()
  --Screen.clear()
  if(self.characterState == "move") then
    if(self.animationFrame >=16) then
     self.animationFrame = 0; 
      end
    self.animationFrame = self.animationFrame + 1;
    
    if(self.animationFrame == 1) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,196,228,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 2) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,249,228,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 3) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,302,228,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 4) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,355,228,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 5) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,408,228,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 6) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,196,293,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 7) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,249,293,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 8) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,302,293,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 9) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,355,293,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 10) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,408,293,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 11) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,0,342,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 12) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,53,342,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 13) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,106,342,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 14) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,159,358,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 15) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,212,358,53,65,  enemyImg);
    end
    
    if(self.animationFrame == 16) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition,265,358,53,65,  enemyImg);
    end
    
    
  end
  
  if(self.characterState == "attack") then
  
  if(self.animationFrame >= 12) then
    self.health = 0;
  end
  self.animationFrame = self.animationFrame + 1;
  
   if(self.animationFrame == 1) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition -25,0,0,98,114,  enemyImg);
    end
    
    if(self.animationFrame == 2) then
      
self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition - 25,98,0,98,114,  enemyImg);
end
    
    if(self.animationFrame == 3) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition -25,196,0,98,114,  enemyImg);
    end
    
    if(self.animationFrame == 4) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition -25,294,0,98,114,  enemyImg);
    end
    
    if(self.animationFrame == 5) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition -25,392,0,98,114,  enemyImg);
    end
    
    if(self.animationFrame == 6) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition -25,0,114,98,114,  enemyImg);
      self:CheckPlayerCollision();
      PlaySounds("monsterBite");
      
    end
    
    if(self.animationFrame == 7) then
      
       self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition -25,98,114,98,114,  enemyImg);
       self:CheckPlayerCollision();
    end
    
    if(self.animationFrame == 8) then
      
       self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition -25,196,114,98,114,  enemyImg);
       self:CheckPlayerCollision();
    end
    
    if(self.animationFrame == 9) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition -25,294,114,98,114,  enemyImg);
      self:CheckPlayerCollision();
    end
    
    if(self.animationFrame == 10) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition -25,392,114,98,114,  enemyImg);
      self:CheckPlayerCollision();
    end
    
    if(self.animationFrame == 11) then
      
       self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition -25,0,228,98,114,  enemyImg);
       self:CheckPlayerCollision();
    end
    
    if(self.animationFrame == 12) then
      
      self.enemySprite = Graphics.drawPartialImage(self.xPosition, self.yPosition -25,98,228,98,114,  enemyImg);
      self:CheckPlayerCollision();
    end
  end
  
  --Screen.flip()
  end
  
  function Enemy1:SwitchAttackMode()
    
    self.animationFrame = 0
    self.characterState = "attack"
    
  end  
  
  function Enemy1:CheckIfShouldAttack()
    
    
    if(self.characterState == "move" and self.xPosition > player.playerX and self.xPosition < player.playerX + 140) then
      
      if(self.yPosition < player.playerY + 40  and self.yPosition > player.playerY - 40) then
        self:SwitchAttackMode();
        
        end
      
      
      end
    
    end
  
  function Enemy1:Update()
    if(self.health > 0) then
  self:Move()
  self:CheckIfShouldAttack();
  self:Draw()
  return true;
  end
  return false;
  end
  
  
 