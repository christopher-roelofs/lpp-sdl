red = Color.new(255,0,0)
green = Color.new(0,255,0)
blue = Color.new(0,0,255)
white = Color.new(255,255,255)
black = Color.new(0,0,0)
i = 0
points = 0
level = 1
menu_index = 1
state = "menu"
oldpad = Controls.read()
menu = {}
loader = true
while true do
	Screen.waitVblankStart()
	Screen.refresh()
	Controls.init()
	pad = Controls.read()
	if (state == "menu") then
		Screen.clear(TOP_SCREEN)
		Screen.clear(BOTTOM_SCREEN)
		z = 0
		while (z <= menu_index) do
		menu[z] = white
		z = z + 1
		end
		menu[i] = red
		if (Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A)) then
			if (i==0) then
				state = "game"
				loader = true
				level = 1
				points = 0
			elseif (i==1) then
				System.exit()
			end
		elseif (Controls.check(pad,KEY_DUP) and not Controls.check(oldpad,KEY_DUP)) then
			i = i - 1
		elseif (Controls.check(pad,KEY_DDOWN) and not Controls.check(oldpad,KEY_DDOWN)) then
			i = i + 1
		end
		if (i<0) then
			i = 1
		elseif (i>menu_index) then
			i = 0
		end
		Screen.debugPrint(0,0,"PixelRoad v.1.0",red,TOP_SCREEN)
		Screen.debugPrint(0,40,"Start new game",menu[0],TOP_SCREEN)
		Screen.debugPrint(0,54,"Exit game",menu[1],TOP_SCREEN)
		Screen.debugPrint(0,0,"Take control of a pixel through",white,BOTTOM_SCREEN)
		Screen.debugPrint(0,14,"touchscreen. Guide it from",white,BOTTOM_SCREEN)
		Screen.debugPrint(0,28,"green zone to blue zone.",white,BOTTOM_SCREEN)
	elseif (state == "game") then
		Screen.clear(TOP_SCREEN)
		Screen.clear(BOTTOM_SCREEN)
		if (loader) then
		track = Screen.loadBitmap(System.currentDirectory().."/levels/"..level..".bmp")
		loader = false
		minutes = 0
		seconds = 0
		hundreds = points
		while (hundreds > 100) do
		hundreds = hundreds - 100
		seconds = seconds + 1
		end
		while (seconds > 60) do
		seconds = seconds - 60
		minutes = minutes + 1
		end
		formatted_seconds = seconds
		if (seconds < 10) then
		formatted_seconds = "0" .. seconds
		end
		formatted_minutes = minutes
		if (minutes < 10) then
		formatted_seconds = "0" .. minutes
		end
		formatted_hundreds = hundreds
		if (hundreds < 10) then
		formatted_hundreds = "0" .. hundreds
		end
		formatted_time = formatted_minutes .. ":" .. formatted_seconds .. ":" .. formatted_hundreds
		end
		Screen.drawImage(0,0,track,BOTTOM_SCREEN)
		Screen.debugPrint(0,5,"Press Start to return to main menu",red,TOP_SCREEN)
		Screen.debugPrint(0,19,"Total Time: " .. formatted_time,red,TOP_SCREEN)
		if (Controls.check(pad,KEY_START) and not Controls.check(oldpad,KEY_START)) then
			state = "menu"
			Screen.clear(TOP_SCREEN)
			Screen.clear(BOTTOM_SCREEN)
		elseif (Controls.check(pad,KEY_TOUCH) and not Controls.check(oldpad,KEY_TOUCH)) then
			x,y = Controls.readTouch()
			if (Screen.getPixel(x,y,track) == green) then
				counter = Timer.new()
				while ((Controls.check(pad,KEY_TOUCH)) and ((Screen.getPixel(x,y,track) == green) or (Screen.getPixel(x,y,track) == white))) do
				Controls.init()
				pad = Controls.read()
				x,y = Controls.readTouch()
				Screen.waitVblankStart()
				Screen.refresh()
				Screen.clear(BOTTOM_SCREEN)
				Screen.drawImage(0,0,track,BOTTOM_SCREEN)
				Screen.drawPixel(x,y,red,BOTTOM_SCREEN)
				Screen.flip()
				end
				if (Controls.check(pad,KEY_TOUCH)) then
					if (Screen.getPixel(x,y,track) == blue) then
						not_timed = true
						state = "win"
					else
						not_timed = true
						state = "lose"
					end
				else
				not_timed = true
				state = "lose"
				end
			end
		end		
	elseif (state == "win") then
		if (not_timed) then
		time_f = (Timer.getTime(counter)) / 10
		minutes = 0
		seconds = 0
		hundreds = math.ceil(time_f)
		points = points + hundreds
		not_timed = false
		end
		while (hundreds > 100) do
		hundreds = hundreds - 100
		seconds = seconds + 1
		end
		while (seconds > 60) do
		seconds = seconds - 60
		minutes = minutes + 1
		end
		formatted_seconds = seconds
		if (seconds < 10) then
		formatted_seconds = "0" .. seconds
		end
		formatted_minutes = minutes
		if (minutes < 10) then
		formatted_minutes = "0" .. minutes
		end
		formatted_hundreds = hundreds
		if (hundreds < 10) then
		formatted_hundreds = "0" .. hundreds
		end
		formatted_time = formatted_minutes .. ":" .. formatted_seconds .. ":" .. formatted_hundreds
		points = time_f
		Screen.fillEmptyRect(10,250,150,210,red,BOTTOM_SCREEN)
		Screen.fillRect(11,249,151,209,black,BOTTOM_SCREEN)
		Screen.debugPrint(11,153,"Level "..level.." completed!",white,BOTTOM_SCREEN)
		Screen.debugPrint(11,167,"Time: " .. formatted_time,white,BOTTOM_SCREEN)
		Screen.debugPrint(11,181,"Press A to proceed",white,BOTTOM_SCREEN)
		Screen.debugPrint(11,196,"Press B to take screenshot",white,BOTTOM_SCREEN)
		if (Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A)) then
			level = level + 1
			if (System.doesFileExist(System.currentDirectory().."/levels/"..level..".bmp")) then
			state = "game"
			loader = true
			not_timed = true
			else
			state = "gameover"
			end
		end
		if (Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B)) then
			System.takeScreenshot("/pixelroad_win_lv"..level..".bmp")
		end
	elseif (state == "gameover") then
		Screen.fillEmptyRect(10,250,150,210,red,BOTTOM_SCREEN)
		Screen.fillRect(11,249,151,209,black,BOTTOM_SCREEN)
		if (not_timed) then
		minutes = 0
		seconds = 0
		hundreds = points
		not_timed = false
		while (hundreds > 100) do
		hundreds = hundreds - 100
		seconds = seconds + 1
		end
		while (seconds > 60) do
		seconds = seconds - 60
		minutes = minutes + 1
		end
		formatted_seconds = seconds
		if (seconds < 10) then
		formatted_seconds = "0" .. seconds
		end
		formatted_minutes = minutes
		if (minutes < 10) then
		formatted_seconds = "0" .. minutes
		end
		formatted_hundreds = hundreds
		if (hundreds < 10) then
		formatted_hundreds = "0" .. hundreds
		end
		formatted_time = formatted_minutes .. ":" .. formatted_seconds .. ":" .. formatted_hundreds
		end
		Screen.debugPrint(11,153,"You beated the game!",white,BOTTOM_SCREEN)
		Screen.debugPrint(11,167,"Total Time: " .. formatted_time,white,BOTTOM_SCREEN)
		Screen.debugPrint(11,181,"Press A to return menu",white,BOTTOM_SCREEN)
		Screen.debugPrint(11,196,"Press B to take screenshot",white,BOTTOM_SCREEN)
		if (Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A)) then
			state = "menu"
		end
		if (Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B)) then
			System.takeScreenshot("/pixelroad_end.bmp")
		end
	elseif (state == "lose") then
		Screen.fillEmptyRect(10,250,150,210,red,BOTTOM_SCREEN)
		Screen.fillRect(11,249,151,209,black,BOTTOM_SCREEN)
		Screen.debugPrint(11,153,"You lose...",white,BOTTOM_SCREEN)
		if (not_timed) then
		minutes = 0
		seconds = 0
		hundreds = points
		not_timed = false
		while (hundreds > 100) do
		hundreds = hundreds - 100
		seconds = seconds + 1
		end
		while (seconds > 60) do
		seconds = seconds - 60
		minutes = minutes + 1
		end
		formatted_seconds = seconds
		if (seconds < 10) then
		formatted_seconds = "0" .. seconds
		end
		formatted_minutes = minutes
		if (minutes < 10) then
		formatted_seconds = "0" .. minutes
		end
		formatted_hundreds = hundreds
		if (hundreds < 10) then
		formatted_hundreds = "0" .. hundreds
		end
		formatted_time = formatted_minutes .. ":" .. formatted_seconds .. ":" .. formatted_hundreds
		end
		Screen.debugPrint(11,167,"Total Time: " .. formatted_time,white,BOTTOM_SCREEN)
		Screen.debugPrint(11,181,"Press A to return menu",white,BOTTOM_SCREEN)
		Screen.debugPrint(11,196,"Press B to take screenshot",white,BOTTOM_SCREEN)
		if (Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A)) then
			state = "menu"
		end
		if (Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B)) then
			System.takeScreenshot("/pixelroad_lose_lv"..level..".bmp")
		end
	end
	Screen.flip()
	oldpad = pad
end