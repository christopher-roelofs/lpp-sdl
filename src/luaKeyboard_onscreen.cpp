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
    
    // Color settings
    SDL_Color bg_color;
    SDL_Color font_color;
    SDL_Color selected_bg_color;
    SDL_Color selected_font_color;
    SDL_Color key_bg_color;
    SDL_Color shift_key_color;
    SDL_Color title_bar_color;
    SDL_Color input_bg_color;
    SDL_Color input_border_color;
    SDL_Color input_text_color;
    SDL_Color keyboard_border_color;
    SDL_Color key_border_color;
    
    // Font settings
    TTF_Font* font;  // Custom font for keyboard (NULL = use default)
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
    // Use keyboard font if set, otherwise use default font
    TTF_Font* font_to_use = osk.font ? osk.font : g_defaultFont;
    if (!font_to_use || !g_renderer || !text || strlen(text) == 0) return;
    
    SDL_Surface* text_surface = TTF_RenderText_Blended(font_to_use, text, color);
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
            screen_width = SCREEN_WIDTH;
            screen_height = SCREEN_HEIGHT;
        } else {
            // In native mode, use logical coordinate system (not physical window size)
            screen_width = NATIVE_LOGICAL_WIDTH;
            screen_height = NATIVE_LOGICAL_HEIGHT;
        }
        
        // Keyboard area - scale with screen size but ensure it fits on screen
        int kb_width = (int)(screen_width * 0.85);  // 85% of screen width for better margins
        int kb_height = (int)(screen_height * 0.45); // 45% of screen height to leave room for title/input
        int kb_x = (screen_width - kb_width) / 2;   // Center horizontally
        
        // Calculate total needed height including title bar and input area
        int title_height = 30;
        int input_height = 30;
        int margin = 10;
        int total_height = title_height + input_height + kb_height + (margin * 2);
        
        // Ensure keyboard doesn't go off screen - adjust position if needed
        int kb_y = screen_height - total_height - 20; // 20px margin from bottom
        if (kb_y < 20) { // If too high, adjust size
            kb_y = 20;
            total_height = screen_height - 40;
            kb_height = total_height - title_height - input_height - (margin * 2);
        }
        
        // Title area
        SDL_SetRenderDrawColor(g_renderer, osk.title_bar_color.r, osk.title_bar_color.g, osk.title_bar_color.b, osk.title_bar_color.a);
        SDL_Rect title_rect = {kb_x, kb_y, kb_width, title_height};
        SDL_RenderFillRect(g_renderer, &title_rect);
        
        // Input text area
        int input_y = kb_y + title_height + margin;
        SDL_SetRenderDrawColor(g_renderer, osk.input_bg_color.r, osk.input_bg_color.g, osk.input_bg_color.b, osk.input_bg_color.a);
        SDL_Rect input_rect = {kb_x, input_y, kb_width, input_height};
        SDL_RenderFillRect(g_renderer, &input_rect);
        SDL_SetRenderDrawColor(g_renderer, osk.input_border_color.r, osk.input_border_color.g, osk.input_border_color.b, osk.input_border_color.a);
        SDL_RenderDrawRect(g_renderer, &input_rect);
        
        // Keyboard background
        int keys_y = input_y + input_height + margin;
        SDL_SetRenderDrawColor(g_renderer, osk.bg_color.r, osk.bg_color.g, osk.bg_color.b, osk.bg_color.a);
        SDL_Rect bg_rect = {kb_x, keys_y, kb_width, kb_height};
        SDL_RenderFillRect(g_renderer, &bg_rect);
        
        // Border around entire keyboard area
        SDL_SetRenderDrawColor(g_renderer, osk.keyboard_border_color.r, osk.keyboard_border_color.g, osk.keyboard_border_color.b, osk.keyboard_border_color.a);
        SDL_Rect border_rect = {kb_x - 2, kb_y - 2, kb_width + 4, total_height + 4};
        SDL_RenderDrawRect(g_renderer, &border_rect);
        
        // Draw keyboard keys
        auto& current_layout = (osk.shift_mode || osk.caps_lock) ? osk.shift_layout : osk.layout;
        int key_h = kb_height / 5;
        
        for (int row = 0; row < current_layout.size(); row++) {
            // Calculate key width dynamically for each row to use available space
            int keys_in_row = current_layout[row].size();
            int gap_size = 5; // Space between keys
            int total_gap_space = (keys_in_row - 1) * gap_size;
            int available_width = kb_width - total_gap_space;
            int key_w = available_width / keys_in_row;
            
            // Center the row horizontally
            int row_total_width = (key_w * keys_in_row) + total_gap_space;
            int row_start_x = kb_x + (kb_width - row_total_width) / 2;
            
            for (int col = 0; col < current_layout[row].size(); col++) {
                int key_x = row_start_x + (col * (key_w + gap_size));
                int key_y = keys_y + (row * key_h);
                
                // Key background
                bool is_selected = (row == osk.cursor_y && col == osk.cursor_x);
                if (is_selected) {
                    SDL_SetRenderDrawColor(g_renderer, osk.selected_bg_color.r, osk.selected_bg_color.g, osk.selected_bg_color.b, osk.selected_bg_color.a);
                } else if (current_layout[row][col] == "SHIFT" && (osk.shift_mode || osk.caps_lock)) {
                    SDL_SetRenderDrawColor(g_renderer, osk.shift_key_color.r, osk.shift_key_color.g, osk.shift_key_color.b, osk.shift_key_color.a);
                } else {
                    SDL_SetRenderDrawColor(g_renderer, osk.key_bg_color.r, osk.key_bg_color.g, osk.key_bg_color.b, osk.key_bg_color.a);
                }
                
                SDL_Rect key_rect = {key_x + 1, key_y + 1, key_w - 3, key_h - 3};
                SDL_RenderFillRect(g_renderer, &key_rect);
                
                // Key border
                SDL_SetRenderDrawColor(g_renderer, osk.key_border_color.r, osk.key_border_color.g, osk.key_border_color.b, osk.key_border_color.a);
                SDL_RenderDrawRect(g_renderer, &key_rect);
            }
        }
        
        // Render keyboard text
        SDL_Color selected_color = osk.selected_font_color;
        
        // Calculate text scale based on screen size - increased for better visibility
        float text_scale;
        if (g_vita_compat_mode) {
            // In vitacompat mode, use fixed scale for Vita resolution
            text_scale = 1.2f;
        } else {
            // In native mode, scale relative to logical resolution difference
            text_scale = (float)NATIVE_LOGICAL_WIDTH / (float)SCREEN_WIDTH * 1.2f; // Scale relative to logical coordinate difference (~1.6f)
        }
        
        // Render key text
        for (int row = 0; row < current_layout.size(); row++) {
            // Calculate key width dynamically for each row (same as above)
            int keys_in_row = current_layout[row].size();
            int gap_size = 5;
            int total_gap_space = (keys_in_row - 1) * gap_size;
            int available_width = kb_width - total_gap_space;
            int key_w = available_width / keys_in_row;
            int row_total_width = (key_w * keys_in_row) + total_gap_space;
            int row_start_x = kb_x + (kb_width - row_total_width) / 2;
            
            for (int col = 0; col < current_layout[row].size(); col++) {
                std::string key_text = current_layout[row][col];
                int key_x = row_start_x + (col * (key_w + gap_size));
                int key_y = keys_y + (row * key_h);
                
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
                SDL_Color text_color = is_selected ? selected_color : osk.font_color;
                
                renderKeyboardText(key_text.c_str(), text_x, text_y, text_color, key_text_scale);
            }
        }
        
        // Render title - positioned near top of area 
        renderKeyboardText(osk.title.c_str(), kb_x + 5, kb_y + 1, osk.font_color, text_scale);
        
        // Render input text - positioned near top of area
        std::string display_text = osk.input_text;
        if (osk.mode == OSK_MODE_PASSWORD) {
            // Show asterisks for password mode
            display_text = std::string(osk.input_text.length(), '*');
        }
        renderKeyboardText(display_text.c_str(), kb_x + 5, input_y + 1, osk.input_text_color, text_scale);
        
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
        screen_width = SCREEN_WIDTH;
        screen_height = SCREEN_HEIGHT;
    } else {
        // In native mode, use logical coordinate system (not physical window size)
        screen_width = NATIVE_LOGICAL_WIDTH;
        screen_height = NATIVE_LOGICAL_HEIGHT;
    }
    
    // Draw keyboard background - scale with screen size but ensure it fits on screen
    int kb_width = (int)(screen_width * 0.85);  // 85% of screen width for better margins
    int kb_height = (int)(screen_height * 0.45); // 45% of screen height to leave room for title/input
    int kb_x = (screen_width - kb_width) / 2;   // Center horizontally
    
    // Calculate total needed height including title bar and input area
    int title_height = 30;
    int input_height = 30;
    int margin = 10;
    int total_height = title_height + input_height + kb_height + (margin * 2);
    
    // Ensure keyboard doesn't go off screen - adjust position if needed
    int kb_y = screen_height - total_height - 20; // 20px margin from bottom
    if (kb_y < 20) { // If too high, adjust size
        kb_y = 20;
        total_height = screen_height - 40;
        kb_height = total_height - title_height - input_height - (margin * 2);
    }
    
    // Title area
    SDL_SetRenderDrawColor(g_renderer, osk.title_bar_color.r, osk.title_bar_color.g, osk.title_bar_color.b, osk.title_bar_color.a);
    SDL_Rect title_rect = {kb_x, kb_y, kb_width, title_height};
    SDL_RenderFillRect(g_renderer, &title_rect);
    
    // Input text area
    int input_y = kb_y + title_height + margin;
    SDL_SetRenderDrawColor(g_renderer, osk.input_bg_color.r, osk.input_bg_color.g, osk.input_bg_color.b, osk.input_bg_color.a);
    SDL_Rect input_rect = {kb_x, input_y, kb_width, input_height};
    SDL_RenderFillRect(g_renderer, &input_rect);
    SDL_SetRenderDrawColor(g_renderer, osk.input_border_color.r, osk.input_border_color.g, osk.input_border_color.b, osk.input_border_color.a);
    SDL_RenderDrawRect(g_renderer, &input_rect);
    
    // Keyboard background
    int keys_y = input_y + input_height + margin;
    SDL_SetRenderDrawColor(g_renderer, osk.bg_color.r, osk.bg_color.g, osk.bg_color.b, 200);
    SDL_Rect bg_rect = {kb_x, keys_y, kb_width, kb_height};
    SDL_RenderFillRect(g_renderer, &bg_rect);
    
    // Border around entire keyboard area
    SDL_SetRenderDrawColor(g_renderer, osk.keyboard_border_color.r, osk.keyboard_border_color.g, osk.keyboard_border_color.b, osk.keyboard_border_color.a);
    SDL_Rect border_rect = {kb_x - 2, kb_y - 2, kb_width + 4, total_height + 4};
    SDL_RenderDrawRect(g_renderer, &border_rect);
    
    // Add text rendering to draw function as well
    
    // Calculate text scale based on screen size - increased for better visibility
    float text_scale;
    if (g_vita_compat_mode) {
        // In vitacompat mode, use fixed scale for Vita resolution
        text_scale = 1.2f;
    } else {
        // In native mode, scale relative to logical resolution difference
        text_scale = (float)NATIVE_LOGICAL_WIDTH / (float)SCREEN_WIDTH * 1.2f; // Scale relative to logical coordinate difference (~1.6f)
    }
    
    // Render title - positioned near top of area
    renderKeyboardText(osk.title.c_str(), kb_x + 5, kb_y + 1, osk.font_color, text_scale);
    
    // Render input text - positioned near top of area
    std::string display_text = osk.input_text;
    if (osk.mode == OSK_MODE_PASSWORD) {
        display_text = std::string(osk.input_text.length(), '*');
    }
    renderKeyboardText(display_text.c_str(), kb_x + 5, input_y + 1, osk.input_text_color, text_scale);
    
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

// Helper function to extract color from Lua Color object or integer
SDL_Color extractColor(lua_State *L, int index) {
    SDL_Color color = {255, 255, 255, 255}; // Default white
    
    if (lua_isnumber(L, index)) {
        // Handle integer color from Color.new(r, g, b, a)
        // Color.new packs as: r | (g << 8) | (b << 16) | (a << 24)
        uint32_t packed_color = (uint32_t)lua_tonumber(L, index);
        color.r = packed_color & 0xFF;
        color.g = (packed_color >> 8) & 0xFF;
        color.b = (packed_color >> 16) & 0xFF;
        color.a = (packed_color >> 24) & 0xFF;
    }
    
    return color;
}

// Set keyboard background color
static int lua_setBackgroundColor(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.bg_color = extractColor(L, 1);
    return 0;
}

// Set keyboard font color
static int lua_setFontColor(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.font_color = extractColor(L, 1);
    return 0;
}

// Set selected key background color
static int lua_setSelectedBackgroundColor(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.selected_bg_color = extractColor(L, 1);
    return 0;
}

// Set selected key font color
static int lua_setSelectedFontColor(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.selected_font_color = extractColor(L, 1);
    return 0;
}

// Set normal key background color
static int lua_setKeyBackgroundColor(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.key_bg_color = extractColor(L, 1);
    return 0;
}

// Set shift key color
static int lua_setShiftKeyColor(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.shift_key_color = extractColor(L, 1);
    return 0;
}

// Set title bar color
static int lua_setTitleBarColor(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.title_bar_color = extractColor(L, 1);
    return 0;
}

// Set input area background color
static int lua_setInputBackgroundColor(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.input_bg_color = extractColor(L, 1);
    return 0;
}

// Set input area border color
static int lua_setInputBorderColor(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.input_border_color = extractColor(L, 1);
    return 0;
}

// Set input text color
static int lua_setInputTextColor(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.input_text_color = extractColor(L, 1);
    return 0;
}

// Set keyboard border color
static int lua_setKeyboardBorderColor(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.keyboard_border_color = extractColor(L, 1);
    return 0;
}

// Set key border color
static int lua_setKeyBorderColor(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    osk.key_border_color = extractColor(L, 1);
    return 0;
}

// Set keyboard font
static int lua_setFont(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc < 1 || argc > 2) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    const char* font_path = luaL_checkstring(L, 1);
    int font_size = (argc == 2) ? luaL_checkinteger(L, 2) : 16; // Default size 16
    
    // Close existing custom font if any
    if (osk.font && osk.font != g_defaultFont) {
        TTF_CloseFont(osk.font);
        osk.font = NULL;
    }
    
    // Load new font
    if (font_path && strlen(font_path) > 0) {
        osk.font = TTF_OpenFont(font_path, font_size);
        if (!osk.font) {
            return luaL_error(L, "Failed to load font: %s", TTF_GetError());
        }
    } else {
        // Empty string or NULL resets to default font
        osk.font = NULL;
    }
    
    return 0;
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
    {"setBackgroundColor", lua_setBackgroundColor},
    {"setFontColor", lua_setFontColor},
    {"setSelectedBackgroundColor", lua_setSelectedBackgroundColor},
    {"setSelectedFontColor", lua_setSelectedFontColor},
    {"setKeyBackgroundColor", lua_setKeyBackgroundColor},
    {"setShiftKeyColor", lua_setShiftKeyColor},
    {"setTitleBarColor", lua_setTitleBarColor},
    {"setInputBackgroundColor", lua_setInputBackgroundColor},
    {"setInputBorderColor", lua_setInputBorderColor},
    {"setInputTextColor", lua_setInputTextColor},
    {"setKeyboardBorderColor", lua_setKeyboardBorderColor},
    {"setKeyBorderColor", lua_setKeyBorderColor},
    {"setFont", lua_setFont},
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
    
    // Initialize default colors (matching original hardcoded values)
    osk.bg_color = {40, 40, 40, 220};              // Background color
    osk.font_color = {255, 255, 255, 255};         // Font color (white)
    osk.selected_bg_color = {100, 150, 200, 255};  // Selected key background
    osk.selected_font_color = {255, 255, 0, 255};  // Selected key font (yellow)
    osk.key_bg_color = {80, 80, 80, 255};          // Normal key background
    osk.shift_key_color = {150, 100, 100, 255};    // Active shift key color
    osk.title_bar_color = {60, 60, 60, 255};       // Title bar color
    osk.input_bg_color = {255, 255, 255, 255};     // Input background (white)
    osk.input_border_color = {0, 0, 0, 255};       // Input border (black)
    osk.input_text_color = {0, 0, 0, 255};         // Input text (black)
    osk.keyboard_border_color = {100, 100, 100, 255}; // Main border (gray)
    osk.key_border_color = {120, 120, 120, 255};   // Key borders (light gray)
    
    // Initialize font
    osk.font = NULL;  // Use default font initially
    
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