InfoPan = {
	new = function()
		local o = {
			X = nil,
			Y = nil,
			Tex = nil,
			
			SetDefaults = function(self)
				self.X = 0
				self.Y = 256
				self.Tex = Style.spr.Elements.PanelInfo
			end,
			
			Initialize = function(self)
				self:InitRender()
				self:InitRenderElem("Standart")
			end,
			
			InitRender = function(self)
				screen:blit(self.X, self.Y, self.Tex)
			end,
			
			InitRenderElem = function(self, tar)
				if tar == "Standart" then
					AdvFontPrint(Style.Font, 3, 269, "X: "..math.floor(Me.Cursor.X), StyleInfo.FontUp, StyleInfo.FontDown, 1)
					AdvFontPrint(Style.Font, 45, 269, "Y: "..math.floor(Me.Cursor.Y), StyleInfo.FontUp, StyleInfo.FontDown, 1)
					
					if Me.Cursor.Tool == "Pencil" then
						AdvFontPrint(Style.Font, 90, 269, "[Pen] Size: "..Me.Cursor.Size.Pencil.Cur.."/"..Me.Cursor.Size.Pencil.Max, StyleInfo.FontUp, StyleInfo.FontDown, 1)
					elseif Me.Cursor.Tool == "Brush" or Me.Cursor.Tool == "Eraser" then
						AdvFontPrint(Style.Font, 90, 269, "[Bru/Era] Size: "..Me.Cursor.Size.Brush.Cur.."/"..Me.Cursor.Size.Brush.Max, StyleInfo.FontUp, StyleInfo.FontDown, 1)
					end
				end
			end
			
		}
		return o
	end
}