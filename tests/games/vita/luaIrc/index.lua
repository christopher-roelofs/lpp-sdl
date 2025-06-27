VERSION = "1.1"

-- GekiHEN contest splashscreen
splash = Graphics.loadImage("app0:/splash.png")
spl = 0
while spl < 3 do
	Graphics.initBlend()
	Graphics.drawImage(0, 0, splash)
	Graphics.termBlend()
	Screen.flip()
	Screen.waitVblankStart()
	spl = spl + 1
end
System.wait(3000000)
Graphics.freeImage(splash)

-- * explode
-- PHP explode porting for Lua developing
function explode(div,str)
	pos = 0
	arr = {}
	for st,sp in function() return string.find(str,div,pos,true) end do
		table.insert(arr,string.sub(str,pos,st-1))
		pos = sp + 1
	end
	table.insert(arr,string.sub(str,pos))
	return arr
end

local function checkInput(title, start)
	Keyboard.show(title, start)
	mess = ""
	while true do
		Graphics.initBlend()
		Screen.clear()
		status = Keyboard.getState()
		if status ~= RUNNING then
			if status ~= CANCELED then
				mess = Keyboard.getInput()
			end
			Keyboard.clear()
			break
		end
		Graphics.termBlend()
		Screen.flip()
		Screen.waitVblankStart()
	end
	return mess
end

-- A couple of colors
local white = Color.new(255, 255, 255)
local black = Color.new(0, 0, 0)
local yellow = Color.new(255, 255, 0)
local cyan = Color.new(0, 255, 255)
local green = Color.new(0, 255, 0)
local orange = Color.new(255,128,0)

-- Chats internal values
local cns_lines = {}
local new_msgs = {}
local userslists = {}
local populateUserlistOf = nil
cns_lines["system"] = {}
new_msgs["system"] = false
userslists["system"] = {}

-- Printf implementation for the chat system
local function printf(msg, color, channel)
	if string.len(msg) <= 61 then
		if #cns_lines[channel] > 26 then
			table.remove(cns_lines[channel], 1)
		end
		table.insert(cns_lines[channel], {["msg"]=msg,["clr"]=color})
	else
		printf(string.sub(msg, 1, 60), color, channel)
		printf(string.sub(msg, 61), color, channel)
	end
	new_msgs[channel] = true
end

-- Render chat
local function renderChat()	
	local cns_y = 2
	for i, line in pairs(cns_lines[cur_channel]) do
		Graphics.debugPrint(5, cns_y, line.msg, line.clr)
		cns_y = cns_y + 20
	end
	new_msgs[cur_channel] = false
end

-- Render channels list
local function renderChannels()
	local cns_y = 2
	local clr
	for chn, dummy in pairs(cns_lines) do
		if chn == cur_channel then
			clr = yellow
		elseif new_msgs[chn] then
			clr = cyan
		else
			clr = white
		end
		Graphics.debugPrint(755, cns_y, chn, clr)
		cns_y = cns_y + 20
	end
end

-- Render users list
local sel_val = 128
local decrease = true
local function renderUserslist()
	if userslist == nil then
		return -1
	end
	Graphics.fillRect(10, 958, 10, 540, white)
	Graphics.fillRect(11, 957, 11, 539, black)
	x = 15
	y = 15
	for i, user in pairs(userslist) do
		if string.sub(user,1,1) == "@" then
			clr = green
			username = string.sub(user,2)
		else
			clr = white
			username = user
		end
		if i == user_idx then
			if decrease then
				sel_val = sel_val - 4
				if sel_val == 0 then
					decrease = false
				end
			else
				sel_val = sel_val + 4
				if sel_val == 128 then
					decrease = true
				end
			end
			sclr = Color.new(sel_val, sel_val, sel_val)
			Graphics.fillRect(x-2, x+183, y+2, y+21, sclr)
		end
		Graphics.debugPrint(x, y, username, clr)
		y = y + 20
		if y > 515 then
			y = 15
			x = x + 185
		end
	end
end

-- Join a channel
local function joinChannel(chn_name)
	printf("Joining " .. chn_name .. "...", cyan, "system")
	cns_lines[chn_name] = {}
	userslists[chn_name] = {}
	cur_channel = chn_name
	new_msgs[chn_name] = false
	Socket.send(skt, "JOIN "..chn_name.."\r\n")
	Socket.send(skt, "NAMES "..chn_name.."\r\n")
	populateUserlistOf = chn_name
end

-- Creates a private message lobby
local function createPrivateLobby(user)
	cns_lines[user] = {}
	userslists[user] = {user}
	new_msgs[user] = false
end	

-- Internal details
System.createDirectory("ux0:/data/luaIrc")
local save_log = false
user_idx = 0
nick_default = System.getUsername()
server_default = "irc.freenode.net"
channel_default = "#henkaku"
if System.doesFileExist("ux0:/data/luaIrc/config.lua") then
	dofile("ux0:/data/luaIrc/config.lua")
end
nick = checkInput("Insert nickname",nick_default)
login = nick
server = checkInput("Insert server hostname",server_default)
channel = checkInput("Insert channel name",channel_default)
local show_userslist = false
local raw_userslist = ""

-- Initializing network
printf("Initializing network...", cyan, "system")
Socket.init()

-- Connect to the server
printf("Connecting to " .. server .. "...", cyan, "system")
skt = Socket.connect(server, 6667);

-- Waiting till server sends first response
msg = ""
repeat
	msg = Socket.receive(skt, 128)
until (not (msg == ""))

-- Logging in
printf("Logging in as " .. nick .. "...", cyan, "system")
Socket.send(skt, "NICK "..nick.."\r\n")
Socket.send(skt, "USER "..login.." 8 * : luaIrc\r\n")

-- Joining channel
joinChannel(channel)

-- Main loop
local pad
local oldpad = Controls.read()
while true do

	-- Rendering the scene
	Graphics.initBlend()
	Screen.clear()
	Graphics.drawLine(750,750,0,544,white)
	renderChannels()
	renderChat()
	Graphics.debugPrint(835,520, "luaIrc v" .. VERSION, white)
	if show_userslist then
		renderUserslist()
	end
	Graphics.termBlend()
	Screen.flip()
	Screen.waitVblankStart()
	System.powerTick()
	
	-- Receiving new messages
	msg = Socket.receive(skt, 32767)
	local lines = explode("\r\n", msg)
	for i, line in pairs(lines) do
		if string.len(line) > 5 then
			if string.sub(line, 1, 4) == "PING" then -- PING detection
				Socket.send(skt, "PONG\r\n")
			else
				local parsed_line = explode(":", line)
				if #parsed_line > 1 then
					local parsed_prefix = explode(" ", parsed_line[2])
					local parsed_name = explode("!", parsed_prefix[1])
					local name = parsed_name[1]
					if name == nil then
						name = ""
					end
					local txt = ""
					idx = 3
					while idx <= #parsed_line do
						if txt == "" then
							txt = parsed_line[idx]
						else
							txt = txt .. ":" .. parsed_line[idx]
						end
						idx = idx + 1
					end
					
					-- Received a message without channel value
					if parsed_prefix[3] == nil or string.sub(parsed_prefix[3],1,1) ~= "#" then
						if parsed_prefix[2] == "366" then -- RPL_ENDOFNAMES
							userslist = explode(" ", raw_userslist)
							if populateUserlistOf ~= nil then
								userslists[populateUserlistOf] = userslist
							end
						elseif parsed_prefix[2] == "353" then -- RPL_NAMREPLY
							if raw_userslist == "" then
								raw_userslist = txt
							else
								raw_userslist = raw_userslist .. " " .. txt
							end
						elseif parsed_prefix[2] == "332" then -- RPL_TOPIC
							printf("Topic of the channel: " .. txt, yellow, joined_chn)
						elseif parsed_prefix[2] == "QUIT" then -- QUIT
							for chn, list in pairs(userslists) do
								for i, user in pairs(list) do
									if string.sub(user,1,1) == "@" then
										username = string.sub(user,2)
									else
										username = user
									end
									if username == name then
										table.remove(list, i)
										if save_log then
											log_hdl = io.open("ux0:/data/luaIrc/log.txt", FCREATE)
											log_txt = "(" .. chn .. ") " .. name .. "left the channel."
											io.write(log_hdl, log_txt, string.len(log_txt))
											io.close(log_hdl)
										end
										printf(name .. " left the channel.", orange, chn)
										break
									end
								end
							end
						elseif parsed_prefix[2] == "PRIVMSG" then -- PRIVMSG from users
							if save_log then
								log_hdl = io.open("ux0:/data/luaIrc/log.txt", FCREATE)
								log_txt = "(private message) " .. name .. ":" .. txt
								io.write(log_hdl, log_txt, string.len(log_txt))
								io.close(log_hdl)
							end
							if cns_lines[name] == nil then
								createPrivateLobby(name)
							end
							printf(name .. ":" .. txt, white, name)
						else
							printf(name .. ":" .. txt, white, "system")
						end
						
					-- Received a message with channel value
					else
						if save_log then
							log_hdl = io.open("ux0:/data/luaIrc/log.txt", FCREATE)
							if parsed_prefix[2] == "PRIVMSG" then
								log_txt = "(" .. parsed_prefix[3] .. ") " .. name .. ":" .. txt
							elseif parsed_prefix[2] == "JOIN" then
								log_txt = "(" .. parsed_prefix[3] .. ") " .. name .. "joined the channel."
							elseif parsed_prefix[2] == "PART" then
								log_txt = "(" .. parsed_prefix[3] .. ") " .. name .. "left the channel."
							end
							io.write(log_hdl, log_txt, string.len(log_txt))
							io.close(log_hdl)
						end
						if parsed_prefix[2] == "PRIVMSG" then -- PRIVMSG from channel
							printf(name .. ":" .. txt, white, parsed_prefix[3])
						elseif parsed_prefix[2] == "JOIN" then -- JOIN to a channel
							printf(name .. " joined the channel.", cyan, parsed_prefix[3])
							if name == nick then -- We joined a channel, saving channel name for topic printing
								joined_chn = parsed_prefix[3]
							end
							table.insert(userslists[parsed_prefix[3]],name)
						elseif parsed_prefix[2] == "PART" then -- PART from a channel
							printf(name .. " left the channel.", orange, parsed_prefix[3])
						end
					end
				end
			end
		end
	end
	
	-- Controls handling
	pad = Controls.read()
	
	if Controls.check(pad, SCE_CTRL_UP) and not Controls.check(oldpad, SCE_CTRL_UP) then
		if show_userslist then -- Changing selected user
			user_idx = user_idx - 1
			if user_idx == 0 then
				user_idx = 1
			end
		else -- Changing shown chat
			local old_chn = nil
			for chn, dummy in pairs(cns_lines) do
				if chn == cur_channel then
					break
				end
				old_chn = chn
			end
			if old_chn ~= nil then
				cur_channel = old_chn
			end
		end
	elseif Controls.check(pad, SCE_CTRL_DOWN) and not Controls.check(oldpad, SCE_CTRL_DOWN) then
		if show_userslist then -- Changing selected user
			user_idx = user_idx + 1
			if user_idx > #userslist then
				user_idx = #userslist
			end
		else -- Changing shown chat
			local old_chn = nil
			local new_chn = nil
			for chn, dummy in pairs(cns_lines) do
				if old_chn ~= nil then
					new_chn = chn
					break
				end
				if chn == cur_channel then
					old_chn = chn
				end
			end
			if new_chn ~= nil then
				cur_channel = new_chn
			end
		end
	elseif Controls.check(pad, SCE_CTRL_LEFT) and not Controls.check(oldpad, SCE_CTRL_LEFT) then
		if show_userslist then -- Changing selected user
			if user_idx > 26 then
				user_idx = user_idx - 26
			end
		end
	elseif Controls.check(pad, SCE_CTRL_RIGHT) and not Controls.check(oldpad, SCE_CTRL_RIGHT) then
		if show_userslist then -- Changing selected user
			if #userslist - user_idx >= 26 then
				user_idx = user_idx + 26
			end
		end
	elseif Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS) then
		if show_userslist then -- Opening private messages chat
			if string.sub(userslist[user_idx],1,1) == "@" then
				username = string.sub(userslist[user_idx],2)
			else
				username = userslist[user_idx]
			end
			createPrivateLobby(username)
			show_userslist = false
			cur_channel = username				
		else -- Sending a new message
			if cur_channel ~= "system" and (#cns_lines[cur_channel] > 0 or string.sub(cur_channel,1,1) ~= "#") then
				if string.sub(cur_channel,1,1) == "#" then
					Keyboard.show("Insert message to send on " .. cur_channel, "")
				else
					Keyboard.show("Insert message to send to " .. cur_channel, "")
				end
				while true do
					Graphics.initBlend()
					Screen.clear()
					status = Keyboard.getState()
					if status ~= RUNNING then
						if status ~= CANCELED then
							mess = Keyboard.getInput()
							Socket.send(skt, "PRIVMSG " .. cur_channel .. " :" .. mess .. "\r\n")
							printf(nick .. ":" .. mess, white, cur_channel)
						end
						Keyboard.clear()
						break
					end
					Graphics.termBlend()
					Screen.flip()
					Screen.waitVblankStart()
				end
			end
		end
		
	-- Connecting to a new channel
	elseif Controls.check(pad, SCE_CTRL_START) and not Controls.check(oldpad, SCE_CTRL_START) then
		Keyboard.show("Insert channel name", "")
		while true do
			Graphics.initBlend()
			Screen.clear()
			status = Keyboard.getState()
			if status ~= RUNNING then
				if status ~= CANCELED then
					mess = Keyboard.getInput()
					joinChannel(mess)
				end
				Keyboard.clear()
				break
			end
			Graphics.termBlend()
			Screen.flip()
			Screen.waitVblankStart()
		end
	
	-- Requiring current userslist
	elseif Controls.check(pad, SCE_CTRL_LTRIGGER) and not Controls.check(oldpad, SCE_CTRL_LTRIGGER) then
		if string.sub(cur_channel,1,1) == "#" and #cns_lines[cur_channel] > 0 then
			show_userslist = not show_userslist
			user_idx = 1
			Socket.send(skt, "NAMES " .. cur_channel .. "\r\n")
			userslist = nil
			raw_userslist = ""
		end
	end
	
	oldpad = pad
	Screen.flip()
	Screen.waitVblankStart()
end