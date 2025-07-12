--[[

	Main File for Paint Lite 0.3
	----------------------------------
	Controls mState
	
	Create Date: 2020.06.07
	Last Edit: 2020.08.03

--]]

AppRun = true




while AppRun do
	pad = Controls.read()
	
	if G.mState ~= G.mStateOld then
		G.mStateOld = G.mState
		ChangeState(G.mState)
	else
		RunState(G.mState)
	end
	
	--dofile("Menu.lua")
	
	screen.flip()
	screen.waitVblankStart()
	-- swapBuffers()
end

