dofile("input/InputModule.lua")

local image = Graphics.loadImage("assets/sprites/cursor0.png")

CursorDrawController = {}

function CursorDrawController.pipeline()
    cursorPosition = InputModule.getCursorPosition()
    Graphics.drawImage(cursorPosition[0], cursorPosition[1], image)
end
