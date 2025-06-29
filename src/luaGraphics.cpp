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
#- All the devs involved in Rejuvenate and vita-toolchain --------------------------------------------------------------#
#- xerpi for drawing libs and for FTP server code ----------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------*/

#include <string.h>
#include <string>
#include <vector>
#include <stdlib.h>
#include <SDL.h>
#include <SDL_ttf.h>
#include <SDL_filesystem.h>
#include <SDL_image.h>
#include <cmath>
//#include <vitasdk.h> // Porting to SDL
//#include <vita2d.h> // Porting to SDL

// External globals from main_sdl.cpp
extern SDL_Window* g_window;
extern SDL_Renderer* g_renderer;
extern bool g_dual_screen_mode;

// Global current screen for 3DS compatibility
static int g_current_screen = 0; // Default to TOP_SCREEN

// SDL Porting Placeholders
typedef void vita2d_pgf;
typedef void vita2d_font;
typedef void vita2d_pvf;
typedef void vita2d_texture;
typedef int SceGxmTextureFormat;
typedef int SceGxmTextureFilter;
typedef int SceKernelMemBlockType;
typedef int SceUID;

#define RGBA8(r,g,b,a) 0
#define SCE_O_RDONLY 0
#define SCE_O_WRONLY 0
#define SCE_O_CREAT 0
#define SCE_O_TRUNC 0
#define SCE_KERNEL_MEMBLOCK_TYPE_USER_CDRAM_RW 0
#define SCE_KERNEL_MEMBLOCK_TYPE_USER_MAIN_PHYCONT_RW 1
#define SCE_KERNEL_MEMBLOCK_TYPE_USER_RW 2
#define SCE_GXM_TEXTURE_FORMAT_A8B8G8R8 0
#define SCE_GXM_TEXTURE_FILTER_POINT 0
#define SCE_GXM_TEXTURE_FILTER_LINEAR 1
#define SCE_GXM_SCENE_FRAGMENT_SET_DEPENDENCY 0
#define SCE_GXM_SCENE_VERTEX_WAIT_FOR_DEPENDENCY 0
#define SCE_GXM_TEXTURE_FORMAT_U8U8U8_BGR 0
// End SDL Porting Placeholders

#include "utils.h"
#include "luaplayer.h"
#include "include/path_utils.h"

// Helper functions to calculate screen offsets for dual screen mode
extern int getScreenXOffset(int screen_id);
int getScreenXOffset(int screen_id) {
    // Check if we're in 3DS compatibility mode
    if (g_compat_mode != LPP_COMPAT_3DS) {
        return 0; // Single screen mode: no offset
    }
    
    // In single-screen mode, position screens appropriately
    if (g_3ds_single_screen_mode) {
        if (screen_id == 1) {
            // Bottom screen: center it in the 400px logical width
            return (DS_TOP_SCREEN_WIDTH - DS_BOTTOM_SCREEN_WIDTH) / 2; // 40px offset to center 320px in 400px
        }
        return 0; // Top screen at 0,0
    }
    
    // Orientation-aware screen offsets (using logical coordinates)
    if (g_3ds_orientation == LPP_3DS_VERTICAL) {
        // Vertical layout: both screens use same X offset (0 for top, centered for bottom)
        if (screen_id == 1) {
            return BOTTOM_SCREEN_X_OFFSET_V; // Centered bottom screen
        }
        return TOP_SCREEN_X_OFFSET_V; // Top screen at X=0
    } else {
        // Horizontal layout: side-by-side
        if (screen_id == 1) {
            return BOTTOM_SCREEN_X_OFFSET_H; // Bottom screen to the right
        }
        return TOP_SCREEN_X_OFFSET_H; // Top screen at X=0
    }
}

int getScreenYOffset(int screen_id) {
    // Check if we're in 3DS compatibility mode
    if (g_compat_mode != LPP_COMPAT_3DS) {
        return 0; // Single screen mode: no offset
    }
    
    // In single-screen mode, both screens render at Y=0
    if (g_3ds_single_screen_mode) {
        return 0; // Both screens at Y=0
    }
    
    // Orientation-aware screen offsets (using logical coordinates)
    if (g_3ds_orientation == LPP_3DS_VERTICAL) {
        // Vertical layout: screens stacked top/bottom
        if (screen_id == 1) {
            return BOTTOM_SCREEN_Y_OFFSET_V; // Bottom screen below top screen
        }
        return TOP_SCREEN_Y_OFFSET_V; // Top screen at Y=0
    } else {
        // Horizontal layout: both screens at same Y level
        if (screen_id == 1) {
            return BOTTOM_SCREEN_Y_OFFSET_H; // Bottom screen at Y=0
        }
        return TOP_SCREEN_Y_OFFSET_H; // Top screen at Y=0
    }
}

// Get per-screen scaling factors for proper aspect ratio rendering
void getScreenScaling(int screen_id, float* scale_x, float* scale_y) {
    // For 3DS mode, use 1:1 scaling since SDL logical scaling handles it
    *scale_x = 1.0f;
    *scale_y = 1.0f;
}

// Set viewport clipping for a specific screen to maintain aspect ratios
void setScreenViewport(int screen_id) {
    extern SDL_Renderer* g_renderer;
    extern lpp_compat_mode_t g_compat_mode;
    
    if (!g_renderer) {
        return;
    }
    
    // For 3DS mode, set clipping rectangles to prevent rendering outside screen boundaries
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // In single-screen mode, only clip if this screen is not the active one
        if (g_3ds_single_screen_mode) {
            if (screen_id != g_3ds_active_screen) {
                // Inactive screen: clip to nothing (hide it)
                SDL_Rect clip_rect = {0, 0, 0, 0}; // Empty clip rect hides everything
                SDL_RenderSetClipRect(g_renderer, &clip_rect);
            } else {
                // Active screen: no clipping (full visibility)
                SDL_RenderSetClipRect(g_renderer, NULL);
            }
            return;
        }
        
        SDL_Rect clip_rect;
        
        // Get screen offsets and dimensions
        int x_offset = getScreenXOffset(screen_id);
        int y_offset = getScreenYOffset(screen_id);
        
        // Set clipping rectangle to exact screen bounds to allow all content within screen
        if (screen_id == 0) {
            // Top screen
            clip_rect.x = x_offset;
            clip_rect.y = y_offset;
            clip_rect.w = DS_TOP_SCREEN_WIDTH;
            clip_rect.h = DS_TOP_SCREEN_HEIGHT;
        } else {
            // Bottom screen
            clip_rect.x = x_offset;
            clip_rect.y = y_offset;
            clip_rect.w = DS_BOTTOM_SCREEN_WIDTH;
            clip_rect.h = DS_BOTTOM_SCREEN_HEIGHT;
        }
        
        SDL_RenderSetClipRect(g_renderer, &clip_rect);
        return;
    }
    
    // For other modes, disable clipping
    SDL_RenderSetClipRect(g_renderer, NULL);
}

extern "C"{
#include <png.h>      // libpng-dev available
//#include <libimagequant.h>  // Missing dependency - TODO: install libimagequant-dev (not available in this environment)
#include "gifdec.h"
};

#define stringify(str) #str
#define VariableRegister(lua, value) do { lua_pushinteger(lua, value); lua_setglobal (lua, stringify(value)); } while(0)

void* debug_font = NULL; // SDL equivalent placeholder
TTF_Font* g_defaultFont = NULL; // Global default font, to be loaded in main_sdl.cpp


// Helper function to extract color from Lua stack (handles both Color objects and integers)
static uint32_t get_color_from_lua(lua_State *L, int index) {
    if (lua_istable(L, index)) {
        // Color object - extract r, g, b, a from table
        lua_getfield(L, index, "r");
        uint8_t r = (uint8_t)luaL_checkinteger(L, -1);
        lua_pop(L, 1);
        
        lua_getfield(L, index, "g");
        uint8_t g = (uint8_t)luaL_checkinteger(L, -1);
        lua_pop(L, 1);
        
        lua_getfield(L, index, "b");
        uint8_t b = (uint8_t)luaL_checkinteger(L, -1);
        lua_pop(L, 1);
        
        lua_getfield(L, index, "a");
        uint8_t a = lua_isnil(L, -1) ? 255 : (uint8_t)luaL_checkinteger(L, -1);
        lua_pop(L, 1);
        
        return (a << 24) | (r << 16) | (g << 8) | b;
    } else {
        // Integer color
        return (uint32_t)luaL_checkinteger(L, index);
    }
}

struct ttf {
	uint32_t magic;
	void* f;
	void* f2;
	void* f3;
	int size;
	float scale;
};

struct rescaler {
	void* fbo;
	int x;
	int y;
	float x_scale;
	float y_scale;
};

struct animated_texture {
	void *frames;
	uint32_t num_frames;
};

static bool isRescaling = false;
static rescaler scaler;

// static char asyncImagePath[512];

int FORMAT_BMP = 1;
int FORMAT_PNG = 2;
int FORMAT_JPG = 3;

#ifdef PARANOID
static bool draw_state = false;
#endif



static int lua_print(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    // Graphics.print(x, y, text, color, [scale]) - scale is ignored for TTF
    if (argc < 4 || argc > 5)
        return luaL_error(L, "Graphics.print(x, y, text, color, [scale]): wrong number of arguments.");
#endif

    int x = luaL_checkinteger(L, 1);
    int y = luaL_checkinteger(L, 2);
    const char* text = luaL_checkstring(L, 3);
    
    uint32_t color_val;
    // Handle both Color objects (tables) and integer colors
    if (lua_istable(L, 4)) {
        // Color object - extract r, g, b, a from table
        lua_getfield(L, 4, "r");
        uint8_t r = (uint8_t)luaL_checkinteger(L, -1);
        lua_pop(L, 1);
        
        lua_getfield(L, 4, "g");
        uint8_t g = (uint8_t)luaL_checkinteger(L, -1);
        lua_pop(L, 1);
        
        lua_getfield(L, 4, "b");
        uint8_t b = (uint8_t)luaL_checkinteger(L, -1);
        lua_pop(L, 1);
        
        lua_getfield(L, 4, "a");
        uint8_t a = 255;
        if (!lua_isnil(L, -1)) {
            a = (uint8_t)luaL_checkinteger(L, -1);
        }
        lua_pop(L, 1);
        
        // Pack into RGBA format
        color_val = (a << 24) | (b << 16) | (g << 8) | r;
    } else {
        // Integer color
        color_val = luaL_checkinteger(L, 4);
    }
    
    float scale = (argc == 5) ? (float)luaL_checknumber(L, 5) : 1.0f;

    if (!g_defaultFont) {
        fprintf(stderr, "Error: g_defaultFont not loaded. Cannot render text with Graphics.print.\n");
        return 0; // Don't cause Lua error, just don't render
    }

    if (!g_renderer) {
        return luaL_error(L, "SDL Renderer not available for print");
    }

    SDL_Color sdl_color = {
        (Uint8)(color_val & 0xFF),        // R
        (Uint8)((color_val >> 8) & 0xFF), // G
        (Uint8)((color_val >> 16) & 0xFF),// B
        (Uint8)((color_val >> 24) & 0xFF) // A
    };

    SDL_Surface* text_surface = TTF_RenderText_Blended(g_defaultFont, text, sdl_color);
    if (!text_surface) {
        fprintf(stderr, "TTF_RenderText_Blended Error (g_defaultFont): %s\n", TTF_GetError());
        return 0;
    }

    SDL_Texture* text_texture = SDL_CreateTextureFromSurface(g_renderer, text_surface);
    if (!text_texture) {
        fprintf(stderr, "SDL_CreateTextureFromSurface Error (g_defaultFont): %s\n", SDL_GetError());
        SDL_FreeSurface(text_surface);
        return 0;
    }
    
    // Set texture filtering to linear for smooth scaled fonts
    SDL_SetTextureScaleMode(text_texture, SDL_ScaleModeLinear);

    SDL_Rect dest_rect = { x, y, (int)(text_surface->w * scale), (int)(text_surface->h * scale) };
    
    // Apply per-screen scaling and positioning for dual screen mode
    if (g_dual_screen_mode && g_vita_compat_mode) {
        // For now, assume TOP_SCREEN (screen=0) since this function doesn't have screen parameter
        // TODO: Add screen parameter support to Graphics.debugPrint
        int screen = 0;
        
        // Get per-screen scaling factors
        float scale_x, scale_y;
        getScreenScaling(screen, &scale_x, &scale_y);
        
        // First: Apply scaling to local coordinates
        dest_rect.x = (int)(dest_rect.x * scale_x);
        dest_rect.y = (int)(dest_rect.y * scale_y);
        dest_rect.w = (int)(dest_rect.w * scale_x);
        dest_rect.h = (int)(dest_rect.h * scale_y);
        
        // Second: Add properly calculated screen offset to position the screen in the window
        if (screen == 1) { // BOTTOM_SCREEN
            // Bottom screen should be positioned after the scaled top screen area
            float top_screen_scale_x, top_screen_scale_y;
            getScreenScaling(0, &top_screen_scale_x, &top_screen_scale_y);
            int bottom_screen_x_pos = (int)(DS_TOP_SCREEN_WIDTH * top_screen_scale_x);
            dest_rect.x += bottom_screen_x_pos;
        }
        // Top screen starts at window origin (no additional offset needed)
    }
    
    SDL_RenderCopy(g_renderer, text_texture, NULL, &dest_rect);

    SDL_DestroyTexture(text_texture);
    SDL_FreeSurface(text_surface);

    return 0;
}

static int lua_graphics_printf(lua_State *L) {
    int n = lua_gettop(L); // Number of arguments
#ifndef SKIP_ERROR_HANDLING
    if (n < 4) { // x, y, format_string, color, ...
        return luaL_error(L, "Graphics.printf(x, y, format, color, ...): at least 4 arguments expected");
    }
#endif

    int x = (int)luaL_checknumber(L, 1);
    int y = (int)luaL_checknumber(L, 2);
    uint32_t color_val = luaL_checkinteger(L, 4);

#ifndef SKIP_ERROR_HANDLING
    if (!g_defaultFont) {
        fprintf(stderr, "Graphics.printf: Default font not loaded. Cannot print.\n");
        return 0;
    }
    if (!g_renderer) {
        return luaL_error(L, "SDL Renderer not available for Graphics.printf");
    }
#endif

    luaL_checkstring(L, 3); // Ensure format string is a string

    lua_getglobal(L, "string");
    lua_getfield(L, -1, "format");
    lua_remove(L, -2); // Remove 'string' table

    lua_pushvalue(L, 3); // Push format string (original index 3)
    for (int i = 5; i <= n; i++) {
        lua_pushvalue(L, i); // Push varargs (original indices 5 to n)
    }

    // Number of arguments to string.format = 1 (format string) + (n - 4) (varargs) = n - 3
    if (lua_pcall(L, n - 3, 1, 0) != 0) {
        return luaL_error(L, "Error in string.format during Graphics.printf: %s", lua_tostring(L, -1));
    }
    
    const char* formatted_text = lua_tostring(L, -1);
    if (!formatted_text) {
        return luaL_error(L, "Graphics.printf: string.format did not return a string.");
    }

    SDL_Color sdl_color = {
        (Uint8)(color_val & 0xFF),
        (Uint8)((color_val >> 8) & 0xFF),
        (Uint8)((color_val >> 16) & 0xFF),
        (Uint8)((color_val >> 24) & 0xFF)
    };

    SDL_Surface* text_surface = TTF_RenderText_Blended(g_defaultFont, formatted_text, sdl_color);
    if (!text_surface) {
        fprintf(stderr, "TTF_RenderText_Blended Error (printf): %s\n", TTF_GetError());
        lua_pop(L, 1); // Pop formatted string
        return 0; 
    }

    SDL_Texture* text_texture = SDL_CreateTextureFromSurface(g_renderer, text_surface);
    if (!text_texture) {
        fprintf(stderr, "SDL_CreateTextureFromSurface Error (printf): %s\n", SDL_GetError());
        SDL_FreeSurface(text_surface);
        lua_pop(L, 1); // Pop formatted string
        return 0;
    }
    
    // Set texture filtering to linear for smooth scaled fonts
    SDL_SetTextureScaleMode(text_texture, SDL_ScaleModeLinear);

    SDL_Rect dest_rect = { x, y, text_surface->w, text_surface->h };
    SDL_RenderCopy(g_renderer, text_texture, NULL, &dest_rect);

    SDL_DestroyTexture(text_texture);
    SDL_FreeSurface(text_surface);
    lua_pop(L, 1); // Pop formatted string

    return 0;
}



static int lua_pixel(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 3)
		return luaL_error(L, "Argument error: graphics.drawPixel(x, y, color) expected.");
#endif

    int x = luaL_checkinteger(L, 1);
    int y = luaL_checkinteger(L, 2);
    uint32_t color = luaL_checkinteger(L, 3);

    if (g_renderer) {
        Uint8 r = color & 0xFF;
        Uint8 g = (color >> 8) & 0xFF;
        Uint8 b = (color >> 16) & 0xFF;
        Uint8 a = (color >> 24) & 0xFF;

        SDL_SetRenderDrawColor(g_renderer, r, g, b, a);
        SDL_RenderDrawPoint(g_renderer, x, y);
    }

	return 0;
}



static int lua_rect(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 5 && argc != 6)
		return luaL_error(L, "Argument error: graphics.fillRect(x1, x2, y1, y2, color [, screen]) expected.");
#endif
    // Vita API uses (x1, x2, y1, y2, color) format
    int x1 = luaL_checkinteger(L, 1);
    int x2 = luaL_checkinteger(L, 2);
    int y1 = luaL_checkinteger(L, 3);
    int y2 = luaL_checkinteger(L, 4);
    uint32_t color = get_color_from_lua(L, 5);
    
    // Handle optional screen parameter for 3DS compatibility
    int screen = (argc == 6) ? luaL_checkinteger(L, 6) : 0; // Default to TOP_SCREEN

    if (g_renderer) {
        // Convert from Vita (x1,x2,y1,y2) to SDL (x,y,w,h) format
        int x = x1;
        int y = y1;
        int w = x2 - x1;
        int h = y2 - y1;
        
        // Add bounds checking to prevent drawing outside screen
        if (w <= 0 || h <= 0) return 0; // Invalid dimensions
        
        // Apply screen offsets for 3DS mode
        if (g_compat_mode == LPP_COMPAT_3DS) {
            // In single-screen mode, skip rendering if this isn't the active screen
            if (g_3ds_single_screen_mode && screen != g_3ds_active_screen) {
                return 0; // Skip rendering for inactive screen
            }
            
            int x_offset = getScreenXOffset(screen);
            int y_offset = getScreenYOffset(screen);
            x += x_offset;
            y += y_offset;
            
            // Set viewport clipping for this screen
            setScreenViewport(screen);
        }
        
        // Get appropriate screen boundaries based on mode
        int screen_width = g_vita_compat_mode ? SCREEN_WIDTH : NATIVE_LOGICAL_WIDTH;
        int screen_height = g_vita_compat_mode ? SCREEN_HEIGHT : NATIVE_LOGICAL_HEIGHT;
        
        // Strict clamping to prevent edge artifacts
        if (x >= screen_width || y >= screen_height || x + w <= 0 || y + h <= 0) {
            return 0; // Completely outside bounds
        }
        
        // Clamp to screen boundaries
        if (x < 0) {
            w += x;
            x = 0;
        }
        if (y < 0) {
            h += y; 
            y = 0;
        }
        if (x + w > screen_width) {
            w = screen_width - x;
        }
        if (y + h > screen_height) {
            h = screen_height - y;
        }
        
        // Final check after clamping
        if (w <= 0 || h <= 0) return 0;
        
        SDL_Rect rect = { x, y, w, h };
        Uint8 r = color & 0xFF;
        Uint8 g = (color >> 8) & 0xFF;
        Uint8 b = (color >> 16) & 0xFF;
        Uint8 a = (color >> 24) & 0xFF;

        SDL_SetRenderDrawColor(g_renderer, r, g, b, a);
        SDL_RenderFillRect(g_renderer, &rect);
    }

	return 0;
}

static int lua_emptyrect(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 5)
		return luaL_error(L, "Argument error: graphics.drawEmptyRect(x1, x2, y1, y2, color) expected.");
#endif
    // Vita API uses (x1, x2, y1, y2, color) format like fillRect
    int x1 = luaL_checkinteger(L, 1);
    int x2 = luaL_checkinteger(L, 2);
    int y1 = luaL_checkinteger(L, 3);
    int y2 = luaL_checkinteger(L, 4);
    uint32_t color = get_color_from_lua(L, 5);

    if (g_renderer) {
        // Convert from Vita (x1,x2,y1,y2) to SDL (x,y,w,h) format
        int x = x1;
        int y = y1;
        int w = x2 - x1;
        int h = y2 - y1;
        
        // Add bounds checking to prevent drawing outside screen
        if (w <= 0 || h <= 0) return 0; // Invalid dimensions
        
        // Get appropriate screen boundaries based on mode
        int screen_width = g_vita_compat_mode ? SCREEN_WIDTH : NATIVE_LOGICAL_WIDTH;
        int screen_height = g_vita_compat_mode ? SCREEN_HEIGHT : NATIVE_LOGICAL_HEIGHT;
        
        // Strict clamping to prevent edge artifacts
        if (x >= screen_width || y >= screen_height || x + w <= 0 || y + h <= 0) {
            return 0; // Completely outside bounds
        }
        
        // Clamp to screen boundaries
        if (x < 0) {
            w += x;
            x = 0;
        }
        if (y < 0) {
            h += y; 
            y = 0;
        }
        if (x + w > screen_width) {
            w = screen_width - x;
        }
        if (y + h > screen_height) {
            h = screen_height - y;
        }
        
        // Final check after clamping
        if (w <= 0 || h <= 0) return 0;
        
        SDL_Rect rect = { x, y, w, h };
        Uint8 r = color & 0xFF;
        Uint8 g = (color >> 8) & 0xFF;
        Uint8 b = (color >> 16) & 0xFF;
        Uint8 a = (color >> 24) & 0xFF;

        SDL_SetRenderDrawColor(g_renderer, r, g, b, a);
        SDL_RenderDrawRect(g_renderer, &rect);
    }

	return 0;
}

static int lua_line(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 5)
		return luaL_error(L, "Argument error: graphics.drawLine(x1, x2, y1, y2, color) expected.");
#endif
    int x1 = luaL_checkinteger(L, 1);
    int x2 = luaL_checkinteger(L, 2);
    int y1 = luaL_checkinteger(L, 3);
    int y2 = luaL_checkinteger(L, 4);
    uint32_t color = luaL_checkinteger(L, 5);

    if (g_renderer) {
        Uint8 r = color & 0xFF;
        Uint8 g = (color >> 8) & 0xFF;
        Uint8 b = (color >> 16) & 0xFF;
        Uint8 a = (color >> 24) & 0xFF;

        SDL_SetRenderDrawColor(g_renderer, r, g, b, a);
        SDL_RenderDrawLine(g_renderer, x1, y1, x2, y2);
    }

	return 0;
}



static int lua_circle(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 4)
		return luaL_error(L, "wrong number of arguments.");
#endif
#ifdef PARANOID
	if (!draw_state)
		return luaL_error(L, "drawCircle can't be called outside a blending phase.");
#endif
	int x = (int)luaL_checknumber(L, 1);
	int y = (int)luaL_checknumber(L, 2);
	int radius = (int)luaL_checknumber(L, 3);
	uint32_t color = luaL_checkinteger(L, 4);
	
	if (g_renderer) {
		Uint8 r = color & 0xFF;
		Uint8 g = (color >> 8) & 0xFF;
		Uint8 b = (color >> 16) & 0xFF;
		Uint8 a = (color >> 24) & 0xFF;
		
		SDL_SetRenderDrawColor(g_renderer, r, g, b, a);
		
		// Simple circle drawing using Bresenham's algorithm
		int dx = radius;
		int dy = 0;
		int err = 0;
		
		while (dx >= dy) {
			SDL_RenderDrawPoint(g_renderer, x + dx, y + dy);
			SDL_RenderDrawPoint(g_renderer, x + dy, y + dx);
			SDL_RenderDrawPoint(g_renderer, x - dy, y + dx);
			SDL_RenderDrawPoint(g_renderer, x - dx, y + dy);
			SDL_RenderDrawPoint(g_renderer, x - dx, y - dy);
			SDL_RenderDrawPoint(g_renderer, x - dy, y - dx);
			SDL_RenderDrawPoint(g_renderer, x + dy, y - dx);
			SDL_RenderDrawPoint(g_renderer, x + dx, y - dy);
			
			if (err <= 0) {
				dy += 1;
				err += 2*dy + 1;
			}
			if (err > 0) {
				dx -= 1;
				err -= 2*dx + 1;
			}
		}
	}
	return 0;
}

static int lua_init(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0 && argc != 1)
		return luaL_error(L, "wrong number of arguments");
#endif
	
	// Handle optional screen parameter for 3DS compatibility
	if (argc == 1) {
		// Screen parameter provided (3DS mode) - set current screen context
		g_current_screen = luaL_checkinteger(L, 1);
	}
#ifdef PARANOID
	if (draw_state)
		return luaL_error(L, "initBlend can't be called inside a blending phase.");
	else
		draw_state = true;
#endif
	// Porting to SDL
	return 0;
}

static int lua_term(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0)
		return luaL_error(L, "wrong number of arguments");
#endif
#ifdef PARANOID
	if (!draw_state)
		return luaL_error(L, "termBlend can't be called outside a blending phase.");
	else
		draw_state = false;
#endif
	
	// Vita compatibility: Some games expect termBlend to present the frame
	if (g_compat_mode == LPP_COMPAT_VITA && g_renderer) {
		SDL_RenderPresent(g_renderer);
	}
	
	return 0;
}

static int lua_loadimg(lua_State *L) {
    const char* path = luaL_checkstring(L, 1);
    
    // Translate Vita paths (app0:/ -> current directory)
    std::string translated_path = PathUtils::translate_vita_path(path);
    
    // Load surface first to get pixel data for getPixel functionality
    SDL_Surface* surface = IMG_Load(translated_path.c_str());
    if (!surface) {
        return luaL_error(L, "Error loading image: %s", IMG_GetError());
    }
    
    // Create texture from surface
    SDL_Texture* sdl_texture = SDL_CreateTextureFromSurface(g_renderer, surface);
    if (!sdl_texture) {
        SDL_FreeSurface(surface);
        return luaL_error(L, "Error creating texture: %s", SDL_GetError());
    }

    lpp_texture* tex = (lpp_texture*)malloc(sizeof(lpp_texture));
    tex->magic = 0xABADBEEF;
    tex->texture = (void*)sdl_texture;
    tex->w = surface->w;
    tex->h = surface->h;
    
    // Store pixel data for getPixel functionality
    int size = surface->w * surface->h * 4; // RGBA
    tex->data = malloc(size);
    
    // Convert surface to ABGR8888 format for consistent pixel access (matches 3DS byte order)
    SDL_Surface* rgba_surface = SDL_ConvertSurfaceFormat(surface, SDL_PIXELFORMAT_ABGR8888, 0);
    if (rgba_surface) {
        memcpy(tex->data, rgba_surface->pixels, size);
        SDL_FreeSurface(rgba_surface);
    } else {
        // Fallback: copy original surface data
        memcpy(tex->data, surface->pixels, size);
    }
    
    SDL_FreeSurface(surface);

    lua_pushlightuserdata(L, tex);
    return 1;
}

static int lua_saveimg(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 2 && argc != 3)
		return luaL_error(L, "Graphics.saveImage(image, filename, [format]): wrong number of arguments");
#endif
	
	lpp_texture* text = (lpp_texture*)lua_touserdata(L, 1);
	const char* filename = luaL_checkstring(L, 2);
	int format = (argc == 3) ? luaL_checkinteger(L, 3) : FORMAT_BMP; // Default to BMP
	
#ifndef SKIP_ERROR_HANDLING
	if (text->magic != 0xABADBEEF)
		return luaL_error(L, "attempt to access wrong memory block type.");
#endif
	
	if (!text->data) {
		return luaL_error(L, "Cannot save image: texture has no pixel data");
	}
	
	// Translate Vita paths
	std::string translated_path = PathUtils::translate_vita_path(filename);
	
	if (format == FORMAT_BMP) {
		// Save as BMP using SDL_image
		SDL_Surface* surface = SDL_CreateRGBSurfaceFrom(
			text->data, text->w, text->h, 32, text->w * 4,
			0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000
		);
		
		if (surface) {
			// Flip surface for BMP format (BMP stores bottom-to-top)
			SDL_Surface* flipped = SDL_CreateRGBSurface(0, text->w, text->h, 32,
				0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000);
			if (flipped) {
				Uint32* src_pixels = (Uint32*)surface->pixels;
				Uint32* dst_pixels = (Uint32*)flipped->pixels;
				for (int y = 0; y < text->h; y++) {
					memcpy(&dst_pixels[(text->h - 1 - y) * text->w], 
						   &src_pixels[y * text->w], text->w * 4);
				}
				SDL_SaveBMP(flipped, translated_path.c_str());
				SDL_FreeSurface(flipped);
			}
			SDL_FreeSurface(surface);
		}
	} else if (format == FORMAT_PNG) {
		// Save as PNG using libpng
		FILE* fp = fopen(translated_path.c_str(), "wb");
		if (!fp) {
			return luaL_error(L, "Cannot open file for writing: %s", translated_path.c_str());
		}
		
		png_structp png = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
		if (!png) {
			fclose(fp);
			return luaL_error(L, "PNG write struct creation failed");
		}
		
		png_infop info = png_create_info_struct(png);
		if (!info) {
			png_destroy_write_struct(&png, NULL);
			fclose(fp);
			return luaL_error(L, "PNG info struct creation failed");
		}
		
		if (setjmp(png_jmpbuf(png))) {
			png_destroy_write_struct(&png, &info);
			fclose(fp);
			return luaL_error(L, "PNG write error");
		}
		
		png_init_io(png, fp);
		png_set_IHDR(png, info, text->w, text->h, 8, PNG_COLOR_TYPE_RGBA,
					 PNG_INTERLACE_NONE, PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT);
		png_write_info(png, info);
		
		// Write pixel data (PNG stores top-to-bottom, same as our data)
		png_bytep* row_pointers = (png_bytep*)malloc(sizeof(png_bytep) * text->h);
		for (int y = 0; y < text->h; y++) {
			row_pointers[y] = (png_byte*)text->data + (y * text->w * 4);
		}
		
		png_write_image(png, row_pointers);
		png_write_end(png, NULL);
		
		png_destroy_write_struct(&png, &info);
		fclose(fp);
		free(row_pointers);
	} else {
		return luaL_error(L, "Unsupported image format: %d (use FORMAT_BMP or FORMAT_PNG)", format);
	}
	
	return 0;
}

static int lua_loadimgasync(lua_State *L){
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1)
		return luaL_error(L, "wrong number of arguments");
#endif
	// Porting to SDL
	return 0;
}

static int lua_loadanimg(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1)
		return luaL_error(L, "wrong number of arguments");
#endif
	// Porting to SDL
	lua_pushnil(L);
	return 1;
}

static int lua_getnumframes(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1)
		return luaL_error(L, "wrong number of arguments");
#endif
	lpp_texture* text = (lpp_texture*)(luaL_checkinteger(L, 1));
#ifndef SKIP_ERROR_HANDLING
	if (text->magic != 0xABADBEEF)
		return luaL_error(L, "attempt to access wrong memory block type.");
	if (text->data == NULL)
		return luaL_error(L, "attempt to access a static image.");
#endif
	// Porting to SDL
	lua_pushinteger(L, 0);
	return 1;
}

static int lua_setframe(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 2)
        return luaL_error(L, "wrong number of arguments");
#endif
    lpp_texture* text = (lpp_texture*)(luaL_checkinteger(L, 1));
    int idx = luaL_checkinteger(L, 2);
    (void)idx;
#ifndef SKIP_ERROR_HANDLING
    if (text->magic != 0xABADBEEF)
        return luaL_error(L, "attempt to access wrong memory block type.");
    if (text->data == NULL)
        return luaL_error(L, "attempt to access a static image.");
#endif
	// Porting to SDL
	return 0;
}

static int lua_drawimg(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc < 3 || argc > 4) {
        return luaL_error(L, "wrong number of arguments (expected 3 or 4)");
    }
    
    float x = luaL_checknumber(L, 1);
    float y = luaL_checknumber(L, 2);
    lpp_texture* tex = (lpp_texture*)lua_touserdata(L, 3);
    if (!tex || tex->magic != 0xABADBEEF) {
        return luaL_error(L, "Invalid texture provided to drawImage");
    }

    // Apply screen offsets for 3DS mode using current screen context
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // In single-screen mode, skip rendering if this isn't the active screen
        if (g_3ds_single_screen_mode && g_current_screen != g_3ds_active_screen) {
            return 0; // Skip rendering for inactive screen
        }
        
        int x_offset = getScreenXOffset(g_current_screen);
        int y_offset = getScreenYOffset(g_current_screen);
        x += x_offset;
        y += y_offset;
        
        // Set viewport clipping for this screen
        setScreenViewport(g_current_screen);
    }

    SDL_Texture* sdl_tex = (SDL_Texture*)tex->texture;
    
    // Handle optional color parameter for alpha blending
    if (argc == 4) {
        int color;
        if (lua_isnumber(L, 4)) {
            // Direct integer color value
            color = lua_tointeger(L, 4);
        } else if (lua_istable(L, 4)) {
            // Handle table returned by Color.new() - this shouldn't happen but let's be safe
            return luaL_error(L, "Color table not supported - use Color.new() result directly");
        } else {
            return luaL_error(L, "Color parameter must be a number (got %s)", lua_typename(L, lua_type(L, 4)));
        }
        Uint8 r = (color) & 0xFF;
        Uint8 g = (color >> 8) & 0xFF;
        Uint8 b = (color >> 16) & 0xFF;
        Uint8 a = (color >> 24) & 0xFF;
        
        // Set texture color modulation and alpha
        SDL_SetTextureColorMod(sdl_tex, r, g, b);
        SDL_SetTextureAlphaMod(sdl_tex, a);
    } else {
        // Reset to default (no color modulation)
        SDL_SetTextureColorMod(sdl_tex, 255, 255, 255);
        SDL_SetTextureAlphaMod(sdl_tex, 255);
    }

    SDL_Rect dest_rect = { (int)x, (int)y, tex->w, tex->h };
    SDL_RenderCopy(g_renderer, sdl_tex, NULL, &dest_rect);

    return 0;
}

static int lua_drawimg_rotate(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 4)
		return luaL_error(L, "wrong number of arguments");
#endif
    float x = luaL_checknumber(L, 1);
    float y = luaL_checknumber(L, 2);
    lpp_texture* tex = (lpp_texture*)lua_touserdata(L, 3);
    float angle = luaL_checknumber(L, 4);

    if (!tex || tex->magic != 0xABADBEEF) {
        return luaL_error(L, "Invalid texture provided to drawRotateImage");
    }

    // Apply screen offsets for 3DS mode using current screen context
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // In single-screen mode, skip rendering if this isn't the active screen
        if (g_3ds_single_screen_mode && g_current_screen != g_3ds_active_screen) {
            return 0; // Skip rendering for inactive screen
        }
        
        int x_offset = getScreenXOffset(g_current_screen);
        int y_offset = getScreenYOffset(g_current_screen);
        x += x_offset;
        y += y_offset;
        
        // Set viewport clipping for this screen
        setScreenViewport(g_current_screen);
    }

    if (g_renderer) {
        // Note: Vita drawRotateImage uses (x,y) as center, SDL uses top-left corner
        SDL_Rect dest_rect = { (int)x - tex->w/2, (int)y - tex->h/2, tex->w, tex->h };
        // The angle in vita2d is in radians, SDL_RenderCopyEx expects degrees.
        double angle_degrees = angle * 180.0 / M_PI;
        SDL_RenderCopyEx(g_renderer, (SDL_Texture*)tex->texture, NULL, &dest_rect, angle_degrees, NULL, SDL_FLIP_NONE);
    }

    return 0;
}

static int lua_drawimg_scale(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 5 && argc != 6)
		return luaL_error(L, "wrong number of arguments");
#endif
    float x = luaL_checknumber(L, 1);
    float y = luaL_checknumber(L, 2);
    
    lpp_texture* tex;
    float x_scale, y_scale;
    uint32_t color = 0xFFFFFFFF; // Default: white (no tint)
    
    // Check if 3rd parameter is userdata (image) or number (scale)
    if (lua_isuserdata(L, 3)) {
        // Standard order: drawScaleImage(x, y, image, x_scale, y_scale [, color])
        tex = (lpp_texture*)lua_touserdata(L, 3);
        x_scale = luaL_checknumber(L, 4);
        y_scale = luaL_checknumber(L, 5);
        if (argc == 6) {
            color = luaL_checkinteger(L, 6);
        }
    } else {
        // Vita order: drawScaleImage(x, y, x_scale, y_scale, image [, color])
        x_scale = luaL_checknumber(L, 3);
        y_scale = luaL_checknumber(L, 4);
        tex = (lpp_texture*)lua_touserdata(L, 5);
        if (argc == 6) {
            color = luaL_checkinteger(L, 6);
        }
    }

    if (!tex || tex->magic != 0xABADBEEF) {
        return luaL_error(L, "Invalid texture provided to drawScaleImage");
    }

    // Apply screen offsets for 3DS mode using current screen context
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // In single-screen mode, skip rendering if this isn't the active screen
        if (g_3ds_single_screen_mode && g_current_screen != g_3ds_active_screen) {
            return 0; // Skip rendering for inactive screen
        }
        
        int x_offset = getScreenXOffset(g_current_screen);
        int y_offset = getScreenYOffset(g_current_screen);
        x += x_offset;
        y += y_offset;
        
        // Set viewport clipping for this screen
        setScreenViewport(g_current_screen);
    }

    if (g_renderer) {
        SDL_Texture* texture = (SDL_Texture*)tex->texture;
        
        // Apply color modulation if specified
        if (color != 0xFFFFFFFF) {
            uint8_t r = (color >> 24) & 0xFF;
            uint8_t g = (color >> 16) & 0xFF;
            uint8_t b = (color >> 8) & 0xFF;
            uint8_t a = color & 0xFF;
            SDL_SetTextureColorMod(texture, r, g, b);
            SDL_SetTextureAlphaMod(texture, a);
        }
        
        SDL_Rect dest_rect = { (int)x, (int)y, (int)(tex->w * x_scale), (int)(tex->h * y_scale) };
        SDL_RenderCopy(g_renderer, texture, NULL, &dest_rect);
        
        // Reset color modulation to default
        if (color != 0xFFFFFFFF) {
            SDL_SetTextureColorMod(texture, 255, 255, 255);
            SDL_SetTextureAlphaMod(texture, 255);
        }
    }

    return 0;
}

static int lua_drawimg_part(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 7 && argc != 8)
		return luaL_error(L, "wrong number of arguments");
#endif
#ifdef PARANOID
	if (!draw_state)
		return luaL_error(L, "drawPartialImage can't be called outside a blending phase.");
#endif
	
	float x = luaL_checknumber(L, 1);
	float y = luaL_checknumber(L, 2);
	
	lpp_texture* text;
	int st_x, st_y, width, height;
	
	// Check if 3rd parameter is userdata (SDL order) or number (3DS order)
	if (lua_isuserdata(L, 3)) {
		// SDL order: x, y, texture, st_x, st_y, width, height [, color]
		text = (lpp_texture*)lua_touserdata(L, 3);
		st_x = luaL_checkinteger(L, 4);
		st_y = luaL_checkinteger(L, 5);
		width = luaL_checkinteger(L, 6);
		height = luaL_checkinteger(L, 7);
	} else {
		// 3DS order: x, y, st_x, st_y, width, height, texture [, color]
		st_x = luaL_checkinteger(L, 3);
		st_y = luaL_checkinteger(L, 4);
		width = luaL_checkinteger(L, 5);
		height = luaL_checkinteger(L, 6);
		text = (lpp_texture*)lua_touserdata(L, 7);
	}
	
#ifndef SKIP_ERROR_HANDLING
	if (!text || text->magic != 0xABADBEEF)
		return luaL_error(L, "attempt to access wrong memory block type.");
#endif
	
	// Implement SDL drawPartialImage
	if (g_renderer && text->texture) {
		SDL_Rect src_rect = { st_x, st_y, width, height };
		SDL_Rect dest_rect = { (int)x, (int)y, width, height };
		SDL_RenderCopy(g_renderer, (SDL_Texture*)text->texture, &src_rect, &dest_rect);
	}
	
	return 0;
}

static int lua_drawimg_full(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 11 && argc != 10 && argc != 9)
		return luaL_error(L, "wrong number of arguments");
#endif
#ifdef PARANOID
	if (!draw_state)
		return luaL_error(L, "drawImageExtended can't be called outside a blending phase.");
#endif
	float x = luaL_checknumber(L, 1);
	float y = luaL_checknumber(L, 2);
	
	lpp_texture* text;
	int st_x, st_y;
	float width, height, radius, x_scale, y_scale;
	
	// Check for SuperHeroChronicles variant (9 or 10 args with texture at end)
	if ((argc == 9 || argc == 10) && lua_isuserdata(L, argc - (argc == 10 ? 1 : 0))) {
		// SuperHeroChronicles order: x, y, st_x, st_y, width, height, x_scale, y_scale, texture, [color]
		st_x = luaL_checkinteger(L, 3);
		st_y = luaL_checkinteger(L, 4);
		width = luaL_checknumber(L, 5);
		height = luaL_checknumber(L, 6);
		x_scale = luaL_checknumber(L, 7);
		y_scale = luaL_checknumber(L, 8);
		text = (lpp_texture*)lua_touserdata(L, 9);
		radius = 0.0f; // No radius parameter in this variant
	} else if (lua_isuserdata(L, 3)) {
		// SDL order: x, y, texture, st_x, st_y, width, height, radius, x_scale, y_scale
		text = (lpp_texture*)lua_touserdata(L, 3);
		st_x = luaL_checkinteger(L, 4);
		st_y = luaL_checkinteger(L, 5);
		width = luaL_checknumber(L, 6);
		height = luaL_checknumber(L, 7);
		radius = luaL_checknumber(L, 8);
		x_scale = luaL_checknumber(L, 9);
		y_scale = luaL_checknumber(L, 10);
	} else {
		// 3DS order: x, y, st_x, st_y, width, height, radius, x_scale, y_scale, texture
		st_x = luaL_checkinteger(L, 3);
		st_y = luaL_checkinteger(L, 4);
		width = luaL_checknumber(L, 5);
		height = luaL_checknumber(L, 6);
		radius = luaL_checknumber(L, 7);
		x_scale = luaL_checknumber(L, 8);
		y_scale = luaL_checknumber(L, 9);
		text = (lpp_texture*)lua_touserdata(L, 10);
	}
#ifndef SKIP_ERROR_HANDLING
	if (text->magic != 0xABADBEEF)
		return luaL_error(L, "attempt to access wrong memory block type.");
#endif
	
	// Handle color tinting if provided
	if (argc == 11 || (argc == 10 && lua_isuserdata(L, 9))) {
		// Standard 11-arg version or SuperHeroChronicles 10-arg version
		int color_arg = (argc == 11) ? 11 : 10;
		uint32_t color = luaL_checkinteger(L, color_arg);
		uint8_t r = (color) & 0xFF;
		uint8_t g = (color >> 8) & 0xFF;
		uint8_t b = (color >> 16) & 0xFF;
		uint8_t a = (color >> 24) & 0xFF;
		SDL_SetTextureColorMod((SDL_Texture*)text->texture, r, g, b);
		SDL_SetTextureAlphaMod((SDL_Texture*)text->texture, a);
	} else {
		SDL_SetTextureColorMod((SDL_Texture*)text->texture, 255, 255, 255);
		SDL_SetTextureAlphaMod((SDL_Texture*)text->texture, 255);
	}
	
	// Source rectangle (part of texture to draw)
	SDL_Rect src_rect;
	src_rect.x = st_x;
	src_rect.y = st_y;
	src_rect.w = (int)width;
	src_rect.h = (int)height;
	
	// Destination rectangle (where to draw, with scaling)
	SDL_Rect dest_rect;
	dest_rect.w = (int)(width * x_scale);
	dest_rect.h = (int)(height * y_scale);
	
	// Different coordinate systems based on argument pattern:
	// 9-10 args (SuperHeroChronicles variant): top-left positioning
	// 11 args (standard format): center positioning for backwards compatibility
	if (argc == 9 || (argc == 10 && lua_isuserdata(L, 9))) {
		// SuperHeroChronicles variant: use top-left positioning
		dest_rect.x = (int)x;
		dest_rect.y = (int)y;
	} else {
		// Standard format: use center positioning (original behavior)
		dest_rect.x = (int)x - dest_rect.w / 2;
		dest_rect.y = (int)y - dest_rect.h / 2;
	}
	
	// Apply screen offsets for 3DS mode using current screen context
	if (g_compat_mode == LPP_COMPAT_3DS) {
		// In single-screen mode, skip rendering if this isn't the active screen
		if (g_3ds_single_screen_mode && g_current_screen != g_3ds_active_screen) {
			return 0; // Skip rendering for inactive screen
		}
		
		int x_offset = getScreenXOffset(g_current_screen);
		int y_offset = getScreenYOffset(g_current_screen);
		dest_rect.x += x_offset;
		dest_rect.y += y_offset;
		
		// Set viewport clipping for this screen
		setScreenViewport(g_current_screen);
	}
	
	// Center point for rotation
	SDL_Point center;
	center.x = dest_rect.w / 2;
	center.y = dest_rect.h / 2;
	
	// Convert radians to degrees for SDL
	double angle_degrees = radius * (180.0 / M_PI);
	
	// Render the texture with rotation, scaling, and optional tinting
	SDL_RenderCopyEx(g_renderer, (SDL_Texture*)text->texture, &src_rect, &dest_rect, 
					 angle_degrees, &center, SDL_FLIP_NONE);
	
	return 0;
}

static int lua_getwidth(lua_State *L) {
    lpp_texture* tex = (lpp_texture*)lua_touserdata(L, 1);
    if (tex && tex->magic == 0xABADBEEF) {
        lua_pushinteger(L, tex->w);
    } else {
        lua_pushinteger(L, 0);
    }
    return 1;
}

static int lua_getheight(lua_State *L) {
    lpp_texture* tex = (lpp_texture*)lua_touserdata(L, 1);
    if (tex && tex->magic == 0xABADBEEF) {
        lua_pushinteger(L, tex->h);
    } else {
        lua_pushinteger(L, 0);
    }
    return 1;
}

static int lua_free(lua_State *L) {
    lpp_texture* tex = (lpp_texture*)lua_touserdata(L, 1);
    if (tex && tex->magic == 0xABADBEEF) {
        if (tex->texture) {
            SDL_DestroyTexture((SDL_Texture*)tex->texture);
        }
        if (tex->data) { // For animated textures later
            free(tex->data);
        }
        free(tex);
    }
    return 0;
}

static int lua_createimage(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc < 2 || argc > 4)
		return luaL_error(L, "wrong number of arguments");
#endif
	// Porting to SDL
	lua_pushnil(L);
	return 1;
}

static int lua_filters(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 3)
		return luaL_error(L, "wrong number of arguments");
#endif
	lpp_texture* text = (lpp_texture*)(luaL_checkinteger(L, 1));
	SceGxmTextureFilter min_filter = (SceGxmTextureFilter)(luaL_checkinteger(L, 2));
	(void)min_filter;
	SceGxmTextureFilter mag_filter = (SceGxmTextureFilter)(luaL_checkinteger(L, 3));
	(void)mag_filter;
#ifndef SKIP_ERROR_HANDLING
	if (text->magic != 0xABADBEEF)
		luaL_error(L, "attempt to access wrong memory block type.");
#endif
	// Porting to SDL
	return 0;
}

static int lua_freefont(lua_State *L);

static int lua_loadFont(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0 && argc != 1 && argc != 2)
        return luaL_error(L, "wrong number of arguments");
#endif
    
    const char* filename = NULL;
    int ptsize = 16; // Default size like original Vita implementation
    
    if (argc == 0) {
        // No arguments - use default font
        filename = NULL;
    } else {
        // Original behavior - filename required, optional size
        filename = luaL_checkstring(L, 1);
        if (argc == 2) {
            ptsize = luaL_checkinteger(L, 2);
        }
    }
    
    TTF_Font* sdl_font;
    
    if (filename == NULL) {
        // Use default font - check if it's available
        if (!g_defaultFont) {
#ifndef SKIP_ERROR_HANDLING
            return luaL_error(L, "default font not available");
#else
            lua_pushnil(L);
            return 1;
#endif
        }
        
        // Use the global default font directly
        sdl_font = g_defaultFont;
    } else {
        // Load specified font file
        std::string translated_path = PathUtils::translate_vita_path(filename);
        sdl_font = TTF_OpenFont(translated_path.c_str(), ptsize);
        if (!sdl_font) {
            fprintf(stderr, "Failed to load font: '%s' (size %d) - SDL_ttf Error: %s\n", filename, ptsize, TTF_GetError());
#ifndef SKIP_ERROR_HANDLING
            return luaL_error(L, "cannot load font file");
#else
            lua_pushnil(L);
            return 1;
#endif
        }
    }

    // Create a font structure like original implementation
    ttf* result = (ttf*)malloc(sizeof(ttf));
    if (!result) {
        // Don't close the global default font
        if (sdl_font != g_defaultFont) {
            TTF_CloseFont(sdl_font);
        }
#ifndef SKIP_ERROR_HANDLING
        return luaL_error(L, "cannot allocate font memory");
#else
        lua_pushnil(L);
        return 1;
#endif
    }
    
    memset(result, 0, sizeof(ttf));
    result->f = (void*)sdl_font; // Store SDL font in f pointer
    result->size = ptsize;
    result->scale = 0.919f; // Same as original Vita implementation
    result->magic = 0x4C464E54; // Same magic number as original
    
    // Return integer pointer like original implementation (use uintptr_t for 64-bit compatibility)
    lua_pushinteger(L, (lua_Integer)(uintptr_t)result);
    return 1;
}

static int lua_fsize(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 2)
		return luaL_error(L, "wrong number of arguments");
#endif
	ttf* font = (ttf*)(luaL_checkinteger(L, 1));
	int size = luaL_checkinteger(L, 2);
#ifndef SKIP_ERROR_HANDLING
	if (font->magic != 0x4C464E54)
		return luaL_error(L, "attempt to access wrong memory block type");
#endif

	// To change font size in SDL, we need to reload the font
	// Unfortunately, we don't have the original font path stored
	// For now, just update the size variable and use scaling during rendering
	font->size = size;
	font->scale = size / 17.402f;
	
	// TODO: Implement proper font reloading with new size
	// This would require storing the original font path in the ttf struct
	
	return 0;
}

static int lua_freefont(lua_State *L) {
    // Handle both integer font handles (from Font.load) and userdata (from other contexts)
    if (lua_isnumber(L, 1)) {
        // Handle integer font handle (from Font.load)
        lua_Integer font_handle = lua_tointeger(L, 1);
        ttf* font_obj = (ttf*)(uintptr_t)font_handle;
        
        if (font_obj && font_obj->magic == 0x4C464E54) {
            if (font_obj->f) {
                TTF_CloseFont((TTF_Font*)font_obj->f);
                font_obj->f = NULL;
            }
            font_obj->magic = 0; // Invalidate magic
            free(font_obj);
        }
    } else if (lua_isuserdata(L, 1)) {
        // Handle userdata (for __gc metamethod)
        lpp_font* font_obj = (lpp_font*)luaL_checkudata(L, 1, "LPP.Font");

        if (font_obj != NULL && font_obj->magic == 0xABADF011) {
            if (font_obj->font != NULL) {
                TTF_CloseFont(font_obj->font);
                font_obj->font = NULL; // Prevent double free
            }
            font_obj->magic = 0; // Invalidate magic number after freeing
        }
    }
    // If neither integer nor valid userdata, silently ignore (robust for __gc)
    return 0;
}

static int lua_fprint(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc < 5 || argc > 7)
        return luaL_error(L, "Font.print(font, x, y, text, color, [screen], [eye]): wrong number of arguments");
#endif
    
    // Get arguments - compatible with both Vita (5 args) and 3DS (6-7 args) versions
    ttf *font = (ttf *)(luaL_checkinteger(L, 1));
    float x = luaL_checknumber(L, 2);
    float y = luaL_checknumber(L, 3);
    const char *text = luaL_checkstring(L, 4);
    
    // Handle screen parameter for dual screen support
    int screen = (argc >= 6) ? luaL_checkinteger(L, 6) : 0; // Default to TOP_SCREEN
    // int eye = (argc == 7) ? luaL_checkinteger(L, 7) : 0; // 3D eye (ignored in SDL port)
    
    // Calculate screen offsets for dual screen support
    int x_offset = getScreenXOffset(screen);
    int y_offset = getScreenYOffset(screen);
    (void)x_offset; // Suppress unused variable warning
    (void)y_offset; // Suppress unused variable warning
    
    uint32_t color_val;
    // Handle both Color objects (tables) and integer colors for compatibility
    if (lua_istable(L, 5)) {
        // Color object - extract r, g, b, a from table
        lua_getfield(L, 5, "r");
        uint8_t r = (uint8_t)luaL_checkinteger(L, -1);
        lua_pop(L, 1);
        
        lua_getfield(L, 5, "g");
        uint8_t g = (uint8_t)luaL_checkinteger(L, -1);
        lua_pop(L, 1);
        
        lua_getfield(L, 5, "b");
        uint8_t b = (uint8_t)luaL_checkinteger(L, -1);
        lua_pop(L, 1);
        
        lua_getfield(L, 5, "a");
        uint8_t a = 255;
        if (!lua_isnil(L, -1)) {
            a = (uint8_t)luaL_checkinteger(L, -1);
        }
        lua_pop(L, 1);
        
        // Pack into RGBA format
        color_val = (a << 24) | (b << 16) | (g << 8) | r;
    } else {
        // Integer color
        color_val = luaL_checkinteger(L, 5);
    }

#ifndef SKIP_ERROR_HANDLING
    if (font->magic != 0x4C464E54)
        return luaL_error(L, "attempt to access wrong memory block type");
#endif

    if (!g_renderer) {
        return luaL_error(L, "SDL Renderer not available for fprint");
    }

    // Extract color components
    SDL_Color sdl_color = {
        (Uint8)((color_val) & 0xFF),         // R
        (Uint8)((color_val >> 8) & 0xFF),    // G
        (Uint8)((color_val >> 16) & 0xFF),   // B
        (Uint8)((color_val >> 24) & 0xFF)    // A
    };

    // Get SDL font from ttf structure
    TTF_Font* sdl_font = (TTF_Font*)font->f;
    if (!sdl_font) {
        fprintf(stderr, "Font.print: Invalid SDL font\n");
        return 0;
    }

    // Handle multiline text by splitting on \n characters
    std::string text_str(text);
    std::vector<std::string> lines;
    
    // Split text by newlines
    size_t start = 0;
    size_t end = text_str.find('\n');
    while (end != std::string::npos) {
        lines.push_back(text_str.substr(start, end - start));
        start = end + 1;
        end = text_str.find('\n', start);
    }
    lines.push_back(text_str.substr(start)); // Add the last line
    
    // Get line height for spacing
    int line_height = TTF_FontHeight(sdl_font);
    float scale_factor = (float)font->size / 16.0f;
    int scaled_line_height = (int)(line_height * scale_factor);
    
    // Render each line
    for (size_t i = 0; i < lines.size(); i++) {
        if (lines[i].empty()) continue; // Skip empty lines
        
        SDL_Surface* text_surface = TTF_RenderText_Blended(sdl_font, lines[i].c_str(), sdl_color);
        if (!text_surface) {
            fprintf(stderr, "TTF_RenderText_Blended Error: %s\n", TTF_GetError());
            continue;
        }

        SDL_Texture* text_texture = SDL_CreateTextureFromSurface(g_renderer, text_surface);
        if (!text_texture) {
            fprintf(stderr, "SDL_CreateTextureFromSurface Error: %s\n", SDL_GetError());
            SDL_FreeSurface(text_surface);
            continue;
        }
        
        // Set texture filtering to linear for smooth scaled fonts
        SDL_SetTextureScaleMode(text_texture, SDL_ScaleModeLinear);
        
        int scaled_width = (int)(text_surface->w * scale_factor);
        int scaled_height = (int)(text_surface->h * scale_factor);
        
        // Render at specified position with proper scaling and line spacing - start with local coordinates
        SDL_Rect dest_rect = { 
            (int)x, 
            (int)y + (int)(i * scaled_line_height), // Local coordinates with line spacing
            scaled_width, 
            scaled_height 
        };

        // Apply screen offsets for 3DS mode
        if (g_compat_mode == LPP_COMPAT_3DS) {
            // In single-screen mode, skip rendering if this isn't the active screen
            if (g_3ds_single_screen_mode && screen != g_3ds_active_screen) {
                continue; // Skip rendering text for inactive screen
            }
            
            int screen_x_offset = getScreenXOffset(screen);
            int screen_y_offset = getScreenYOffset(screen);
            dest_rect.x += screen_x_offset;
            dest_rect.y += screen_y_offset;
            
            // Set viewport clipping for this screen
            setScreenViewport(screen);
        }

        SDL_RenderCopy(g_renderer, text_texture, NULL, &dest_rect);
        
        // Reset clipping after drawing
        if (g_compat_mode == LPP_COMPAT_3DS) {
            SDL_RenderSetClipRect(g_renderer, NULL);
        }

        SDL_DestroyTexture(text_texture);
        SDL_FreeSurface(text_surface);
    }

    return 0;
}

static int lua_fprint_center(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    // font, y, text, color, [scale]
    if (argc < 4 || argc > 5) 
        return luaL_error(L, "Font.printCenter(font, y, text, color, [scale]): wrong number of arguments");
#endif

    lpp_font* font_obj = (lpp_font*)luaL_checkudata(L, 1, "LPP.Font");
    int y = (int)luaL_checknumber(L, 2);
    const char* text = luaL_checkstring(L, 3);

    // Color is argument 4, expected to be a table {r, g, b, [a]}
    luaL_checktype(L, 4, LUA_TTABLE);

    lua_getfield(L, 4, "r");
    uint8_t r_val = (uint8_t)luaL_checkinteger(L, -1);
    lua_pop(L, 1); // pop r_val

    lua_getfield(L, 4, "g");
    uint8_t g_val = (uint8_t)luaL_checkinteger(L, -1);
    lua_pop(L, 1); // pop g_val

    lua_getfield(L, 4, "b");
    uint8_t b_val = (uint8_t)luaL_checkinteger(L, -1);
    lua_pop(L, 1); // pop b_val

    // Optional: Check for alpha, default to 255 if not present
    lua_getfield(L, 4, "a");
    uint8_t a_val = lua_isnil(L, -1) ? 255 : (uint8_t)luaL_checkinteger(L, -1);
    lua_pop(L, 1); // pop a_val or nil

    float scale = (argc == 5) ? (float)luaL_checknumber(L, 5) : 1.0f;

#ifndef SKIP_ERROR_HANDLING
    if (!font_obj || font_obj->magic != 0xABADF011 || !font_obj->font) {
        return luaL_error(L, "Invalid font object passed to Font.printCenter");
    }
#endif

    if (!g_renderer) {
        return luaL_error(L, "SDL Renderer not available for Font.printCenter");
    }

    int text_width = 0;
    int text_height = 0; 
    if (TTF_SizeText(font_obj->font, text, &text_width, &text_height) != 0) {
        fprintf(stderr, "TTF_SizeText Error for printCenter: %s\n", TTF_GetError());
        return 0; 
    }

    int actual_x = (SCREEN_WIDTH - text_width) / 2;

    SDL_Color sdl_color = { r_val, g_val, b_val, a_val };

    SDL_Surface* text_surface = TTF_RenderText_Blended(font_obj->font, text, sdl_color);
    if (!text_surface) {
        fprintf(stderr, "TTF_RenderText_Blended Error (printCenter): %s\n", TTF_GetError());
        return 0;
    }

    SDL_Texture* text_texture = SDL_CreateTextureFromSurface(g_renderer, text_surface);
    if (!text_texture) {
        fprintf(stderr, "SDL_CreateTextureFromSurface Error (printCenter): %s\n", SDL_GetError());
        SDL_FreeSurface(text_surface);
        return 0;
    }

    // Set scale mode to linear for smooth font rendering
    SDL_SetTextureScaleMode(text_texture, SDL_ScaleModeLinear);

    SDL_Rect dest_rect = { actual_x, y, (int)(text_surface->w * scale), (int)(text_surface->h * scale) };
    SDL_RenderCopy(g_renderer, text_texture, NULL, &dest_rect);

    SDL_DestroyTexture(text_texture);
    SDL_FreeSurface(text_surface);

    return 0;
}

static int lua_fwidth(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 2) // font_obj, text
        return luaL_error(L, "Graphics.fwidth(font, text): wrong number of arguments");
#endif

    lpp_font* font_obj = (lpp_font*)luaL_checkudata(L, 1, "LPP.Font");
    const char* text = luaL_checkstring(L, 2);

#ifndef SKIP_ERROR_HANDLING
    if (!font_obj || font_obj->magic != 0xABADF011 || !font_obj->font) {
        return luaL_error(L, "Invalid font object passed to Graphics.fwidth");
    }
#endif

    int width = 0;
    int height = 0; // TTF_SizeText gives both, we only need width for this func

    if (TTF_SizeText(font_obj->font, text, &width, &height) != 0) {
        fprintf(stderr, "TTF_SizeText Error: %s\n", TTF_GetError());
        lua_pushinteger(L, 0); // Return 0 on error
    } else {
        lua_pushinteger(L, width);
    }

    return 1;
}

static int lua_fheight(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 1) // Expects only font_obj
        return luaL_error(L, "Graphics.fheight(font): wrong number of arguments");
#endif

    lpp_font* font_obj = (lpp_font*)luaL_checkudata(L, 1, "LPP.Font");

#ifndef SKIP_ERROR_HANDLING
    if (!font_obj || font_obj->magic != 0xABADF011 || !font_obj->font) {
        return luaL_error(L, "Invalid font object passed to Graphics.fheight");
    }
#endif

    int height = TTF_FontHeight(font_obj->font);
    lua_pushinteger(L, height);

    return 1;
}

static int lua_rescaleron(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 4)
		return luaL_error(L, "wrong number of arguments");
	if (isRescaling)
		return luaL_error(L, "cannot start two different rescalers together");
#endif
	int x = luaL_checkinteger(L, 1);
	int y = luaL_checkinteger(L, 2);
	float x_scale = luaL_checknumber(L, 3);
	float y_scale = luaL_checknumber(L, 4);
	scaler.x = x;
	scaler.y = y;
	scaler.x_scale = x_scale;
	scaler.y_scale = y_scale;
	// Porting to SDL
	isRescaling = true;
	return 0;
}

static int lua_rescaleroff(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0)
		return luaL_error(L, "wrong number of arguments");
	if (!isRescaling)
		return luaL_error(L, "no rescaler available");
#endif
	// Porting to SDL
	return 0;
}

static int lua_gpixel(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 3)
		return luaL_error(L, "wrong number of arguments");
#endif
	int x = luaL_checkinteger(L, 1);
	int y = luaL_checkinteger(L, 2);
	lpp_texture* text = (lpp_texture*)lua_touserdata(L, 3);
#ifndef SKIP_ERROR_HANDLING
	if (text->magic != 0xABADBEEF)
		return luaL_error(L, "attempt to access wrong memory block type.");
#endif
	
	if (!text->data) {
		lua_pushinteger(L, 0); // Return black if no pixel data
		return 1;
	}
	
	// Check bounds
	if (x < 0 || y < 0 || x >= text->w || y >= text->h) {
		lua_pushinteger(L, 0); // Return black for out of bounds
		return 1;
	}
	
	// Get pixel from stored RGBA data
	Uint32* pixels = (Uint32*)text->data;
	Uint32 pixel = pixels[y * text->w + x];
	
	// Extract ABGR components (ABGR8888 format: A=bits 24-31, B=bits 16-23, G=bits 8-15, R=bits 0-7)
	Uint8 r = (pixel >> 0) & 0xFF;
	Uint8 g = (pixel >> 8) & 0xFF;
	Uint8 b = (pixel >> 16) & 0xFF;
	Uint8 a = (pixel >> 24) & 0xFF;
	
	// Force alpha to 255 for compatibility with 3DS behavior (BMPs don't have alpha)
	a = 255;
	
	// Pack into RGBA format that matches Color.new() format (RGBA: R=bits 0-7, G=bits 8-15, B=bits 16-23, A=bits 24-31)
	// Pure green (0,255,0) should be 65280 = 0xFF00
	uint32_t color = r | (g << 8) | (b << 16) | (a << 24);
	
	lua_pushinteger(L, (int32_t)color);
	return 1;
}

static int lua_spixel(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 4)
		return luaL_error(L, "Graphics.setPixel(x, y, color, texture): wrong number of arguments");
#endif
	int x = luaL_checkinteger(L, 1);
	int y = luaL_checkinteger(L, 2);
	uint32_t color = luaL_checkinteger(L, 3);
	lpp_texture* text = (lpp_texture*)lua_touserdata(L, 4);
#ifndef SKIP_ERROR_HANDLING
	if (text->magic != 0xABADBEEF)
		return luaL_error(L, "attempt to access wrong memory block type.");
#endif
	
	if (!text->data) {
		return luaL_error(L, "Cannot set pixel: texture has no pixel data");
	}
	
	// Check bounds
	if (x < 0 || y < 0 || x >= text->w || y >= text->h) {
		return 0; // Silently ignore out of bounds writes
	}
	
	// Extract color components from input (RGBA format)
	Uint8 r = color & 0xFF;
	Uint8 g = (color >> 8) & 0xFF;
	Uint8 b = (color >> 16) & 0xFF;
	Uint8 a = (color >> 24) & 0xFF;
	
	// Convert to ABGR8888 format for storage (matches how we read pixels)
	Uint32 abgr_color = r | (g << 8) | (b << 16) | (a << 24);
	
	// Set pixel in stored RGBA data
	Uint32* pixels = (Uint32*)text->data;
	pixels[y * text->w + x] = abgr_color;
	
	// Update the SDL texture with modified data
	// This is expensive but necessary for the changes to be visible
	SDL_Texture* sdl_texture = (SDL_Texture*)text->texture;
	if (sdl_texture) {
		void* texture_pixels;
		int pitch;
		if (SDL_LockTexture(sdl_texture, NULL, &texture_pixels, &pitch) == 0) {
			memcpy(texture_pixels, text->data, text->w * text->h * 4);
			SDL_UnlockTexture(sdl_texture);
		}
	}
	
	return 0;
}

static int lua_overloadimg(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 4)
		return luaL_error(L, "wrong number of arguments");
#endif
	lpp_texture* text = (lpp_texture*)lua_touserdata(L, 1);
	int offs = luaL_checkinteger(L, 2);
	int size = luaL_checkinteger(L, 3);
	uint8_t *data = (uint8_t *)luaL_checkstring(L, 4);
#ifndef SKIP_ERROR_HANDLING
	if (text->magic != 0xABADBEEF)
		return luaL_error(L, "attempt to access wrong memory block type.");
#endif
	// SDL doesn't provide direct texture data access like Vita2D
	// This function would require texture locking/unlocking
	// For now, this is a placeholder - TODO: implement with SDL_LockTexture
	(void)offs; (void)size; (void)data; // Suppress unused variable warnings
	return 0;
}

// Methods for Font objects ( userdata.__index = Font_methods_table )
static const luaL_Reg Font_methods[] = {
    {"print",           lua_fprint},
    {"printCenter",     lua_fprint_center},
    {"width",           lua_fwidth},
    {"height",          lua_fheight},
    {"setPixelSizes",   lua_fsize},
    {"unload",          lua_freefont},
    {NULL, NULL}
};

// Functions for the global Color table
static int lua_color_new(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc < 3 || argc > 4) {
        return luaL_error(L, "Color.new(r, g, b, [a]): wrong number of arguments");
    }

    int r = luaL_checkinteger(L, 1);
    int g = luaL_checkinteger(L, 2);
    int b = luaL_checkinteger(L, 3);
    int a = (argc == 4) ? luaL_checkinteger(L, 4) : 255;

    // Return packed integer color for compatibility with existing games
    int color = r | (g << 8) | (b << 16) | (a << 24);
    lua_pushinteger(L, color);
    return 1;
}

static int lua_getR(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 1)
        return luaL_error(L, "wrong number of arguments");
#endif
    int color = luaL_checkinteger(L, 1);
    int colour = color & 0xFF;
    lua_pushinteger(L, colour);
    return 1;
}

static int lua_getG(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 1)
        return luaL_error(L, "wrong number of arguments");
#endif
    int color = luaL_checkinteger(L, 1);
    int colour = (color >> 8) & 0xFF;
    lua_pushinteger(L, colour);
    return 1;
}

static int lua_getB(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 1)
        return luaL_error(L, "wrong number of arguments");
#endif
    int color = luaL_checkinteger(L, 1);
    int colour = (color >> 16) & 0xFF;
    lua_pushinteger(L, colour);
    return 1;
}

static int lua_getA(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 1)
        return luaL_error(L, "wrong number of arguments");
#endif
    int color = luaL_checkinteger(L, 1);
    int colour = (color >> 24) & 0xFF;
    lua_pushinteger(L, colour);
    return 1;
}

static const luaL_Reg Color_functions[] = {
    {"new", lua_color_new},
    {"getR", lua_getR},
    {"getG", lua_getG},
    {"getB", lua_getB},
    {"getA", lua_getA},
    {NULL, NULL}
};

// Functions for the global Font table (e.g., Font.load)
static const luaL_Reg Font_functions[] = {
    {"load",        lua_loadFont},
    {"unload",      lua_freefont},
    {"print",       lua_fprint},
    {"printCenter", lua_fprint_center},
    {"size",        lua_fsize},
    {NULL, NULL}
};

static const luaL_Reg Global_Font_functions[] = {
    {"load",            lua_loadFont},
    {"unload",          lua_freefont},
    {"print",           lua_fprint},
    {"printCenter",     lua_fprint_center},
    {"setPixelSizes",   lua_fsize},
    {NULL, NULL}
};

//Register our Graphics Functions
static const luaL_Reg Graphics_functions[] = {
	{"createImage",         lua_createimage},
	{"debugPrint",          lua_print},
	{"printf",              lua_graphics_printf},
	{"drawImage",           lua_drawimg},
	{"drawImageExtended",   lua_drawimg_full},
	{"drawCircle",          lua_circle},
	{"drawLine",            lua_line},
	{"drawPartialImage",    lua_drawimg_part},
	{"drawPixel",           lua_pixel},
	{"drawRect",            lua_emptyrect},
	{"drawRotateImage",     lua_drawimg_rotate},
	{"drawScaleImage",      lua_drawimg_scale},
	{"fillCircle",          lua_circle},
	{"fillEmptyRect",       lua_emptyrect},
	{"fillRect",            lua_rect},
	{"freeImage",           lua_free},
	{"getImageFramesNum",   lua_getnumframes},
	{"getImageHeight",      lua_getheight},
	{"getImageWidth",       lua_getwidth},
	{"getPixel",            lua_gpixel},
	{"setPixel",            lua_spixel},
	{"init",                lua_init},  // Alias for initBlend for compatibility
	{"initBlend",           lua_init},
	{"initRescaler",        lua_rescaleron},
	{"loadAnimatedImage",   lua_loadanimg},
	{"loadImage",           lua_loadimg},
	{"loadImageAsync",      lua_loadimgasync},
	{"overloadImage",       lua_overloadimg},
	{"saveImage",           lua_saveimg},
	{"setImageFilters",     lua_filters},
	{"setImageFrame",       lua_setframe},
	{"termBlend",           lua_term},
	{"termRescaler",        lua_rescaleroff},
	{0, 0}
};

void luaGraphics_init(lua_State *L) {
    uint32_t FILTER_POINT = (uint32_t)0; // SDL_ScaleModeNearest equivalent for placeholder
    uint32_t FILTER_LINEAR = (uint32_t)1; // SDL_ScaleModeLinear equivalent for placeholder
    // Remove SCE specific memory types or map to generic concepts if necessary
    // For now, let's comment them out as they are not directly used by SDL graphics calls here
    // uint32_t MEM_VRAM = (uint32_t)SCE_KERNEL_MEMBLOCK_TYPE_USER_CDRAM_RW;
    // uint32_t MEM_PHYCONT_RAM = (uint32_t)SCE_KERNEL_MEMBLOCK_TYPE_USER_MAIN_PHYCONT_RW;
    // uint32_t MEM_RAM = (uint32_t)SCE_KERNEL_MEMBLOCK_TYPE_USER_RW;
    // VariableRegister(L, MEM_VRAM);
    // VariableRegister(L, MEM_PHYCONT_RAM);
    // VariableRegister(L, MEM_RAM);
    VariableRegister(L, FILTER_POINT);
    VariableRegister(L, FILTER_LINEAR);
    
    // Register image format constants
    VariableRegister(L, FORMAT_BMP);
    VariableRegister(L, FORMAT_PNG);
    VariableRegister(L, FORMAT_JPG);

    // Create Graphics global table
    lua_newtable(L);
    luaL_setfuncs(L, Graphics_functions, 0);
    lua_setglobal(L, "Graphics");

    // Create Font metatable ("LPP.Font")
    luaL_newmetatable(L, "LPP.Font");       // Stack: metatable
    lua_pushstring(L, "__index");           // Stack: metatable, "__index"
    lua_newtable(L);                        // Stack: metatable, "__index", method_table
    luaL_setfuncs(L, Font_methods, 0);      // Register methods to method_table
    lua_settable(L, -3);                    // metatable.__index = method_table. Stack: metatable
    
    lua_pushstring(L, "__gc");              // Stack: metatable, "__gc"
    lua_pushcfunction(L, lua_freefont);     // Stack: metatable, "__gc", lua_freefont
    lua_settable(L, -3);                    // metatable.__gc = lua_freefont. Stack: metatable
    lua_pop(L, 1);                          // Pop metatable, not needed on stack globally

    // Create Font global table (for Font.load)
    lua_newtable(L);
    luaL_setfuncs(L, Global_Font_functions, 0);
    lua_setglobal(L, "Font");

    // Create Color global table
    lua_newtable(L);
    luaL_setfuncs(L, Color_functions, 0);
    lua_setglobal(L, "Color");

    // Initialize g_defaultFont (example, ensure font.ttf is accessible)
    // This should ideally be done after TTF_Init() in main_sdl.cpp
    // For now, we ensure it's NULL if not loaded by main_sdl.cpp
    if (!g_defaultFont) {
        // fprintf(stderr, "luaGraphics_init: g_defaultFont is NULL. Load it in main_sdl.cpp\n");
    }
}