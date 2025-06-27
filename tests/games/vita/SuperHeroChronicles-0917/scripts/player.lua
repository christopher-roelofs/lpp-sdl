player = {};
red = Color.new(255,0,0) 
require("app0:/scripts/bullets");
healthbarImages = Graphics.loadImage("app0:/Sprites/Healthbars.png");

player.new = function()
  
 
player.listOfBullets = {}; 


player.playerImg = Graphics.loadImage("app0:/Sprites/Hero.png");
player.playerX = 0;
player.playerY = 300;
player.imgWidth = 99
player.imgHeight = 46
player.frameCount = 0;  
player.health = 10;
player.cityHealth = 50
player.comboMeter = 0;
player.comboCount = 1;
player.subtractTime = 0;
  
  
  --playerSprite = Graphics.drawImage( player.playerX, player.playerY, player.playerImg)
  
  local function Draw()
  
  playerHealthBarImage =  Graphics.drawImageExtended (5, 10,600,18, 202, 14, player.health/10, 1, healthbarImages);
  playerHealthBarOutline = Graphics.drawPartialImage( 5, 10, 806,0, 202, 14, healthbarImages);
  playerComboBarImage = Graphics.drawImageExtended(745,10,806,14,200,13,player.comboMeter/100,1,healthbarImages);
   playerComboBarOutline = Graphics.drawPartialImage( 745, 10, 604,0, 202, 15, healthbarImages);
   
  
  if(player.frameCount >= 20) then
    player.frameCount = 0;
    end
  
  player.frameCount = player.frameCount + 1;
	
  if(player.frameCount == 1) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 0, 0, 99, 46, player.playerImg)
end

if(player.frameCount == 2) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 99, 0, 99, 46, player.playerImg)
end

if(player.frameCount == 3) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 198, 0, 99, 46, player.playerImg)
end

if(player.frameCount == 4) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 297, 0, 99, 46, player.playerImg)
end

if(player.frameCount == 5) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 396, 0, 99, 46, player.playerImg)
end

if(player.frameCount == 6) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 0, 46, 99, 46, player.playerImg)
end

if(player.frameCount == 7) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 99, 46, 99, 46, player.playerImg)
end

if(player.frameCount == 8) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 198, 46, 99, 46, player.playerImg)
end

if(player.frameCount == 9) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 297, 46, 99, 46, player.playerImg)
end

if(player.frameCount == 10) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 396, 46, 99, 46, player.playerImg)
end

if(player.frameCount == 11) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 0, 92, 99, 46, player.playerImg)
end

if(player.frameCount == 12) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 99, 92, 99, 46, player.playerImg)
end

if(player.frameCount == 13) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 198, 92, 99, 46, player.playerImg)
end

if(player.frameCount == 14) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 297, 92, 99, 46, player.playerImg)
end

if(player.frameCount == 15) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 396, 92, 99, 46, player.playerImg)
end

if(player.frameCount == 16) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 0, 138, 99, 46, player.playerImg)
end

if(player.frameCount == 17) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 99, 138, 99, 46, player.playerImg)
end

if(player.frameCount == 18) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 198, 138, 99, 46, player.playerImg)
end

if(player.frameCount == 19) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 297, 138, 99, 46, player.playerImg)
end

if(player.frameCount == 20) then
  
  playerSprite = Graphics.drawPartialImage( player.playerX, player.playerY, 396, 138, 99, 46, player.playerImg)
end



  --Graphics.termBlend()
 --Screen.flip();
  
  
  end


local function CreateBullets()
  
  if(xIsPressed == true and xCanBePressed == true) then
    if(player.comboCount == 1) then
        table.insert(player.listOfBullets, #player.listOfBullets + 1,bullets:new(player.playerX + 85, player.playerY + 10, 15, 0,0))
    end
    
    if(player.comboCount == 2) then 
      table.insert(player.listOfBullets, #player.listOfBullets + 1,bullets:new(player.playerX + 85, player.playerY + 10, 15, 3, -1.5))
      table.insert(player.listOfBullets, #player.listOfBullets + 1,bullets:new(player.playerX + 85, player.playerY + 10, 15, 0,0))
      table.insert(player.listOfBullets, #player.listOfBullets + 1,bullets:new(player.playerX + 85, player.playerY + 10, 15,-3, 1.5))
    end
    
    if(player.comboCount == 3) then
      table.insert(player.listOfBullets, #player.listOfBullets + 1,bullets:new(player.playerX + 85, player.playerY + 10, 15, 7, -15))
      table.insert(player.listOfBullets, #player.listOfBullets + 1,bullets:new(player.playerX + 85, player.playerY + 10, 15, 3, -1.5))
      table.insert(player.listOfBullets, #player.listOfBullets + 1,bullets:new(player.playerX + 85, player.playerY + 10, 15, 0, 0))
      table.insert(player.listOfBullets, #player.listOfBullets + 1,bullets:new(player.playerX + 85, player.playerY + 10, 15, -3, 1.5))
      table.insert(player.listOfBullets, #player.listOfBullets + 1,bullets:new(player.playerX + 85, player.playerY + 10, 15, -7, 15))
      
    end
    
    
  end
  
end

local function Movement()
  
  if(leftIsPressed == true) then
    player.playerX = player.playerX - 5;
  end
  
  if(rightIsPressed == true) then
    player.playerX = player.playerX + 5;
    
  end
  
  if(upIsPressed == true) then
    player.playerY = player.playerY - 10;
    
  end
  
  if(downIsPressed == true) then
    player.playerY = player.playerY + 10; 
  end
  
  if(player.playerY < 0) then
  
  player.playerY = 0;
end


if(player.playerY > 544 - 46) then

player.playerY = 544 - 46;
end

if(player.playerX < 0) then
  player.playerX = 0;
  
end

if(player.playerX > 860) then
player.playerX = 860  
end

for i, value in ipairs(waveManagerObj.ListOfBosses) do
    if(waveManagerObj.ListOfBosses[i].characterState == "moveForward") then
      
      if(player.playerX > 500) then
        
      player.playerX = player.playerX - 10;  
      end
    else
    
    if(player.playerX > 500) then
      
    player.playerX = 500  
    end
    
      
    end
    
     
    end
  
end



function CheckForGameOver()
  
  if(player.health <= 0 or player.cityHealth <= 0) then
  
  GameOverFunc();
  end
  
  
end


function player.TakeDamage()
  
player.health = player.health -1;  
  
end

function player.AddToComboMeter()
  
  player.comboMeter = player.comboMeter + 2;
  if(player.comboMeter > 100) then
    player.comboMeter = 100;
  end
  
  
end

function GetComboLevel()
  
  if(player.comboMeter < 40) then
    
  player.comboCount = 1;  
  end
  
  
  if(player.comboMeter >= 40) then
    
     player.comboCount = 2; 
  end
  
  if(player.comboMeter >= 75) then
    
     player.comboCount = 3; 
  end
  
end



function player.CheckCollision(leftXPos,rightXPos,topYPos,bottomYPos)
  
  if(leftXPos <= player.playerX + player.imgWidth and rightXPos >= player.playerX) then
      if(topYPos <= player.playerY + player.imgHeight and bottomYPos >= player.playerY) then
      player.TakeDamage();
      return true
    end
    
  end
  return false
  
end


function CheckHealthCollision()
  for i = #listOfHealthPacks, 1, -1 do 
    
    if(player.playerX < listOfHealthPacks[i].x + 32 and player.playerX + 99 > listOfHealthPacks[i].x) then
    
    if(player.playerY < listOfHealthPacks[i].y + 32 and player.playerY + 46 > listOfHealthPacks[i].y) then
      
    listOfHealthPacks[i].isDead = true;
    player.health = player.health + 1;
    
    if(player.health > 10) then
      
    player.health = 10;  
    end
    
    end
    
    
      
    end
    
    
  end
  
  
end


function player.Update()
  
  player.subtractTime = player.subtractTime + 1
  
  if(player.subtractTime >= 10) then
    
   player.subtractTime = 0;
    player.comboMeter = player.comboMeter -1;
    
    if(player.comboMeter < 0) then
      
      player.comboMeter = 0
      end
    
  end
  
  
  Movement();
  CheckHealthCollision()
  GetComboLevel()
  CreateBullets();
  CheckForGameOver();
  Draw()
  
  
end
return player;
end
  
