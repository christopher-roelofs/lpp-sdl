#include <SDL.h>
#include "src/include/luaSystem.h"
#include "src/include/luaTimer.h"
#include <SDL_ttf.h>
#include <string>
#include <unistd.h>
#include <vector>
#include <algorithm>
#include <dirent.h>
#include <sys/stat.h>

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

// Forward declaration for file browser
const char* launch_file_browser(lua_State* L);

struct FileEntry {
    std::string name;
    std::string full_path;
    bool is_directory;
    size_t size;
};

static std::string current_path = ".";
static std::vector<FileEntry> file_list;
static int selected_index = 0;
static int scroll_offset = 0;
static const int MAX_VISIBLE_ITEMS = 15;
static char* selected_file_result = nullptr;

bool is_lua_file(const std::string& filename) {
    size_t dot_pos = filename.find_last_of('.');
    if (dot_pos != std::string::npos) {
        std::string ext = filename.substr(dot_pos);
        std::transform(ext.begin(), ext.end(), ext.begin(), ::tolower);
        return ext == ".lua";
    }
    return false;
}

void scan_directory(const std::string& path) {
    file_list.clear();
    
    DIR* dir = opendir(path.c_str());
    if (!dir) return;
    
    // Add parent directory entry if not at root
    if (path != "." && path != "/") {
        FileEntry parent;
        parent.name = "..";
        parent.full_path = path + "/..";
        parent.is_directory = true;
        parent.size = 0;
        file_list.push_back(parent);
    }
    
    struct dirent* entry;
    while ((entry = readdir(dir)) != nullptr) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }
        
        std::string full_path = path + "/" + entry->d_name;
        struct stat st;
        if (stat(full_path.c_str(), &st) == 0) {
            FileEntry file_entry;
            file_entry.name = entry->d_name;
            file_entry.full_path = full_path;
            file_entry.is_directory = S_ISDIR(st.st_mode);
            file_entry.size = st.st_size;
            
            // Only add directories or .lua files
            if (file_entry.is_directory || is_lua_file(file_entry.name)) {
                file_list.push_back(file_entry);
            }
        }
    }
    closedir(dir);
    
    // Sort: directories first, then files, both alphabetically
    std::sort(file_list.begin(), file_list.end(), [](const FileEntry& a, const FileEntry& b) {
        if (a.name == "..") return true;
        if (b.name == "..") return false;
        if (a.is_directory != b.is_directory) {
            return a.is_directory;
        }
        return a.name < b.name;
    });
    
    selected_index = 0;
    scroll_offset = 0;
}

void draw_text(const char* text, int x, int y, Uint8 r, Uint8 g, Uint8 b) {
    if (!g_defaultFont) return;
    
    SDL_Color color = {r, g, b, 255};
    SDL_Surface* text_surface = TTF_RenderText_Blended(g_defaultFont, text, color);
    if (!text_surface) return;
    
    SDL_Texture* text_texture = SDL_CreateTextureFromSurface(g_renderer, text_surface);
    SDL_FreeSurface(text_surface);
    
    if (!text_texture) return;
    
    int text_w, text_h;
    SDL_QueryTexture(text_texture, NULL, NULL, &text_w, &text_h);
    
    SDL_Rect dest_rect = {x, y, text_w, text_h};
    SDL_RenderCopy(g_renderer, text_texture, NULL, &dest_rect);
    
    SDL_DestroyTexture(text_texture);
}

void render_file_browser() {
    // Clear screen
    SDL_SetRenderDrawColor(g_renderer, 20, 20, 30, 255);
    SDL_RenderClear(g_renderer);
    
    // Draw title
    draw_text("Lua File Browser", 20, 20, 255, 255, 255);
    
    // Draw current path
    std::string path_display = "Path: " + current_path;
    draw_text(path_display.c_str(), 20, 50, 200, 200, 200);
    
    // Draw instructions
    draw_text("Arrow Keys: Navigate | Enter: Select | Escape: Exit", 20, 80, 150, 150, 150);
    
    // Draw file list
    int y_start = 120;
    int line_height = 25;
    
    for (int i = 0; i < MAX_VISIBLE_ITEMS && (scroll_offset + i) < static_cast<int>(file_list.size()); i++) {
        int file_index = scroll_offset + i;
        const FileEntry& entry = file_list[file_index];
        
        int y = y_start + i * line_height;
        
        // Highlight selected item
        if (file_index == selected_index) {
            SDL_SetRenderDrawColor(g_renderer, 60, 60, 100, 255);
            SDL_Rect highlight_rect = {15, y - 2, 800, line_height};
            SDL_RenderFillRect(g_renderer, &highlight_rect);
        }
        
        // Draw file/folder icon and name
        std::string display_name;
        Uint8 r, g, b;
        
        if (entry.is_directory) {
            display_name = "[DIR] " + entry.name;
            r = 100; g = 200; b = 255; // Blue for directories
        } else {
            display_name = entry.name;
            r = 255; g = 255; b = 100; // Yellow for Lua files
        }
        
        // Highlight selected item text
        if (file_index == selected_index) {
            r = 255; g = 255; b = 255; // White for selected
        }
        
        draw_text(display_name.c_str(), 20, y, r, g, b);
    }
    
    // Draw scrollbar if needed
    if (static_cast<int>(file_list.size()) > MAX_VISIBLE_ITEMS) {
        int scrollbar_x = 820;
        int scrollbar_y = y_start;
        int scrollbar_height = MAX_VISIBLE_ITEMS * line_height;
        
        // Scrollbar background
        SDL_SetRenderDrawColor(g_renderer, 50, 50, 50, 255);
        SDL_Rect scrollbar_bg = {scrollbar_x, scrollbar_y, 10, scrollbar_height};
        SDL_RenderFillRect(g_renderer, &scrollbar_bg);
        
        // Scrollbar thumb
        float thumb_ratio = (float)MAX_VISIBLE_ITEMS / static_cast<float>(file_list.size());
        int thumb_height = (int)(scrollbar_height * thumb_ratio);
        float scroll_ratio = (float)scroll_offset / (static_cast<float>(file_list.size()) - MAX_VISIBLE_ITEMS);
        int thumb_y = scrollbar_y + (int)((scrollbar_height - thumb_height) * scroll_ratio);
        
        SDL_SetRenderDrawColor(g_renderer, 150, 150, 150, 255);
        SDL_Rect thumb_rect = {scrollbar_x, thumb_y, 10, thumb_height};
        SDL_RenderFillRect(g_renderer, &thumb_rect);
    }
    
    SDL_RenderPresent(g_renderer);
}

const char* launch_file_browser(lua_State* L) {
    scan_directory(current_path);
    
    bool quit = false;
    SDL_Event e;
    
    while (!quit && !should_exit) {
        while (SDL_PollEvent(&e) != 0) {
            if (e.type == SDL_QUIT) {
                quit = true;
            }
            
            if (e.type == SDL_KEYDOWN) {
                switch (e.key.keysym.sym) {
                    case SDLK_ESCAPE:
                        quit = true;
                        break;
                        
                    case SDLK_UP:
                        if (selected_index > 0) {
                            selected_index--;
                            if (selected_index < scroll_offset) {
                                scroll_offset = selected_index;
                            }
                        }
                        break;
                        
                    case SDLK_DOWN:
                        if (selected_index < static_cast<int>(file_list.size()) - 1) {
                            selected_index++;
                            if (selected_index >= scroll_offset + MAX_VISIBLE_ITEMS) {
                                scroll_offset = selected_index - MAX_VISIBLE_ITEMS + 1;
                            }
                        }
                        break;
                        
                    case SDLK_RETURN:
                    case SDLK_KP_ENTER:
                        if (selected_index < static_cast<int>(file_list.size())) {
                            const FileEntry& selected = file_list[selected_index];
                            
                            if (selected.is_directory) {
                                // Enter directory
                                if (selected.name == "..") {
                                    // Go to parent directory
                                    size_t last_slash = current_path.find_last_of('/');
                                    if (last_slash != std::string::npos && last_slash > 0) {
                                        current_path = current_path.substr(0, last_slash);
                                    } else if (current_path != ".") {
                                        current_path = ".";
                                    }
                                } else {
                                    // Enter subdirectory
                                    if (current_path == ".") {
                                        current_path = selected.name;
                                    } else {
                                        current_path += "/" + selected.name;
                                    }
                                }
                                scan_directory(current_path);
                            } else {
                                // Select Lua file
                                selected_file_result = new char[selected.full_path.length() + 1];
                                strcpy(selected_file_result, selected.full_path.c_str());
                                return selected_file_result;
                            }
                        }
                        break;
                }
            }
        }
        
        render_file_browser();
        SDL_Delay(16); // ~60 FPS
    }
    
    return nullptr;
}

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
        // Check for index.lua in current directory
        if (access("index.lua", F_OK) == 0) {
            lua_file = "index.lua";
            printf("Found index.lua in current directory, loading it...\n");
        } else {
            // No file specified and no index.lua found - launch file browser
            printf("No Lua file specified and no index.lua found. Launching file browser...\n");
            lua_file = "__file_browser__";
        }
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

    // Handle file browser mode
    if (strcmp(lua_file, "__file_browser__") == 0) {
        // Launch file browser
        const char* selected_file = launch_file_browser(L);
        if (selected_file == NULL) {
            printf("File browser exited without selection.\n");
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
        lua_file = selected_file;
    }

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

    // Clean up allocated memory
    if (selected_file_result) {
        delete[] selected_file_result;
        selected_file_result = nullptr;
    }

    return 0;
}
