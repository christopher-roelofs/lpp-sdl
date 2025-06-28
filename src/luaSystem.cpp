/*
* Clean, SDL-compatible implementation of luaSystem
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <sys/stat.h>
#include <unistd.h>
#include <dirent.h>
#include <time.h>
#include <SDL.h>
#include <errno.h>
#include <thread>
#include <atomic>
#include <algorithm>
#include "include/path_utils.h"

// Zip support
extern "C" {
#include "include/zip.h"
#include "include/unzip.h"
}

// Archive support (if enabled)
#ifdef USE_LIBARCHIVE
#include <archive.h>
#include <archive_entry.h>
#endif

// Platform-specific includes for disk space
#if defined(_WIN32)
#include <windows.h>
#elif defined(__linux__) || defined(__APPLE__)
#include <sys/statvfs.h>
#endif

extern "C" {
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
}

#include "luaplayer.h"

// External declarations for async variables defined in main_sdl.cpp
extern volatile int asyncResult;
extern uint8_t async_task_num;
extern unsigned char* asyncStrRes;
extern uint32_t asyncResSize;

// Zip-related globals
static char fname[512];
static char ext_fname[512];
static char read_buffer[8192];
static char asyncDest[512];
static char asyncName[512];
static unzFile asyncHandle;
static int asyncMode = 0;

// Async modes
enum {
    FULL_EXTRACT = 0,
    FILE_EXTRACT = 1
};

// Maximum async tasks
#define ASYNC_TASKS_MAX 1

// Helper function to translate console-specific paths for cross-platform compatibility
static std::string translate_console_path(const char* path) {
    extern lpp_compat_mode_t g_compat_mode;
    std::string result = PathUtils::translate_vita_path(path);
    bool was_console_path = (result != path);
    
    // Handle 3DS-specific paths: convert absolute paths to relative for desktop compatibility
    // Only convert simple absolute paths (like "/save.dat"), not full system paths or root directory
    if (g_compat_mode == LPP_COMPAT_3DS && !was_console_path && result.length() > 1 && result[0] == '/') {
        // Check if this is a simple 3DS-style path (no subdirectories) vs a full system path
        size_t second_slash = result.find('/', 1);
        if (second_slash == std::string::npos) {
            // Simple path like "/save.dat" - convert to relative
            // But preserve root directory "/" unchanged
            result = result.substr(1); // Remove leading slash to make it relative
            was_console_path = true;
        }
        // Full paths like "/home/user/..." and root "/" are left unchanged
    }
    
    // Only convert to relative path if it was originally a console-specific path
    // Preserve absolute paths for regular filesystem operations
    if (was_console_path && result.length() > 0 && result[0] == '/') {
        result = result.substr(1); // Remove leading slash to make it relative
    }
    
    return result;
}

// For stat() and mkdir() cross-platform compatibility
#if defined(_WIN32)
#include <direct.h>
#define stat _stat
#define mkdir(path, mode) _mkdir(path)
#endif

// Helper function to add a file to zip archive
static void addFileToZip(zipFile zf, const char* parent_path, const char* file_path, int compression_level) {
    std::string zip_path;
    const char* base_name = strrchr(file_path, '/');
    std::string filename = base_name ? (base_name + 1) : file_path;
    
    if (parent_path && strlen(parent_path) > 0) {
        zip_path = PathUtils::join(parent_path, filename);
    } else {
        zip_path = filename;
    }
    
    FILE* f = fopen(translate_console_path(file_path).c_str(), "rb");
    if (!f) return;
    
    zip_fileinfo zi = {};
    zipOpenNewFileInZip(zf, zip_path.c_str(), &zi, NULL, 0, NULL, 0, NULL, Z_DEFLATED, compression_level);
    
    char buffer[8192];
    size_t bytes_read;
    while ((bytes_read = fread(buffer, 1, sizeof(buffer), f)) > 0) {
        zipWriteInFileInZip(zf, buffer, bytes_read);
    }
    
    fclose(f);
    zipCloseFileInZip(zf);
}

// Helper function to add a directory to zip archive recursively
static void addDirToZip(zipFile zf, const char* parent_path, const char* dir_path, int compression_level) {
    std::string translated_path = translate_console_path(dir_path);
    DIR* dir = opendir(translated_path.c_str());
    if (!dir) return;
    
    struct dirent* entry;
    while ((entry = readdir(dir)) != NULL) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }
        
        std::string full_path = PathUtils::join(translated_path, entry->d_name);
        
        struct stat st;
        if (stat(full_path.c_str(), &st) == 0) {
            std::string zip_parent_path;
            
            if (parent_path && strlen(parent_path) > 0) {
                // We're in a subdirectory, use the current parent path
                zip_parent_path = parent_path;
            } else {
                // First level - use the directory name as the parent
                const char* base_name = strrchr(dir_path, '/');
                zip_parent_path = base_name ? (base_name + 1) : dir_path;
            }
            
            if (S_ISDIR(st.st_mode)) {
                // For subdirectories, include the subdirectory name in the path
                std::string subdir_zip_path = PathUtils::join(zip_parent_path, entry->d_name);
                addDirToZip(zf, subdir_zip_path.c_str(), full_path.c_str(), compression_level);
            } else {
                addFileToZip(zf, zip_parent_path.c_str(), full_path.c_str(), compression_level);
            }
        }
    }
    
    closedir(dir);
}

#define LUA_FILEHANDLE "FILE*"

// --- System wrapper functions ---

// System.doesFileExist(path)
static int lua_doesFileExist(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    
    // Translate Vita paths (app0:/ -> current directory)
    std::string translated_path = translate_console_path(path);
    // Convert Unix-style paths to platform-specific separators
    translated_path = PathUtils::unix_to_platform(translated_path);
    
    struct stat buffer;
    lua_pushboolean(L, (stat(translated_path.c_str(), &buffer) == 0));
    return 1;
}

// Helper function to create directory recursively
static bool mkdir_recursive(const std::string& path) {
    if (path.empty()) return true;
    
    struct stat st;
    if (stat(path.c_str(), &st) == 0) {
        return true; // Directory already exists
    }
    
    // Find parent directory
    size_t pos = path.find_last_of('/');
    if (pos != std::string::npos) {
        std::string parent = path.substr(0, pos);
        if (!mkdir_recursive(parent)) {
            return false;
        }
    }
    
    // Create this directory
    return mkdir(path.c_str(), 0777) == 0;
}

// Helper function for recursive directory creation for zip extraction  
static void recursive_mkdir(const char* path) {
    std::string path_str(path);
    size_t pos = path_str.find_last_of('/');
    if (pos != std::string::npos) {
        std::string parent = path_str.substr(0, pos);
        mkdir_recursive(parent);
    }
}

// Async zip thread function
static void zipThread() {
    if (asyncMode == FULL_EXTRACT) {
        // Full zip extraction
        unz_global_info global_info;
        unz_file_info file_info;
        unzGetGlobalInfo(asyncHandle, &global_info);
        unzGoToFirstFile(asyncHandle);
        uint64_t curr_file_bytes = 0;
        int num_files = global_info.number_entry;
        
        for (int zip_idx = 0; zip_idx < num_files; ++zip_idx) {
            unzGetCurrentFileInfo(asyncHandle, &file_info, fname, 512, NULL, 0, NULL, 0);
            sprintf(ext_fname, "%s%s", asyncDest, fname);
            const size_t filename_length = strlen(ext_fname);
            
            if (ext_fname[filename_length - 1] != '/') {
                curr_file_bytes = 0;
                unzOpenCurrentFile(asyncHandle);
                recursive_mkdir(ext_fname);
                FILE *f = fopen(ext_fname, "wb");
                if (f) {
                    while (curr_file_bytes < file_info.uncompressed_size) {
                        int rbytes = unzReadCurrentFile(asyncHandle, read_buffer, 8192);
                        if (rbytes > 0) {
                            fwrite(read_buffer, 1, rbytes, f);
                            curr_file_bytes += rbytes;
                        }
                    }
                    fclose(f);
                }
                unzCloseCurrentFile(asyncHandle);
            }
            
            if ((zip_idx + 1) < num_files)
                unzGoToNextFile(asyncHandle);
        }
        
        asyncResult = 1; // Success
    } else if (asyncMode == FILE_EXTRACT) {
        // Single file extraction
        unz_global_info global_info;
        unz_file_info file_info;
        unzGetGlobalInfo(asyncHandle, &global_info);
        unzGoToFirstFile(asyncHandle);
        uint64_t curr_file_bytes = 0;
        int num_files = global_info.number_entry;
        
        for (int zip_idx = 0; zip_idx < num_files; ++zip_idx) {
            unzGetCurrentFileInfo(asyncHandle, &file_info, fname, 512, NULL, 0, NULL, 0);
            if (!strcmp(fname, asyncName)) {
                curr_file_bytes = 0;
                unzOpenCurrentFile(asyncHandle);
                FILE *f = fopen(asyncDest, "wb");
                if (f) {
                    while (curr_file_bytes < file_info.uncompressed_size) {
                        int rbytes = unzReadCurrentFile(asyncHandle, read_buffer, 8192);
                        if (rbytes > 0) {
                            fwrite(read_buffer, 1, rbytes, f);
                            curr_file_bytes += rbytes;
                        }
                    }
                    fclose(f);
                }
                unzCloseCurrentFile(asyncHandle);
                break;
            }
            if ((zip_idx + 1) < num_files)
                unzGoToNextFile(asyncHandle);
        }
        
        asyncResult = 1; // Success
    }
    
    unzClose(asyncHandle);
    async_task_num--;
}

// System.createDirectory(path)
static int lua_createDirectory(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    
    // Translate Vita paths
    std::string translated_path = translate_console_path(path);
    bool success = mkdir_recursive(translated_path);
    lua_pushboolean(L, success);
    return 1;
}

// System.exit()
static int lua_exit(lua_State *L) {
    exit(0);
    return 0;
}

// --- File Handle Operations ---

// System.openFile(path, mode)
static int lua_openFile(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    
    // Translate Vita paths (app0:/ -> current directory)  
    std::string translated_path = translate_console_path(path);
    // Convert Unix-style paths to platform-specific separators
    translated_path = PathUtils::unix_to_platform(translated_path);
    const char *mode_str = NULL;

    if (lua_isstring(L, 2)) {
        const char* mode_arg = luaL_checkstring(L, 2);
        
        // Check if it's a numeric string (FREAD, FWRITE, etc. constants)
        if (strcmp(mode_arg, "0") == 0) {
            mode_str = "rb";   // FREAD
        } else if (strcmp(mode_arg, "1") == 0) {
            mode_str = "wb";   // FWRITE
        } else if (strcmp(mode_arg, "2") == 0) {
            mode_str = "w+b";  // FCREATE
        } else if (strcmp(mode_arg, "3") == 0) {
            mode_str = "r+b";  // FRDWR
        } else {
            // Assume it's a direct mode string like "rb", "wb", etc.
            mode_str = mode_arg;
        }
    } else {
        int mode = luaL_checkinteger(L, 2);
        // Mapping from Vita constants to C standard modes
        switch (mode) {
            case 0: mode_str = "rb"; break;   // FREAD
            case 1: mode_str = "wb"; break;   // FWRITE
            case 2: mode_str = "w+b"; break;  // FCREATE
            case 3: mode_str = "r+b"; break;  // FRDWR
            default: return luaL_error(L, "Invalid file mode integer");
        }
    }

    FILE **ud = (FILE **)lua_newuserdata(L, sizeof(FILE *));
    *ud = fopen(translated_path.c_str(), mode_str);

    if (*ud == NULL) {
        lua_pushnil(L);
        return 1;
    }

    luaL_getmetatable(L, LUA_FILEHANDLE);
    lua_setmetatable(L, -2);
    return 1;
}

// System.closeFile(filehandle)
static int lua_closeFile(lua_State *L) {
    FILE **ud = (FILE **)luaL_checkudata(L, 1, LUA_FILEHANDLE);
    if (*ud) {
        int result = fclose(*ud);
        *ud = NULL;
        lua_pushboolean(L, result == 0);
        return 1;
    }
    lua_pushboolean(L, false);
    return 1;
}

// System.sizeFile(filehandle)
static int lua_sizeFile(lua_State *L) {
    FILE **ud = (FILE **)luaL_checkudata(L, 1, LUA_FILEHANDLE);
    if (*ud) {
        long current_pos = ftell(*ud);
        fseek(*ud, 0, SEEK_END);
        long size = ftell(*ud);
        fseek(*ud, current_pos, SEEK_SET);
        lua_pushinteger(L, size);
    } else {
        lua_pushnil(L);
    }
    return 1;
}

// System.seekFile(filehandle, offset, origin)
static int lua_seekFile(lua_State *L) {
    FILE **ud = (FILE **)luaL_checkudata(L, 1, LUA_FILEHANDLE);
    if (*ud) {
        long offset = luaL_checklong(L, 2);
        int origin = luaL_checkinteger(L, 3);
        int whence;
        switch(origin) {
            case 0: whence = SEEK_SET; break; // SET
            case 1: whence = SEEK_CUR; break; // CUR
            case 2: whence = SEEK_END; break; // END
            default: return luaL_error(L, "Invalid seek origin");
        }
        int result = fseek(*ud, offset, whence);
        lua_pushboolean(L, result == 0);
    } else {
        lua_pushboolean(L, 0);
    }
    return 1;
}

// System.readFile(filehandle, num_bytes)
static int lua_readFile(lua_State *L) {
    FILE **ud = (FILE **)luaL_checkudata(L, 1, LUA_FILEHANDLE);
    if (!*ud) {
        lua_pushnil(L);
        return 1;
    }

    // Read all bytes if num_bytes is not provided or is -1
    long num_bytes_to_read;
    if (lua_isnoneornil(L, 2) || lua_tointeger(L, 2) == -1) {
        long current_pos = ftell(*ud);
        fseek(*ud, 0, SEEK_END);
        num_bytes_to_read = ftell(*ud) - current_pos;
        fseek(*ud, current_pos, SEEK_SET);
    } else {
        num_bytes_to_read = luaL_checklong(L, 2);
    }

    if (num_bytes_to_read <= 0) {
        lua_pushstring(L, "");
        return 1;
    }

    char *buffer = (char *)malloc(num_bytes_to_read);
    if (!buffer) {
        return luaL_error(L, "malloc failed in readFile");
    }

    size_t bytes_read = fread(buffer, 1, num_bytes_to_read, *ud);
    lua_pushlstring(L, buffer, bytes_read);
    free(buffer);
    return 1;
}

// System.writeFile(filehandle, data)
static int lua_writeFile(lua_State *L) {
    FILE **ud = (FILE **)luaL_checkudata(L, 1, LUA_FILEHANDLE);
    if (!*ud) {
        lua_pushboolean(L, 0);
        return 1;
    }
    size_t len;
    const char *data = luaL_checklstring(L, 2, &len);
    size_t bytes_written = fwrite(data, 1, len, *ud);
    lua_pushboolean(L, bytes_written == len);
    return 1;
}

// Compatibility wrapper for 3DS-style io.write(filehandle, offset, data, length)
static int lua_iowrite_3ds(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 4) {
        return luaL_error(L, "io.write(filehandle, offset, data, length): wrong number of arguments");
    }
    
    FILE **ud = (FILE **)luaL_checkudata(L, 1, LUA_FILEHANDLE);
    if (!*ud) {
        return luaL_error(L, "Attempt to use a closed file");
    }
    
    // For now, ignore the offset (argument 2) - 3DS might use this differently
    // int offset = luaL_checkinteger(L, 2);
    
    size_t len;
    const char *data = luaL_checklstring(L, 3, &len);
    int specified_length = luaL_checkinteger(L, 4);
    
    // Use the minimum of the string length and specified length
    size_t write_len = (specified_length < (int)len) ? specified_length : len;
    
    size_t bytes_written = fwrite(data, 1, write_len, *ud);
    lua_pushboolean(L, bytes_written == write_len);
    return 1;
}

// Compatibility wrapper for 3DS-style io.read(filehandle, offset, length)
static int lua_ioread_3ds(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 3) {
        return luaL_error(L, "io.read(filehandle, offset, length): wrong number of arguments");
    }
    
    FILE **ud = (FILE **)luaL_checkudata(L, 1, LUA_FILEHANDLE);
    if (!*ud) {
        return luaL_error(L, "Attempt to use a closed file");
    }
    
    int offset = luaL_checkinteger(L, 2);
    int length = luaL_checkinteger(L, 3);
    
    // Seek to the specified offset
    if (fseek(*ud, offset, SEEK_SET) != 0) {
        lua_pushnil(L);
        return 1;
    }
    
    // Allocate buffer for reading
    char *buffer = (char *)malloc(length + 1);
    if (!buffer) {
        return luaL_error(L, "Memory allocation failed");
    }
    
    // Read the data
    size_t bytes_read = fread(buffer, 1, length, *ud);
    buffer[bytes_read] = '\0'; // Null-terminate
    
    // Push the result as a string
    lua_pushlstring(L, buffer, bytes_read);
    free(buffer);
    
    return 1;
}

// --- Dummy implementations for compatibility ---
static int lua_checkInput(lua_State *L) {
    lua_pushstring(L, "");
    return 1;
}

// System.getBatteryPercentage() - Use SDL_PowerState for real battery info
static int lua_getBatteryPercentage(lua_State *L) {
    int secs, pct;
    SDL_PowerState power_state = SDL_GetPowerInfo(&secs, &pct);
    
    // If battery percentage is available, return it
    if (pct >= 0) {
        lua_pushinteger(L, pct);
    } else {
        // If no battery info available (desktop/plugged in), return 100
        switch (power_state) {
            case SDL_POWERSTATE_NO_BATTERY:
            case SDL_POWERSTATE_CHARGING:
            case SDL_POWERSTATE_CHARGED:
                lua_pushinteger(L, 100);
                break;
            case SDL_POWERSTATE_ON_BATTERY:
                // Battery exists but percentage unknown, estimate 50%
                lua_pushinteger(L, 50);
                break;
            default:
                // Unknown power state, return 100 as safe default
                lua_pushinteger(L, 100);
                break;
        }
    }
    return 1;
}

// System.getBatteryInfo() - Extended battery information
static int lua_getBatteryInfo(lua_State *L) {
    int secs, pct;
    SDL_PowerState power_state = SDL_GetPowerInfo(&secs, &pct);
    
    lua_newtable(L);
    
    // Add battery percentage
    if (pct >= 0) {
        lua_pushinteger(L, pct);
    } else {
        lua_pushnil(L);
    }
    lua_setfield(L, -2, "percentage");
    
    // Add time remaining in seconds (if available)
    if (secs >= 0) {
        lua_pushinteger(L, secs);
    } else {
        lua_pushnil(L);
    }
    lua_setfield(L, -2, "secondsLeft");
    
    // Add power state as string
    const char* state_str;
    switch (power_state) {
        case SDL_POWERSTATE_UNKNOWN:   state_str = "unknown"; break;
        case SDL_POWERSTATE_ON_BATTERY: state_str = "battery"; break;
        case SDL_POWERSTATE_NO_BATTERY: state_str = "no_battery"; break;
        case SDL_POWERSTATE_CHARGING:   state_str = "charging"; break;
        case SDL_POWERSTATE_CHARGED:    state_str = "charged"; break;
        default:                        state_str = "unknown"; break;
    }
    lua_pushstring(L, state_str);
    lua_setfield(L, -2, "state");
    
    // Add charging boolean for convenience
    lua_pushboolean(L, power_state == SDL_POWERSTATE_CHARGING);
    lua_setfield(L, -2, "charging");
    
    return 1;
}

// System.isBatteryCharging() - Returns true if battery is charging
static int lua_isBatteryCharging(lua_State *L) {
    int secs, pct;
    SDL_PowerState power_state = SDL_GetPowerInfo(&secs, &pct);
    lua_pushboolean(L, power_state == SDL_POWERSTATE_CHARGING);
    return 1;
}

// System.deleteFile(path) - Missing function for tetromino compatibility  
static int lua_deleteFile(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    std::string translated_path = translate_console_path(path);
    translated_path = PathUtils::unix_to_platform(translated_path);
    bool success = (unlink(translated_path.c_str()) == 0);
    lua_pushboolean(L, success);
    return 1;
}

// System.shouldExit() - Check if ESC was pressed or window closed
extern bool should_exit; // Defined in main_sdl.cpp
static int lua_shouldExit(lua_State *L) {
    lua_pushboolean(L, should_exit);
    return 1;
}

// System.getTime() - Get current local time (hour, minute, second)
static int lua_getTime(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    // Get current time using C++ standard library
    time_t rawtime;
    struct tm* timeinfo;
    
    time(&rawtime);
    timeinfo = localtime(&rawtime);
    
    // Push hour, minute, second to Lua stack
    lua_pushinteger(L, timeinfo->tm_hour);
    lua_pushinteger(L, timeinfo->tm_min);
    lua_pushinteger(L, timeinfo->tm_sec);
    
    return 3; // Return 3 values: hour, minute, second
}

// Power management functions - SDL stubs for Vita compatibility
static int lua_setCpuSpeed(lua_State *L) {
    // SDL doesn't have CPU speed control, just return success
    lua_pushboolean(L, true);
    return 1;
}

static int lua_setGpuSpeed(lua_State *L) {
    // SDL doesn't have GPU speed control, just return success
    lua_pushboolean(L, true);
    return 1;
}

static int lua_setGpuXbarSpeed(lua_State *L) {
    // SDL doesn't have GPU Xbar speed control, just return success
    lua_pushboolean(L, true);
    return 1;
}

// Get username (Vita compatibility)
static int lua_getUsername(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    // Try to get username from environment
    const char* username = getenv("USER");
    if (!username) {
        username = getenv("USERNAME"); // Windows
    }
    if (!username) {
        username = "user"; // Default fallback
    }
    
    lua_pushstring(L, username);
    return 1;
}

// Power tick (Vita compatibility - prevents system sleep)
static int lua_powerTick(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    // On desktop, we don't need to prevent sleep, but we can use SDL's built-in functionality
    // SDL_DisableScreenSaver() prevents screensaver, which is similar behavior
    // This is already called in main, so this is just a stub for compatibility
    
    return 0;
}

static int lua_setBusSpeed(lua_State *L) {
    // SDL doesn't have bus speed control, just return success
    lua_pushboolean(L, true);
    return 1;
}

// System.wait() - Sleep function for tetromino compatibility
static int lua_wait(lua_State *L) {
    int microseconds = luaL_checkinteger(L, 1);
    // Convert microseconds to milliseconds for Vita compatibility
    int ms = microseconds / 1000;
    if (ms < 1) ms = 1; // Minimum 1ms delay
    SDL_Delay(ms);
    return 0;
}

// System.takeScreenshot() - Capture and save current screen
static int lua_screenshot(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc < 1 || argc > 2) {
        return luaL_error(L, "System.takeScreenshot(filename, [format]): wrong number of arguments");
    }
    
    const char* filename = luaL_checkstring(L, 1);
    bool unused_param = (argc == 2) ? lua_toboolean(L, 2) : false; // Second param ignored for compatibility
    (void)unused_param; // Suppress unused warning
    
    // Translate console path (Vita/3DS paths to SDL paths)
    std::string translated_path = translate_console_path(filename);
    
    extern SDL_Renderer* g_renderer;
    if (!g_renderer) {
        return luaL_error(L, "No renderer available for screenshot");
    }
    
    // Get renderer output size
    int width, height;
    if (SDL_GetRendererOutputSize(g_renderer, &width, &height) != 0) {
        return luaL_error(L, "Failed to get renderer size: %s", SDL_GetError());
    }
    
    // Create surface to hold screenshot data
    SDL_Surface* screenshot = SDL_CreateRGBSurface(0, width, height, 32,
        0x00FF0000, 0x0000FF00, 0x000000FF, 0xFF000000);
    if (!screenshot) {
        return luaL_error(L, "Failed to create screenshot surface: %s", SDL_GetError());
    }
    
    // Save current clip rect state to restore later
    SDL_Rect clip_rect;
    SDL_bool clip_enabled = SDL_RenderIsClipEnabled(g_renderer);
    if (clip_enabled) {
        SDL_RenderGetClipRect(g_renderer, &clip_rect);
    }
    
    // Temporarily disable clipping to ensure all screen content is visible
    SDL_RenderSetClipRect(g_renderer, NULL);
    
    // Read pixels from renderer (now captures all content without clipping)
    int read_result = SDL_RenderReadPixels(g_renderer, NULL, SDL_PIXELFORMAT_ARGB8888, 
                                         screenshot->pixels, screenshot->pitch);
    
    // Restore original clip rect state
    if (clip_enabled) {
        SDL_RenderSetClipRect(g_renderer, &clip_rect);
    }
    
    if (read_result != 0) {
        SDL_FreeSurface(screenshot);
        return luaL_error(L, "Failed to read pixels: %s", SDL_GetError());
    }
    
    // Determine format based on file extension
    std::string path_str(translated_path);
    std::string ext = path_str.substr(path_str.find_last_of(".") + 1);
    std::transform(ext.begin(), ext.end(), ext.begin(), ::tolower);
    
    int result = 0;
    if (ext == "bmp") {
        result = SDL_SaveBMP(screenshot, translated_path.c_str());
    } else if (ext == "png") {
        // For PNG, we'd need to use IMG_SavePNG or implement libpng saving
        // For now, fall back to BMP and warn
        printf("Warning: PNG format requested but saving as BMP instead\n");
        result = SDL_SaveBMP(screenshot, translated_path.c_str());
    } else {
        // Default to BMP for unknown extensions
        result = SDL_SaveBMP(screenshot, translated_path.c_str());
    }
    
    SDL_FreeSurface(screenshot);
    
    if (result != 0) {
        return luaL_error(L, "Failed to save screenshot: %s", SDL_GetError());
    }
    
    return 0;
}

// System.doesDirExist() - Check if directory exists
static int lua_doesDirExist(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    std::string translated_path = translate_console_path(path);
    translated_path = PathUtils::unix_to_platform(translated_path);
    
    struct stat buffer;
    bool exists = (stat(translated_path.c_str(), &buffer) == 0 && S_ISDIR(buffer.st_mode));
    lua_pushboolean(L, exists);
    return 1;
}

// System.listDirectory(path) - List files and directories in a path
static int lua_listDirectory(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "System.listDirectory(path) takes one argument");
    }
    
    const char *path = luaL_checkstring(L, 1);
    
    // Translate Vita paths (app0:/ -> current directory, ux0:/ -> .)
    std::string translated_path = translate_console_path(path);
    translated_path = PathUtils::unix_to_platform(translated_path);
    
    // Create a table to return
    lua_newtable(L);
    
    // Open directory
    DIR *dir;
    struct dirent *entry;
    
    dir = opendir(translated_path.c_str());
    if (dir == NULL) {
        // Return empty table if directory doesn't exist
        return 1;
    }
    
    int i = 1;
    while ((entry = readdir(dir)) != NULL) {
        // Skip . and .. entries
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }
        
        // Create table index (1-based for Lua)
        lua_pushnumber(L, i++);
        
        // Create table for this entry
        lua_newtable(L);
        
        // Add name field
        lua_pushstring(L, "name");
        lua_pushstring(L, entry->d_name);
        lua_settable(L, -3);
        
        // Get file stats for size and directory flag
        std::string full_path = translated_path;
        if (full_path.back() != '/' && full_path.back() != '\\') {
            full_path += '/';
        }
        full_path += entry->d_name;
        
        struct stat st;
        if (stat(full_path.c_str(), &st) == 0) {
            // Add size field
            lua_pushstring(L, "size");
            lua_pushnumber(L, (lua_Number)st.st_size);
            lua_settable(L, -3);
            
            // Add directory flag (legacy compatibility)
            lua_pushstring(L, "directory");
            lua_pushboolean(L, S_ISDIR(st.st_mode));
            lua_settable(L, -3);
            
            // Add type field (file/directory)
            lua_pushstring(L, "type");
            lua_pushstring(L, S_ISDIR(st.st_mode) ? "directory" : "file");
            lua_settable(L, -3);
            
            // Add modification time
            lua_pushstring(L, "mtime");
            lua_pushnumber(L, (lua_Number)st.st_mtime);
            lua_settable(L, -3);
            
            // Add access time
            lua_pushstring(L, "atime");
            lua_pushnumber(L, (lua_Number)st.st_atime);
            lua_settable(L, -3);
            
            // Add creation time (same as mtime on Unix systems)
            lua_pushstring(L, "ctime");
            lua_pushnumber(L, (lua_Number)st.st_ctime);
            lua_settable(L, -3);
        } else {
            // If stat fails, set defaults
            lua_pushstring(L, "size");
            lua_pushnumber(L, 0);
            lua_settable(L, -3);
            
            lua_pushstring(L, "directory");
            lua_pushboolean(L, false);
            lua_settable(L, -3);
            
            lua_pushstring(L, "type");
            lua_pushstring(L, "unknown");
            lua_settable(L, -3);
            
            lua_pushstring(L, "mtime");
            lua_pushnumber(L, 0);
            lua_settable(L, -3);
            
            lua_pushstring(L, "atime");
            lua_pushnumber(L, 0);
            lua_settable(L, -3);
            
            lua_pushstring(L, "ctime");
            lua_pushnumber(L, 0);
            lua_settable(L, -3);
        }
        
        // Add entry to main table
        lua_settable(L, -3);
    }
    
    closedir(dir);
    return 1;  // Return the table
}

// --- Custom dofile with Vita path translation ---
static int lua_dofile_vita(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) {
        return luaL_error(L, "wrong number of arguments");
    }
    
    const char *path = luaL_checkstring(L, 1);
    std::string translated_path = translate_console_path(path);
    // Convert Unix-style paths to platform-specific separators
    translated_path = PathUtils::unix_to_platform(translated_path);
    
    // Use luaL_dofile with the translated path
    int status = luaL_dofile(L, translated_path.c_str());
    if (status) {
        // If there was an error, the error message is on the top of the stack
        return lua_error(L);
    }
    
    // If no return values, return nil
    if (lua_gettop(L) == argc) {
        lua_pushnil(L);
        return 1;
    } else {
        // Return all return values from the file
        return lua_gettop(L) - argc;
    }
}

// System.statFile(path) - Get file metadata/statistics
static int lua_statFile(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    std::string translated_path = translate_console_path(path);
    translated_path = PathUtils::unix_to_platform(translated_path);
    
    struct stat st;
    if (stat(translated_path.c_str(), &st) != 0) {
        lua_pushnil(L);
        return 1;
    }
    
    // Create table with file statistics
    lua_newtable(L);
    
    // File size
    lua_pushstring(L, "size");
    lua_pushnumber(L, (lua_Number)st.st_size);
    lua_settable(L, -3);
    
    // Is directory
    lua_pushstring(L, "directory");
    lua_pushboolean(L, S_ISDIR(st.st_mode));
    lua_settable(L, -3);
    
    // Modification time (Unix timestamp)
    lua_pushstring(L, "mtime");
    lua_pushnumber(L, (lua_Number)st.st_mtime);
    lua_settable(L, -3);
    
    // Access time (Unix timestamp)
    lua_pushstring(L, "atime");
    lua_pushnumber(L, (lua_Number)st.st_atime);
    lua_settable(L, -3);
    
    // Creation/change time (Unix timestamp)
    lua_pushstring(L, "ctime");
    lua_pushnumber(L, (lua_Number)st.st_ctime);
    lua_settable(L, -3);
    
    // File mode/permissions
    lua_pushstring(L, "mode");
    lua_pushinteger(L, st.st_mode);
    lua_settable(L, -3);
    
    return 1;
}

// System.statOpenedFile(filehandle) - Get statistics for open file handles
static int lua_statOpenedFile(lua_State *L) {
    FILE **ud = (FILE **)luaL_checkudata(L, 1, LUA_FILEHANDLE);
    if (!*ud) {
        lua_pushnil(L);
        return 1;
    }
    
    // Get file descriptor and then stat it
    int fd = fileno(*ud);
    if (fd == -1) {
        lua_pushnil(L);
        return 1;
    }
    
    struct stat st;
    if (fstat(fd, &st) != 0) {
        lua_pushnil(L);
        return 1;
    }
    
    // Create table with file statistics (same format as statFile)
    lua_newtable(L);
    
    lua_pushstring(L, "size");
    lua_pushnumber(L, (lua_Number)st.st_size);
    lua_settable(L, -3);
    
    lua_pushstring(L, "directory");
    lua_pushboolean(L, S_ISDIR(st.st_mode));
    lua_settable(L, -3);
    
    lua_pushstring(L, "mtime");
    lua_pushnumber(L, (lua_Number)st.st_mtime);
    lua_settable(L, -3);
    
    lua_pushstring(L, "atime");
    lua_pushnumber(L, (lua_Number)st.st_atime);
    lua_settable(L, -3);
    
    lua_pushstring(L, "ctime");
    lua_pushnumber(L, (lua_Number)st.st_ctime);
    lua_settable(L, -3);
    
    lua_pushstring(L, "mode");
    lua_pushinteger(L, st.st_mode);
    lua_settable(L, -3);
    
    return 1;
}

// System.copyFile(src, dest) - Copy files
static int lua_copyFile(lua_State *L) {
    const char *src_path = luaL_checkstring(L, 1);
    const char *dest_path = luaL_checkstring(L, 2);
    
    std::string translated_src = translate_console_path(src_path);
    translated_src = PathUtils::unix_to_platform(translated_src);
    std::string translated_dest = translate_console_path(dest_path);
    translated_dest = PathUtils::unix_to_platform(translated_dest);
    
    FILE *src_file = fopen(translated_src.c_str(), "rb");
    if (!src_file) {
        lua_pushboolean(L, false);
        lua_pushstring(L, "Cannot open source file");
        return 2;
    }
    
    FILE *dest_file = fopen(translated_dest.c_str(), "wb");
    if (!dest_file) {
        fclose(src_file);
        lua_pushboolean(L, false);
        lua_pushstring(L, "Cannot create destination file");
        return 2;
    }
    
    // Copy in chunks
    const size_t buffer_size = 8192;
    char *buffer = (char *)malloc(buffer_size);
    if (!buffer) {
        fclose(src_file);
        fclose(dest_file);
        lua_pushboolean(L, false);
        lua_pushstring(L, "Memory allocation failed");
        return 2;
    }
    
    bool success = true;
    size_t bytes_read;
    while ((bytes_read = fread(buffer, 1, buffer_size, src_file)) > 0) {
        if (fwrite(buffer, 1, bytes_read, dest_file) != bytes_read) {
            success = false;
            break;
        }
    }
    
    free(buffer);
    fclose(src_file);
    fclose(dest_file);
    
    if (!success) {
        // Clean up failed copy
        unlink(translated_dest.c_str());
    }
    
    lua_pushboolean(L, success);
    if (!success) {
        lua_pushstring(L, "Copy operation failed");
        return 2;
    }
    return 1;
}

// System.rename(oldpath, newpath) - Rename/move files and directories
static int lua_rename(lua_State *L) {
    const char *old_path = luaL_checkstring(L, 1);
    const char *new_path = luaL_checkstring(L, 2);
    
    std::string translated_old = translate_console_path(old_path);
    translated_old = PathUtils::unix_to_platform(translated_old);
    std::string translated_new = translate_console_path(new_path);
    translated_new = PathUtils::unix_to_platform(translated_new);
    
    int result = rename(translated_old.c_str(), translated_new.c_str());
    lua_pushboolean(L, result == 0);
    
    if (result != 0) {
        lua_pushstring(L, strerror(errno));
        return 2;
    }
    return 1;
}

// Helper function to remove directory recursively
static bool remove_directory_recursive(const std::string& path) {
    DIR *dir = opendir(path.c_str());
    if (!dir) {
        return false;
    }
    
    struct dirent *entry;
    bool success = true;
    
    while ((entry = readdir(dir)) != NULL && success) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }
        
        std::string full_path = PathUtils::join(path, entry->d_name);
        struct stat st;
        
        if (stat(full_path.c_str(), &st) == 0) {
            if (S_ISDIR(st.st_mode)) {
                success = remove_directory_recursive(full_path);
            } else {
                success = (unlink(full_path.c_str()) == 0);
            }
        }
    }
    
    closedir(dir);
    
    if (success) {
        success = (rmdir(path.c_str()) == 0);
    }
    
    return success;
}

// System.deleteDirectory(path) - Remove directories
static int lua_deleteDirectory(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    std::string translated_path = translate_console_path(path);
    
    // Check if it's actually a directory
    struct stat st;
    if (stat(translated_path.c_str(), &st) != 0) {
        lua_pushboolean(L, false);
        lua_pushstring(L, "Directory does not exist");
        return 2;
    }
    
    if (!S_ISDIR(st.st_mode)) {
        lua_pushboolean(L, false);
        lua_pushstring(L, "Path is not a directory");
        return 2;
    }
    
    bool success = remove_directory_recursive(translated_path);
    lua_pushboolean(L, success);
    
    if (!success) {
        lua_pushstring(L, "Failed to remove directory");
        return 2;
    }
    return 1;
}

// System.getFreeSpace(path) - Get available storage space
static int lua_getFreeSpace(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    std::string translated_path = translate_console_path(path);
    
#if defined(_WIN32)
    ULARGE_INTEGER free_bytes;
    if (GetDiskFreeSpaceExA(translated_path.c_str(), &free_bytes, NULL, NULL)) {
        lua_pushnumber(L, (lua_Number)free_bytes.QuadPart);
    } else {
        lua_pushnil(L);
    }
#elif defined(__linux__) || defined(__APPLE__)
    struct statvfs stat_buf;
    if (statvfs(translated_path.c_str(), &stat_buf) == 0) {
        uint64_t free_space = (uint64_t)stat_buf.f_bavail * stat_buf.f_frsize;
        lua_pushnumber(L, (lua_Number)free_space);
    } else {
        lua_pushnil(L);
    }
#else
    lua_pushnil(L);
#endif
    
    return 1;
}

// System.getTotalSpace(path) - Get total storage capacity
static int lua_getTotalSpace(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    std::string translated_path = translate_console_path(path);
    
#if defined(_WIN32)
    ULARGE_INTEGER total_bytes;
    if (GetDiskFreeSpaceExA(translated_path.c_str(), NULL, &total_bytes, NULL)) {
        lua_pushnumber(L, (lua_Number)total_bytes.QuadPart);
    } else {
        lua_pushnil(L);
    }
#elif defined(__linux__) || defined(__APPLE__)
    struct statvfs stat_buf;
    if (statvfs(translated_path.c_str(), &stat_buf) == 0) {
        uint64_t total_space = (uint64_t)stat_buf.f_blocks * stat_buf.f_frsize;
        lua_pushnumber(L, (lua_Number)total_space);
    } else {
        lua_pushnil(L);
    }
#else
    lua_pushnil(L);
#endif
    
    return 1;
}

// --- Zip Functions ---

// System.extractZip(filename, dirname)
static int lua_extractZip(lua_State *L) {
    const char* file_to_extract = luaL_checkstring(L, 1);
    const char* dir_to_extract = luaL_checkstring(L, 2);
    
    std::string translated_file = translate_console_path(file_to_extract);
    std::string dest_dir = translate_console_path(dir_to_extract);
    
    // Ensure destination directory ends with /
    if (dest_dir.back() != '/') {
        dest_dir += '/';
    }
    
    mkdir_recursive(dest_dir);
    
    unz_global_info global_info;
    unz_file_info file_info;
    unzFile zipfile = unzOpen(translated_file.c_str());
    if (!zipfile) {
        lua_pushboolean(L, false);
        return 1;
    }
    
    unzGetGlobalInfo(zipfile, &global_info);
    unzGoToFirstFile(zipfile);
    uint64_t curr_file_bytes = 0;
    int num_files = global_info.number_entry;
    
    
    for (int zip_idx = 0; zip_idx < num_files; ++zip_idx) {
        unzGetCurrentFileInfo(zipfile, &file_info, fname, 512, NULL, 0, NULL, 0);
        std::string extract_path = dest_dir + fname;
        printf("Processing file: %s -> %s\n", fname, extract_path.c_str());
        
        if (fname[strlen(fname) - 1] != '/') {
            curr_file_bytes = 0;
            unzOpenCurrentFile(zipfile);
            recursive_mkdir(extract_path.c_str());
            FILE *f = fopen(extract_path.c_str(), "wb");
            if (f) {
                while (curr_file_bytes < file_info.uncompressed_size) {
                    int rbytes = unzReadCurrentFile(zipfile, read_buffer, 8192);
                    if (rbytes > 0) {
                        fwrite(read_buffer, 1, rbytes, f);
                        curr_file_bytes += rbytes;
                    }
                }
                fclose(f);
            }
            unzCloseCurrentFile(zipfile);
        }
        
        if ((zip_idx + 1) < num_files)
            unzGoToNextFile(zipfile);
    }
    
    unzClose(zipfile);
    lua_pushboolean(L, true);
    return 1;
}

// System.extractZipAsync(filename, dirname)
static int lua_extractZipAsync(lua_State *L) {
    if (async_task_num >= ASYNC_TASKS_MAX) {
        lua_pushboolean(L, false);
        return 1;
    }
    
    const char* file_to_extract = luaL_checkstring(L, 1);
    const char* dir_to_extract = luaL_checkstring(L, 2);
    
    std::string translated_file = translate_console_path(file_to_extract);
    std::string dest_dir = translate_console_path(dir_to_extract);
    
    // Ensure destination directory ends with /
    if (dest_dir.back() != '/') {
        dest_dir += '/';
    }
    strcpy(asyncDest, dest_dir.c_str());
    
    mkdir_recursive(dest_dir);
    asyncHandle = unzOpen(translated_file.c_str());
    if (!asyncHandle) {
        lua_pushboolean(L, false);
        return 1;
    }
    
    asyncMode = FULL_EXTRACT;
    async_task_num++;
    asyncResult = 0;
    
    std::thread(zipThread).detach();
    lua_pushboolean(L, true);
    return 1;
}

// System.extractFromZip(zipfile, filename, destination)
static int lua_extractFromZip(lua_State *L) {
    const char* zip_file = luaL_checkstring(L, 1);
    const char* filename = luaL_checkstring(L, 2);
    const char* destination = luaL_checkstring(L, 3);
    
    std::string translated_zip = translate_console_path(zip_file);
    std::string translated_dest = translate_console_path(destination);
    
    unz_global_info global_info;
    unz_file_info file_info;
    unzFile zipfile = unzOpen(translated_zip.c_str());
    if (!zipfile) {
        lua_pushboolean(L, false);
        return 1;
    }
    
    unzGetGlobalInfo(zipfile, &global_info);
    unzGoToFirstFile(zipfile);
    uint64_t curr_file_bytes = 0;
    int num_files = global_info.number_entry;
    bool found = false;
    
    for (int zip_idx = 0; zip_idx < num_files; ++zip_idx) {
        unzGetCurrentFileInfo(zipfile, &file_info, fname, 512, NULL, 0, NULL, 0);
        if (!strcmp(fname, filename)) {
            curr_file_bytes = 0;
            unzOpenCurrentFile(zipfile);
            FILE *f = fopen(translated_dest.c_str(), "wb");
            if (f) {
                while (curr_file_bytes < file_info.uncompressed_size) {
                    int rbytes = unzReadCurrentFile(zipfile, read_buffer, 8192);
                    if (rbytes > 0) {
                        fwrite(read_buffer, 1, rbytes, f);
                        curr_file_bytes += rbytes;
                    }
                }
                fclose(f);
                found = true;
            }
            unzCloseCurrentFile(zipfile);
            break;
        }
        if ((zip_idx + 1) < num_files)
            unzGoToNextFile(zipfile);
    }
    
    unzClose(zipfile);
    lua_pushboolean(L, found);
    return 1;
}

// System.extractFromZipAsync(zipfile, filename, destination)
static int lua_extractFromZipAsync(lua_State *L) {
    if (async_task_num >= ASYNC_TASKS_MAX) {
        lua_pushboolean(L, false);
        return 1;
    }
    
    const char* zip_file = luaL_checkstring(L, 1);
    const char* filename = luaL_checkstring(L, 2);
    const char* destination = luaL_checkstring(L, 3);
    
    std::string translated_zip = translate_console_path(zip_file);
    std::string translated_dest = translate_console_path(destination);
    
    asyncHandle = unzOpen(translated_zip.c_str());
    if (!asyncHandle) {
        lua_pushboolean(L, false);
        return 1;
    }
    
    asyncMode = FILE_EXTRACT;
    strcpy(asyncDest, translated_dest.c_str());
    strcpy(asyncName, filename);
    async_task_num++;
    asyncResult = 0;
    
    std::thread(zipThread).detach();
    lua_pushboolean(L, true);
    return 1;
}

// System.compressZip(path, filename, ratio)
static int lua_compressZip(lua_State *L) {
    const char* path_to_compress = luaL_checkstring(L, 1);
    const char* zip_filename = luaL_checkstring(L, 2);
    int compression_level = Z_DEFAULT_COMPRESSION;
    if (lua_gettop(L) >= 3) {
        compression_level = luaL_checkinteger(L, 3);
    }
    
    std::string translated_path = translate_console_path(path_to_compress);
    std::string translated_zip = translate_console_path(zip_filename);
    
    zipFile zf = zipOpen(translated_zip.c_str(), APPEND_STATUS_CREATE);
    if (!zf) {
        printf("Failed to create zip file: %s\n", translated_zip.c_str());
        lua_pushboolean(L, false);
        return 1;
    }
    // Check if it's a file or directory
    struct stat st;
    if (stat(translated_path.c_str(), &st) == 0) {
        if (S_ISDIR(st.st_mode)) {
            addDirToZip(zf, "", translated_path.c_str(), compression_level);
        } else {
            addFileToZip(zf, "", translated_path.c_str(), compression_level);
        }
    }
    
    zipClose(zf, nullptr);
    lua_pushboolean(L, true);
    return 1;
}

// System.addToZip(path, filename, parent, ratio)
static int lua_addToZip(lua_State *L) {
    const char* path_to_add = luaL_checkstring(L, 1);
    const char* zip_filename = luaL_checkstring(L, 2);
    const char* parent_path = luaL_checkstring(L, 3);
    int compression_level = Z_DEFAULT_COMPRESSION;
    if (lua_gettop(L) >= 4) {
        compression_level = luaL_checkinteger(L, 4);
    }
    
    std::string translated_path = translate_console_path(path_to_add);
    std::string translated_zip = translate_console_path(zip_filename);
    
    zipFile zf = zipOpen(translated_zip.c_str(), APPEND_STATUS_ADDINZIP);
    if (!zf) {
        lua_pushboolean(L, false);
        return 1;
    }
    
    // Check if it's a file or directory
    struct stat st;
    if (stat(translated_path.c_str(), &st) == 0) {
        if (S_ISDIR(st.st_mode)) {
            addDirToZip(zf, parent_path, translated_path.c_str(), compression_level);
        } else {
            addFileToZip(zf, parent_path, translated_path.c_str(), compression_level);
        }
        zipClose(zf, nullptr);
        lua_pushboolean(L, true);
        return 1;
    } else {
        // File/directory doesn't exist
        zipClose(zf, nullptr);
        lua_pushboolean(L, false);
        return 1;
    }
}

#ifdef USE_LIBARCHIVE
// System.unarchive(archive_path, destination_path)
static int lua_unarchive(lua_State *L) {
    const char* archive_path = luaL_checkstring(L, 1);
    const char* dest_path = luaL_checkstring(L, 2);
    
    std::string translated_archive = translate_console_path(archive_path);
    std::string translated_dest = translate_console_path(dest_path);
    
    struct archive *a;
    struct archive *ext;
    struct archive_entry *entry;
    int flags;
    int r;
    
    // Select which attributes we want to restore
    flags = ARCHIVE_EXTRACT_TIME;
    flags |= ARCHIVE_EXTRACT_PERM;
    flags |= ARCHIVE_EXTRACT_ACL;
    flags |= ARCHIVE_EXTRACT_FFLAGS;
    
    a = archive_read_new();
    archive_read_support_format_all(a);
    archive_read_support_filter_all(a);
    
    ext = archive_write_disk_new();
    archive_write_disk_set_options(ext, flags);
    archive_write_disk_set_standard_lookup(ext);
    
    if ((r = archive_read_open_filename(a, translated_archive.c_str(), 10240))) {
        archive_read_free(a);
        archive_write_free(ext);
        lua_pushboolean(L, false);
        lua_pushstring(L, archive_error_string(a));
        return 2;
    }
    
    for (;;) {
        r = archive_read_next_header(a, &entry);
        if (r == ARCHIVE_EOF)
            break;
        if (r < ARCHIVE_OK) {
            archive_read_free(a);
            archive_write_free(ext);
            lua_pushboolean(L, false);
            lua_pushstring(L, archive_error_string(a));
            return 2;
        }
        
        // Prepend destination path to entry pathname
        std::string entry_path = translated_dest + "/" + archive_entry_pathname(entry);
        archive_entry_set_pathname(entry, entry_path.c_str());
        
        r = archive_write_header(ext, entry);
        if (r < ARCHIVE_OK) {
            continue; // Skip problematic entries
        } else if (archive_entry_size(entry) > 0) {
            const void *buff;
            size_t size;
            la_int64_t offset;
            
            for (;;) {
                r = archive_read_data_block(a, &buff, &size, &offset);
                if (r == ARCHIVE_EOF)
                    break;
                if (r < ARCHIVE_OK) {
                    break;
                }
                r = archive_write_data_block(ext, buff, size, offset);
                if (r < ARCHIVE_OK) {
                    break;
                }
            }
        }
        r = archive_write_finish_entry(ext);
    }
    
    archive_read_close(a);
    archive_read_free(a);
    archive_write_close(ext);
    archive_write_free(ext);
    
    lua_pushboolean(L, true);
    return 1;
}

// System.detectArchiveFormat(archive_path)
static int lua_detectArchiveFormat(lua_State *L) {
    const char* archive_path = luaL_checkstring(L, 1);
    std::string translated_archive = translate_console_path(archive_path);
    
    struct archive *a;
    struct archive_entry *entry;
    int r;
    
    a = archive_read_new();
    archive_read_support_format_all(a);
    archive_read_support_filter_all(a);
    
    if ((r = archive_read_open_filename(a, translated_archive.c_str(), 10240))) {
        archive_read_free(a);
        lua_pushnil(L);
        lua_pushstring(L, archive_error_string(a));
        return 2;
    }
    
    // Try to read first header to detect format
    r = archive_read_next_header(a, &entry);
    
    const char* format_name = "unknown";
    if (r >= ARCHIVE_OK) {
        format_name = archive_format_name(a);
        // Ensure format_name is valid and not null
        if (!format_name || strlen(format_name) == 0) {
            format_name = "unknown";
        }
    }
    
    archive_read_close(a);
    archive_read_free(a);
    
    lua_pushstring(L, format_name ? format_name : "unknown");
    return 1;
}
#endif

// System.getAsyncState()
static int lua_getAsyncState(lua_State *L) {
    lua_pushinteger(L, asyncResult);
    return 1;
}

// System.getAsyncResult()
static int lua_getAsyncResult(lua_State *L) {
    if (asyncStrRes != nullptr) {
        lua_pushlstring(L, (const char*)asyncStrRes, asyncResSize);
        free(asyncStrRes);
        asyncStrRes = nullptr;
        return 1;
    }
    return 0;
}

// System.currentDirectory([path])
static int lua_currentDirectory(lua_State *L) {
    int argc = lua_gettop(L);
    
    if (argc == 0) {
        // Get current directory
        char current_dir[1024];
        if (getcwd(current_dir, sizeof(current_dir)) != nullptr) {
            lua_pushstring(L, current_dir);
            return 1;
        } else {
            return luaL_error(L, "Failed to get current directory: %s", strerror(errno));
        }
    } else if (argc == 1) {
        // Change directory
        const char* new_dir = luaL_checkstring(L, 1);
        std::string translated_path = translate_console_path(new_dir);
        
        if (chdir(translated_path.c_str()) == 0) {
            // Successfully changed directory, return new current directory
            char current_dir[1024];
            if (getcwd(current_dir, sizeof(current_dir)) != nullptr) {
                lua_pushstring(L, current_dir);
                return 1;
            } else {
                return luaL_error(L, "Failed to get current directory after change: %s", strerror(errno));
            }
        } else {
            return luaL_error(L, "Failed to change directory to '%s': %s", translated_path.c_str(), strerror(errno));
        }
    } else {
        return luaL_error(L, "System.currentDirectory([path]): wrong number of arguments");
    }
}

// Path utility functions for Lua scripts

// Path.join(base, relative) - Join two path components using correct platform separator
static int lua_pathJoin(lua_State *L) {
    const char *base = luaL_checkstring(L, 1);
    const char *relative = luaL_checkstring(L, 2);
    
    std::string result = PathUtils::join(std::string(base), std::string(relative));
    lua_pushstring(L, result.c_str());
    return 1;
}

// Path.normalize(path) - Normalize a path to use correct platform separators
static int lua_pathNormalize(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    
    std::string result = PathUtils::normalize(std::string(path));
    lua_pushstring(L, result.c_str());
    return 1;
}

// Path.getSeparator() - Get the platform-specific path separator
static int lua_pathGetSeparator(lua_State *L) {
    char sep = PathUtils::get_separator();
    char sep_str[2] = {sep, '\0'};
    lua_pushstring(L, sep_str);
    return 1;
}

// Path.isAbsolute(path) - Check if a path is absolute
static int lua_pathIsAbsolute(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    
    bool result = PathUtils::is_absolute(std::string(path));
    lua_pushboolean(L, result);
    return 1;
}

// Path.getDirectory(path) - Get directory part of a path
static int lua_pathGetDirectory(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    
    std::string result = PathUtils::get_directory(std::string(path));
    lua_pushstring(L, result.c_str());
    return 1;
}

// Path.getFilename(path) - Get filename part of a path
static int lua_pathGetFilename(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    
    std::string result = PathUtils::get_filename(std::string(path));
    lua_pushstring(L, result.c_str());
    return 1;
}

// System.setGamepadLayout(layout) - Set gamepad button layout (0=Nintendo, 1=Xbox)
static int lua_setGamepadLayout(lua_State *L) {
    int layout = luaL_checkinteger(L, 1);
    if (layout < 0 || layout > 1) {
        return luaL_error(L, "Invalid gamepad layout. Use 0 for Nintendo or 1 for Xbox.");
    }
    
    extern int g_gamepad_layout;
    g_gamepad_layout = layout;
    
    return 0;
}

// System.getGamepadLayout() - Get current gamepad button layout
static int lua_getGamepadLayout(lua_State *L) {
    extern int g_gamepad_layout;
    lua_pushinteger(L, g_gamepad_layout);
    return 1;
}

// --- Module Registration ---

static const luaL_Reg System_functions[] = {
    {"doesFileExist",       lua_doesFileExist},
    {"createDirectory",     lua_createDirectory},
    {"currentDirectory",    lua_currentDirectory},
    {"exit",               lua_exit},
    {"openFile",           lua_openFile},
    {"closeFile",          lua_closeFile},
    {"sizeFile",           lua_sizeFile},
    {"seekFile",           lua_seekFile},
    {"readFile",           lua_readFile},
    {"writeFile",          lua_writeFile},
    {"checkInput",         lua_checkInput},
    {"getBatteryLife",     lua_getBatteryPercentage},  // Alias for compatibility
    {"getBatteryPercentage", lua_getBatteryPercentage},
    {"getBatteryInfo",     lua_getBatteryInfo},
    {"isBatteryCharging",  lua_isBatteryCharging},
    {"deleteFile",         lua_deleteFile},
    {"shouldExit",         lua_shouldExit},
    {"setCpuSpeed",        lua_setCpuSpeed},
    {"setGpuSpeed",        lua_setGpuSpeed},
    {"setGpuXbarSpeed",    lua_setGpuXbarSpeed},
    {"getUsername",        lua_getUsername},
    {"powerTick",          lua_powerTick},
    {"setBusSpeed",        lua_setBusSpeed},
    {"wait",               lua_wait},
    {"takeScreenshot",     lua_screenshot},
    {"doesDirExist",       lua_doesDirExist},
    {"listDirectory",      lua_listDirectory},
    {"getTime",            lua_getTime},
    {"statFile",           lua_statFile},
    {"statOpenedFile",     lua_statOpenedFile},
    {"copyFile",           lua_copyFile},
    {"rename",             lua_rename},
    {"deleteDirectory",    lua_deleteDirectory},
    {"getFreeSpace",       lua_getFreeSpace},
    {"getTotalSpace",      lua_getTotalSpace},
    {"extractZip",         lua_extractZip},
    {"extractZipAsync",    lua_extractZipAsync},
    {"extractFromZip",     lua_extractFromZip},
    {"extractFromZipAsync", lua_extractFromZipAsync},
    {"compressZip",        lua_compressZip},
    {"addToZip",           lua_addToZip},
#ifdef USE_LIBARCHIVE
    {"unarchive",          lua_unarchive},
    {"detectArchiveFormat", lua_detectArchiveFormat},
#endif
    {"getAsyncState",      lua_getAsyncState},
    {"getAsyncResult",     lua_getAsyncResult},
    {"setGamepadLayout",   lua_setGamepadLayout},
    {"getGamepadLayout",   lua_getGamepadLayout},
    {NULL, NULL}
};

static const luaL_Reg FileHandle_methods[] = {
    {"size",  lua_sizeFile},
    {"seek",  lua_seekFile},
    {"read",  lua_readFile},
    {"write", lua_writeFile},
    {"stat",  lua_statOpenedFile},
    {"__gc",  lua_closeFile},
    {NULL, NULL}
};

static const luaL_Reg Path_functions[] = {
    {"join",         lua_pathJoin},
    {"normalize",    lua_pathNormalize},
    {"getSeparator", lua_pathGetSeparator},
    {"isAbsolute",   lua_pathIsAbsolute},
    {"getDirectory", lua_pathGetDirectory},
    {"getFilename",  lua_pathGetFilename},
    {NULL, NULL}
};

void luaSystem_init(lua_State *L) {
    // Create metatable for file handles
    luaL_newmetatable(L, LUA_FILEHANDLE);
    lua_pushvalue(L, -1);
    lua_setfield(L, -2, "__index");
    luaL_setfuncs(L, FileHandle_methods, 0);
    lua_pop(L, 1); // pop metatable

    // Create System table
    lua_newtable(L);
    luaL_setfuncs(L, System_functions, 0);
    lua_setglobal(L, "System");
    
    // Create Path table for cross-platform path utilities
    lua_newtable(L);
    luaL_setfuncs(L, Path_functions, 0);
    lua_setglobal(L, "Path");
    
    // Set file mode constants
    lua_pushinteger(L, 0); lua_setglobal(L, "FREAD");
    lua_pushinteger(L, 1); lua_setglobal(L, "FWRITE");
    lua_pushinteger(L, 2); lua_setglobal(L, "FCREATE");
    lua_pushinteger(L, 3); lua_setglobal(L, "FRDWR");

    // Set seek constants
    lua_pushinteger(L, 0); lua_setglobal(L, "SET");
    lua_pushinteger(L, 1); lua_setglobal(L, "CUR");
    lua_pushinteger(L, 2); lua_setglobal(L, "END");

    // Set gamepad layout constants
    lua_pushinteger(L, 0); lua_setglobal(L, "GAMEPAD_NINTENDO");
    lua_pushinteger(L, 1); lua_setglobal(L, "GAMEPAD_XBOX");

    // Override dofile with Vita path translation (only for vita paths)
    lua_register(L, "dofile", lua_dofile_vita);

    // Register dummy checkInput
    lua_register(L, "checkInput", lua_checkInput);
    
    // Create io table for 3DS compatibility (aliases to System functions)
    lua_newtable(L);
    
    // io.open = System.openFile
    lua_getglobal(L, "System");
    lua_getfield(L, -1, "openFile");
    lua_setfield(L, -3, "open");
    lua_pop(L, 1); // pop System table
    
    // io.close = System.closeFile  
    lua_getglobal(L, "System");
    lua_getfield(L, -1, "closeFile");
    lua_setfield(L, -3, "close");
    lua_pop(L, 1); // pop System table
    
    // io.read = lua_ioread_3ds (3DS-compatible version)
    lua_pushcfunction(L, lua_ioread_3ds);
    lua_setfield(L, -2, "read");
    
    // io.write = lua_iowrite_3ds (3DS-compatible version)
    lua_pushcfunction(L, lua_iowrite_3ds);
    lua_setfield(L, -2, "write");
    
    // io.size = System.sizeFile
    lua_getglobal(L, "System");
    lua_getfield(L, -1, "sizeFile");
    lua_setfield(L, -3, "size");
    lua_pop(L, 1); // pop System table
    
    lua_setglobal(L, "io");
}
