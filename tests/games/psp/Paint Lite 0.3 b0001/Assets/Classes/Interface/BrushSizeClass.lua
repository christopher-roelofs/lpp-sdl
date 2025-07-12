BrushSize = {
	new = function()
		local o = {
			X = nil,
			Y = nil,
			
			SetDefaults = function(self)
				self.X = 0
				self.Y = 0
			end,
			
		}
		return o
	end
}