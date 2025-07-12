Cursor = {
	new = function()
		local o = {
			X = nil,
			Y = nil,
			W = nil,
			H = nil,
			Hotspot = {X = nil, Y = nil},
			LColor = nil,
			RColor = nil,
			LColorName = nil,
			RColorName = nil,
			CurPal = nil,
			Tex = nil,
			Speed = nil,
			Container = {},
			Tool = nil,
			OldTool = nil,
			PrevTool = nil,
			Trigger = nil,
			MoveMode = nil,
			Timer = {
				pix = {
					Max = nil, -- In game ticks
					Cur = nil,
				}
			},
			Sensity = nil,
			Size = {
				Main = nil,
				
				Pencil = {
					Cur = nil,
					Max = nil
				},
				Brush = {
					Cur = nil,
					Max = nil
				}
			},
			Visible = nil,
			Collision = {
				ColorPalette = nil,
				InfoPanel = nil,
				ToolPanel = nil,
				ParamPanel = nil,
				SpeedPanel = nil
			},
			
			SetDefaults = function(self, TPInfo)
				local TPInfo = TPInfo or "ToolPackInfo"
				self.X = 200
				self.Y = 100
				self.W = TPInfo.Resolution
				self.H = TPInfo.Resolution
				self.Hotspot.X = 4 - TPInfo.Resolution/2
				self.Hotspot.Y = 4 - TPInfo.Resolution/2
				self.LColor = Color.new(255, 255, 255)
				self.RColor = Color.new(0, 0, 0)
				self.LColorName = "White"
				self.RColorName = "Black"
				self.CurPal = 1
				self.Tex = ToolPack.spr.Cursor.Cursor
				self.Speed = 2
				self.Tool = "Pencil"
				self.OldTool = ""
				self.PrevTool = ""
				self.pixTimer = 6
				self.Sensity = 35
				self.MoveMode = "Classic"
				self.Timer.pix.Max = 6
				self.Timer.pix.Cur = 0
				self.Trigger = "R"
				self.Size.Main = 3
				self.Size.Pencil.Cur = 6
				self.Size.Pencil.Max = 25
				self.Size.Brush.Cur = 3
				self.Size.Brush.Max = 7
				self.Visible = true
				self.Collision.ColorPalette = false
				self.Collision.InfoPanel = false
				self.Collision.ToolPanel = false
				self.Collision.ParamPanel = false
				self.Collision.SpeedPanel = false
			end,
			
			CollisionsCheck = function(self, obj)
				-- Color Palette
				if obj == "Color Palette" then
					if self.X < 69 and self.X > 0 and self.Y < 238 and self.Y > 27 then self.Collision.ColorPalette = true else self.Collision.ColorPalette = false end
				end
			end,
			
			Initialize = function(self)
				
			end,
			
			InitTimer = function(self)
				self.Timer.pix.Cur = self.Timer.pix.Cur + 1
			end,
			
			InitRender = function(self, vis)
				if vis then
					screen:blit(self.X+5, self.Y+5, self.Tex)
				end
			end,
			
			ToolCheck = function(self, toolClass)
				if self.OldTool ~= self.Tool then
					self:ChangeIcon(self.Tool)
					if self.OldTool ~= self.PrevTool then self.PrevTool = self.OldTool end
					self.OldTool = self.Tool
					self:ToolPanel(toolClass)
				end
			end,
			
			ToolPanel = function(self, toolClass)
				if self.Tool == "Pencil" then
					toolClass.DrawRect.X = 146
				elseif self.Tool == "Brush" then
					toolClass.DrawRect.X = 164
				elseif self.Tool == "Eraser" then
					toolClass.DrawRect.X = 182
				elseif self.Tool == "FillTool" then
					toolClass.DrawRect.X = 282
				elseif self.Tool == "SquareTool" then
					toolClass.DrawRect.X = 300
				elseif self.Tool == "LineTool" then
					toolClass.DrawRect.X = 318
				end
			end,
			
			Draw = function(self, con, canv, index, sel, color)
				if con == "Square" then
					P.Draw.Square(canv, index, self, sel, color)
				elseif con == "Circle" then
					P.Draw.Circle(canv, index, self, sel, color)
				end
			end,
			
			InitBorders = function(self, type)
				type = type or "Border"
				if type == "Border" then
					if self.X > 480 then self.X = 480 end
					if self.X < 0 then self.X = 0 end
					if self.Y > 272-1 then self.Y = 272-1 end
					if self.Y < 0 then self.Y = 0 end
				elseif type == "Teleport" then
					if self.X > 480 + self.W then self.X = 0 - self.W end
					if self.X + self.W < 0 then self.X = 480 end
					if self.Y > 272 + self.H then self.Y = 0 - self.H end
					if self.Y + self.H < 0 then self.Y = 272 end
				end
			end,
			
			ChangeIcon = function(self, ico)
				if ico == "Cursor" then
					self.Tex = ToolPack.spr.Cursor.Cursor
				elseif ico == "Pencil" then
					self.Tex = ToolPack.spr.Cursor.Pencil
				elseif ico == "Brush" then
					self.Tex = ToolPack.spr.Cursor.Brush
				elseif ico == "Eraser" then
					self.Tex = ToolPack.spr.Cursor.Eraser
				elseif ico == "FillTool" then
					self.Tex = ToolPack.spr.Cursor.FillTool
				elseif ico == "SquareTool" then
					self.Tex = ToolPack.spr.Cursor.SquareTool
				elseif ico == "LineTool" then
					self.Tex = ToolPack.spr.Cursor.LineTool
				end
			end,
			
			InitMove = function(self, sen, dir)
				local dir = dir or "Up"
				if sen == 1 then
					if dir == "Up" then
						self.Y = self.Y - 1
					elseif dir == "Down" then
						self.Y = self.Y + 1
					elseif dir == "Left" then
						self.X = self.X - 1
					elseif dir == "Right" then
						self.X = self.X + 1
					end
					Me.Cursor.Timer.pix.Cur = 0
				else
					dir = nil
					
					local dx = pad:analogX()
					if math.abs(dx) > 32 then
						self.X = self.X + dx / sen
					end
					
					--ANALOG-Y
					local dy = pad:analogY()
					if math.abs(dy) > 32 then
						self.Y = self.Y + dy / sen
					end
				end
			end,
			
			InitTrigger = function(self)
				if pad:r() then
					self.Trigger = "R"
				elseif pad:l() then
					self.Trigger = "L"
				end
			end,
					
			Pixel = function(self, vis)
				if vis then
					screen:fillRect(self.X, self.Y, 1, 1, Col.Black)
				end
			end
			
		}
		return o
	end
}