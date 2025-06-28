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
// Compatibility mode enum
typedef enum {
    LPP_COMPAT_NATIVE = 0,  // Native SDL mode - no compatibility layer
    LPP_COMPAT_VITA = 1,    // Vita compatibility mode
    LPP_COMPAT_3DS = 2      // 3DS compatibility mode
} lpp_compat_mode_t;

// 3DS screen orientation enum
typedef enum {
    LPP_3DS_HORIZONTAL = 0, // Side-by-side layout (default)
    LPP_3DS_VERTICAL = 1    // Top/bottom layout (more authentic)
} lpp_3ds_orientation_t;

extern lpp_compat_mode_t g_compat_mode; // Global compatibility mode
extern lpp_3ds_orientation_t g_3ds_orientation; // 3DS screen orientation (horizontal/vertical)
extern bool g_vita_compat_mode; // Global flag for Vita compatibility mode (deprecated, use g_compat_mode)
extern bool g_dual_screen_mode; // Global flag for 3DS dual screen mode (deprecated, use g_compat_mode)
extern bool g_3ds_single_screen_mode; // Global flag for 3DS single-screen mode on small displays
extern int g_3ds_active_screen; // Currently active screen in single-screen mode (0=top, 1=bottom)
extern bool g_debug_mode; // Global flag for debug output
extern bool g_headless_mode; // Global flag for headless mode (no GUI)
extern float g_scale_x; // Manual scaling factor for dual screen X
extern float g_scale_y; // Manual scaling factor for dual screen Y
extern float g_top_screen_scale_x; // Top screen X scaling factor
extern float g_top_screen_scale_y; // Top screen Y scaling factor  
extern float g_bottom_screen_scale_x; // Bottom screen X scaling factor
extern float g_bottom_screen_scale_y; // Bottom screen Y scaling factor

// Helper functions for per-screen scaling and viewport management
void getScreenScaling(int screen_id, float* scale_x, float* scale_y);
void setScreenViewport(int screen_id);

// Screen dimensions - defined here for global access (Vita resolution)
const int SCREEN_WIDTH = 960;
const int SCREEN_HEIGHT = 544;

// Native mode logical resolution (set dynamically based on display)
extern int NATIVE_LOGICAL_WIDTH;
extern int NATIVE_LOGICAL_HEIGHT;

// 3DS dual screen support - HORIZONTAL (side-by-side) and VERTICAL (top/bottom) layouts
// 3DS screen dimensions: Top screen 400x240, Bottom screen 320x240
const int DS_TOP_SCREEN_WIDTH = 400;
const int DS_TOP_SCREEN_HEIGHT = 240;
const int DS_BOTTOM_SCREEN_WIDTH = 320;
const int DS_BOTTOM_SCREEN_HEIGHT = 240;

// HORIZONTAL layout (side-by-side) - original layout
const int DUAL_SCREEN_WIDTH_H = DS_TOP_SCREEN_WIDTH + DS_BOTTOM_SCREEN_WIDTH;  // Total width: 400 + 320 = 720
const int DUAL_SCREEN_HEIGHT_H = DS_TOP_SCREEN_HEIGHT;                         // Height: 240 (top screen height)
const int TOP_SCREEN_X_OFFSET_H = 0;                                          // Top screen starts at X=0 
const int TOP_SCREEN_Y_OFFSET_H = 0;                                          // Top screen starts at Y=0
const int BOTTOM_SCREEN_X_OFFSET_H = DS_TOP_SCREEN_WIDTH;                     // Bottom screen starts after top screen (X=400)
const int BOTTOM_SCREEN_Y_OFFSET_H = 0;                                       // Bottom screen aligned with top screen (Y=0)

// VERTICAL layout (top/bottom) - more authentic 3DS layout
const int DUAL_SCREEN_WIDTH_V = DS_TOP_SCREEN_WIDTH;                          // Width: 400 (top screen width)
const int DUAL_SCREEN_HEIGHT_V = DS_TOP_SCREEN_HEIGHT + DS_BOTTOM_SCREEN_HEIGHT; // Total height: 240 + 240 = 480
const int TOP_SCREEN_X_OFFSET_V = 0;                                          // Top screen starts at X=0
const int TOP_SCREEN_Y_OFFSET_V = 0;                                          // Top screen starts at Y=0
const int BOTTOM_SCREEN_X_OFFSET_V = (DS_TOP_SCREEN_WIDTH - DS_BOTTOM_SCREEN_WIDTH) / 2; // Center bottom screen (X=40)
const int BOTTOM_SCREEN_Y_OFFSET_V = DS_TOP_SCREEN_HEIGHT;                    // Bottom screen below top screen (Y=240)

// Legacy constants for backward compatibility (horizontal layout)
const int DUAL_SCREEN_WIDTH = DUAL_SCREEN_WIDTH_H;
const int DUAL_SCREEN_HEIGHT = DUAL_SCREEN_HEIGHT_H;
const int TOP_SCREEN_X_OFFSET = TOP_SCREEN_X_OFFSET_H;
const int TOP_SCREEN_Y_OFFSET = TOP_SCREEN_Y_OFFSET_H;
const int BOTTOM_SCREEN_X_OFFSET = BOTTOM_SCREEN_X_OFFSET_H;
const int BOTTOM_SCREEN_Y_OFFSET = BOTTOM_SCREEN_Y_OFFSET_H;

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define CLAMP(val, min, max) ((val)>(max)?(max):((val)<(min)?(min):(val)))

#define ASYNC_TASKS_MAX 1

const char *runScript(const char* script, bool isStringBuffer);
void luaC_collectgarbage (lua_State *L);

void luaControls_init(lua_State *L);
void luaControls_set_key_constants(lua_State *L);
void luaCamera_init(lua_State *L);
void luaScreen_init(lua_State *L);
void luaGraphics_init(lua_State *L);
void luaSound_init(lua_State *L);
void luaSystem_init(lua_State *L);
void luaNetwork_init(lua_State *L);
void luaSocket_init(lua_State *L);
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
