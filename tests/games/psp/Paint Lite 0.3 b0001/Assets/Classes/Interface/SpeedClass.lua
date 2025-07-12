Speed = {
	new = function()
		local o = {
			WorkX = nil,
			WorkY = nil,
			PaintX = nil,
			PaintY = nil,
			WorkHotspot = {X = nil, Y = nil},
			PaintHotspot = {X = nil, Y = nil},
			Timer = { Apply = nil, Running = nil, Add = nil, Max = nil, Cur = nil },
			Speeds = {},
			
			SetDefaults = function(self)
				self.WorkX = 92
				self.WorkY = 84
				self.PaintX = 7
				self.PaintY = 84
				self.WorkHotspot.X = 99
				self.WorkHotspot.Y = 91
				self.PaintHotspot.X = 14
				self.PaintHotspot.Y = 91
				self.Timer = {
					Apply = false,
					Running = false,
					Add = 1,
					Max = 35,
					Cur = 0
				}
				
				self.Speeds[1] = 15 -- LB
				self.Speeds[2] = 25 -- LB
				self.Speeds[3] = 50 -- N
				self.Speeds[4] = 75 -- N
				self.Speeds[5] = 100 -- N
				self.Speeds[6] = 150 -- R
				self.Speeds[7] = 250 -- R
				self.Speeds[8] = 350 -- R
				self.Speeds[9] = 500 -- DR
				self.Speeds[10] = 600 -- DR
			end,
			
			-- Adding some numbers
			InitAction = function(self, cur)
				if pad:down() then
					if cur.Speed ~= 1 then
						cur.Speed = cur.Speed - 1
					else
						--cur.Speed = 10
					end
				end
				
				if pad:up() then
					if cur.Speed ~= 10 then
						cur.Speed = cur.Speed + 1
					else
						--cur.Speed = 1
					end
				end
			end,
			
			-- Rendering Panel, Indicators
			InitRender = function(self, cur, state)
				if state == "Paint" then b = false elseif state == "Workspace" then b = true else b = false end
				if self.Timer.Apply or b then
					
					local x = nil
					local y = nil
					local HotX = nil
					local HotY = nil
					local Xfor10 = nil
					local Indicator = nil
					if cur.Speed == 10 then Xfor10 = -3 else Xfor10 = 1 end
					
					if state == "Paint" then
						x = self.PaintX
						y = self.PaintY
						HotX = self.PaintHotspot.X
						HotY = self.PaintHotspot.Y
					elseif state == "Workspace" then
						x = self.WorkX
						y = self.WorkY
						HotX = self.WorkHotspot.X
						HotY = self.WorkHotspot.Y
					else
						x = self.PaintX
						y = self.PaintY
						HotX = self.PaintHotspot.X
						HotY = self.PaintHotspot.Y
					end
					
					-- Speed Panel
					screen:blit(x, y, Style.spr.Elements.PanelSpeed)
					
					-- Speed Indicator Picture
					for i = 0, 9 do
						--local j = i+1 -- Reversed j
						local j = 10 - (i) -- Normal j
						if cur.Speed >= j then
							
							if j == 10 or j == 9 or j == 8 then
								Indicator = Style.spr.Speed.DeepRed
							elseif j == 7 or j == 6 then
								Indicator = Style.spr.Speed.Red
							elseif j == 5 or j == 4 or j == 3 then
								Indicator = Style.spr.Speed.Yellow
							elseif j == 2 or j == 1 then
								Indicator = Style.spr.Speed.LightBlue
							end
							
							screen:blit(HotX, HotY + (6*i), Indicator)
						end
					end
					
					-- Speed Indicator (a Text)
					screen:print(x + 14 + Xfor10, y + 72, cur.Speed, Col.Black)
				end
			end,
			
			ApplySpeed = function(self, cur)
				cur.Sensity = self.Speeds[cur.Speed]
			end,
			
			-- Where everything starts
			Initialize = function(self, cur, state)
				if state == "Paint" then
					self:fTimerInit()
				elseif state == "Workspace" then
					self:fTimerReset()
				end
				self:InitRender(cur, state)
			end,
			
			-- This is a timer work: "Initialization", "Run" and "Reset"
			--fTimer = {
				fTimerInit = function(self)
					if self.Timer.Running then
						if self.Timer.Cur <= self.Timer.Max then
							self.Timer.Cur = self.Timer.Cur + self.Timer.Add
							self.Timer.Apply = true
						else
							self.Timer.Cur = 0
							self.Timer.Apply = false
							self.Timer.Running = false
						end
					end
				end,
				
				fTimerRun = function(self)
					self.Timer.Running = true
				end,
				
				fTimerReset = function(self)
					self.Timer.Cur = 0
					self.Timer.Apply = false
				end,
			--},
			
			-- Coordinates changer
			ChangePosition = function(self, pos)
				if pos == "Left" then
					self.PaintX = 7
					self.PaintY = 84
					self.PaintHotspot.X = 14
					self.PaintHotspot.Y = 91
				elseif pos == "Right" then
					self.PaintX = 438
					self.PaintY = 84
					self.PaintHotspot.X = 445
					self.PaintHotspot.Y = 91
				end
			end
			
		}
		return o
	end
}