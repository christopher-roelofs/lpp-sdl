function CreateBat1(x,y)
  table.insert(enemyObj, #enemyObj + 1, Bat:New())
end


function CreateSlime1()
  table.insert(enemyObj, #enemyObj + 1, Slime:New())
end

function CreateBug1()
  table.insert(enemyObj, #enemyObj + 1, Bug:New())
end
