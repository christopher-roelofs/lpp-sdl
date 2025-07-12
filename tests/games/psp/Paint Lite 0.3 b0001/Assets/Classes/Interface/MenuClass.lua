MenuPaint = {
	new = function()
		local o = {
			X = nil,
			Y = nil,
			Tex = nil,
			index = nil,
			-- 1 - Resume
			-- 2 - Save
			-- 3 - Exit
			Button = {
				Hotspot = {X = nil, Y = nil},
				Tex = {
					Non = nil,
					Active = nil,
					Checkbox = nil,
					CheckboxActive = nil
				}
			},
			StartTimer = nil,
			MoveTimer = nil,
			-- Latency
			StartLat = nil,
			MoveLat = nil,
			
			SetDefaults = function(self)
				self.X = 156
				self.Y = 79
				self.Tex = Style.spr.Elements.Menu
				self.index = 1
				self.Button.Hotspot.X = 11
				self.Button.Hotspot.Y = 25
				self.Button.Tex.Non = Style.spr.Button.MenuNon
				self.Button.Tex.Active = Style.spr.Button.MenuActive
				self.StartTimer = 0
				self.MoveTimer = 0
				self.StartLat = 10
				self.MoveLat = 6
			end,
			
			InitActions = function(self)
				--[[
				if pad:up() then
					if pressed.up == false then
						pressed.up = true
						if self.index ~= 1 then
							self.index = self.index - 1
						end
					else
						pressed.up = false
					end
				end
				if pad:down() then
					if pressed.down == false then
						pressed.down = true
						if self.index ~= 3 then
							self.index = self.index + 1
						end
					else
						pressed.down = false
					end
				end
				--]]
				
				if self.MoveTimer == 0 then
					if pad:up() then
						if self.index ~= 1 then
							self.index = self.index - 1
						end
						self.MoveTimer = self.MoveLat
					elseif pad:down() then
						if self.index ~= 3 then
							self.index = self.index + 1
						end
						self.MoveTimer = self.MoveLat
					end
				end
				
				if pad:cross() then
					if self.index == 1 then
						P.mState = "Paint"
					elseif self.index == 2 then
						P.mMenuState = "Menu"
						P.mState = "Paint"
						StartScreen()
					elseif self.index == 3 then
						exit = true
					end
				end
				
				if self.MoveTimer ~= 0 then self.MoveTimer = self.MoveTimer - 1 end
				
			end,
			
			InitRender = function(self)
				screen:blit(self.X, self.Y, self.Tex)
				local HotX = self.X + self.Button.Hotspot.X
				local HotY = self.Y + self.Button.Hotspot.Y
				local Text = 15
				
				AdvFontPrint(Style.Font, self.X + 65, self.Y + 18, "Menu", StyleInfo.FontUp, StyleInfo.FontDown, 1)
				
				for i = 1, 3 do
					screen:blit(HotX, HotY + ((i-1) * (6 + 22)), self.Button.Tex.Non)
					if i == self.index then screen:blit(HotX, HotY + ((i-1) * (6 + 22)), self.Button.Tex.Active) end
				end
				
				AdvFontPrint(Style.Font, HotX + 25, HotY + (0 * (6 + 22)) + Text, "Resume", StyleInfo.FontUp, StyleInfo.FontDown, 1)
				AdvFontPrint(Style.Font, HotX + 25, HotY + (1 * (6 + 22)) + Text, "Save Drawing", StyleInfo.FontUp, StyleInfo.FontDown, 1)
				AdvFontPrint(Style.Font, HotX + 25, HotY + (2 * (6 + 22)) + Text, "Exit", StyleInfo.FontUp, StyleInfo.FontDown, 1)
				
			end
			
		}
		return o
	end
}