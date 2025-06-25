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

#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <cstring>
#include <SDL.h>
#include "luaplayer.h"
#include "include/sdl_renderer.h"

#define stringify(str) #str
#define VariableRegister(lua, value) do { lua_pushinteger(lua, value); lua_setglobal (lua, stringify(value)); } while(0)

// Simple keyboard key constants - just use the SDL scancode values directly
static SDL_GameController* controllers[4] = {NULL, NULL, NULL, NULL};
static Sint16 left_analog_x = 0, left_analog_y = 0;
static Sint16 right_analog_x = 0, right_analog_y = 0;
static int mouse_x = 0, mouse_y = 0;
static bool mouse_pressed = false;
static bool current_mouse_pressed = false;
static bool previous_mouse_pressed = false;
static const Uint8* keyboard_state = NULL;

// Store current and previous keyboard state for edge detection
static bool current_keys[SDL_NUM_SCANCODES] = {false};
static bool previous_keys[SDL_NUM_SCANCODES] = {false};
static int frame_counter = 0;

static void update_input_state() {
    // Pump events to update keyboard state
    SDL_PumpEvents();
    
    // Update keyboard state
    keyboard_state = SDL_GetKeyboardState(NULL);
    
    // Update controller state if available
    if (controllers[0] && SDL_GameControllerGetAttached(controllers[0])) {
        // Read analog sticks
        left_analog_x = SDL_GameControllerGetAxis(controllers[0], SDL_CONTROLLER_AXIS_LEFTX);
        left_analog_y = SDL_GameControllerGetAxis(controllers[0], SDL_CONTROLLER_AXIS_LEFTY);
        right_analog_x = SDL_GameControllerGetAxis(controllers[0], SDL_CONTROLLER_AXIS_RIGHTX);
        right_analog_y = SDL_GameControllerGetAxis(controllers[0], SDL_CONTROLLER_AXIS_RIGHTY);
    }
    
    // Update mouse state
    Uint32 mouse_state = SDL_GetMouseState(&mouse_x, &mouse_y);
    mouse_pressed = (mouse_state & SDL_BUTTON_LMASK) != 0;
    
}

static int lua_readC(lua_State *L){
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0 && argc != 1) return luaL_error(L, "wrong number of arguments.");
#endif
    int port = 0;
    if (argc == 1){
        port = luaL_checkinteger(L, 1);
#ifndef SKIP_ERROR_HANDLING
        if (port > 3) return luaL_error(L, "wrong port number.");
#endif
    }
    
    // Copy current keys to previous keys
    memcpy(previous_keys, current_keys, sizeof(current_keys));
    
    // Copy current mouse state to previous mouse state
    previous_mouse_pressed = current_mouse_pressed;
    
    update_input_state();
    
    // Update current keys from SDL keyboard state
    if (keyboard_state) {
        for (int i = 0; i < SDL_NUM_SCANCODES; i++) {
            current_keys[i] = keyboard_state[i] != 0;
        }
    }
    
    // Update current mouse state
    current_mouse_pressed = mouse_pressed;
    
    // Return frame counter for edge detection (different value each frame)
    frame_counter++;
    lua_pushnumber(L, frame_counter);
    return 1;
}

static int lua_readleft(lua_State *L){
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0 && argc != 1) return luaL_error(L, "wrong number of arguments.");
#endif
    int port = 0;
    if (argc == 1){
        port = luaL_checkinteger(L, 1);
#ifndef SKIP_ERROR_HANDLING
        if (port > 3) return luaL_error(L, "wrong port number.");
#endif
    }
    update_input_state();
    lua_pushinteger(L, left_analog_x / 256);
    lua_pushinteger(L, left_analog_y / 256);
    return 2;
}

static int lua_readright(lua_State *L){
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0 && argc != 1) return luaL_error(L, "wrong number of arguments.");
#endif
    int port = 0;
    if (argc == 1){
        port = luaL_checkinteger(L, 1);
#ifndef SKIP_ERROR_HANDLING
        if (port > 3) return luaL_error(L, "wrong port number.");
#endif
    }
    update_input_state();
    lua_pushinteger(L, right_analog_x / 256);
    lua_pushinteger(L, right_analog_y / 256);
    return 2;
}

static int lua_check(lua_State *L){
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 2) return luaL_error(L, "wrong number of arguments.");
#endif
    int pad = luaL_checkinteger(L, 1);  // Frame counter from Controls.read()
    int scancode = luaL_checkinteger(L, 2);
    
    // Check if the scancode key is pressed
    bool is_pressed = false;
    if (scancode == 1000) { // KEY_TOUCH special case
        // For touch, use frame-based state like keyboard keys
        if (pad == frame_counter) {
            is_pressed = current_mouse_pressed;
        } else if (pad == frame_counter - 1) {
            is_pressed = previous_mouse_pressed;
        }
        // For any other frame, return false (not pressed)
    } else if (scancode >= 0 && scancode < SDL_NUM_SCANCODES) {
        // If this is the current frame (pad == frame_counter), use current_keys
        // If this is the previous frame (pad == frame_counter - 1), use previous_keys
        if (pad == frame_counter) {
            is_pressed = current_keys[scancode];
        } else if (pad == frame_counter - 1) {
            is_pressed = previous_keys[scancode];
        }
        // For any other frame, return false (key not pressed)
    }
    
    lua_pushboolean(L, is_pressed);
    return 1;
}

// Mimic the Vita lerp function for coordinate transformation
#define lerp(value, from_max, to_max) ((((value*10) * (to_max*10))/(from_max*10))/10)

static int lua_touchpad(lua_State *L){
    int argc = lua_gettop(L);
    if (argc != 0) return luaL_error(L, "wrong number of arguments.");
    update_input_state();
    if (mouse_pressed) {
        int logical_x = mouse_x;
        int logical_y = mouse_y;
        
        if (g_renderer) {
            int logical_w, logical_h;
            int window_w, window_h;
            
            // Check if we're in 3DS dual screen mode with manual scaling
            extern bool g_dual_screen_mode;
            extern bool g_vita_compat_mode;
            
            // Get logical and window sizes for coordinate transformation
            SDL_RenderGetLogicalSize(g_renderer, &logical_w, &logical_h);
            SDL_GetWindowSize(g_window, &window_w, &window_h);
            
            // Transform from window coordinates to logical coordinates
            if (logical_w > 0 && logical_h > 0 && window_w > 0 && window_h > 0) {
                logical_x = lerp(mouse_x, window_w, logical_w);
                logical_y = lerp(mouse_y, window_h, logical_h);
                
                // For 3DS dual-screen mode, convert to bottom screen coordinates
                if (g_dual_screen_mode && g_vita_compat_mode) {
                    extern lpp_3ds_orientation_t g_3ds_orientation;
                    extern int getScreenXOffset(int screen_id);
                    extern int getScreenYOffset(int screen_id);
                    
                    // Check if the click is on the bottom screen and convert to local coordinates
                    int bottom_x_offset = getScreenXOffset(1); // BOTTOM_SCREEN
                    int bottom_y_offset = getScreenYOffset(1);
                    
                    if (logical_x >= bottom_x_offset && logical_y >= bottom_y_offset) {
                        // Click is on bottom screen area - convert to local bottom screen coordinates
                        logical_x = logical_x - bottom_x_offset;
                        logical_y = logical_y - bottom_y_offset;
                        
                        // Clamp to bottom screen dimensions
                        if (logical_x > 320) logical_x = 320;
                        if (logical_y > 240) logical_y = 240;
                    } else {
                        // Click is not on bottom screen area - report no touch
                        logical_x = -1;
                        logical_y = -1;
                    }
                }
            }
        }
        
        lua_pushinteger(L, logical_x);
        lua_pushinteger(L, logical_y);
        return 2;
    }
    return 0;
}

static int lua_rumble(lua_State *L){
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 3) return luaL_error(L, "wrong number of arguments.");
#endif
    int port = luaL_checkinteger(L, 1);
#ifndef SKIP_ERROR_HANDLING
    if (port > 3) return luaL_error(L, "wrong port number.");
#endif
    uint8_t int_small = luaL_checkinteger(L, 2);
    uint8_t int_large = luaL_checkinteger(L, 3);
    
    if (controllers[port] && SDL_GameControllerGetAttached(controllers[port])) {
        SDL_GameControllerRumble(controllers[port], int_large * 256, int_small * 256, 1000);
    }
    return 0;
}

static int lua_lightbar(lua_State *L){
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 2) return luaL_error(L, "wrong number of arguments.");
#endif
    int port = luaL_checkinteger(L, 1);
#ifndef SKIP_ERROR_HANDLING
    if (port > 3) return luaL_error(L, "wrong port number.");
#endif
    uint32_t color = luaL_checkinteger(L, 2);
    
    if (controllers[port] && SDL_GameControllerGetAttached(controllers[port])) {
        SDL_GameControllerSetLED(controllers[port], color & 0xFF, (color>>8) & 0xFF, (color>>16) & 0xFF);
    }
    return 0;
}

static int lua_touchpad2(lua_State *L){
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0) return luaL_error(L, "wrong number of arguments.");
#endif
    return 0;
}

static int lua_lock(lua_State *L){
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0) return luaL_error(L, "wrong number of arguments.");
#endif
    return 0;
}

static int lua_unlock(lua_State *L){
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0) return luaL_error(L, "wrong number of arguments.");
#endif
    return 0;
}

static int lua_gettype(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
    lua_newtable(L);
    for (int i = 1; i <= 4; i++) {
        lua_pushnumber(L, i);
        lua_newtable(L);
        lua_pushstring(L, "type");
        if (controllers[i-1] && SDL_GameControllerGetAttached(controllers[i-1])) {
            lua_pushinteger(L, 1);
        } else {
            lua_pushinteger(L, 0);
        }
        lua_settable(L, -3);
        lua_settable(L, -3);
    }
    return 1;
}

static int lua_headset(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
    lua_pushboolean(L, false);
    return 1;
}

static int lua_accel(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
    lua_pushnumber(L, 0.0);
    lua_pushnumber(L, 0.0);
    lua_pushnumber(L, 0.0);
    return 3;
}

static int lua_gyro(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
    lua_pushnumber(L, 0.0);
    lua_pushnumber(L, 0.0);
    lua_pushnumber(L, 0.0);
    return 3;
}

static int lua_enablesensors(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
    return 0;
}

static int lua_disablesensors(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
    return 0;
}

static int lua_getenter(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
    lua_pushinteger(L, SDL_SCANCODE_RETURN);
    return 1;
}

static int lua_init(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
    return 0;
}

static const luaL_Reg Controls_functions[] = {
  {"read",             lua_readC},    
  {"readLeftAnalog",   lua_readleft},      
  {"readRightAnalog",  lua_readright},    
  {"rumble",           lua_rumble},
  {"setLightbar",      lua_lightbar},
  {"check",            lua_check},    
  {"readTouch",        lua_touchpad},    
  {"readRetroTouch",   lua_touchpad2},    
  {"lockHomeButton",   lua_lock},    
  {"unlockHomeButton", lua_unlock},    
  {"getDeviceInfo",    lua_gettype},
  {"headsetStatus",    lua_headset},
  {"readAccel",        lua_accel},
  {"readGyro",         lua_gyro},
  {"enableGyro",       lua_enablesensors},    
  {"enableAccel",      lua_enablesensors},    
  {"disableGyro",      lua_disablesensors},    
  {"disableAccel",     lua_disablesensors},
  {"getEnterButton",   lua_getenter},
  {"init",             lua_init}, 
  {0, 0}
};

// Functions for main loop to update keyboard state
extern "C" void sdl_key_down(int scancode) {
    if (scancode >= 0 && scancode < SDL_NUM_SCANCODES) {
        current_keys[scancode] = true;
    }
}

extern "C" void sdl_key_up(int scancode) {
    if (scancode >= 0 && scancode < SDL_NUM_SCANCODES) {
        current_keys[scancode] = false;
    }
}

// External function for updating SDL controls state
extern "C" void update_sdl_controls() {
    update_input_state();
}

// External functions for mouse button event handling
extern "C" void sdl_mouse_button_down() {
    mouse_pressed = true;
}

extern "C" void sdl_mouse_button_up() {
    mouse_pressed = false;
}

void luaControls_init(lua_State *L) {
    lua_newtable(L);
    luaL_setfuncs(L, Controls_functions, 0);
    lua_setglobal(L, "Controls");
    
    // Add 3DS key constants (mapped to SDL scancodes)
    lua_pushinteger(L, SDL_SCANCODE_RETURN);lua_setglobal(L, "KEY_A");
    lua_pushinteger(L, SDL_SCANCODE_BACKSPACE);lua_setglobal(L, "KEY_B");
    lua_pushinteger(L, SDL_SCANCODE_SPACE);lua_setglobal(L, "KEY_X");
    lua_pushinteger(L, SDL_SCANCODE_LSHIFT);lua_setglobal(L, "KEY_Y");
    lua_pushinteger(L, SDL_SCANCODE_PAGEUP);lua_setglobal(L, "KEY_L");
    lua_pushinteger(L, SDL_SCANCODE_PAGEDOWN);lua_setglobal(L, "KEY_R");
    lua_pushinteger(L, SDL_SCANCODE_TAB);lua_setglobal(L, "KEY_START");
    lua_pushinteger(L, SDL_SCANCODE_LCTRL);lua_setglobal(L, "KEY_SELECT");
    lua_pushinteger(L, SDL_SCANCODE_UP);lua_setglobal(L, "KEY_DUP");
    lua_pushinteger(L, SDL_SCANCODE_DOWN);lua_setglobal(L, "KEY_DDOWN");
    lua_pushinteger(L, SDL_SCANCODE_LEFT);lua_setglobal(L, "KEY_DLEFT");
    lua_pushinteger(L, SDL_SCANCODE_RIGHT);lua_setglobal(L, "KEY_DRIGHT");
    
    // Touch support using left mouse button (special constant outside SDL scancode range)
    lua_pushinteger(L, 1000);lua_setglobal(L, "KEY_TOUCH");
    
    // Initialize game controllers
    for (int i = 0; i < 4; i++) {
        if (SDL_IsGameController(i)) {
            controllers[i] = SDL_GameControllerOpen(i);
        }
    }
    
    // Register device types
    uint8_t UNPAIRED_DEV = 0;
    uint8_t VITA_DEV = 1;
    uint8_t VIRTUAL_DEV = 2;
    uint8_t DS3_DEV = 4;
    uint8_t DS4_DEV = 8;
    VariableRegister(L,UNPAIRED_DEV);
    VariableRegister(L,VITA_DEV);
    VariableRegister(L,VIRTUAL_DEV);
    VariableRegister(L,DS3_DEV);
    VariableRegister(L,DS4_DEV);
    
    // Register SDL scancode constants with SDLK_ names
    lua_pushinteger(L, SDL_SCANCODE_A); lua_setglobal(L, "SDLK_A");
    lua_pushinteger(L, SDL_SCANCODE_B); lua_setglobal(L, "SDLK_B");
    lua_pushinteger(L, SDL_SCANCODE_C); lua_setglobal(L, "SDLK_C");
    lua_pushinteger(L, SDL_SCANCODE_D); lua_setglobal(L, "SDLK_D");
    lua_pushinteger(L, SDL_SCANCODE_E); lua_setglobal(L, "SDLK_E");
    lua_pushinteger(L, SDL_SCANCODE_F); lua_setglobal(L, "SDLK_F");
    lua_pushinteger(L, SDL_SCANCODE_G); lua_setglobal(L, "SDLK_G");
    lua_pushinteger(L, SDL_SCANCODE_H); lua_setglobal(L, "SDLK_H");
    lua_pushinteger(L, SDL_SCANCODE_I); lua_setglobal(L, "SDLK_I");
    lua_pushinteger(L, SDL_SCANCODE_J); lua_setglobal(L, "SDLK_J");
    lua_pushinteger(L, SDL_SCANCODE_K); lua_setglobal(L, "SDLK_K");
    lua_pushinteger(L, SDL_SCANCODE_L); lua_setglobal(L, "SDLK_L");
    lua_pushinteger(L, SDL_SCANCODE_M); lua_setglobal(L, "SDLK_M");
    lua_pushinteger(L, SDL_SCANCODE_N); lua_setglobal(L, "SDLK_N");
    lua_pushinteger(L, SDL_SCANCODE_O); lua_setglobal(L, "SDLK_O");
    lua_pushinteger(L, SDL_SCANCODE_P); lua_setglobal(L, "SDLK_P");
    lua_pushinteger(L, SDL_SCANCODE_Q); lua_setglobal(L, "SDLK_Q");
    lua_pushinteger(L, SDL_SCANCODE_R); lua_setglobal(L, "SDLK_R");
    lua_pushinteger(L, SDL_SCANCODE_S); lua_setglobal(L, "SDLK_S");
    lua_pushinteger(L, SDL_SCANCODE_T); lua_setglobal(L, "SDLK_T");
    lua_pushinteger(L, SDL_SCANCODE_U); lua_setglobal(L, "SDLK_U");
    lua_pushinteger(L, SDL_SCANCODE_V); lua_setglobal(L, "SDLK_V");
    lua_pushinteger(L, SDL_SCANCODE_W); lua_setglobal(L, "SDLK_W");
    lua_pushinteger(L, SDL_SCANCODE_X); lua_setglobal(L, "SDLK_X");
    lua_pushinteger(L, SDL_SCANCODE_Y); lua_setglobal(L, "SDLK_Y");
    lua_pushinteger(L, SDL_SCANCODE_Z); lua_setglobal(L, "SDLK_Z");
    lua_pushinteger(L, SDL_SCANCODE_0); lua_setglobal(L, "SDLK_0");
    lua_pushinteger(L, SDL_SCANCODE_1); lua_setglobal(L, "SDLK_1");
    lua_pushinteger(L, SDL_SCANCODE_2); lua_setglobal(L, "SDLK_2");
    lua_pushinteger(L, SDL_SCANCODE_3); lua_setglobal(L, "SDLK_3");
    lua_pushinteger(L, SDL_SCANCODE_4); lua_setglobal(L, "SDLK_4");
    lua_pushinteger(L, SDL_SCANCODE_5); lua_setglobal(L, "SDLK_5");
    lua_pushinteger(L, SDL_SCANCODE_6); lua_setglobal(L, "SDLK_6");
    lua_pushinteger(L, SDL_SCANCODE_7); lua_setglobal(L, "SDLK_7");
    lua_pushinteger(L, SDL_SCANCODE_8); lua_setglobal(L, "SDLK_8");
    lua_pushinteger(L, SDL_SCANCODE_9); lua_setglobal(L, "SDLK_9");
    lua_pushinteger(L, SDL_SCANCODE_UP); lua_setglobal(L, "SDLK_UP");
    lua_pushinteger(L, SDL_SCANCODE_DOWN); lua_setglobal(L, "SDLK_DOWN");
    lua_pushinteger(L, SDL_SCANCODE_LEFT); lua_setglobal(L, "SDLK_LEFT");
    lua_pushinteger(L, SDL_SCANCODE_RIGHT); lua_setglobal(L, "SDLK_RIGHT");
    lua_pushinteger(L, SDL_SCANCODE_SPACE); lua_setglobal(L, "SDLK_SPACE");
    lua_pushinteger(L, SDL_SCANCODE_RETURN); lua_setglobal(L, "SDLK_RETURN");
    lua_pushinteger(L, SDL_SCANCODE_ESCAPE); lua_setglobal(L, "SDLK_ESCAPE");
    lua_pushinteger(L, SDL_SCANCODE_TAB); lua_setglobal(L, "SDLK_TAB");
    lua_pushinteger(L, SDL_SCANCODE_LSHIFT); lua_setglobal(L, "SDLK_LSHIFT");
    lua_pushinteger(L, SDL_SCANCODE_RSHIFT); lua_setglobal(L, "SDLK_RSHIFT");
    lua_pushinteger(L, SDL_SCANCODE_LCTRL); lua_setglobal(L, "SDLK_LCTRL");
    lua_pushinteger(L, SDL_SCANCODE_RCTRL); lua_setglobal(L, "SDLK_RCTRL");
    lua_pushinteger(L, SDL_SCANCODE_BACKSPACE); lua_setglobal(L, "SDLK_BACKSPACE");
    lua_pushinteger(L, SDL_SCANCODE_DELETE); lua_setglobal(L, "SDLK_DELETE");
    lua_pushinteger(L, SDL_SCANCODE_INSERT); lua_setglobal(L, "SDLK_INSERT");
    lua_pushinteger(L, SDL_SCANCODE_HOME); lua_setglobal(L, "SDLK_HOME");
    lua_pushinteger(L, SDL_SCANCODE_END); lua_setglobal(L, "SDLK_END");
    lua_pushinteger(L, SDL_SCANCODE_PAGEUP); lua_setglobal(L, "SDLK_PAGEUP");
    lua_pushinteger(L, SDL_SCANCODE_PAGEDOWN); lua_setglobal(L, "SDLK_PAGEDOWN");
    lua_pushinteger(L, SDL_SCANCODE_LALT); lua_setglobal(L, "SDLK_LALT");
    lua_pushinteger(L, SDL_SCANCODE_RALT); lua_setglobal(L, "SDLK_RALT");
    lua_pushinteger(L, SDL_SCANCODE_CAPSLOCK); lua_setglobal(L, "SDLK_CAPSLOCK");
    lua_pushinteger(L, SDL_SCANCODE_F1); lua_setglobal(L, "SDLK_F1");
    lua_pushinteger(L, SDL_SCANCODE_F2); lua_setglobal(L, "SDLK_F2");
    lua_pushinteger(L, SDL_SCANCODE_F3); lua_setglobal(L, "SDLK_F3");
    lua_pushinteger(L, SDL_SCANCODE_F4); lua_setglobal(L, "SDLK_F4");
    lua_pushinteger(L, SDL_SCANCODE_F5); lua_setglobal(L, "SDLK_F5");
    lua_pushinteger(L, SDL_SCANCODE_F6); lua_setglobal(L, "SDLK_F6");
    lua_pushinteger(L, SDL_SCANCODE_F7); lua_setglobal(L, "SDLK_F7");
    lua_pushinteger(L, SDL_SCANCODE_F8); lua_setglobal(L, "SDLK_F8");
    lua_pushinteger(L, SDL_SCANCODE_F9); lua_setglobal(L, "SDLK_F9");
    lua_pushinteger(L, SDL_SCANCODE_F10); lua_setglobal(L, "SDLK_F10");
    lua_pushinteger(L, SDL_SCANCODE_F11); lua_setglobal(L, "SDLK_F11");
    lua_pushinteger(L, SDL_SCANCODE_F12); lua_setglobal(L, "SDLK_F12");
    lua_pushinteger(L, SDL_SCANCODE_PRINTSCREEN); lua_setglobal(L, "SDLK_PRINTSCREEN");
    lua_pushinteger(L, SDL_SCANCODE_SCROLLLOCK); lua_setglobal(L, "SDLK_SCROLLLOCK");
    lua_pushinteger(L, SDL_SCANCODE_PAUSE); lua_setglobal(L, "SDLK_PAUSE");
    lua_pushinteger(L, SDL_SCANCODE_GRAVE); lua_setglobal(L, "SDLK_GRAVE");
    lua_pushinteger(L, SDL_SCANCODE_MINUS); lua_setglobal(L, "SDLK_MINUS");
    lua_pushinteger(L, SDL_SCANCODE_EQUALS); lua_setglobal(L, "SDLK_EQUALS");
    lua_pushinteger(L, SDL_SCANCODE_LEFTBRACKET); lua_setglobal(L, "SDLK_LEFTBRACKET");
    lua_pushinteger(L, SDL_SCANCODE_RIGHTBRACKET); lua_setglobal(L, "SDLK_RIGHTBRACKET");
    lua_pushinteger(L, SDL_SCANCODE_BACKSLASH); lua_setglobal(L, "SDLK_BACKSLASH");
    lua_pushinteger(L, SDL_SCANCODE_SEMICOLON); lua_setglobal(L, "SDLK_SEMICOLON");
    lua_pushinteger(L, SDL_SCANCODE_APOSTROPHE); lua_setglobal(L, "SDLK_APOSTROPHE");
    lua_pushinteger(L, SDL_SCANCODE_COMMA); lua_setglobal(L, "SDLK_COMMA");
    lua_pushinteger(L, SDL_SCANCODE_PERIOD); lua_setglobal(L, "SDLK_PERIOD");
    lua_pushinteger(L, SDL_SCANCODE_SLASH); lua_setglobal(L, "SDLK_SLASH");
    lua_pushinteger(L, SDL_SCANCODE_KP_DIVIDE); lua_setglobal(L, "SDLK_KP_DIVIDE");
    lua_pushinteger(L, SDL_SCANCODE_KP_MULTIPLY); lua_setglobal(L, "SDLK_KP_MULTIPLY");
    lua_pushinteger(L, SDL_SCANCODE_KP_MINUS); lua_setglobal(L, "SDLK_KP_MINUS");
    lua_pushinteger(L, SDL_SCANCODE_KP_PLUS); lua_setglobal(L, "SDLK_KP_PLUS");
    lua_pushinteger(L, SDL_SCANCODE_KP_ENTER); lua_setglobal(L, "SDLK_KP_ENTER");
    lua_pushinteger(L, SDL_SCANCODE_KP_1); lua_setglobal(L, "SDLK_KP_1");
    lua_pushinteger(L, SDL_SCANCODE_KP_2); lua_setglobal(L, "SDLK_KP_2");
    lua_pushinteger(L, SDL_SCANCODE_KP_3); lua_setglobal(L, "SDLK_KP_3");
    lua_pushinteger(L, SDL_SCANCODE_KP_4); lua_setglobal(L, "SDLK_KP_4");
    lua_pushinteger(L, SDL_SCANCODE_KP_5); lua_setglobal(L, "SDLK_KP_5");
    lua_pushinteger(L, SDL_SCANCODE_KP_6); lua_setglobal(L, "SDLK_KP_6");
    lua_pushinteger(L, SDL_SCANCODE_KP_7); lua_setglobal(L, "SDLK_KP_7");
    lua_pushinteger(L, SDL_SCANCODE_KP_8); lua_setglobal(L, "SDLK_KP_8");
    lua_pushinteger(L, SDL_SCANCODE_KP_9); lua_setglobal(L, "SDLK_KP_9");
    lua_pushinteger(L, SDL_SCANCODE_KP_0); lua_setglobal(L, "SDLK_KP_0");
    lua_pushinteger(L, SDL_SCANCODE_KP_PERIOD); lua_setglobal(L, "SDLK_KP_PERIOD");
    
    // Backward compatibility: Map SCE_CTRL codes to SDLK keys for old Vita scripts
    // Use the actual runtime scancode values that are generated by key presses
    lua_pushinteger(L, 82); lua_setglobal(L, "SCE_CTRL_UP");     // Runtime UP scancode
    lua_pushinteger(L, 81); lua_setglobal(L, "SCE_CTRL_DOWN");   // Runtime DOWN scancode  
    lua_pushinteger(L, 80); lua_setglobal(L, "SCE_CTRL_LEFT");   // Runtime LEFT scancode
    lua_pushinteger(L, 79); lua_setglobal(L, "SCE_CTRL_RIGHT");  // Runtime RIGHT scancode
    lua_pushinteger(L, SDL_SCANCODE_SPACE); lua_setglobal(L, "SCE_CTRL_CROSS");
    lua_pushinteger(L, SDL_SCANCODE_BACKSPACE); lua_setglobal(L, "SCE_CTRL_CIRCLE");
    lua_pushinteger(L, SDL_SCANCODE_Z); lua_setglobal(L, "SCE_CTRL_SQUARE");
    lua_pushinteger(L, SDL_SCANCODE_X); lua_setglobal(L, "SCE_CTRL_TRIANGLE");
    lua_pushinteger(L, SDL_SCANCODE_Q); lua_setglobal(L, "SCE_CTRL_LTRIGGER");
    lua_pushinteger(L, SDL_SCANCODE_E); lua_setglobal(L, "SCE_CTRL_RTRIGGER");
    lua_pushinteger(L, SDL_SCANCODE_RETURN); lua_setglobal(L, "SCE_CTRL_START");
    lua_pushinteger(L, SDL_SCANCODE_TAB); lua_setglobal(L, "SCE_CTRL_SELECT");
    lua_pushinteger(L, SDL_SCANCODE_H); lua_setglobal(L, "SCE_CTRL_PSBUTTON");
    lua_pushinteger(L, SDL_SCANCODE_P); lua_setglobal(L, "SCE_CTRL_POWER");
    lua_pushinteger(L, SDL_SCANCODE_PAGEUP); lua_setglobal(L, "SCE_CTRL_VOLUP");
    lua_pushinteger(L, SDL_SCANCODE_PAGEDOWN); lua_setglobal(L, "SCE_CTRL_VOLDOWN");
}