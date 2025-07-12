ToolPanel = {
	new = function()
		local o = {
			X = nil,
			Y = nil,
			W = nil,
			H = nil,
			Tex = nil,
			DrawRect = {X = nil, Y = nil},
			SelCol = nil,
			
			SetDefaults = function(self)
				self.X = 0
				self.Y = 0
				self.Tex = Style.spr.Elements.PanelTool
				self.W = self.Tex:width()
				self.H = self.Tex:height()
				self.DrawRect = {
					X = 146,
					Y = 2
				}
				self.SelCol = Color.new(255, 255, 0, 100) -- RGBA
			end,
			
			InitRender = function(self)
				screen:blit(self.X, self.Y, self.Tex)
			end,
			
			InitRenderIcons = function(self)
				screen:blit(146, 1, ToolPack.spr.Icon.Pencil)
				screen:blit(146+2+((16)*1), 1, ToolPack.spr.Icon.Brush)
				screen:blit(146+2+2+((16)*2), 1, ToolPack.spr.Icon.Eraser)
				
				screen:blit(282, 1, ToolPack.spr.Icon.FillTool)
				screen:blit(282+2+(16*1), 1, ToolPack.spr.Icon.SquareTool)
				screen:blit(282+2+2+(16*2), 1, ToolPack.spr.Icon.LineTool)
			end,
			
			InitRenderColors = function(self, cur)
				screen:fillRect(92, 4, 17, 17, cur.LColor)
				screen:fillRect(371, 4, 17, 17, cur.RColor)
			end,
			
			InitRenderSelection = function(self)
				screen:fillRect(self.DrawRect.X, self.DrawRect.Y, 16, 16, self.SelCol)
			end,
			
			InitActions = function(self, cur)
				if cur.Y > 2 and cur.Y < 2+16 then
					if cur.X > 145 and cur.X < 145+16 then
						cur.Tool = "Pencil"
						--self.DrawRect.X = 146
						--cur:ToolCheck()
					elseif cur.X > 145+2+16 and cur.X < 145+2+(16*2) then
						cur.Tool = "Brush"
						--self.DrawRect.X = 164
						--cur:ToolCheck()
					elseif cur.X > 145+((16+2)*2) and cur.X < 145+((16+2)*3) then
						cur.Tool = "Eraser"
						--self.DrawRect.X = 182
						--cur:ToolCheck()
					end
					
					if cur.X > 281 and cur.X < 281+16 then
						cur.Tool = "FillTool"
						--self.DrawRect.X = 282
						--cur:ToolCheck()
					elseif cur.X > 281+2+16 and cur.X < 281+2+(16*2) then
						cur.Tool = "SquareTool"
						--self.DrawRect.X = 300
						--cur:ToolCheck()
					elseif cur.X > 281+((16+2)*2) and cur.X < 281+((16+2)*3) then
						cur.Tool = "LineTool"
						--self.DrawRect.X = 318
						--cur:ToolCheck()
					end
				end
			end
			
		}
		return o
	end
}