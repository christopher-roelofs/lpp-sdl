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
    
    // Draw compatibility mode selector
    std::string mode_display = "Mode: < " + std::string(browser_compat_modes[browser_compat_mode_index]) + " >";
    draw_text(mode_display.c_str(), 450, 20, 255, 200, 100);
    
    // Draw gamepad layout selector with dynamic color based on controller status
    std::string layout_display = "Gamepad: < " + std::string(browser_gamepad_layouts[browser_gamepad_layout_index]) + " >";
    
    // Check if any controller is connected
    bool controller_connected = false;
    for (int i = 0; i < SDL_NumJoysticks(); i++) {
        if (SDL_IsGameController(i)) {
            SDL_GameController* controller = SDL_GameControllerOpen(i);
            if (controller) {
                controller_connected = true;
                SDL_GameControllerClose(controller);
                break;
            }
        }
    }
    
    // Red if no controller, green if connected
    Uint8 r = controller_connected ? 100 : 255;
    Uint8 g = controller_connected ? 255 : 100;
    Uint8 b = controller_connected ? 200 : 100;
    
    draw_text(layout_display.c_str(), 450, 50, r, g, b);
    
    // Draw current path
    std::string path_display = "Path: " + current_path;
    draw_text(path_display.c_str(), 20, 50, 200, 200, 200);
    
    // Draw instructions
    draw_text("Arrow Keys/D-Pad/Left Analog: Navigate | A: Select | B: Back | Start: Exit | L/R: Change Mode | Select: Layout", 20, 80, 150, 150, 150);
    
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
    
    // Ensure the global compatibility mode is set for proper gamepad mapping
    // Default to native mode for file browser
    extern lpp_compat_mode_t g_compat_mode;
    extern int g_gamepad_layout;
    g_compat_mode = LPP_COMPAT_NATIVE;
    
    // Initialize browser gamepad layout from global setting
    browser_gamepad_layout_index = g_gamepad_layout;
    
    bool quit = false;
    SDL_Event e;
    static Uint32 last_analog_time = 0;
    static const Uint32 analog_delay = 150; // milliseconds between analog inputs
    
    while (!quit && !should_exit) {
        while (SDL_PollEvent(&e) != 0) {
            if (e.type == SDL_QUIT) {
                quit = true;
            }
            
            // Handle controller hotplug events
            handle_controller_event(&e);
            
            // No need for raw gamepad events - we'll use the Controls API instead
            
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
                        
                    case SDLK_LEFT:
                        // Cycle compatibility mode backward
                        browser_compat_mode_index--;
                        if (browser_compat_mode_index < 0) {
                            browser_compat_mode_index = browser_compat_modes_count - 1;
                        }
                        break;
                        
                    case SDLK_RIGHT:
                        // Cycle compatibility mode forward
                        browser_compat_mode_index++;
                        if (browser_compat_mode_index >= browser_compat_modes_count) {
                            browser_compat_mode_index = 0;
                        }
                        break;
                }
            }
        }
        
        // Handle gamepad input directly (since Controls API needs Lua context)
        // Get current time for button timing
        Uint32 current_time = SDL_GetTicks();
        
        // Use simple state tracking to prevent repeated actions
        static bool prev_up = false, prev_down = false, prev_action = false, prev_back = false;
        static bool prev_exit = false, prev_select = false, prev_l = false, prev_r = false;
        
        // Get keyboard state for regular keyboard input
        const Uint8* keyboard_state = SDL_GetKeyboardState(NULL);
        
        // Read gamepad input with layout-aware mapping
        bool gamepad_up = false, gamepad_down = false, gamepad_action = false;
        bool gamepad_back = false, gamepad_start = false, gamepad_select = false, gamepad_l = false, gamepad_r = false;
        
        // Check for connected controllers
        for (int i = 0; i < SDL_NumJoysticks(); i++) {
            if (SDL_IsGameController(i)) {
                SDL_GameController* controller = SDL_GameControllerOpen(i);
                if (controller) {
                    // D-pad navigation
                    gamepad_up = SDL_GameControllerGetButton(controller, SDL_CONTROLLER_BUTTON_DPAD_UP);
                    gamepad_down = SDL_GameControllerGetButton(controller, SDL_CONTROLLER_BUTTON_DPAD_DOWN);
                    
                    // Map buttons based on selected layout
                    if (browser_gamepad_layout_index == 0) {
                        // Nintendo layout: Physical A (right) = action, Physical B (bottom) = back
                        // gamecontrollerdb.txt maps: Physical A → SDL_B, Physical B → SDL_A
                        gamepad_action = SDL_GameControllerGetButton(controller, SDL_CONTROLLER_BUTTON_B); // Physical A
                        gamepad_back = SDL_GameControllerGetButton(controller, SDL_CONTROLLER_BUTTON_A);   // Physical B
                    } else {
                        // Xbox layout: Physical A (bottom) = action, Physical B (right) = back  
                        // gamecontrollerdb.txt maps: Physical A → SDL_A, Physical B → SDL_B
                        gamepad_action = SDL_GameControllerGetButton(controller, SDL_CONTROLLER_BUTTON_A); // Physical A
                        gamepad_back = SDL_GameControllerGetButton(controller, SDL_CONTROLLER_BUTTON_B);   // Physical B
                    }
                    
                    // Start/Select buttons
                    gamepad_start = SDL_GameControllerGetButton(controller, SDL_CONTROLLER_BUTTON_START);  // Start = exit browser
                    gamepad_select = SDL_GameControllerGetButton(controller, SDL_CONTROLLER_BUTTON_BACK); // Select = change layout
                    
                    // Shoulder buttons for mode switching
                    gamepad_l = SDL_GameControllerGetButton(controller, SDL_CONTROLLER_BUTTON_LEFTSHOULDER);
                    gamepad_r = SDL_GameControllerGetButton(controller, SDL_CONTROLLER_BUTTON_RIGHTSHOULDER);
                    
                    SDL_GameControllerClose(controller);
                    break; // Only use first controller
                }
            }
        }
        
        // Combine keyboard and gamepad input
        bool up_pressed = keyboard_state[SDL_SCANCODE_UP] || gamepad_up;
        bool down_pressed = keyboard_state[SDL_SCANCODE_DOWN] || gamepad_down;
        bool action_pressed = keyboard_state[SDL_SCANCODE_SPACE] || keyboard_state[SDL_SCANCODE_RETURN] || gamepad_action;
        bool back_pressed = keyboard_state[SDL_SCANCODE_BACKSPACE] || gamepad_back; // B button = go up directory
        bool exit_pressed = keyboard_state[SDL_SCANCODE_ESCAPE] || gamepad_start; // Start button = exit browser
        bool select_pressed = keyboard_state[SDL_SCANCODE_TAB] || gamepad_select; // Select button = change layout
        bool l_pressed = keyboard_state[SDL_SCANCODE_Q] || keyboard_state[SDL_SCANCODE_LEFT] || gamepad_l;
        bool r_pressed = keyboard_state[SDL_SCANCODE_E] || keyboard_state[SDL_SCANCODE_RIGHT] || gamepad_r;
        
        // Navigation up
        if (up_pressed && !prev_up) {
            if (selected_index > 0) {
                selected_index--;
                if (selected_index < scroll_offset) {
                    scroll_offset = selected_index;
                }
            }
        }
        prev_up = up_pressed;
        
        // Navigation down
        if (down_pressed && !prev_down) {
            if (selected_index < static_cast<int>(file_list.size()) - 1) {
                selected_index++;
                if (selected_index >= scroll_offset + MAX_VISIBLE_ITEMS) {
                    scroll_offset = selected_index - MAX_VISIBLE_ITEMS + 1;
                }
            }
        }
        prev_down = down_pressed;
        
        // Action button (enter/select)
        if (action_pressed && !prev_action) {
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
        }
        prev_action = action_pressed;
        
        // Back button (B) - go up one directory
        if (back_pressed && !prev_back) {
            // Go to parent directory
            size_t last_slash = current_path.find_last_of('/');
            if (last_slash != std::string::npos && last_slash > 0) {
                current_path = current_path.substr(0, last_slash);
            } else if (current_path != ".") {
                current_path = ".";
            }
            scan_directory(current_path);
        }
        prev_back = back_pressed;
        
        // Exit button (Start) - quit browser
        if (exit_pressed && !prev_exit) {
            quit = true;
        }
        prev_exit = exit_pressed;
        
        // Select button - change gamepad layout
        if (select_pressed && !prev_select) {
            browser_gamepad_layout_index++;
            if (browser_gamepad_layout_index >= browser_gamepad_layouts_count) {
                browser_gamepad_layout_index = 0;
            }
            // Save to global setting
            g_gamepad_layout = browser_gamepad_layout_index;
        }
        prev_select = select_pressed;
        
        // L shoulder button for mode switching
        if (l_pressed && !prev_l) {
            browser_compat_mode_index--;
            if (browser_compat_mode_index < 0) {
                browser_compat_mode_index = browser_compat_modes_count - 1;
            }
        }
        prev_l = l_pressed;
        
        // R shoulder button for mode switching
        if (r_pressed && !prev_r) {
            browser_compat_mode_index++;
            if (browser_compat_mode_index >= browser_compat_modes_count) {
                browser_compat_mode_index = 0;
            }
        }
        prev_r = r_pressed;
        
        // Handle analog stick input (outside event loop for continuous polling)
        if (current_time - last_analog_time > analog_delay) {
            // Check for connected controllers
            for (int i = 0; i < SDL_NumJoysticks(); i++) {
                if (SDL_IsGameController(i)) {
                    SDL_GameController* controller = SDL_GameControllerOpen(i);
                    if (controller) {
                        // Read left analog stick Y axis
                        Sint16 left_y = SDL_GameControllerGetAxis(controller, SDL_CONTROLLER_AXIS_LEFTY);
                        
                        // Convert to -1.0 to 1.0 range and apply deadzone
                        float analog_y = left_y / 32768.0f;
                        const float deadzone = 0.3f;
                        
                        if (analog_y < -deadzone) {
                            // Analog stick pushed up
                            if (selected_index > 0) {
                                selected_index--;
                                if (selected_index < scroll_offset) {
                                    scroll_offset = selected_index;
                                }
                                last_analog_time = current_time;
                            }
                        } else if (analog_y > deadzone) {
                            // Analog stick pushed down
                            if (selected_index < static_cast<int>(file_list.size()) - 1) {
                                selected_index++;
                                if (selected_index >= scroll_offset + MAX_VISIBLE_ITEMS) {
                                    scroll_offset = selected_index - MAX_VISIBLE_ITEMS + 1;
                                }
                                last_analog_time = current_time;
                            }
                        }
                        
                        // Don't need to keep the controller open for polling
                        SDL_GameControllerClose(controller);
                        break; // Only use first controller found
                    }
                }
            }
        }
        
        render_file_browser();
        SDL_Delay(16); // ~60 FPS
    }
    
    return nullptr;
}

#ifdef USE_READLINE
// Tab completion for REPL commands and file paths
static char* command_completion_generator(const char* text, int state) {
    static const char* commands[] = {
        "help", "list", "ls", "dir", "cd", "pwd", "run", "load", 
        "cat", "clear", "info", "lua", "exit", "quit", nullptr
    };
    
    static int list_index, len;
    const char* name;
    
    if (!state) {
        list_index = 0;
        len = strlen(text);
    }
    
    while ((name = commands[list_index])) {
        list_index++;
        if (strncmp(name, text, len) == 0) {
            return strdup(name);
        }
    }
    
    return nullptr;
}

static char* file_completion_generator(const char* text, int state, const std::string& current_dir) {
    static DIR* dir = nullptr;
    static int len;
    static std::string search_dir;
    static std::string prefix;
    
    if (!state) {
        len = strlen(text);
        
        // Determine directory to search and prefix
        std::string text_str(text);
        size_t slash_pos = text_str.find_last_of('/');
        
        if (slash_pos != std::string::npos) {
            // Text contains path separator
            prefix = text_str.substr(0, slash_pos + 1);
            std::string search_path = prefix;
            
            if (search_path[0] == '/') {
                // Absolute path
                search_dir = search_path;
            } else {
                // Relative path
                search_dir = current_dir + "/" + search_path;
            }
            
            // Remove trailing slash for opendir
            if (search_dir.back() == '/' && search_dir.length() > 1) {
                search_dir.pop_back();
            }
        } else {
            // No path separator, search current directory
            search_dir = current_dir;
            prefix = "";
        }
        
        if (dir) {
            closedir(dir);
        }
        dir = opendir(search_dir.c_str());
    }
    
    if (!dir) {
        return nullptr;
    }
    
    struct dirent* entry;
    while ((entry = readdir(dir)) != nullptr) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }
        
        std::string search_text = text;
        size_t slash_pos = search_text.find_last_of('/');
        std::string filename_part = (slash_pos != std::string::npos) ? 
            search_text.substr(slash_pos + 1) : search_text;
        
        if (strncmp(entry->d_name, filename_part.c_str(), filename_part.length()) == 0) {
            std::string full_path = search_dir + "/" + entry->d_name;
            struct stat st;
            if (stat(full_path.c_str(), &st) == 0) {
                std::string result = prefix + entry->d_name;
                if (S_ISDIR(st.st_mode)) {
                    result += "/";
                }
                return strdup(result.c_str());
            }
        }
    }
    
    closedir(dir);
    dir = nullptr;
    return nullptr;
}

// Global current directory for completion
static std::string g_repl_current_dir = ".";

static char* file_completion_wrapper(const char* text, int state) {
    return file_completion_generator(text, state, g_repl_current_dir);
}

static char** repl_completion(const char* text, int start, int end) {
    rl_attempted_completion_over = 1;
    
    // If we're at the beginning of the line, complete commands
    if (start == 0) {
        return rl_completion_matches(text, command_completion_generator);
    }
    
    // Otherwise, complete file paths
    return rl_completion_matches(text, file_completion_wrapper);
}

static void setup_readline() {
    // Set completion function
    rl_attempted_completion_function = repl_completion;
    
    // Load history if available
    read_history(".lpp_sdl_history");
}

static void cleanup_readline() {
    // Save history
    write_history(".lpp_sdl_history");
    history_truncate_file(".lpp_sdl_history", 100); // Keep last 100 commands
}
#endif

const char* launch_console_repl(lua_State* L) {
    printf("\n=== LPP-SDL Console REPL ===\n");
    printf("Type 'help' for available commands.\n");
#ifdef USE_READLINE
    printf("Features: Tab completion, command history, line editing\n");
#endif
    
    static char* selected_file_result = nullptr;
    std::string current_dir = ".";
    
    // Helper function to list files and directories
    auto list_directory = [&current_dir]() {
        printf("\nCurrent directory: %s\n", current_dir.c_str());
        
        DIR* dir = opendir(current_dir.c_str());
        if (!dir) {
            printf("Error: Cannot access directory '%s'\n", current_dir.c_str());
            return;
        }
        
        std::vector<FileEntry> entries;
        
        // Add parent directory entry if not at root
        if (current_dir != "." && current_dir != "/") {
            FileEntry parent;
            parent.name = "..";
            parent.full_path = current_dir + "/..";
            parent.is_directory = true;
            parent.size = 0;
            entries.push_back(parent);
        }
        
        struct dirent* entry;
        while ((entry = readdir(dir)) != nullptr) {
            if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
                continue;
            }
            
            std::string full_path = current_dir + "/" + entry->d_name;
            struct stat st;
            if (stat(full_path.c_str(), &st) == 0) {
                FileEntry file_entry;
                file_entry.name = entry->d_name;
                file_entry.full_path = full_path;
                file_entry.is_directory = S_ISDIR(st.st_mode);
                file_entry.size = st.st_size;
                entries.push_back(file_entry);
            }
        }
        closedir(dir);
        
        // Sort: directories first, then files
        std::sort(entries.begin(), entries.end(), [](const FileEntry& a, const FileEntry& b) {
            if (a.name == "..") return true;
            if (b.name == "..") return false;
            if (a.is_directory != b.is_directory) {
                return a.is_directory;
            }
            return a.name < b.name;
        });
        
        printf("\nContents:\n");
        for (size_t i = 0; i < entries.size(); i++) {
            const auto& entry = entries[i];
            const char* type = entry.is_directory ? "[DIR]" : "[FILE]";
            if (entry.is_directory) {
                printf("  %2zu. %s %s\n", i + 1, type, entry.name.c_str());
            } else {
                printf("  %2zu. %s %s (%zu bytes)\n", i + 1, type, entry.name.c_str(), entry.size);
            }
        }
    };
    
    // Helper function to show help
    auto show_help = []() {
        printf("\nAvailable commands:\n");
        printf("  help                 - Show this help message\n");
        printf("  list, ls, dir        - List files and directories in current directory\n");
        printf("  cd <directory>       - Change to directory (use .. for parent)\n");
        printf("  run, load <file.lua> - Run a Lua script\n");
        printf("  cat <file>           - Display file contents\n");
        printf("  pwd                  - Show current directory\n");
        printf("  info                 - Show system information\n");
        printf("  clear                - Clear the screen\n");
        printf("  lua <code>           - Execute Lua code directly\n");
        printf("  exit                 - Exit the REPL\n");
        printf("  quit                 - Exit the REPL\n");
#ifdef USE_READLINE
        printf("\nFeatures:\n");
        printf("  Tab completion       - Tab to complete commands and file paths\n");
        printf("  Command history      - Up/Down arrows to navigate command history\n");
        printf("  Line editing         - Left/Right arrows, Home/End, backspace, delete\n");
        printf("  History persistence  - Commands saved to .lpp_sdl_history\n");
#endif
        printf("\nExamples:\n");
        printf("  run samples/sdl/Console/index.lua\n");
        printf("  run samples/sdl/Console/input_demo.lua\n");
        printf("  cat samples/sdl/Console/README.md\n");
        printf("  cd samples/sdl/Console\n");
        printf("  dir\n");
        printf("  info\n");
        printf("  lua print('Hello from Lua!')\n");
        printf("  lua local name = System.input('Name: '); print('Hi ' .. name)\n");
        printf("  lua for i=1,3 do print('Line ' .. i) end\n");
    };
    
#ifdef USE_READLINE
    // Initialize readline
    setup_readline();
    
    char* input;
#else
    char input[512];
#endif
    
    while (true) {
#ifdef USE_READLINE
        input = readline("lpp-sdl> ");
        
        if (!input) {
            printf("\n"); // Print newline on EOF
            break; // EOF or error
        }
        
        // Skip empty input
        if (strlen(input) == 0) {
            free(input);
            continue;
        }
        
        // Add to history if non-empty
        add_history(input);
#else
        printf("\nlpp-sdl> ");
        fflush(stdout);
        
        if (!fgets(input, sizeof(input), stdin)) {
            break; // EOF or error
        }
        
        // Remove newline
        input[strcspn(input, "\n")] = 0;
        
        // Skip empty input
        if (strlen(input) == 0) {
            continue;
        }
#endif
        
        // Parse command
        char* command = strtok(input, " ");
        char* argument = strtok(nullptr, "");
        
        if (strcmp(command, "help") == 0) {
            show_help();
        }
        else if (strcmp(command, "list") == 0 || strcmp(command, "ls") == 0 || strcmp(command, "dir") == 0) {
            list_directory();
        }
        else if (strcmp(command, "pwd") == 0) {
            printf("Current directory: %s\n", current_dir.c_str());
        }
        else if (strcmp(command, "cd") == 0) {
            if (!argument) {
                printf("Error: cd requires a directory argument\n");
                continue;
            }
            
            std::string new_dir;
            if (argument[0] == '/') {
                // Absolute path
                new_dir = argument;
            } else {
                // Relative path
                new_dir = current_dir + "/" + argument;
            }
            
            // Check if directory exists
            struct stat st;
            if (stat(new_dir.c_str(), &st) == 0 && S_ISDIR(st.st_mode)) {
                current_dir = new_dir;
#ifdef USE_READLINE
                g_repl_current_dir = current_dir; // Update global for completion
#endif
                printf("Changed to directory: %s\n", current_dir.c_str());
            } else {
                printf("Error: Directory '%s' does not exist\n", argument);
            }
        }
        else if (strcmp(command, "run") == 0 || strcmp(command, "load") == 0) {
            if (!argument) {
                printf("Error: %s requires a Lua file argument\n", command);
                continue;
            }
            
            std::string file_path;
            if (argument[0] == '/') {
                // Absolute path
                file_path = argument;
            } else {
                // Relative path
                file_path = current_dir + "/" + argument;
            }
            
            // Check if file exists
            if (access(file_path.c_str(), F_OK) == 0) {
                // Check if it's a .lua file
                if (file_path.find(".lua") != std::string::npos) {
                    printf("Running: %s\n", file_path.c_str());
                    
                    // Clean up any previous result
                    if (selected_file_result) {
                        delete[] selected_file_result;
                    }
                    
                    // Allocate and copy the file path
                    selected_file_result = new char[file_path.length() + 1];
                    strcpy(selected_file_result, file_path.c_str());
                    
                    return selected_file_result;
                } else {
                    printf("Error: '%s' is not a Lua file (.lua extension required)\n", argument);
                }
            } else {
                printf("Error: File '%s' does not exist\n", argument);
            }
        }
        else if (strcmp(command, "cat") == 0) {
            if (!argument) {
                printf("Error: cat requires a file argument\n");
                continue;
            }
            
            std::string file_path;
            if (argument[0] == '/') {
                // Absolute path
                file_path = argument;
            } else {
                // Relative path
                file_path = current_dir + "/" + argument;
            }
            
            // Check if file exists and is readable
            if (access(file_path.c_str(), F_OK) == 0) {
                struct stat st;
                if (stat(file_path.c_str(), &st) == 0 && !S_ISDIR(st.st_mode)) {
                    // It's a file, try to read it
                    FILE* file = fopen(file_path.c_str(), "r");
                    if (file) {
                        printf("\n--- Contents of %s ---\n", argument);
                        char line[1024];
                        int line_number = 1;
                        while (fgets(line, sizeof(line), file)) {
                            printf("%4d: %s", line_number++, line);
                        }
                        fclose(file);
                        printf("--- End of file ---\n");
                    } else {
                        printf("Error: Cannot read file '%s' (permission denied)\n", argument);
                    }
                } else {
                    printf("Error: '%s' is a directory, not a file\n", argument);
                }
            } else {
                printf("Error: File '%s' does not exist\n", argument);
            }
        }
        else if (strcmp(command, "clear") == 0) {
            // Clear screen using ANSI escape codes
            printf("\033[2J\033[H");
            printf("=== LPP-SDL Console REPL ===\n");
            printf("Type 'help' for available commands.\n");
        }
        else if (strcmp(command, "info") == 0) {
            printf("\n=== System Information ===\n");
            printf("Platform: Linux SDL2\n");
            printf("Mode: Console/Headless\n");
            printf("Current Directory: %s\n", current_dir.c_str());
            printf("LPP-SDL Version: Console REPL\n");
            printf("Lua Engine: LuaJIT\n");
            printf("Features: File Operations, Timer, System, Network\n");
            printf("Graphics: Disabled (headless mode)\n");
            printf("Audio: Disabled (headless mode)\n");
            printf("Console Commands: help, list/ls/dir, cd, pwd, run/load, cat, clear, info, lua, exit\n");
        }
        else if (strcmp(command, "lua") == 0) {
            if (!argument) {
                printf("Error: lua requires Lua code argument\n");
                printf("Example: lua print('Hello World')\n");
                printf("Example: lua local x = System.input('Name: '); print('Hi ' .. x)\n");
                continue;
            }
            
            // Execute Lua code
            int result = luaL_dostring(L, argument);
            if (result != LUA_OK) {
                printf("Lua error: %s\n", lua_tostring(L, -1));
                lua_pop(L, 1);
            }
        }
        else if (strcmp(command, "exit") == 0 || strcmp(command, "quit") == 0) {
            printf("Exiting console REPL...\n");
#ifdef USE_READLINE
            free(input);
#endif
            break;
        }
        else {
            printf("Unknown command: %s\n", command);
            printf("Type 'help' for available commands.\n");
        }
        
#ifdef USE_READLINE
        // Free readline input
        free(input);
#endif
    }
    
#ifdef USE_READLINE
    // Cleanup readline
    cleanup_readline();
#endif
    
    return nullptr;
}

int main(int argc, char* args[]) {
    lua_State* L = NULL;
    lpp_compat_mode_t compat_mode = LPP_COMPAT_NATIVE; // Default to native mode
    bool vita_compat_mode = false; // Legacy flag for backward compatibility
    bool threeds_compat_mode = false; // Legacy flag for backward compatibility
    bool headless_mode = false; // Headless mode flag (no SDL window)
    const char* lua_file = NULL;
    
    // Store the executable directory for font loading
    std::string exe_dir = ".";
    if (argc > 0 && args[0]) {
        std::string exe_path(args[0]);
        size_t last_slash = exe_path.find_last_of("/\\");
        if (last_slash != std::string::npos) {
            exe_dir = exe_path.substr(0, last_slash);
        }
    }

    // Parse command line arguments
    for (int i = 1; i < argc; i++) {
        if (strcmp(args[i], "-vitacompat") == 0) {
            compat_mode = LPP_COMPAT_VITA;
            vita_compat_mode = true; // Set legacy flag for backward compatibility
            printf("Vita compatibility mode enabled\n");
        } else if (strcmp(args[i], "-3dscompat") == 0) {
            compat_mode = LPP_COMPAT_3DS;
            g_3ds_orientation = LPP_3DS_HORIZONTAL; // Default to horizontal layout
            threeds_compat_mode = true; // Set legacy flag for backward compatibility
            vita_compat_mode = true; // 3DS mode implies vita compat for scaling
            printf("3DS compatibility mode enabled (horizontal dual screen)\n");
        } else if (strcmp(args[i], "-3dscompat-horizontal") == 0) {
            compat_mode = LPP_COMPAT_3DS;
            g_3ds_orientation = LPP_3DS_HORIZONTAL;
            threeds_compat_mode = true;
            vita_compat_mode = true;
            printf("3DS compatibility mode enabled (horizontal dual screen)\n");
        } else if (strcmp(args[i], "-3dscompat-vertical") == 0) {
            compat_mode = LPP_COMPAT_3DS;
            g_3ds_orientation = LPP_3DS_VERTICAL;
            threeds_compat_mode = true;
            vita_compat_mode = true;
            printf("3DS compatibility mode enabled (vertical dual screen)\n");
        } else if (strcmp(args[i], "-3dscompat-1screen") == 0) {
            compat_mode = LPP_COMPAT_3DS;
            g_3ds_orientation = LPP_3DS_HORIZONTAL; // Default orientation
            g_3ds_single_screen_mode = true;
            g_3ds_active_screen = 0; // Start with top screen
            threeds_compat_mode = true;
            vita_compat_mode = true;
            printf("3DS compatibility mode enabled (single screen with TAB switching)\n");
        } else if (strcmp(args[i], "-debug") == 0) {
            g_debug_mode = true;
            printf("Debug mode enabled\n");
        } else if (strcmp(args[i], "-headless") == 0 || strcmp(args[i], "-console") == 0) {
            headless_mode = true;
            g_headless_mode = true; // Set global flag
            printf("Headless mode enabled (no GUI window)\n");
        } else if (strcmp(args[i], "--help") == 0 || strcmp(args[i], "-h") == 0) {
            printf("Lua Player Plus SDL - Compatibility Usage:\n");
            printf("  %s [options] <lua_file>\n\n", args[0]);
            printf("Compatibility Options:\n");
            printf("  -vitacompat              Enable Vita compatibility mode (960x544 resolution)\n");
            printf("  -3dscompat               Enable 3DS compatibility mode (horizontal dual screen)\n");
            printf("  -3dscompat-horizontal    Enable 3DS mode with side-by-side screen layout\n");
            printf("  -3dscompat-vertical      Enable 3DS mode with top/bottom screen layout\n");
            printf("  -3dscompat-1screen       Enable 3DS mode with single screen (TAB to switch)\n");
            printf("\nOther Options:\n");
            printf("  -debug              Enable debug output\n");
            printf("  -headless, -console Run without GUI window (for scripts that don't need graphics)\n");
            printf("  -h, --help          Show this help message\n");
            printf("\nIf no lua file is specified, the program will:\n");
            printf("  1. Look for index.lua in the current directory\n");
            printf("  2. Launch a file browser (GUI mode) or console REPL (headless mode)\n");
            printf("\nExamples:\n");
            printf("  %s -vitacompat mygame.lua             # Run with Vita compatibility\n", args[0]);
            printf("  %s -3dscompat mygame.lua              # Run with 3DS compatibility (horizontal)\n", args[0]);
            printf("  %s -3dscompat-vertical mygame.lua     # Run with 3DS compatibility (vertical)\n", args[0]);
            printf("  %s -3dscompat-1screen mygame.lua      # Run with 3DS single screen mode\n", args[0]);
            printf("  %s mygame.lua                         # Run in native SDL mode (default)\n", args[0]);
            printf("  %s -headless                          # Launch interactive console REPL\n", args[0]);
            return 0;
        } else if (lua_file == NULL) {
            lua_file = args[i];
        } else {
            printf("Unknown argument: %s\n", args[i]);
            printf("Use --help for usage information.\n");
        }
    }

    // Check for Lua file argument
    if (lua_file == NULL) {
        // Check for index.lua in current directory
        if (access("index.lua", F_OK) == 0) {
            lua_file = "index.lua";
            printf("Found index.lua in current directory, loading it...\n");
        } else {
            // No file specified and no index.lua found
            if (headless_mode) {
                // In headless mode, launch console REPL
                printf("No Lua file specified. Starting console REPL...\n");
                lua_file = "__console_repl__";
            } else {
                // In GUI mode, launch file browser
                printf("No Lua file specified and no index.lua found. Launching file browser...\n");
                lua_file = "__file_browser__";
            }
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
    
    // Override require to handle Vita paths
    const char* require_override = R"(
        local original_require = require
        function require(modname)
            -- Handle Vita paths
            if modname:match("^app0:/") then
                -- Remove app0:/ prefix and .lua extension if present
                local fixed_path = modname:gsub("^app0:/", ""):gsub("%.lua$", "")
                return original_require(fixed_path)
            end
            return original_require(modname)
        end
    )";
    
    if (luaL_dostring(L, require_override) != 0) {
        printf("Failed to override require function: %s\n", lua_tostring(L, -1));
    }
    
    luaSystem_init(L);
    luaTimer_init(L);

    // Initialize LPP-Vita modules
    luaControls_init(L);
    luaScreen_init(L);
    luaGraphics_init(L);
    luaSound_init(L);
    luaSystem_init(L);
    luaNetwork_init(L);
    luaSocket_init(L);
    luaTimer_init(L);
    luaKeyboard_init(L);
    luaRender_init(L);
    luaMic_init(L);
    luaVideo_init(L);
    luaCamera_init(L);
    luaDatabase_init(L);
    luaRegistry_init(L);
    luaGui_init(L);

    // Initialize SDL (conditionally initialize video based on headless mode)
    Uint32 sdl_flags = SDL_INIT_AUDIO | SDL_INIT_JOYSTICK | SDL_INIT_GAMECONTROLLER;
    if (!headless_mode) {
        sdl_flags |= SDL_INIT_VIDEO;
    }
    
    if (SDL_Init(sdl_flags) < 0) {
        printf("SDL could not initialize! SDL_Error: %s\n", SDL_GetError());
        return 1;
    }

    // Initialize SDL_image and SDL_ttf only if not in headless mode
    if (!headless_mode) {
        if (!(IMG_Init(IMG_INIT_PNG | IMG_INIT_JPG) & (IMG_INIT_PNG | IMG_INIT_JPG))) {
            printf("SDL_image could not initialize! IMG_Error: %s\n", IMG_GetError());
            SDL_Quit();
            return 1;
        }

        if (TTF_Init() == -1) {
            printf("SDL_ttf could not initialize! TTF_Error: %s\n", TTF_GetError());
            SDL_Quit();
            return 1;
        }
    }

    // Initialize and detect game controllers
    init_controllers();

    // Handle console REPL mode (headless only)
    if (strcmp(lua_file, "__console_repl__") == 0) {
        // Launch console REPL
        const char* selected_file = launch_console_repl(L);
        
        if (selected_file == NULL) {
            printf("Console REPL exited.\n");
            if (L) lua_close(L);
            SDL_Quit();
            return 0;
        }
        
        lua_file = selected_file;
        printf("Console REPL selected file: %s\n", lua_file);
    }

    // Handle file browser mode early (before renderer setup)
    if (strcmp(lua_file, "__file_browser__") == 0) {
        // Set file browser default mode based on command line compatibility mode
        if (compat_mode == LPP_COMPAT_VITA) {
            browser_compat_mode_index = 4; // vitacompat
            printf("File browser: Defaulting to Vita compatibility mode\n");
        } else if (compat_mode == LPP_COMPAT_3DS) {
            if (g_3ds_single_screen_mode) {
                browser_compat_mode_index = 3; // 3dscompat-1screen
                printf("File browser: Defaulting to 3DS single-screen mode\n");
            } else if (g_3ds_orientation == LPP_3DS_VERTICAL) {
                browser_compat_mode_index = 1; // 3dscompat-vertical
                printf("File browser: Defaulting to 3DS vertical mode\n");
            } else {
                browser_compat_mode_index = 2; // 3dscompat-horizontal
                printf("File browser: Defaulting to 3DS horizontal mode\n");
            }
        } else {
            browser_compat_mode_index = 0; // native (default)
            printf("File browser: Defaulting to native mode\n");
        }
        // Get display resolution for file browser window
        SDL_DisplayMode browser_display_mode;
        if (SDL_GetCurrentDisplayMode(0, &browser_display_mode) != 0) {
            printf("Could not get display mode for file browser: %s\n", SDL_GetError());
            // Fall back to reasonable defaults
            browser_display_mode.w = 1024;
            browser_display_mode.h = 768;
        }
        
        // Use native display resolution for file browser (not console emulation)
        int browser_width = browser_display_mode.w * 0.8; // 80% of screen width
        int browser_height = browser_display_mode.h * 0.8; // 80% of screen height
        if (browser_width < 800) browser_width = 800;   // Minimum width
        if (browser_height < 600) browser_height = 600; // Minimum height
        
        // Create a temporary window and renderer for the file browser using native resolution
        SDL_Window* temp_window = SDL_CreateWindow("Lua Player Plus SDL - File Browser", 
                                                  SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 
                                                  browser_width, browser_height, SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE);
        if (!temp_window) {
            printf("Could not create temporary window for file browser: %s\n", SDL_GetError());
            SDL_Quit();
            return 1;
        }
        
        SDL_Renderer* temp_renderer = SDL_CreateRenderer(temp_window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
        if (!temp_renderer) {
            printf("Could not create temporary renderer for file browser: %s\n", SDL_GetError());
            SDL_DestroyWindow(temp_window);
            SDL_Quit();
            return 1;
        }
        
        // File browser uses native rendering - no logical scaling needed
        // This allows it to use the full display resolution for better UI experience
        printf("File browser: Using native resolution %dx%d (no console emulation)\n", browser_width, browser_height);
        
        // Load default font for file browser
        g_defaultFont = TTF_OpenFont("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 16);
        if (!g_defaultFont) {
            // Fallback to other common system fonts
            g_defaultFont = TTF_OpenFont("/System/Library/Fonts/Helvetica.ttc", 16);
            if (!g_defaultFont) {
                g_defaultFont = TTF_OpenFont("/Windows/Fonts/arial.ttf", 16);
                if (!g_defaultFont) {
                    printf("Could not load any system font for file browser\n");
                    SDL_DestroyRenderer(temp_renderer);
                    SDL_DestroyWindow(temp_window);
                    SDL_Quit();
                    return 1;
                }
            }
        }
        
        // Set global renderer temporarily for file browser
        g_window = temp_window;
        g_renderer = temp_renderer;
        
        // Launch file browser
        const char* selected_file = launch_file_browser(L);
        
        // Clean up temporary renderer and window
        SDL_DestroyRenderer(temp_renderer);
        SDL_DestroyWindow(temp_window);
        g_renderer = nullptr;
        g_window = nullptr;
        
        if (selected_file == NULL) {
            printf("File browser exited without selection.\n");
            if (g_defaultFont) TTF_CloseFont(g_defaultFont);
            TTF_Quit();
            IMG_Quit();
            SDL_Quit();
            if (L) lua_close(L);
            return 0;
        }
        
        lua_file = selected_file;
        
        // Apply selected compatibility mode from file browser
        const char* selected_mode = browser_compat_modes[browser_compat_mode_index];
        if (strcmp(selected_mode, "vitacompat") == 0) {
            compat_mode = LPP_COMPAT_VITA;
            vita_compat_mode = true;
            printf("Compatibility mode: Vita (%s)\n", selected_mode);
        } else if (strcmp(selected_mode, "3dscompat-vertical") == 0) {
            compat_mode = LPP_COMPAT_3DS;
            g_3ds_orientation = LPP_3DS_VERTICAL;
            threeds_compat_mode = true;
            vita_compat_mode = true;
            printf("Compatibility mode: 3DS Vertical (%s)\n", selected_mode);
        } else if (strcmp(selected_mode, "3dscompat-horizontal") == 0) {
            compat_mode = LPP_COMPAT_3DS;
            g_3ds_orientation = LPP_3DS_HORIZONTAL;
            threeds_compat_mode = true;
            vita_compat_mode = true;
            printf("Compatibility mode: 3DS Horizontal (%s)\n", selected_mode);
        } else if (strcmp(selected_mode, "3dscompat-1screen") == 0) {
            compat_mode = LPP_COMPAT_3DS;
            g_3ds_orientation = LPP_3DS_VERTICAL;
            g_3ds_single_screen_mode = true;
            g_3ds_active_screen = 0; // Start with top screen
            threeds_compat_mode = true;
            vita_compat_mode = true;
            printf("Compatibility mode: 3DS Single Screen (%s)\n", selected_mode);
        } else {
            // native mode - no changes needed, defaults are already set
            printf("Compatibility mode: Native (%s)\n", selected_mode);
        }
    }

    // Load the global default font from executable directory
    std::string font_path = exe_dir + "/InterVariable.ttf";
    g_defaultFont = TTF_OpenFont(font_path.c_str(), 16); // Default size 16
    if (!g_defaultFont) {
        printf("Warning: Failed to load default font '%s'. Graphics.print will not work. TTF_Error: %s\n", font_path.c_str(), TTF_GetError());
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
    
    // Set native logical resolution based on display resolution (only in native mode)
    if (compat_mode == LPP_COMPAT_NATIVE) {
        NATIVE_LOGICAL_WIDTH = display_mode.w;
        NATIVE_LOGICAL_HEIGHT = display_mode.h;
        printf("Native mode: Set logical resolution to %dx%d (display resolution)\n", 
               NATIVE_LOGICAL_WIDTH, NATIVE_LOGICAL_HEIGHT);
    }
    
    int window_width, window_height;
    
    g_compat_mode = compat_mode; // Store globally for other modules to access
    g_vita_compat_mode = vita_compat_mode; // Store legacy flag for backward compatibility
    g_dual_screen_mode = threeds_compat_mode; // Store legacy flag for backward compatibility
    
    // Skip all GUI setup in headless mode
    if (headless_mode) {
        printf("Headless mode: Skipping window and renderer creation\n");
        goto skip_gui_setup;
    }
    
    // Update key constants now that compatibility mode is set
    luaControls_set_key_constants(L);
    
    if (compat_mode != LPP_COMPAT_NATIVE) {
        // Vita/3DS compatibility mode: Calculate window size maintaining aspect ratio
        float aspect_ratio;
        int logical_height;
        
        if (compat_mode == LPP_COMPAT_3DS) {
            // Get layout dimensions based on orientation
            int dual_width, dual_height;
            if (g_3ds_orientation == LPP_3DS_VERTICAL) {
                dual_width = DUAL_SCREEN_WIDTH_V;   // 400
                dual_height = DUAL_SCREEN_HEIGHT_V; // 480
            } else {
                dual_width = DUAL_SCREEN_WIDTH_H;   // 720
                dual_height = DUAL_SCREEN_HEIGHT_H; // 240
            }
            
            // Check if screen is too small for dual-screen layout
            bool force_single_screen = false;
            if (g_3ds_orientation == LPP_3DS_VERTICAL) {
                // For vertical layout, check if we have enough height for both screens
                force_single_screen = (display_mode.h <= 600);
            } else {
                // For horizontal layout, check if we have enough width for both screens
                force_single_screen = (display_mode.w <= 800 || display_mode.h <= 600);
            }
            
            if (force_single_screen || g_3ds_single_screen_mode) {
                // Enable single-screen mode for small displays or when explicitly requested
                g_3ds_single_screen_mode = true;
                g_3ds_active_screen = 0; // Start with top screen
                // Use top screen dimensions for window sizing (will be properly sized for single screen)
                aspect_ratio = (float)DS_TOP_SCREEN_WIDTH / (float)DS_TOP_SCREEN_HEIGHT; // 400x240
                logical_height = DS_TOP_SCREEN_HEIGHT; // 240
                if (force_single_screen) {
                    printf("3DS single-screen mode enabled for small display (%dx%d)\n", display_mode.w, display_mode.h);
                }
                printf("Use TAB key to switch between top and bottom screens\n");
            } else {
                // Normal dual screen mode
                g_3ds_single_screen_mode = false;
                aspect_ratio = (float)dual_width / (float)dual_height;
                logical_height = dual_height;
                const char* orientation_name = (g_3ds_orientation == LPP_3DS_VERTICAL) ? "vertical" : "horizontal";
                printf("3DS dual-screen mode (%s): %dx%d layout\n", orientation_name, dual_width, dual_height);
            }
        } else {
            // Vita compatibility mode - check for small screens
            g_3ds_single_screen_mode = false; // Not applicable for Vita mode
            if (display_mode.w <= 640 || display_mode.h <= 480) {
                // Scale down Vita resolution for very small screens while maintaining aspect ratio
                // 960x544 -> 640x360 (maintains 16:9 aspect ratio)
                aspect_ratio = 640.0f / 360.0f;
                logical_height = 360;
                printf("Vita adaptive scaling enabled for small display (%dx%d)\n", display_mode.w, display_mode.h);
                printf("Using scaled resolution 640x360 instead of 960x544\n");
            } else {
                // Normal Vita resolution: 960x544
                aspect_ratio = (float)SCREEN_WIDTH / (float)SCREEN_HEIGHT;
                logical_height = SCREEN_HEIGHT;
            }
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
        int min_logical_width;
        if (compat_mode == LPP_COMPAT_3DS) {
            if (g_3ds_single_screen_mode) {
                // Single-screen mode: use top screen dimensions
                min_logical_width = DS_TOP_SCREEN_WIDTH; // 400
            } else {
                // Dual-screen mode: use full dual screen dimensions
                min_logical_width = (g_3ds_orientation == LPP_3DS_VERTICAL) ? DUAL_SCREEN_WIDTH_V : DUAL_SCREEN_WIDTH_H;
            }
        } else {
            min_logical_width = SCREEN_WIDTH;
        }
        
        if (window_width < min_logical_width || window_height < logical_height) {
            window_width = min_logical_width;
            window_height = logical_height;
        }
        
        // For 3DS mode, ensure we have a large enough window to see screens clearly
        if (compat_mode == LPP_COMPAT_3DS && !g_3ds_single_screen_mode) {
            // Make window at least 1.5x the logical size for better visibility (dual-screen mode only)
            int dual_width = (g_3ds_orientation == LPP_3DS_VERTICAL) ? DUAL_SCREEN_WIDTH_V : DUAL_SCREEN_WIDTH_H;
            int dual_height = (g_3ds_orientation == LPP_3DS_VERTICAL) ? DUAL_SCREEN_HEIGHT_V : DUAL_SCREEN_HEIGHT_H;
            int min_width = (dual_width * 3) / 2;
            int min_height = (dual_height * 3) / 2;
            if (window_width < min_width) window_width = min_width;
            if (window_height < min_height) window_height = min_height;
        }
        
        if (compat_mode == LPP_COMPAT_3DS) {
            if (g_3ds_single_screen_mode) {
                printf("3DS single-screen mode: Window size %dx%d for logical size %dx%d\n", 
                       window_width, window_height, DS_TOP_SCREEN_WIDTH, DS_TOP_SCREEN_HEIGHT);
            } else {
                int dual_width = (g_3ds_orientation == LPP_3DS_VERTICAL) ? DUAL_SCREEN_WIDTH_V : DUAL_SCREEN_WIDTH_H;
                int dual_height = (g_3ds_orientation == LPP_3DS_VERTICAL) ? DUAL_SCREEN_HEIGHT_V : DUAL_SCREEN_HEIGHT_H;
                const char* orientation_name = (g_3ds_orientation == LPP_3DS_VERTICAL) ? "vertical" : "horizontal";
                printf("3DS compatibility mode (%s): Window size %dx%d for logical size %dx%d\n", 
                       orientation_name, window_width, window_height, dual_width, dual_height);
            }
        } else {
            printf("Vita compatibility mode: Window size %dx%d for logical size %dx%d\n", 
                   window_width, window_height, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
    } else {
        // Native resolution mode: Use full display resolution for maximum quality
        window_width = display_mode.w;
        window_height = display_mode.h;
        
        printf("Native resolution mode: Using full display resolution %dx%d\n", window_width, window_height);
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
    
    // macOS specific fixes - different approaches for Intel vs ARM64
#ifdef __APPLE__
    // Disable high DPI to avoid Retina scaling issues (both architectures)
    SDL_SetHint(SDL_HINT_VIDEO_HIGHDPI_DISABLED, "1");
    
    #if defined(__APPLE__) && defined(__aarch64__)
        // macOS ARM64 specific: Use OpenGL instead of Metal for buffer sync issues
        SDL_SetHint(SDL_HINT_RENDER_DRIVER, "opengl");
        SDL_SetHint(SDL_HINT_RENDER_BATCHING, "0");
        printf("macOS ARM64: Using OpenGL renderer with disabled batching\n");
    #elif defined(__APPLE__)
        // Intel Mac: Metal works better on x86_64
        SDL_SetHint(SDL_HINT_RENDER_DRIVER, "metal");
        SDL_SetHint(SDL_HINT_RENDER_BATCHING, "1");
        printf("macOS Intel: Using Metal renderer with batching enabled\n");
    #endif
#endif

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
    
    // Debug: Print renderer info on macOS
#ifdef __APPLE__
    SDL_RendererInfo renderer_info;
    if (SDL_GetRendererInfo(g_renderer, &renderer_info) == 0) {
        printf("macOS Renderer: %s\n", renderer_info.name);
        printf("Renderer flags: 0x%08X\n", renderer_info.flags);
    }
#endif
    
    // Enable alpha blending for proper transparency support
    SDL_SetRenderDrawBlendMode(g_renderer, SDL_BLENDMODE_BLEND);
    
    
    
    // Hide the system cursor to prevent rendering artifacts
    // SDL_ShowCursor(SDL_DISABLE); // Keep mouse visible by default
    
    // Additional macOS compatibility fixes
#ifdef __APPLE__
    // Force refresh rate to avoid timing issues
    SDL_GL_SetSwapInterval(1);
    // Clear all render targets to prevent buffer artifacts
    SDL_SetRenderTarget(g_renderer, NULL);
    SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
    SDL_RenderFillRect(g_renderer, NULL);
    
    #if defined(__APPLE__) && defined(__aarch64__)
        // macOS ARM64 specific: Force buffer flush for sync issues
        SDL_RenderPresent(g_renderer);
        SDL_RenderClear(g_renderer);
        printf("Applied macOS ARM64 buffer sync fix\n");
    #endif
#endif

    // Set logical size only in compatibility modes
    if (compat_mode != LPP_COMPAT_NATIVE) {
        // Clear renderer first
        SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
        SDL_RenderClear(g_renderer);
        
        // For 3DS compatibility mode, handle both dual-screen and single-screen modes
        if (compat_mode == LPP_COMPAT_3DS) {
            if (g_3ds_single_screen_mode) {
                // Single-screen mode: Use uniform logical sizing to prevent artifacts
                int logical_width = DS_TOP_SCREEN_WIDTH;  // Always use 400px width
                int logical_height = DS_TOP_SCREEN_HEIGHT; // Always use 240px height
                
                if (SDL_RenderSetLogicalSize(g_renderer, logical_width, logical_height) != 0) {
                    printf("Warning: Could not set logical size: %s\n", SDL_GetError());
                } else {
                    const char* screen_name = (g_3ds_active_screen == 0) ? "top" : "bottom";
                    printf("3DS single-screen mode: Set logical size to %dx%d (%s screen) in %dx%d window\n", 
                           logical_width, logical_height, screen_name, window_width, window_height);
                }
            } else {
                // Dual-screen mode: Use SDL logical scaling (like Vita mode)
                int dual_width, dual_height;
                if (g_3ds_orientation == LPP_3DS_VERTICAL) {
                    dual_width = DUAL_SCREEN_WIDTH_V;   // 400
                    dual_height = DUAL_SCREEN_HEIGHT_V; // 480
                } else {
                    dual_width = DUAL_SCREEN_WIDTH_H;   // 720
                    dual_height = DUAL_SCREEN_HEIGHT_H; // 240
                }
                
                // Use original 3DS logical dimensions
                int logical_width = dual_width;
                int logical_height = dual_height;
                
                if (SDL_RenderSetLogicalSize(g_renderer, logical_width, logical_height) != 0) {
                    printf("Warning: Could not set logical size for 3DS dual-screen mode: %s\n", SDL_GetError());
                } else {
                    const char* orientation_name = (g_3ds_orientation == LPP_3DS_VERTICAL) ? "vertical" : "horizontal";
                    printf("3DS dual-screen mode (%s): Set logical size to %dx%d in %dx%d window\n", 
                           orientation_name, logical_width, logical_height, window_width, window_height);
                }
            }
        } else {
            // Vita compatibility mode with adaptive scaling
            int vita_logical_width, vita_logical_height;
            
            if (display_mode.w <= 640 || display_mode.h <= 480) {
                // Use scaled down resolution for small screens
                vita_logical_width = 640;
                vita_logical_height = 360;
            } else {
                // Use normal Vita resolution
                vita_logical_width = SCREEN_WIDTH;   // 960
                vita_logical_height = SCREEN_HEIGHT; // 544
            }
            
            if (SDL_RenderSetLogicalSize(g_renderer, vita_logical_width, vita_logical_height) != 0) {
                printf("Warning: Could not set logical size: %s\n", SDL_GetError());
            } else {
                if (vita_logical_width == SCREEN_WIDTH) {
                    printf("Set logical size to %dx%d (Vita resolution) in %dx%d window\n", 
                           vita_logical_width, vita_logical_height, window_width, window_height);
                } else {
                    printf("Set adaptive logical size to %dx%d (scaled Vita) in %dx%d window\n", 
                           vita_logical_width, vita_logical_height, window_width, window_height);
                }
            }
            
            // Verify the logical size was set
            int logical_w, logical_h;
            SDL_RenderGetLogicalSize(g_renderer, &logical_w, &logical_h);
            printf("Confirmed logical size: %dx%d\n", logical_w, logical_h);
        }
        
        // Disable integer scaling for smooth scaling
        SDL_RenderSetIntegerScale(g_renderer, SDL_FALSE);
        
        // Set scale quality to linear for smooth scaling
        SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1");
        
        // Force SDL to use letterboxing instead of stretching - this should prevent edge artifacts
        SDL_SetHint(SDL_HINT_RENDER_LOGICAL_SIZE_MODE, "letterbox");
    } else {
        // Native resolution mode: Adaptive logical resolution based on screen size
        // Clear renderer first
        SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
        SDL_RenderClear(g_renderer);
        
        // Use the dynamic native logical resolution (which is now set to display resolution)
        int logical_width = NATIVE_LOGICAL_WIDTH;
        int logical_height = NATIVE_LOGICAL_HEIGHT;
        
        // Set native logical size to match display resolution (1:1 pixel mapping)
        if (SDL_RenderSetLogicalSize(g_renderer, logical_width, logical_height) != 0) {
            printf("Warning: Could not set logical size: %s\n", SDL_GetError());
        } else {
            printf("Set native logical size to %dx%d (1:1 pixel mapping)\n", 
                   logical_width, logical_height);
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
    
    // Set initial render state and clear letterbox areas
    SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
    SDL_RenderClear(g_renderer);
    
#ifdef __APPLE__
    // Force clear the entire window buffer to prevent letterbox artifacts on macOS ARM64
    SDL_Rect full_window;
    SDL_GetWindowSize(g_window, &full_window.w, &full_window.h);
    full_window.x = 0;
    full_window.y = 0;
    SDL_RenderFillRect(g_renderer, &full_window);
#endif
    
    SDL_RenderPresent(g_renderer);

skip_gui_setup:
    // Update key constants now that compatibility mode is set (if not already done)
    if (headless_mode) {
        luaControls_set_key_constants(L);
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
        if (!headless_mode) {
            if (g_renderer) SDL_DestroyRenderer(g_renderer);
            if (g_window) SDL_DestroyWindow(g_window);
            IMG_Quit();
            if (g_defaultFont) TTF_CloseFont(g_defaultFont);
            TTF_Quit();
        }
        SDL_Quit();
        if (L) lua_close(L);
        return 0;
    }

    bool quit = false;
    SDL_Event e;

    // In headless mode, skip the main loop since there's no GUI to handle
    if (headless_mode) {
        printf("Headless mode: Script execution complete, exiting.\n");
        if (L) lua_close(L);
        SDL_Quit();
        return 0;
    }

    // Main loop - for scripts that don't exit immediately
    while (!quit && !should_exit) {
        // Handle events on queue
        while (SDL_PollEvent(&e) != 0) {
            // User requests quit
            if (e.type == SDL_QUIT) {
                quit = true;
            }
            
            // Handle controller hotplug events
            handle_controller_event(&e);
            // Handle keyboard events for controls
            if (e.type == SDL_KEYDOWN) {
                sdl_key_down(e.key.keysym.scancode);
                // ESC key to quit
                if (e.key.keysym.sym == SDLK_ESCAPE) {
                    quit = true;
                }
                // TAB key to switch 3DS screens in single-screen mode
                if (e.key.keysym.sym == SDLK_TAB && g_compat_mode == LPP_COMPAT_3DS && g_3ds_single_screen_mode) {
                    // Switch between top (0) and bottom (1) screens
                    g_3ds_active_screen = (g_3ds_active_screen == 0) ? 1 : 0;
                    
                    // Change logical size to show only the active screen, scaled to fill window
                    int logical_width = (g_3ds_active_screen == 0) ? DS_TOP_SCREEN_WIDTH : DS_BOTTOM_SCREEN_WIDTH;
                    int logical_height = (g_3ds_active_screen == 0) ? DS_TOP_SCREEN_HEIGHT : DS_BOTTOM_SCREEN_HEIGHT;
                    
                    if (SDL_RenderSetLogicalSize(g_renderer, logical_width, logical_height) == 0) {
                        const char* screen_name = (g_3ds_active_screen == 0) ? "top" : "bottom";
                        printf("Switched to %s screen (%dx%d logical, scaled to fill window)\n", screen_name, logical_width, logical_height);
                        
                        // Clear the render target to prevent overlap (but don't present immediately)
                        SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
                        SDL_RenderClear(g_renderer);
                    }
                }
            }
            if (e.type == SDL_KEYUP) {
                sdl_key_up(e.key.keysym.scancode);
            }
            // Handle mouse button events
            if (e.type == SDL_MOUSEBUTTONDOWN) {
                if (e.button.button == SDL_BUTTON_LEFT) {
                    sdl_mouse_button_down();
                }
            }
            if (e.type == SDL_MOUSEBUTTONUP) {
                if (e.button.button == SDL_BUTTON_LEFT) {
                    sdl_mouse_button_up();
                }
            }
            // Handle window resize events to maintain proper scaling
            if (e.type == SDL_WINDOWEVENT && (e.window.event == SDL_WINDOWEVENT_RESIZED || e.window.event == SDL_WINDOWEVENT_SIZE_CHANGED)) {
                if (g_renderer && g_compat_mode != LPP_COMPAT_NATIVE) {
                    if (g_compat_mode == LPP_COMPAT_3DS) {
                        // 3DS dual screen mode: recalculate manual scaling factors
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
                        
                        printf("Window resized: New scale factors: X=%.3f, Y=%.3f\n", g_scale_x, g_scale_y);
                        printf("Per-screen scale factors - Top: X=%.3f, Y=%.3f | Bottom: X=%.3f, Y=%.3f\n", 
                               g_top_screen_scale_x, g_top_screen_scale_y, g_bottom_screen_scale_x, g_bottom_screen_scale_y);
                    } else {
                        // Vita compatibility mode: reapply SDL logical scaling
                        SDL_RenderSetLogicalSize(g_renderer, SCREEN_WIDTH, SCREEN_HEIGHT);
                        SDL_RenderSetIntegerScale(g_renderer, SDL_FALSE);
                    }
                    
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

    // Destroy renderer and window (if they exist)
    if (!headless_mode) {
        if (g_renderer) SDL_DestroyRenderer(g_renderer);
        if (g_window) SDL_DestroyWindow(g_window);
    }

    // Cleanup controllers before SDL shutdown
    cleanup_controllers();
    
    // Quit SDL subsystems
    if (!headless_mode) {
        IMG_Quit();
        if (g_defaultFont) TTF_CloseFont(g_defaultFont);
        TTF_Quit();
    }
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
