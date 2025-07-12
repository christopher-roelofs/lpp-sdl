ColorPalette = {
	new = function()
		local o = {
			X = nil,
			Y = nil,
			W = nil,
			H = nil,
			Tex = nil,
			Hotspot = { X = nil, Y = nil },
			Max = {
				X = nil,
				Y = nil,
				Size = nil,
				FreeSpc = nil
			}, 
			Palette = {},
			
			SetDefaults = function(self)
				self.X = 0
				self.Y = 0
				self.Tex = Style.spr.Elements.PanelColor
				self.W = self.Tex:width()
				self.H = self.Tex:height()
				self.Hotspot = { X = 3, Y = 33 }
				self.Max = {
					X = 5,
					Y = 12,
					Size = 10,
					FreeSpc = 3
				}
				self.Palette[1] = {}
				self.Palette[2] = {}
				self.Palette[3] = {}
				
				for i = 1, 3 do
					self.Palette[i] = {}
					
					for a = 1, self.Max.X do
						self.Palette[i][a] = {}
						for b = 1, self.Max.Y do
							if i == 1 then
								self.Palette[i][a][b] = {Name = "Defgen", Color = Color.new(255, 0, 0)}
							elseif i == 2 then
								self.Palette[i][a][b] = {Name = "Defgen", Color = Color.new(0, 255, 0)}
							elseif i == 3 then
								self.Palette[i][a][b] = {Name = "Defgen", Color = Color.new(0, 0, 255)}
							end
						end
					end
				end
			end,
			
			-- LoadPalette = function(self, palID)
				-- P.Pal(self, palID)
			-- end,
			
			InitRender = function(self)
				screen:blit(self.X, self.Y, self.Tex)
			end,
			
			InitRenderColors = function(self, palID)
				for i = 1, self.Max.X do
					for j = 1, self.Max.Y do
						screen:fillRect(self.Hotspot.X + ((i-1) * (self.Max.Size + self.Max.FreeSpc)),       self.Hotspot.Y + ((j-1) * (self.Max.Size + self.Max.FreeSpc)),       self.Max.Size, self.Max.Size, self.Palette[palID][i][j].Color)
					end
				end
			end,
			
			InitRenderInfo = function(self, palID, cur, two)
				if two == "R" then
					AdvFontPrint(Style.Font, 2, 202, cur.RColorName, StyleInfo.FontUp, StyleInfo.FontDown, 1)
				elseif two == "L" then
					AdvFontPrint(Style.Font, 2, 202, cur.LColorName, StyleInfo.FontUp, StyleInfo.FontDown, 1)
				end
				AdvFontPrint(Style.Font, 22, 216, palID.." / 3", StyleInfo.FontUp, StyleInfo.FontDown, 1)
			end,
			
			InitActions = function(self, palID, cur, two)
				
				local xmod = -20
				local ymod = -20
				
				-- Take Color
				for i = 1, self.Max.X do
					for j = 1, self.Max.Y do
						if cur.X > xmod + self.Hotspot.X + i * (self.Max.Size + self.Max.FreeSpc) and cur.X < xmod + self.Hotspot.X + self.Max.Size + i * (self.Max.Size + self.Max.FreeSpc) then
							if cur.Y > ymod + self.Hotspot.Y + j * (self.Max.Size + self.Max.FreeSpc) and cur.Y < ymod + self.Hotspot.Y + self.Max.Size + j * (self.Max.Size + self.Max.FreeSpc) then
								if two == "R" then
									cur.RColor = self.Palette[palID][i][j].Color
									cur.RColorName = self.Palette[palID][i][j].Name
								elseif two == "L" then
									cur.LColor = self.Palette[palID][i][j].Color
									cur.LColorName = self.Palette[palID][i][j].Name
								end
							end
						end
					end
				end
			end
			
		}
		return o
	end
}