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
#include <cmath>
#include <cctype>
#include <cstdlib>

// ImGui includes (conditional)
#ifdef USE_IMGUI
#include <GL/gl.h>
#include "imgui.h"
#include "imgui_impl_sdl2.h"
#include "imgui_impl_opengl3.h"
#endif

#ifdef USE_READLINE
#include <readline/readline.h>
#include <readline/history.h>
#endif

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

// ImGui globals
#ifdef USE_IMGUI
SDL_GLContext g_gl_context = NULL;
bool g_imgui_initialized = false;
#endif

int g_3ds_update_frames = 0; // Frame counter to allow inactive screen updates
lpp_compat_mode_t g_compat_mode = LPP_COMPAT_NATIVE; // Global compatibility mode
lpp_3ds_orientation_t g_3ds_orientation = LPP_3DS_HORIZONTAL; // 3DS screen orientation (default: horizontal)
bool g_vita_compat_mode = false; // Global flag for Vita compatibility mode (deprecated, use g_compat_mode)
bool g_dual_screen_mode = false; // Global flag for 3DS dual screen mode (deprecated, use g_compat_mode)
bool g_3ds_single_screen_mode = false; // Global flag for 3DS single-screen mode on small displays
int g_3ds_active_screen = 0; // Currently active screen in single-screen mode (0=top, 1=bottom)
bool g_debug_mode = false; // Global flag for debug output
bool g_headless_mode = false; // Global flag for headless mode (no GUI)
int g_gamepad_layout = 0; // Global gamepad layout (0=Nintendo, 1=Xbox)
float g_scale_x = 1.0f; // Manual scaling factor for dual screen X
float g_scale_y = 1.0f; // Manual scaling factor for dual screen Y
float g_top_screen_scale_x = 1.0f; // Top screen X scaling factor
float g_top_screen_scale_y = 1.0f; // Top screen Y scaling factor  
float g_bottom_screen_scale_x = 1.0f; // Bottom screen X scaling factor
float g_bottom_screen_scale_y = 1.0f; // Bottom screen Y scaling factor

// Global variables required by LPP modules
int clr_color = 0;

// Dynamic native resolution variables (set based on display resolution)
int NATIVE_LOGICAL_WIDTH = 1280;   // Default fallback values
int NATIVE_LOGICAL_HEIGHT = 720;
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
extern "C" void sdl_mouse_button_down();
extern "C" void sdl_mouse_button_up();
extern "C" void init_controllers();
extern "C" void cleanup_controllers();
extern "C" void handle_controller_event(SDL_Event* event);
// Remove external current_keys reference - use Controls API instead

// Forward declaration for file browser
const char* launch_file_browser(lua_State* L);

// Forward declaration for console REPL
const char* launch_console_repl(lua_State* L);

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

// Compatibility mode selector for file browser
static int browser_compat_mode_index = 0;
static const char* browser_compat_modes[] = {
    "native",
    "3dscompat-vertical", 
    "3dscompat-horizontal",
    "3dscompat-1screen",
    "vitacompat"
};
static const int browser_compat_modes_count = sizeof(browser_compat_modes) / sizeof(browser_compat_modes[0]);

// Gamepad layout selector for file browser
static int browser_gamepad_layout_index = 0; // 0 = Nintendo (default), 1 = Xbox
static const char* browser_gamepad_layouts[] = {
    "Nintendo",
    "Xbox"
};
static const int browser_gamepad_layouts_count = sizeof(browser_gamepad_layouts) / sizeof(browser_gamepad_layouts[0]);

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
        
        FileEntry file_entry;
        file_entry.name = entry->d_name;
        file_entry.full_path = path + "/" + entry->d_name;
        
        struct stat file_stat;
        if (stat(file_entry.full_path.c_str(), &file_stat) == 0) {
            file_entry.is_directory = S_ISDIR(file_stat.st_mode);
            file_entry.size = file_stat.st_size;
        } else {
            file_entry.is_directory = false;
            file_entry.size = 0;
        }
        
        file_list.push_back(file_entry);
    }
    
    closedir(dir);
    
    // Sort: directories first, then files (case insensitive)
    std::sort(file_list.begin(), file_list.end(), [](const FileEntry& a, const FileEntry& b) {
        if (a.name == "..") return true;
        if (b.name == "..") return false;
        if (a.is_directory != b.is_directory) {
            return a.is_directory;
        }
        
        std::string lower_a = a.name;
        std::string lower_b = b.name;
        std::transform(lower_a.begin(), lower_a.end(), lower_a.begin(), ::tolower);
        std::transform(lower_b.begin(), lower_b.end(), lower_b.begin(), ::tolower);
        
        return lower_a < lower_b;
    });
    
    selected_index = 0;
    scroll_offset = 0;
}

void render_file_browser(SDL_Renderer* renderer, TTF_Font* font, int window_width, int window_height) {
    // Clear screen with dark background
    SDL_SetRenderDrawColor(renderer, 20, 20, 25, 255);
    SDL_RenderClear(renderer);
    
    // Get dimensions for centering
    int content_width = window_width - 40;
    int content_height = window_height - 120;
    int start_x = 20;
    int start_y = 60;
    
    // Draw title
    SDL_Color white = {255, 255, 255, 255};
    SDL_Color yellow = {255, 255, 0, 255};
    SDL_Color green = {0, 255, 0, 255};
    SDL_Color blue = {100, 150, 255, 255};
    SDL_Color gray = {128, 128, 128, 255};
    
    // Title
    std::string title = "LPP-SDL File Browser - " + current_path;
    SDL_Surface* title_surface = TTF_RenderText_Solid(font, title.c_str(), white);
    if (title_surface) {
        SDL_Texture* title_texture = SDL_CreateTextureFromSurface(renderer, title_surface);
        SDL_Rect title_rect = {start_x, 10, title_surface->w, title_surface->h};
        SDL_RenderCopy(renderer, title_texture, NULL, &title_rect);
        SDL_DestroyTexture(title_texture);
        SDL_FreeSurface(title_surface);
    }
    
    // Compatibility mode display
    std::string compat_mode_text = "Mode: " + std::string(browser_compat_modes[browser_compat_mode_index]);
    SDL_Surface* compat_surface = TTF_RenderText_Solid(font, compat_mode_text.c_str(), blue);
    if (compat_surface) {
        SDL_Texture* compat_texture = SDL_CreateTextureFromSurface(renderer, compat_surface);
        SDL_Rect compat_rect = {start_x, 30, compat_surface->w, compat_surface->h};
        SDL_RenderCopy(renderer, compat_texture, NULL, &compat_rect);
        SDL_DestroyTexture(compat_texture);
        SDL_FreeSurface(compat_surface);
    }
    
    // Gamepad layout display
    std::string gamepad_text = "Gamepad: " + std::string(browser_gamepad_layouts[browser_gamepad_layout_index]);
    SDL_Surface* gamepad_surface = TTF_RenderText_Solid(font, gamepad_text.c_str(), blue);
    if (gamepad_surface) {
        SDL_Texture* gamepad_texture = SDL_CreateTextureFromSurface(renderer, gamepad_surface);
        SDL_Rect gamepad_rect = {start_x + 250, 30, gamepad_surface->w, gamepad_surface->h};
        SDL_RenderCopy(renderer, gamepad_texture, NULL, &gamepad_rect);
        SDL_DestroyTexture(gamepad_texture);
        SDL_FreeSurface(gamepad_surface);
    }
    
    // Calculate line height and visible items
    int line_height = 25;
    int visible_items = (content_height - 40) / line_height;
    if (visible_items > MAX_VISIBLE_ITEMS) {
        visible_items = MAX_VISIBLE_ITEMS;
    }
    
    // Ensure selected item is visible
    if (selected_index < scroll_offset) {
        scroll_offset = selected_index;
    } else if (selected_index >= scroll_offset + visible_items) {
        scroll_offset = selected_index - visible_items + 1;
    }
    
    // Render file list
    for (int i = 0; i < visible_items && i + scroll_offset < (int)file_list.size(); i++) {
        int file_index = i + scroll_offset;
        const FileEntry& entry = file_list[file_index];
        
        int y = start_y + i * line_height;
        
        // Highlight selected item
        if (file_index == selected_index) {
            SDL_SetRenderDrawColor(renderer, 50, 50, 70, 255);
            SDL_Rect highlight_rect = {start_x - 5, y - 2, content_width + 10, line_height};
            SDL_RenderFillRect(renderer, &highlight_rect);
        }
        
        // Choose color based on file type
        SDL_Color color = white;
        std::string prefix = "";
        if (entry.name == "..") {
            color = yellow;
            prefix = "[UP] ";
        } else if (entry.is_directory) {
            color = yellow;
            prefix = "[DIR] ";
        } else if (is_lua_file(entry.name)) {
            color = green;
            prefix = "[LUA] ";
        } else {
            color = gray;
            prefix = "[FILE] ";
        }
        
        // Render file name
        std::string display_name = prefix + entry.name;
        if (display_name.length() > 80) {
            display_name = display_name.substr(0, 77) + "...";
        }
        
        SDL_Surface* text_surface = TTF_RenderText_Solid(font, display_name.c_str(), color);
        if (text_surface) {
            SDL_Texture* text_texture = SDL_CreateTextureFromSurface(renderer, text_surface);
            SDL_Rect text_rect = {start_x, y, text_surface->w, text_surface->h};
            SDL_RenderCopy(renderer, text_texture, NULL, &text_rect);
            SDL_DestroyTexture(text_texture);
            SDL_FreeSurface(text_surface);
        }
        
        // Show file size for regular files
        if (!entry.is_directory && entry.name != "..") {
            std::string size_str;
            if (entry.size < 1024) {
                size_str = std::to_string(entry.size) + " B";
            } else if (entry.size < 1024 * 1024) {
                size_str = std::to_string(entry.size / 1024) + " KB";
            } else {
                size_str = std::to_string(entry.size / (1024 * 1024)) + " MB";
            }
            
            SDL_Surface* size_surface = TTF_RenderText_Solid(font, size_str.c_str(), gray);
            if (size_surface) {
                SDL_Texture* size_texture = SDL_CreateTextureFromSurface(renderer, size_surface);
                SDL_Rect size_rect = {start_x + content_width - size_surface->w, y, size_surface->w, size_surface->h};
                SDL_RenderCopy(renderer, size_texture, NULL, &size_rect);
                SDL_DestroyTexture(size_texture);
                SDL_FreeSurface(size_surface);
            }
        }
    }
    
    // Instructions
    std::vector<std::string> instructions = {
        "Arrow Keys/WASD: Navigate   Enter/Space: Select   Backspace/Esc: Exit",
        "M: Change compatibility mode   G: Change gamepad layout",
        "Current directory: " + current_path
    };
    
    int instr_y = window_height - 80;
    for (const std::string& instr : instructions) {
        SDL_Surface* instr_surface = TTF_RenderText_Solid(font, instr.c_str(), gray);
        if (instr_surface) {
            SDL_Texture* instr_texture = SDL_CreateTextureFromSurface(renderer, instr_surface);
            SDL_Rect instr_rect = {start_x, instr_y, instr_surface->w, instr_surface->h};
            SDL_RenderCopy(renderer, instr_texture, NULL, &instr_rect);
            SDL_DestroyTexture(instr_texture);
            SDL_FreeSurface(instr_surface);
            instr_y += 20;
        }
    }
    
    SDL_RenderPresent(renderer);
}

// SDL event handlers for ImGui
#ifdef USE_IMGUI
bool handle_imgui_event(SDL_Event* event) {
    if (!g_imgui_initialized) return false;
    return ImGui_ImplSDL2_ProcessEvent(event);
}
#endif

// Rest of the file would continue with the existing functions...
// [Note: This is a template showing the key changes needed]

// The main function would need these key additions after SDL initialization:

/*
int main(int argc, char* args[]) {
    // ... existing argument parsing ...
    
    // ... existing SDL initialization until after g_renderer creation ...
    
#ifdef USE_IMGUI
    // Create OpenGL context for ImGui
    if (!headless_mode) {
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, 0);
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 0);
        
        // Create OpenGL context
        g_gl_context = SDL_GL_CreateContext(g_window);
        if (g_gl_context == NULL) {
            printf("OpenGL context could not be created! SDL Error: %s\n", SDL_GetError());
            // Continue without ImGui support
        } else {
            SDL_GL_MakeCurrent(g_window, g_gl_context);
            SDL_GL_SetSwapInterval(1); // Enable vsync
            printf("ImGui support enabled with OpenGL context\n");
        }
    }
#endif
    
    // ... rest of initialization ...
    
    // Main event loop would need:
    while (!should_exit) {
        SDL_Event event;
        while (SDL_PollEvent(&event)) {
#ifdef USE_IMGUI
            if (handle_imgui_event(&event)) {
                continue; // ImGui consumed the event
            }
#endif
            // ... existing event handling ...
        }
        
        // ... game loop ...
    }
    
    // Cleanup
#ifdef USE_IMGUI
    if (g_gl_context) {
        if (g_imgui_initialized) {
            ImGui_ImplOpenGL3_Shutdown();
            ImGui_ImplSDL2_Shutdown();
            ImGui::DestroyContext();
        }
        SDL_GL_DeleteContext(g_gl_context);
    }
#endif
    
    // ... existing cleanup ...
}
*/