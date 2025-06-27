waveManager = {}
waveManager.ListOfEnemy1 = {};
waveManager.ListOfRobots = {};
waveManager.ListOfBosses = {};
waveManager.ListOfShips = {};
waveManager.ListOfScooters = {};
waveManager.enemiesAlive = 0;
waveManager.currentLevel = 1;
  waveManager.currentWave = 1;
  waveManager.waitTime = 0;

require ("app0:/scripts/bullets");

 function waveManager.new()
  
  waveManager.currentLevel = 1;
  waveManager.currentWave = 1;
  waveManager.enemiesAlive = 0;
   waveManager.waitTime = 0;
  return waveManager;
 end
  
  local function NextLevel()
    waveManager.currentLevel = waveManager.currentLevel + 1;
    waveManager.currentWave = 1;
    
    end
  
  function waveManager.CreateEnemy1 (xPos,yPos, pat)
    table.insert(waveManager.ListOfEnemy1, #waveManager.ListOfEnemy1 + 1, Enemy1:new(xPos,yPos,pat));
    waveManager.enemiesAlive = waveManager.enemiesAlive + 1;
    
  end
  
  function waveManager.CreateEnemyRobot(xPos, yPos, pat, times)
    table.insert(waveManager.ListOfRobots, #waveManager.ListOfRobots + 1, Robot:new(xPos,yPos,pat,times));
     waveManager.enemiesAlive = waveManager.enemiesAlive + 1;
  end
  
  function waveManager.CreateEnemyShip(xPos,yPos)
  table.insert(waveManager.ListOfShips, #waveManager.ListOfShips + 1, Ship:new(xPos, yPos))
  waveManager.enemiesAlive = waveManager.enemiesAlive + 1;
  end
  
  
  function waveManager.CreateEnemyScooter(xPos,yPos)
    table.insert(waveManager.ListOfScooters, #waveManager.ListOfScooters + 1, Scooter:new(xPos,yPos));
    waveManager.enemiesAlive = waveManager.enemiesAlive + 1;
  end
  
  
  function waveManager.CreateBoss()
    table.insert(waveManager.ListOfBosses, #waveManager.ListOfBosses + 1, Boss:new());
    waveManager.enemiesAlive = waveManager.enemiesAlive + 1;
  end
  
  
  
function waveManager.Monster1()
  
  for i = 10, 1,-1 do
  waveManager.CreateEnemy1(1000 + (i * 60), 1 + i * 45, 1)
  
end

  
end

function waveManager.Monster2()
  
  for i = 30, 1, -1 do
  
  waveManager.CreateEnemy1(1000 + (i * 45), 400,2)
  
  end
end

function waveManager.Monster3()
  
  for i = 25, 1, -1 do
  
  waveManager.CreateEnemy1(960 + (i * 45), 100,2)
  
  end
end

function waveManager.Monster4()
  
  for i = 14, 1, -1 do
  
  waveManager.CreateEnemy1(960 + (i * 35), 500 + (i * 30) ,3)
  
  end
end

function waveManager.Monster5()
  
  for i = 14, 1, -1 do
  
  waveManager.CreateEnemy1(960 + (i * 35), -100 - (i * 30),3 )
  
  end
end

function waveManager.Monster6()
  
  for i = 22, 1, -1 do
  
  waveManager.CreateEnemy1(960 + (i * 200),  math.random(30, 450),4 )
  
  end
end

function waveManager.Monster7()
  
  for i = 20, 1, -1 do
  
  waveManager.CreateEnemy1(960 + (i * 70), 330,5 )
  
  end
end

function waveManager.Monster8()
  
  for i = 25, 1, -1 do
  
  waveManager.CreateEnemy1(1000 + (i * 70), 330 ,6)
  
  end
end

function waveManager.Robot1() 
  for i =8, 1, -1 do

    if(i < 5) then
      
       waveManager.CreateEnemyRobot(270, 0 + (i * 100) - 100,1,0)
      
    end
    if(i >= 5) then
      waveManager.CreateEnemyRobot(770, 0 + (i * 100) - 400,1,0)
    end


  end

end

function waveManager.Robot2()

for i = 12, 1, -1 do
  if(i >=9) then
  waveManager.CreateEnemyRobot(1000, 0 + (i *100) -800,2,30)

  end
  
  if(i <= 8 and i >= 5) then
    waveManager.CreateEnemyRobot(1200, 0 + (i *100) -400,2, 60)
  end
  
  if(i < 5) then
    waveManager.CreateEnemyRobot(1400, 0 + (i *100) ,2, 0)
  end
  
  
end

end

function waveManager.Robot3()
  
  for i = 6, 1, -1 do
    
    if(i == 6) then
       waveManager.CreateEnemyRobot(1000 + (i * 80), 60 + ((i * 120) - 400), 2, 0 )
    end
    
    if(i == 5) then
       waveManager.CreateEnemyRobot(1000 + (i * 80), 60 + ((i * 120) - 400), 2, 180)
    end
    
    if(i == 4) then
       waveManager.CreateEnemyRobot(1000 + (i * 80), 60 + ((i * 120) - 400), 2, 0)
    end
    
    if(i == 3) then
       waveManager.CreateEnemyRobot(1000 + (i * 80),60 + ((i * 120) - 100), 2, 180)
    end
    
    if(i == 2) then
       waveManager.CreateEnemyRobot(1000 + (i * 80), 60 + ((i * 120) - 100), 2, 180)
    end
    
    if(i == 1) then
       waveManager.CreateEnemyRobot(1000 + (i * 80), 60 + ((i * 120) - 100), 2, 180)
    end
    
    
    
  end
  
  
end



function waveManager.Ship1()
  
  for i = 4, 1, -1 do
  
  waveManager.CreateEnemyShip(1000 + (600 * i), math.random(20, 450));
  
    
  end
  
  
end

function waveManager.Ship2()
  
  for i = 12, 1, -1 do
    
    waveManager.CreateEnemyShip(1000 + ((i * 200) - 200), math.random(20, 450));
    
  end
  
  
  
end


function waveManager.Scooter1()
  
  for i = 1, 1 -1 do
  
  waveManager.CreateEnemyScooter(1000 , math.random(20,450))
  end
  
end


function waveManager.Scooter2()
  
  for i = 1, 3 -1 do
  
  waveManager.CreateEnemyScooter(1000 + ((i * 600) - 600), math.random(20,450))
  end
  
end



function waveManager.NextWave()
  
  if(waveManager.currentLevel == 1) then
    
    if(waveManager.currentWave ==1) then
      
      waveManager.Monster1();
    end
    
    if(waveManager.currentWave ==2) then
       waveManager.Monster2();
                

    end
    
    if(waveManager.currentWave ==3) then
       waveManager.Monster3();
    end
    
    if(waveManager.currentWave ==4) then
       waveManager.Monster4();
    end
    
    if(waveManager.currentWave ==5) then
       waveManager.Monster5();
    end
    
    if(waveManager.currentWave ==6) then
       waveManager.Monster6();
    end
    
    if(waveManager.currentWave ==7) then
      waveManager.Robot1();
    end
    
    if(waveManager.currentWave ==8) then
      waveManager.Monster1();
    end
    
    if(waveManager.currentWave ==9) then
      waveManager.Monster4();
    end
    
    if(waveManager.currentWave ==10) then
      waveManager.Monster2();
    end
    
    if(waveManager.currentWave ==11) then
      waveManager.Robot2();
    end
    
    if(waveManager.currentWave ==12) then
      waveManager.Monster3();
    end
    
    if(waveManager.currentWave ==13) then
      waveManager.Monster4();
    end
    
    if(waveManager.currentWave ==14) then
      waveManager.Monster8();
    end
    
    if(waveManager.currentWave ==15) then
      waveManager.Monster4();
    end
    
    if(waveManager.currentWave ==16) then
      waveManager.Monster1();
    end
    
    if(waveManager.currentWave ==17) then
      waveManager.Monster7();
      end
    
    if(waveManager.currentWave == 18) then
      waveManager.Monster8();
    end
    
    if(waveManager.currentWave == 19) then
      waveManager.Monster6()
    end
    
    if(waveManager.currentWave == 20) then
      waveManager.Monster4()
    end
    
    if(waveManager.currentWave == 21) then
      waveManager.Robot2()
    end
    
    if(waveManager.currentWave == 22) then
      waveManager.Ship1()
    end
    
    if(waveManager.currentWave == 23) then
      waveManager.Ship2();
    end
    
    if(waveManager.currentWave == 24) then
      waveManager.Monster5()
    end
    
    if(waveManager.currentWave == 25) then
      waveManager.Monster7()
    end
    
    if(waveManager.currentWave == 26) then
      waveManager.Robot3()
    end
    
    if(waveManager.currentWave == 27) then
      waveManager.Ship2()
    end
    
    if(waveManager.currentWave == 28) then
      waveManager.Ship1()
    end
    
    if(waveManager.currentWave == 29) then
      waveManager.Ship2()
    end
    
    if(waveManager.currentWave == 30) then
      waveManager.Monster8()
    end
    
    if(waveManager.currentWave == 31) then
      waveManager.Robot3()
    end
    
    if(waveManager.currentWave == 32) then
      waveManager.Monster1()
    end
    
    if(waveManager.currentWave == 33) then
      waveManager.Monster4()
    end
    
    if(waveManager.currentWave == 34) then
      waveManager.Robot2()
    end
    
    if(waveManager.currentWave == 35) then
      waveManager.Ship2()
    end
    
    if(waveManager.currentWave == 36) then
      waveManager.Monster8()
    end
    
    if(waveManager.currentWave == 37) then
      waveManager.Ship1()
    end
    
    if(waveManager.currentWave == 38) then
      waveManager.Robot3()
    end
    
    if(waveManager.currentWave == 39) then
      waveManager.Monster7()
    end
    
    if(waveManager.currentWave == 40) then
      waveManager.Monster5()
    end
    
    if(waveManager.currentWave == 41) then
      waveManager.Scooter1();
      waveManager.Scooter2()
    end
    
    if(waveManager.currentWave == 42) then
      waveManager.Monster3()
    end
    
    if(waveManager.currentWave == 43) then
      waveManager.Scooter2()
    end
    
    if(waveManager.currentWave == 44) then
      waveManager.Ship1();
    end
    
    if(waveManager.currentWave == 45) then
      
      waveManager.CreateBoss();
      
    end
    
    
    
  end
  
  
  waveManager.currentWave = waveManager.currentWave + 1;
  end

function waveManager.Update()
  
  if(waveManager.enemiesAlive <= 0) then
  waveManager.NextWave()
  end
  
  end

