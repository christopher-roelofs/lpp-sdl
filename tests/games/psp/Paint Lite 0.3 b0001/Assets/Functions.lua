--[[

	Function File for Paint Lite 0.3
	----------------------------------
	Loads useful functions and global variables
	
	Create Date: 2020.06.07
	Last Edit: 2020.08.10

--]]

Const = {
	AppName = "Paint Lite",
	Version = "0.3", Build = "0001",
	Date = "2020.08.10",
	Author = "MasterMen",
	
	ScreenshotsDir = "Screenshots",
	DrawingsDir = "Saves",
	SaveFormat = ".png",
	PrjFormat = ".plp", -- Paint Lite Project File
	
	FontSize = 11,
	
	Default = {
		Style = "White",
		ToolPack = "ClassicNew"
	}
	
}

G = {
	mState = "Menu",
	mStateOld = "",
	mOneTime = true,
	SaveCount = nil,
	
	Run = {
		Menu = true,
		Gallery = true,
		Settings = true,
		Paint = true,
		Info = true
	}
}

-- Default Colors Pack
Col = {
	Black = Color.new(0	,0	,0),
	White = Color.new(255	,255	,255),
	
	Red = Color.new(255	,0	,0),
	Green = Color.new(0	,255	,0),
	Blue = Color.new(0	,0	,255),
	Yellow = Color.new(255	,255	,0)
}

function LoadClass(Class)
	dofile("Classes/"..Class.."Class.lua")
end

function LoadInterface(Class)
	dofile("Classes/Interface/"..Class.."Class.lua")
end

function LoadContainer(cont)
	dofile("Data/Editor/Containers/Container"..cont..".lua")
end

function LoadPalette(Pal)
	dofile("Data/Editor/"..Pal..".cfg")
end

SaveCounter = {
	Read = function(Folder)
		ScreenCFG = io.open(Folder.."/Temp/SaveCounter.cfg", "r")
		G.SaveCount = tonumber(ScreenCFG:read())
		ScreenCFG:close()
	end,
	Write = function(Folder, Save)
		ScreenCFG = io.open(Folder.."/Temp/SaveCounter.cfg", "w")
		ScreenCFG:write(Save)
		ScreenCFG:close()
	end
}

function returnBool(bool)
	if bool == true then bool = "true" else bool = "false" end
	return bool
end

-- I would make a saving system by data, but LuaPlayer 0.20 can't do this
function SavePicture()
	SaveCounter.Read(Const.DrawingsDir)
		G.SaveCount = G.SaveCount + 1
		local add = "0000"
		if G.SaveCount > 10000 then
			error("Sorry, but "..Const.AppName..Const.Version.." Can't handle more than 10.000 saved drawings, please clear your folder.")
		elseif G.SaveCount == 10000 then -- 10.000
			add = ""
		elseif G.SaveCount > 10000 then -- X0.000
			add = "0"
		elseif G.SaveCount > 1000 then -- XX.000
			add = "00"
		elseif G.SaveCount > 100 then -- XX.X00
			add = "000"
		elseif G.SaveCount > 10 then -- XX.XX0
			add = "0000"
		end
		screen:save(Const.DrawingsDir.."/"..add..G.SaveCount.."_Save"..Const.SaveFormat)
	SaveCounter.Write(Const.DrawingsDir, G.SaveCount)
end

function TakeScreenshot()
	SaveCounter.Read(Const.ScreenshotsDir)
		G.SaveCount = G.SaveCount + 1
		local add = "0000"
		if G.SaveCount > 10000 then
			error("Sorry, but "..Const.AppName..Const.Version.." Can't handle more than 10.000 saved screenshots, please clear your folder.")
		elseif G.SaveCount == 10000 then -- 10.000
			add = ""
		elseif G.SaveCount > 10000 then -- X0.000
			add = "0"
		elseif G.SaveCount > 1000 then -- XX.000
			add = "00"
		elseif G.SaveCount > 100 then -- XX.X00
			add = "000"
		elseif G.SaveCount > 10 then -- XX.XX0
			add = "0000"
		end
		screen:save(Const.ScreenshotsDir.."/"..add..G.SaveCount.."_Screenshot"..Const.SaveFormat)
	SaveCounter.Write(Const.ScreenshotsDir, G.SaveCount)
end

-- Thanks to Exnonull
pressed={
	left=false,
	up=false,
	right=false,
	down=false,
	r=false,
	l=false,
	start=false,
	select=false,
	cross=false,
	triangle=false,
	square=false,
	circle=false
}

function AdvFontPrint(Font, X, Y, Text, Color1, Color2, Skip)
	Skip = Skip or 1
	--screen:fontPrint(Font, X + Skip, Y + Skip, Text, Color2)
	screen:fontPrint(Font, X, Y, Text, Color1)
end

function Pixel(X, Y, Color)
	screen:fillRect(X, Y, 1, 1, Color)
end

Style = {
	spr = {},
	Font = nil
}

ToolPack = {
	spr = {
		Cursor = {},
		Icon = {}
	}
}



Load = {

	ToolPack = function(argToolPack)
		
		dofile("Resources/ToolPack/"..argToolPack.."/Info.cfg")
		
		ToolPack.spr.Icon = {
			Pencil = Image.load("Resources/ToolPack/"..argToolPack.."/Icon/Pencil.png"),
			Brush = Image.load("Resources/ToolPack/"..argToolPack.."/Icon/Brush.png"),
			Eraser = Image.load("Resources/ToolPack/"..argToolPack.."/Icon/Eraser.png"),
			FillTool = Image.load("Resources/ToolPack/"..argToolPack.."/Icon/Fill.png"),
			LineTool = Image.load("Resources/ToolPack/"..argToolPack.."/Icon/Line.png"),
			SquareTool = Image.load("Resources/ToolPack/"..argToolPack.."/Icon/Square.png"),
			CircleTool = Image.load("Resources/ToolPack/"..argToolPack.."/Icon/Circle.png"),
			ColorPickTool = Image.load("Resources/ToolPack/"..argToolPack.."/Icon/ColorPick.png"),
			SelectionTool = Image.load("Resources/ToolPack/"..argToolPack.."/Icon/Selection.png"),
			MovingSelectionTool = Image.load("Resources/ToolPack/"..argToolPack.."/Icon/MoveSelection.png"),
			MovingTool = Image.load("Resources/ToolPack/"..argToolPack.."/Icon/Move.png")
		}
		
		ToolPack.spr.Cursor = {
			Pencil = Image.load("Resources/ToolPack/"..argToolPack.."/Pencil.png"),
			Brush = Image.load("Resources/ToolPack/"..argToolPack.."/Brush.png"),
			Eraser = Image.load("Resources/ToolPack/"..argToolPack.."/Eraser.png"),
			FillTool = Image.load("Resources/ToolPack/"..argToolPack.."/Fill.png"),
			LineTool = Image.load("Resources/ToolPack/"..argToolPack.."/Line.png"),
			SquareTool = Image.load("Resources/ToolPack/"..argToolPack.."/Square.png"),
			CircleTool = Image.load("Resources/ToolPack/"..argToolPack.."/Circle.png"),
			ColorPickTool = Image.load("Resources/ToolPack/"..argToolPack.."/ColorPick.png"),
			SelectionTool = Image.load("Resources/ToolPack/"..argToolPack.."/Selection.png"),
			MovingSelectionTool = Image.load("Resources/ToolPack/"..argToolPack.."/MoveSelection.png"),
			MovingTool = Image.load("Resources/ToolPack/"..argToolPack.."/Move.png"),
			Cursor = Image.load("Resources/ToolPack/"..argToolPack.."/Cursor.png")
		}
		
	end,

	Style = function(argStyle)
		
		dofile("Resources/Style/"..argStyle.."/Info.cfg")
		
		Style.Font = Font.load("Resources/Style/"..argStyle.."/"..StyleInfo.Font)
		Style.Font:setPixelSizes(Const.FontSize, Const.FontSize)
		
		Style.spr = {
			Button = {
				Start = Image.load("Resources/Style/"..argStyle.."/Menu/MainMenu/StartDrawing.png"), 
				Gallery = Image.load("Resources/Style/"..argStyle.."/Menu/MainMenu/Gallery.png"),
				Settings = Image.load("Resources/Style/"..argStyle.."/Menu/MainMenu/Settings.png"),
				Info = Image.load("Resources/Style/"..argStyle.."/Menu/MainMenu/Information.png"), 
				Exit = Image.load("Resources/Style/"..argStyle.."/Menu/MainMenu/ExitApp.png"), 
				
				Activated = Image.load("Resources/Style/"..argStyle.."/Menu/MainMenu/Activated.png"),
				ActivatedClosed = Image.load("Resources/Style/"..argStyle.."/Menu/MainMenu/ActivatedClosed.png"),
				--Back = Image.load("Resources/Style/"..argStyle.."/Buttons/Back.png")
				
				MenuNon = Image.load("Resources/Style/"..argStyle.."/Menu/MenuButton.png"),
				MenuActive = Image.load("Resources/Style/"..argStyle.."/Menu/MenuButtonActive.png")
				
			},
			--[[
			OtherButton = {
				-- Selected Buttons
				PageShowSel = Image.load("Resources/Style/"..argStyle.."/Settings/PageShowSel.png"),
				SmallButtonSel = Image.load("Resources/Style/"..argStyle.."/Settings/SmallButtonSel.png"),
				BigSel = Image.load("Resources/Style/"..argStyle.."/Settings/BigSelection.png"),
				
				-- UnSelected Buttons
				PageShow = Image.load("Resources/Style/"..argStyle.."/Settings/PageShow.png"),
				SmallButton = Image.load("Resources/Style/"..argStyle.."/Settings/SmallButton.png"),
				Big = Image.load("Resources/Style/"..argStyle.."/Settings/Big.png"),
				
				SelON = Image.load("Resources/Style/"..argStyle.."/Settings/SelectorON.png"),
				SelOFF = Image.load("Resources/Style/"..argStyle.."/Settings/SelectorOFF.png"),
				
				Counter = Image.load("Resources/Style/"..argStyle.."/Settings/Counter.png")
			},
			--]]
			Other = {
				Logo = Image.load("Resources/Style/"..argStyle.."/Other/Logo.png"),
				Wires = Image.load("Resources/Style/"..argStyle.."/Menu/Information/Wires.png"),
				Circles = Image.load("Resources/Style/"..argStyle.."/Menu/Information/NineCircles.png"),
				Locker = Image.load("Resources/Style/"..argStyle.."/Other/Icons/Locker.png")
				
				--SettingPanel = Image.load("Resources/Style/"..argStyle.."/Settings/ListBox.png"),
				--Slider1x = Image.load("Resources/Style/"..argStyle.."/Settings/Slider1x.png")
				--LeftSelection = Image.load("Resources/Style/"..Style.."/Settings/Selection/LeftSel.png"),
				--RightSelection = Image.load("Resources/Style/"..Style.."/Settings/Selection/RightSel.png"),
			},
			
			Elements = {
				PanelTool = Image.load("Resources/Style/"..argStyle.."/PanelTools.png"),
				PanelColor = Image.load("Resources/Style/"..argStyle.."/PanelColors.png"),
				PanelParams = Image.load("Resources/Style/"..argStyle.."/PanelParams.png"),
				PanelSpeed = Image.load("Resources/Style/"..argStyle.."/PanelSpeed.png"),
				PanelThickness = Image.load("Resources/Style/"..argStyle.."/PanelThickness.png"),
				PanelInfo = Image.load("Resources/Style/"..argStyle.."/PanelInfo.png"),
				Menu = Image.load("Resources/Style/"..argStyle.."/Menu/Menu.png")
			},
			
			Speed = {
				DeepRed = Image.load("Resources/Style/"..argStyle.."/Other/Speed/DeepRed.png"),
				Red = Image.load("Resources/Style/"..argStyle.."/Other/Speed/Red.png"),
				Yellow = Image.load("Resources/Style/"..argStyle.."/Other/Speed/Yellow.png"),
				LightBlue = Image.load("Resources/Style/"..argStyle.."/Other/Speed/LightBlue.png")
			}
		}
		
	end
}