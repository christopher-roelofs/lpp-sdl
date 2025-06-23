local desiredFPS = 60
local timer = Timer.new()
local lastLoopTime = Timer.getTime(timer)
local OPTIMAL_TIME = 1000 / desiredFPS
local delta = 0
local lastFpsTime = 0
local realFps = 0
local displayFps = 0
FPS = {}

function FPS.limit()
    local now = Timer.getTime(timer) --miliseconds 1/1000
    local updateLength = now - lastLoopTime --miliseconds 1/1000
    lastLoopTime = now
    delta = updateLength / OPTIMAL_TIME
    lastFpsTime = lastFpsTime + updateLength
    realFps = realFps + 1
    if lastFpsTime >= 1000 then
        displayFps = realFps
        lastFpsTime = 0
        realFps = 0
    end
    System.wait(math.floor((lastLoopTime - Timer.getTime(timer) + OPTIMAL_TIME)* 1000)) -- microseconds 1/1000000
end

function FPS.get()
    return displayFps
end