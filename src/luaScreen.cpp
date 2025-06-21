#include <SDL.h>

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

#include "sdl_renderer.h"
#include "luaplayer.h"

// Forward declaration
extern "C" void update_sdl_controls();

static int lua_flip(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0)
        return luaL_error(L, "wrong number of arguments.");
#endif

    // Process SDL events
    SDL_Event e;
    while (SDL_PollEvent(&e) != 0) {
        if (e.type == SDL_QUIT) {
            should_exit = true; // Signal main loop to exit
            exit(0); // Force immediate exit for games with infinite loops
        }
        if (e.type == SDL_KEYDOWN && e.key.keysym.sym == SDLK_ESCAPE) {
            should_exit = true; // Signal main loop to exit
            exit(0); // Force immediate exit for games with infinite loops
        }
        // F11 to toggle fullscreen (common convention)
        if (e.type == SDL_KEYDOWN && e.key.keysym.sym == SDLK_F11) {
            if (g_window) {
                Uint32 flags = SDL_GetWindowFlags(g_window);
                if (flags & SDL_WINDOW_FULLSCREEN_DESKTOP) {
                    SDL_SetWindowFullscreen(g_window, 0);
                } else {
                    SDL_SetWindowFullscreen(g_window, SDL_WINDOW_FULLSCREEN_DESKTOP);
                }
                
                // Reapply logical size after fullscreen toggle in Vita compat mode
                if (g_renderer && g_vita_compat_mode) {
                    // Clear first
                    SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
                    SDL_RenderClear(g_renderer);
                    
                    // Reapply scaling settings
                    SDL_RenderSetLogicalSize(g_renderer, SCREEN_WIDTH, SCREEN_HEIGHT);
                    SDL_RenderSetIntegerScale(g_renderer, SDL_FALSE);
                    
                    // Set scale quality
                    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1");
                }
            }
        }
        // Handle window resize events to maintain proper scaling
        if (e.type == SDL_WINDOWEVENT && (e.window.event == SDL_WINDOWEVENT_RESIZED || e.window.event == SDL_WINDOWEVENT_SIZE_CHANGED)) {
            // Reapply logical size only in Vita compatibility mode
            if (g_renderer && g_vita_compat_mode) {
                // Reset logical size to clear any scaling artifacts
                SDL_RenderSetLogicalSize(g_renderer, 0, 0);
                
                // Clear the entire window surface (not logical area)
                SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
                SDL_RenderClear(g_renderer);
                SDL_RenderPresent(g_renderer);
                
                // Now re-establish logical scaling
                SDL_RenderSetLogicalSize(g_renderer, SCREEN_WIDTH, SCREEN_HEIGHT);
                SDL_RenderSetIntegerScale(g_renderer, SDL_FALSE);
                SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1");
                
                // Clear again with new logical size
                SDL_RenderClear(g_renderer);
            }
        }
    }

    // Update controls for Lua input
    update_sdl_controls();

    // Present the rendered frame
    if (g_renderer) { // Ensure g_renderer is valid
        SDL_RenderPresent(g_renderer);
        // Reset renderer state to prevent artifacts
        SDL_SetRenderDrawBlendMode(g_renderer, SDL_BLENDMODE_BLEND);
    }

    // Check if the Lua script wants to exit
    lua_getglobal(L, " exiting"); // Check for a Lua global flag (e.g., _G.exiting = true)
    if (lua_isboolean(L, -1)) {
        if (lua_toboolean(L, -1)) {
            should_exit = true;
        }
    }
    lua_pop(L, 1); // Remove the global from the stack

    // Small delay to prevent 100% CPU usage if vsync is not perfectly working or not enabled
    SDL_Delay(1); // Adjust as needed, 1ms is usually fine with vsync

    return 0;
}

static int lua_clear(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if ((argc != 1) && (argc != 0))
		return luaL_error(L, "wrong number of arguments.");
#endif
	if (argc == 1) {
		int color = luaL_checkinteger(L,1);
		if (color != clr_color) {
			SDL_SetRenderDrawColor(g_renderer, (color) & 0xFF, (color >> 8) & 0xFF, (color >> 16) & 0xFF, (color >> 24) & 0xFF);
			clr_color = color;
		}
	} else {
		SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
	}
	SDL_RenderClear(g_renderer);
	return 0;
}

static int lua_getP(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 2)
		return luaL_error(L, "wrong number of arguments");
#endif
	int x = luaL_checkinteger(L, 1);
	int y = luaL_checkinteger(L, 2);
	// SDL doesn't provide direct framebuffer access like Vita2D
	// This would require reading pixels from renderer which is expensive
	// For now, return 0 (black) as placeholder
	lua_pushinteger(L, 0);
	return 1;
}

static int lua_vblank(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0)
		return luaL_error(L, "wrong number of arguments");
#endif
	// SDL handles VSync automatically with SDL_RENDERER_PRESENTVSYNC
	// No explicit VBlank wait needed
	return 0;
}

static int lua_color(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if ((argc != 3) && (argc != 4))
		return luaL_error(L, "wrong number of arguments");
#endif
	int r = luaL_checkinteger(L, 1);
	int g = luaL_checkinteger(L, 2);
	int b = luaL_checkinteger(L, 3);
	int a = 255;
	if (argc==4) a = luaL_checkinteger(L, 4);
	int color = r | (g << 8) | (b << 16) | (a << 24);
	lua_pushinteger(L,color);
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
	lua_pushinteger(L,colour);
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
	lua_pushinteger(L,colour);
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
	lua_pushinteger(L,colour);
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
	lua_pushinteger(L,colour);
	return 1;
}

//Register our Color Functions
static const luaL_Reg Color_functions[] = {
	{"new",   lua_color},
	{"getR",  lua_getR},
	{"getG",  lua_getG},
	{"getB",  lua_getB},
	 {"getA",  lua_getA},
	{0, 0}
};

//Register our Screen Functions
// Screen.waitVblankStart()
static int lua_waitVblankStart(lua_State *L) {
    // Simple delay to cap framerate, approximates waiting for vblank
    SDL_Delay(16);
    return 0;
}

// Get actual renderer width for native resolution mode
static int lua_getScreenWidth(lua_State *L) {
    if (g_vita_compat_mode) {
        lua_pushinteger(L, SCREEN_WIDTH);
    } else {
        int w, h;
        if (g_renderer && SDL_GetRendererOutputSize(g_renderer, &w, &h) == 0) {
            lua_pushinteger(L, w);
        } else {
            lua_pushinteger(L, 800); // Fallback
        }
    }
    return 1;
}

// Get actual renderer height for native resolution mode
static int lua_getScreenHeight(lua_State *L) {
    if (g_vita_compat_mode) {
        lua_pushinteger(L, SCREEN_HEIGHT);
    } else {
        int w, h;
        if (g_renderer && SDL_GetRendererOutputSize(g_renderer, &w, &h) == 0) {
            lua_pushinteger(L, h);
        } else {
            lua_pushinteger(L, 600); // Fallback
        }
    }
    return 1;
}

static const luaL_Reg Screen_functions[] = {
	{"clear",            lua_clear},
	{"flip",             lua_flip},
    {"waitVblankStart",  lua_waitVblankStart},
	{"getPixel",         lua_getP},
	{"waitVblankStart",  lua_vblank},
    {"getWidth",         lua_getScreenWidth},
    {"getHeight",        lua_getScreenHeight},
	{0, 0}
};

void luaScreen_init(lua_State *L) {
	lua_newtable(L);
	luaL_setfuncs(L, Screen_functions, 0);
	lua_setglobal(L, "Screen");
	lua_newtable(L);
	luaL_setfuncs(L, Color_functions, 0);
	lua_setglobal(L, "Color");
}