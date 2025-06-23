#include <SDL.h>
#include "src/include/luaSystem.h"
#include "src/include/luaTimer.h"
#include <SDL_ttf.h>
#include <string>
#include <unistd.h>

bool should_exit = false; // Definition for the global exit flag
#include <SDL_image.h>
#include <stdio.h>
#include "luaplayer.h"

extern "C" {
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
}

// SCREEN_WIDTH and SCREEN_HEIGHT are now defined in luaplayer.h

#include "src/include/sdl_renderer.h"

SDL_Window* g_window = NULL;
SDL_Renderer* g_renderer = NULL;
bool g_vita_compat_mode = false; // Global flag for Vita compatibility mode
bool g_dual_screen_mode = false; // Global flag for 3DS dual screen mode

// Global variables required by LPP modules
int clr_color = 0;
bool unsafe_mode = false;
bool keyboardStarted = false;
bool messageStarted = false;
volatile bool termMic = false;
volatile int asyncResult = 0;
uint8_t async_task_num = 0;
unsigned char* asyncStrRes = NULL;
uint32_t asyncResSize = 0;
float video_audio_tick = 0.0f;

// Forward declarations for controls update functions
extern "C" void update_sdl_controls();
extern "C" void sdl_key_down(int scancode);
extern "C" void sdl_key_up(int scancode);

int main(int argc, char* args[]) {
    lua_State* L = NULL;
    bool vita_compat_mode = false; // Temporarily disable to test if logical scaling is the issue
    bool threeds_compat_mode = false; // 3DS dual screen compatibility mode
    const char* lua_file = NULL;

    // Parse command line arguments
    for (int i = 1; i < argc; i++) {
        if (strcmp(args[i], "-vitacompat") == 0) {
            vita_compat_mode = true;
            printf("Vita compatibility mode enabled\n");
        } else if (strcmp(args[i], "-3dscompat") == 0) {
            threeds_compat_mode = true;
            vita_compat_mode = true; // 3DS mode implies vita compat for scaling
            printf("3DS compatibility mode enabled (dual screen)\n");
        } else if (strcmp(args[i], "-native") == 0) {
            vita_compat_mode = false;
            threeds_compat_mode = false;
            printf("Native resolution mode enabled\n");
        } else if (lua_file == NULL) {
            lua_file = args[i];
        } else {
            printf("Unknown argument: %s\n", args[i]);
        }
    }

    // Check for Lua file argument
    if (lua_file == NULL) {
        printf("Usage: %s [options] <lua_file>\n", args[0]);
        printf("Options:\n");
        printf("  -vitacompat    Force Vita resolution scaling (960x544 logical size) [DEFAULT]\n");
        printf("  -3dscompat     Enable 3DS dual screen mode (960x1088 logical size)\n");
        printf("  -native        Use native window resolution (no scaling)\n");
        printf("Example: %s hello_test.lua\n", args[0]);
        printf("Example: %s -3dscompat \"tests/games/3ds/blackjack-3ds/index.lua\"\n", args[0]);
        printf("Example: %s -native \"samples/Vita Hangman - Touhou Edition/index.lua\"\n", args[0]);
        return 1;
    }

    printf("Loading Lua file: %s\n", lua_file);

    // Initialize LuaJIT
    L = luaL_newstate();
    if (L == NULL) {
        printf("Failed to create Lua state!\n");
        return 1;
    }
    luaL_openlibs(L); // Open standard libraries
    luaSystem_init(L);
    luaTimer_init(L);

    // Initialize LPP-Vita modules
    luaControls_init(L);
    luaScreen_init(L);
    luaGraphics_init(L);
    luaSound_init(L);
    luaSystem_init(L);
    luaNetwork_init(L);
    luaTimer_init(L);
    luaKeyboard_init(L);
    luaRender_init(L);
    luaMic_init(L);
    luaVideo_init(L);
    luaCamera_init(L);
    luaDatabase_init(L);
    luaRegistry_init(L);
    luaGui_init(L);

    // Initialize SDL
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO) < 0) {
        printf("SDL could not initialize! SDL_Error: %s\n", SDL_GetError());
        return 1;
    }

    // Initialize SDL_image
    if (!(IMG_Init(IMG_INIT_PNG | IMG_INIT_JPG) & (IMG_INIT_PNG | IMG_INIT_JPG))) {
        printf("SDL_image could not initialize! IMG_Error: %s\n", IMG_GetError());
        SDL_Quit();
        return 1;
    }

    // Initialize SDL_ttf
    if (TTF_Init() == -1) {
        printf("SDL_ttf could not initialize! TTF_Error: %s\n", TTF_GetError());
        SDL_Quit();
        return 1;
    }

    // Load the global default font
    g_defaultFont = TTF_OpenFont("InterVariable.ttf", 16); // Default size 16
    if (!g_defaultFont) {
        printf("Warning: Failed to load default font 'InterVariable.ttf'. Graphics.print will not work. TTF_Error: %s\n", TTF_GetError());
        // Continue without default font, lua_print will handle the NULL case
    }

    // Get current display resolution
    SDL_DisplayMode display_mode;
    if (SDL_GetCurrentDisplayMode(0, &display_mode) != 0) {
        printf("Could not get display mode: %s\n", SDL_GetError());
        // Fall back to Vita resolution
        display_mode.w = SCREEN_WIDTH;
        display_mode.h = SCREEN_HEIGHT;
    }
    
    int window_width, window_height;
    
    g_vita_compat_mode = vita_compat_mode; // Store globally for other modules to access
    g_dual_screen_mode = threeds_compat_mode; // Store globally for 3DS dual screen support
    
    if (vita_compat_mode) {
        // Vita/3DS compatibility mode: Calculate window size maintaining aspect ratio
        float aspect_ratio;
        int logical_height;
        
        if (threeds_compat_mode) {
            // 3DS dual screen mode: 960x1088 (two 960x544 screens stacked)
            aspect_ratio = (float)SCREEN_WIDTH / (float)DUAL_SCREEN_HEIGHT;
            logical_height = DUAL_SCREEN_HEIGHT;
        } else {
            // Vita single screen mode: 960x544
            aspect_ratio = (float)SCREEN_WIDTH / (float)SCREEN_HEIGHT;
            logical_height = SCREEN_HEIGHT;
        }
        
        // Start with 70% of screen height, then calculate width to maintain aspect ratio
        window_height = (display_mode.h * 7) / 10;
        window_width = (int)(window_height * aspect_ratio);
        
        // If calculated width is too wide for display, scale based on width instead
        if (window_width > (display_mode.w * 7) / 10) {
            window_width = (display_mode.w * 7) / 10;
            window_height = (int)(window_width / aspect_ratio);
        }
        
        // Ensure window is not larger than logical resolution scaled up by 2x
        if (window_width > SCREEN_WIDTH * 2) {
            window_width = SCREEN_WIDTH * 2;
            window_height = (int)(window_width / aspect_ratio);
        }
        if (window_height > logical_height * 2) {
            window_height = logical_height * 2;
            window_width = (int)(window_height * aspect_ratio);
        }
        
        // Ensure window is at least the logical resolution (maintain aspect ratio)
        if (window_width < SCREEN_WIDTH || window_height < logical_height) {
            window_width = SCREEN_WIDTH;
            window_height = logical_height;
        }
        
        if (threeds_compat_mode) {
            printf("3DS compatibility mode: Window size %dx%d for logical size %dx%d\n", 
                   window_width, window_height, SCREEN_WIDTH, DUAL_SCREEN_HEIGHT);
        } else {
            printf("Vita compatibility mode: Window size %dx%d for logical size %dx%d\n", 
                   window_width, window_height, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
    } else {
        // Native resolution mode: Use 80% of screen size for comfortable windowed experience
        window_width = (display_mode.w * 4) / 5;  // 80% of screen width
        window_height = (display_mode.h * 4) / 5; // 80% of screen height
        
        // Minimum reasonable window size
        if (window_width < 800) window_width = 800;
        if (window_height < 600) window_height = 600;
        
        printf("Native resolution mode: Window size %dx%d\n", window_width, window_height);
    }
    
    // Create window
    g_window = SDL_CreateWindow("Lua Player Plus SDL", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, window_width, window_height, SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE);
    if (g_window == NULL) {
        printf("Window could not be created! SDL_Error: %s\n", SDL_GetError());
        if (g_defaultFont) TTF_CloseFont(g_defaultFont);
        TTF_Quit();
        SDL_Quit();
        return 1;
    }

    // Show window explicitly
    SDL_ShowWindow(g_window);
    SDL_RaiseWindow(g_window);

    // Set scale quality to linear for smoother scaling (before creating renderer)
    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1");
    
    // Set logical size mode to letterbox to prevent stretching artifacts
    SDL_SetHint(SDL_HINT_RENDER_LOGICAL_SIZE_MODE, "letterbox");

    // Create renderer
    g_renderer = SDL_CreateRenderer(g_window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (g_renderer == NULL) {
        printf("Renderer could not be created! SDL_Error: %s\n", SDL_GetError());
        SDL_DestroyWindow(g_window);
        if (g_defaultFont) TTF_CloseFont(g_defaultFont);
        TTF_Quit();
        SDL_Quit();
        return 1;
    }
    
    // Enable alpha blending for proper transparency support
    SDL_SetRenderDrawBlendMode(g_renderer, SDL_BLENDMODE_BLEND);

    // Set logical size only in Vita compatibility mode
    if (vita_compat_mode) {
        // Clear renderer first
        SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
        SDL_RenderClear(g_renderer);
        
        // Use SDL's logical scaling (the original approach that mostly worked)
        int logical_height = threeds_compat_mode ? DUAL_SCREEN_HEIGHT : SCREEN_HEIGHT;
        if (SDL_RenderSetLogicalSize(g_renderer, SCREEN_WIDTH, logical_height) != 0) {
            printf("Warning: Could not set logical size: %s\n", SDL_GetError());
        } else {
            if (threeds_compat_mode) {
                printf("Set logical size to %dx%d (3DS dual screen) in %dx%d window\n", 
                       SCREEN_WIDTH, logical_height, window_width, window_height);
            } else {
                printf("Set logical size to %dx%d (Vita resolution) in %dx%d window\n", 
                       SCREEN_WIDTH, logical_height, window_width, window_height);
            }
        }
        
        // Disable integer scaling for smooth scaling
        SDL_RenderSetIntegerScale(g_renderer, SDL_FALSE);
        
        // Set scale quality to linear for smooth scaling
        SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1");
        
        // Force SDL to use letterboxing instead of stretching - this should prevent edge artifacts
        SDL_SetHint(SDL_HINT_RENDER_LOGICAL_SIZE_MODE, "letterbox");
        
        // Verify the logical size was set
        int logical_w, logical_h;
        SDL_RenderGetLogicalSize(g_renderer, &logical_w, &logical_h);
        printf("Confirmed logical size: %dx%d\n", logical_w, logical_h);
    } else {
        // Native resolution mode: Apply logical scaling with HD 720p base resolution
        // Clear renderer first
        SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
        SDL_RenderClear(g_renderer);
        
        // Set logical size for native resolution mode
        if (SDL_RenderSetLogicalSize(g_renderer, NATIVE_LOGICAL_WIDTH, NATIVE_LOGICAL_HEIGHT) != 0) {
            printf("Warning: Could not set logical size: %s\n", SDL_GetError());
        } else {
            printf("Set logical size to %dx%d (Native HD) in %dx%d window\n", 
                   NATIVE_LOGICAL_WIDTH, NATIVE_LOGICAL_HEIGHT, window_width, window_height);
        }
        
        // Disable integer scaling for smooth scaling
        SDL_RenderSetIntegerScale(g_renderer, SDL_FALSE);
        
        // Set scale quality to linear for smooth scaling
        SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1");
        
        // Force SDL to use letterboxing instead of stretching
        SDL_SetHint(SDL_HINT_RENDER_LOGICAL_SIZE_MODE, "letterbox");
        
        // Verify the logical size was set
        int logical_w, logical_h;
        SDL_RenderGetLogicalSize(g_renderer, &logical_w, &logical_h);
        printf("Confirmed logical size: %dx%d\n", logical_w, logical_h);
    }
    
    // Set initial render state
    SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
    SDL_RenderClear(g_renderer);
    SDL_RenderPresent(g_renderer);

    // Change working directory to the script's directory so relative asset paths work.
    std::string path_str(lua_file);
    std::string script_name_str = lua_file;
    const char* script_name = lua_file;
    size_t last_slash = path_str.find_last_of("/\\");
    if (last_slash != std::string::npos) {
        std::string dir = path_str.substr(0, last_slash);
        if (chdir(dir.c_str()) != 0) {
            perror("Could not change to script directory");
        } else {
            printf("Changed working directory to: %s\n", dir.c_str());
        }
        script_name_str = path_str.substr(last_slash + 1);
        script_name = script_name_str.c_str();
    }

    printf("Attempting to load and run %s...\n", script_name);
    fflush(stdout);

    // Load and run the main Lua script (after SDL is initialized)
    if (luaL_dofile(L, script_name)) {
        printf("Error running lua script: %s\n", lua_tostring(L, -1));
        fflush(stdout);
        lua_close(L);
        return 1; // Exit if script fails
    } else {
        printf("Successfully loaded and ran %s.\n", lua_file);
        fflush(stdout);
    }

    // Check if the script has a callback function
    lua_getglobal(L, "_LPP_MAIN_LOOP");
    bool has_callback = lua_isfunction(L, -1);
    lua_pop(L, 1); // remove function or nil from stack
    
    // If no callback function, the script has finished its own loop - exit
    if (!has_callback) {
        printf("Script completed - no callback function found, exiting.\n");
        fflush(stdout);
        // Cleanup and exit
        SDL_DestroyRenderer(g_renderer);
        SDL_DestroyWindow(g_window);
        IMG_Quit();
        if (g_defaultFont) TTF_CloseFont(g_defaultFont);
        TTF_Quit();
        SDL_Quit();
        if (L) lua_close(L);
        return 0;
    }

    bool quit = false;
    SDL_Event e;

    // Main loop - for scripts that don't exit immediately
    while (!quit && !should_exit) {
        // Handle events on queue
        while (SDL_PollEvent(&e) != 0) {
            // User requests quit
            if (e.type == SDL_QUIT) {
                quit = true;
            }
            // Handle keyboard events for controls
            if (e.type == SDL_KEYDOWN) {
                sdl_key_down(e.key.keysym.scancode);
                // ESC key to quit
                if (e.key.keysym.sym == SDLK_ESCAPE) {
                    quit = true;
                }
            }
            if (e.type == SDL_KEYUP) {
                sdl_key_up(e.key.keysym.scancode);
            }
            // Handle window resize events to maintain proper scaling
            if (e.type == SDL_WINDOWEVENT && (e.window.event == SDL_WINDOWEVENT_RESIZED || e.window.event == SDL_WINDOWEVENT_SIZE_CHANGED)) {
                // Reapply logical size only in Vita compatibility mode
                if (g_renderer && vita_compat_mode) {
                    // Ensure logical size is maintained and letterboxing is correct
                    SDL_RenderSetLogicalSize(g_renderer, SCREEN_WIDTH, SCREEN_HEIGHT);
                    SDL_RenderSetIntegerScale(g_renderer, SDL_FALSE);
                    
                    // Clear any potential artifacts
                    SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
                    SDL_RenderClear(g_renderer);
                }
            }
        }

        // Update controls state for Lua to read
        update_sdl_controls();

        // Check if there's a main loop function to call (for callback-based scripts)
        lua_getglobal(L, "_LPP_MAIN_LOOP");
        if (lua_isfunction(L, -1)) {
            if (lua_pcall(L, 0, 0, 0) != 0) {
                printf("Error running _LPP_MAIN_LOOP: %s\n", lua_tostring(L, -1));
                quit = true; // Exit on error
            }
        } else {
            lua_pop(L, 1); // remove non-function
            // If no callback function exists, script has its own loop
            // SDL events are handled in Screen.flip(), so just wait
        }
        
        // Small delay to prevent 100% CPU usage
        SDL_Delay(100); // Slower for non-callback scripts
    }

    // Destroy renderer and window
    SDL_DestroyRenderer(g_renderer);
    SDL_DestroyWindow(g_window);

    // Quit SDL subsystems
    IMG_Quit();
    if (g_defaultFont) TTF_CloseFont(g_defaultFont);
    TTF_Quit();
    SDL_Quit();

    // Close LuaJIT state
    if (L) {
        lua_close(L);
    }

    return 0;
}
