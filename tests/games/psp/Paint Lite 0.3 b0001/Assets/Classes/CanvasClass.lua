Canvas = {
	new = function()
		local o = {
			X = nil,
			Y = nil,
			Width = nil,
			Height = nil,
			StartColor = nil,
			Tex = nil,
			Layer = {},
			
			SetDefaults = function(self)
				self.X = 0
				self.Y = 0
				self.Width = 480
				self.Height = 272
				self.StartColor = Color.new(255,255,255)
				self.Tex = nil
				self.Layer[1] = {
					Name = "Main",
					Width = 480,
					Height = 272,
					Transparency = 0,
					Visible = true,
					Tex = Image.load("Resources/Alpha.png")
				}
			end,
			
			--[[
			Layer = {
				Visibility = function(self, layer, visibility)
					self.layer.Visible = visibility
				end
			},
			--]]
			
			InitRender = function(self, index)
				screen:blit(self.X, self.Y, self.Layer[index].Tex)
			end,
			
			-- Still in progress (I'll try to make this feature after 0.3)
			SaveProject = function(self, Name)
				local Name = Name or "Paint Lite Project"
				local Date = "nil"
				local Count = 0
				local Discription = "A Paint Lite Project File"
				
				Project = io.open("Project/"..Name..Const.PrjFormat, "w")
				
				Project:write("Prj = {\n")
				Project:write("	Name = "..Name..",\n")
				Project:write("	Date = "..Date..",\n")
				Project:write("	Discription = "..Dicription..",\n'n")
				Project:write("Layer = {}")
				Project:write("Layer[1] = {")
				for x = 1, self.Width do
					for y = 1, self.Height do
						pix = pixel(x, y)
						Project:write("{"..pix.r..", "..pix.g..", "..pix.b.."}")
					end
				end
				Project:write("}\n")
				Project:write("}")
				Project:close()
			end,
			
			LoadProject = function(self, Name)
				dofile("Project/"..Name..Const.PrjFormat)
			end
			
		}
		return o
	end
}