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

// Forward declaration
extern "C" void update_sdl_controls();

// Helper functions from Graphics module
extern int getScreenXOffset(int screen_id);
extern int getScreenYOffset(int screen_id);

// LPP texture structure is already defined in luaplayer.h

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
            // Reapply logical size for both modes
            if (g_renderer) {
                if (g_dual_screen_mode && g_vita_compat_mode) {
                    // 3DS dual screen mode: recalculate manual scaling factors
                    extern SDL_Window* g_window;
                    int new_window_width, new_window_height;
                    SDL_GetWindowSize(g_window, &new_window_width, &new_window_height);
                    
                    // Recalculate scaling factors for manual scaling
                    g_scale_x = (float)new_window_width / (float)DUAL_SCREEN_WIDTH;
                    g_scale_y = (float)new_window_height / (float)DUAL_SCREEN_HEIGHT;
                    
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
                    if (g_vita_compat_mode) {
                        SDL_RenderSetLogicalSize(g_renderer, SCREEN_WIDTH, SCREEN_HEIGHT);
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
			
			if (g_dual_screen_mode) {
				// Clear only the specified screen area
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
	if (argc != 2)
		return luaL_error(L, "wrong number of arguments");
#endif
	// Parameters are validated but not used in placeholder implementation
	luaL_checkinteger(L, 1); // x coordinate
	luaL_checkinteger(L, 2); // y coordinate
	
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

// Get logical screen width
static int lua_getScreenWidth(lua_State *L) {
    if (g_vita_compat_mode) {
        lua_pushinteger(L, SCREEN_WIDTH);
    } else {
        // Native mode: return logical width for consistent coordinate system
        lua_pushinteger(L, NATIVE_LOGICAL_WIDTH);
    }
    return 1;
}

// Get logical screen height
static int lua_getScreenHeight(lua_State *L) {
    if (g_vita_compat_mode) {
        lua_pushinteger(L, SCREEN_HEIGHT);
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
        extern bool g_vita_compat_mode;
        extern bool threeds_compat_mode; // This would need to be global
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
    
    printf("DEBUG: screen=%d, x_offset=%d, y_offset=%d\n", screen, x_offset, y_offset);
    printf("DEBUG: x1=%d, x2=%d, y1=%d, y2=%d\n", x1, x2, y1, y2);
    
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
    
    printf("DEBUG: Local coordinates: rect=(%d,%d,%d,%d)\n", rect.x, rect.y, rect.w, rect.h);
    
    // Apply per-screen scaling and positioning for dual screen mode
    if (g_dual_screen_mode && g_vita_compat_mode) {
        // Set viewport clipping for this screen to maintain aspect ratio
        setScreenViewport(screen);
        
        // Get per-screen scaling factors
        float scale_x, scale_y;
        getScreenScaling(screen, &scale_x, &scale_y);
        
        // First: Apply scaling to local coordinates
        rect.x = (int)(rect.x * scale_x);
        rect.y = (int)(rect.y * scale_y);
        rect.w = (int)(rect.w * scale_x);
        rect.h = (int)(rect.h * scale_y);
        
        // Second: Add properly calculated screen offset to position the screen in the window
        // The offset should position the screen in the final window coordinate space
        if (screen == 1) { // BOTTOM_SCREEN
            // Bottom screen should be positioned after the scaled top screen area
            float top_screen_scale_x, top_screen_scale_y;
            getScreenScaling(0, &top_screen_scale_x, &top_screen_scale_y); // Get top screen scaling
            int bottom_screen_x_pos = (int)(DS_TOP_SCREEN_WIDTH * top_screen_scale_x); // Position after top screen
            rect.x += bottom_screen_x_pos;
            rect.y += (int)(y_offset * scale_y); // Y offset can use bottom screen scaling
        } else { // TOP_SCREEN
            // Top screen starts at window origin (no additional offset needed)
            rect.x += (int)(x_offset * scale_x); // Should be 0 for top screen
            rect.y += (int)(y_offset * scale_y); // Should be 0 for top screen
        }
        
        // Calculate actual offset for debug output
        int actual_x_offset = 0, actual_y_offset = 0;
        if (screen == 1) {
            float top_screen_scale_x, top_screen_scale_y;
            getScreenScaling(0, &top_screen_scale_x, &top_screen_scale_y);
            actual_x_offset = (int)(DS_TOP_SCREEN_WIDTH * top_screen_scale_x);
            actual_y_offset = (int)(y_offset * scale_y);
        } else {
            actual_x_offset = (int)(x_offset * scale_x);
            actual_y_offset = (int)(y_offset * scale_y);
        }
        
        printf("DEBUG: Scaled local: (%d,%d,%d,%d), calculated offset: (%d,%d)\n", 
               (int)(((x1 < x2) ? x1 : x2) * scale_x), (int)(((y1 < y2) ? y1 : y2) * scale_y),
               (int)(abs(x2 - x1) * scale_x), (int)(abs(y2 - y1) * scale_y),
               actual_x_offset, actual_y_offset);
        printf("DEBUG: Final positioned rect: (%d,%d,%d,%d)\n", rect.x, rect.y, rect.w, rect.h);
    } else {
        // Non-dual screen mode: just add the offset
        rect.x += x_offset;
        rect.y += y_offset;
    }
    
    printf("DEBUG: Final fillRect screen=%d: (%d,%d,%d,%d)\n", screen, rect.x, rect.y, rect.w, rect.h);
    SDL_RenderFillRect(g_renderer, &rect);
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
    
    // Apply per-screen scaling and positioning for dual screen mode
    if (g_dual_screen_mode && g_vita_compat_mode) {
        // Get per-screen scaling factors
        float scale_x, scale_y;
        getScreenScaling(screen, &scale_x, &scale_y);
        
        // First: Apply scaling to local coordinates
        rect.x = (int)(rect.x * scale_x);
        rect.y = (int)(rect.y * scale_y);
        rect.w = (int)(rect.w * scale_x);
        rect.h = (int)(rect.h * scale_y);
        
        // Second: Add properly calculated screen offset to position the screen in the window
        if (screen == 1) { // BOTTOM_SCREEN
            // Bottom screen should be positioned after the scaled top screen area
            float top_screen_scale_x, top_screen_scale_y;
            getScreenScaling(0, &top_screen_scale_x, &top_screen_scale_y);
            int bottom_screen_x_pos = (int)(DS_TOP_SCREEN_WIDTH * top_screen_scale_x);
            rect.x += bottom_screen_x_pos;
        }
        // Top screen starts at window origin (no additional offset needed)
    } else {
        // Non-dual screen mode: just add the offset
        rect.x += x_offset;
        rect.y += y_offset;
    }
    
    SDL_RenderDrawRect(g_renderer, &rect);
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
    
    // Apply per-screen scaling and positioning for dual screen mode
    int scaled_x1 = x1, scaled_y1 = y1;
    int scaled_x2 = x2, scaled_y2 = y2;
    
    if (g_dual_screen_mode && g_vita_compat_mode) {
        // Get per-screen scaling factors
        float scale_x, scale_y;
        getScreenScaling(screen, &scale_x, &scale_y);
        
        // First: Apply scaling to local coordinates
        scaled_x1 = (int)(x1 * scale_x);
        scaled_y1 = (int)(y1 * scale_y);
        scaled_x2 = (int)(x2 * scale_x);
        scaled_y2 = (int)(y2 * scale_y);
        
        // Second: Add properly calculated screen offset to position the screen in the window
        if (screen == 1) { // BOTTOM_SCREEN
            // Bottom screen should be positioned after the scaled top screen area
            float top_screen_scale_x, top_screen_scale_y;
            getScreenScaling(0, &top_screen_scale_x, &top_screen_scale_y);
            int bottom_screen_x_pos = (int)(DS_TOP_SCREEN_WIDTH * top_screen_scale_x);
            scaled_x1 += bottom_screen_x_pos;
            scaled_x2 += bottom_screen_x_pos;
        }
        // Top screen starts at window origin (no additional offset needed)
    } else {
        // Non-dual screen mode: just add the offset
        scaled_x1 += x_offset;
        scaled_y1 += y_offset;
        scaled_x2 += x_offset;
        scaled_y2 += y_offset;
    }
    
    SDL_RenderDrawLine(g_renderer, scaled_x1, scaled_y1, scaled_x2, scaled_y2);
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
    
    // Apply per-screen scaling and positioning for dual screen mode
    if (g_dual_screen_mode && g_vita_compat_mode) {
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
    } else {
        // Non-dual screen mode: just add the offset
        dest_rect.x += x_offset;
        dest_rect.y += y_offset;
    }
    
    SDL_RenderCopy(g_renderer, (SDL_Texture*)tex->texture, NULL, &dest_rect);
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
    
    // Apply per-screen scaling and positioning for dual screen mode
    if (g_dual_screen_mode && g_vita_compat_mode) {
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
    } else {
        // Non-dual screen mode: just add the offset
        dest_rect.x += x_offset;
        dest_rect.y += y_offset;
    }
    
    SDL_RenderCopy(g_renderer, (SDL_Texture*)tex->texture, &src_rect, &dest_rect);
    return 0;
}

// Screen refresh function for 3DS compatibility
static int lua_refresh(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
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
    
    SDL_Texture* sdl_texture = IMG_LoadTexture(g_renderer, translated_path.c_str());
    if (!sdl_texture) {
        return luaL_error(L, "Error loading image: %s", IMG_GetError());
    }

    lpp_texture* tex = (lpp_texture*)malloc(sizeof(lpp_texture));
    tex->magic = 0xABADBEEF;
    tex->texture = (void*)sdl_texture;
    SDL_QueryTexture(sdl_texture, NULL, NULL, &tex->w, &tex->h);
    tex->data = NULL;

    lua_pushlightuserdata(L, tex);
    return 1;
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
}