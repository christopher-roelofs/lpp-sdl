Sound.init()
--globals
red = Color.new(255,32,32,255)
green = Color.new(32,255,32,255)
white = Color.new(255,255,255,255)
require("menu")
require("twoplayergame")
require("oneplayergame")

require("bullet")
require("tank")

tile = Graphics.loadImage("resources/floor.png")
overlay = Graphics.loadImage("resources/overlay.png")
explode = Sound.openWav("resources/explode.wav")
impact = Sound.openWav("resources/impact.wav")

enemy = {
	hp = 500,
	x = 500,
	y = 500,
	xv = 1,
	yv = 1,
	sprite = Graphics.loadImage("resources/enemy.png")
}


joyX = 1.0
joyY = 1.0

deadzone = 50
spin = 0

leftTank = Tank:new(nil, 256,256,green)
rightTank = Tank:new(nil,450,300,red)
leftTank.x = 256
leftTank.y = 256
leftTank.color = green
leftTank.bullet = Bullet:new(nil,-50,-50,0,0,false)

screen = 0
--sound buffer
sounds = {nil,nil,nil,nil,nil,nil,nil}

function playSound(sound)
	for s=0,7 do
		if sounds[s] == nil then
			sounds[s] = sound
      Sound.play(sounds[s],NO_LOOP)
			break
		end
	end
	for s=0,7 do
		if sounds[s] and not Sound.isPlaying(sounds[s]) then
			Sound.close(sounds[s])
			sounds[s]=nil
		end
	end
end
--ready for camera
function floor(camX,camY)
	scale = 0.5
	size = 256*scale
	for x=0,20,1 do
		for y=0,20,1 do
			Graphics.drawScaleImage((x+camX)*size,(y+camY)*size,tile,scale,scale)
		end
	end
end
--returns the distance of these from 0
function range(x,y)
	absx = math.abs(x)
	absy = math.abs(y)
	absx  = (absx*absx)
	absy  = (absy*absy)
	return math.sqrt(absx+absy)
end
--distance between two vectors
function distance(x,y,xx,yy)
	absx = math.abs(x-xx)
	absy = math.abs(y-yy)
	absx  = (absx*absx)
	absy  = (absy*absy)
	return math.sqrt(absx+absy)
end
--gives the rad needed to look at an objects vector (for AI shooting)
function lookAt(x,y,xx,yy)
	return -(math.atan(xx-x, yy-y) - math.atan(0, -1))
end
-- Main loop
while true do
	Graphics.initBlend()
	Screen.clear()
	floor(-9.0,-3.0)
	if(screen == 0) then
		Menu.render()
	elseif(screen == 1) then
		OnePlayer:render()
	elseif(screen == 2) then
		TwoPlayer:render()
	end
	Graphics.termBlend()
	Screen.flip()
	if Controls.check(Controls.read(), SCE_CTRL_START) then
		leftTank.y = 262
		rightTank.y = 262
		leftTank.x = 245
		rightTank.x = 900-200
		leftTank.hp = 500
		rightTank.hp = 500
		screen = 0
	end
end
