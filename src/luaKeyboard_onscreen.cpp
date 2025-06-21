/*----------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#------  This File is Part Of : ----------------------------------------------------------------------------------------#
#------- _  -------------------  ______   _   --------------------------------------------------------------------------#
#------ | | ------------------- (_____ \ | |  --------------------------------------------------------------------------#
#------ | | ---  _   _   ____    _____) )| |  ____  _   _   ____   ____   ----------------------------------------------#
#------ | | --- | | | | / _  |  |  ____/ | | / _  || | | | / _  ) / ___)  ----------------------------------------------#
#------ | |_____| |_| |( ( | |  | |      | |( ( | || |_| |( (/ / | |  --------------------------------------------------#
#------ |_______)____| _||_|  |_|      |_| _||_| __  | ____)|_|  --------------------------------------------------#
#------------------------------------------------- (____/  -------------------------------------------------------------#
#------------------------   ______   _   -------------------------------------------------------------------------------#
#------------------------  (_____ \ | |  -------------------------------------------------------------------------------#
#------------------------   _____) )| | _   _   ___   ------------------------------------------------------------------#
#------------------------  |  ____/ | || | | | /___)  ------------------------------------------------------------------#
#------------------------  | |      | || |_| ||___ |  ------------------------------------------------------------------#
#------------------------  |_|      |_| ____|(___/   ------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#- Licensed under the GPL License --------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#- SDL Port: On-Screen Keyboard Implementation -------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------*/

#include <stdlib.h>
#include <string.h>
#include <vector>
#include <string>
#include <SDL.h>
#include <SDL_ttf.h>
#include "luaplayer.h"

#define stringify(str) #str
#define VariableRegister(lua, value) do { lua_pushinteger(lua, value); lua_setglobal (lua, stringify(value)); } while(0)

// Keyboard constants
#define OSK_STATE_NONE 0
#define OSK_STATE_RUNNING 1
#define OSK_STATE_FINISHED 2
#define OSK_STATE_CANCELED 3

// Keyboard types
#define OSK_TYPE_DEFAULT 0
#define OSK_TYPE_LATIN 1
#define OSK_TYPE_NUMBER 2
#define OSK_TYPE_EXT_NUMBER 3

// Keyboard modes
#define OSK_MODE_TEXT 0
#define OSK_MODE_PASSWORD 1

// Keyboard options
#define OSK_OPT_MULTILINE 1
#define OSK_OPT_NO_AUTOCAP 2
#define OSK_OPT_NO_ASSISTANCE 4

// Global keyboard state
struct OnScreenKeyboard {
    bool active;
    int state;
    std::string title;
    std::string input_text;
    std::string initial_text;
    int max_length;
    int type;
    int mode;
    int option;
    int cursor_x;
    int cursor_y;
    int selected_key;
    bool shift_mode;
    bool caps_lock;
    std::vector<std::vector<std::string>> layout;
    std::vector<std::vector<std::string>> shift_layout;
    int layout_width;
    int layout_height;
    uint32_t last_pad;
    bool auto_draw;
} osk;

extern SDL_Renderer* g_renderer;
extern TTF_Font* g_defaultFont;
extern bool g_vita_compat_mode;

// Forward declarations
extern "C" int lua_readControls(lua_State *L);
void autoUpdateKeyboard();
void autoDrawKeyboard(lua_State *L);

// Helper function to render text with SDL_ttf
void renderKeyboardText(const char* text, int x, int y, SDL_Color color, float scale = 1.0f) {
    if (!g_defaultFont || !g_renderer || !text || strlen(text) == 0) return;
    
    SDL_Surface* text_surface = TTF_RenderText_Blended(g_defaultFont, text, color);
    if (!text_surface) return;
    
    SDL_Texture* text_texture = SDL_CreateTextureFromSurface(g_renderer, text_surface);
    if (!text_texture) {
        SDL_FreeSurface(text_surface);
        return;
    }
    
    SDL_SetTextureScaleMode(text_texture, SDL_ScaleModeNearest);
    SDL_Rect dest_rect = { x, y, (int)(text_surface->w * scale), (int)(text_surface->h * scale) };
    SDL_RenderCopy(g_renderer, text_texture, NULL, &dest_rect);
    
    SDL_DestroyTexture(text_texture);
    SDL_FreeSurface(text_surface);
}

// QWERTY keyboard layouts
void initKeyboardLayouts() {
    // Normal layout
    osk.layout = {
        {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "DEL"},
        {"q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "[", "]", "\\"},
        {"a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "'", "ENTER"},
        {"SHIFT", "z", "x", "c", "v", "b", "n", "m", ",", ".", "/", "SHIFT"},
        {"SPACE", "CLEAR", "CANCEL", "OK"}
    };
    
    // Shift layout
    osk.shift_layout = {
        {"!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+", "DEL"},
        {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "{", "}", "|"},
        {"A", "S", "D", "F", "G", "H", "J", "K", "L", ":", "\"", "ENTER"},
        {"SHIFT", "Z", "X", "C", "V", "B", "N", "M", "<", ">", "?", "SHIFT"},
        {"SPACE", "CLEAR", "CANCEL", "OK"}
    };
    
    osk.layout_height = osk.layout.size();
    osk.layout_width = 0;
    for (const auto& row : osk.layout) {
        if (row.size() > osk.layout_width) {
            osk.layout_width = row.size();
        }
    }
}

// Initialize keyboard state
static int lua_setup(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc < 2 || argc > 6) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    if (osk.active) {
        return luaL_error(L, "keyboard already active");
    }
    
    const char* title_str = luaL_checkstring(L, 1);
    const char* initial_str = luaL_checkstring(L, 2);
    
    // Set defaults
    osk.max_length = 128;
    osk.type = OSK_TYPE_DEFAULT;
    osk.mode = OSK_MODE_TEXT;
    osk.option = 0;
    
    // Parse optional arguments
    if (argc >= 3) osk.max_length = luaL_checkinteger(L, 3);
    if (argc >= 4) osk.type = luaL_checkinteger(L, 4);
    if (argc >= 5) osk.mode = luaL_checkinteger(L, 5);
    if (argc >= 6) osk.option = luaL_checkinteger(L, 6);
    
    // Validate and clamp values
    if (osk.max_length < 1) osk.max_length = 1;
    if (osk.max_length > 1024) osk.max_length = 1024;
    if (osk.type < 0 || osk.type > 3) osk.type = OSK_TYPE_DEFAULT;
    if (osk.mode < 0 || osk.mode > 1) osk.mode = OSK_MODE_TEXT;
    
    // Initialize keyboard
    osk.title = title_str;
    osk.input_text = initial_str;
    osk.initial_text = initial_str;
    osk.active = true;
    osk.state = OSK_STATE_RUNNING;
    osk.cursor_x = 0;
    osk.cursor_y = 0;
    osk.selected_key = 0;
    osk.shift_mode = false;
    osk.caps_lock = false;
    osk.last_pad = 0;
    osk.auto_draw = true;
    
    initKeyboardLayouts();
    
    return 0;
}

// Get keyboard state
static int lua_state(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    // Auto-draw keyboard when state is checked (like original Vita)
    if (osk.active && g_renderer) {
        // Draw keyboard background
        int screen_width, screen_height;
        
        if (g_vita_compat_mode) {
            // In vitacompat mode, use logical Vita resolution
            screen_width = 960;  // SCREEN_WIDTH
            screen_height = 544; // SCREEN_HEIGHT
        } else {
            // In native mode, use actual renderer size
            SDL_GetRendererOutputSize(g_renderer, &screen_width, &screen_height);
        }
        
        // Keyboard area - scale with screen size
        int kb_width = (int)(screen_width * 0.95);  // 95% of screen width
        int kb_height = (int)(screen_height * 0.55); // 55% of screen height  
        int kb_x = (screen_width - kb_width) / 2;   // Center horizontally
        int kb_y = screen_height - kb_height - (int)(screen_height * 0.02); // 2% margin from bottom
        
        // Background
        SDL_SetRenderDrawColor(g_renderer, 40, 40, 40, 220);
        SDL_Rect bg_rect = {kb_x - 10, kb_y - 60, kb_width + 20, kb_height + 80};
        SDL_RenderFillRect(g_renderer, &bg_rect);
        
        // Border
        SDL_SetRenderDrawColor(g_renderer, 100, 100, 100, 255);
        SDL_RenderDrawRect(g_renderer, &bg_rect);
        
        // Title area - made bigger
        SDL_SetRenderDrawColor(g_renderer, 60, 60, 60, 255);
        SDL_Rect title_rect = {kb_x - 10, kb_y - 80, kb_width + 20, 40}; // Increased height from 30 to 40, moved up
        SDL_RenderFillRect(g_renderer, &title_rect);
        
        // Input text area - made bigger
        SDL_SetRenderDrawColor(g_renderer, 255, 255, 255, 255);
        SDL_Rect input_rect = {kb_x, kb_y - 35, kb_width, 35}; // Increased height from 25 to 35, moved up
        SDL_RenderFillRect(g_renderer, &input_rect);
        SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
        SDL_RenderDrawRect(g_renderer, &input_rect);
        
        // Draw keyboard keys
        auto& current_layout = (osk.shift_mode || osk.caps_lock) ? osk.shift_layout : osk.layout;
        int key_w = kb_width / 13;
        int key_h = kb_height / 5;
        
        for (int row = 0; row < current_layout.size(); row++) {
            for (int col = 0; col < current_layout[row].size(); col++) {
                int key_x = kb_x + (col * key_w);
                int key_y = kb_y + (row * key_h);
                
                // Key background
                bool is_selected = (row == osk.cursor_y && col == osk.cursor_x);
                if (is_selected) {
                    SDL_SetRenderDrawColor(g_renderer, 100, 150, 200, 255);
                } else if (current_layout[row][col] == "SHIFT" && (osk.shift_mode || osk.caps_lock)) {
                    SDL_SetRenderDrawColor(g_renderer, 150, 100, 100, 255);
                } else {
                    SDL_SetRenderDrawColor(g_renderer, 80, 80, 80, 255);
                }
                
                SDL_Rect key_rect = {key_x + 1, key_y + 1, key_w - 3, key_h - 3};
                SDL_RenderFillRect(g_renderer, &key_rect);
                
                // Key border
                SDL_SetRenderDrawColor(g_renderer, 120, 120, 120, 255);
                SDL_RenderDrawRect(g_renderer, &key_rect);
            }
        }
        
        // Render keyboard text
        SDL_Color white_color = {255, 255, 255, 255};
        SDL_Color black_color = {0, 0, 0, 255};
        SDL_Color selected_color = {255, 255, 0, 255};
        
        // Calculate text scale based on screen size - increased for better visibility
        float text_scale;
        if (g_vita_compat_mode) {
            // In vitacompat mode, use fixed scale for Vita resolution
            text_scale = 1.2f;
        } else {
            // In native mode, scale relative to screen size
            text_scale = (float)screen_width / 960.0f * 1.2f; // Scale relative to Vita resolution
            if (text_scale < 0.8f) text_scale = 0.8f; // Minimum size increased from 0.5f
            if (text_scale > 3.0f) text_scale = 3.0f; // Maximum size increased from 2.0f
        }
        
        // Render key text
        for (int row = 0; row < current_layout.size(); row++) {
            for (int col = 0; col < current_layout[row].size(); col++) {
                std::string key_text = current_layout[row][col];
                int key_x = kb_x + (col * key_w);
                int key_y = kb_y + (row * key_h);
                
                // Adjust text scale based on key text length to prevent overflow
                float key_text_scale = text_scale;
                if (key_text.length() > 4) {
                    // Scale down longer text to fit in key
                    key_text_scale = text_scale * 0.6f; // Smaller scale for long text
                } else if (key_text.length() > 2) {
                    key_text_scale = text_scale * 0.8f; // Medium scale for medium text
                }
                
                // Better text centering calculation using actual font metrics
                int estimated_text_width = (int)(key_text.length() * 8 * key_text_scale);
                int estimated_text_height = (int)(16 * key_text_scale);
                int text_x = key_x + (key_w - estimated_text_width) / 2;
                int text_y = key_y + (key_h - estimated_text_height) / 2;
                
                // Use different color for selected key
                bool is_selected = (row == osk.cursor_y && col == osk.cursor_x);
                SDL_Color text_color = is_selected ? selected_color : white_color;
                
                renderKeyboardText(key_text.c_str(), text_x, text_y, text_color, key_text_scale);
            }
        }
        
        // Render title - moved higher to center in bigger area
        renderKeyboardText(osk.title.c_str(), kb_x, kb_y - 75, white_color, text_scale);
        
        // Render input text - moved higher to center in bigger area
        std::string display_text = osk.input_text;
        if (osk.mode == OSK_MODE_PASSWORD) {
            // Show asterisks for password mode
            display_text = std::string(osk.input_text.length(), '*');
        }
        renderKeyboardText(display_text.c_str(), kb_x + 5, kb_y - 30, black_color, text_scale);
        
        // Handle input while keyboard is active
        // Get SDL keyboard state
        const Uint8* keystate = SDL_GetKeyboardState(NULL);
        
        // Track key presses (simple debouncing)
        static bool last_up = false, last_down = false, last_left = false, last_right = false;
        static bool last_enter = false, last_ctrl = false;
        
        bool up_pressed = keystate[SDL_SCANCODE_UP];
        bool down_pressed = keystate[SDL_SCANCODE_DOWN];
        bool left_pressed = keystate[SDL_SCANCODE_LEFT];
        bool right_pressed = keystate[SDL_SCANCODE_RIGHT];
        bool enter_pressed = keystate[SDL_SCANCODE_RETURN];
        bool ctrl_pressed = keystate[SDL_SCANCODE_LCTRL];
        
        // Navigation (on new key press)
        if (up_pressed && !last_up) {
            osk.cursor_y = (osk.cursor_y - 1 + current_layout.size()) % current_layout.size();
            if (osk.cursor_x >= current_layout[osk.cursor_y].size()) {
                osk.cursor_x = current_layout[osk.cursor_y].size() - 1;
            }
        }
        if (down_pressed && !last_down) {
            osk.cursor_y = (osk.cursor_y + 1) % current_layout.size();
            if (osk.cursor_x >= current_layout[osk.cursor_y].size()) {
                osk.cursor_x = current_layout[osk.cursor_y].size() - 1;
            }
        }
        if (left_pressed && !last_left) {
            osk.cursor_x = (osk.cursor_x - 1 + current_layout[osk.cursor_y].size()) % current_layout[osk.cursor_y].size();
        }
        if (right_pressed && !last_right) {
            osk.cursor_x = (osk.cursor_x + 1) % current_layout[osk.cursor_y].size();
        }
        
        // Key activation (on new key press)
        if (enter_pressed && !last_enter) {
            std::string key = current_layout[osk.cursor_y][osk.cursor_x];
            
            if (key == "ENTER" || key == "OK") {
                osk.state = OSK_STATE_FINISHED;
                osk.active = false;
            } else if (key == "CANCEL") {
                osk.state = OSK_STATE_CANCELED;
                osk.active = false;
            } else if (key == "CLEAR") {
                osk.input_text.clear();
            } else if (key == "DEL") {
                if (!osk.input_text.empty()) {
                    osk.input_text.pop_back();
                }
            } else if (key == "SPACE") {
                if (osk.input_text.length() < osk.max_length) {
                    osk.input_text += " ";
                }
            } else if (key == "SHIFT") {
                osk.shift_mode = !osk.shift_mode;
            } else if (key.length() == 1) {
                if (osk.input_text.length() < osk.max_length) {
                    osk.input_text += key;
                    if (osk.shift_mode && !osk.caps_lock) {
                        osk.shift_mode = false;
                    }
                }
            }
        }
        
        // Toggle caps lock with ctrl
        if (ctrl_pressed && !last_ctrl) {
            osk.caps_lock = !osk.caps_lock;
            if (osk.caps_lock) {
                osk.shift_mode = false;
            }
        }
        
        // Update last key states
        last_up = up_pressed;
        last_down = down_pressed;
        last_left = left_pressed;
        last_right = right_pressed;
        last_enter = enter_pressed;
        last_ctrl = ctrl_pressed;
    }
    
    lua_pushinteger(L, osk.state);
    return 1;
}

// Get current input text
static int lua_input(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    lua_pushstring(L, osk.input_text.c_str());
    return 1;
}

// Clear/close keyboard
static int lua_clear(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.active = false;
    osk.state = OSK_STATE_NONE;
    osk.input_text.clear();
    osk.title.clear();
    
    return 0;
}

// Get keyboard layout data for Lua rendering
static int lua_getLayout(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    if (!osk.active) {
        lua_pushnil(L);
        return 1;
    }
    
    auto& current_layout = (osk.shift_mode || osk.caps_lock) ? osk.shift_layout : osk.layout;
    
    // Create table for layout data
    lua_newtable(L);
    
    // Add layout array
    lua_pushstring(L, "keys");
    lua_newtable(L);
    for (int row = 0; row < current_layout.size(); row++) {
        lua_pushinteger(L, row + 1);
        lua_newtable(L);
        for (int col = 0; col < current_layout[row].size(); col++) {
            lua_pushinteger(L, col + 1);
            lua_pushstring(L, current_layout[row][col].c_str());
            lua_settable(L, -3);
        }
        lua_settable(L, -3);
    }
    lua_settable(L, -3);
    
    // Add cursor position
    lua_pushstring(L, "cursor_x");
    lua_pushinteger(L, osk.cursor_x + 1); // Lua is 1-indexed
    lua_settable(L, -3);
    
    lua_pushstring(L, "cursor_y");
    lua_pushinteger(L, osk.cursor_y + 1); // Lua is 1-indexed
    lua_settable(L, -3);
    
    // Add keyboard state
    lua_pushstring(L, "shift_mode");
    lua_pushboolean(L, osk.shift_mode);
    lua_settable(L, -3);
    
    lua_pushstring(L, "caps_lock");
    lua_pushboolean(L, osk.caps_lock);
    lua_settable(L, -3);
    
    lua_pushstring(L, "title");
    lua_pushstring(L, osk.title.c_str());
    lua_settable(L, -3);
    
    return 1;
}

// Simple draw function that just draws background
static int lua_draw(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    if (!osk.active || !g_renderer) {
        return 0;
    }
    
    int screen_width, screen_height;
    
    if (g_vita_compat_mode) {
        // In vitacompat mode, use logical Vita resolution
        screen_width = 960;  // SCREEN_WIDTH
        screen_height = 544; // SCREEN_HEIGHT
    } else {
        // In native mode, use actual renderer size
        SDL_GetRendererOutputSize(g_renderer, &screen_width, &screen_height);
    }
    
    // Draw keyboard background - scale with screen size
    int kb_width = (int)(screen_width * 0.95);  // 95% of screen width
    int kb_height = (int)(screen_height * 0.55); // 55% of screen height  
    int kb_x = (screen_width - kb_width) / 2;   // Center horizontally
    int kb_y = screen_height - kb_height - (int)(screen_height * 0.02); // 2% margin from bottom
    
    // Background
    SDL_SetRenderDrawColor(g_renderer, 40, 40, 40, 200);
    SDL_Rect bg_rect = {kb_x - 10, kb_y - 60, kb_width + 20, kb_height + 80};
    SDL_RenderFillRect(g_renderer, &bg_rect);
    
    // Border
    SDL_SetRenderDrawColor(g_renderer, 100, 100, 100, 255);
    SDL_RenderDrawRect(g_renderer, &bg_rect);
    
    // Input text area - made bigger
    SDL_SetRenderDrawColor(g_renderer, 255, 255, 255, 255);
    SDL_Rect input_rect = {kb_x, kb_y - 35, kb_width, 35};
    SDL_RenderFillRect(g_renderer, &input_rect);
    SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
    SDL_RenderDrawRect(g_renderer, &input_rect);
    
    // Add text rendering to draw function as well
    SDL_Color white_color = {255, 255, 255, 255};
    SDL_Color black_color = {0, 0, 0, 255};
    
    // Calculate text scale based on screen size - increased for better visibility
    float text_scale;
    if (g_vita_compat_mode) {
        // In vitacompat mode, use fixed scale for Vita resolution
        text_scale = 1.2f;
    } else {
        // In native mode, scale relative to screen size
        text_scale = (float)screen_width / 960.0f * 1.2f;
        if (text_scale < 0.8f) text_scale = 0.8f;
        if (text_scale > 3.0f) text_scale = 3.0f;
    }
    
    // Render title - moved higher to center in bigger area
    renderKeyboardText(osk.title.c_str(), kb_x, kb_y - 75, white_color, text_scale);
    
    // Render input text - moved higher to center in bigger area
    std::string display_text = osk.input_text;
    if (osk.mode == OSK_MODE_PASSWORD) {
        display_text = std::string(osk.input_text.length(), '*');
    }
    renderKeyboardText(display_text.c_str(), kb_x + 5, kb_y - 30, black_color, text_scale);
    
    return 0;
}

// Handle keyboard input/navigation
static int lua_update(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    if (!osk.active) {
        return 0;
    }
    
    uint32_t pad = luaL_checkinteger(L, 1);
    
    // Navigation constants (matching SDL controls used in luaControls.cpp)
    const uint32_t SCE_CTRL_UP = 0x00000001;
    const uint32_t SCE_CTRL_DOWN = 0x00000002;
    const uint32_t SCE_CTRL_LEFT = 0x00000004;
    const uint32_t SCE_CTRL_RIGHT = 0x00000008;
    const uint32_t SCE_CTRL_CROSS = 0x00000010;
    const uint32_t SCE_CTRL_CIRCLE = 0x00000020;
    const uint32_t SCE_CTRL_TRIANGLE = 0x00000080;
    
    auto& current_layout = (osk.shift_mode || osk.caps_lock) ? osk.shift_layout : osk.layout;
    
    // Navigation
    if (pad & SCE_CTRL_UP) {
        osk.cursor_y = (osk.cursor_y - 1 + current_layout.size()) % current_layout.size();
        if (osk.cursor_x >= current_layout[osk.cursor_y].size()) {
            osk.cursor_x = current_layout[osk.cursor_y].size() - 1;
        }
    }
    if (pad & SCE_CTRL_DOWN) {
        osk.cursor_y = (osk.cursor_y + 1) % current_layout.size();
        if (osk.cursor_x >= current_layout[osk.cursor_y].size()) {
            osk.cursor_x = current_layout[osk.cursor_y].size() - 1;
        }
    }
    if (pad & SCE_CTRL_LEFT) {
        osk.cursor_x = (osk.cursor_x - 1 + current_layout[osk.cursor_y].size()) % current_layout[osk.cursor_y].size();
    }
    if (pad & SCE_CTRL_RIGHT) {
        osk.cursor_x = (osk.cursor_x + 1) % current_layout[osk.cursor_y].size();
    }
    
    // Key activation
    if (pad & SCE_CTRL_CROSS) {
        std::string key = current_layout[osk.cursor_y][osk.cursor_x];
        
        if (key == "ENTER" || key == "OK") {
            osk.state = OSK_STATE_FINISHED;
            osk.active = false;
        } else if (key == "CANCEL") {
            osk.state = OSK_STATE_CANCELED;
            osk.active = false;
        } else if (key == "CLEAR") {
            osk.input_text.clear();
        } else if (key == "DEL") {
            if (!osk.input_text.empty()) {
                osk.input_text.pop_back();
            }
        } else if (key == "SPACE") {
            if (osk.input_text.length() < osk.max_length) {
                osk.input_text += " ";
            }
        } else if (key == "SHIFT") {
            osk.shift_mode = !osk.shift_mode;
        } else if (key.length() == 1) {
            // Regular character
            if (osk.input_text.length() < osk.max_length) {
                osk.input_text += key;
                // Auto-disable shift after character input (except caps lock)
                if (osk.shift_mode && !osk.caps_lock) {
                    osk.shift_mode = false;
                }
            }
        }
    }
    
    // Toggle caps lock with triangle
    if (pad & SCE_CTRL_TRIANGLE) {
        osk.caps_lock = !osk.caps_lock;
        if (osk.caps_lock) {
            osk.shift_mode = false;
        }
    }
    
    // Cancel with circle
    if (pad & SCE_CTRL_CIRCLE) {
        osk.state = OSK_STATE_CANCELED;
        osk.active = false;
    }
    
    return 0;
}

// Check if keyboard is active
static int lua_isActive(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    lua_pushboolean(L, osk.active);
    return 1;
}


//Register our Keyboard Functions
static const luaL_Reg Keyboard_functions[] = {
    {"start",     lua_setup},
    {"show",      lua_setup},  // Backward compatibility alias for Vita scripts
    {"getState",  lua_state},
    {"getInput",  lua_input},
    {"clear",     lua_clear},
    {"draw",      lua_draw},
    {"getLayout", lua_getLayout},
    {"update",    lua_update},
    {"isActive",  lua_isActive},
    {0, 0}
};

void luaKeyboard_init(lua_State *L) {
    // Initialize keyboard state
    osk.active = false;
    osk.state = OSK_STATE_NONE;
    osk.input_text.clear();
    osk.title.clear();
    osk.cursor_x = 0;
    osk.cursor_y = 0;
    osk.shift_mode = false;
    osk.caps_lock = false;
    
    lua_newtable(L);
    luaL_setfuncs(L, Keyboard_functions, 0);
    lua_setglobal(L, "Keyboard");
    
    // Register constants
    uint8_t MODE_TEXT = OSK_MODE_TEXT;
    uint8_t MODE_PASSWORD = OSK_MODE_PASSWORD;
    uint8_t TYPE_DEFAULT = OSK_TYPE_DEFAULT;
    uint8_t TYPE_LATIN = OSK_TYPE_LATIN;
    uint8_t TYPE_NUMBER = OSK_TYPE_NUMBER;
    uint8_t TYPE_EXT_NUMBER = OSK_TYPE_EXT_NUMBER;
    uint8_t RUNNING = OSK_STATE_RUNNING;
    uint8_t FINISHED = OSK_STATE_FINISHED;
    uint8_t CANCELED = OSK_STATE_CANCELED;
    uint8_t OPT_MULTILINE = OSK_OPT_MULTILINE;
    uint8_t OPT_NO_AUTOCAP = OSK_OPT_NO_AUTOCAP;
    uint8_t OPT_NO_ASSISTANCE = OSK_OPT_NO_ASSISTANCE;
    
    VariableRegister(L, MODE_TEXT);
    VariableRegister(L, MODE_PASSWORD);
    VariableRegister(L, TYPE_DEFAULT);
    VariableRegister(L, TYPE_LATIN);
    VariableRegister(L, TYPE_NUMBER);
    VariableRegister(L, TYPE_EXT_NUMBER);
    VariableRegister(L, RUNNING);
    VariableRegister(L, FINISHED);
    VariableRegister(L, CANCELED);
    VariableRegister(L, OPT_MULTILINE);
    VariableRegister(L, OPT_NO_AUTOCAP);
    VariableRegister(L, OPT_NO_ASSISTANCE);
}