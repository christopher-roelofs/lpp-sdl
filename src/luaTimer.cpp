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
*/

#include <SDL.h>
#include <stdlib.h>

extern "C" {
    #include "lua.h"
    #include "lualib.h"
    #include "lauxlib.h"
}

#include "luaplayer.h"

struct Timer {
    uint32_t magic;
    bool isPlaying;
    uint32_t tick;
};

// Timer.new()
// Returns a Timer object (backwards compatible with Vita API)
static int lua_timer_new(lua_State *L) {
    Timer* new_timer = (Timer*)malloc(sizeof(Timer));
    new_timer->tick = SDL_GetTicks();
    new_timer->magic = 0x4C544D52;
    new_timer->isPlaying = true;
    lua_pushinteger(L, (uintptr_t)new_timer);
    return 1;
}

// Timer.time(startTime) - original simplified API (for backwards compatibility)
// Returns the elapsed time in milliseconds since startTime.
static int lua_timer_time(lua_State *L) {
    int startTime = luaL_checkinteger(L, 1);
    int elapsed = SDL_GetTicks() - startTime;
    lua_pushinteger(L, elapsed);
    return 1;
}

// Timer.getTime(timer) - Vita API compatibility
// Returns elapsed time from timer object
static int lua_timer_getTime(lua_State *L) {
    Timer* src = (Timer*)luaL_checkinteger(L, 1);
    if (src->magic != 0x4C544D52)
        return luaL_error(L, "attempt to access wrong memory block type");
    
    if (src->isPlaying) {
        lua_pushinteger(L, SDL_GetTicks() - src->tick);
    } else {
        lua_pushinteger(L, src->tick);
    }
    return 1;
}

// Timer.reset(timer) - Vita API compatibility  
// Resets the timer to current time
static int lua_timer_reset(lua_State *L) {
    Timer* src = (Timer*)luaL_checkinteger(L, 1);
    if (src->magic != 0x4C544D52)
        return luaL_error(L, "attempt to access wrong memory block type");
    
    if (src->isPlaying)
        src->tick = SDL_GetTicks();
    else
        src->tick = 0;
    return 0;
}

// Timer.pause(timer) - Vita API compatibility
static int lua_timer_pause(lua_State *L) {
    Timer* src = (Timer*)luaL_checkinteger(L, 1);
    if (src->magic != 0x4C544D52)
        return luaL_error(L, "attempt to access wrong memory block type");
    
    if (src->isPlaying) {
        src->isPlaying = false;
        src->tick = SDL_GetTicks() - src->tick;
    }
    return 0;
}

// Timer.resume(timer) - Vita API compatibility
static int lua_timer_resume(lua_State *L) {
    Timer* src = (Timer*)luaL_checkinteger(L, 1);
    if (src->magic != 0x4C544D52)
        return luaL_error(L, "attempt to access wrong memory block type");
    
    if (!src->isPlaying) {
        src->isPlaying = true;
        src->tick = SDL_GetTicks() - src->tick;
    }
    return 0;
}

// Timer.setTime(timer, value) - Vita API compatibility
static int lua_timer_setTime(lua_State *L) {
    Timer* src = (Timer*)luaL_checkinteger(L, 1);
    uint32_t val = (uint32_t)luaL_checkinteger(L, 2);
    if (src->magic != 0x4C544D52)
        return luaL_error(L, "attempt to access wrong memory block type");
    
    if (src->isPlaying)
        src->tick = SDL_GetTicks() + val;
    else
        src->tick = val;
    return 0;
}

// Timer.isPlaying(timer) - Vita API compatibility
static int lua_timer_isPlaying(lua_State *L) {
    Timer* src = (Timer*)luaL_checkinteger(L, 1);
    if (src->magic != 0x4C544D52)
        return luaL_error(L, "attempt to access wrong memory block type");
    
    lua_pushboolean(L, src->isPlaying);
    return 1;
}

// Timer.destroy(timer) - Vita API compatibility
static int lua_timer_destroy(lua_State *L) {
    Timer* timer = (Timer*)luaL_checkinteger(L, 1);
    if (timer->magic != 0x4C544D52)
        return luaL_error(L, "attempt to access wrong memory block type");
    
    free(timer);
    return 0;
}

// Timer.sleep(milliseconds) - Sleep function for async compatibility
static int lua_timer_sleep(lua_State *L) {
    int ms = luaL_checkinteger(L, 1);
    SDL_Delay(ms);
    return 0;
}

static const luaL_Reg Timer_functions[] = {
    {"new", lua_timer_new},
    {"time", lua_timer_time},        // Keep original simple API
    {"getTime", lua_timer_getTime},  // Vita API compatibility
    {"reset", lua_timer_reset},      // Vita API compatibility  
    {"pause", lua_timer_pause},      // Vita API compatibility
    {"resume", lua_timer_resume},    // Vita API compatibility
    {"setTime", lua_timer_setTime},  // Vita API compatibility
    {"isPlaying", lua_timer_isPlaying}, // Vita API compatibility
    {"destroy", lua_timer_destroy},  // Vita API compatibility
    {"sleep", lua_timer_sleep},      // Sleep function for async compatibility
    {NULL, NULL}
};

void luaTimer_init(lua_State *L) {
    luaL_register(L, "Timer", Timer_functions);
}
