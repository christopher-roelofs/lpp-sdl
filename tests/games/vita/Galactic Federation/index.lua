Sound.init()
System.setCpuSpeed(444)
-- List of obj arrays
bulletsObj = {}
cameraObj = {}
characterSelectScreenObj = {}
controllerObj = {}
doorObj = {}
enemyObj = {}
healthBarObj = {}
itemsObj = {}
mainMenuObj = {}
mapObj = {}
miniMapObj = {}
mapLoaderObj = {}
onScreenTextPopUpObj = {}
optionsObj = {}
pauseObj = {}
playerObj = {}
textBoxObj = {}
textMessageObj = {}
tileObj = {}
splashScreenObj = {}
gameOverScreenObj = {}
specialMenuObj = {}
collidableObj = {}
collidableParentObj = {}
chestObj = {}



classIsSelected = ""
controlType = "b"

fps = 0
isPaused = false
fontObj = Font.load("app0:/Fonts/6809chargen.ttf")
textBoxFont = Font.load("app0:/Fonts/Reactor7.ttf")
pauseFont = Font.load("app0:/Fonts/Digital_tech.ttf")

require("app0:/Scripts/Alien")
require("app0:/Scripts/AlienPunchEffect")
require("app0:/Scripts/Android")
require("app0:/Scripts/AttackBox")
require("app0:/Scripts/Bullets")
require("app0:/Scripts/Camera")
require("app0:/Scripts/Chest")
require("app0:/Scripts/ClassSelectionScreen")
require("app0:/Scripts/Collidable")
require("app0:/Scripts/Controller")
require("app0:/Scripts/DialogueBox")
require("app0:/Scripts/Door")
require("app0:/Scripts/EgyptBoss1")
require("app0:/Scripts/EnemyGenerator")
require("app0:/Scripts/GameOverScreen")
require("app0:/Scripts/HealBeam")
require("app0:/Scripts/HealthBar")
require("app0:/Scripts/IntroVideo")
require("app0:/Scripts/Items")
require("app0:/Scripts/LaserWhip")
require("app0:/Scripts/ListOfEnemies")
require("app0:/Scripts/MainMenu")
require("app0:/Scripts/Map")
require("app0:/Scripts/MapLoader")
require("app0:/Scripts/MiniMap")
require("app0:/Scripts/OnScreenTextPopUps")
require("app0:/Scripts/Options")
require("app0:/Scripts/Pause")
require("app0:/Scripts/Player")
require("app0:/Scripts/RectangleCollision")
require("app0:/Scripts/RepairBeam")
require("app0:/Scripts/Robot")
require("app0:/Scripts/SpecialMenu")
require("app0:/Scripts/Test")
require("app0:/Scripts/TextBox")
require("app0:/Scripts/TextMessage")
require("app0:/Scripts/Tiles")
require("app0:/Scripts/Turrent")
require("app0:/Scripts/UseMenu")

require("app0:/Scripts/Enemies/Bug")
require("app0:/Scripts/Enemies/Bat")
require("app0:/Scripts/Enemies/Slime")

marineLaserSnd = Sound.openWav("app0:/Sound/Laser_Shoot6.wav")
marineLaserHitSnd = Sound.openWav("app0:/Sound/Hit_Hurt5.wav")
marineLaserWallHitSnd = Sound.openWav("app0:/Sound/Hit_Hurt2.wav")
 music = Sound.openMp3("app0:/Music/Space.mp3")

timerObj = Timer.new()


function SelectCharacter(startPos)
  if(classIsSelected == "human") then
  table.insert(playerObj, #playerObj + 1, Player:New(startPos[1],startPos[2]))
end

if(classIsSelected == "alien") then
  table.insert(playerObj, #playerObj + 1, Alien:New(startPos[1],startPos[2]))
end


if(classIsSelected == "android") then
  table.insert(playerObj, #playerObj + 1, Android:New(startPos[1],startPos[2]))
end


if(classIsSelected == "robot") then
  table.insert(playerObj, #playerObj + 1, Robot:New(startPos[1],startPos[2]))
end


end

function LoadNewRoom()
  
  for i, value in ipairs(mapLoaderObj) do
    
    mapLoaderObj[i]:LoadMap("egypt1")
    
  end
  
end


function NewGame()
LoadNewRoom()
for i, value in ipairs(mapLoaderObj) do
  SelectCharacter(mapLoaderObj[i].startPosition)

table.insert(specialMenuObj, #specialMenuObj + 1, SpecialMenu:New())
table.insert(healthBarObj, #healthBarObj + 1, HealthBar:New())
table.insert(cameraObj, #cameraObj + 1, Camera:New(mapLoaderObj[i].cameraPosition[1],mapLoaderObj[i].cameraPosition[2]))
table.insert(mapObj, #mapObj + 1, Map:New(mapLoaderObj[i].tiles, mapLoaderObj[i].interactive))
table.insert(collidableParentObj, #collidableParentObj + 1, Collidable:New())
end
for i = 0, 1216, 1 do
  
  table.insert(tileObj, #tileObj + 1, Tiles:New(0,0,0, false))
  
end


for i, value in ipairs(mapObj) do
  mapObj[i]:DrawMap()
  
end
table.insert(textBoxObj, #textBoxObj + 1, TextBox:New({'There is said to be an artifact somewhere in this ancient temple. I want you to find the artifcat and return it to the ship for research purposes. I need you to return it undamaged, so be careful. This temple is said to be full of threats, the neutopians were said to be overly protective about their belongings, even in death.', 'Commander'}))

for i, value in ipairs(specialMenuObj) do
specialMenuObj[i]:DecideSpecial(classIsSelected)  
end

  
end


function CloseClassSelectScreen() 
  table.remove(characterSelectScreenObj, #characterSelectScreenObj)
end

function CloseEverything()

  for i = #bulletsObj, 1, -1 do
  table.remove(bulletsObj, i)  
  end


  for i = #cameraObj, 1, -1 do
    table.remove(cameraObj, i)  
  end

  for i = #chestObj, 1, -1 do
    table.remove(chestObj, i)
  end

  for i = #doorObj, 1, -1 do
  table.remove(doorObj, i)  
  end
  

  for i = #enemyObj, 1, -1 do
    table.remove(enemyObj, i)  
  end

  for i = #healthBarObj, 1, -1 do
    table.remove(healthBarObj, i)  
  end

  for i = #itemsObj, 1, -1 do
    table.remove(itemsObj, i)
  end

  for i = #mapObj, 1, -1 do
    table.remove(mapObj, i)  
  end

  for i = #onScreenTextPopUpObj, 1, -1 do
    table.remove(onScreenTextPopUpObj, i)  
  end

  for i = #pauseObj, 1, -1 do
    table.remove(pauseObj, i)  
  end

  for i = #playerObj, 1, -1 do
    table.remove(playerObj, i)  
  end

  for i = #textBoxObj, 1, -1 do
    table.remove(textBoxObj, i)  
  end

  for i = #tileObj, 1, -1 do
    table.remove(tileObj, i)  
  end

  for i = #specialMenuObj, 1, -1 do
    table.remove(specialMenuObj, i)  
  end

  for i = #collidableObj, 1, -1 do
    table.remove(collidableObj, i)  
  end
  
  for i = #collidableParentObj, 1, -1 do
      table.remove(collidableParentObj,i)
  end
  
  
end


function GameOver()
 
 CloseEverything()
 table.insert(gameOverScreenObj,#gameOverScreenObj + 1,GameOverScreen:New())
  
end

function PlayMusic()
  if(Sound.isPlaying(music) == true) then
  return  
  end
  
 
  Sound.play(music, LOOP)
end

function OptionsScreen()
table.insert(optionsObj, #optionsObj + 1, Options:New())  
table.remove(mainMenuObj, #mainMenuObj)
end


function MainMenuScreen()
  table.insert(mainMenuObj, #mainMenuObj + 1, MainMenu:New())
  PlayMusic()
end
function RemoveIntroVideo()
MainMenuScreen()
table.remove(splashScreenObj, #splashScreenObj)
end

function SplashScreen()
  table.insert(mapLoaderObj, #mapLoaderObj + 1, MapLoader:New())
  table.insert(controllerObj, #controllerObj + 1, Controller:New())
  table.insert(splashScreenObj, #splashScreenObj + 1, IntroVideo:New())
  
end

function CharacterSelectScreen()
  
  table.insert(characterSelectScreenObj, #characterSelectScreenObj + 1, ClassSelectionScreen:New())
  table.remove(mainMenuObj, #mainMenuObj)
  
end


function PlaySound(soundEffect)
  
  if(soundEffect == 'playerLaser') then
  Sound.play(marineLaserSnd,NO_LOOP)   
  end
  
  if(soundEffect == 'playerLaserHit') then
    Sound.play(marineLaserHitSnd,NO_LOOP) 
  end
if(soundEffect == 'playerLaserHitWall') then
    Sound.play(marineLaserWallHitSnd,NO_LOOP) 
  end
  
end


function UpdateGame()
  
  if(isPaused == true) then
    for i, value in ipairs(pauseObj) do
     shouldDelete = pauseObj[i]:Update()  
     
     if(shouldDelete == true) then
     isPaused = false
     table.remove(pauseObj,i)
     end
     
     
    end
    
    for i = #miniMapObj, 1, -1 do
    isDead = miniMapObj[i]:Update()
    
      if(isDead == true) then
        isPaused = false
        table.remove(miniMapObj, i)
      end
    
    
    end
    
    
    for i = #textBoxObj, 1, -1 do
   isDead = textBoxObj[i]:Update()
   
   if(isDead == true) then
     isPaused = false
   table.remove(textBoxObj, i)  
   end
   
  end
    
    return
    end
  
  for i, value in ipairs(splashScreenObj) do
  splashScreenObj[i]:Update()
  end
  
  for i, value in ipairs(characterSelectScreenObj) do
  characterSelectScreenObj[i]:Update()  
  
  for i, value in ipairs(controllerObj) do
    -- Gets button presses and releases
    controllerObj[i]:GetCanPresses()
    end
  
end

for i, value in ipairs(optionsObj) do
isDead = optionsObj[i]:Update()  
if(isDead == true) then
  table.remove(optionsObj, i)
  end
end

  for i, value in ipairs(mainMenuObj) do
  mainMenuObj[i]:Update()
 
 
 end
 


for i, value in ipairs(specialMenuObj) do
  specialMenuObj[i]:Update()  
  end
  
  for i = #textMessageObj, 1, -1 do
    table.remove(textMessageObj, i)
  end


for i, value in ipairs(playerObj) do
    playerObj[i]:Update()
  end
  
   collidableObj = {}
  
  
  for i, value in ipairs(mapObj) do 
  mapObj[i]:DrawMap()  
  mapObj[i]:DrawItems()
end

for i, value in ipairs(collidableParentObj) do
collidableParentObj[i]:Update()  
end

for i = #doorObj, 1, -1 do
 isDead = doorObj[i]:Update()  
 
 if(isDead == true) then
   table.remove(doorObj, i)
 end
 
 
end

for i = #chestObj, 1, -1 do
  isDead = chestObj[i]:Update() 
  if(isDead == true) then
  table.remove(chestObj, i)  
  end
  
  
end

for i = #itemsObj, 1, -1 do

  isDead = itemsObj[i]:Update()
  if(isDead == true) then
    table.remove(itemsObj, i)
  end
end

for i = #enemyObj, 1, -1 do
  isDead = enemyObj[i]:Update()
  
  if(isDead == true) then
    table.remove(enemyObj, i)
    end
  
end

  
  
  for i = #bulletsObj, 1, -1 do
  isDead = bulletsObj[i]:Update()  
  
  if(isDead == true) then
  table.remove(bulletsObj,i)  
  end
  
  
  end
  
  for i = #onScreenTextPopUpObj, 1, -1 do
isDead = onScreenTextPopUpObj[i]:Update()  

if(isDead == true) then
  table.remove(onScreenTextPopUpObj, i)
end

end
  
  
for i, value in ipairs(gameOverScreenObj) do
isDead = gameOverScreenObj[i]:Update()  

if(isDead == true) then
table.remove(gameOverScreenObj, i)  
end


end
  
  
end


function Draw()
  Graphics.initBlend() 
   Screen.waitVblankStart()
  Screen.clear()
  
  for i, value in ipairs(tileObj) do
   shouldNotEnd = tileObj[i]:Draw()
   
   if(shouldNotEnd == false) then
   break  
   end
   
   
  end
  
  for i, value in ipairs(doorObj) do
  doorObj[i]:Draw()  
  end
  
  
  for i, value in ipairs(characterSelectScreenObj) do
  characterSelectScreenObj[i]:Draw()  
  end
  
  
  for i, value in ipairs(splashScreenObj) do
  splashScreenObj[i]:Draw()
end

for i, value in ipairs(mainMenuObj) do
  mainMenuObj[i]:Draw()
  end
  
  for i, value in ipairs(playerObj) do
   playerObj[i]:Draw()
  end
  
  for i, value in ipairs(enemyObj) do
  enemyObj[i]:Draw()  
end

for i, value in ipairs(chestObj) do
chestObj[i]:Draw()  
end


for i, value in ipairs(itemsObj) do
itemsObj[i]:Draw()  
end

  
  
  for i, value in ipairs(bulletsObj) do
  bulletsObj[i]:Draw()  
  end

  for i, value in ipairs(specialMenuObj) do
  specialMenuObj[i]:Draw()  
end

for i , value in ipairs(healthBarObj) do
healthBarObj[i]:Draw()  
end


for i, value in ipairs(onScreenTextPopUpObj) do
onScreenTextPopUpObj[i]:Draw()  
end

for i, value in ipairs(textMessageObj) do
textMessageObj[i]:Draw()
end

for i, value in ipairs(textBoxObj) do
textBoxObj[i]:Draw()  
end

for i, value in ipairs(miniMapObj) do
miniMapObj[i]:Draw()  
end


for i, value in ipairs(pauseObj) do
  
pauseObj[i]:Draw()  
end

for i, value in ipairs(gameOverScreenObj) do
gameOverScreenObj[i]:Draw()  
end

for i, value in ipairs(optionsObj) do
optionsObj[i]:Draw()  
end




  
  --Font.print(fontObj, 890, 10, tostring(fps), Color.new(255,0,0))
 
  Screen.flip()
  Graphics.termBlend()
  
end
SplashScreen()

while(true) do
for i, value in ipairs(controllerObj) do
    -- Gets button presses and releases
    controllerObj[i]:GetButtonPresses()
  end
  
  
  -- Checks if enough time has passed to update game logic
  if(Timer.getTime(timerObj) >= 33.3) then
    -- Resets the logic timer
    fps = math.ceil(1000 / Timer.getTime(timerObj))
    Timer.reset(timerObj)
    
    UpdateGame()
    for i, value in ipairs(controllerObj) do
    -- Gets button presses and releases
    controllerObj[i]:GetCanPresses()
    end
    Draw()
    
  end

end
