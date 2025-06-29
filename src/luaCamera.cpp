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
#- SDL Port: Camera Module Implementation using OpenCV ----------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------*/

#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <SDL.h>
#include <opencv2/opencv.hpp>
#include "luaplayer.h"

#define stringify(str) #str
#define VariableRegister(lua, value) do { lua_pushinteger(lua, value); lua_setglobal (lua, stringify(value)); } while(0)

// Camera constants matching Vita API
#define SCE_CAMERA_RESOLUTION_640_480 0
#define SCE_CAMERA_RESOLUTION_320_240 1
#define SCE_CAMERA_RESOLUTION_160_120 2
#define SCE_CAMERA_RESOLUTION_352_288 3
#define SCE_CAMERA_RESOLUTION_176_144 4
#define SCE_CAMERA_RESOLUTION_480_272 5
#define SCE_CAMERA_RESOLUTION_640_360 6

#define SCE_CAMERA_DEVICE_FRONT 0
#define SCE_CAMERA_DEVICE_BACK 1

#define SCE_CAMERA_ANTIFLICKER_AUTO 0
#define SCE_CAMERA_ANTIFLICKER_50HZ 1
#define SCE_CAMERA_ANTIFLICKER_60HZ 2
#define SCE_CAMERA_ISO_AUTO 0
#define SCE_CAMERA_ISO_100 100
#define SCE_CAMERA_ISO_200 200
#define SCE_CAMERA_ISO_400 400
#define SCE_CAMERA_WB_AUTO 0
#define SCE_CAMERA_WB_DAY 1
#define SCE_CAMERA_WB_CWF 2
#define SCE_CAMERA_WB_SLSA 3
#define SCE_CAMERA_BACKLIGHT_OFF 0
#define SCE_CAMERA_BACKLIGHT_ON 1
#define SCE_CAMERA_NIGHTMODE_OFF 0
#define SCE_CAMERA_NIGHTMODE_LESS10 1
#define SCE_CAMERA_NIGHTMODE_LESS100 2
#define SCE_CAMERA_NIGHTMODE_OVER100 3
#define SCE_CAMERA_REVERSE_OFF 0
#define SCE_CAMERA_REVERSE_MIRROR 1
#define SCE_CAMERA_REVERSE_FLIP 2
#define SCE_CAMERA_REVERSE_MIRROR_FLIP 3
#define SCE_CAMERA_EFFECT_NORMAL 0
#define SCE_CAMERA_EFFECT_NEGATIVE 1
#define SCE_CAMERA_EFFECT_BLACKWHITE 2
#define SCE_CAMERA_EFFECT_SEPIA 3
#define SCE_CAMERA_EFFECT_BLUE 4
#define SCE_CAMERA_EFFECT_RED 5
#define SCE_CAMERA_EFFECT_GREEN 6

#define FRAMERATES_NUM 9

// Global camera state
static cv::VideoCapture* camera = nullptr;
static cv::Mat current_frame;
static lpp_texture* cam_texture = nullptr;
static bool isCamOn = false;
static int cam_width = 640;
static int cam_height = 480;
static int cam_device = 0;
static int cam_effect = SCE_CAMERA_EFFECT_NORMAL;
static int cam_reverse = SCE_CAMERA_REVERSE_OFF;
static double cam_brightness = 0.5;
static double cam_contrast = 0.5;
static double cam_saturation = 0.5;

// Camera resolutions
uint8_t VGA_RES = SCE_CAMERA_RESOLUTION_640_480;
uint8_t QVGA_RES = SCE_CAMERA_RESOLUTION_320_240;
uint8_t QQVGA_RES = SCE_CAMERA_RESOLUTION_160_120;
uint8_t CIF_RES = SCE_CAMERA_RESOLUTION_352_288;
uint8_t QCIF_RES = SCE_CAMERA_RESOLUTION_176_144;
uint8_t PSP_RES = SCE_CAMERA_RESOLUTION_480_272;
uint8_t NGP_RES = SCE_CAMERA_RESOLUTION_640_360;

// Camera framerates
uint8_t framerates[FRAMERATES_NUM] = {3, 5, 7, 10, 15, 20, 30, 60, 120};

extern SDL_Renderer* g_renderer;

// Helper function to get resolution dimensions
void getResolutionDimensions(uint8_t res, int& width, int& height) {
    switch(res) {
        case SCE_CAMERA_RESOLUTION_640_480: width = 640; height = 480; break;
        case SCE_CAMERA_RESOLUTION_320_240: width = 320; height = 240; break;
        case SCE_CAMERA_RESOLUTION_160_120: width = 160; height = 120; break;
        case SCE_CAMERA_RESOLUTION_352_288: width = 352; height = 288; break;
        case SCE_CAMERA_RESOLUTION_176_144: width = 176; height = 144; break;
        case SCE_CAMERA_RESOLUTION_480_272: width = 480; height = 272; break;
        case SCE_CAMERA_RESOLUTION_640_360: width = 640; height = 360; break;
        default: width = 640; height = 480; break;
    }
}

// Apply effects to frame
void applyEffects(cv::Mat& frame) {
    switch(cam_effect) {
        case SCE_CAMERA_EFFECT_NEGATIVE:
            cv::bitwise_not(frame, frame);
            break;
        case SCE_CAMERA_EFFECT_BLACKWHITE:
            cv::cvtColor(frame, frame, cv::COLOR_BGR2GRAY);
            cv::cvtColor(frame, frame, cv::COLOR_GRAY2BGR);
            break;
        case SCE_CAMERA_EFFECT_SEPIA:
            {
                cv::Mat kernel = (cv::Mat_<float>(4, 4) <<
                    0.272, 0.534, 0.131, 0,
                    0.349, 0.686, 0.168, 0,
                    0.393, 0.769, 0.189, 0,
                    0, 0, 0, 1);
                cv::transform(frame, frame, kernel);
            }
            break;
        case SCE_CAMERA_EFFECT_BLUE:
            {
                std::vector<cv::Mat> channels;
                cv::split(frame, channels);
                channels[0] = cv::Mat::zeros(frame.rows, frame.cols, CV_8UC1); // Zero green
                channels[1] = cv::Mat::zeros(frame.rows, frame.cols, CV_8UC1); // Zero red
                cv::merge(channels, frame);
            }
            break;
        case SCE_CAMERA_EFFECT_RED:
            {
                std::vector<cv::Mat> channels;
                cv::split(frame, channels);
                channels[0] = cv::Mat::zeros(frame.rows, frame.cols, CV_8UC1); // Zero blue
                channels[1] = cv::Mat::zeros(frame.rows, frame.cols, CV_8UC1); // Zero green
                cv::merge(channels, frame);
            }
            break;
        case SCE_CAMERA_EFFECT_GREEN:
            {
                std::vector<cv::Mat> channels;
                cv::split(frame, channels);
                channels[0] = cv::Mat::zeros(frame.rows, frame.cols, CV_8UC1); // Zero blue
                channels[2] = cv::Mat::zeros(frame.rows, frame.cols, CV_8UC1); // Zero red
                cv::merge(channels, frame);
            }
            break;
    }
    
    // Apply reverse/mirror effects
    switch(cam_reverse) {
        case SCE_CAMERA_REVERSE_MIRROR:
            cv::flip(frame, frame, 1);
            break;
        case SCE_CAMERA_REVERSE_FLIP:
            cv::flip(frame, frame, 0);
            break;
        case SCE_CAMERA_REVERSE_MIRROR_FLIP:
            cv::flip(frame, frame, -1);
            break;
    }
}

// Convert OpenCV Mat to SDL texture
SDL_Texture* matToTexture(const cv::Mat& mat) {
    if (!g_renderer) return nullptr;
    
    SDL_Texture* texture = SDL_CreateTexture(g_renderer, SDL_PIXELFORMAT_BGR24, 
                                           SDL_TEXTUREACCESS_STREAMING, 
                                           mat.cols, mat.rows);
    if (!texture) return nullptr;
    
    void* pixels;
    int pitch;
    if (SDL_LockTexture(texture, nullptr, &pixels, &pitch) == 0) {
        memcpy(pixels, mat.data, mat.rows * mat.cols * 3);
        SDL_UnlockTexture(texture);
    }
    
    return texture;
}

// Initialize camera
void initCam(uint8_t type, uint8_t res, uint8_t fps) {
    getResolutionDimensions(res, cam_width, cam_height);
    cam_device = (type == SCE_CAMERA_DEVICE_FRONT) ? 0 : 1;
    
    // Try to open camera
    camera = new cv::VideoCapture(cam_device);
    if (!camera->isOpened()) {
        // Try default camera if specified device fails
        delete camera;
        camera = new cv::VideoCapture(0);
        if (!camera->isOpened()) {
            delete camera;
            camera = nullptr;
            return;
        }
    }
    
    // Set camera properties
    camera->set(cv::CAP_PROP_FRAME_WIDTH, cam_width);
    camera->set(cv::CAP_PROP_FRAME_HEIGHT, cam_height);
    camera->set(cv::CAP_PROP_FPS, fps);
    
    // Create texture for camera output
    cam_texture = (lpp_texture*)malloc(sizeof(lpp_texture));
    cam_texture->w = cam_width;
    cam_texture->h = cam_height;
    cam_texture->texture = nullptr;
    cam_texture->data = nullptr;
    cam_texture->magic = 0xABADBEEF;
}

// Camera.init(device, resolution, framerate)
static int lua_caminit(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 3) return luaL_error(L, "wrong number of arguments.");
    if (isCamOn) return luaL_error(L, "cannot start two camera instances together");
    
    uint8_t type = (uint8_t)luaL_checkinteger(L, 1);
    uint8_t resolution = (uint8_t)luaL_checkinteger(L, 2);
    uint8_t framerate = (uint8_t)luaL_checkinteger(L, 3);
    
    initCam(type, resolution, framerate);
    
    if (camera && camera->isOpened()) {
        isCamOn = true;
    } else {
        return luaL_error(L, "Failed to initialize camera");
    }
    
    return 0;
}

// Camera.getOutput() - Capture frame and return as texture
static int lua_camoutput(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) return luaL_error(L, "wrong number of arguments.");
    if (!isCamOn) return luaL_error(L, "camera has not been initialized.");
    if (!camera) return luaL_error(L, "camera is not available.");
    
    // Capture frame
    if (!camera->read(current_frame) || current_frame.empty()) {
        lua_pushinteger(L, 0);
        return 1;
    }
    
    // Resize frame to target resolution
    if (current_frame.cols != cam_width || current_frame.rows != cam_height) {
        cv::resize(current_frame, current_frame, cv::Size(cam_width, cam_height));
    }
    
    // Apply effects
    applyEffects(current_frame);
    
    // Update texture
    if (cam_texture->texture) {
        SDL_DestroyTexture((SDL_Texture*)cam_texture->texture);
    }
    cam_texture->texture = matToTexture(current_frame);
    
    lua_pushlightuserdata(L, cam_texture);
    return 1;
}

// Camera.switchDevice() - Switch camera device while maintaining settings
static int lua_switchdevice(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) return luaL_error(L, "wrong number of arguments.");
    if (!isCamOn) return luaL_error(L, "camera has not been initialized.");
    
    uint8_t new_device = (uint8_t)luaL_checkinteger(L, 1);
    
    // Save current settings
    int saved_width = cam_width;
    int saved_height = cam_height;
    int saved_effect = cam_effect;
    int saved_reverse = cam_reverse;
    double saved_brightness = cam_brightness;
    double saved_contrast = cam_contrast;
    double saved_saturation = cam_saturation;
    
    // Clean up current camera
    if (camera) {
        camera->release();
        delete camera;
        camera = nullptr;
    }
    
    if (cam_texture && cam_texture->texture) {
        SDL_DestroyTexture((SDL_Texture*)cam_texture->texture);
        cam_texture->texture = nullptr;
    }
    
    // Initialize new camera device
    cam_device = (new_device == SCE_CAMERA_DEVICE_FRONT) ? 0 : 1;
    
    camera = new cv::VideoCapture(cam_device);
    if (!camera->isOpened()) {
        // Try default camera if specified device fails
        delete camera;
        camera = new cv::VideoCapture(0);
        if (!camera->isOpened()) {
            delete camera;
            camera = nullptr;
            isCamOn = false;
            return luaL_error(L, "Failed to switch to camera device");
        }
    }
    
    // Restore camera properties
    camera->set(cv::CAP_PROP_FRAME_WIDTH, saved_width);
    camera->set(cv::CAP_PROP_FRAME_HEIGHT, saved_height);
    camera->set(cv::CAP_PROP_BRIGHTNESS, saved_brightness);
    camera->set(cv::CAP_PROP_CONTRAST, saved_contrast);
    camera->set(cv::CAP_PROP_SATURATION, saved_saturation);
    
    // Restore effect and reverse settings
    cam_effect = saved_effect;
    cam_reverse = saved_reverse;
    cam_brightness = saved_brightness;
    cam_contrast = saved_contrast;
    cam_saturation = saved_saturation;
    
    return 0;
}

// Camera.term() - Clean up camera
static int lua_camexit(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 0) return luaL_error(L, "wrong number of arguments.");
    if (!isCamOn) return luaL_error(L, "camera has not been initialized.");
    
    isCamOn = false;
    
    if (camera) {
        camera->release();
        delete camera;
        camera = nullptr;
    }
    
    if (cam_texture) {
        if (cam_texture->texture) {
            SDL_DestroyTexture((SDL_Texture*)cam_texture->texture);
        }
        free(cam_texture);
        cam_texture = nullptr;
    }
    
    return 0;
}

// Camera setting functions
static int lua_sbright(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) return luaL_error(L, "wrong number of arguments.");
    if (!isCamOn) return luaL_error(L, "camera has not been initialized.");
    
    int val = luaL_checkinteger(L, 1);
    cam_brightness = val / 255.0;
    if (camera) camera->set(cv::CAP_PROP_BRIGHTNESS, cam_brightness);
    return 0;
}

static int lua_ssat(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) return luaL_error(L, "wrong number of arguments.");
    if (!isCamOn) return luaL_error(L, "camera has not been initialized.");
    
    float val = luaL_checknumber(L, 1);
    cam_saturation = val / 10.0;
    if (camera) camera->set(cv::CAP_PROP_SATURATION, cam_saturation);
    return 0;
}

static int lua_ssharp(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) return luaL_error(L, "wrong number of arguments.");
    if (!isCamOn) return luaL_error(L, "camera has not been initialized.");
    
    int val = luaL_checkinteger(L, 1);
    (void)val; // Suppress unused variable warning
    // Sharpness is not directly supported by OpenCV, store for future use
    return 0;
}

static int lua_scontrast(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) return luaL_error(L, "wrong number of arguments.");
    if (!isCamOn) return luaL_error(L, "camera has not been initialized.");
    
    int val = luaL_checkinteger(L, 1);
    cam_contrast = val / 255.0;
    if (camera) camera->set(cv::CAP_PROP_CONTRAST, cam_contrast);
    return 0;
}

static int lua_srev(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) return luaL_error(L, "wrong number of arguments.");
    if (!isCamOn) return luaL_error(L, "camera has not been initialized.");
    
    int val = luaL_checkinteger(L, 1);
    cam_reverse = val;
    return 0;
}

static int lua_seffect(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) return luaL_error(L, "wrong number of arguments.");
    if (!isCamOn) return luaL_error(L, "camera has not been initialized.");
    
    int val = luaL_checkinteger(L, 1);
    cam_effect = val;
    return 0;
}

// Placeholder functions for settings not directly supported
static int lua_sexp(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) return luaL_error(L, "wrong number of arguments.");
    if (!isCamOn) return luaL_error(L, "camera has not been initialized.");
    
    float val = luaL_checknumber(L, 1);
    if (camera) camera->set(cv::CAP_PROP_EXPOSURE, val);
    return 0;
}

static int lua_szoom(lua_State *L) {
    int argc = lua_gettop(L);
    if (argc != 1) return luaL_error(L, "wrong number of arguments.");
    if (!isCamOn) return luaL_error(L, "camera has not been initialized.");
    
    int val = luaL_checkinteger(L, 1);
    if (camera) camera->set(cv::CAP_PROP_ZOOM, val);
    return 0;
}

// Stub functions for unsupported features
static int lua_santiflicker(lua_State *L) { return 0; }
static int lua_siso(lua_State *L) { return 0; }
static int lua_sgain(lua_State *L) { return 0; }
static int lua_swhite(lua_State *L) { return 0; }
static int lua_slight(lua_State *L) { return 0; }
static int lua_snight(lua_State *L) { return 0; }

// Getter functions
static int lua_gbright(lua_State *L) {
    lua_pushinteger(L, (int)(cam_brightness * 255));
    return 1;
}

static int lua_gsat(lua_State *L) {
    lua_pushnumber(L, cam_saturation * 10.0);
    return 1;
}

static int lua_gsharp(lua_State *L) {
    lua_pushinteger(L, 0);
    return 1;
}

static int lua_gcontrast(lua_State *L) {
    lua_pushinteger(L, (int)(cam_contrast * 255));
    return 1;
}

static int lua_grev(lua_State *L) {
    lua_pushinteger(L, cam_reverse);
    return 1;
}

static int lua_geffect(lua_State *L) {
    lua_pushnumber(L, cam_effect);
    return 1;
}

static int lua_gexp(lua_State *L) {
    lua_pushinteger(L, 0);
    return 1;
}

static int lua_gzoom(lua_State *L) {
    lua_pushinteger(L, 0);
    return 1;
}

static int lua_gantiflicker(lua_State *L) {
    lua_pushinteger(L, 0);
    return 1;
}

static int lua_giso(lua_State *L) {
    lua_pushinteger(L, 0);
    return 1;
}

static int lua_ggain(lua_State *L) {
    lua_pushinteger(L, 0);
    return 1;
}

static int lua_gwhite(lua_State *L) {
    lua_pushinteger(L, 0);
    return 1;
}

static int lua_glight(lua_State *L) {
    lua_pushinteger(L, 0);
    return 1;
}

static int lua_gnight(lua_State *L) {
    lua_pushinteger(L, 0);
    return 1;
}

// Register Camera Functions
static const luaL_Reg Camera_functions[] = {
    {"init",              lua_caminit},
    {"getOutput",         lua_camoutput},
    {"switchDevice",      lua_switchdevice},
    {"setBrightness",     lua_sbright},
    {"setSaturation",     lua_ssat},
    {"setSharpness",      lua_ssharp},
    {"setContrast",       lua_scontrast},
    {"setReverse",        lua_srev},
    {"setEffect",         lua_seffect},
    {"setExposure",       lua_sexp},
    {"setZoom",           lua_szoom},
    {"setAntiFlicker",    lua_santiflicker},
    {"setISO",            lua_siso},
    {"setGain",           lua_sgain},
    {"setWhiteBalance",   lua_swhite},
    {"setBacklight",      lua_slight},
    {"setNightmode",      lua_snight},
    {"getBrightness",     lua_gbright},
    {"getSaturation",     lua_gsat},
    {"getSharpness",      lua_gsharp},
    {"getContrast",       lua_gcontrast},
    {"getReverse",        lua_grev},
    {"getEffect",         lua_geffect},
    {"getExposure",       lua_gexp},
    {"getZoom",           lua_gzoom},
    {"getAntiFlicker",    lua_gantiflicker},
    {"getISO",            lua_giso},
    {"getGain",           lua_ggain},
    {"getWhiteBalance",   lua_gwhite},
    {"getBacklight",      lua_glight},
    {"getNightmode",      lua_gnight},
    {"term",              lua_camexit},
    {0, 0}
};

void luaCamera_init(lua_State *L) {
    lua_newtable(L);
    luaL_setfuncs(L, Camera_functions, 0);
    lua_setglobal(L, "Camera");
    
    // Camera device types
    uint8_t INNER_CAM = SCE_CAMERA_DEVICE_FRONT;
    uint8_t OUTER_CAM = SCE_CAMERA_DEVICE_BACK;
    VariableRegister(L, INNER_CAM);
    VariableRegister(L, OUTER_CAM);
    
    // Camera settings constants
    uint8_t ANTIFLICKER_AUTO = SCE_CAMERA_ANTIFLICKER_AUTO;
    uint8_t ANTIFLICKER_50HZ = SCE_CAMERA_ANTIFLICKER_50HZ;
    uint8_t ANTIFLICKER_60HZ = SCE_CAMERA_ANTIFLICKER_60HZ;
    uint16_t ISO_AUTO = SCE_CAMERA_ISO_AUTO;
    uint16_t ISO_100 = SCE_CAMERA_ISO_100;
    uint16_t ISO_200 = SCE_CAMERA_ISO_200;
    uint16_t ISO_400 = SCE_CAMERA_ISO_400;
    uint8_t WB_AUTO = SCE_CAMERA_WB_AUTO;
    uint8_t WB_DAYLIGHT = SCE_CAMERA_WB_DAY;
    uint8_t WB_CWF = SCE_CAMERA_WB_CWF;
    uint8_t WB_SLSA = SCE_CAMERA_WB_SLSA;
    uint8_t BACKLIGHT_OFF = SCE_CAMERA_BACKLIGHT_OFF;
    uint8_t BACKLIGHT_ON = SCE_CAMERA_BACKLIGHT_ON;
    uint8_t NIGHTMODE_OFF = SCE_CAMERA_NIGHTMODE_OFF;
    uint8_t NIGHTMODE_LOW = SCE_CAMERA_NIGHTMODE_LESS10;
    uint8_t NIGHTMODE_MED = SCE_CAMERA_NIGHTMODE_LESS100;
    uint8_t NIGHTMODE_HIGH = SCE_CAMERA_NIGHTMODE_OVER100;
    uint8_t REVERSE_OFF = SCE_CAMERA_REVERSE_OFF;
    uint8_t REVERSE_MIRROR = SCE_CAMERA_REVERSE_MIRROR;
    uint8_t REVERSE_FLIP = SCE_CAMERA_REVERSE_FLIP;
    uint8_t REVERSE_BOTH = SCE_CAMERA_REVERSE_MIRROR_FLIP;
    uint8_t EFFECT_NONE = SCE_CAMERA_EFFECT_NORMAL;
    uint8_t EFFECT_NEGATIVE = SCE_CAMERA_EFFECT_NEGATIVE;
    uint8_t EFFECT_BLACKWHITE = SCE_CAMERA_EFFECT_BLACKWHITE;
    uint8_t EFFECT_SEPIA = SCE_CAMERA_EFFECT_SEPIA;
    uint8_t EFFECT_BLUE = SCE_CAMERA_EFFECT_BLUE;
    uint8_t EFFECT_RED = SCE_CAMERA_EFFECT_RED;
    uint8_t EFFECT_GREEN = SCE_CAMERA_EFFECT_GREEN;
    
    VariableRegister(L, ANTIFLICKER_AUTO);
    VariableRegister(L, ANTIFLICKER_50HZ);
    VariableRegister(L, ANTIFLICKER_60HZ);
    VariableRegister(L, ISO_AUTO);
    VariableRegister(L, ISO_100);
    VariableRegister(L, ISO_200);
    VariableRegister(L, ISO_400);
    VariableRegister(L, WB_AUTO);
    VariableRegister(L, WB_DAYLIGHT);
    VariableRegister(L, WB_CWF);
    VariableRegister(L, WB_SLSA);
    VariableRegister(L, BACKLIGHT_OFF);
    VariableRegister(L, BACKLIGHT_ON);
    VariableRegister(L, NIGHTMODE_OFF);
    VariableRegister(L, NIGHTMODE_LOW);
    VariableRegister(L, NIGHTMODE_MED);
    VariableRegister(L, NIGHTMODE_HIGH);
    VariableRegister(L, REVERSE_OFF);
    VariableRegister(L, REVERSE_MIRROR);
    VariableRegister(L, REVERSE_FLIP);
    VariableRegister(L, REVERSE_BOTH);
    VariableRegister(L, EFFECT_NONE);
    VariableRegister(L, EFFECT_NEGATIVE);
    VariableRegister(L, EFFECT_BLACKWHITE);
    VariableRegister(L, EFFECT_SEPIA);
    VariableRegister(L, EFFECT_BLUE);
    VariableRegister(L, EFFECT_RED);
    VariableRegister(L, EFFECT_GREEN);
    
    // Camera Resolutions
    VariableRegister(L, VGA_RES);
    VariableRegister(L, QVGA_RES);
    VariableRegister(L, QQVGA_RES);
    VariableRegister(L, CIF_RES);
    VariableRegister(L, QCIF_RES);
    VariableRegister(L, PSP_RES);
    VariableRegister(L, NGP_RES);
}