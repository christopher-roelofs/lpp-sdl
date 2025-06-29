-- Blackjack 3DS 0.4 ---------------------

--[[
	Changes this release:
	fixed flashing touch menus
	clean up commented out code
	fixed insurance offering when you can't afford it
	write to money file on gameover screen
	statistics
	bet changing with R L add hold option?
	SOUND IS FIXED HOPEFULLY
--]]

System.setCpuSpeed(NEW_3DS_CLOCK)

debug = ''

white = Color.new(255,255,255)
black = Color.new(0,0,0)
background = Color.new(7,99,36)
buttonFill = Color.new(9,86,32)
buttonText = Color.new(200,200,200)
buttonFillPressed = Color.new(47,117,66)
buttonFillPressedHalfOpacity = Color.new(47,117,66,225)

three = nil
level = 0.0

font = Font.load("font/lppdebug.ttf")
Font.setPixelSizes(font, 15)

function fprint(x,y,string,color,screen, eye)
	if eye then
		Font.print(font,x,y-2,string,color,screen, eye)
	else
		Font.print(font,x,y-2,string,color,screen)
	end
end

function fprint3D(x, y, string, color)
	if three then
		fprint(x, y, string, color, TOP_SCREEN, LEFT_EYE)
		fprint(x, y, string, color, TOP_SCREEN, RIGHT_EYE)
	else
		fprint(x, y, string, color, TOP_SCREEN)
	end
end

Screen.waitVblankStart()
Screen.refresh()
fprint3D(5,5,'Loading...', white)
Screen.flip()

h,m,s = System.getTime()
seed = s + m * 60 + h * 3600
math.randomseed (seed)

oldPad = Controls.read()
local touchX, touchY = Controls.readTouch()
oldX = touchX or 0
oldY = touchY or 0

cardSprites = Screen.loadImage("images/cardsprites.png")
cardSpritesDim = Screen.loadImage("images/cardspritesdim.png")
cardBack = Screen.loadImage("images/cardbackblue.png")

aButton = Screen.loadImage("images/a.png")
bButton = Screen.loadImage("images/b.png")
xButton = Screen.loadImage("images/x.png")
yButton = Screen.loadImage("images/y.png")
lButton = Screen.loadImage("images/l.png")
rButton = Screen.loadImage("images/r.png")
startButton = Screen.loadImage("images/start.png")
titlebg = Screen.loadImage("images/titlebg.png")
titlefg = Screen.loadImage("images/titlefg.png")

if System.doesFileExist("sound/bgm.ogg") then
	bgm = Sound.openOgg("sound/bgm.ogg", false)
else
	bgm = nil
end
dealCardSFX = Sound.openOgg("sound/dealcard.ogg", false)
flipCardSFX = Sound.openOgg("sound/flipcard.ogg", false)

suiteYIndices = { s=0, c=98, h=196, d=294 }
suiteXIndices = { ['A']=0, [2]=73, [3]=(73*2), [4]=(73*3), [5]=(73*4), [6]=(73*5), [7]=(73*6), [8]=(73*7), [9]=(73*8), [10]=(73*9), ['J']=(73*10), ['Q']=(73*11), ['K']=(73*12) }

cards = {2,3,4,5,6,7,8,9,10,'J','Q','K','A'}
suites = {'c','d','s','h'}

playerMoney = 1000

dealerHand = nil
playerHands = {}
playerHandIndex = 1
playerBet = 100
playerHasInsurance = false
roundResults = {}

betIncrement = 10
minBet = 10
maxBet = 1000

currentState = 'menu'
nextState = 'menu'

dealerAnimationCounter = 0

fullLengthCardSpacing = 75
singleHandCollapseCardSpacing = 35
splitHandCardSpacing = 15

bgmEnabled = true
sfxEnabled = true
offerInsurance = true
dealerHitsSoft17 = false

bgmStarted = false

playerStatistics = {
	handsPlayed = 0,
	handsWon = 0,
	handsPushed = 0,
	handsLost = 0,
	handsSurrended = 0,
	handsWonBlackjack = 0,
	highestMoney = 1000,
}

--- Basic Functions --------------------------------------------------------------------------

function split(str, pat)
  local t = {}
  local fpat = "(.-)" .. pat
  local last_end = 1
  local s, e, cap = str:find(fpat, 1)
  while s do
    if s ~= 1 or cap ~= "" then
			table.insert(t,cap)
    end
    last_end = e+1
    s, e, cap = str:find(fpat, last_end)
  end
  if last_end <= #str then
    cap = str:sub(last_end)
    table.insert(t, cap)
  end
  return t
end

function fillRect3D(x1, x2, y1, y2, color, screen)
	if three then
		Screen.fillRect(x1, x2, y1, y2, color, TOP_SCREEN, LEFT_EYE)
		Screen.fillRect(x1, x2, y1, y2, color, TOP_SCREEN, RIGHT_EYE)
	else
		Screen.fillRect(x1, x2, y1, y2, color, TOP_SCREEN)
	end
end

function drawImage3D(x,y,image)
	if three then
		Screen.drawImage(x,y,image,TOP_SCREEN, LEFT_EYE)
		Screen.drawImage(x,y,image,TOP_SCREEN, RIGHT_EYE)
	else
		Screen.drawImage(x,y,image,TOP_SCREEN)
	end
end

function drawPartialImage3D(x,y,image_x,image_y,width,height,image)
	if three then
		Screen.drawPartialImage(x,y,image_x,image_y,width,height,image, TOP_SCREEN, LEFT_EYE)
		Screen.drawPartialImage(x,y,image_x,image_y,width,height,image, TOP_SCREEN, RIGHT_EYE)
	else
		Screen.drawPartialImage(x,y,image_x,image_y,width,height,image, TOP_SCREEN)
	end
end

local function shuffleTable(t)
  local rand = math.random 
  local iterations = #t
  local j
  
  for i = iterations, 2, -1 do
      j = rand(i)
      t[i], t[j] = t[j], t[i]
  end
end

function getTableSize (t)
	local size = 0
	for key,value in pairs(t) do
		size = size + 1
	end
	return size
end

function splitActive ()
	return (getTableSize(playerHands) == 2)
end

function getFreshDeck ()
	local deck = {}
	for i=1,4,1 do
		for key,value in ipairs(cards) do 
			table.insert(deck, {value, suites[i]})
		end
	end
	shuffleTable(deck)
	return deck
end

function getHandValue (hand)
	local sum = 0
	local numAces = 0
	local soft = false
	for key, value in ipairs(hand) do
		value = value[1]
		if (value == 'J') or (value == 'Q') or (value == 'K') then
			sum = sum + 10
		elseif (value == 'A') then
			sum = sum + 1
			numAces = numAces + 1
		else 
			sum = sum + value
		end
	end

	if (numAces > 0) and (sum < 12) then
		sum = sum + 10 -- convert an ace from 1 to 11
		soft = true
	end

	return sum, soft
end

function renderHand (startX, startY, cards, spacing, spriteSheet)
	spriteSheet = spriteSheet or cardSprites
	for key,value in ipairs(cards) do
		if three then
			Screen.drawPartialImage(startX - math.ceil(level*2.0) + (key-1)*spacing, startY, suiteXIndices[value[1]], suiteYIndices[value[2]], 72, 97, spriteSheet, TOP_SCREEN, RIGHT_EYE)
			Screen.drawPartialImage(startX + math.ceil(level*2.0) + (key-1)*spacing, startY, suiteXIndices[value[1]], suiteYIndices[value[2]], 72, 97, spriteSheet, TOP_SCREEN, LEFT_EYE)
		else
			drawPartialImage3D(startX + (key-1)*spacing, startY, suiteXIndices[value[1]], suiteYIndices[value[2]], 72, 97, spriteSheet)
		end
	end
end

function dealerHandRenderer(startX, startY, hideCard)
	local hideCard = hideCard or false
	if (dealerHand.getSize() > 5) then
		renderHand(startX, startY, dealerHand.getCards(), singleHandCollapseCardSpacing)
	elseif (hideCard == true) then
		if three then
			Screen.drawPartialImage(startX - math.ceil(level*2.0), startY,suiteXIndices[dealerHand.getCards()[1][1]], suiteYIndices[dealerHand.getCards()[1][2]], 72, 97, cardSprites, TOP_SCREEN, RIGHT_EYE)
			Screen.drawPartialImage(startX + math.ceil(level*2.0), startY,suiteXIndices[dealerHand.getCards()[1][1]], suiteYIndices[dealerHand.getCards()[1][2]], 72, 97, cardSprites, TOP_SCREEN, LEFT_EYE)
			Screen.drawImage(startX + math.ceil(level*2.0) + fullLengthCardSpacing, startY, cardBack, TOP_SCREEN, LEFT_EYE )
			Screen.drawImage(startX - math.ceil(level*2.0) + fullLengthCardSpacing, startY, cardBack, TOP_SCREEN, RIGHT_EYE )
		else
			Screen.drawPartialImage(startX, startY, suiteXIndices[dealerHand.getCards()[1][1]], suiteYIndices[dealerHand.getCards()[1][2]], 72, 97, cardSprites, TOP_SCREEN)
			Screen.drawImage(startX + fullLengthCardSpacing, startY, cardBack, TOP_SCREEN )
		end
	else
		renderHand(startX, startY, dealerHand.getCards(), fullLengthCardSpacing)
	end
end

function playerHandRenderer(startX, startY, hand, spriteSheet)
	if splitActive() then -- split active
		renderHand(startX, startY, hand.getCards(), splitHandCardSpacing, spriteSheet)
	else
		if (hand.getSize() > 5) then
			renderHand(startX, startY, hand.getCards(), singleHandCollapseCardSpacing)
		else
			renderHand(startX, startY, hand.getCards(), fullLengthCardSpacing)
		end
	end
end

function addCardToHand (hand)
	local index = math.random(1, getTableSize(deck))
	table.insert(hand, deck[index])
	return hand
end

function buttonPressed (key)
	return ((Controls.check(pad,key)) and not (Controls.check(oldPad,key)))
end

function renderDealerPlayerLine ()
	Screen.drawLine(0, 399, 119, 119, white, TOP_SCREEN, LEFT_EYE)
	Screen.drawLine(0, 399, 120, 120, white, TOP_SCREEN, LEFT_EYE)
	if three then
		Screen.drawLine(0, 399, 119, 119, white, TOP_SCREEN, RIGHT_EYE)
		Screen.drawLine(0, 399, 120, 120, white, TOP_SCREEN, RIGHT_EYE)
	end
end

function dealerCanReceiveCard ()
	if not(playerHands[1].getResult() == 'Surrendered') then
		if splitActive() then
			if (playerHands[1].handStatus() == 'valid') or (playerHands[2].handStatus() == 'valid') then
				local value = dealerHand.getValue()
				if value < 17 then
					return true
				elseif dealerHitsSoft17 and dealerHand.soft17() then
					return true
				end
			end
		else
			if (playerHands[1].handStatus() == 'valid') then
				local value = dealerHand.getValue()
				if value < 17 then
					return true
				elseif dealerHitsSoft17 and dealerHand.soft17() then
					return true
				end
			end
		end
	end
	return false
end

function moneyWagered ()
	local wagered = 0
	for key,value in pairs(playerHands) do
		wagered = wagered + value.getBet()
	end
	if (playerHasInsurance == true) and not(dealerHand.handStatus() == 'blackjack') then
		wagered = wagered + math.floor(playerBet / 2.0)
	end
	return wagered
end

function withinCoords (x, y, x1, x2, y1, y2)
	if (y >= y1) and (y <= y2) then
		if (x >= x1) and (x <= x2) then
			return true
		end
	end
	return false
end

function menuTrigger (x, y, x1, x2, y1, y2, returnString) 
	if withinCoords(x, y, x1, x2, y1, y2) and not _G[returnString..'Trigger'] then
		_G[returnString..'Trigger'] = true
	elseif x == 0 and y == 0 and _G[returnString..'Trigger'] then
		_G[returnString..'Trigger'] = false
		return returnString
	elseif not withinCoords(x, y, x1, x2, y1, y2) then
		_G[returnString..'Trigger'] = false
	end
	return false
end

function instantMenuTrigger (x, y, x1, x2, y1, y2, returnString) 
	if withinCoords(x, y, x1, x2, y1, y2) then
		return returnString
	end
	return false
end

function buttonColor (x, y, x1, x2, y1, y2)
	if withinCoords(x, y, x1, x2, y1, y2) then
		return buttonFillPressed
	else
		return buttonFill
	end
end

function playSFX (effect)
	if sfxEnabled then
		Sound.play(_G[effect..'SFX'],NO_LOOP)
	end
end

function booleanToNumber (boolean)
	if boolean then
		return 1
	else
		return 0
	end
end

function numberToBoolean (number)
	if tonumber(number) > 0 then
		return true
	else
		return false
	end
end

function loadFiles ()
	if System.doesFileExist("/settings.file") then
		local fileStream = io.open("/settings.file",FREAD)
		io.close(fileStream)
		fileStream = 0
		fileStream = io.open("/settings.file",FREAD)
		local fileDealerHitsSoft17 = io.read(fileStream, 17, 1)
		local fileOfferInsurance = io.read(fileStream, 34, 1)
		local fileBgmEnabled = io.read(fileStream, 47, 1)
		local fileSfxEnabled = io.read(fileStream, 60, 1)
		io.close(fileStream)
		dealerHitsSoft17 = numberToBoolean(fileDealerHitsSoft17)
		offerInsurance = numberToBoolean(fileOfferInsurance)
		bgmEnabled = numberToBoolean(fileBgmEnabled)
		sfxEnabled = numberToBoolean(fileSfxEnabled)
	else
		writeSettingsFile()
	end

	if System.doesFileExist("money.file") then
		local fileStream = io.open("money.file",FREAD)
		local fileSize = io.size(fileStream)
		local fileMoney = io.read(fileStream,0,10)
		local settingsString = io.read(fileStream,11,fileSize)
		io.close(fileStream)
		if tonumber(fileMoney, 10) == nil then -- money file is corrupt or some shit
			error("money file corrupt: "..fileMoney.." EXIT AND RESTART")
		else
			playerMoney = tonumber(fileMoney, 10)
			if playerMoney <= 0 then
				playerMoney = 1000
				resetStatistics()
			end
		end
		local s = split(settingsString,':')
		if settingsString and getTableSize(s) == 7 then
			loadedStats = true
			playerStatistics = {
				handsPlayed = tonumber(s[1]:match('%d+')),
				handsWon = tonumber(s[2]:match('%d+')),
				handsPushed = tonumber(s[3]:match('%d+')),
				handsLost = tonumber(s[4]:match('%d+')),
				handsSurrended = tonumber(s[5]:match('%d+')),
				handsWonBlackjack = tonumber(s[6]:match('%d+')),
				highestMoney = tonumber(s[7]:match('%d+'))
			}
		end
	else
		writeMoneyFile()
	end
end

function writeMoneyFile ()
	local fileStream = nil
	if System.doesFileExist("money.file") then
		fileStream = io.open("money.file",FWRITE)
	else
		fileStream = io.open("money.file",FCREATE)
	end
	moneyString = string.format('%010d', playerMoney)
	local s = playerStatistics
	saveString = moneyString..':'..s['handsPlayed']..':'..s['handsWon']..':'..s['handsPushed']..':'..s['handsLost']..':'..s['handsSurrended']..':'..s['handsWonBlackjack']..':'..s['highestMoney']..'                      '
	io.write(fileStream, 0, saveString, string.len(saveString))
	io.close(fileStream)
end

function writeSettingsFile ()
	local fileStream = nil
	if System.doesFileExist("settings.file") then
		fileStream = io.open("settings.file",FWRITE)
	else
		fileStream = io.open("settings.file",FCREATE)
	end
	local dealerHitsSoft17String = 'dealerHitsSoft17:'..booleanToNumber(dealerHitsSoft17)
	local offerInsuranceString = ' offerInsurance:'..booleanToNumber(offerInsurance)
	local bgmEnabledString = ' bgmEnabled:'..booleanToNumber(bgmEnabled)
	local sfxEnabledString = ' sfxEnabled:'..booleanToNumber(sfxEnabled)
	local fileString = dealerHitsSoft17String..offerInsuranceString..bgmEnabledString..sfxEnabledString
	local stringLength = string.len(fileString)
	io.write(fileStream,0,fileString, stringLength)
	io.close(fileStream)
end

function drawTitle()
	drawImage3D(0,0, titlebg)
	if three then
		Screen.drawImage(2 + math.ceil(level*2.0),0, titlefg, TOP_SCREEN, LEFT_EYE)
		Screen.drawImage(2 - math.ceil(level*2.0),0, titlefg, TOP_SCREEN, RIGHT_EYE)
	else
		Screen.drawImage(2,0, titlefg, TOP_SCREEN)
	end
end

function incrementStatistic(statisticString)
	playerStatistics[statisticString] = playerStatistics[statisticString] + 1
end

function resetStatistics()
	playerStatistics = {
		handsPlayed = 0,
		handsWon = 0,
		handsPushed = 0,
		handsLost = 0,
		handsSurrended = 0,
		handsWonBlackjack = 0,
		highestMoney = playerMoney,
	}
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return string.gsub(tostring(math.floor(num * mult + 0.5) / mult), "%.?0+$", "")
end

------------------------------------------------------------------------------------

function newHand (initialCards, bet)
	local self = { cards = initialCards, bet = bet, doubled = false, result = nil }
	local getBet = function ()
						return math.floor(self.bet)
					end
	local doubleDown = function ()
						if (self.doubled == false) then
							self.bet = self.bet * 2.0
							self.doubled = true
							addCardToHand(self.cards)
						end
					end
	local getDoubledDown = function ()
						return self.doubled
					end
	local getCards = function ()
						return self.cards
					end
	local getValue = function ()
						return getHandValue(self.cards)
					end
	local dealCard = function ()
						return addCardToHand(self.cards)
					end
	local getSize = function ()
						return getTableSize(self.cards)
					end
	local canSplit = function ()
						if (getSize() == 2) then
							local firstCardValue = getHandValue({ self.cards[1] })
							local secondCardValue = getHandValue({ self.cards[2] })
							if (firstCardValue == secondCardValue) then
								return true
							end
						end	
						return false
					end
	local handStatus = function ()
	                        local value = getValue()
							if (value > 21) then
								return 'bust'
							elseif (getSize() == 2) and (value == 21) then
								return 'blackjack'
							else
								return 'valid'
							end
						end
	local setResult = function (r)
						self.result = r
					end
	local getResult = function ()
						return self.result
					end
	local soft17 = function ()
						local value = 0
						local soft = false
						value, soft = getValue()
						if value == 17 and soft then
							return true
						end
						return false
					end

	return {
		getCards = getCards,
		getValue = getValue,
		dealCard = dealCard,
		getSize = getSize,
		canSplit = canSplit,
		handStatus = handStatus,
		getBet = getBet,
		doubleDown = doubleDown,
		getDoubledDown = getDoubledDown,
		setResult = setResult,
		getResult = getResult,
		soft17 = soft17
	}
end

---------------------------------------------------------------------------

function renderStats ()
	Screen.fillRect(5,314, 25, 150, buttonFill, BOTTOM_SCREEN )
	Screen.drawLine(159,159,30,145, white, BOTTOM_SCREEN)
	Screen.drawLine(160,160,30,145, white, BOTTOM_SCREEN)

	local spacing = 17
	local textStart = 32

	fprint(10,textStart, "Played", buttonText, BOTTOM_SCREEN)
	fprint(170,textStart, playerStatistics['handsPlayed'], buttonText, BOTTOM_SCREEN)

	fprint(10,textStart + spacing, "Won", buttonText, BOTTOM_SCREEN)
	fprint(170,textStart + spacing, playerStatistics['handsWon'].." ("..round((playerStatistics['handsWon'] * 100.0 / playerStatistics['handsPlayed']),1).."%)", buttonText, BOTTOM_SCREEN)

	fprint(10,textStart + 2*spacing, "Pushed", buttonText, BOTTOM_SCREEN)
	fprint(170,textStart + 2*spacing, playerStatistics['handsPushed'].." ("..round((playerStatistics['handsPushed'] * 100.0 / playerStatistics['handsPlayed']),1).."%)", buttonText, BOTTOM_SCREEN)

	fprint(10,textStart + 3*spacing, "Lost", buttonText, BOTTOM_SCREEN)
	fprint(170,textStart + 3*spacing, playerStatistics['handsLost'].." ("..round((playerStatistics['handsLost'] * 100.0 / playerStatistics['handsPlayed']),1).."%)", buttonText, BOTTOM_SCREEN)

	fprint(10,textStart + 4*spacing, "Surrendered", buttonText, BOTTOM_SCREEN)
	fprint(170,textStart + 4*spacing, playerStatistics['handsSurrended'].." ("..round((playerStatistics['handsSurrended'] * 100.0 / playerStatistics['handsPlayed']),1).."%)", buttonText, BOTTOM_SCREEN)

	fprint(10,textStart + 5*spacing, "Blackjacks", buttonText, BOTTOM_SCREEN)
	fprint(170,textStart + 5*spacing, playerStatistics['handsWonBlackjack'].." ("..round((playerStatistics['handsWonBlackjack'] * 100.0 / playerStatistics['handsPlayed']),1).."%)", buttonText, BOTTOM_SCREEN)

	fprint(10,textStart + 6*spacing, "Highest Money", buttonText, BOTTOM_SCREEN)
	fprint(170,textStart + 6*spacing, "$"..playerStatistics['highestMoney'], buttonText, BOTTOM_SCREEN)
end

function drawAndCheckMenu ()
	local trigger = nil

	if currentState == 'menu' then
		Screen.fillRect(5,314, 25, 85, buttonColor(xTouch, yTouch, 5, 314, 25, 85), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,314, 25, 85, black, BOTTOM_SCREEN )
		Screen.drawImage(8,28, aButton, BOTTOM_SCREEN)
		fprint(119,50, "New Hand", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 314, 25, 85, 'newHand') or trigger

		Screen.fillRect(5,314, 90, 150, buttonColor(xTouch, yTouch, 5, 314, 90, 150), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,314, 90, 150, black, BOTTOM_SCREEN )
		Screen.drawImage(8,93, xButton, BOTTOM_SCREEN)
		fprint(118,115, "Statistics", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 314, 90, 150, 'statistics') or trigger

		Screen.fillRect(5,210, 155, 215, buttonColor(xTouch, yTouch, 5, 210, 155, 215), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,210, 155, 215, black, BOTTOM_SCREEN )
		Screen.drawImage(8,158, startButton, BOTTOM_SCREEN)
		fprint(100,180, "Exit", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 210, 155, 215, 'exit') or trigger

		Screen.fillRect(214,314, 155, 215, buttonColor(xTouch, yTouch, 214, 314, 155, 215), BOTTOM_SCREEN )
		Screen.fillEmptyRect(214,314, 155, 215, black, BOTTOM_SCREEN )
		Screen.drawImage(217,158, yButton, BOTTOM_SCREEN)
		fprint(234,180, "Options", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 214, 314, 155, 215, 'options') or trigger

		trigger = menuTrigger(xTouch, yTouch, 5, 314, 25, 85, 'newHand') or trigger
		trigger = menuTrigger(xTouch, yTouch, 5, 314, 90, 150, 'statistics') or trigger
		trigger = menuTrigger(xTouch, yTouch, 5, 210, 155, 215, 'exit') or trigger
		trigger = menuTrigger(xTouch, yTouch, 214, 314, 155, 215, 'options') or trigger

	elseif currentState == 'options' then
		Screen.fillRect(5,314, 25, 150, buttonFill, BOTTOM_SCREEN )

		local settingsBaseY = 30
		local settingsSpacing = 5
		local settingsHeight = 25
		local settingsTextOffset = 8

		--- Deck ----
		local deckY1 = settingsBaseY
		local deckY2 = settingsBaseY + settingsHeight
		local deckText = deckY1 + settingsTextOffset
		if not dealerHitsSoft17 then
			Screen.fillRect(10,160, deckY1, deckY2, buttonFillPressed, BOTTOM_SCREEN )
			fprint(15,deckText, "Stands Soft 17", white, BOTTOM_SCREEN)
		else
			fprint(15,deckText, "Stands Soft 17", buttonText, BOTTOM_SCREEN)
		end
		Screen.fillEmptyRect(10,160, deckY1, deckY2, black, BOTTOM_SCREEN )
		-- trigger = instantMenuTrigger(xTouch, yTouch, 10, 160, 30, 50, 'singleDeck') or trigger

		if dealerHitsSoft17 then
			Screen.fillRect(160,309, deckY1, deckY2, buttonFillPressed, BOTTOM_SCREEN )
			fprint(165,deckText, "Hits Soft 17", white, BOTTOM_SCREEN)
		else
			fprint(165,deckText, "Hits Soft 17", buttonText, BOTTOM_SCREEN)
		end
		Screen.fillEmptyRect(160,309, deckY1, deckY2, black, BOTTOM_SCREEN )
		-- trigger = instantMenuTrigger(xTouch, yTouch, 160, 309, 30, 50, 'infinteDeck') or trigger


		--- Insurance ---
		local insuranceY1 = settingsBaseY + settingsHeight + settingsSpacing
		local insuranceY2 = settingsBaseY + (settingsHeight * 2) + settingsSpacing
		local insuranceText = insuranceY1 + settingsTextOffset
		if offerInsurance then
			Screen.fillRect(10,160, insuranceY1,insuranceY2, buttonFillPressed, BOTTOM_SCREEN )
			fprint(15,insuranceText, "Insurance", white, BOTTOM_SCREEN)
		else
			fprint(15,insuranceText, "Insurance", buttonText, BOTTOM_SCREEN)
		end
		Screen.fillEmptyRect(10,160, insuranceY1,insuranceY2, black, BOTTOM_SCREEN )
		-- trigger = instantMenuTrigger(xTouch, yTouch, 10, 160, 55, 75, 'insurance') or trigger

		if not offerInsurance then
			Screen.fillRect(160,309, insuranceY1,insuranceY2, buttonFillPressed, BOTTOM_SCREEN )
			fprint(165,insuranceText, "No Insurance", white, BOTTOM_SCREEN)
		else
			fprint(165,insuranceText, "No Insurance", buttonText, BOTTOM_SCREEN)
		end
		Screen.fillEmptyRect(160,309, insuranceY1,insuranceY2, black, BOTTOM_SCREEN )
		-- trigger = instantMenuTrigger(xTouch, yTouch, 160, 309, 55, 75, 'noInsurance') or trigger

		--- BGM ----
		local bgmY1 = settingsBaseY + (settingsHeight * 2) + (settingsSpacing * 2)
		local bgmY2 = settingsBaseY + (settingsHeight * 3) + (settingsSpacing*2)
		local bgmText = bgmY1 + settingsTextOffset
		if bgmEnabled then
			Screen.fillRect(10,160, bgmY1, bgmY2, buttonFillPressed, BOTTOM_SCREEN )
			fprint(15,bgmText, "BGM On", white, BOTTOM_SCREEN)
		else
			fprint(15,bgmText, "BGM On", buttonText, BOTTOM_SCREEN)
		end
		Screen.fillEmptyRect(10,160,  bgmY1, bgmY2, black, BOTTOM_SCREEN )
		-- trigger = instantMenuTrigger(xTouch, yTouch, 10, 160, 80, 100, 'bgmOn') or trigger

		if not bgmEnabled then
			Screen.fillRect(160, 309, bgmY1, bgmY2, buttonFillPressed, BOTTOM_SCREEN )
			fprint(165,bgmText, "BGM Off", white, BOTTOM_SCREEN)
		else
			fprint(165,bgmText, "BGM Off", buttonText, BOTTOM_SCREEN)
		end
		Screen.fillEmptyRect(160, 309, bgmY1, bgmY2, black, BOTTOM_SCREEN )
		-- trigger = instantMenuTrigger(xTouch, yTouch, 160, 309, 80, 100, 'bgmOff') or trigger


		--- SFX -----
		local sfxY1 =  settingsBaseY + (settingsHeight * 3) + (settingsSpacing * 3)
		local sfxY2 = settingsBaseY + (settingsHeight * 4) + (settingsSpacing*3)
		local sfxText = sfxY1 + settingsTextOffset
		if sfxEnabled then
			Screen.fillRect(10,160,  sfxY1, sfxY2, buttonFillPressed, BOTTOM_SCREEN )
			fprint(15,sfxText, "SFX On", white, BOTTOM_SCREEN)
		else
			fprint(15,sfxText, "SFX On", buttonText, BOTTOM_SCREEN)
		end
		Screen.fillEmptyRect(10,160,  sfxY1, sfxY2, black, BOTTOM_SCREEN )
		-- trigger = instantMenuTrigger(xTouch, yTouch, 10, 160, 105, 125, 'sfxOn') or trigger

		if not sfxEnabled then
			Screen.fillRect(160,309,  sfxY1, sfxY2, buttonFillPressed, BOTTOM_SCREEN )
			fprint(165,sfxText, "SFX Off", white, BOTTOM_SCREEN)
		else
			fprint(165,sfxText, "SFX Off", buttonText, BOTTOM_SCREEN)
		end
		Screen.fillEmptyRect(160,309,  sfxY1, sfxY2, black, BOTTOM_SCREEN )
		-- trigger = instantMenuTrigger(xTouch, yTouch, 160, 309, 105, 125, 'sfxOff') or trigger

		Screen.fillRect(5,314, 155, 215, buttonColor(xTouch, yTouch, 5, 314, 155, 215), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,314, 155, 215, black, BOTTOM_SCREEN )
		Screen.drawImage(8,158, bButton, BOTTOM_SCREEN)
		fprint(140,180, "Back", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 314, 155, 215, 'backToMenu') or trigger

		trigger = instantMenuTrigger(xTouch, yTouch, 10, 160, deckY1, deckY2, 'dealerStandsSoft17') or trigger
		trigger = instantMenuTrigger(xTouch, yTouch, 160, 309, deckY1, deckY2, 'dealerHitsSoft17') or trigger
		trigger = instantMenuTrigger(xTouch, yTouch, 10, 160, insuranceY1, insuranceY2, 'insurance') or trigger
		trigger = instantMenuTrigger(xTouch, yTouch, 160, 309, insuranceY1, insuranceY2, 'noInsurance') or trigger
		trigger = instantMenuTrigger(xTouch, yTouch, 10, 160, bgmY1, bgmY2, 'bgmOn') or trigger
		trigger = instantMenuTrigger(xTouch, yTouch, 160, 309, bgmY1, bgmY2, 'bgmOff') or trigger
		trigger = instantMenuTrigger(xTouch, yTouch, 10, 160, sfxY1, sfxY2, 'sfxOn') or trigger
		trigger = instantMenuTrigger(xTouch, yTouch, 160, 309, sfxY1, sfxY2, 'sfxOff') or trigger
		trigger = menuTrigger(xTouch, yTouch, 5, 314, 155, 215, 'backToMenu') or trigger

	elseif currentState == 'playerBet' then
		Screen.fillRect(5,210, 25, 85, buttonColor(xTouch, yTouch, 5, 210, 25, 85), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,210, 25, 85, black, BOTTOM_SCREEN )
		Screen.drawImage(8,28, aButton, BOTTOM_SCREEN)
		fprint(65,50, "Bet $"..playerBet, buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 210, 25, 85, 'bet') or trigger

		Screen.fillRect(214,314, 25, 55, buttonColor(xTouch, yTouch, 214, 314, 25, 55), BOTTOM_SCREEN )
		Screen.fillEmptyRect(214,314, 25, 55, black, BOTTOM_SCREEN )
		Screen.drawImage(217,28, rButton, BOTTOM_SCREEN)
		fprint(258,35, "+", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 214, 314, 25, 55, 'plus') or trigger

		Screen.fillRect(214,314, 55, 85, buttonColor(xTouch, yTouch, 214, 314, 55, 85), BOTTOM_SCREEN )
		Screen.fillEmptyRect(214,314, 55, 85, black, BOTTOM_SCREEN )
		Screen.drawImage(217,58, lButton, BOTTOM_SCREEN)
		fprint(258,65, "-", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 214, 314, 55, 85, 'minus') or trigger

		Screen.fillRect(5,105, 90, 150, buttonColor(xTouch, yTouch, 5, 105, 90, 150), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,105, 90, 150, black, BOTTOM_SCREEN )
		fprint(35,115, "$50", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 105, 90, 150, 'bet50') or trigger

		Screen.fillRect(109,210, 90, 150, buttonColor(xTouch, yTouch, 109, 210, 90, 150), BOTTOM_SCREEN )
		Screen.fillEmptyRect(109,210, 90, 150, black, BOTTOM_SCREEN )
		fprint(137,115, "$100", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 109, 210, 90, 150, 'bet100') or trigger

		Screen.fillRect(214,314, 90, 150, buttonColor(xTouch, yTouch, 214, 314, 90, 150), BOTTOM_SCREEN )
		Screen.fillEmptyRect(214,314, 90, 150, black, BOTTOM_SCREEN )
		fprint(238,115, "$500", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 214, 314, 90, 150, 'bet500') or trigger

		Screen.fillRect(5,314, 155, 215, buttonColor(xTouch, yTouch, 5, 314, 155, 215), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,314, 155, 215, black, BOTTOM_SCREEN )
		Screen.drawImage(8,158, bButton, BOTTOM_SCREEN)
		fprint(140,180, "Back", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 314, 155, 215, 'backToMenu') or trigger

		trigger = menuTrigger(xTouch, yTouch, 5, 210, 25, 85, 'bet') or trigger
		trigger = menuTrigger(xTouch, yTouch, 214, 314, 25, 55, 'plus') or trigger
		trigger = menuTrigger(xTouch, yTouch, 214, 314, 55, 85, 'minus') or trigger
		trigger = menuTrigger(xTouch, yTouch, 5, 105, 90, 150, 'bet50') or trigger
		trigger = menuTrigger(xTouch, yTouch, 109, 210, 90, 150, 'bet100') or trigger
		trigger = menuTrigger(xTouch, yTouch, 214, 314, 90, 150, 'bet500') or trigger
		trigger = menuTrigger(xTouch, yTouch, 5, 314, 155, 215, 'backToMenu') or trigger

	elseif currentState == 'offerInsurance' then
		Screen.fillRect(5,314, 25, 85, buttonColor(xTouch, yTouch, 5, 314, 25, 85), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,314, 25, 85, black, BOTTOM_SCREEN )
		Screen.drawImage(8,28, bButton, BOTTOM_SCREEN)
		fprint(80,50, "Decline Insurance", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 314, 25, 85, 'skipInsurance') or trigger

		Screen.fillRect(5,314, 90, 150, buttonColor(xTouch, yTouch, 5, 314, 90, 150), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,314, 90, 150, black, BOTTOM_SCREEN )
		Screen.drawImage(8,93, xButton, BOTTOM_SCREEN)
		fprint(70,115, "Buy Insurance ($"..math.floor(playerBet / 2.0)..")", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 314, 90, 150, 'buyInsurance') or trigger

		trigger = menuTrigger(xTouch, yTouch, 5, 314, 25, 85, 'skipInsurance') or trigger
		trigger = menuTrigger(xTouch, yTouch, 5, 314, 90, 150, 'buyInsurance') or trigger

	elseif currentState == 'playerTurn' then
		Screen.fillRect(5,314, 25, 85, buttonColor(xTouch, yTouch, 5, 314, 25, 85), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,314, 25, 85, black, BOTTOM_SCREEN )
		Screen.drawImage(8,28, aButton, BOTTOM_SCREEN)
		fprint(147,50, "Hit", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 314, 25, 85, 'hit') or trigger

		Screen.fillRect(5,314, 90, 150, buttonColor(xTouch, yTouch, 5, 314, 90, 150), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,314, 90, 150, black, BOTTOM_SCREEN )
		Screen.drawImage(8,93, bButton, BOTTOM_SCREEN)
		fprint(135,115, "Stand", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 314, 90, 150, 'stand') or trigger

		Screen.fillRect(5,105, 155, 215, buttonColor(xTouch, yTouch, 5, 105, 155, 215), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,105, 155, 215, black, BOTTOM_SCREEN )
		Screen.drawImage(8,158, xButton, BOTTOM_SCREEN)
		fprint(27,180, "Double", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 105, 155, 215, 'double') or trigger

		Screen.fillRect(109,210, 155, 215, buttonColor(xTouch, yTouch, 109, 210, 155, 215), BOTTOM_SCREEN )
		Screen.fillEmptyRect(109,210, 155, 215, black, BOTTOM_SCREEN )
		Screen.drawImage(112,158, yButton, BOTTOM_SCREEN)
		fprint(114,180, "Surrender", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 109, 210, 155, 215, 'surrender') or trigger

		Screen.fillRect(214,314, 155, 215, buttonColor(xTouch, yTouch, 214, 314, 155, 215), BOTTOM_SCREEN )
		Screen.fillEmptyRect(214,314, 155, 215, black, BOTTOM_SCREEN )
		Screen.drawImage(217,158, rButton, BOTTOM_SCREEN)
		fprint(243,180, "Split", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 214, 314, 155, 215, 'split') or trigger

		trigger = menuTrigger(xTouch, yTouch, 5, 314, 25, 85, 'hit') or trigger
		trigger = menuTrigger(xTouch, yTouch, 5, 314, 90, 150, 'stand') or trigger
		trigger = menuTrigger(xTouch, yTouch, 5, 105, 155, 215, 'double') or trigger
		trigger = menuTrigger(xTouch, yTouch, 109, 210, 155, 215, 'surrender') or trigger
		trigger = menuTrigger(xTouch, yTouch, 214, 314, 155, 215, 'split') or trigger

	elseif currentState == 'gameOver' then
		Screen.fillRect(5,314, 155, 215, buttonColor(xTouch, yTouch, 5, 314, 155, 215), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,314, 155, 215, black, BOTTOM_SCREEN )
		Screen.drawImage(8,158, xButton, BOTTOM_SCREEN)
		fprint(120,180, "New Game", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 314, 155, 215, 'restart') or trigger

		trigger = menuTrigger(xTouch, yTouch, 5, 314, 155, 215, 'restart') or trigger

	elseif currentState == 'statistics' then
		Screen.fillRect(5,314, 155, 215, buttonColor(xTouch, yTouch, 5, 314, 155, 215), BOTTOM_SCREEN )
		Screen.fillEmptyRect(5,314, 155, 215, black, BOTTOM_SCREEN )
		Screen.drawImage(8,158, bButton, BOTTOM_SCREEN)
		fprint(140,180, "Back", buttonText, BOTTOM_SCREEN)
		-- trigger = menuTrigger(xTouch, yTouch, 5, 314, 155, 215, 'backToMenu') or trigger

		trigger = menuTrigger(xTouch, yTouch, 5, 314, 155, 215, 'backToMenu') or trigger

	end

	-- Screen.drawLine(159,159,0,239, white, BOTTOM_SCREEN)
	-- Screen.drawLine(160,160,0,239, white, BOTTOM_SCREEN)
	return trigger
end

---------------------------------------------------------------------------

loadFiles()

Sound.init()

if bgmEnabled then
	Sound.play(bgm,LOOP)
	bgmStarted = true
end

moneyWriten = false

deck = getFreshDeck()


---------------------------------------------------------------------------

while true do
	Screen.waitVblankStart()

	if Screen.get3DLevel() == 0 then
		Screen.disable3D()
		three = nil
	else
		if three == nil then
			Screen.enable3D()
			three = true
		end
		level = Screen.get3DLevel()
	end

	pad = Controls.read()

	local touchX, touchY = Controls.readTouch()
	xTouch = touchX or 0
	yTouch = touchY or 0
	Screen.refresh()
	Screen.clear(TOP_SCREEN)
	Screen.clear(BOTTOM_SCREEN)
	
	fillRect3D(0, 399, 0, 239, background, TOP_SCREEN)
	Screen.fillRect(0, 319, 0, 239, background, BOTTOM_SCREEN)

	if playerBet > playerMoney then playerBet = playerMoney end
	menuResponse = drawAndCheckMenu()

	fprint(147,225, "Blackjack 3DS v0.4", white, BOTTOM_SCREEN)
	-- fprint(5,225, "d:"..debug, white, BOTTOM_SCREEN)
	
	if (currentState == 'menu') then
		if moneyWriten == false then
			writeMoneyFile()
			moneyWriten = true
		end


		if dealerHand then
			if (playerMoney > oldPlayerMoney) then
				fprint(5,5, "Cash: $"..playerMoney.." (+"..(playerMoney - oldPlayerMoney)..")", white, BOTTOM_SCREEN)
			else
				fprint(5,5, "Cash: $"..playerMoney.." ("..(playerMoney - oldPlayerMoney)..")", white, BOTTOM_SCREEN)
			end

			renderDealerPlayerLine()
			dealerHandValue = dealerHand.getValue()
			fprint3D(10,5,"Dealer: "..dealerHandValue,white)
			dealerHandRenderer(13, 17)
			for key, value in pairs(playerHands) do
				fprint3D(10+(200*(key-1)),126,value.getValue()..": $"..value.getBet().." ("..value.getResult()..")",white)
				playerHandRenderer(13+(200*(key-1)), 138, value)
			end

		else
			drawTitle()

			fprint(5,5, "Cash: $"..playerMoney, white, BOTTOM_SCREEN)
		end


		if ((menuResponse == 'newHand') or buttonPressed(KEY_A)) and (playerMoney >= minBet) then
			nextState = 'playerBet'
		end

		if (menuResponse == 'options') or buttonPressed(KEY_Y) then
			nextState = 'options'
		end

		if (menuResponse == 'statistics') or buttonPressed(KEY_X) then
			nextState = 'statistics'
		end

		if (menuResponse == 'exit') or buttonPressed(KEY_START) then
			-- Sound.pause(bgm)
			Sound.close(bgm)
			Sound.term()
			System.exit()
		end
		
	elseif (currentState == 'options') then
		if dealerHand then
			renderDealerPlayerLine()
			dealerHandValue = dealerHand.getValue()
			fprint3D(10,5,"Dealer: "..dealerHandValue,white)
			dealerHandRenderer(13, 17)
			for key, value in pairs(playerHands) do
				fprint3D(10+(200*(key-1)),126,value.getValue()..": $"..value.getBet().." ("..value.getResult()..")",white)
				playerHandRenderer(13+(200*(key-1)), 138, value)
			end
		else
			drawTitle()
		end

		fprint(5,5, "Options", white, BOTTOM_SCREEN)

		if (menuResponse == 'dealerStandsSoft17') then dealerHitsSoft17 = false end
		if (menuResponse == 'dealerHitsSoft17') then  dealerHitsSoft17 = true end
		if (menuResponse == 'insurance') then offerInsurance = true end
		if (menuResponse == 'noInsurance') then offerInsurance = false end
		if (menuResponse == 'bgmOn') then
			bgmEnabled = true
			if not bgmStarted then
				Sound.play(bgm,LOOP)
				bgmStarted = true
			elseif not Sound.isPlaying(bgm) then
				Sound.resume(bgm)
			end
		end
		if (menuResponse == 'bgmOff') then
			bgmEnabled = false
			if bgmStarted then Sound.pause(bgm) end
		end
		if (menuResponse == 'sfxOn') then sfxEnabled = true end
		if (menuResponse == 'sfxOff') then sfxEnabled = false end

		if (menuResponse == 'backToMenu') or (buttonPressed(KEY_B)) then
			writeSettingsFile()
			nextState = 'menu'
		end
		
	elseif (currentState == 'playerBet') then
		fprint(5,5, "Cash: $"..playerMoney, white, BOTTOM_SCREEN)
		renderDealerPlayerLine()

	  	if (menuResponse == 'bet') or buttonPressed(KEY_A) then
			nextState = 'turnStart'
		end

	  	if (menuResponse == 'plus') or Controls.check(pad,KEY_R) then
	  		if (playerBet < maxBet) and ((playerBet + betIncrement) <= playerMoney) then
	  			playerBet = playerBet + betIncrement
	  		end
		end

	  	if (menuResponse == 'minus') or Controls.check(pad,KEY_L) then
	  		if playerBet > minBet then
	  			playerBet = playerBet - betIncrement
	  		end
		end

		if (menuResponse == 'bet50') then
			if playerMoney >= 50 then
				playerBet = 50
			end
		end

		if (menuResponse == 'bet100') then
			if playerMoney >= 100 then
				playerBet = 100
			end
		end

		if (menuResponse == 'bet500') then
			if playerMoney >= 500 then
				playerBet = 500
			end
		end

		if (menuResponse == 'backToMenu') or (buttonPressed(KEY_B)) then
			dealerHand = nil
			nextState = 'menu'
		end

	elseif (currentState == 'turnStart') then
		incrementStatistic('handsPlayed')

		fprint(5,5, "Cash: $"..(playerMoney - moneyWagered()), white, BOTTOM_SCREEN)
		
		deck = getFreshDeck()
		
		dealerHand = newHand({})
		dealerHand.dealCard()
		dealerHand.dealCard()
	
		oldPlayerMoney = playerMoney
		playerHasInsurance = false
		playerDoubledDown = false
		playerHands = {}
		playerHandIndex = 1
		table.insert(playerHands, newHand({}, playerBet))
		playerHands[1].dealCard()
		playerHands[1].dealCard()

		playSFX('dealCard')
		
		if (dealerHand.getCards()[1][1] == 'A') and ((playerMoney - moneyWagered() - (playerBet / 2.0)) > 0) and offerInsurance then
			nextState = 'offerInsurance'
		elseif (playerHands[1].handStatus() == 'blackjack') then
			nextState = 'dealerTurn'
			playSFX('flipCard')
		else
			nextState = 'dealerPeek'
		end
		
	elseif (currentState == 'offerInsurance') then
		fprint(5,5, "Cash: $"..(playerMoney - moneyWagered()), white, BOTTOM_SCREEN)

		renderDealerPlayerLine()
	
		fprint3D(10,5,"Dealer",white)
		dealerHandRenderer(13, 17, true)
		
		playerHandValue = playerHands[1].getValue()
		fprint3D(10,126,playerHandValue..": $"..playerHands[1].getBet(),white)
		playerHandRenderer(13, 138, playerHands[1])

		if (menuResponse == 'buyInsurance') or buttonPressed(KEY_X) then
			playerHasInsurance = true
			if (playerHands[1].handStatus() == 'blackjack') then
				nextState = 'dealerTurn'
				playSFX('flipCard')
			else
				nextState = 'dealerPeek'
			end
		end

		if (menuResponse == 'skipInsurance') or buttonPressed(KEY_B) then
			if (playerHands[1].handStatus() == 'blackjack') then
				nextState = 'dealerTurn'
				playSFX('flipCard')
			else
				nextState = 'dealerPeek'
			end
		end

	elseif (currentState == 'dealerPeek') then
		fprint(5,5, "Cash: $"..(playerMoney - moneyWagered()), white, BOTTOM_SCREEN)
		renderDealerPlayerLine()
		fprint3D(10,5,"Dealer",white)
		dealerHandRenderer(13, 17, true)
		playerHandValue = playerHands[1].getValue()
		fprint3D(10,126,playerHandValue..": $"..playerHands[1].getBet(),white)
		playerHandRenderer(13, 138, playerHands[1])

		if (dealerHand.handStatus() == 'blackjack') then
			nextState = 'dealerTurn'
			playSFX('flipCard')
		else
			nextState = 'playerTurn'
		end

	elseif (currentState == 'playerTurn') then
		fprint(5,5, "Cash: $"..(playerMoney - moneyWagered()), white, BOTTOM_SCREEN)
		renderDealerPlayerLine()
		fprint3D(10,5,"Dealer",white)
		dealerHandRenderer(13, 17, true)
		for key, value in pairs(playerHands) do
			fprint3D(10+(200*(key-1)),126,value.getValue()..": $"..value.getBet(),white)
			if (key == playerHandIndex) and splitActive() then
				playerHandRenderer(13+(200*(key-1)), 138, value)
			else
				playerHandRenderer(13+(200*(key-1)), 138, value, cardSpritesDim)
			end
		end

		local currentHand = playerHands[playerHandIndex]
		local playerHandValue = currentHand.getValue()
		
		if (playerHandValue > 21) or (playerHandValue == 21) or ((currentHand.getDoubledDown() == true) and (currentHand.getSize() > 2)) then
			if (playerHandIndex == 1) and splitActive() then -- split active
				playerHandIndex = 2
			else
				nextState = 'dealerTurn'
				playSFX('flipCard')
			end
		end

		if (menuResponse == 'stand') or buttonPressed(KEY_B) then
			if (playerHandIndex == 1) and splitActive() then -- split active
				playerHandIndex = 2
			else
				nextState = 'dealerTurn'
				playSFX('flipCard')
			end
		elseif (menuResponse == 'hit') or buttonPressed(KEY_A) then
			currentHand.dealCard()

			playSFX('dealCard')
		end

		if (currentHand.getSize() == 2) and (currentHand.getDoubledDown() == false) and ((playerMoney - moneyWagered() - playerBet) >= 0) then
			if (menuResponse == 'double') or buttonPressed(KEY_X) then
				currentHand.doubleDown()
				playSFX('flipCard')
			end
		else
			Screen.fillRect(5,105, 155, 215, background, BOTTOM_SCREEN )
		end

		if not(splitActive()) and (currentHand.canSplit() == true) and (currentHand.getDoubledDown() == false) and ((playerMoney - moneyWagered() - playerBet) >= 0) then 
			if (menuResponse == 'split') or buttonPressed(KEY_R) then
				local cards = playerHands[1].getCards()
				local bet = playerHands[1].getBet()
				playerHands = { newHand({cards[1]}, bet), newHand({cards[2]}, bet) }
				playerHands[1].dealCard()
				playerHands[2].dealCard()

				incrementStatistic('handsPlayed')
				playSFX('dealCard')
			end
		else -- hide button
			Screen.fillRect(214,314, 155, 215, background, BOTTOM_SCREEN )
		end

		if (getTableSize(playerHands) == 1) and (currentHand.getSize() == 2) and (currentHand.getDoubledDown() == false) then
			if (menuResponse == 'surrender') or buttonPressed(KEY_Y) then
				currentHand.setResult('Surrendered')
				nextState = 'dealerTurn'
				playSFX('flipCard')
			end
		else
			Screen.fillRect(109,210, 155, 215, background, BOTTOM_SCREEN )
		end

	elseif (currentState == 'dealerTurn') then
		fprint(5,5, "Cash: $"..(playerMoney - moneyWagered()), white, BOTTOM_SCREEN)
		renderDealerPlayerLine()
		dealerHandValue = dealerHand.getValue()
		fprint3D(10,5,"Dealer: "..dealerHandValue,white)
		dealerHandRenderer(13, 17)
		for key, value in pairs(playerHands) do
			fprint3D(10+(200*(key-1)),126,value.getValue()..": $"..value.getBet(),white)
			playerHandRenderer(13+(200*(key-1)), 138, value)
		end

		dealerAnimationCounter = dealerAnimationCounter + 1
		if dealerCanReceiveCard() then
			if (dealerAnimationCounter > 20) then
				dealerHand.dealCard()
				dealerAnimationCounter = 0
				playSFX('dealCard')
			end
		else
			if (dealerAnimationCounter > 10) then
				dealerAnimationCounter = 0

				if (playerHasInsurance == true) then
					if (dealerHand.handStatus() == 'blackjack') then
						playerMoney = playerMoney + playerBet -- to cancel out the bet that will be removed
						playerHands[1].setResult("Insured")
						incrementStatistic('handsLost')
					else
						playerMoney = playerMoney - (playerBet / 2.0)
					end
				end

				for key, value in pairs(playerHands) do
					playerHandValue = value.getValue()
					dealerHandValue = dealerHand.getValue()
					if value.getResult() == 'Surrendered' then -- player already surrendered
						playerMoney = playerMoney - (playerBet / 2.0)
						incrementStatistic('handsSurrended')
						incrementStatistic('handsLost')
					elseif value.handStatus() == 'bust' then -- player bust
						playerMoney = playerMoney - value.getBet()
						value.setResult("Lost")
						incrementStatistic('handsLost')

					elseif value.handStatus() == 'blackjack' then -- player has blackjack
						if dealerHand.handStatus() == 'blackjack' then -- dealer also has blackjack
							value.setResult("Push")
							incrementStatistic('handsPushed')
						else
							if splitActive() then
								playerMoney = playerMoney + value.getBet()
								value.setResult("Won")
								incrementStatistic('handsWon')
							else
								playerMoney = playerMoney + value.getBet() * 1.5
								value.setResult("Blackjack")
								incrementStatistic('handsWon')
								incrementStatistic('handsWonBlackjack')
							end
						end
					elseif dealerHand.handStatus() == 'blackjack' then -- dealer blackjack always wins unless player has blackjack
						playerMoney = playerMoney - value.getBet()
						if (playerHasInsurance == false) then
							value.setResult("Lost")
							incrementStatistic('handsLost')
						end
					elseif dealerHand.handStatus() == 'bust' then -- dealer bust
						playerMoney = playerMoney + value.getBet()
						value.setResult("Won")
						incrementStatistic('handsWon')
					elseif (dealerHandValue > playerHandValue) then -- dealer high
						playerMoney = playerMoney - value.getBet()
						value.setResult("Lost")
						incrementStatistic('handsLost')
					elseif (dealerHandValue < playerHandValue) then -- player high
						playerMoney = playerMoney + value.getBet()
						value.setResult("Won")
						incrementStatistic('handsWon')
					elseif (dealerHandValue == playerHandValue) then -- push
						value.setResult("Push")
						incrementStatistic('handsPushed')
					end
				end

				playerMoney = math.floor(playerMoney)
				if playerMoney > playerStatistics['highestMoney'] then
					playerStatistics['highestMoney'] = playerMoney
				end

				if (playerMoney >= minBet) then
					nextState = 'menu'
					moneyWriten = false

				else
					nextState = 'gameOver'
					moneyWriten = false
				end
			end

		end

	elseif currentState == 'gameOver' then
		fprint(5,5, "Game Over", white, BOTTOM_SCREEN)

		if not moneyWriten then
			writeMoneyFile()
			moneyWriten = true
		end

		renderDealerPlayerLine()
		dealerHandValue = dealerHand.getValue()
		fprint3D(10,5,"Dealer: "..dealerHandValue,white)
		dealerHandRenderer(13, 17)
		for key, value in pairs(playerHands) do
			fprint3D(10+(200*(key-1)),126,value.getValue()..": $"..value.getBet().." ("..value.getResult()..")",white)
			playerHandRenderer(13+(200*(key-1)), 138, value)
		end

		renderStats()

		if (menuResponse == 'restart') or (buttonPressed(KEY_X)) then
			playerMoney = 1000
			resetStatistics()
			playerBet = 100
			dealerHand = nil -- will reset the menu
			moneyWriten = false
			nextState = 'menu'
		end

	elseif currentState == 'statistics' then
		if dealerHand then
			renderDealerPlayerLine()
			dealerHandValue = dealerHand.getValue()
			fprint3D(10,5,"Dealer: "..dealerHandValue,white)
			dealerHandRenderer(13, 17)
			for key, value in pairs(playerHands) do
				fprint3D(10+(200*(key-1)),126,value.getValue()..": $"..value.getBet().." ("..value.getResult()..")",white)
				playerHandRenderer(13+(200*(key-1)), 138, value)
			end
		else
			drawTitle()
		end

		fprint(5,5, "Statistics", white, BOTTOM_SCREEN)

		renderStats()

		if (menuResponse == 'backToMenu') or (buttonPressed(KEY_B)) then
			nextState = 'menu'
		end
	end
	
	playerMoney = math.floor(playerMoney)
	oldPad = pad
	oldX, oldY = xTouch, yTouch
	currentState = nextState
	Screen.flip()
end