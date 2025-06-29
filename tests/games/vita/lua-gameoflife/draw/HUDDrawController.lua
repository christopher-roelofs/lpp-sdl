dofile("input/InputModule.lua")
dofile("game_of_life/GameOfLifeModule.lua")

HUDDrawController = {}

local crossImage = Graphics.loadImage("assets/sprites/cross0.png")
local dpadImage = Graphics.loadImage("assets/sprites/dpad0.png")
local selectImage = Graphics.loadImage("assets/sprites/select0.png")
local startImage = Graphics.loadImage("assets/sprites/start0.png")
local rtriggerImage = Graphics.loadImage("assets/sprites/rtrigger0.png")
local ltriggerImage = Graphics.loadImage("assets/sprites/ltrigger0.png")
local BLACK = Color.new(0, 0, 0)

HUDDrawController = {}

function HUDDrawController.pipeline()
    Graphics.drawImage(816, 64, crossImage)
    Graphics.drawImage(816, 108, dpadImage)
    Graphics.drawImage(816, 152, selectImage)
    Graphics.drawImage(816, 196, startImage)
    Graphics.drawImage(816, 240, rtriggerImage)
    Graphics.drawImage(816, 284, ltriggerImage)
    Graphics.debugPrint(816, 32, "- MENU -", BLACK)
    Graphics.debugPrint(856, 64, "Switch", BLACK)
    Graphics.debugPrint(856, 108, "Move", BLACK)
    Graphics.debugPrint(856, 152, "FPS Limit", BLACK)
    Graphics.debugPrint(856, 196, GameOfLifeModule.MODE, BLACK)
    Graphics.debugPrint(856, 240, "Random", BLACK)
    Graphics.debugPrint(856, 284, "Empty", BLACK)
end
