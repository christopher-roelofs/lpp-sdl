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
#- SDL Port: Render Module Stub (3D Rendering) -------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------*/

#include <stdlib.h>
#include <string.h>
#include "luaplayer.h"

#define stringify(str) #str
#define VariableRegister(lua, value) do { lua_pushinteger(lua, value); lua_setglobal (lua, stringify(value)); } while(0)

// Model constants
enum {
	VERTEX_POSITION = 0,
	VERTEX_TEXTURE = 1,
	VERTEX_NORMAL = 2,
	VERTEX_COLOR = 3
};

// SDL Port: All 3D rendering functions are stubbed out since 3D is not essential for basic LPP operation
// These functions return appropriate default values to prevent Lua script errors

static int lua_createModel(lua_State *L) { lua_pushlightuserdata(L, NULL); return 1; }
static int lua_loadModel(lua_State *L) { lua_pushlightuserdata(L, NULL); return 1; }
static int lua_drawModel(lua_State *L) { return 0; }
static int lua_useTexture(lua_State *L) { return 0; }
static int lua_loadObject(lua_State *L) { lua_pushlightuserdata(L, NULL); return 1; }
static int lua_setCamera(lua_State *L) { return 0; }
static int lua_init3D(lua_State *L) { return 0; }
static int lua_term3D(lua_State *L) { return 0; }

//Register our Render Functions
static const luaL_Reg Render_functions[] = {
  {"createModel",   lua_createModel},
  {"loadModel",     lua_loadModel},
  {"drawModel",     lua_drawModel},
  {"useTexture",    lua_useTexture},
  {"loadObject",    lua_loadObject}, 
  {"setCamera",     lua_setCamera},
  {"init",          lua_init3D},
  {"term",          lua_term3D},
  {0, 0}
};

void luaRender_init(lua_State *L) {
	lua_newtable(L);
	luaL_setfuncs(L, Render_functions, 0);
	lua_setglobal(L, "Render");
	VariableRegister(L, VERTEX_POSITION);
	VariableRegister(L, VERTEX_TEXTURE);
	VariableRegister(L, VERTEX_NORMAL);
	VariableRegister(L, VERTEX_COLOR);
}