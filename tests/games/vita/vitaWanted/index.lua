tmr = Timer.new()
time_left = 20
game_over = true
bgm = true
idx = 1
Sound.init()
clap = Sound.openOgg("app0:/sfx/clap.ogg")
boo = Sound.openOgg("app0:/sfx/boo.ogg")
bgm_file = Sound.openOgg("app0:/sfx/bgm.ogg")
Sound.play(bgm_file, LOOP)
f1 = Graphics.loadImage("app0:/faces/face1.png")
f2 = Graphics.loadImage("app0:/faces/face2.png")
f3 = Graphics.loadImage("app0:/faces/face3.png")
f4 = Graphics.loadImage("app0:/faces/face4.png")
w = Graphics.loadImage("app0:/faces/wanted.png")
faces = {f1, f2, f3, f4}
face_width = 60
face_height = 55
voices = {"Start new game","BGM: On","Exit Game"}
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
	winner_x = math.random(0, 800) - 10
	winner_y = math.random(0, 544) - 10
	
	num_faces = stage * 4
	i = 1
	while i <= num_faces do
		face_id = math.random(1, 4)
		while face_id == winner_id do
			face_id = math.random(1, 4)
		end
		face_x = math.random(0, 800) - 10
		face_y = math.random(0, 544) - 10
		table.insert(wrong_faces, {["id"] = face_id, ["x"] = face_x, ["y"] = face_y})
		i = i + 1
	end
end

while true do
	pad = Controls.read()
	-- Main menu
	if game_over then
		Graphics.initBlend()
		Screen.clear()
		Graphics.debugPrint(5, 5, "vitaWanted v.1.3", red)
		for i, voice in pairs(voices) do
			if i == idx then
				color = red
				x = 10
			else
				color = white
				x = 5
			end
			Graphics.debugPrint(x, 50 + 20 * i, voice, color)
		end
		if Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS) then
			if idx == 1 then -- Start new game
				game_over = false
				found = false
				tmr = Timer.new()
				game_started = false
				lv = 1
				SetGame(lv)
			elseif idx == 2 then
				bgm = not bgm
				if bgm then
					Sound.resume(bgm_file)
					voices[2] = "BGM: On"
				else
					Sound.pause(bgm_file)
					voices[2] = "BGM: Off"
				end
			elseif idx == 3 then -- Exit Game
				for i, face in pairs(faces) do
					Graphics.freeImage(face)
				end
				Graphics.freeImage(w)
				Sound.close(clap)
				Sound.close(bgm_file)
				Sound.close(boo)
				Sound.term()
				Graphics.term()
				System.exit()
			end
		elseif Controls.check(pad, SCE_CTRL_UP) and not Controls.check(oldpad, SCE_CTRL_UP) then
			idx = idx - 1
			if idx == 0 then
				idx = #voices
			end
		elseif Controls.check(pad, SCE_CTRL_DOWN) and not Controls.check(oldpad, SCE_CTRL_DOWN) then
			idx = idx + 1
			if idx > #voices then
				idx = 1
			end
		end
		Graphics.termBlend()
		Screen.flip()
	else
		-- Game
		if game_started then
			if Timer.getTime(tmr) > (time_left * 1000) and not found then
				game_over = true
				Timer.destroy(tmr)
				to_confirm = true
				while to_confirm do
					Graphics.initBlend()
					Screen.clear()
					Graphics.drawImage(850, 200, w)
					Graphics.drawImage(870, 250, faces[winner_id])
					Graphics.drawScaleImage(winner_x, winner_y, 1.5, 1.5, faces[winner_id])
					Graphics.debugPrint(120,50,"Game Over!", red)
					Graphics.debugPrint(130,90,"Score: " .. (lv - 1), white)
					Graphics.debugPrint(75,110,"Press X to return menu", white)
					pad = Controls.read()
					if Controls.check(pad, SCE_CTRL_CROSS) then
						game_started = false
						time_left = 30
						game_over = true
						to_confirm = false
					end
					Graphics.termBlend()
					Screen.flip()
				end
				Graphics.initBlend()
			elseif found then
				Graphics.initBlend()
				Screen.clear()
				Graphics.drawImage(850, 200, w)
				Graphics.drawImage(870, 250, faces[winner_id])
				Graphics.drawScaleImage(winner_x, winner_y, 1.5, 1.5, faces[winner_id])
				if Timer.getTime(tmr) > 3000 then
					SetGame(lv)
					Timer.reset(tmr)
					game_started = false
					found = false
				end
			else
				Graphics.initBlend()
				Screen.clear()
				Graphics.drawImage(850, 200, w)
				Graphics.drawImage(870, 250, faces[winner_id])
				x, y = Controls.readTouch()
				if (not (x == nil)) and (old_x == nil) then		
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
				elseif Controls.check(pad, SCE_CTRL_START) then
					game_started = false
					time_left = 30
					game_over = true
				end
				Graphics.drawImage(winner_x, winner_y, faces[winner_id])
				for i, wrong in pairs(wrong_faces) do
					Graphics.drawImage(wrong.x, wrong.y, faces[wrong.id])
				end
				if time_left - (Timer.getTime(tmr) / 1000) < 0 then
					Graphics.debugPrint(920,500, "0", white)
				else
					Graphics.debugPrint(920,500, math.ceil(time_left - (Timer.getTime(tmr) / 1000)), white)
				end
				if not game_started then
					Timer.destroy(tmr)
				end
			end
			Graphics.debugPrint(850, 100, "Score: " .. (lv - 1), white)
			Graphics.termBlend()
			Screen.flip()
		else
			Graphics.initBlend()
			Screen.clear()
			if Timer.getTime(tmr) < 3000 then
				Graphics.debugPrint(300, 270, "You must find...", Color.new(255, 255, 255))
			else
				Timer.reset(tmr)
				game_started = true
			end
			Graphics.termBlend()
			Screen.flip()
		end
		
	end
	oldpad = pad
	old_x = x
end