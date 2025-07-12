--[[

	StartUp File for Paint Lite 0.3
	----------------------------------
	Starts everything to set up the enviroment and etc.
	
	Create Date: 2020.06.07
	Last Edit: 2020.08.03

--]]


dofile("Functions.lua")

-- Configs
dofile("Data/Config.cfg")
Load.Style(Config.Theme)
Load.ToolPack(Config.ToolPack)

-- Starting a Main Script
dofile("Menu.lua")

--exit()
error("Exit an app via PS button, thanks")