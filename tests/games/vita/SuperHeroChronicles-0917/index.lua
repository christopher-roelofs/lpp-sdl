Sound.init();

snd = Sound.openMp3("app0:/Music/Music.mp3");


System.setCpuSpeed(444);
bossLaserSnd = Sound.openWav("app0:/Music/SoundEffects/BossLaser.wav");
comeOnSnd = Sound.openWav("app0:/Music/SoundEffects/ComeOn.wav");
enemyLaserSnd = Sound.openWav("app0:/Music/SoundEffects/EnemyLaser.wav");
finalExplosion1Snd = Sound.openWav("app0:/Music/SoundEffects/FinalExplosion1.wav");
finalExplosion2Snd = Sound.openWav("app0:/Music/SoundEffects/FinalExplosion2.wav");
finalExplosion3Snd = Sound.openWav("app0:/Music/SoundEffects/FinalExplosion3.wav");
metalHitSnd = Sound.openWav("app0:/Music/SoundEffects/MetalHit.wav");
monsterBiteSnd = Sound.openWav("app0:/Music/SoundEffects/MonsterBite.wav");
playerLaserSnd = Sound.openWav("app0:/Music/SoundEffects/PlayerLaser.wav");
popSnd = Sound.openWav("app0:/Music/SoundEffects/Pop.wav");
robotBlowUpSnd = Sound.openWav("app0:/Music/SoundEffects/RobotBlowUp.wav");
robotCanonSnd = Sound.openWav("app0:/Music/SoundEffects/RobotCanon.wav");
rockDestroySnd = Sound.openWav("app0:/Music/SoundEffects/RockDestroy.wav");

require("app0:/scripts/player");
require("app0:/scripts/waveManager");
require("app0:/scripts/Enemy1");
require("app0:/scripts/robot");
require("app0:/scripts/EnemyBullets");
require("app0:/scripts/FrontBuilding");
require("app0:/scripts/FurthestBackground");
require("app0:/scripts/MidBuilding");
require("app0:/scripts/MainMenu");
require("app0:/scripts/Boss");
require("app0:/scripts/Ship");
require("app0:/scripts/Sky");
require("app0:/scripts/ComicBook");
require("app0:/scripts/GameOverScreen");
require("app0:/scripts/Scooter");
require("app0:/scripts/EnemyLaser");
require("app0:/scripts/Controller");
require("app0:/scripts/IntroVideo");
require("app0:/scripts/PauseScreen");
require("app0:/scripts/HealthPack");

mainMenuObject = nil;

myFont = Font.load("app0:/Sprites/SuperWebcomicBros.ttf");
Font.setPixelSizes(myFont,24);
playerObj = nil
comicObj = nil
furthestObj = nil
frontObj = nil
frontObj1 = nil
midObj1 = nil
midObj2 = nil
midObj3 = nil
midObj4 = nil
midObj5 = nil
midObj6 = nil
 gameOverObj = nil
waveManagerObj = nil
pauseScreenObj = nil;
startGame = false;
introVideoObject = nil;
isPaused = false;
listOfHealthPacks = {}

 timerObj = Timer.new()
 
 function GameOverFunc()
 for i = #waveManagerObj.ListOfRobots, 1, -1 do
  table.remove(waveManagerObj.ListOfRobots,i);
 end
 
 for i = #waveManagerObj.ListOfEnemy1, 1, -1 do
  table.remove(waveManagerObj.ListOfEnemy1,i);
 end
 
 for i = #waveManagerObj.ListOfBosses, 1, -1 do
  table.remove(waveManagerObj.ListOfBosses,i);
 end
 
 for i = #waveManagerObj.ListOfShips, 1, -1 do
  table.remove(waveManagerObj.ListOfShips,i);
 end
 
 for i = #waveManagerObj.ListOfScooters, 1, -1 do
  table.remove(waveManagerObj.ListOfScooters,i);
 end
 
 for i = #listOfEnemyBullets, 1, -1 do
 table.remove(listOfEnemyBullets,i);  
end

for i = #listOfShipBullets, 1, -1 do
table.remove(listOfShipBullets,i);  
end

 for i = #listOfHealthPacks, 1, -1 do 

  table.remove(listOfHealthPacks,i);
  
  end
 
 
 gameOverObj = GameOverScreen:new();
 playerObj = nil
comicObj = nil
furthestObj = nil
frontObj = nil
frontObj1 = nil
midObj1 = nil
midObj2 = nil
midObj3 = nil
midObj4 = nil
midObj5 = nil
midObj6 = nil
waveManagerObj = nil
 
end


function CreateHealthPack(xPos,yPos) 
  
  if(#listOfHealthPacks > 2) then
    
  return  
  end
  
  
  table.insert(listOfHealthPacks, #listOfHealthPacks + 1, HealthPack:new(xPos, yPos));
  
end


 

function CreateLevel()
  
  comicObj = nil;
  playerObj = player.new();
furthestObj = furthestBackground.new(0, 150);
frontObj = FrontBuilding:new(150,430, 1)
frontObj1 = FrontBuilding:new(650,430, 2)
midObj1 = MidBuilding:new(0,140,1);
midObj2 = MidBuilding:new(188,180,2);
midObj3 = MidBuilding:new(384,210,3);
midObj4 = MidBuilding:new(727,200,4);
midObj5 = MidBuilding:new(889,200,5);
midObj6 = MidBuilding:new(1077,116,6);
waveManagerObj = waveManager.new()
  
end

function CreateFirstComicPage()
  
  comicObj = ComicBook:new(1);
  
end

function CreateSecondComicPage ()
  
  comicObj = ComicBook:new(2);
end


function GameComplete()
  
   for i = #waveManagerObj.ListOfRobots, 1, -1 do
  table.remove(waveManagerObj.ListOfRobots,i);
 end
 
 for i = #waveManagerObj.ListOfEnemy1, 1, -1 do
  table.remove(waveManagerObj.ListOfEnemy1,i);
 end
 
 for i = #waveManagerObj.ListOfBosses, 1, -1 do
  table.remove(waveManagerObj.ListOfBosses,i);
 end
 
 for i = #waveManagerObj.ListOfShips, 1, -1 do
  table.remove(waveManagerObj.ListOfShips,i);
 end
 
 for i = #waveManagerObj.ListOfScooters, 1, -1 do
  table.remove(waveManagerObj.ListOfScooters,i);
 end
 
 for i = #listOfEnemyBullets, 1, -1 do
 table.remove(listOfEnemyBullets,i);  
end

for i = #listOfShipBullets, 1, -1 do
table.remove(listOfShipBullets,i);  
end
  
  
  
  playerObj = nil
comicObj = nil
furthestObj = nil
frontObj = nil
frontObj1 = nil
midObj1 = nil
midObj2 = nil
midObj3 = nil
midObj4 = nil
midObj5 = nil
midObj6 = nil
waveManagerObj = nil
 CreateSecondComicPage() 
end


function GameOverMainMenuFunc()
  gameOverObj = nil;
  mainMenuObject = MainMenu:new();
  
end


function MainMenuFunc()
  mainMenuObject = MainMenu:new();
  
end

function CreateIntroVideo ()
  
  introVideoObject = IntroVideo:new();
  
end

function RemoveIntroVideo()
  
MainMenuFunc()  
introVideoObject = nil;
Sound.play(snd, LOOP);
end



CreateIntroVideo()

function EndGame()
  comicObj = nil;
  MainMenuFunc()
end


  function UpdateMainLoop()
  
  if(isPaused == true) then
    Graphics.initBlend()
  Screen.clear()
    Screen.flip()
    pauseScreenObj:Update();
    Controller.CheckButtonPresses()
Graphics.termBlend()
    return
  end
  
  
  
  if(mainMenuObject == nil and startGame == true) then
  CreateFirstComicPage()
  startGame = false;
  end
  
  
	Graphics.initBlend()
  Screen.clear()
  if(introVideoObject == nil) then
   Graphics.fillRect(0, 960, 0, 544, Color.new(51,0,51)) 
 end
 
  Screen.flip()
  
  
if(introVideoObject ~= nil) then
  introVideoObject:Update();
  
end

  if(gameOverObj ~= nil) then
  
  gameOverObj:Update();
  end
  
  
  
  if(comicObj ~= nil) then
  
  comicObj:Update();
  
end


  
  
 if(mainMenuObject ~= nil) then
   tempObj = mainMenuObject:Update();  
   
   if(tempObj == true) then
     mainMenuObject:RemoveMainMenu();
     mainMenuObject = nil;
     startGame = true;
     
   end
   
 end
 
 
 if(furthestObj ~= nil) then
  furthestObj.Update();
end

if(midObj1 ~= nil) then
  midObj1:Update();
  midObj2:Update();
  midObj3:Update();
  midObj4:Update();
  midObj5:Update();
  midObj6:Update();
end

if(frontObj ~= nil) then
  frontObj:Update();
  frontObj1:Update();
  end
  
  
  if(playerObj ~= nil) then
  playerObj.Update()
  end
  if(waveManagerObj ~= nil) then
    
    for i, value in ipairs(waveManagerObj.ListOfBosses) do
    waveManagerObj.ListOfBosses[i]:Update();  
    if(waveManagerObj ~= nil) then
      waveManagerObj.ListOfBosses[i]:Update(); 
      end
    end
    
    if(waveManagerObj == nil) then
      
      Controller.CheckButtonPresses()
Graphics.termBlend()
      return
    end
    
  for i, value in ipairs(waveManagerObj.ListOfEnemy1) do
  
  enemyIsDead = waveManagerObj.ListOfEnemy1[i]:CheckIfAlive();
  if (enemyIsDead == true) then
    
    table.remove(waveManagerObj.ListOfEnemy1,i);
    end
  
  end
  
  for i, value in ipairs(waveManagerObj.ListOfEnemy1) do
  
  enemyIsDead = waveManagerObj.ListOfEnemy1[i]:Update();
  
  end
  
  for i, value in ipairs(waveManagerObj.ListOfRobots) do
   enemyIsDead = waveManagerObj.ListOfRobots[i]:CheckIfAlive();
    
    if (enemyIsDead == true) then
    
    table.remove(waveManagerObj.ListOfRobots,i);
    end
  end
  
  for i, value in ipairs(waveManagerObj.ListOfRobots) do
     waveManagerObj.ListOfRobots[i]:Update();
  end
  
 
 for i = #waveManagerObj.ListOfShips, 1, -1 do
  isDead = waveManagerObj.ListOfShips[i]:CheckDeath();
  
  if(isDead == true) then
  
  table.remove(waveManagerObj.ListOfShips,i);
    
  end
  
  
 end
 
 for i, value in ipairs(waveManagerObj.ListOfShips) do
     waveManagerObj.ListOfShips[i]:Update();
  end
 
 for i = #waveManagerObj.ListOfScooters, 1, -1 do
 isDead = waveManagerObj.ListOfScooters[i]:CheckDeath();
 
 if(isDead == true) then
   
   table.remove(waveManagerObj.ListOfScooters, i)
   end
 
 end
  for i, value in ipairs(waveManagerObj.ListOfScooters) do
     waveManagerObj.ListOfScooters[i]:Update();
  end
  
  
  for i = #listOfShipBullets, 1, -1 do
  
  isDead = listOfShipBullets[i]:CheckDeath()
  
  if(isDead == true) then
  
  table.remove(listOfShipBullets,i);
  
  end
  
    
  end
  
  
  for i, value in ipairs(listOfShipBullets) do
    
    listOfShipBullets[i]:Update();
  end
  
  
end






for i = #listOfEnemyBullets, 1, -1  do
    
    isBulletDead = listOfEnemyBullets[i]:CheckDeath();
    
    if(isBulletDead == true) then
      table.remove(listOfEnemyBullets,i)
      end
  end

  for i, value in ipairs(listOfEnemyBullets) do
    
    listOfEnemyBullets[i]:Update();
  end
  
  if(waveManagerObj ~= nil) then
    waveManagerObj.Update()
  end
  
  if(playerObj ~= nil and bullets.Update ~= nil and playerObj.listOfBullets ~= nil) then
  for i, value in ipairs(playerObj.listOfBullets) do
    
   
    isBulletDead = playerObj.listOfBullets[i]:Update();
    if(isBulletDead == true) then
      table.remove(playerObj.listOfBullets,i)
      end
    end
  
  
end

for i = #listOfHealthPacks, 1, -1 do 

isDead = listOfHealthPacks[i]:CheckLife();

if(isDead == true) then
  table.remove(listOfHealthPacks,i);
  
  end

end


  for i, value in ipairs(listOfHealthPacks) do
    listOfHealthPacks[i]:Update();
  end


if(playerObj ~= nil) then
Font.print(myFont, 5, 35, "City Health " .. tostring(playerObj.cityHealth) .. "/50", Color.new(255,255,255))  
end

Controller.CheckButtonPresses()
Graphics.termBlend()

  

end

function PlaySounds(soundName)
  
  if(soundName == "bossLaser") then
    
     if Sound.isPlaying(bossLaserSnd) == false then
    Sound.play(bossLaserSnd,NO_LOOP);
  end
  
  end
  
  if(soundName == "comeOn") then
    if Sound.isPlaying(comeOnSnd) == false then
     Sound.play(comeOnSnd,NO_LOOP);
     end
    
  end
  
  if(soundName == "enemyLaser") then
    if Sound.isPlaying(enemyLaserSnd) == false then
     Sound.play(enemyLaserSnd,NO_LOOP);
     end
  end
  
  if(soundName == "finalExplosion1") then
    if Sound.isPlaying(finalExplosion1Snd) == false then
     Sound.play(finalExplosion1Snd,NO_LOOP);
     end
  end
  
   if(soundName == "finalExplosion2") then
     if Sound.isPlaying(finalExplosion2Snd) == false then
     Sound.play(finalExplosion2Snd,NO_LOOP);
     end
  end
   if(soundName == "finalExplosion3") then
     if Sound.isPlaying(finalExplosion3Snd) == false then
     Sound.play(finalExplosion3Snd,NO_LOOP);
     end
  end
  
   if(soundName == "metalHit") then
     if Sound.isPlaying(metalHitSnd) == false then
     Sound.play(metalHitSnd,NO_LOOP);
     end
  end
  
  if(soundName == "monsterBite") then
    if Sound.isPlaying(monsterBiteSnd) == false then
     Sound.play(monsterBiteSnd,NO_LOOP);
     end
  end
  
  if(soundName == "playerLaser") then
    if Sound.isPlaying(playerLaserSnd) == false then
     Sound.play(playerLaserSnd,NO_LOOP);
     end
  end
  if(soundName == "pop") then
    if Sound.isPlaying(popSnd) == false then
     Sound.play(popSnd,NO_LOOP);
     end
  end
  
  if(soundName == "robotBlowUp") then
    if Sound.isPlaying(robotBlowUpSnd) == false then
     Sound.play(robotBlowUpSnd,NO_LOOP);
     end
  end
  
  if(soundName == "robotCanon") then
    if Sound.isPlaying(robotCanonSnd) == false then
     Sound.play(robotCanonSnd,NO_LOOP);
     end
  end
  
  if(soundName == "rockDestroy") then
    if Sound.isPlaying(rockDestroySnd) == false then
     Sound.play(rockDestroySnd,NO_LOOP);
     end
  end
  
end

function CheckPause()
  
  if(waveManagerObj ~= nil and startIsPressed == true and  startCanBePressed == true) then
  
  if(isPaused == true) then
    
    isPaused = false
    pauseScreenObj = nil
    return
    
  end
  
    if(isPaused == false) then
    isPaused = true
    pauseScreenObj = PauseScreen:new()
    return
  
    end

  end
  
  
end



while true do
  
  Controller.Update();
  CheckPause();
  
  --if(Timer.getTime(timerObj) >= 16) then
   Screen.waitVblankStart() 
 UpdateMainLoop();  
 
 --Timer.reset(timerObj);
 
 --end
  
end


