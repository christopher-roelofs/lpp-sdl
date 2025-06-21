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
#- SDL Port: System Module Stub (TODO: Implement essential file/system functions) -------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------*/

#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <time.h>
#include "luaplayer.h"

// External flag for exit requests (defined in main_sdl.cpp)
extern bool should_exit;

#define stringify(str) #str
#define VariableRegister(lua, value) do { lua_pushinteger(lua, value); lua_setglobal (lua, stringify(value)); } while(0)

// File mode constants (use standard POSIX values)
static int FREAD = 0;    // O_RDONLY
static int FWRITE = 1;   // O_WRONLY  
static int FCREATE = 2;  // O_CREAT
static int FRDWR = 2;    // O_RDWR

// Power constants (stubbed)
static uint32_t AUTO_SUSPEND_TIMER = 0;
static uint32_t OLED_SCREEN_TIMER = 1;

// Extract mode constants
enum {
	FULL_EXTRACT,
	PARTIAL_EXTRACT
};

// SDL Port: Basic system functions implemented, advanced Vita-specific features stubbed
// File operations use standard C library functions

static int lua_exit(lua_State *L) { 
	printf("System.exit() called - setting exit flag\n");
	fflush(stdout);
	should_exit = true; 
	return 0; 
}
static int lua_wait(lua_State *L) { 
	int ms = luaL_checkinteger(L, 1);
	usleep(ms * 1000); 
	return 0; 
}

static int lua_currentDirectory(lua_State *L) { 
	char* cwd = getcwd(NULL, 0);
	if (cwd) {
		lua_pushstring(L, cwd);
		free(cwd);
	} else {
		lua_pushstring(L, ".");
	}
	return 1; 
}

static int lua_listDirectory(lua_State *L) {
	// TODO: Implement directory listing
	lua_newtable(L);
	return 1;
}

static int lua_doesFileExist(lua_State *L) {
	const char* path = luaL_checkstring(L, 1);
	struct stat st;
	lua_pushboolean(L, (stat(path, &st) == 0));
	return 1;
}

static int lua_doesDirExist(lua_State *L) {
	const char* path = luaL_checkstring(L, 1);
	struct stat st;
	lua_pushboolean(L, (stat(path, &st) == 0 && S_ISDIR(st.st_mode)));
	return 1;
}

static int lua_createDirectory(lua_State *L) {
	const char* path = luaL_checkstring(L, 1);
	lua_pushinteger(L, mkdir(path, 0755));
	return 1;
}

static int lua_deleteFile(lua_State *L) {
	const char* path = luaL_checkstring(L, 1);
	lua_pushinteger(L, remove(path));
	return 1;
}

static int lua_deleteDirectory(lua_State *L) {
	const char* path = luaL_checkstring(L, 1);
	lua_pushinteger(L, rmdir(path));
	return 1;
}

static int lua_rename(lua_State *L) {
	const char* old_path = luaL_checkstring(L, 1);
	const char* new_path = luaL_checkstring(L, 2);
	lua_pushinteger(L, rename(old_path, new_path));
	return 1;
}

static int lua_getFileSize(lua_State *L) {
	const char* path = luaL_checkstring(L, 1);
	struct stat st;
	if (stat(path, &st) == 0) {
		lua_pushinteger(L, st.st_size);
	} else {
		lua_pushinteger(L, -1);
	}
	return 1;
}

// Stubbed functions for features not essential to basic operation
static int lua_openFile(lua_State *L) { lua_pushlightuserdata(L, NULL); return 1; }
static int lua_readFile(lua_State *L) { lua_pushstring(L, ""); return 1; }
static int lua_writeFile(lua_State *L) { return 0; }
static int lua_closeFile(lua_State *L) { return 0; }
static int lua_seekFile(lua_State *L) { return 0; }
static int lua_sizeFile(lua_State *L) { lua_pushinteger(L, 0); return 1; }
static int lua_getTitleID(lua_State *L) { lua_pushstring(L, "UNKNOWN"); return 1; }
static int lua_getBatteryLevel(lua_State *L) { lua_pushinteger(L, 100); return 1; }
static int lua_isBatteryCharging(lua_State *L) { lua_pushboolean(L, 0); return 1; }
static int lua_getTime(lua_State *L) { lua_pushinteger(L, (int)time(NULL)); return 1; }
static int lua_extractZIP(lua_State *L) { return 0; }
static int lua_createZIP(lua_State *L) { return 0; }
static int lua_messageBox(lua_State *L) { return 0; }
static int lua_setGpuXbarSpeed(lua_State *L) { return 0; } // GPU frequency control not available on SDL

//Register our System Functions
static const luaL_Reg System_functions[] = {
  {"exit",                  lua_exit},
  {"wait",                  lua_wait},
  {"currentDirectory",      lua_currentDirectory},
  {"listDirectory",         lua_listDirectory},
  {"doesFileExist",         lua_doesFileExist},
  {"doesDirExist",          lua_doesDirExist},
  {"createDirectory",       lua_createDirectory},
  {"deleteFile",            lua_deleteFile},
  {"deleteDirectory",       lua_deleteDirectory},
  {"rename",                lua_rename},
  {"getFileSize",           lua_getFileSize},
  {"openFile",              lua_openFile},
  {"readFile",              lua_readFile},
  {"writeFile",             lua_writeFile},
  {"closeFile",             lua_closeFile},
  {"seekFile",              lua_seekFile},
  {"sizeFile",              lua_sizeFile},
  {"getTitleID",            lua_getTitleID},
  {"getBatteryLevel",       lua_getBatteryLevel},
  {"isBatteryCharging",     lua_isBatteryCharging},
  {"getTime",               lua_getTime},
  {"extractZIP",            lua_extractZIP},
  {"createZIP",             lua_createZIP},
  {"messageBox",            lua_messageBox},
  {"setGpuXbarSpeed",       lua_setGpuXbarSpeed},
  {0, 0}
};

void luaSystem_init(lua_State *L) {
	lua_newtable(L);
	luaL_setfuncs(L, System_functions, 0);
	lua_setglobal(L, "System");
	VariableRegister(L, FREAD);
	VariableRegister(L, FWRITE);
	VariableRegister(L, FCREATE);
	VariableRegister(L, FRDWR);
	VariableRegister(L, FULL_EXTRACT);
	VariableRegister(L, PARTIAL_EXTRACT);
	VariableRegister(L, AUTO_SUSPEND_TIMER);
	VariableRegister(L, OLED_SCREEN_TIMER);
}