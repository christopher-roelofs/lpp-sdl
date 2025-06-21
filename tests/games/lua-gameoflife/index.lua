-- INJECT start dependencies
dofile("common/FPSController.lua")
dofile("input/InputModule.lua")
dofile("draw/DrawModule.lua")
-- INJECT end dependencies

while true do
    DrawModule.draw()
    InputModule.update()
    FPSController.limit()
end
