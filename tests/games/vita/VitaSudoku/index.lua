-- Init resources
white = Color.new(255,255,255)
red = Color.new(255,0,0)
black = Color.new(0,0,0)
yellow = Color.new(255,255,128)
green = Color.new(128,255,128)
cyan = Color.new(128,255,255)
won = false

-- Additional BGM support
bgm_queue = {}
bgms = System.listDirectory("data/VitaSudoku")
for i, file in pairs(bgms) do
	if string.upper(string.sub(file.name,-4)) == ".MP3" then
		table.insert(bgm_queue, {file.name,1})
	elseif string.upper(string.sub(file.name,-4)) == ".MID" then
		table.insert(bgm_queue, {file.name,2})
	elseif string.upper(string.sub(file.name,-4)) == ".OGG" then
		table.insert(bgm_queue, {file.name,3})
	end
end

function playMusic(name, mode)
	if (not (snd == nil)) then
		Sound.close(snd)
	end
	if mode == 1 then
		snd = Sound.openMp3("data/VitaSudoku/" .. name)
	elseif mode == 2 then
		snd = Sound.openMidi("data/VitaSudoku/" .. name)
	else
		snd = Sound.openOgg("data/VitaSudoku/" .. name)
	end
	Sound.play(snd, NO_LOOP)
end

function dequeueMusic()
	bgm_idx = bgm_idx + 1
	if bgm_idx > #bgm_queue then
		bgm_idx = 1
	end
	playMusic(bgm_queue[bgm_idx][1],bgm_queue[bgm_idx][2])
end

-- Initializing audio
soundSystem = false
if #bgm_queue > 0 then
	soundSystem = true
	Sound.init()
	bgm_idx = 0
	dequeueMusic()
	tmr = Timer.new()
	alpha = 255
end

-- fillEmptyRect implementation
function Graphics.fillEmptyRect(x1,x2,y1,y2,color)
	Graphics.drawLine(x1,x1,y1,y2,color)
	Graphics.drawLine(x1,x2,y1,y1,color)
	Graphics.drawLine(x2,x2,y1,y2,color)
	Graphics.drawLine(x1,x2,y2,y2,color)
end

function GetMaxCoord(l)
	if l <= 3 then
		return 3
	elseif l <= 6 then
		return 6
	else
		return 9
	end
end

function CheckLine(n,l,m)
	for i=1,9 do
		if m[l][i] == n then
			return false
		end
	end
	return true
end

function CheckColumn(n,l,m)
	for i=1,9 do
		if m[i][l] == n then
			return false
		end
	end
	return true
end

function CheckSquare(n,l,c,m)
	my_nums = {}
	for i=(l-2),l do
		for j=(c-2),c do
			table.insert(my_nums,m[i][j])
		end
	end
	for i=1,9 do
		if my_nums[i] == n then
			return false
		end
	end
	return true
end

function AvailableNumbers(l,c,m)
	square_l = GetMaxCoord(l)
	square_c = GetMaxCoord(c)
	res = {0,{}}
	for i=1,9 do
		if CheckLine(i,l,m) then
			if CheckColumn(i,c,m) then
				if CheckSquare(i,square_l,square_c,m) then
					table.insert(res[2],i)
					res[1] = res[1] + 1
				end
			end
		end
	end
	return res
end

function PartialGenerateSudoku(m,z)
	for i=1,9 do
		m[z][i] = 0
		m[z+1][i] = 0
	end
	for l=z,9 do
		for c=1,9 do
			available = AvailableNumbers(l,c,matrix)
			if available[1] == 0 then
				return PartialGenerateSudoku(matrix,l-1)
			else
				matrix[l][c] = available[2][math.random(1,available[1])]
			end
		end
	end
	return matrix
end

function DefaultNumbers(d,m,s)
	if d == "Easy" then
		num = math.random(32,36)
	elseif d == "Normal" then
		num = math.random(20,25)
	elseif d == "Hard" then
		num = math.random(15,20)
	end
	z = 0
	while z < num do
		i = math.random(1,9)
		j = math.random(1,9)
		if m[i][j][1] ~= s[i][j] then
			m[i][j][1] = s[i][j]
			m[i][j][2] = true
			z = z + 1
		end
	end
	return num
end

function AddNumber(n,l,r,m)
	if not m[l][r][2] then
		if m[l][r][i] == 0 then
			inserted = inserted + 1
		end
		m[l][r][1] = n
	end
	if inserted >= 81 then
		won = true
		for i=1,9 do
			if not won then
				break
			end
			for j=1,9 do
				if m[i][j][1] ~= my_solution[i][j] then
					won = false
					break
				end
			end
		end
	end
end

function RemoveNumber(l,r,m)
	if not m[l][r][2] then
		if m[l][r][i] ~= 0 then
			inserted = inserted - 1
		end
		m[l][r][1] = 0
	end
end

function GenerateSudoku()
	matrix = {}
	for i=1,9 do
		matrix[i] = {0,0,0,0,0,0,0,0,0}
	end
	h,m,s = System.getTime()
	math.randomseed(h*3600+m*60+s)
	for l=1,9 do
		for c=1,9 do
			available = AvailableNumbers(l,c,matrix)
			if available[1] == 0 then
				return PartialGenerateSudoku(matrix,l-1)
			else
				matrix[l][c] = available[2][math.random(1,available[1])]
			end
		end
	end
	return matrix
end

function TextScreen()
	Graphics.debugPrint(5,5,"Generated in "..(Timer.getTime(time_spent)/1000).." secs",black)
	Graphics.debugPrint(5,24,"Difficulty set to "..difficulty,black)
	Graphics.debugPrint(5,43,"Press X to clear selected box",black)
	Graphics.debugPrint(5,62,"Press R to clear current sudoku",black)
	Graphics.debugPrint(5,81,"Press L to generate a new sudoku",black)
end

function GameScreen()
	Graphics.fillEmptyRect(48,104,200,256,black)
	Graphics.fillEmptyRect(120,176,200,256,black)
	Graphics.fillEmptyRect(192,248,200,256,black)
	Graphics.fillEmptyRect(48,104,300,356,black)
	Graphics.fillEmptyRect(120,176,300,356,black)
	Graphics.fillEmptyRect(192,248,300,356,black)
	Graphics.fillEmptyRect(48,104,400,456,black)
	Graphics.fillEmptyRect(120,176,400,456,black)
	Graphics.fillEmptyRect(192,248,400,456,black)
	Graphics.debugPrint(62,210,"1      2      3", black, 1.5)
	Graphics.debugPrint(62,310,"4      5      6", black, 1.5)
	Graphics.debugPrint(62,410,"7      8      9", black, 1.5)
	for z1=1,3 do
		for z2=1,3 do
			if (z1+z2) % 2 == 0 then
				color = yellow
			else
				color = green
			end
			Graphics.fillRect(250+z1*168,250+z1*168+168,10+(z2-1)*168,10+z2*168,color)
			Graphics.fillEmptyRect(250+z1*168,250+z1*168+56,10+(z2-1)*168,10+(z2-1)*168+56,black)
			Graphics.fillEmptyRect(250+z1*168+56,250+z1*168+112,10+(z2-1)*168,10+(z2-1)*168+56,black)
			Graphics.fillEmptyRect(250+z1*168+112,250+z1*168+168,10+(z2-1)*168,10+(z2-1)*168+56,black)
			Graphics.fillEmptyRect(250+z1*168,250+z1*168+56,10+(z2-1)*168+56,10+(z2-1)*168+112,black)
			Graphics.fillEmptyRect(250+z1*168+56,250+z1*168+112,10+(z2-1)*168+56,10+(z2-1)*168+112,black)
			Graphics.fillEmptyRect(250+z1*168+112,250+z1*168+168,10+(z2-1)*168+56,10+(z2-1)*168+112,black)
			Graphics.fillEmptyRect(250+z1*168,250+z1*168+56,10+(z2-1)*168+112,10+(z2-1)*168+168,black)
			Graphics.fillEmptyRect(250+z1*168+56,250+z1*168+112,10+(z2-1)*168+112,10+(z2-1)*168+168,black)
			Graphics.fillEmptyRect(250+z1*168+112,250+z1*168+168,10+(z2-1)*168+112,10+(z2-1)*168+168,black)
		end
	end
	Graphics.fillRect(419+(cursor_l-1)*56,417+cursor_l*56,11+(cursor_r-1)*56,65+(cursor_r-1)*56,cyan)
	for i=1,9 do
		for j=1,9 do
			if my_matrix[i][j][1] ~= 0 then
				if my_matrix[i][j][2] then
					color = red
				else
					color = black
				end
				Graphics.debugPrint(433+(i-1)*56,20+(j-1)*56,my_matrix[i][j][1],color, 1.5)
			end
		end
	end  
end

function CreateSudoku()
	time_spent = Timer.new()
	my_solution = GenerateSudoku()
	Timer.pause(time_spent)

	-- Set default cursor position
	cursor_l = 1
	cursor_r = 1
	
	my_matrix = {}
	for i=1,9 do
		my_matrix[i] = {{0,false},{0,false},{0,false},{0,false},{0,false},{0,false},{0,false},{0,false},{0,false}}
	end
	inserted = DefaultNumbers(difficulty,my_matrix,my_solution)
	update_screen = true
	top_blend = true
	won = false
end

-- Set default config
difficulty = "Easy"
mode = "Menu"
index = 1
oldpad = Controls.read()
menu = {"Start new sudoku","Difficulty: "..difficulty,"Exit game"}
difficulties = {"Easy","Normal","Hard"}
diff_idx = 1

while true do
	Graphics.initBlend()
	pad = Controls.read()
	if mode == "Menu" then
		Graphics.fillRect(0,960,0,544,white)
		Graphics.debugPrint(5,5,"VitaSudoku v.1.3 by Rinnegatamante",red)
		for i,voice in pairs(menu) do
			if i == index then
				color = red
			else
				color = black
			end
			Graphics.debugPrint(10,25+20*i,voice,color)
		end
		if Controls.check(pad,SCE_CTRL_UP) and not Controls.check(oldpad,SCE_CTRL_UP) then
			index = index - 1
		elseif Controls.check(pad,SCE_CTRL_DOWN) and not Controls.check(oldpad,SCE_CTRL_DOWN) then
			index = index + 1
		elseif Controls.check(pad,SCE_CTRL_CROSS) and not Controls.check(oldpad,SCE_CTRL_CROSS) then
			if index == 1 then
				mode = "Game"
				CreateSudoku()
			elseif index == 2 then
				diff_idx = diff_idx + 1
				if diff_idx > #difficulties then
					diff_idx = 1
				end
				difficulty = difficulties[diff_idx]
				menu[2] = "Difficulty: "..difficulty
			elseif index == 3 then
				if soundSystem then
					Sound.close(snd)
					Sound.term()
				end
				System.exit()
			end
		end
		if index > #menu then
			index = 1
		elseif index < 1 then
			index  =  #menu
		end
	elseif mode == "Game" then
		Graphics.fillRect(0,960,0,544,white)
		TextScreen()
		GameScreen()
		if Controls.check(pad, SCE_CTRL_START) then
			mode = "Menu"
			index = 1
		elseif Controls.check(pad,SCE_CTRL_CROSS) and not Controls.check(oldpad,SCE_CTRL_CROSS) then
			RemoveNumber(cursor_l,cursor_r,my_matrix)
		elseif Controls.check(pad,SCE_CTRL_RTRIGGER) then
			for i=1,9 do
				for j=1,9 do
					if my_matrix[i][j][1] ~= 0 then
						if not my_matrix[i][j][2] then
							inserted = inserted - 1
							my_matrix[i][j][1] = 0
						end
					end
				end
			end
			update_screen = true
		elseif Controls.check(pad,SCE_CTRL_LTRIGGER) then
			CreateSudoku()
		end
		x,y = Controls.readTouch()
		if (not (x == nil)) then
			if y < 514 and x < 922 and x > 418 and y > 10 then
				cursor_l = math.ceil((x - 418) / 56)
				cursor_r = math.ceil((y - 10) / 56)
			end
			if y > 200 and y < 256 then
				if x > 48 and x < 104 then
					AddNumber(1,cursor_l,cursor_r,my_matrix)
				elseif x > 120 and x < 176 then
					AddNumber(2,cursor_l,cursor_r,my_matrix)
				elseif x > 192 and x < 248 then
					AddNumber(3,cursor_l,cursor_r,my_matrix)
				end
			elseif y > 300 and y < 356 then
				if x > 48 and x < 104 then
					AddNumber(4,cursor_l,cursor_r,my_matrix)
				elseif x > 120 and x < 176 then
					AddNumber(5,cursor_l,cursor_r,my_matrix)
				elseif x > 192 and x < 248 then
					AddNumber(6,cursor_l,cursor_r,my_matrix)
				end
			elseif y > 400 and y < 456 then
				if x > 48 and x < 104 then
					AddNumber(7,cursor_l,cursor_r,my_matrix)
				elseif x > 120 and x < 176 then
					AddNumber(8,cursor_l,cursor_r,my_matrix)
				elseif x > 192 and x < 248 then
					AddNumber(9,cursor_l,cursor_r,my_matrix)
				end
			end
		end
		if won then
			Graphics.debugPrint(360,270,"Sudoku completed succesfully!",red)
		end
	end
	oldpad = pad
	
	-- BGM managing
	if soundSystem then
		if not Sound.isPlaying(snd) then
			dequeueMusic()
			tmr = Timer.new()
			alpha = 255
		end
	end	
	if not (tmr == nil) then
		if Timer.getTime(tmr) > 100 then
			alpha = alpha - 5
			Timer.reset(tmr)
			if alpha == 0 then
				Timer.destroy(tmr)
				tmr = nil
			end
		end
		Graphics.debugPrint(5, 500, "Reproducing track " .. bgm_idx .. " of " .. #bgm_queue, Color.new(0,0,0,alpha))
		Graphics.debugPrint(5, 520, bgm_queue[bgm_idx][1], Color.new(0,0,0,alpha))
	end
	
	Graphics.termBlend()
	Screen.flip()
end