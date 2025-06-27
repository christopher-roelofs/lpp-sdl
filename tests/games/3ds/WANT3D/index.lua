tmr = Timer.new()
time_left = 20
game_over = true
idx = 1
Graphics.init()
Sound.init()
clap = Sound.openOgg(System.currentDirectory().."/sfx/clap.ogg", false)
boo = Sound.openOgg(System.currentDirectory().."/sfx/boo.ogg", false)
f1 = Graphics.loadImage(System.currentDirectory().."/faces/face1.png")
f2 = Graphics.loadImage(System.currentDirectory().."/faces/face2.png")
f3 = Graphics.loadImage(System.currentDirectory().."/faces/face3.png")
f4 = Graphics.loadImage(System.currentDirectory().."/faces/face4.png")
w = Graphics.loadImage(System.currentDirectory().."/faces/wanted.png")
faces = {f1, f2, f3, f4}
face_width = 30
face_height = 27
voices = {"Start new game","Exit Game"}
red = Color.new(255, 0, 0)
white = Color.new(255, 255, 255)
yellow = Color.new(255, 255, 0)
oldpad = 0 -- Prevents interpreter error on startup
wrong_faces = {}
function SetGame(stage)
	wrong_faces = {}
	h, m, s = System.getTime()
	math.randomseed(h*3600+m*60+s)
	winner_id = math.random(1, 4)
	winner_x = math.random(0, 320) - 5
	winner_y = math.random(0, 240) - 5
	
	num_faces = stage * 4
	i = 1
	while i <= num_faces do
		face_id = math.random(1, 4)
		while face_id == winner_id do
			face_id = math.random(1, 4)
		end
		face_x = math.random(0, 320) - 5
		face_y = math.random(0, 240) - 5
		table.insert(wrong_faces, {["id"] = face_id, ["x"] = face_x, ["y"] = face_y})
		i = i + 1
	end
end

while true do
	Screen.refresh()
	Screen.clear(TOP_SCREEN)
	Screen.clear(BOTTOM_SCREEN)
	pad = Controls.read()
	-- Main menu
	if game_over then
		Screen.debugPrint(5, 5, "WANT3D v.1.2", red, TOP_SCREEN)
		for i, voice in pairs(voices) do
			if i == idx then
				color = red
				x = 10
			else
				color = white
				x = 5
			end
			Screen.debugPrint(x, 50 + 15 * i, voice, color, TOP_SCREEN)
		end
		if Controls.check(pad, KEY_A) and not Controls.check(oldpad, KEY_A) then
			if idx == 1 then -- Start new game
				game_over = false
				found = false
				tmr = Timer.new()
				game_started = false
				lv = 1
				SetGame(lv)
			elseif idx == 2 then -- Exit Game
				for i, face in pairs(faces) do
					Graphics.freeImage(face)
				end
				Graphics.freeImage(w)
				Sound.close(clap)
				Sound.close(boo)
				Sound.term()
				Graphics.term()
				System.exit()
			end
		elseif Controls.check(pad, KEY_DUP) and not Controls.check(oldpad, KEY_DUP) then
			idx = idx - 1
			if idx == 0 then
				idx = #voices
			end
		elseif Controls.check(pad, KEY_DDOWN) and not Controls.check(oldpad, KEY_DDOWN) then
			idx = idx + 1
			if idx > #voices then
				idx = 1
			end
		end
	else
		-- Game
		if game_started then
			if Timer.getTime(tmr) > (time_left * 1000) and not found then
				game_over = true
				Timer.destroy(tmr)
				to_confirm = true
				while to_confirm do
					Screen.refresh()
					Screen.clear(TOP_SCREEN)
					Screen.clear(BOTTOM_SCREEN)
					Graphics.initBlend(BOTTOM_SCREEN)
					Graphics.drawImage(winner_x, winner_y, faces[winner_id])
					Graphics.termBlend()
					Screen.debugPrint(120,50,"Game Over!", red, TOP_SCREEN)
					Screen.debugPrint(130,80,"Score: " .. (lv - 1), white, TOP_SCREEN)
					Screen.debugPrint(75,95,"Press A to return menu", white, TOP_SCREEN)
					pad = Controls.read()
					if Controls.check(pad, KEY_A) then
						game_started = false
						time_left = 30
						game_over = true
						to_confirm = false
					end
					Screen.flip()
					Screen.waitVblankStart()
				end
			elseif found then
				Graphics.initBlend(BOTTOM_SCREEN)
				Graphics.drawImage(winner_x, winner_y, faces[winner_id])
				Graphics.termBlend()
				if Timer.getTime(tmr) > 3000 then
					SetGame(lv)
					Timer.reset(tmr)
					game_started = false
					found = false
				end
			else
				if Controls.check(pad, KEY_TOUCH) and not Controls.check(oldpad, KEY_TOUCH) then
					x, y = Controls.readTouch()
					if x > winner_x and x < winner_x + face_width and y > winner_y and y < winner_y + face_height then
						time_left = math.ceil(time_left + 5 - (Timer.getTime(tmr) / 1000))
						Timer.reset(tmr)
						found = true
						lv = lv + 1
						Sound.play(clap, NO_LOOP)
					else
						time_left = time_left - 3
						Sound.play(boo, NO_LOOP)
					end
				elseif Controls.check(pad, KEY_START) then
					game_started = false
					time_left = 30
					game_over = true
				end
				Graphics.initBlend(TOP_SCREEN)
				Graphics.drawImage(150, 25, w)
				Graphics.drawImage(170, 75, faces[winner_id])
				Graphics.termBlend()
				Graphics.initBlend(BOTTOM_SCREEN)
				Graphics.drawScaleImage(winner_x, winner_y, faces[winner_id], 0.5, 0.5)
				for i, wrong in pairs(wrong_faces) do
					Graphics.drawScaleImage(wrong.x, wrong.y, faces[wrong.id], 0.5, 0.5)
				end
				Graphics.termBlend()
				if time_left - (Timer.getTime(tmr) / 1000) < 0 then
					Screen.debugPrint(190,200, "0", white, TOP_SCREEN)
				else
					Screen.debugPrint(190,200, math.ceil(time_left - (Timer.getTime(tmr) / 1000)), white, TOP_SCREEN)
				end
				if not game_started then
					Timer.destroy(tmr)
				end
			end
			Screen.debugPrint(2, 223, "Score: " .. (lv - 1), white, TOP_SCREEN)
		else
			if Timer.getTime(tmr) < 3000 then
				Screen.debugPrint(120, 150, "You must find...", Color.new(255, 255, 255), TOP_SCREEN)
			else
				Timer.reset(tmr)
				game_started = true
			end
		end
		
	end

	Screen.flip()
	Screen.waitVblankStart()
	oldpad = pad
end