/*----------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#------  This File is Part Of : ----------------------------------------------------------------------------------------#
#------- _  -------------------  ______   _   --------------------------------------------------------------------------#
#------ | | ------------------- (_____ \ | |  --------------------------------------------------------------------------#
#------ | | ---  _   _   ____    _____) )| |  ____  _   _   ____   ____   ----------------------------------------------#
#------ | | --- | | | | / _  |  |  ____/ | | / _  || | | | / _  ) / ___)  ----------------------------------------------#
#------ | |_____| |_| |( ( | |  | |      | |( ( | || |_| |( (/ / | |  --------------------------------------------------#
#------ |_______)\____| \_||_|  |_|      |_| \_||_| \__  | \____)|_|  --------------------------------------------------#
#------------------------------------------------- (____/  -------------------------------------------------------------#
#------------------------   ______   _   -------------------------------------------------------------------------------#
#------------------------  (_____ \ | |  -------------------------------------------------------------------------------#
#------------------------   _____) )| | _   _   ___   ------------------------------------------------------------------#
#------------------------  |  ____/ | || | | | /___)  ------------------------------------------------------------------#
#------------------------  | |      | || |_| ||___ |  ------------------------------------------------------------------#
#------------------------  |_|      |_| \____|(___/   ------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#- Licensed under the GPL License --------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#- Copyright (c) Nanni <lpp.nanni@gmail.com> ---------------------------------------------------------------------------#
#- Copyright (c) Rinnegatamante <rinnegatamante@gmail.com> -------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#- SDL Port: GUI Module Stub -------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------*/

#include <stdlib.h>
#include <string.h>
#include "luaplayer.h"

#define stringify(str) #str
#define VariableRegister(lua, value) do { lua_pushinteger(lua, value); lua_setglobal (lua, stringify(value)); } while(0)

// Theme constants
enum {
	DARK_THEME,
	LIGHT_THEME,
	CLASSIC_THEME
};

// Set mode constants
enum {
	SET_ONCE,
	SET_ALWAYS
};

// Flag constants
enum {
	FLAG_NONE             = 0,
	FLAG_NO_MOVE          = 1 << 1,
	FLAG_NO_RESIZE        = 1 << 2,
	FLAG_NO_SCROLLBAR     = 1 << 3,
	FLAG_NO_TITLEBAR      = 1 << 4,
	FLAG_NO_COLLAPSE      = 1 << 5,
	FLAG_HORIZONTAL_SCROLLBAR = 1 << 11
};

// SDL Port: All GUI functions are stubbed out since ImGui is not essential for basic LPP operation
// These functions return appropriate default values to prevent Lua script errors

static int lua_init(lua_State *L) { return 0; }
static int lua_config(lua_State *L) { return 0; }
static int lua_term(lua_State *L) { return 0; }
static int lua_initblend(lua_State *L) { return 0; }
static int lua_termblend(lua_State *L) { return 0; }
static int lua_settheme(lua_State *L) { return 0; }
static int lua_smmenubar(lua_State *L) { lua_pushboolean(L, 0); return 1; }
static int lua_emmenubar(lua_State *L) { return 0; }
static int lua_smenu(lua_State *L) { lua_pushboolean(L, 0); return 1; }
static int lua_emenu(lua_State *L) { return 0; }
static int lua_mitem(lua_State *L) { lua_pushboolean(L, 0); return 1; }
static int lua_swindow(lua_State *L) { lua_pushboolean(L, 0); return 1; }
static int lua_ewindow(lua_State *L) { return 0; }
static int lua_label(lua_State *L) { return 0; }
static int lua_button(lua_State *L) { lua_pushboolean(L, 0); return 1; }
static int lua_checkbox(lua_State *L) { lua_pushboolean(L, 0); return 1; }
static int lua_radio(lua_State *L) { lua_pushboolean(L, 0); return 1; }
static int lua_input(lua_State *L) { lua_pushstring(L, ""); return 1; }
static int lua_multiinput(lua_State *L) { lua_pushstring(L, ""); return 1; }
static int lua_winpos(lua_State *L) { return 0; }
static int lua_winsize(lua_State *L) { return 0; }
static int lua_separator(lua_State *L) { return 0; }
static int lua_slider(lua_State *L) { lua_pushnumber(L, 0.0); return 1; }
static int lua_islider(lua_State *L) { lua_pushinteger(L, 0); return 1; }
static int lua_tooltip(lua_State *L) { return 0; }
static int lua_combobox(lua_State *L) { lua_pushinteger(L, 0); return 1; }
static int lua_cursorpos(lua_State *L) { return 0; }
static int lua_textsize(lua_State *L) { lua_pushinteger(L, 10); lua_pushinteger(L, 10); return 2; }
static int lua_progressbar(lua_State *L) { return 0; }
static int lua_colorpicker(lua_State *L) { lua_pushinteger(L, 0xFFFFFFFF); return 1; }
static int lua_widgetwidth(lua_State *L) { return 0; }
static int lua_widgetwidthr(lua_State *L) { return 0; }
static int lua_listbox(lua_State *L) { lua_pushinteger(L, 0); return 1; }
static int lua_gimg(lua_State *L) { return 0; }

//Register our Gui Functions
static const luaL_Reg Gui_functions[] = {
  {"init",                lua_init},
  {"term",                lua_term},
  {"initBlend",           lua_initblend},
  {"termBlend",           lua_termblend},
  {"setTheme",            lua_settheme},
  {"initMenubar",         lua_smmenubar},
  {"termMenubar",         lua_emmenubar},
  {"initMenu",            lua_smenu},
  {"termMenu",            lua_emenu},
  {"initWindow",          lua_swindow},
  {"drawLabel",           lua_label},
  {"drawButton",          lua_button},
  {"drawCheckbox",        lua_checkbox},
  {"drawRadioButton",     lua_radio},
  {"drawTextInput",       lua_input},
  {"drawMultilineTextInput", lua_multiinput},
  {"termWindow",          lua_ewindow},
  {"setWindowPos",        lua_winpos},
  {"setWindowSize",       lua_winsize},
  {"drawSeparator",       lua_separator},
  {"drawSlider",          lua_slider},
  {"drawIntSlider",       lua_islider},
  {"drawMenuItem",        lua_mitem},
  {"drawTooltip",         lua_tooltip},
  {"setInputMode",        lua_config},
  {"drawComboBox",        lua_combobox},
  {"setWidgetPos",        lua_cursorpos},
  {"getTextSize",         lua_textsize},
  {"drawProgressbar",     lua_progressbar},
  {"drawColorPicker",     lua_colorpicker},
  {"setWidgetWidth",      lua_widgetwidth},
  {"resetWidgetWidth",    lua_widgetwidthr},
  {"drawListBox",         lua_listbox},
  {"drawImage",           lua_gimg},
  {0, 0}
};

void luaGui_init(lua_State *L) {
	lua_newtable(L);
	luaL_setfuncs(L, Gui_functions, 0);
	lua_setglobal(L, "Gui");
	VariableRegister(L,DARK_THEME);
	VariableRegister(L,LIGHT_THEME);
	VariableRegister(L,CLASSIC_THEME);
	VariableRegister(L,SET_ONCE);
	VariableRegister(L,SET_ALWAYS);
	VariableRegister(L,FLAG_NONE);
	VariableRegister(L,FLAG_NO_COLLAPSE);
	VariableRegister(L,FLAG_NO_MOVE);
	VariableRegister(L,FLAG_NO_RESIZE);
	VariableRegister(L,FLAG_NO_SCROLLBAR);
	VariableRegister(L,FLAG_NO_TITLEBAR);
	VariableRegister(L,FLAG_HORIZONTAL_SCROLLBAR);
}