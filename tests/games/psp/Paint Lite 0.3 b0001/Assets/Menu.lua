--[[

	Menu File for Paint Lite 0.3
	----------------------------------
	App menu
	
	Create Date: 2020.06.07
	Last Edit: 2020.08.10

--]]

Menu = {
	index = 1
	-- 1 = Start Drawing
	-- 2 = Gallery
	-- 3 = Settings
	-- 4 = Information
	-- 5 = Exit App
}

Buttons = {
	HotX = 23,
	HotY = 83,
	
	Start = {
		X = 0,
		Y = 0
	},
	Gallery = {
		X = 0,
		Y = 30
	},
	Settings = {
		X = 0,
		Y = 60
	},
	Info = {
		X = 0,
		Y = 90
	},
	Exit = {
		X = 0,
		Y = 120
	}
}

-- Stop Timer
stt = 0

while G.Run.Menu do
	pad = Controls.read()
	screen:clear(StyleInfo.BackColor)

	if pad:up() then
		if pressed.up == false then
			pressed.up = true
			if Menu.index ~= 1 then
				Menu.index = Menu.index - 1
			else
				Menu.index = 5
			end
		end
	else
		pressed.up = false
	end

	if pad:down() then
		if pressed.down == false then
			pressed.down = true
			if Menu.index ~= 5 then
				Menu.index = Menu.index + 1
			else
				Menu.index = 1
			end
		end
	else
		pressed.down = false
	end

	screen:blit(18, 18, Style.spr.Other.Logo)

	screen:blit(Buttons.HotX + Buttons.Start.X, Buttons.HotY + Buttons.Start.Y, Style.spr.Button.Start)
	screen:blit(Buttons.HotX + Buttons.Gallery.X, Buttons.HotY +  Buttons.Gallery.Y, Style.spr.Button.Gallery)
	screen:blit(Buttons.HotX + Buttons.Settings.X, Buttons.HotY +  Buttons.Settings.Y, Style.spr.Button.Settings)
	screen:blit(Buttons.HotX + Buttons.Info.X, Buttons.HotY +  Buttons.Info.Y, Style.spr.Button.Info)
	screen:blit(Buttons.HotX + Buttons.Exit.X, Buttons.HotY +  Buttons.Exit.Y, Style.spr.Button.Exit)

	if Menu.index == 1 then
		screen:blit(Buttons.HotX + Buttons.Start.X, Buttons.HotY + Buttons.Start.Y, Style.spr.Button.Activated)	
		AdvFontPrint(Style.Font, 238, 100 + (29 * 0), ">  Start your new drawing", StyleInfo.FontUp, StyleInfo.FontDown, 1)
	elseif Menu.index == 2 then
		screen:blit(Buttons.HotX + Buttons.Gallery.X, Buttons.HotY +  Buttons.Gallery.Y, Style.spr.Button.ActivatedClosed)
		AdvFontPrint(Style.Font, 238, 100 + (29 * 1), ">  Check a local and a global gallery", StyleInfo.FontUp, StyleInfo.FontDown, 1)
	elseif Menu.index == 3 then
		screen:blit(Buttons.HotX + Buttons.Settings.X, Buttons.HotY +  Buttons.Settings.Y, Style.spr.Button.ActivatedClosed)
		AdvFontPrint(Style.Font, 238, 100 + (29 * 2), ">  Change editor settings", StyleInfo.FontUp, StyleInfo.FontDown, 1)
	elseif Menu.index == 4 then
		screen:blit(Buttons.HotX + Buttons.Info.X, Buttons.HotY +  Buttons.Info.Y, Style.spr.Button.Activated)
		AdvFontPrint(Style.Font, 238, 100 + (29 * 3), ">  Take a look of credits and app info", StyleInfo.FontUp, StyleInfo.FontDown, 1)
	elseif Menu.index == 5 then
		screen:blit(Buttons.HotX + Buttons.Exit.X, Buttons.HotY +  Buttons.Exit.Y, Style.spr.Button.Activated)
		AdvFontPrint(Style.Font, 238, 100 + (29 * 4), ">  Exit the whole app", StyleInfo.FontUp, StyleInfo.FontDown, 1)
	end

	if pad:cross() then
		if Menu.index == 1 and stt == 0 then
			dofile("PaintCore.lua")
			stt = 10
			--ChangeState("Paint")
		elseif Menu.index == 2 then
			
		elseif Menu.index == 3 then
			
		elseif Menu.index == 4 then
			dofile("Info.lua")
		elseif Menu.index == 5 then
			--ChangeState("Terminate")
			break
		end
	end
	
	if stt ~= 0 then stt = stt - 1 end
	
	AdvFontPrint(Style.Font, 197, 269, Const.AppName.." "..Const.Version.." by "..Const.Author..", Build "..Const.Build.." from "..Const.Date, Col.Red, StyleInfo.FontDown, 1)
	AdvFontPrint(Style.Font, 33, 250, "Welcome, "..Config.Nick, StyleInfo.FontUp, StyleInfo.FontDown, 1)
	
	if pad:select() then TakeScreenshot() end
	
	screen.flip()
	screen.waitVblankStart()
end