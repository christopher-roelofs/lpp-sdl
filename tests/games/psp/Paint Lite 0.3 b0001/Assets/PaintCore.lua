--[[

	Paint Core File for Paint Lite 0.3
	----------------------------------
	Connects up every class and activates them.
	Main Script, provides drawing state.
	
	Create Date: 2020.06.07
	Last Edit: 2020.08.09

--]]


exit = false


P = {
	mState = "Paint",
		-- "Paint"
		-- "Workspace"
		-- "Menu"
	mMenuState = "Menu",
		-- "Menu"
		-- "Save"
		-- ""
	Draw = {
		Square = nil,
		Circle = nil
	},
	Pal = {
		Load = nil
	},
	
	Interface = {
		ToolPanel = nil,
		ColorPalette = nil,
		ParamsPanel = nil
	}
}

-- Save Process
SP = {
	ti = 0, -- Max = 3
	Do = false
}

function StartScreen()
	SP.Do = true
	SP.ti = 3
end

function ScreenFromMenu()
	if SP.Do then
		Me.Cursor.Visible = false
		if SP.ti ~= 0 then SP.ti = SP.ti - 1 end
		if SP.ti == 0 then SavePicture() SP.Do = false end
	else
		Me.Cursor.Visible = true
	end
end

DebugLog = io.open("debug.log", "w")
DebugLog:write("Starting...\n\n")

DebugLog:write("Interfaces:\n")
LoadInterface("Tool")
DebugLog:write("[Loaded] Tools Loaded\n")

LoadInterface("ColorPalette")
DebugLog:write("[Loaded] Colors Palette\n")

LoadInterface("Parameter")
DebugLog:write("[Loaded] Paramenters\n")

LoadInterface("Speed")
DebugLog:write("[Loaded] Speed\n")

LoadInterface("InfoPanel")
DebugLog:write("[Loaded] Info Panel\n")

LoadInterface("Menu")
DebugLog:write("[Loaded] Menu\n")


DebugLog:write("\nContainers:\n")
LoadContainer("Square") -- for Pen
DebugLog:write("[Loaded] Square\n")

LoadContainer("Circle") -- for Brush
DebugLog:write("[Loaded] Circle\n")

DebugLog:write("\nOther Classes:\n")
LoadClass("Cursor")
DebugLog:write("[Loaded] Cursor Class\n")
LoadClass("Canvas")
DebugLog:write("[Loaded] Canvas Class\n")

Me = {
	ToolPanel = ToolPanel:new(),
	ColorPalette = ColorPalette:new(),
	Params = nil,
	Speed = Speed:new(),
	InfoPan = InfoPan:new(),
	Menu = MenuPaint:new(),
	
	Cursor = Cursor:new(),
	Canvas = Canvas:new()
}

--WorkCan = image.create(480, 272)

Me.ToolPanel:SetDefaults()
Me.ColorPalette:SetDefaults()
Me.Speed:SetDefaults()
Me.Speed:ChangePosition("Left")
Me.InfoPan:SetDefaults()
Me.Menu:SetDefaults()

Me.Cursor:SetDefaults(ToolPackInfo)
Me.Canvas:SetDefaults()

Me.Cursor:ChangeIcon("Pencil")

LoadPalette("01 Palette")
P.Pal.Load(Me.ColorPalette, 1)
LoadPalette("02 Palette")
P.Pal.Load(Me.ColorPalette, 2)
LoadPalette("03 Palette")
P.Pal.Load(Me.ColorPalette, 3)

DebugLog:write("\n\nALL READY TO USE\n")

DebugLog:close()

ToolPanel = nil
Speed = nil
Param = nil
Cursor = nil
Canvas = nil





----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

function Draw()
	if Me.Cursor.Tool == "Pencil" then
		if pad:l() then
			Me.Cursor:Draw("Square", Me.Canvas, 1, Me.Cursor.Size.Pencil.Cur, Me.Cursor.LColor)
		elseif pad:r() then
			Me.Cursor:Draw("Square", Me.Canvas, 1, Me.Cursor.Size.Pencil.Cur, Me.Cursor.RColor)
		end
	elseif Me.Cursor.Tool == "Brush" then
		if pad:l() then
			Me.Cursor:Draw("Circle", Me.Canvas, 1, Me.Cursor.Size.Brush.Cur, Me.Cursor.LColor)
		elseif pad:r() then
			Me.Cursor:Draw("Circle", Me.Canvas, 1, Me.Cursor.Size.Brush.Cur, Me.Cursor.RColor)
		end
	elseif Me.Cursor.Tool == "Eraser" then
		if pad:l() then
			Me.Cursor:Draw("Circle", Me.Canvas, 1, Me.Cursor.Size.Brush.Cur, Col.White)
		elseif pad:r() then
			Me.Cursor:Draw("Circle", Me.Canvas, 1, Me.Cursor.Size.Brush.Cur, Col.White)
		end
	end
end

-- Change Brush Size
CBS = {
	doTim = function(self)
		if self.ti ~= 0 then self.ti = self.ti - 1 end
	end,
	
	ResetTim = function(self)
		if P.mState == "Paint" then
			self.ti = self.maxP
		elseif P.mState == "Workspace" then
			self.ti = self.maxW
		end
	end,
	
	ti = 0,
	maxP = 10,
	maxW = 4
}

function ChangeBrushSize()
	CBS:doTim()
	if not Me.Cursor.Collision.ColorPalette then
		if pad:left() then -- "-"
			if CBS.ti == 0 then
				if Me.Cursor.Tool == "Pencil" then
					if Me.Cursor.Size.Pencil.Cur ~= 1 then
						Me.Cursor.Size.Pencil.Cur = Me.Cursor.Size.Pencil.Cur - 1
					else
						Me.Cursor.Size.Pencil.Cur = Me.Cursor.Size.Pencil.Max
					end
				elseif Me.Cursor.Tool == "Brush" or Me.Cursor.Tool == "Eraser" then
					if Me.Cursor.Size.Brush.Cur ~= 1 then
						Me.Cursor.Size.Brush.Cur = Me.Cursor.Size.Brush.Cur - 1
					else
						Me.Cursor.Size.Brush.Cur = Me.Cursor.Size.Brush.Max
					end
				end
			end
			
			
		elseif pad:right() then -- "+"
			if CBS.ti == 0 then
				if Me.Cursor.Tool == "Pencil" then
					if Me.Cursor.Size.Pencil.Cur ~= Me.Cursor.Size.Pencil.Max then
						Me.Cursor.Size.Pencil.Cur = Me.Cursor.Size.Pencil.Cur + 1
					else
						Me.Cursor.Size.Pencil.Cur = 1
					end
				elseif Me.Cursor.Tool == "Brush" or Me.Cursor.Tool == "Eraser" then
					if Me.Cursor.Size.Brush.Cur ~= Me.Cursor.Size.Brush.Max then
						Me.Cursor.Size.Brush.Cur = Me.Cursor.Size.Brush.Cur + 1
					else
						Me.Cursor.Size.Brush.Cur = 1
					end
				end
			end
		end
		
		if pad:left() and CBS.ti == 0 or pad:right() and CBS.ti == 0 then
			CBS:ResetTim()
		end
	end
end

function CursorMove()
	if Me.Cursor.Timer.pix.Cur >= Me.Cursor.Timer.pix.Max then
		Me.Cursor.Timer.pix.Cur = Me.Cursor.Timer.pix.Max
		if pad:up() then
			Me.Cursor:InitMove(Me.Cursor.Sensity, "Up")
		elseif pad:down() then
			Me.Cursor:InitMove(Me.Cursor.Sensity, "Down")
		elseif pad:left() then
			Me.Cursor:InitMove(Me.Cursor.Sensity, "Left")
		elseif pad:right() then
			Me.Cursor:InitMove(Me.Cursor.Sensity, "Right")
		end
	end
	
	Me.Cursor:InitMove(Me.Cursor.Sensity)
end

function ActivateSpeed()
	if pad:up() then
		if pressed.up == false then
			pressed.up = true
			Me.Speed:InitAction(Me.Cursor)
			Me.Speed:ApplySpeed(Me.Cursor)
			Me.Speed:fTimerRun()
		end
	else
		pressed.up = false
	end
	if pad:down() then
		if pressed.down == false then
			pressed.down = true
			Me.Speed:InitAction(Me.Cursor)
			Me.Speed:ApplySpeed(Me.Cursor)
			Me.Speed:fTimerRun()
		end
	else
		pressed.down = false
	end
end

function CheckSpeedPos()
	if Me.Cursor.X <= 49 then
		Me.Speed:ChangePosition("Right")
	elseif Me.Cursor.X >= 431 then
		Me.Speed:ChangePosition("Left")
	end
end

-------------------------------------------
-------------------------------------------
-------------------------------------------

-- Swap Tool - Pencil to Brush
STPenBru = {
	func = function(self)
		if pad:square() and self.ti == 0 then
			if Me.Cursor.Tool == "Pencil" then
				Me.Cursor.Tool = "Brush"
			elseif Me.Cursor.Tool == "Brush" then
				Me.Cursor.Tool = "Pencil"
			else
				Me.Cursor.Tool = "Pencil"
			end
			self:ResetTim()
		end
	end,
	
	doTim = function(self)
		if self.ti ~= 0 then self.ti = self.ti - 1 end
	end,
	
	ResetTim = function(self)
		if P.mState == "Paint" then
			self.ti = self.maxP
		elseif P.mState == "Workspace" then
			self.ti = self.maxW
		end
	end,
	
	ti = 0,
	maxP = 20,
	maxW = 5
}

-- Swap Tool - Eraser
STEr = {
	func = function(self)
		if pad:circle() and self.ti == 0 then
			if Me.Cursor.PrevTool == "Pencil" or Me.Cursor.PrevTool == "Brush" then
				Me.Cursor.Tool = "Eraser"
			elseif Me.Cursor.Tool == "Eraser" then
				Me.Cursor.Tool = Me.Cursor.PrevTool
			else
				Me.Cursor.Tool = Me.Cursor.PrevTool
			end
			self:ResetTim()
		end
	end,
	
	doTim = function(self)
		if self.ti ~= 0 then self.ti = self.ti - 1 end
	end,
	
	ResetTim = function(self)
		self.ti = self.max
	end,
	
	ti = 0,
	max = 10
}

SwapTool = {
	DoSwap = function()
		STPenBru:func()
		STEr:func()
	end,
	DoTimer = function()
		STPenBru:doTim()
		STEr:doTim()
	end
}

-------------------------------------------
-------------------------------------------
-------------------------------------------

function PaintMenu()
	-- Menu Opening and Closing Process
	if pad:start() and Me.Menu.StartTimer == 0 then
		if P.mState == "Paint" or P.mState == "Workspace" then
			P.mState = "Menu"
			P.mMenuState = "Menu"
			Me.Menu.StartTimer = Me.Menu.StartLat
		else
			P.mState = "Paint"
		end
	end
	if Me.Menu.StartTimer ~= 0 then Me.Menu.StartTimer = Me.Menu.StartTimer - 1 end
end

function SwitchPalettes()
	Me.Cursor:CollisionsCheck("Color Palette")
	if pad:left() or pad:right() then
		if Me.Cursor.Collision.ColorPalette then
			if pad:left() then
				if Me.Cursor.CurPal ~= 1 then
					Me.Cursor.CurPal = Me.Cursor.CurPal - 1
				else
					Me.Cursor.CurPal = 3
				end
			elseif pad:right() then
				if Me.Cursor.CurPal ~= 3 then
					Me.Cursor.CurPal = Me.Cursor.CurPal + 1
				else
					Me.Cursor.CurPal = 1
				end
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------


while G.Run.Paint do
	pad = Controls.read()
	Me.Cursor:InitTimer()
	Me.Cursor:ToolCheck(Me.ToolPanel)
	
	screen:clear(StyleInfo.BackColor)
	Me.Canvas:InitRender(1)
	
	Me.Speed:Initialize(Me.Cursor, P.mState)
	
	SwapTool.DoTimer()
	
	-----------------------------------------------------------------
	-----------------------------------------------------------------
	-----------------------------------------------------------------
	if P.mState == "Paint" then
		Me.Speed:InitRender(Me.Cursor, P.mState)
		
		if pad:triangle() then
			if pressed.right == false then
				pressed.right = true
				P.mState = "Workspace"
			end
		else
			pressed.right = false
		end
		
		Draw()
		
		ActivateSpeed()
		CursorMove()
		Me.Cursor:InitRender(Me.Cursor.Visible)
		Me.Cursor:InitBorders("Border")
		CheckSpeedPos()
		
		SwapTool.DoSwap()
		ChangeBrushSize()
		
		if pad:select() then StartScreen() end
		Me.Cursor:Pixel(Me.Cursor.Visible)
		
		ScreenFromMenu()
		Me.Cursor:InitTrigger()
	
	-----------------------------------------------------------------
	-----------------------------------------------------------------
	-----------------------------------------------------------------
	elseif P.mState == "Workspace" then
		
		Me.ToolPanel:InitRender()
		Me.ToolPanel:InitRenderSelection()
		Me.ToolPanel:InitRenderIcons()
		Me.ToolPanel:InitRenderColors(Me.Cursor)
		
		Me.ColorPalette:InitRender()
		Me.ColorPalette:InitRenderColors(Me.Cursor.CurPal)
		Me.ColorPalette:InitRenderInfo(Me.Cursor.CurPal, Me.Cursor, Me.Cursor.Trigger)
		
		SwapTool.DoSwap()
		ChangeBrushSize()
		
		Me.InfoPan:Initialize()
		AdvFontPrint(Style.Font, 197, 269, Const.AppName.." "..Const.Version.." by "..Const.Author..", Build "..Const.Build.." from "..Const.Date, Col.Red, StyleInfo.FontDown, 1)
		
		if pad:l() then
			Me.ColorPalette:InitActions(Me.Cursor.CurPal, Me.Cursor, Me.Cursor.Trigger)
		elseif pad:r() then
			Me.ColorPalette:InitActions(Me.Cursor.CurPal, Me.Cursor, Me.Cursor.Trigger)
		end
		
		if pad:cross() then Me.ToolPanel:InitActions(Me.Cursor) end
		SwitchPalettes()
		
		if pad:triangle() then
			if pressed.right == false then
				pressed.right = true
				P.mState = "Paint"
			end
		else
			pressed.right = false
		end
		
		ActivateSpeed()
		CursorMove()
		
		Me.Cursor:InitRender(Me.Cursor.Visible)
		Me.Cursor:InitBorders("Teleport")
		
		if pad:select() then TakeScreenshot() end
		Me.Cursor:Pixel(Me.Cursor.Visible)
		Me.Cursor:InitTrigger()
		
	-----------------------------------------------------------------
	-----------------------------------------------------------------
	-----------------------------------------------------------------
	elseif P.mState == "Menu" then
		if P.mMenuState == "Menu" then
			
			Me.Menu:InitRender()
			Me.Menu:InitActions()
			
			if pad:select() then TakeScreenshot() end
			
		elseif P.mMenuState == "Save" then
			
		end
	end
	
	PaintMenu()
	
	if exit then
		break
	end
	
	--[[
	AdvFontPrint(Style.Font, 120, 250, "CBS.ti: "..CBS.ti, StyleInfo.FontUp, StyleInfo.FontDown, 1)
	if Me.Cursor.Tool == "Pencil" then
		AdvFontPrint(Style.Font, 90, 250, Me.Cursor.Size.Pencil.Cur.."/"..Me.Cursor.Size.Pencil.Max, StyleInfo.FontUp, StyleInfo.FontDown, 1)
	elseif Me.Cursor.Tool == "Brush" or Me.Cursor.Tool == "Eraser" then
		AdvFontPrint(Style.Font, 90, 250, Me.Cursor.Size.Brush.Cur.."/"..Me.Cursor.Size.Brush.Max, StyleInfo.FontUp, StyleInfo.FontDown, 1)
	end
	--]]
	
	--screen:print(200, 100, "", Col.Black)
	--screen:print(200, 120, "", Col.Black)
	
	--[[
	screen:print(170 - 30, 240, "", Col.Black)
	screen:print(280 - 30, 240, "", Col.Black)
	--]]
	--screen:print(170 - 20, 245, "Prev: "..Me.Cursor.PrevTool, Col.Black)
	--screen:print(280 - 20, 245, "Old: "..Me.Cursor.OldTool, Col.Black)
	
	
	
	screen.flip()
	screen.waitVblankStart()
end