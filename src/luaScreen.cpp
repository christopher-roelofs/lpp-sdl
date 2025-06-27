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
#include <SDL_image.h>
#include <string>
#include <vector>
#include <algorithm>

// Forward declaration
extern "C" void update_sdl_controls();

// Helper functions from Graphics module
extern int getScreenXOffset(int screen_id);
extern int getScreenYOffset(int screen_id);
extern void getScreenScaling(int screen_id, float* scale_x, float* scale_y);
extern void setScreenViewport(int screen_id);
extern SDL_Renderer* g_renderer;
extern TTF_Font* g_defaultFont;
extern bool g_vita_compat_mode;
extern lpp_compat_mode_t g_compat_mode;

// LPP texture structure is already defined in luaplayer.h

// Console structure for 3DS compatibility
struct Console {
    int screen_id;
    std::vector<std::string> lines;
    int max_lines;
    int font_size;
    SDL_Color text_color;
    int x_offset;
    int y_offset;
    int line_height;
    bool valid;
};

// Storage for console instances
static std::vector<Console*> consoles;
static int next_console_id = 1;

// Helper function to translate Vita paths (app0:/ -> current directory, ux0:/ -> .)
static std::string translate_vita_path(const char* path) {
    std::string result(path);
    
    // Replace app0:/ with current directory (empty string means relative to current dir)
    size_t pos = result.find("app0:/");
    if (pos != std::string::npos) {
        result.replace(pos, 6, "");  // Remove "app0:/"
    }
    
    // Replace ux0:/ with current directory (user data path)
    pos = result.find("ux0:/");
    if (pos != std::string::npos) {
        result.replace(pos, 5, "");  // Remove "ux0:/"
    }
    
    return result;
}

// Helper function to get console by Lua userdata
Console* getConsole(lua_State *L, int index) {
    Console** console_ptr = (Console**)lua_touserdata(L, index);
    if (!console_ptr || !*console_ptr || !(*console_ptr)->valid) {
        return nullptr;
    }
    return *console_ptr;
}

// Helper function to render console text
void renderConsoleText(const char* text, int x, int y, SDL_Color color) {
    if (!g_defaultFont || !g_renderer || !text || strlen(text) == 0) {
        printf("Console render failed: font=%p renderer=%p text=%s\n", g_defaultFont, g_renderer, text ? text : "null");
        return;
    }
    
    SDL_Surface* text_surface = TTF_RenderText_Blended(g_defaultFont, text, color);
    if (!text_surface) {
        printf("Failed to create text surface for: %s\n", text);
        return;
    }
    
    SDL_Texture* text_texture = SDL_CreateTextureFromSurface(g_renderer, text_surface);
    if (text_texture) {
        SDL_Rect dest_rect = {x, y, text_surface->w, text_surface->h};
        SDL_RenderCopy(g_renderer, text_texture, NULL, &dest_rect);
        SDL_DestroyTexture(text_texture);
    }
    
    SDL_FreeSurface(text_surface);
}

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
        // TAB key to switch between screens in 3DS single-screen mode
        if (e.type == SDL_KEYDOWN && e.key.keysym.sym == SDLK_TAB && g_3ds_single_screen_mode) {
            // Switch active screen
            g_3ds_active_screen = (g_3ds_active_screen == 0) ? 1 : 0;
            
            // Use uniform logical size to prevent artifacts
            int logical_width = DS_TOP_SCREEN_WIDTH;  // Always use 400px width
            int logical_height = DS_TOP_SCREEN_HEIGHT; // Always use 240px height
            
            if (SDL_RenderSetLogicalSize(g_renderer, logical_width, logical_height) == 0) {
                const char* screen_name = (g_3ds_active_screen == 0) ? "top" : "bottom";
                printf("Switched to %s screen (%dx%d logical, scaled to fill window)\n", screen_name, logical_width, logical_height);
                
                // Reset render state to ensure proper rendering after switch
                SDL_SetRenderDrawBlendMode(g_renderer, SDL_BLENDMODE_BLEND);
                // Don't reset clipping here - let individual screens handle their own clipping
            }
        }
        // Handle window resize events to maintain proper scaling
        if (e.type == SDL_WINDOWEVENT && (e.window.event == SDL_WINDOWEVENT_RESIZED || e.window.event == SDL_WINDOWEVENT_SIZE_CHANGED)) {
            // Reapply logical size for both modes
            if (g_renderer) {
                if (g_compat_mode == LPP_COMPAT_3DS) {
                    // 3DS dual screen mode: recalculate manual scaling factors
                    extern SDL_Window* g_window;
                    int new_window_width, new_window_height;
                    SDL_GetWindowSize(g_window, &new_window_width, &new_window_height);
                    
                    // Recalculate scaling factors for manual scaling
                    g_scale_x = (float)new_window_width / (float)DUAL_SCREEN_WIDTH;
                    g_scale_y = (float)new_window_height / (float)DUAL_SCREEN_HEIGHT;
                    
                    // Recalculate per-screen scaling factors to maintain proper aspect ratios
                    // Allocate proportional width space for each screen 
                    float top_screen_area_width = (float)new_window_width * DS_TOP_SCREEN_WIDTH / DUAL_SCREEN_WIDTH;
                    float bottom_screen_area_width = (float)new_window_width * DS_BOTTOM_SCREEN_WIDTH / DUAL_SCREEN_WIDTH;
                    
                    // For top screen: scale to fit allocated width, constrained by window height
                    float top_scale_x = top_screen_area_width / DS_TOP_SCREEN_WIDTH;
                    float top_scale_y = (float)new_window_height / DS_TOP_SCREEN_HEIGHT;
                    float top_uniform_scale = fminf(top_scale_x, top_scale_y);
                    
                    // For bottom screen: scale to fit allocated width, constrained by window height
                    float bottom_scale_x = bottom_screen_area_width / DS_BOTTOM_SCREEN_WIDTH;
                    float bottom_scale_y = (float)new_window_height / DS_BOTTOM_SCREEN_HEIGHT;
                    float bottom_uniform_scale = fminf(bottom_scale_x, bottom_scale_y);
                    
                    // Apply maximum height constraint to bottom screen
                    float max_bottom_height = new_window_height * 0.8f;
                    float max_bottom_scale_from_height = max_bottom_height / DS_BOTTOM_SCREEN_HEIGHT;
                    bottom_uniform_scale = fminf(bottom_uniform_scale, max_bottom_scale_from_height);
                    
                    g_top_screen_scale_x = top_uniform_scale;
                    g_top_screen_scale_y = top_uniform_scale;
                    g_bottom_screen_scale_x = bottom_uniform_scale;
                    g_bottom_screen_scale_y = bottom_uniform_scale;
                    
                    // Clear the screen
                    SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
                    SDL_RenderClear(g_renderer);
                } else {
                    // Reset logical size to clear any scaling artifacts
                    SDL_RenderSetLogicalSize(g_renderer, 0, 0);
                    
                    // Clear the entire window surface (not logical area)
                    SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
                    SDL_RenderClear(g_renderer);
                    SDL_RenderPresent(g_renderer);
                    
                    // Re-establish logical scaling based on mode
                    if (g_compat_mode == LPP_COMPAT_VITA) {
                        SDL_RenderSetLogicalSize(g_renderer, SCREEN_WIDTH, SCREEN_HEIGHT);
                    } else if (g_compat_mode == LPP_COMPAT_3DS) {
                        // 3DS mode: use appropriate dual screen dimensions
                        if (g_3ds_orientation == LPP_3DS_VERTICAL) {
                            SDL_RenderSetLogicalSize(g_renderer, DUAL_SCREEN_WIDTH_V, DUAL_SCREEN_HEIGHT_V);
                        } else {
                            SDL_RenderSetLogicalSize(g_renderer, DUAL_SCREEN_WIDTH_H, DUAL_SCREEN_HEIGHT_H);
                        }
                    } else {
                        SDL_RenderSetLogicalSize(g_renderer, NATIVE_LOGICAL_WIDTH, NATIVE_LOGICAL_HEIGHT);
                    }
                    SDL_RenderSetIntegerScale(g_renderer, SDL_FALSE);
                    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1");
                    
                    // Clear again with new logical size
                    SDL_RenderClear(g_renderer);
                }
            }
        }
    }

    // Update controls for Lua input
    update_sdl_controls();

    // Single-screen mode now uses dynamic logical sizing per screen

    // Present the rendered frame
    if (g_renderer) { // Ensure g_renderer is valid
#ifdef __APPLE__
        // Clear letterbox areas before present to prevent artifacts on macOS ARM64
        SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
        SDL_Rect viewport;
        SDL_RenderGetViewport(g_renderer, &viewport);
        
        int window_w, window_h;
        SDL_GetWindowSize(g_window, &window_w, &window_h);
        
        // Clear areas outside viewport if letterboxing is active
        if (viewport.w < window_w || viewport.h < window_h) {
            // Clear left/right letterbox areas
            if (viewport.x > 0) {
                SDL_Rect left_box = {0, 0, viewport.x, window_h};
                SDL_RenderFillRect(g_renderer, &left_box);
            }
            if (viewport.x + viewport.w < window_w) {
                SDL_Rect right_box = {viewport.x + viewport.w, 0, window_w - (viewport.x + viewport.w), window_h};
                SDL_RenderFillRect(g_renderer, &right_box);
            }
            // Clear top/bottom letterbox areas
            if (viewport.y > 0) {
                SDL_Rect top_box = {0, 0, window_w, viewport.y};
                SDL_RenderFillRect(g_renderer, &top_box);
            }
            if (viewport.y + viewport.h < window_h) {
                SDL_Rect bottom_box = {0, viewport.y + viewport.h, window_w, window_h - (viewport.y + viewport.h)};
                SDL_RenderFillRect(g_renderer, &bottom_box);
            }
        }
#endif
        
        // Add black padding for bottom screen in single-screen mode
        if (g_3ds_single_screen_mode && g_3ds_active_screen == 1) {
            SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
            
            // Draw black padding on left side (0 to 40)
            SDL_Rect left_padding = {0, 0, 40, DS_TOP_SCREEN_HEIGHT};
            SDL_RenderFillRect(g_renderer, &left_padding);
            
            // Draw black padding on right side (360 to 400) 
            SDL_Rect right_padding = {360, 0, 40, DS_TOP_SCREEN_HEIGHT};
            SDL_RenderFillRect(g_renderer, &right_padding);
        }
        
        SDL_RenderPresent(g_renderer);
        
        // In 3DS compatibility mode, preserve framebuffer content like the original 3DS
        // This prevents content from being cleared between frames
        if (g_compat_mode != LPP_COMPAT_3DS) {
            // Reset renderer state to prevent artifacts (only in non-3DS modes)
            SDL_SetRenderDrawBlendMode(g_renderer, SDL_BLENDMODE_BLEND);
        }
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
		int arg = luaL_checkinteger(L,1);
		
		// Check if this is a 3DS screen constant (0=TOP_SCREEN, 1=BOTTOM_SCREEN)
		if (arg == 0 || arg == 1) {
			// Auto-enable dual screen mode when 3DS screen constants are used
			if (!g_dual_screen_mode) {
				g_dual_screen_mode = true;
				printf("Auto-enabling dual screen mode\n");
				
				// Adjust logical size for dual screen
				if (g_renderer && g_vita_compat_mode) {
					SDL_RenderSetLogicalSize(g_renderer, SCREEN_WIDTH, DUAL_SCREEN_HEIGHT);
					printf("Set logical size to %dx%d for dual screen\n", SCREEN_WIDTH, DUAL_SCREEN_HEIGHT);
				} else {
					// In native mode, we need to resize the window to fit both screens
					extern SDL_Window* g_window;
					if (g_window) {
						int current_w, current_h;
						SDL_GetWindowSize(g_window, &current_w, &current_h);
						if (current_h < DUAL_SCREEN_HEIGHT) {
							SDL_SetWindowSize(g_window, current_w, DUAL_SCREEN_HEIGHT);
							printf("Resized window to %dx%d for dual screen in native mode\n", current_w, DUAL_SCREEN_HEIGHT);
						}
					}
				}
			}
			
			// 3DS dual screen mode: clear specific screen area
			SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
			
			if (g_compat_mode == LPP_COMPAT_3DS) {
				// In single-screen mode, still clear both screens
				// Only the display shows one at a time, but both should be kept current
				
				// 3DS compatibility mode: clear only the specified screen area
				SDL_Rect screen_rect;
				
				// Get screen offsets and dimensions
				int x_offset = getScreenXOffset(arg);
				int y_offset = getScreenYOffset(arg);
				
				if (arg == 0) {
					// TOP_SCREEN
					screen_rect.x = x_offset;
					screen_rect.y = y_offset;
					screen_rect.w = DS_TOP_SCREEN_WIDTH;
					screen_rect.h = DS_TOP_SCREEN_HEIGHT;
				} else {
					// BOTTOM_SCREEN
					if (g_3ds_single_screen_mode) {
						// In single-screen mode, first clear the entire logical area to black
						// to prevent the top screen from showing through
						SDL_Rect full_clear = {0, 0, DS_TOP_SCREEN_WIDTH, DS_TOP_SCREEN_HEIGHT};
						SDL_RenderFillRect(g_renderer, &full_clear);
					}
					
					screen_rect.x = x_offset;
					screen_rect.y = y_offset;
					screen_rect.w = DS_BOTTOM_SCREEN_WIDTH;
					screen_rect.h = DS_BOTTOM_SCREEN_HEIGHT;
				}
				
				// Set viewport clipping for this screen
				setScreenViewport(arg);
				
				SDL_RenderFillRect(g_renderer, &screen_rect);
				
				// Reset clipping after clearing
				SDL_RenderSetClipRect(g_renderer, NULL);
			} else if (g_dual_screen_mode) {
				// Legacy dual screen mode
				SDL_Rect screen_rect;
				screen_rect.x = 0;
				screen_rect.w = SCREEN_WIDTH;
				screen_rect.h = SCREEN_HEIGHT;
				
				if (arg == 0) {
					// TOP_SCREEN
					screen_rect.y = TOP_SCREEN_Y_OFFSET;
				} else {
					// BOTTOM_SCREEN
					screen_rect.y = BOTTOM_SCREEN_Y_OFFSET;
				}
				
				SDL_RenderFillRect(g_renderer, &screen_rect);
			} else {
				// Single screen mode: clear entire screen
				SDL_RenderClear(g_renderer);
			}
		} else {
			// Treat as color value
			if (arg != clr_color) {
				SDL_SetRenderDrawColor(g_renderer, (arg) & 0xFF, (arg >> 8) & 0xFF, (arg >> 16) & 0xFF, (arg >> 24) & 0xFF);
				clr_color = arg;
			}
			SDL_RenderClear(g_renderer);
		}
	} else {
		// No arguments: clear entire screen with black
		SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
		SDL_RenderClear(g_renderer);
	}
	return 0;
}

static int lua_getP(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 3)
		return luaL_error(L, "Screen.getPixel(x, y, texture): wrong number of arguments");
#endif
	
	int x = luaL_checkinteger(L, 1);
	int y = luaL_checkinteger(L, 2);
	void* texture_ptr = lua_touserdata(L, 3);
	
	if (!texture_ptr) {
		lua_pushinteger(L, 0); // Return black for invalid texture
		return 1;
	}
	
	// Cast to lpp_texture
	lpp_texture* tex = (lpp_texture*)texture_ptr;
	
	if (!tex->data) {
		lua_pushinteger(L, 0); // Return black if no pixel data
		return 1;
	}
	
	// Check bounds
	if (x < 0 || y < 0 || x >= tex->w || y >= tex->h) {
		lua_pushinteger(L, 0); // Return black for out of bounds
		return 1;
	}
	
	// Get pixel from stored RGBA data
	Uint32* pixels = (Uint32*)tex->data;
	Uint32 pixel = pixels[y * tex->w + x];
	
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
	uint32_t color = r | (g << 8) | (b << 16) | (a << 24);
	lua_pushinteger(L, (int32_t)color);
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

// Forward declarations for Console functions
static int lua_console_new(lua_State *L);
static int lua_console_show(lua_State *L);
static int lua_console_clear(lua_State *L);
static int lua_console_append(lua_State *L);
static int lua_console_destroy(lua_State *L);

// Console function registration table
static const luaL_Reg Console_functions[] = {
    {"new",     lua_console_new},
    {"show",    lua_console_show},
    {"clear",   lua_console_clear},
    {"append",  lua_console_append},
    {"destroy", lua_console_destroy},
    {0, 0}
};

//Register our Screen Functions
// Screen.waitVblankStart()
static int lua_waitVblankStart(lua_State *L) {
    // Simple delay to cap framerate, approximates waiting for vblank
    SDL_Delay(16);
    return 0;
}

// Get logical screen width
static int lua_getScreenWidth(lua_State *L) {
    if (g_compat_mode == LPP_COMPAT_VITA) {
        lua_pushinteger(L, SCREEN_WIDTH);
    } else if (g_compat_mode == LPP_COMPAT_3DS) {
        // 3DS mode: return appropriate dual screen width (always use the actual screen layout width)
        if (g_3ds_orientation == LPP_3DS_VERTICAL) {
            lua_pushinteger(L, DUAL_SCREEN_WIDTH_V);
        } else {
            lua_pushinteger(L, DUAL_SCREEN_WIDTH_H);
        }
    } else {
        // Native mode: return logical width for consistent coordinate system
        lua_pushinteger(L, NATIVE_LOGICAL_WIDTH);
    }
    return 1;
}

// Get logical screen height
static int lua_getScreenHeight(lua_State *L) {
    if (g_compat_mode == LPP_COMPAT_VITA) {
        lua_pushinteger(L, SCREEN_HEIGHT);
    } else if (g_compat_mode == LPP_COMPAT_3DS) {
        // 3DS mode: return appropriate dual screen height (always use the actual screen layout height)
        if (g_3ds_orientation == LPP_3DS_VERTICAL) {
            lua_pushinteger(L, DUAL_SCREEN_HEIGHT_V);
        } else {
            lua_pushinteger(L, DUAL_SCREEN_HEIGHT_H);
        }
    } else {
        // Native mode: return logical height for consistent coordinate system
        lua_pushinteger(L, NATIVE_LOGICAL_HEIGHT);
    }
    return 1;
}

// Dual screen mode control
static int lua_enableDualScreen(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    g_dual_screen_mode = true;
    
    // Adjust logical size for dual screen (only if not using manual scaling)
    if (g_renderer && g_vita_compat_mode) {
        // Check if we're in 3DS compat mode with manual scaling
        // For now, don't override manual scaling setup
        printf("enableDualScreen: dual screen mode enabled\n");
    } else {
        // Native mode: resize window for dual screen
        extern SDL_Window* g_window;
        if (g_window) {
            int current_w, current_h;
            SDL_GetWindowSize(g_window, &current_w, &current_h);
            if (current_h < DUAL_SCREEN_HEIGHT) {
                SDL_SetWindowSize(g_window, current_w, DUAL_SCREEN_HEIGHT);
            }
        }
    }
    
    return 0;
}

static int lua_disableDualScreen(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    g_dual_screen_mode = false;
    
    // Reset logical size for single screen (only if not using manual scaling)
    if (g_renderer && g_vita_compat_mode) {
        // In 3DS compat mode with manual scaling, don't override SDL settings
        printf("disableDualScreen: dual screen mode disabled\n");
    }
    
    return 0;
}

// 3DS-specific 3D functions for compatibility
static int lua_get3DLevel(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    // For SDL port, always return 0 (3D disabled)
    lua_pushinteger(L, 0);
    return 1;
}

static int lua_enable3D(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    // For SDL port, this is a no-op
    return 0;
}

static int lua_disable3D(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    // For SDL port, this is a no-op
    return 0;
}

// 3DS Screen drawing functions
static int lua_screen_fillRect(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc < 5 || argc > 7) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    int x1 = luaL_checkinteger(L, 1);
    int x2 = luaL_checkinteger(L, 2);
    int y1 = luaL_checkinteger(L, 3);
    int y2 = luaL_checkinteger(L, 4);
    int color = luaL_checkinteger(L, 5);
    int screen = (argc >= 6) ? luaL_checkinteger(L, 6) : 0; // Default to TOP_SCREEN
    // int eye = (argc == 7) ? luaL_checkinteger(L, 7) : 0; // 3D eye (ignored in SDL port)
    
    
    // Auto-enable dual screen mode if using screen constants
    if ((screen == 0 || screen == 1) && !g_dual_screen_mode) {
        g_dual_screen_mode = true;
        printf("Auto-enabling dual screen mode\n");
        
        // Only resize window in native mode - 3DS compat mode already has correct size
        if (!g_vita_compat_mode) {
            extern SDL_Window* g_window;
            if (g_window) {
                int current_w, current_h;
                SDL_GetWindowSize(g_window, &current_w, &current_h);
                if (current_h < DUAL_SCREEN_HEIGHT) {
                    SDL_SetWindowSize(g_window, current_w, DUAL_SCREEN_HEIGHT);
                    printf("Resized window to %dx%d for dual screen in native mode\n", current_w, DUAL_SCREEN_HEIGHT);
                }
            }
        }
    }
    
    // Calculate screen offsets
    int x_offset = getScreenXOffset(screen);
    int y_offset = getScreenYOffset(screen);
    
    // Set color
    SDL_SetRenderDrawColor(g_renderer, 
                          (color) & 0xFF, 
                          (color >> 8) & 0xFF, 
                          (color >> 16) & 0xFF, 
                          (color >> 24) & 0xFF);
    
    // Create rectangle (ensure proper ordering) - start with local coordinates
    SDL_Rect rect;
    rect.x = (x1 < x2) ? x1 : x2;  // Local X coordinate (no offset yet)
    rect.y = (y1 < y2) ? y1 : y2;  // Local Y coordinate (no offset yet)
    rect.w = abs(x2 - x1);
    rect.h = abs(y2 - y1);
    
    // Apply per-screen scaling and positioning for dual screen mode
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // In single-screen mode, still render both screens
        // Only the display shows one at a time, but both should be kept current
        
        // 3DS dual screen mode: use coordinate offsets (no clipping needed with SDL logical scaling)
        int screen_x_offset = getScreenXOffset(screen);
        int screen_y_offset = getScreenYOffset(screen);
        
        // Add screen offset to position the screen correctly in the logical coordinate space
        rect.x += screen_x_offset;
        rect.y += screen_y_offset;
        
        // Set viewport clipping for this screen
        setScreenViewport(screen);
    } else {
        // Non-3DS dual screen mode: just add the basic offset
        rect.x += x_offset;
        rect.y += y_offset;
    }
    
    SDL_RenderFillRect(g_renderer, &rect);
    
    // Reset clipping after drawing
    if (g_compat_mode == LPP_COMPAT_3DS) {
        SDL_RenderSetClipRect(g_renderer, NULL);
    }
    return 0;
}

static int lua_screen_fillEmptyRect(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc < 5 || argc > 7) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    int x1 = luaL_checkinteger(L, 1);
    int x2 = luaL_checkinteger(L, 2);
    int y1 = luaL_checkinteger(L, 3);
    int y2 = luaL_checkinteger(L, 4);
    int color = luaL_checkinteger(L, 5);
    int screen = (argc >= 6) ? luaL_checkinteger(L, 6) : 0; // Default to TOP_SCREEN
    
    
    // Auto-enable dual screen mode if using screen constants
    if ((screen == 0 || screen == 1) && !g_dual_screen_mode) {
        g_dual_screen_mode = true;
        printf("Auto-enabling dual screen mode\n");
        
        // Only resize window in native mode - 3DS compat mode already has correct size
        if (!g_vita_compat_mode) {
            extern SDL_Window* g_window;
            if (g_window) {
                int current_w, current_h;
                SDL_GetWindowSize(g_window, &current_w, &current_h);
                if (current_h < DUAL_SCREEN_HEIGHT) {
                    SDL_SetWindowSize(g_window, current_w, DUAL_SCREEN_HEIGHT);
                    printf("Resized window to %dx%d for dual screen in native mode\n", current_w, DUAL_SCREEN_HEIGHT);
                }
            }
        }
    }
    
    // Calculate screen offsets
    int x_offset = getScreenXOffset(screen);
    int y_offset = getScreenYOffset(screen);
    
    // Set color
    SDL_SetRenderDrawColor(g_renderer, 
                          (color) & 0xFF, 
                          (color >> 8) & 0xFF, 
                          (color >> 16) & 0xFF, 
                          (color >> 24) & 0xFF);
    
    // Create rectangle (ensure proper ordering) - start with local coordinates
    SDL_Rect rect;
    rect.x = (x1 < x2) ? x1 : x2;  // Local X coordinate (no offset yet)
    rect.y = (y1 < y2) ? y1 : y2;  // Local Y coordinate (no offset yet)
    rect.w = abs(x2 - x1);
    rect.h = abs(y2 - y1);
    
    // Apply screen positioning for dual screen mode
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // In single-screen mode, still render both screens
        // Only the display shows one at a time, but both should be kept current
        
        // Use simple coordinate offsets (SDL logical scaling handles the rest)
        int x_offset = getScreenXOffset(screen);
        int y_offset = getScreenYOffset(screen);
        
        // Add screen offset to position the screen correctly in the logical coordinate space
        rect.x += x_offset;
        rect.y += y_offset;
        
        // Set viewport clipping for this screen
        setScreenViewport(screen);
    } else {
        // Non-dual screen mode: just add the offset
        rect.x += x_offset;
        rect.y += y_offset;
    }
    
    SDL_RenderDrawRect(g_renderer, &rect);
    
    // Reset clipping after drawing
    if (g_compat_mode == LPP_COMPAT_3DS) {
        SDL_RenderSetClipRect(g_renderer, NULL);
    }
    return 0;
}

static int lua_screen_drawLine(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc < 5 || argc > 7) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    int x1 = luaL_checkinteger(L, 1);
    int x2 = luaL_checkinteger(L, 2);
    int y1 = luaL_checkinteger(L, 3);
    int y2 = luaL_checkinteger(L, 4);
    int color = luaL_checkinteger(L, 5);
    int screen = (argc >= 6) ? luaL_checkinteger(L, 6) : 0; // Default to TOP_SCREEN
    
    
    // Auto-enable dual screen mode if using screen constants
    if ((screen == 0 || screen == 1) && !g_dual_screen_mode) {
        g_dual_screen_mode = true;
        printf("Auto-enabling dual screen mode\n");
        
        // Only resize window in native mode - 3DS compat mode already has correct size
        if (!g_vita_compat_mode) {
            extern SDL_Window* g_window;
            if (g_window) {
                int current_w, current_h;
                SDL_GetWindowSize(g_window, &current_w, &current_h);
                if (current_h < DUAL_SCREEN_HEIGHT) {
                    SDL_SetWindowSize(g_window, current_w, DUAL_SCREEN_HEIGHT);
                    printf("Resized window to %dx%d for dual screen in native mode\n", current_w, DUAL_SCREEN_HEIGHT);
                }
            }
        }
    }
    
    // Calculate screen offsets
    int x_offset = getScreenXOffset(screen);
    int y_offset = getScreenYOffset(screen);
    
    // Set color
    SDL_SetRenderDrawColor(g_renderer, 
                          (color) & 0xFF, 
                          (color >> 8) & 0xFF, 
                          (color >> 16) & 0xFF, 
                          (color >> 24) & 0xFF);
    
    // Apply screen positioning for dual screen mode
    int scaled_x1 = x1, scaled_y1 = y1;
    int scaled_x2 = x2, scaled_y2 = y2;
    
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // In single-screen mode, still render both screens
        // Only the display shows one at a time, but both should be kept current
        
        // Use simple coordinate offsets (SDL logical scaling handles the rest)
        int screen_x_offset = getScreenXOffset(screen);
        int screen_y_offset = getScreenYOffset(screen);
        
        // Add screen offset to position the line correctly in the logical coordinate space
        scaled_x1 += screen_x_offset;
        scaled_y1 += screen_y_offset;
        scaled_x2 += screen_x_offset;
        scaled_y2 += screen_y_offset;
        
        // Set viewport clipping for this screen
        setScreenViewport(screen);
    } else {
        // Non-dual screen mode: just add the offset
        scaled_x1 += x_offset;
        scaled_y1 += y_offset;
        scaled_x2 += x_offset;
        scaled_y2 += y_offset;
    }
    
    SDL_RenderDrawLine(g_renderer, scaled_x1, scaled_y1, scaled_x2, scaled_y2);
    
    // Reset clipping after drawing
    if (g_compat_mode == LPP_COMPAT_3DS) {
        SDL_RenderSetClipRect(g_renderer, NULL);
    }
    return 0;
}

static int lua_screen_drawImage(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc < 3 || argc > 5) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    int x = luaL_checkinteger(L, 1);
    int y = luaL_checkinteger(L, 2);
    void* texture_ptr = lua_touserdata(L, 3);
    int screen = (argc >= 4) ? luaL_checkinteger(L, 4) : 0; // Default to TOP_SCREEN
    
    
    if (!texture_ptr) {
        return luaL_error(L, "Invalid texture provided");
    }
    
    // Auto-enable dual screen mode if using screen constants
    if ((screen == 0 || screen == 1) && !g_dual_screen_mode) {
        g_dual_screen_mode = true;
        printf("Auto-enabling dual screen mode\n");
        
        // Only resize window in native mode - 3DS compat mode already has correct size
        if (!g_vita_compat_mode) {
            extern SDL_Window* g_window;
            if (g_window) {
                int current_w, current_h;
                SDL_GetWindowSize(g_window, &current_w, &current_h);
                if (current_h < DUAL_SCREEN_HEIGHT) {
                    SDL_SetWindowSize(g_window, current_w, DUAL_SCREEN_HEIGHT);
                    printf("Resized window to %dx%d for dual screen in native mode\n", current_w, DUAL_SCREEN_HEIGHT);
                }
            }
        }
    }
    
    // Calculate screen offsets
    int x_offset = getScreenXOffset(screen);
    int y_offset = getScreenYOffset(screen);
    
    // Cast to lpp_texture
    lpp_texture* tex = (lpp_texture*)texture_ptr;
    
    // Get texture dimensions from stored values
    int tex_w = tex->w;
    int tex_h = tex->h;
    
    // Create destination rectangle - start with local coordinates
    SDL_Rect dest_rect = {x, y, tex_w, tex_h};
    
    // Apply screen positioning for dual screen mode
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // In single-screen mode, still render both screens
        // Only the display shows one at a time, but both should be kept current
        
        // Use simple coordinate offsets (SDL logical scaling handles the rest)
        int screen_x_offset = getScreenXOffset(screen);
        int screen_y_offset = getScreenYOffset(screen);
        
        // Add screen offset to position the image correctly in the logical coordinate space
        dest_rect.x += screen_x_offset;
        dest_rect.y += screen_y_offset;
        
        // Set viewport clipping for this screen
        setScreenViewport(screen);
    } else {
        // Non-dual screen mode: just add the offset
        dest_rect.x += x_offset;
        dest_rect.y += y_offset;
    }
    
    SDL_RenderCopy(g_renderer, (SDL_Texture*)tex->texture, NULL, &dest_rect);
    
    // Reset clipping after drawing
    if (g_compat_mode == LPP_COMPAT_3DS) {
        SDL_RenderSetClipRect(g_renderer, NULL);
    }
    return 0;
}

static int lua_screen_drawPartialImage(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc < 7 || argc > 9) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    int dest_x = luaL_checkinteger(L, 1);
    int dest_y = luaL_checkinteger(L, 2);
    int src_x = luaL_checkinteger(L, 3);
    int src_y = luaL_checkinteger(L, 4);
    int src_w = luaL_checkinteger(L, 5);
    int src_h = luaL_checkinteger(L, 6);
    void* texture_ptr = lua_touserdata(L, 7);
    int screen = (argc >= 8) ? luaL_checkinteger(L, 8) : 0; // Default to TOP_SCREEN
    
    
    if (!texture_ptr) {
        return luaL_error(L, "Invalid texture provided");
    }
    
    // Auto-enable dual screen mode if using screen constants
    if ((screen == 0 || screen == 1) && !g_dual_screen_mode) {
        g_dual_screen_mode = true;
        printf("Auto-enabling dual screen mode\n");
        
        // Only resize window in native mode - 3DS compat mode already has correct size
        if (!g_vita_compat_mode) {
            extern SDL_Window* g_window;
            if (g_window) {
                int current_w, current_h;
                SDL_GetWindowSize(g_window, &current_w, &current_h);
                if (current_h < DUAL_SCREEN_HEIGHT) {
                    SDL_SetWindowSize(g_window, current_w, DUAL_SCREEN_HEIGHT);
                    printf("Resized window to %dx%d for dual screen in native mode\n", current_w, DUAL_SCREEN_HEIGHT);
                }
            }
        }
    }
    
    // Calculate screen offsets
    int x_offset = getScreenXOffset(screen);
    int y_offset = getScreenYOffset(screen);
    
    // Cast to lpp_texture
    lpp_texture* tex = (lpp_texture*)texture_ptr;
    
    // Create source and destination rectangles - start with local coordinates
    SDL_Rect src_rect = {src_x, src_y, src_w, src_h};
    SDL_Rect dest_rect = {dest_x, dest_y, src_w, src_h};
    
    // Apply screen positioning for dual screen mode
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // In single-screen mode, still render both screens
        // Only the display shows one at a time, but both should be kept current
        
        // Use simple coordinate offsets (SDL logical scaling handles the rest)
        int screen_x_offset = getScreenXOffset(screen);
        int screen_y_offset = getScreenYOffset(screen);
        
        // Add screen offset to position the partial image correctly in the logical coordinate space
        dest_rect.x += screen_x_offset;
        dest_rect.y += screen_y_offset;
        
        // Set viewport clipping for this screen
        setScreenViewport(screen);
    } else {
        // Non-dual screen mode: just add the offset
        dest_rect.x += x_offset;
        dest_rect.y += y_offset;
    }
    
    SDL_RenderCopy(g_renderer, (SDL_Texture*)tex->texture, &src_rect, &dest_rect);
    
    // Reset clipping after drawing
    if (g_compat_mode == LPP_COMPAT_3DS) {
        SDL_RenderSetClipRect(g_renderer, NULL);
    }
    return 0;
}

// Screen refresh function for 3DS compatibility
static int lua_refresh(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    // Reset clipping rectangle to ensure clean state for new frame
    if (g_renderer) {
        SDL_RenderSetClipRect(g_renderer, NULL);
    }
    
    // For SDL port, refresh is essentially a no-op
    // The actual screen refresh happens in flip()
    return 0;
}

// Screen.loadImage function for 3DS compatibility (same as Graphics.loadImage)
static int lua_screen_loadimg(lua_State *L) {
    const char* path = luaL_checkstring(L, 1);
    
    // Translate Vita paths (app0:/ -> current directory)
    std::string translated_path = translate_vita_path(path);
    
    // Load surface first to get pixel data
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

static int lua_screen_debugPrint(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc < 5 || argc > 6)
        return luaL_error(L, "Screen.debugPrint(x, y, text, color, screen, [eye]): wrong number of arguments.");
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
    
    int screen = luaL_checkinteger(L, 5);
    // int eye = (argc == 6) ? luaL_checkinteger(L, 6) : 0; // 3D eye ignored in SDL port
    
    // Auto-enable dual screen mode if using screen constants
    if ((screen == 0 || screen == 1) && !g_dual_screen_mode) {
        g_dual_screen_mode = true;
        printf("Auto-enabling dual screen mode\n");
        
        // Only resize window in native mode - 3DS compat mode already has correct size
        if (!g_vita_compat_mode) {
            extern SDL_Window* g_window;
            if (g_window) {
                int current_w, current_h;
                SDL_GetWindowSize(g_window, &current_w, &current_h);
                if (current_h < DUAL_SCREEN_HEIGHT) {
                    SDL_SetWindowSize(g_window, current_w, DUAL_SCREEN_HEIGHT);
                    printf("Resized window to %dx%d for dual screen in native mode\n", current_w, DUAL_SCREEN_HEIGHT);
                }
            }
        }
    }
    
    if (!g_defaultFont) {
        fprintf(stderr, "Error: g_defaultFont not loaded. Cannot render text with Screen.debugPrint.\n");
        return 0; // Don't cause Lua error, just don't render
    }

    if (!g_renderer) {
        fprintf(stderr, "Error: g_renderer not initialized. Cannot render text with Screen.debugPrint.\n");
        return 0;
    }

    // Extract color components
    SDL_Color sdl_color = {
        (Uint8)(color_val & 0xFF),         // r
        (Uint8)((color_val >> 8) & 0xFF),  // g
        (Uint8)((color_val >> 16) & 0xFF), // b
        (Uint8)((color_val >> 24) & 0xFF)  // a (though TTF ignores alpha)
    };

    // Create text surface
    SDL_Surface* text_surface = TTF_RenderText_Solid(g_defaultFont, text, sdl_color);
    if (!text_surface) {
        fprintf(stderr, "Error creating text surface: %s\n", TTF_GetError());
        return 0;
    }

    // Create texture from surface
    SDL_Texture* text_texture = SDL_CreateTextureFromSurface(g_renderer, text_surface);
    if (!text_texture) {
        fprintf(stderr, "Error creating text texture: %s\n", SDL_GetError());
        SDL_FreeSurface(text_surface);
        return 0;
    }
    

    // Get text dimensions and apply 3DS-specific scaling
    int text_w = text_surface->w;
    int text_h = text_surface->h;
    SDL_FreeSurface(text_surface);

    // Apply 3DS-specific font scaling to reduce text size for smaller screens
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // 3DS screens are much smaller than Vita (400x240 vs 960x544)
        // Apply scaling factor to make text proportionally smaller
        float scale_factor = 0.6f; // Reduce text size by 40% for 3DS compatibility
        text_w = (int)(text_w * scale_factor);
        text_h = (int)(text_h * scale_factor);
    }

    // Calculate screen offsets
    int x_offset = getScreenXOffset(screen);
    int y_offset = getScreenYOffset(screen);
    
    // Create destination rectangle - start with local coordinates
    SDL_Rect dest_rect = {x, y, text_w, text_h};
    
    // Apply screen positioning - use proper screen offsets in 3DS mode
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // In single-screen mode, only render if this is the active screen
        if (g_3ds_single_screen_mode && screen != g_3ds_active_screen) {
            // Skip rendering for inactive screen in single-screen mode
            SDL_DestroyTexture(text_texture);
            return 0;
        }
        
        // 3DS mode: Use coordinate offsets based on screen layout orientation
        int screen_x_offset = getScreenXOffset(screen);
        int screen_y_offset = getScreenYOffset(screen);
        
        
        // Add screen offset to position the text correctly in the logical coordinate space
        dest_rect.x += screen_x_offset;
        dest_rect.y += screen_y_offset;
    } else {
        // Non-3DS mode: use the legacy offset calculation
        dest_rect.x += x_offset;
        dest_rect.y += y_offset;
    }

    // Render the text
    SDL_RenderCopy(g_renderer, text_texture, NULL, &dest_rect);
    
    // Cleanup
    SDL_DestroyTexture(text_texture);
    
    return 0;
}

// Screen.drawPixel function for 3DS compatibility
static int lua_screen_drawPixel(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc < 3 || argc > 5)
        return luaL_error(L, "Screen.drawPixel(x, y, color, screen, [eye]): wrong number of arguments");
#endif

    int x = luaL_checkinteger(L, 1);
    int y = luaL_checkinteger(L, 2);
    uint32_t color = luaL_checkinteger(L, 3);
    int screen = (argc >= 4) ? luaL_checkinteger(L, 4) : 0; // Default to TOP_SCREEN
    // int eye = (argc == 5) ? luaL_checkinteger(L, 5) : 0; // 3D eye ignored in SDL port
    
    
    // Auto-enable dual screen mode if using screen constants
    if ((screen == 0 || screen == 1) && !g_dual_screen_mode) {
        g_dual_screen_mode = true;
        printf("Auto-enabling dual screen mode\n");
        
        // Only resize window in native mode - 3DS compat mode already has correct size
        if (!g_vita_compat_mode) {
            extern SDL_Window* g_window;
            if (g_window) {
                int current_w, current_h;
                SDL_GetWindowSize(g_window, &current_w, &current_h);
                if (current_h < DUAL_SCREEN_HEIGHT) {
                    SDL_SetWindowSize(g_window, current_w, DUAL_SCREEN_HEIGHT);
                    printf("Resized window to %dx%d for dual screen in native mode\n", current_w, DUAL_SCREEN_HEIGHT);
                }
            }
        }
    }

    if (!g_renderer) {
        return 0; // Silently fail if no renderer
    }

    // Calculate screen offsets
    int x_offset = getScreenXOffset(screen);
    int y_offset = getScreenYOffset(screen);
    
    // Apply screen positioning
    int final_x = x;
    int final_y = y;
    
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // Use simple coordinate offsets (SDL logical scaling handles the rest)
        int screen_x_offset = getScreenXOffset(screen);
        int screen_y_offset = getScreenYOffset(screen);
        
        // Add screen offset to position the pixel correctly in the logical coordinate space
        final_x += screen_x_offset;
        final_y += screen_y_offset;
    } else {
        // Non-dual screen mode: just add the offset
        final_x += x_offset;
        final_y += y_offset;
    }

    // Extract color components
    Uint8 r = color & 0xFF;
    Uint8 g = (color >> 8) & 0xFF;
    Uint8 b = (color >> 16) & 0xFF;
    Uint8 a = (color >> 24) & 0xFF;

    // Set color and draw pixel
    SDL_SetRenderDrawColor(g_renderer, r, g, b, a);
    SDL_RenderDrawPoint(g_renderer, final_x, final_y);

    return 0;
}

// Console.new() - Create a new console
static int lua_console_new(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    int screen_id = luaL_checkinteger(L, 1);
    
    // Create new console
    Console* console = new Console();
    console->screen_id = screen_id;
    console->lines.clear();
    console->max_lines = 25; // Reasonable default
    console->font_size = 16;
    console->text_color = {255, 255, 255, 255}; // White text
    console->x_offset = 10;
    console->y_offset = 10;
    console->line_height = 18;
    console->valid = true;
    
    // Adapt based on screen in 3DS mode
    if (g_compat_mode == LPP_COMPAT_3DS) {
        if (screen_id == 0) { // TOP_SCREEN
            console->max_lines = 13; // Top screen has less vertical space in dual screen mode
            console->x_offset = 5;
            console->y_offset = 5;
        } else { // BOTTOM_SCREEN
            console->max_lines = 12; // Bottom screen
            console->x_offset = 5;
            console->y_offset = 5;
        }
    }
    
    consoles.push_back(console);
    
    // Create Lua userdata
    Console** console_ptr = (Console**)lua_newuserdata(L, sizeof(Console*));
    *console_ptr = console;
    
    return 1;
}

// Console.show() - Show/render console content
static int lua_console_show(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    Console* console = getConsole(L, 1);
    if (!console) {
        return luaL_error(L, "invalid console");
    }
    
    // Calculate screen offsets for dual screen mode
    int screen_x_offset = 0;
    int screen_y_offset = 0;
    
    if (g_compat_mode == LPP_COMPAT_3DS) {
        screen_x_offset = getScreenXOffset(console->screen_id);
        screen_y_offset = getScreenYOffset(console->screen_id);
        
        // Set viewport clipping for this screen
        setScreenViewport(console->screen_id);
    }
    
    // Render console text
    int y = console->y_offset + screen_y_offset;
    
    // Debug: render a test message if console is empty
    if (console->lines.empty()) {
        printf("Console is empty, showing placeholder at %d,%d\n", console->x_offset + screen_x_offset, y);
        renderConsoleText("Console ready. Type to see text here.", console->x_offset + screen_x_offset, y, console->text_color);
    } else {
        printf("Console has %zu lines\n", console->lines.size());
        for (const auto& line : console->lines) {
            printf("Rendering console line at %d,%d: %s\n", console->x_offset + screen_x_offset, y, line.c_str());
            renderConsoleText(line.c_str(), console->x_offset + screen_x_offset, y, console->text_color);
            y += console->line_height;
            
            // Stop if we've reached the bottom of the screen area
            if (y > (screen_y_offset + 240)) break; // Use actual 3DS screen height
        }
    }
    
    // Reset clipping after rendering
    if (g_compat_mode == LPP_COMPAT_3DS) {
        SDL_RenderSetClipRect(g_renderer, NULL);
    }
    
    return 0;
}

// Console.clear() - Clear console content
static int lua_console_clear(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    Console* console = getConsole(L, 1);
    if (!console) {
        return luaL_error(L, "invalid console");
    }
    
    console->lines.clear();
    return 0;
}

// Console.append() - Append text to console
static int lua_console_append(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 2) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    Console* console = getConsole(L, 1);
    if (!console) {
        return luaL_error(L, "invalid console");
    }
    
    const char* text = luaL_checkstring(L, 2);
    
    // Add the text as a new line
    console->lines.push_back(std::string(text));
    
    // Remove old lines if we exceed max_lines
    while ((int)console->lines.size() > console->max_lines) {
        console->lines.erase(console->lines.begin());
    }
    
    return 0;
}

// Console.destroy() - Destroy console
static int lua_console_destroy(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    Console* console = getConsole(L, 1);
    if (!console) {
        return 0; // Already destroyed
    }
    
    // Mark as invalid
    console->valid = false;
    
    // Remove from consoles vector
    auto it = std::find(consoles.begin(), consoles.end(), console);
    if (it != consoles.end()) {
        consoles.erase(it);
    }
    
    // Delete the console
    delete console;
    
    // Clear the userdata pointer
    Console** console_ptr = (Console**)lua_touserdata(L, 1);
    if (console_ptr) {
        *console_ptr = nullptr;
    }
    
    return 0;
}

static int lua_screen_freeImage(lua_State *L) {
    // Screen.freeImage - compatibility wrapper that uses the same logic as Graphics.freeImage
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

static const luaL_Reg Screen_functions[] = {
	{"clear",            lua_clear},
	{"flip",             lua_flip},
	{"refresh",          lua_refresh},
    {"waitVblankStart",  lua_waitVblankStart},
    {"waitVblank",       lua_vblank},
	{"getPixel",         lua_getP},
    {"getWidth",         lua_getScreenWidth},
    {"getHeight",        lua_getScreenHeight},
    {"loadImage",        lua_screen_loadimg},
    {"loadBitmap",       lua_screen_loadimg},
    {"freeImage",        lua_screen_freeImage},
    {"get3DLevel",       lua_get3DLevel},
    {"enable3D",         lua_enable3D},
    {"disable3D",        lua_disable3D},
    {"enableDualScreen", lua_enableDualScreen},
    {"disableDualScreen", lua_disableDualScreen},
    {"fillRect",         lua_screen_fillRect},
    {"fillEmptyRect",    lua_screen_fillEmptyRect},
    {"drawLine",         lua_screen_drawLine},
    {"drawImage",        lua_screen_drawImage},
    {"drawPartialImage", lua_screen_drawPartialImage},
    {"debugPrint",       lua_screen_debugPrint},
    {"drawPixel",        lua_screen_drawPixel},
	{0, 0}
};

void luaScreen_init(lua_State *L) {
	lua_newtable(L);
	luaL_setfuncs(L, Screen_functions, 0);
	lua_setglobal(L, "Screen");
	
	// Add 3DS screen constants for compatibility
	lua_pushinteger(L, 0);
	lua_setglobal(L, "TOP_SCREEN");
	lua_pushinteger(L, 1);
	lua_setglobal(L, "BOTTOM_SCREEN");
	
	// Add 3DS eye constants (for 3D stereoscopic functions)
	lua_pushinteger(L, 0);
	lua_setglobal(L, "LEFT_EYE");
	lua_pushinteger(L, 1);
	lua_setglobal(L, "RIGHT_EYE");
	lua_newtable(L);
	luaL_setfuncs(L, Color_functions, 0);
	lua_setglobal(L, "Color");
	
	// Register Console functions
	lua_newtable(L);
	luaL_setfuncs(L, Console_functions, 0);
	lua_setglobal(L, "Console");
}