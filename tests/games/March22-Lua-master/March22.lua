--[[
	March22-Lua
		Coded in Lua to be used by lpp-vita/love2d
		Code covered by MIT licensing
	By Sam 'Slynch' Lynch
	
	lpp-vita is an open-source project by rinnegatamante
--]]

--Namespace
March22 = {};
March22.version = {0, 7, 0}; -- Major, minor, revision
print("Loading March22 v"..March22.version[1]..".".. March22.version[2] ..".".. March22.version[3]);

March22.currentPage = "";

--CONSTANTS
maxChar = 106; -- Max number of characters to a line of text
FONTSIZE = 25; -- Size of text fonts
March22.TEXTBOX = Graphics.loadImage("graphics/textbox.png"); -- Textbox graphic (doesn't change so constant)
March22.TEXTBOX_NARRATIVE = Graphics.loadImage("graphics/textbox_narrative.png"); -- Textbox graphic (doesn't change so constant)

-- Graphics/icons for PSV icons, constant
March22.CIRCLE_BUTTON_GRAPHIC = Graphics.loadImage("graphics/circle_icon.png");
March22.TRIANGLE_BUTTON_GRAPHIC = Graphics.loadImage("graphics/triangle_icon.png");
March22.SQUARE_BUTTON_GRAPHIC = Graphics.loadImage("graphics/square_icon.png");

-- Initialise the loaded backgrounds array and load black/white (since they're constant)
LOADEDBACKGROUNDS = {};
LOADEDBACKGROUNDS["black"] = Graphics.loadImage("graphics/black.jpg");
LOADEDBACKGROUNDS["white"] = Graphics.loadImage("graphics/white.jpg");

-- Init and load regular and bold fonts (constant)
March22.FONT             = Font.load("graphics/font.ttf");
March22.FONT_BOLD        = Font.load("graphics/font_bold.ttf");
-- And set size
Font.setPixelSizes(March22.FONT_BOLD, FONTSIZE);
Font.setPixelSizes(March22.FONT   , FONTSIZE);

-- This is so we don't waste RAM init'ing the color white 1000+ times
March22.WHITE_COLOUR = Color.new(255,255,255);

-- For when animations are playing and the text box shouldn't show
March22.DRAW_TEXTBOX = true;

-- Init the required content for the main menu first
dofile("March22_save.lua");
dofile("March22_sound.lua");
dofile("March22_controls.lua");
dofile("March22_mainmenu.lua");

-- The main menu has ended, so load the rest
dofile("LUA_CLASSES/Line.lua");
dofile("LUA_CLASSES/Character.lua");
dofile("LUA_CLASSES/Decision.lua");
dofile("March22_character.lua");
dofile("March22_labels.lua");

-- Load the first script file; this will be eventually called "index" or "entrypoint.lua"
--dofile("scripts/script-a1-monday.lua");

-- Init the active variables with the first line of the script
--March22.ACTIVECHARACTER_NAME = ACTIVE_SCRIPT[1].speaker; 
--March22.ACTIVESPEECH = ACTIVE_SCRIPT[1].content;
--March22.ACTIVECHARACTER_COLOR = ACTIVE_SCRIPT[1].color;

--Load the remaining includes
dofile("March22_background.lua");
dofile("March22_script.lua");
dofile("March22_font.lua");

-- Renders the current frame
function March22.Render()
	
	-- Draw the background if it exists
	if March22.ACTIVEBACKGROUND == nil then
		--do nothing, but should draw "black" really
	else
		Graphics.drawImage(0, 0, March22.ACTIVEBACKGROUND);
	end
  
	-- Iterate through the active characters array and draw them
	for k in pairs(March22.ACTIVECHARACTERS) do
		March22.ACTIVECHARACTERS[k].Update();
			Graphics.drawImage(
				March22.ACTIVECHARACTERS[k].x,
				March22.ACTIVECHARACTERS[k].y,
				March22.CHARACTERS[March22.ACTIVECHARACTERS[k].name].sprites[March22.ACTIVECHARACTERS[k].emotion],
		  March22.ACTIVECHARACTERS[k].color
			);
	end
	
	-- If allowed, draw the text box and text
	--if March22.DRAW_TEXTBOX == true then
		if March22.ACTIVECHARACTER_NAME == "" then
			Graphics.drawImage(0, 0, March22.TEXTBOX_NARRATIVE);
		else
			Graphics.drawImage(0, 0, March22.TEXTBOX);
		end
		--Font.print(March22.FONT_BOLD, 18, 370, March22.ACTIVECHARACTER_NAME, March22.ACTIVECHARACTER_COLOR);
		March22.DrawTypeWriterEffect(March22.FONT, 42, 42, March22.currentPage, Color.new(255, 255, 255))
	--end
	
end
