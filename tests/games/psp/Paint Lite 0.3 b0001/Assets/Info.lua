--[[

	Info File for Paint Lite 0.3
	----------------------------------
	Shows an information about this app
	
	Create Date: 2020.08.02
	Last Edit: 2020.08.09

--]]


while G.Run.Info do
	pad = Controls.read()
	screen:clear(StyleInfo.BackColor)
	
	screen:blit(215, 70, Style.spr.Other.Wires)
	screen:blit(220, 16, Style.spr.Other.Circles)
	screen:blit(0, 5, Style.spr.Other.Logo)
	
	screen:fillRect(22, 54, 160, 2, Col.Black)
	
	Style.Font:setPixelSizes(13, 13)
	AdvFontPrint(Style.Font, 22, 80, "Version: "..Const.Version..", Build: "..Const.Build, StyleInfo.FontUp, StyleInfo.FontDown, 1)
	AdvFontPrint(Style.Font, 22, 100, "Release Build Date: "..Const.Date, StyleInfo.FontUp, StyleInfo.FontDown, 1)
	AdvFontPrint(Style.Font, 22, 120, "By "..Const.Author, StyleInfo.FontUp, StyleInfo.FontDown, 1)
	AdvFontPrint(Style.Font, 22, 140, "Coded on LuaPlayer 0.20", StyleInfo.FontUp, StyleInfo.FontDown, 1)
	Style.Font:setPixelSizes(Const.FontSize, Const.FontSize)
	
	AdvFontPrint(Style.Font, 197, 269, Const.AppName.." "..Const.Version.." by "..Const.Author..", Build "..Const.Build.." from "..Const.Date, Col.Red, StyleInfo.FontDown, 1)
	
	if pad:circle() then break end
	if pad:select() then TakeScreenshot() end
	
	screen.flip()
	screen.waitVblankStart()
end