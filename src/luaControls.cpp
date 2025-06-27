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
static SDL_Joystick* fallback_joysticks[4] = {NULL, NULL, NULL, NULL};
static int left_analog_x = 128 * 256, left_analog_y = 128 * 256;  // Initialize to center position (128 in Vita range)
static int right_analog_x = 128 * 256, right_analog_y = 128 * 256;
static int mouse_x = 0, mouse_y = 0;
static bool mouse_pressed = false;
static bool current_mouse_pressed = false;
static bool previous_mouse_pressed = false;
static const Uint8* keyboard_state = NULL;

// Store current and previous keyboard state for edge detection
static bool current_keys[SDL_NUM_SCANCODES] = {false};
static bool previous_keys[SDL_NUM_SCANCODES] = {false};
static int frame_counter = 0;

// Load SDL GameControllerDB for consistent controller mappings
static void load_controller_database() {
    // Try to load gamecontrollerdb.txt from current directory
    FILE* db_file = fopen("gamecontrollerdb.txt", "r");
    if (db_file) {
        fclose(db_file);
        int result = SDL_GameControllerAddMappingsFromFile("gamecontrollerdb.txt");
        if (result > 0) {
            printf("Loaded %d controller mappings from gamecontrollerdb.txt\n", result);
        } else if (result == 0) {
            printf("No new controller mappings found in gamecontrollerdb.txt\n");
        } else {
            printf("Error loading gamecontrollerdb.txt: %s\n", SDL_GetError());
        }
    } else {
        printf("gamecontrollerdb.txt not found, using built-in SDL controller mappings\n");
        printf("For better controller support, download gamecontrollerdb.txt from:\n");
        printf("https://github.com/mdqinc/SDL_GameControllerDB/blob/master/gamecontrollerdb.txt\n");
        printf("and place it in the same directory as the executable.\n");
    }
}

// Cleanup controllers on shutdown
extern "C" void cleanup_controllers() {
    printf("Cleaning up controllers...\n");
    for (int i = 0; i < 4; i++) {
        if (controllers[i]) {
            SDL_GameControllerClose(controllers[i]);
            controllers[i] = NULL;
        }
        if (fallback_joysticks[i]) {
            SDL_JoystickClose(fallback_joysticks[i]);
            fallback_joysticks[i] = NULL;
        }
    }
}

// Initialize game controllers
extern "C" void init_controllers() {
    // Load controller database first for better compatibility
    load_controller_database();
    
    printf("Detecting game controllers...\n");
    int num_joysticks = SDL_NumJoysticks();
    printf("Found %d joystick(s)\n", num_joysticks);
    
    for (int i = 0; i < num_joysticks && i < 4; i++) {
        if (SDL_IsGameController(i)) {
            controllers[i] = SDL_GameControllerOpen(i);
            if (controllers[i]) {
                const char* name = SDL_GameControllerName(controllers[i]);
                const char* mapping = SDL_GameControllerMapping(controllers[i]);
                printf("Controller %d: %s (opened successfully)\n", i, name ? name : "Unknown");
                if (mapping) {
                    printf("  Using mapping: %.100s...\n", mapping);  // Truncate long mappings
                    SDL_free((void*)mapping);  // SDL_GameControllerMapping returns allocated memory
                }
            } else {
                printf("Controller %d: Failed to open - %s\n", i, SDL_GetError());
            }
        } else {
            printf("Joystick %d: Not a recognized game controller\n", i);
            
            // Output detailed joystick info to help create gamecontrollerdb.txt entry
            SDL_Joystick* joystick = SDL_JoystickOpen(i);
            if (joystick) {
                printf("  Raw Joystick Details:\n");
                printf("    Name: %s\n", SDL_JoystickName(joystick) ? SDL_JoystickName(joystick) : "Unknown");
                
                SDL_JoystickGUID guid = SDL_JoystickGetGUID(joystick);
                char guid_str[33];
                SDL_JoystickGetGUIDString(guid, guid_str, sizeof(guid_str));
                printf("    GUID: %s\n", guid_str);
                
                printf("    Axes: %d\n", SDL_JoystickNumAxes(joystick));
                printf("    Buttons: %d\n", SDL_JoystickNumButtons(joystick));
                printf("    Hats: %d\n", SDL_JoystickNumHats(joystick));
                
                printf("  To add support, create a gamecontrollerdb.txt entry like:\n");
                printf("  %s,Your Controller Name,a:b0,b:b1,x:b2,y:b3,back:b4,start:b5,leftstick:b6,rightstick:b7,leftshoulder:b8,rightshoulder:b9,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:a4,righttrigger:a5,platform:Linux,\n", guid_str);
                
                // Keep joystick open as fallback for basic input
                fallback_joysticks[i] = joystick;
                printf("  Using joystick as fallback input device (basic button mapping)\n");
            }
        }
    }
}

// Handle controller hotplug events
extern "C" void handle_controller_event(SDL_Event* event) {
    if (event->type == SDL_CONTROLLERDEVICEADDED) {
        int device_index = event->cdevice.which;
        printf("Controller hotplug: Device %d added\n", device_index);
        
        // Find an empty slot
        for (int i = 0; i < 4; i++) {
            if (!controllers[i]) {
                if (SDL_IsGameController(device_index)) {
                    controllers[i] = SDL_GameControllerOpen(device_index);
                    if (controllers[i]) {
                        const char* name = SDL_GameControllerName(controllers[i]);
                        const char* mapping = SDL_GameControllerMapping(controllers[i]);
                        printf("Controller %d: %s (hotplugged successfully)\n", i, name ? name : "Unknown");
                        if (mapping) {
                            printf("  Using mapping: %.100s...\n", mapping);
                            SDL_free((void*)mapping);
                        }
                    }
                } else {
                    // Use as fallback joystick
                    SDL_Joystick* joystick = SDL_JoystickOpen(device_index);
                    if (joystick) {
                        fallback_joysticks[i] = joystick;
                        printf("Controller %d: Using as fallback joystick (hotplugged)\n", i);
                    }
                }
                break;
            }
        }
    } else if (event->type == SDL_CONTROLLERDEVICEREMOVED) {
        SDL_JoystickID instance_id = event->cdevice.which;
        printf("Controller hotplug: Device with instance ID %d removed\n", instance_id);
        
        // Find and close the removed controller
        for (int i = 0; i < 4; i++) {
            if (controllers[i] && SDL_JoystickInstanceID(SDL_GameControllerGetJoystick(controllers[i])) == instance_id) {
                printf("Closing controller %d\n", i);
                SDL_GameControllerClose(controllers[i]);
                controllers[i] = NULL;
                break;
            } else if (fallback_joysticks[i] && SDL_JoystickInstanceID(fallback_joysticks[i]) == instance_id) {
                printf("Closing fallback joystick %d\n", i);
                SDL_JoystickClose(fallback_joysticks[i]);
                fallback_joysticks[i] = NULL;
                break;
            }
        }
    }
}

static void update_input_state() {
    // Pump events to update keyboard state
    SDL_PumpEvents();
    
    // Update keyboard state
    keyboard_state = SDL_GetKeyboardState(NULL);
    
    // Clear gamepad-mapped keys first (so they don't stick if button is released)
    // Clear keys used for both Vita and 3DS gamepad mapping
    current_keys[SDL_SCANCODE_SPACE] = false;      // Cross/X
    current_keys[SDL_SCANCODE_BACKSPACE] = false;  // Circle/B
    current_keys[SDL_SCANCODE_Z] = false;          // Square (Vita only)
    current_keys[SDL_SCANCODE_X] = false;          // Triangle (Vita only)
    current_keys[SDL_SCANCODE_Q] = false;          // L (Vita only)
    current_keys[SDL_SCANCODE_E] = false;          // R (Vita only)
    current_keys[SDL_SCANCODE_RETURN] = false;     // Start/A
    current_keys[SDL_SCANCODE_TAB] = false;        // Select (Vita only)
    current_keys[SDL_SCANCODE_UP] = false;         // D-Pad Up
    current_keys[SDL_SCANCODE_DOWN] = false;       // D-Pad Down
    current_keys[SDL_SCANCODE_LEFT] = false;       // D-Pad Left
    current_keys[SDL_SCANCODE_RIGHT] = false;      // D-Pad Right
    current_keys[SDL_SCANCODE_PAGEUP] = false;     // L Trigger (Vita only)
    current_keys[SDL_SCANCODE_PAGEDOWN] = false;   // R Trigger (Vita only)
    current_keys[SDL_SCANCODE_Q] = false;          // L (3DS/Vita)
    current_keys[SDL_SCANCODE_E] = false;          // R (3DS/Vita)
    current_keys[SDL_SCANCODE_LSHIFT] = false;     // Y (3DS only)
    current_keys[SDL_SCANCODE_LALT] = false;       // Start (3DS only)
    current_keys[SDL_SCANCODE_LCTRL] = false;      // Select (3DS only)

    // Update controller state if available
    if (controllers[0] && SDL_GameControllerGetAttached(controllers[0])) {
        // Read analog sticks and convert from SDL range (-32768 to 32767) to Vita range (0-255)
        Sint16 sdl_lx = SDL_GameControllerGetAxis(controllers[0], SDL_CONTROLLER_AXIS_LEFTX);
        Sint16 sdl_ly = SDL_GameControllerGetAxis(controllers[0], SDL_CONTROLLER_AXIS_LEFTY);
        Sint16 sdl_rx = SDL_GameControllerGetAxis(controllers[0], SDL_CONTROLLER_AXIS_RIGHTX);
        Sint16 sdl_ry = SDL_GameControllerGetAxis(controllers[0], SDL_CONTROLLER_AXIS_RIGHTY);
        
        // Convert from SDL range (-32768 to 32767) to Vita range (0 to 255), centered at 128
        left_analog_x = ((sdl_lx + 32768) * 255 / 65535) * 256;
        left_analog_y = ((sdl_ly + 32768) * 255 / 65535) * 256;
        right_analog_x = ((sdl_rx + 32768) * 255 / 65535) * 256;
        right_analog_y = ((sdl_ry + 32768) * 255 / 65535) * 256;
        
        // Map gamepad buttons to keyboard scancodes for platform compatibility
        // This allows existing games to work with gamepad without code changes
        
        extern lpp_compat_mode_t g_compat_mode;
        if (g_compat_mode == LPP_COMPAT_NATIVE) {
            // Native gamepad mapping - use intuitive button layout
            // For most users, the physical button labeled "A" should act as the primary action button
            // This means mapping based on the controller's physical layout, not SDL's logical layout
            
            // For Nintendo-style controllers (8BitDo, Pro Controller, etc.):
            // Physical A (right) = SDL B button, should map to primary action
            // Physical B (bottom) = SDL A button, should map to secondary action
            // For Xbox-style controllers:
            // Physical A (bottom) = SDL A button, primary action  
            // Physical B (right) = SDL B button, secondary action
            
            // Since we can't easily detect controller type, we'll use a sensible default:
            // Map SDL's logical buttons to common game actions
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_A)) {
                current_keys[SDL_SCANCODE_SPACE] = true; // SDL A = Primary action (Space/Jump)
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_B)) {
                current_keys[SDL_SCANCODE_BACKSPACE] = true; // SDL B = Secondary action (Back/Cancel)
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_X)) {
                current_keys[SDL_SCANCODE_X] = true; // SDL X = X action
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_Y)) {
                current_keys[SDL_SCANCODE_Y] = true; // SDL Y = Y action
            }
            
            // Shoulder buttons
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_LEFTSHOULDER)) {
                current_keys[SDL_SCANCODE_Q] = true; // L1/LB = Q
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_RIGHTSHOULDER)) {
                current_keys[SDL_SCANCODE_E] = true; // R1/RB = E
            }
            
            // Start/Select buttons
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_START)) {
                current_keys[SDL_SCANCODE_RETURN] = true; // Start = Enter
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_BACK)) {
                current_keys[SDL_SCANCODE_TAB] = true; // Back/Select = Tab
            }
            
            // Guide button
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_GUIDE)) {
                current_keys[SDL_SCANCODE_ESCAPE] = true; // Guide = Escape
            }
            
        } else if (g_compat_mode == LPP_COMPAT_3DS) {
            // 3DS gamepad mapping - map to Nintendo button layout
            // SDL uses Xbox naming (A=bottom, B=right, X=left, Y=top)
            // 3DS uses Nintendo layout (A=right, B=bottom, X=top, Y=left)
            // So we need to translate: SDL_B->3DS_A, SDL_A->3DS_B, SDL_Y->3DS_X, SDL_X->3DS_Y
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_B)) {
                current_keys[SDL_SCANCODE_RETURN] = true; // SDL B (right) = 3DS A = Return (KEY_A maps to Return in 3DS mode)
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_A)) {
                current_keys[SDL_SCANCODE_BACKSPACE] = true; // SDL A (bottom) = 3DS B = Backspace (KEY_B maps to Backspace in 3DS mode)
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_Y)) {
                current_keys[SDL_SCANCODE_SPACE] = true; // SDL Y (top) = 3DS X = Space (KEY_X maps to Space in 3DS mode)
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_X)) {
                current_keys[SDL_SCANCODE_LSHIFT] = true; // SDL X (left) = 3DS Y = LShift (KEY_Y maps to LShift in 3DS mode)
            }
            
            // Shoulder buttons
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_LEFTSHOULDER)) {
                current_keys[SDL_SCANCODE_Q] = true; // L = Q (KEY_L maps to Q in 3DS mode)
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_RIGHTSHOULDER)) {
                current_keys[SDL_SCANCODE_E] = true; // R = E (KEY_R maps to E in 3DS mode)
            }
            
            // Start/Select buttons
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_START)) {
                current_keys[SDL_SCANCODE_LALT] = true; // Start = LAlt (KEY_START maps to LAlt in 3DS mode)
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_BACK)) {
                current_keys[SDL_SCANCODE_LCTRL] = true; // Select = LCtrl (KEY_SELECT maps to LCtrl in 3DS mode)
            }
        } else {
            // Vita gamepad mapping - map to PlayStation button layout
            // SDL uses Xbox naming (A=bottom, B=right, X=left, Y=top)
            // Vita uses PlayStation layout (Cross=bottom, Circle=right, Square=left, Triangle=top)
            // So mapping is: SDL_A->Cross, SDL_B->Circle, SDL_X->Square, SDL_Y->Triangle
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_A)) {
                current_keys[SDL_SCANCODE_SPACE] = true; // SDL A (bottom) = Cross = Space
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_B)) {
                current_keys[SDL_SCANCODE_BACKSPACE] = true; // SDL B (right) = Circle = Backspace
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_X)) {
                current_keys[SDL_SCANCODE_Z] = true; // SDL X (left) = Square = Z
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_Y)) {
                current_keys[SDL_SCANCODE_X] = true; // SDL Y (top) = Triangle = X
            }
            
            // Shoulder buttons
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_LEFTSHOULDER)) {
                current_keys[SDL_SCANCODE_Q] = true; // L = Q
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_RIGHTSHOULDER)) {
                current_keys[SDL_SCANCODE_E] = true; // R = E
            }
            
            // Start/Select buttons
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_START)) {
                current_keys[SDL_SCANCODE_RETURN] = true; // Start = Return
            }
            if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_BACK)) {
                current_keys[SDL_SCANCODE_TAB] = true; // Select = Tab
            }
        }
        
        // D-Pad
        if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_DPAD_UP)) {
            current_keys[SDL_SCANCODE_UP] = true;
        }
        if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_DPAD_DOWN)) {
            current_keys[SDL_SCANCODE_DOWN] = true;
        }
        if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_DPAD_LEFT)) {
            current_keys[SDL_SCANCODE_LEFT] = true;
        }
        if (SDL_GameControllerGetButton(controllers[0], SDL_CONTROLLER_BUTTON_DPAD_RIGHT)) {
            current_keys[SDL_SCANCODE_RIGHT] = true;
        }
        
        // Triggers (map to L/R as well for compatibility)
        if (SDL_GameControllerGetAxis(controllers[0], SDL_CONTROLLER_AXIS_TRIGGERLEFT) > 16384) { // > 50%
            current_keys[SDL_SCANCODE_PAGEUP] = true; // L Trigger = PageUp
        }
        if (SDL_GameControllerGetAxis(controllers[0], SDL_CONTROLLER_AXIS_TRIGGERRIGHT) > 16384) { // > 50%
            current_keys[SDL_SCANCODE_PAGEDOWN] = true; // R Trigger = PageDown
        }
    } else if (fallback_joysticks[0] && SDL_JoystickGetAttached(fallback_joysticks[0])) {
        // Fallback: Use raw joystick input for unrecognized controllers
        if (frame_counter % 300 == 0) { // Print debug info every 5 seconds at 60fps
            printf("Using fallback joystick input (frame %d)\n", frame_counter);
        }
        
        // Read analog sticks (assuming axes 0,1 = left stick, 2,3 = right stick)
        if (SDL_JoystickNumAxes(fallback_joysticks[0]) >= 2) {
            Sint16 sdl_lx = SDL_JoystickGetAxis(fallback_joysticks[0], 0);
            Sint16 sdl_ly = SDL_JoystickGetAxis(fallback_joysticks[0], 1);
            left_analog_x = ((sdl_lx + 32768) * 255 / 65535) * 256;
            left_analog_y = ((sdl_ly + 32768) * 255 / 65535) * 256;
        }
        if (SDL_JoystickNumAxes(fallback_joysticks[0]) >= 4) {
            Sint16 sdl_rx = SDL_JoystickGetAxis(fallback_joysticks[0], 2);
            Sint16 sdl_ry = SDL_JoystickGetAxis(fallback_joysticks[0], 3);
            right_analog_x = ((sdl_rx + 32768) * 255 / 65535) * 256;
            right_analog_y = ((sdl_ry + 32768) * 255 / 65535) * 256;
        }
        
        // Basic button mapping (assuming standard gamepad button order)
        // Map based on compatibility mode
        if (SDL_JoystickNumButtons(fallback_joysticks[0]) >= 4) {
            extern lpp_compat_mode_t g_compat_mode;
            if (g_compat_mode == LPP_COMPAT_NATIVE) {
                // Native mode: Use intuitive mapping (button 0 = primary action)
                if (SDL_JoystickGetButton(fallback_joysticks[0], 0)) { // Button 0 -> Primary action
                    current_keys[SDL_SCANCODE_SPACE] = true;
                }
                if (SDL_JoystickGetButton(fallback_joysticks[0], 1)) { // Button 1 -> Secondary action
                    current_keys[SDL_SCANCODE_BACKSPACE] = true;
                }
                if (SDL_JoystickGetButton(fallback_joysticks[0], 2)) { // Button 2 -> X action
                    current_keys[SDL_SCANCODE_X] = true;
                }
                if (SDL_JoystickGetButton(fallback_joysticks[0], 3)) { // Button 3 -> Y action
                    current_keys[SDL_SCANCODE_Y] = true;
                }
            } else if (g_compat_mode == LPP_COMPAT_3DS) {
                // 3DS mode: Map to 3DS button expectations
                if (SDL_JoystickGetButton(fallback_joysticks[0], 0)) { // Button 0 -> A (Return)
                    current_keys[SDL_SCANCODE_RETURN] = true;
                }
                if (SDL_JoystickGetButton(fallback_joysticks[0], 1)) { // Button 1 -> B (Backspace)
                    current_keys[SDL_SCANCODE_BACKSPACE] = true;
                }
                if (SDL_JoystickGetButton(fallback_joysticks[0], 2)) { // Button 2 -> X (Space)
                    current_keys[SDL_SCANCODE_SPACE] = true;
                }
                if (SDL_JoystickGetButton(fallback_joysticks[0], 3)) { // Button 3 -> Y (LShift)
                    current_keys[SDL_SCANCODE_LSHIFT] = true;
                }
            } else {
                // Vita mode: Map to Vita button expectations
                if (SDL_JoystickGetButton(fallback_joysticks[0], 0)) { // Button 0 -> Cross (Space)
                    current_keys[SDL_SCANCODE_SPACE] = true;
                }
                if (SDL_JoystickGetButton(fallback_joysticks[0], 1)) { // Button 1 -> Circle (Backspace)
                    current_keys[SDL_SCANCODE_BACKSPACE] = true;
                }
                if (SDL_JoystickGetButton(fallback_joysticks[0], 2)) { // Button 2 -> Square (Z)
                    current_keys[SDL_SCANCODE_Z] = true;
                }
                if (SDL_JoystickGetButton(fallback_joysticks[0], 3)) { // Button 3 -> Triangle (X)
                    current_keys[SDL_SCANCODE_X] = true;
                }
            }
        }
        
        // D-Pad via hat (if available)
        if (SDL_JoystickNumHats(fallback_joysticks[0]) >= 1) {
            Uint8 hat = SDL_JoystickGetHat(fallback_joysticks[0], 0);
            if (hat & SDL_HAT_UP) current_keys[SDL_SCANCODE_UP] = true;
            if (hat & SDL_HAT_DOWN) current_keys[SDL_SCANCODE_DOWN] = true;
            if (hat & SDL_HAT_LEFT) current_keys[SDL_SCANCODE_LEFT] = true;
            if (hat & SDL_HAT_RIGHT) current_keys[SDL_SCANCODE_RIGHT] = true;
        }
        
        if (frame_counter % 300 == 0) { // Print debug info every 5 seconds at 60fps
            printf("Fallback joystick: buttons=%d, axes=%d, hats=%d\n", 
                   SDL_JoystickNumButtons(fallback_joysticks[0]),
                   SDL_JoystickNumAxes(fallback_joysticks[0]), 
                   SDL_JoystickNumHats(fallback_joysticks[0]));
        }
        
    } else {
        // No controller - set analog sticks to neutral position (128 in Vita's 0-255 range)
        // Since lua_readleft divides by 256, we multiply by 256 here
        left_analog_x = 128 * 256;   // This will give 128 when divided by 256
        left_analog_y = 128 * 256;
        right_analog_x = 128 * 256;
        right_analog_y = 128 * 256;
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
    // Note: Don't overwrite gamepad mappings that were set in update_input_state()
    if (keyboard_state) {
        for (int i = 0; i < SDL_NUM_SCANCODES; i++) {
            // Use OR operation to combine keyboard and gamepad states
            current_keys[i] = current_keys[i] || (keyboard_state[i] != 0);
        }
    }
    
    // Update current mouse state
    current_mouse_pressed = mouse_pressed;
    
    extern lpp_compat_mode_t g_compat_mode;
    
    // In 3DS compatibility mode, return button state bitmask like original 3DS
    if (g_compat_mode == LPP_COMPAT_3DS) {
        uint32_t button_state = 0;
        
        // Map SDL scancodes to 3DS button bits (matching original 3DS bit positions)
        if (current_keys[SDL_SCANCODE_RETURN]) button_state |= (1 << 0);      // KEY_A = BIT(0)
        if (current_keys[SDL_SCANCODE_BACKSPACE]) button_state |= (1 << 1);   // KEY_B = BIT(1)
        if (current_keys[SDL_SCANCODE_LCTRL]) button_state |= (1 << 2);       // KEY_SELECT = BIT(2)
        if (current_keys[SDL_SCANCODE_LALT]) button_state |= (1 << 3);        // KEY_START = BIT(3)
        if (current_keys[SDL_SCANCODE_RIGHT]) button_state |= (1 << 4);       // KEY_DRIGHT = BIT(4)
        if (current_keys[SDL_SCANCODE_LEFT]) button_state |= (1 << 5);        // KEY_DLEFT = BIT(5)
        if (current_keys[SDL_SCANCODE_UP]) button_state |= (1 << 6);          // KEY_DUP = BIT(6)
        if (current_keys[SDL_SCANCODE_DOWN]) button_state |= (1 << 7);        // KEY_DDOWN = BIT(7)
        if (current_keys[SDL_SCANCODE_PAGEDOWN]) button_state |= (1 << 8);    // KEY_R = BIT(8)
        if (current_keys[SDL_SCANCODE_PAGEUP]) button_state |= (1 << 9);      // KEY_L = BIT(9)
        if (current_keys[SDL_SCANCODE_SPACE]) button_state |= (1 << 10);      // KEY_X = BIT(10)
        if (current_keys[SDL_SCANCODE_LSHIFT]) button_state |= (1 << 11);     // KEY_Y = BIT(11)
        if (current_mouse_pressed) button_state |= (1 << 20);                 // KEY_TOUCH = BIT(20)
        
        lua_pushinteger(L, button_state);
        return 1;
    } else {
        // For Vita/Native modes, return frame counter for edge detection (different value each frame)
        frame_counter++;
        lua_pushnumber(L, frame_counter);
        return 1;
    }
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
    extern lpp_compat_mode_t g_compat_mode;
    
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // In 3DS mode, pad is button state bitmask, scancode is button bit value
        uint32_t pad = luaL_checkinteger(L, 1);    // Button state bitmask from Controls.read()
        uint32_t button = luaL_checkinteger(L, 2); // Button bit value to check
        
        // Use original 3DS logic: bitwise AND check
        lua_pushboolean(L, ((pad & button) == button));
    } else {
        // For Vita/Native modes, use frame-based edge detection
        int pad = luaL_checkinteger(L, 1);  // Frame counter from Controls.read()
        int scancode = luaL_checkinteger(L, 2);
        
        // Check if the scancode key is pressed
        bool is_pressed = false;
        if (scancode == 1000) { // KEY_TOUCH special case
            // Edge detection for touch: return true only when touch started this frame
            if (pad == frame_counter) {
                is_pressed = current_mouse_pressed && !previous_mouse_pressed;
            }
            // For any other frame, return false (not pressed)
        } else if (scancode >= 0 && scancode < SDL_NUM_SCANCODES) {
            // Edge detection: return true only when key is pressed this frame but wasn't pressed last frame
            if (pad == frame_counter) {
                // Current frame: check if key was just pressed (edge detection)
                is_pressed = current_keys[scancode] && !previous_keys[scancode];
            }
            // For any other frame, return false (key not pressed)
        }
        
        lua_pushboolean(L, is_pressed);
    }
    return 1;
}

// Mimic the Vita lerp function for coordinate transformation - fixed precision
#define lerp(value, from_max, to_max) ((value * to_max) / from_max)

static int lua_touchpad(lua_State *L){
    int argc = lua_gettop(L);
    if (argc != 0) return luaL_error(L, "wrong number of arguments.");
    update_input_state();
    
    // Debug output for mouse state
    extern lpp_compat_mode_t g_compat_mode;
    extern bool g_debug_mode;
    static int debug_counter = 0;
    if (g_debug_mode && (debug_counter++ % 60) == 0) { // Print every 60th call to avoid spam
        printf("[DEBUG] Touch check: mouse_pressed=%s, pos=(%d,%d), compat_mode=%d\n", 
               mouse_pressed ? "true" : "false", mouse_x, mouse_y, g_compat_mode);
    }
    
    if (mouse_pressed) {
        int logical_x = mouse_x;
        int logical_y = mouse_y;
        
        // Debug output for touch processing
        if (g_debug_mode && (debug_counter % 60) == 1) { // Print every 60th touch to avoid spam
            printf("[DEBUG] Touch detected: raw=(%d,%d), compat_mode=%d\n", mouse_x, mouse_y, g_compat_mode);
        }
        
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
                
                // Handle platform-specific coordinate transformation
                extern lpp_compat_mode_t g_compat_mode;
                if (g_compat_mode == LPP_COMPAT_3DS) {
                    extern bool g_3ds_single_screen_mode;
                    extern int g_3ds_active_screen;
                    extern lpp_3ds_orientation_t g_3ds_orientation;
                    extern int getScreenXOffset(int screen_id);
                    extern int getScreenYOffset(int screen_id);
                    
                    if (g_3ds_single_screen_mode) {
                        // Single-screen mode: only bottom screen accepts touch input (like real 3DS)
                        if (g_3ds_active_screen == 1) {
                            // Bottom screen is active - adjust coordinates for 320x240 screen centered in 400x240 logical area
                            int center_offset = (DS_TOP_SCREEN_WIDTH - DS_BOTTOM_SCREEN_WIDTH) / 2; // 40px
                            logical_x = logical_x - center_offset;
                            
                            // Clamp to bottom screen dimensions and validate
                            if (logical_x < 0 || logical_x > DS_BOTTOM_SCREEN_WIDTH || logical_y < 0 || logical_y > DS_BOTTOM_SCREEN_HEIGHT) {
                                // Return (0, 0) for out-of-bounds touch (consistent with original lpp-3ds)
                                lua_pushinteger(L, 0);
                                lua_pushinteger(L, 0);
                                return 2;
                            }
                        } else {
                            // Top screen is active - no touch input allowed (3DS top screen has no touch)
                            lua_pushinteger(L, 0);
                            lua_pushinteger(L, 0);
                            return 2;
                        }
                    } else {
                        // Dual-screen mode: convert to bottom screen coordinates
                        int bottom_x_offset = getScreenXOffset(1); // BOTTOM_SCREEN
                        int bottom_y_offset = getScreenYOffset(1);
                        
                        if (logical_x >= bottom_x_offset && logical_y >= bottom_y_offset) {
                            // Click is on bottom screen area - convert to local bottom screen coordinates
                            logical_x = logical_x - bottom_x_offset;
                            logical_y = logical_y - bottom_y_offset;
                            
                            // Clamp to bottom screen dimensions
                            if (logical_x > DS_BOTTOM_SCREEN_WIDTH) logical_x = DS_BOTTOM_SCREEN_WIDTH;
                            if (logical_y > DS_BOTTOM_SCREEN_HEIGHT) logical_y = DS_BOTTOM_SCREEN_HEIGHT;
                        } else {
                            // Click is not on bottom screen area - report no touch (consistent with original lpp-3ds)
                            lua_pushinteger(L, 0);
                            lua_pushinteger(L, 0);
                            return 2;
                        }
                    }
                    
                    // Return transformed 3DS coordinates
                    lua_pushinteger(L, logical_x);
                    lua_pushinteger(L, logical_y);
                    return 2;
                }
                // For Vita/Native mode, use simple coordinate passthrough
            }
        }
        
        // Debug output for final coordinates
        if (g_debug_mode && (debug_counter % 60) == 2) { // Print every 60th touch to avoid spam
            printf("[DEBUG] Returning coordinates: (%d,%d)\n", logical_x, logical_y);
        }
        
        lua_pushinteger(L, logical_x);
        lua_pushinteger(L, logical_y);
        return 2;
    }
    // Return different values based on compatibility mode when no touch is detected
    extern lpp_compat_mode_t g_compat_mode;
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // 3DS mode: return (0, 0) when no touch (expected by 3DS games)
        lua_pushinteger(L, 0);
        lua_pushinteger(L, 0);
        return 2;
    } else {
        // Vita/Native mode: return nil when no touch (original behavior)
        return 0;
    }
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

static int lua_getControllerStatus(lua_State *L) {
    int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
    if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
    
    // Create a table to return controller status
    lua_createtable(L, 0, 4); // Create table with 4 slots for controller info
    
    for (int i = 0; i < 4; i++) {
        // Create table for each controller slot
        lua_createtable(L, 0, 4); // Create table with 4 fields
        
        bool is_connected = false;
        const char* controller_name = "Disconnected";
        const char* controller_type = "none";
        
        if (controllers[i] && SDL_GameControllerGetAttached(controllers[i])) {
            is_connected = true;
            controller_name = SDL_GameControllerName(controllers[i]);
            controller_type = "gamecontroller";
        } else if (fallback_joysticks[i] && SDL_JoystickGetAttached(fallback_joysticks[i])) {
            is_connected = true;
            controller_name = SDL_JoystickName(fallback_joysticks[i]);
            controller_type = "joystick";
        }
        
        // Set fields in controller table
        lua_pushstring(L, "connected");
        lua_pushboolean(L, is_connected);
        lua_settable(L, -3);
        
        lua_pushstring(L, "name");
        lua_pushstring(L, controller_name ? controller_name : "Unknown");
        lua_settable(L, -3);
        
        lua_pushstring(L, "type");
        lua_pushstring(L, controller_type);
        lua_settable(L, -3);
        
        lua_pushstring(L, "port");
        lua_pushinteger(L, i);
        lua_settable(L, -3);
        
        // Add this controller table to the main table with 1-based indexing
        lua_rawseti(L, -2, i + 1);
    }
    
    return 1; // Return the table
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
  {"getControllerStatus", lua_getControllerStatus},
  {"headsetStatus",    lua_headset},
  {"readAccel",        lua_accel},
  {"readGyro",         lua_gyro},
  {"enableGyro",       lua_enablesensors},    
  {"enableAccel",      lua_enablesensors},    
  {"disableGyro",      lua_disablesensors},    
  {"disableAccel",     lua_disablesensors},
  {"getEnterButton",   lua_getenter},
  {"readCirclePad",    lua_readleft},  // Alias for 3DS compatibility
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

static void set_key_constants(lua_State *L) {
    extern lpp_compat_mode_t g_compat_mode;
    if (g_compat_mode == LPP_COMPAT_3DS) {
        // 3DS bit values (matching original 3DS)
        lua_pushinteger(L, (1 << 0));lua_setglobal(L, "KEY_A");      // BIT(0)
        lua_pushinteger(L, (1 << 1));lua_setglobal(L, "KEY_B");      // BIT(1)
        lua_pushinteger(L, (1 << 10));lua_setglobal(L, "KEY_X");     // BIT(10)
        lua_pushinteger(L, (1 << 11));lua_setglobal(L, "KEY_Y");     // BIT(11)
        lua_pushinteger(L, (1 << 9));lua_setglobal(L, "KEY_L");      // BIT(9)
        lua_pushinteger(L, (1 << 8));lua_setglobal(L, "KEY_R");      // BIT(8)
        lua_pushinteger(L, (1 << 3));lua_setglobal(L, "KEY_START");  // BIT(3)
        lua_pushinteger(L, (1 << 2));lua_setglobal(L, "KEY_SELECT"); // BIT(2)
        lua_pushinteger(L, (1 << 6));lua_setglobal(L, "KEY_DUP");    // BIT(6)
        lua_pushinteger(L, (1 << 7));lua_setglobal(L, "KEY_DDOWN");  // BIT(7)
        lua_pushinteger(L, (1 << 5));lua_setglobal(L, "KEY_DLEFT");  // BIT(5)
        lua_pushinteger(L, (1 << 4));lua_setglobal(L, "KEY_DRIGHT"); // BIT(4)
        lua_pushinteger(L, (1 << 20));lua_setglobal(L, "KEY_TOUCH"); // BIT(20)
    } else {
        // SDL scancodes for Vita/Native modes
        lua_pushinteger(L, SDL_SCANCODE_RETURN);lua_setglobal(L, "KEY_A");
        lua_pushinteger(L, SDL_SCANCODE_BACKSPACE);lua_setglobal(L, "KEY_B");
        lua_pushinteger(L, SDL_SCANCODE_SPACE);lua_setglobal(L, "KEY_X");
        lua_pushinteger(L, SDL_SCANCODE_LSHIFT);lua_setglobal(L, "KEY_Y");
        lua_pushinteger(L, SDL_SCANCODE_Q);lua_setglobal(L, "KEY_L");
        lua_pushinteger(L, SDL_SCANCODE_E);lua_setglobal(L, "KEY_R");
        lua_pushinteger(L, SDL_SCANCODE_LALT);lua_setglobal(L, "KEY_START");
        lua_pushinteger(L, SDL_SCANCODE_LCTRL);lua_setglobal(L, "KEY_SELECT");
        lua_pushinteger(L, SDL_SCANCODE_UP);lua_setglobal(L, "KEY_DUP");
        lua_pushinteger(L, SDL_SCANCODE_DOWN);lua_setglobal(L, "KEY_DDOWN");
        lua_pushinteger(L, SDL_SCANCODE_LEFT);lua_setglobal(L, "KEY_DLEFT");
        lua_pushinteger(L, SDL_SCANCODE_RIGHT);lua_setglobal(L, "KEY_DRIGHT");
        lua_pushinteger(L, 1000);lua_setglobal(L, "KEY_TOUCH"); // Special value for touch
    }
}

void luaControls_set_key_constants(lua_State *L) {
    set_key_constants(L);
}

void luaControls_init(lua_State *L) {
    lua_newtable(L);
    luaL_setfuncs(L, Controls_functions, 0);
    lua_setglobal(L, "Controls");
    
    // Set initial key constants (will be updated later if needed)
    set_key_constants(L);
    
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