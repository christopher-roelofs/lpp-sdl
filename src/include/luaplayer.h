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
#- Credits : -----------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#- Smealum for ctrulib and ftpony src ----------------------------------------------------------------------------------#
#- StapleButter for debug font -----------------------------------------------------------------------------------------#
#- Lode Vandevenne for lodepng -----------------------------------------------------------------------------------------#
#- Jean-loup Gailly and Mark Adler for zlib ----------------------------------------------------------------------------#
#- Special thanks to Aurelio for testing, bug-fixing and various help with codes and implementations -------------------#
#-----------------------------------------------------------------------------------------------------------------------*/

#ifndef __LUAPLAYER_H
#define __LUAPLAYER_H

#include <SDL_image.h>
#include <SDL_ttf.h>
#include <sqlite3.h>
#include <stdlib.h>
#include <lua.hpp>
//#include <vitasdk.h> // Porting to SDL: VitaSDK not available
//#include <vita2d.h> // Porting to SDL: Vita2D not available

extern void luaC_collectgarbage (lua_State *L);
extern TTF_Font* g_defaultFont; // Global default font for Graphics.print
extern bool should_exit; // Global flag to signal application exit
extern bool g_vita_compat_mode; // Global flag for Vita compatibility mode
extern bool g_dual_screen_mode; // Global flag for 3DS dual screen mode

// Screen dimensions - defined here for global access (Vita resolution)
const int SCREEN_WIDTH = 960;
const int SCREEN_HEIGHT = 544;

// Native mode logical resolution (HD 720p for good scaling)
const int NATIVE_LOGICAL_WIDTH = 1280;
const int NATIVE_LOGICAL_HEIGHT = 720;

// 3DS dual screen support
const int DUAL_SCREEN_HEIGHT = SCREEN_HEIGHT * 2; // Total height for both screens
const int TOP_SCREEN_Y_OFFSET = 0;                // Top screen starts at Y=0
const int BOTTOM_SCREEN_Y_OFFSET = SCREEN_HEIGHT; // Bottom screen starts at Y=544

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define CLAMP(val, min, max) ((val)>(max)?(max):((val)<(min)?(min):(val)))

#define ASYNC_TASKS_MAX 1

const char *runScript(const char* script, bool isStringBuffer);
void luaC_collectgarbage (lua_State *L);

void luaControls_init(lua_State *L);
void luaCamera_init(lua_State *L);
void luaScreen_init(lua_State *L);
void luaGraphics_init(lua_State *L);
void luaSound_init(lua_State *L);
void luaSystem_init(lua_State *L);
void luaNetwork_init(lua_State *L);
void luaTimer_init(lua_State *L);
void luaKeyboard_init(lua_State *L);
void luaRender_init(lua_State *L);
void luaMic_init(lua_State *L);
void luaVideo_init(lua_State *L);
void luaDatabase_init(lua_State *L);
void luaRegistry_init(lua_State *L);
void luaGui_init(lua_State *L);

// lua-compat
#define lua_callk(L, na, nr, ctx, cont) ((void)(ctx), (void)(cont), lua_call(L, na, nr))
#define lua_rawlen(L, i) lua_objlen(L, i)
#define LUA_OK 0

// Internal variables  
extern int clr_color;
typedef struct {
    TTF_Font* font;     // Pointer to the SDL_ttf font object
    int size;           // Store the font size
    unsigned int magic; // For runtime type checking (e.g., 0xABADF011)
} lpp_font;
extern bool unsafe_mode;
extern bool keyboardStarted;
extern bool messageStarted;
//extern SceCommonDialogConfigParam cmnDlgCfgParam; // Porting to SDL: Vita type
extern volatile bool termMic;
//extern int micThread(SceSize args, void* argc); // Porting to SDL: Vita type SceSize
//extern SceUID Mic_Mutex; // Porting to SDL: Vita type SceUID
extern volatile int asyncResult;
extern uint8_t async_task_num;
extern unsigned char* asyncStrRes;
extern uint32_t asyncResSize;
extern float video_audio_tick;

// Internal structs
struct lpp_texture{
	uint32_t magic;
	void* texture; // SDL_Texture* for SDL port
	void *data;
	int w, h; // Texture dimensions for SDL port
};

struct DecodedMusic{
	uint8_t* audiobuf;
	uint8_t* audiobuf2;
	uint8_t* cur_audiobuf;
	FILE* handle;
	volatile bool isPlaying;
	bool loop;
	volatile bool pauseTrigger;
	volatile bool closeTrigger;
	volatile uint8_t audioThread;
	volatile int volume;
	char filepath[256];
	char title[256];
	char author[256];
	bool tempBlock;
};

#endif
