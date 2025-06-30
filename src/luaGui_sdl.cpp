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
#- SDL Port: GUI Module with ImGui -------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------*/

#include <stdlib.h>
#include <string.h>
#include <string>
#include <unordered_map>
#include <GL/gl.h>
#include <SDL2/SDL.h>
#include "imgui.h"
#include "imgui_impl_sdl2.h"
#include "imgui_impl_opengl3.h"
#include "imgui_impl_opengl2.h"
#include "luaplayer.h"

// ImGui backend type tracking
enum ImGuiBackendType {
    IMGUI_BACKEND_NONE = 0,
    IMGUI_BACKEND_OPENGL3,
    IMGUI_BACKEND_OPENGL2,
    IMGUI_BACKEND_SDL_RENDERER
};

static ImGuiBackendType g_imgui_backend = IMGUI_BACKEND_NONE;

// OpenGL capability detection
static bool detectOpenGLCapabilities(int* major, int* minor, bool* is_es) {
    const char* version_str = (const char*)glGetString(GL_VERSION);
    if (!version_str) return false;
    
    *is_es = (strstr(version_str, "OpenGL ES") != nullptr);
    
    if (*is_es) {
        // Parse "OpenGL ES X.Y" or "OpenGL ES-XX X.Y"
        if (sscanf(version_str, "OpenGL ES %d.%d", major, minor) == 2 ||
            sscanf(version_str, "OpenGL ES-CM %d.%d", major, minor) == 2 ||
            sscanf(version_str, "OpenGL ES-CL %d.%d", major, minor) == 2) {
            return true;
        }
    } else {
        // Parse desktop OpenGL "X.Y" 
        if (sscanf(version_str, "%d.%d", major, minor) == 2) {
            return true;
        }
    }
    
    return false;
}

static const char* selectGLSLVersion(int major, int minor, bool is_es) {
    if (is_es) {
        if (major >= 3 || (major == 3 && minor >= 0)) {
            return "#version 300 es";  // OpenGL ES 3.0+
        } else {
            return "#version 100";     // OpenGL ES 2.0
        }
    } else {
        if (major >= 4 || (major == 3 && minor >= 3)) {
            return "#version 330";     // OpenGL 3.3+
        } else if (major >= 3 || (major == 3 && minor >= 0)) {
            return "#version 130";     // OpenGL 3.0-3.2
        } else {
            return "#version 110";     // OpenGL 2.x
        }
    }
}

#define stringify(str) #str
#define VariableRegister(lua, value) do { lua_pushinteger(lua, value); lua_setglobal (lua, stringify(value)); } while(0)

// External variables from main SDL setup
extern SDL_Window* g_window;
extern SDL_GLContext g_gl_context;
extern bool g_imgui_initialized;

// Theme constants
enum {
	DARK_THEME,
	LIGHT_THEME,
	CLASSIC_THEME
};

// Set mode constants
enum {
	SET_ONCE,
	SET_ALWAYS
};

// Flag constants
enum {
	FLAG_NONE                 = 0,
	FLAG_NO_TITLEBAR          = 1 << 0,
	FLAG_NO_RESIZE            = 1 << 1,
	FLAG_NO_MOVE              = 1 << 2,
	FLAG_NO_SCROLLBAR         = 1 << 3,
	FLAG_NO_COLLAPSE          = 1 << 5,
	FLAG_HORIZONTAL_SCROLLBAR = 1 << 11
};

// Input buffer for text input widgets
static std::unordered_map<std::string, std::string> input_buffers;

static int lua_init(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
	
	if (g_imgui_initialized) {
		return 0; // Already initialized
	}
	
	// Setup Dear ImGui context
	IMGUI_CHECKVERSION();
	ImGui::CreateContext();
	ImGuiIO& io = ImGui::GetIO(); (void)io;
	io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;
	io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;
	
	// Setup Dear ImGui style
	ImGui::StyleColorsDark();
	
	// Try to initialize with the best available backend
	bool backend_initialized = false;
	
	if (g_gl_context) {
		// Make sure OpenGL context is current for capability detection
		SDL_GL_MakeCurrent(g_window, g_gl_context);
		
		int gl_major = 0, gl_minor = 0;
		bool is_es = false;
		
		if (detectOpenGLCapabilities(&gl_major, &gl_minor, &is_es)) {
			printf("Detected OpenGL %s %d.%d\n", is_es ? "ES" : "", gl_major, gl_minor);
			
			// Try OpenGL 3.0+ backend first (best performance and features)
			if (!is_es && (gl_major >= 3)) {
				const char* glsl_version = selectGLSLVersion(gl_major, gl_minor, is_es);
				printf("Using OpenGL 3.0+ backend with GLSL %s\n", glsl_version);
				
				ImGui_ImplSDL2_InitForOpenGL(g_window, g_gl_context);
				ImGui_ImplOpenGL3_Init(glsl_version);
				g_imgui_backend = IMGUI_BACKEND_OPENGL3;
				backend_initialized = true;
			}
			// Try OpenGL ES 3.0+ with OpenGL3 backend (modern embedded)
			else if (is_es && gl_major >= 3) {
				const char* glsl_version = selectGLSLVersion(gl_major, gl_minor, is_es);
				printf("Using OpenGL ES 3.0+ backend with GLSL %s\n", glsl_version);
				
				ImGui_ImplSDL2_InitForOpenGL(g_window, g_gl_context);
				ImGui_ImplOpenGL3_Init(glsl_version);
				g_imgui_backend = IMGUI_BACKEND_OPENGL3;
				backend_initialized = true;
			}
			// Fallback to OpenGL 2.x backend (embedded/legacy compatibility)
			else {
				printf("Using OpenGL 2.x backend for compatibility\n");
				
				ImGui_ImplSDL2_InitForOpenGL(g_window, g_gl_context);
				ImGui_ImplOpenGL2_Init();
				g_imgui_backend = IMGUI_BACKEND_OPENGL2;
				backend_initialized = true;
			}
		}
	}
	
	if (!backend_initialized) {
		printf("OpenGL not available, ImGui initialization failed\n");
		ImGui::DestroyContext();
		return 0;
	}
	
	g_imgui_initialized = true;
	return 0;
}

static int lua_config(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 4) return luaL_error(L, "wrong number of arguments");
#endif
	
	// SDL doesn't have separate touch/gamepad modes like Vita
	// We can configure what input methods to enable
	bool use_touch = lua_toboolean(L, 1);
	bool use_rearpad = lua_toboolean(L, 2);  // Not applicable to SDL
	bool use_buttons = lua_toboolean(L, 3);
	bool use_indirect_touch = lua_toboolean(L, 4);  // Not applicable to SDL
	
	ImGuiIO& io = ImGui::GetIO();
	
	if (use_buttons) {
		io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;
	} else {
		io.ConfigFlags &= ~ImGuiConfigFlags_NavEnableGamepad;
	}
	
	// Touch input is handled automatically by SDL
	// Rear pad and indirect touch are Vita-specific features
	
	return 0;
}

static int lua_term(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
	
	if (!g_imgui_initialized) {
		return 0; // Not initialized
	}
	
	// Cleanup based on which backend was used
	switch (g_imgui_backend) {
		case IMGUI_BACKEND_OPENGL3:
			ImGui_ImplOpenGL3_Shutdown();
			ImGui_ImplSDL2_Shutdown();
			break;
		case IMGUI_BACKEND_OPENGL2:
			ImGui_ImplOpenGL2_Shutdown();
			ImGui_ImplSDL2_Shutdown();
			break;
		case IMGUI_BACKEND_SDL_RENDERER:
			// Future: ImGui_ImplSDLRenderer2_Shutdown();
			ImGui_ImplSDL2_Shutdown();
			break;
		default:
			break;
	}
	
	ImGui::DestroyContext();
	
	g_imgui_initialized = false;
	g_imgui_backend = IMGUI_BACKEND_NONE;
	input_buffers.clear();
	
	return 0;
}

static int lua_initblend(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
	
	if (!g_imgui_initialized) {
		return 0; // Not initialized
	}
	
	// Start the Dear ImGui frame based on backend
	switch (g_imgui_backend) {
		case IMGUI_BACKEND_OPENGL3:
			ImGui_ImplOpenGL3_NewFrame();
			ImGui_ImplSDL2_NewFrame();
			break;
		case IMGUI_BACKEND_OPENGL2:
			ImGui_ImplOpenGL2_NewFrame();
			ImGui_ImplSDL2_NewFrame();
			break;
		case IMGUI_BACKEND_SDL_RENDERER:
			// Future: ImGui_ImplSDLRenderer2_NewFrame();
			ImGui_ImplSDL2_NewFrame();
			break;
		default:
			return 0; // No valid backend
	}
	
	ImGui::NewFrame();
	return 0;
}

static int lua_termblend(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
	
	if (!g_imgui_initialized) {
		return 0; // Not initialized
	}
	
	// Rendering based on backend
	ImGui::Render();
	
	switch (g_imgui_backend) {
		case IMGUI_BACKEND_OPENGL3:
			ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
			break;
		case IMGUI_BACKEND_OPENGL2:
			ImGui_ImplOpenGL2_RenderDrawData(ImGui::GetDrawData());
			break;
		case IMGUI_BACKEND_SDL_RENDERER:
			// Future: ImGui_ImplSDLRenderer2_RenderDrawData(ImGui::GetDrawData());
			break;
		default:
			break;
	}
	
	return 0;
}

static int lua_settheme(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1) return luaL_error(L, "wrong number of arguments");
#endif
	
	int idx = luaL_checkinteger(L, 1);
	switch (idx) {
	case DARK_THEME:
		ImGui::StyleColorsDark();
		break;
	case LIGHT_THEME:
		ImGui::StyleColorsLight();
		break;
	default:
		ImGui::StyleColorsClassic();
		break;
	}
	
	return 0;
}

static int lua_smmenubar(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
	
	lua_pushboolean(L, ImGui::BeginMainMenuBar());
	return 1;
}

static int lua_emmenubar(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
	
	ImGui::EndMainMenuBar();
	return 0;
}

static int lua_smenu(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1 && argc != 2) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	bool enabled = true;
	if (argc == 2) {
		enabled = lua_toboolean(L, 2);
	}
	
	lua_pushboolean(L, ImGui::BeginMenu(label, enabled));
	return 1;
}

static int lua_emenu(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
	
	ImGui::EndMenu();
	return 0;
}

static int lua_text(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1 && argc != 2) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	if (argc == 1) {
		ImGui::Text("%s", label);
	} else {
		uint32_t color = luaL_checkinteger(L, 2);
		ImGui::TextColored(ImVec4(
			(float)(color & 0xFF) / 255.0f,
			(float)((color >> 8) & 0xFF) / 255.0f,
			(float)((color >> 16) & 0xFF) / 255.0f,
			(float)((color >> 24) & 0xFF) / 255.0f),
			"%s", label);
	}
	
	return 0;
}

static int lua_distext(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	ImGui::TextDisabled("%s", label);
	return 0;
}

static int lua_wraptext(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	ImGui::TextWrapped("%s", label);
	return 0;
}

static int lua_button(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1 && argc != 3) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	float sizex = 0;
	float sizey = 0;
	if (argc == 3) {
		sizex = luaL_checknumber(L, 2);
		sizey = luaL_checknumber(L, 3);
	}
	
	lua_pushboolean(L, ImGui::Button(label, ImVec2(sizex, sizey)));
	return 1;
}

static int lua_sbutton(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	lua_pushboolean(L, ImGui::SmallButton(label));
	return 1;
}

static int lua_checkbox(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 2) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	bool status = lua_toboolean(L, 2);
	ImGui::Checkbox(label, &status);
	lua_pushboolean(L, status);
	return 1;
}

static int lua_radiobutton(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 2) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	bool status = lua_toboolean(L, 2);
	lua_pushboolean(L, ImGui::RadioButton(label, status));
	return 1;
}

static int lua_input(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 2) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	const char *initial_text = luaL_checkstring(L, 2);
	
	// Create unique key for this input
	std::string key = std::string(label) + "_input";
	
	// Initialize buffer if it doesn't exist
	if (input_buffers.find(key) == input_buffers.end()) {
		input_buffers[key] = std::string(initial_text);
	}
	
	// Resize buffer to accommodate input
	std::string& buffer = input_buffers[key];
	buffer.resize(256);
	
	if (ImGui::InputText(label, &buffer[0], buffer.size())) {
		buffer.resize(strlen(buffer.c_str())); // Trim to actual length
	}
	
	lua_pushstring(L, buffer.c_str());
	return 1;
}

static int lua_multiinput(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 2) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	const char *initial_text = luaL_checkstring(L, 2);
	
	// Create unique key for this input
	std::string key = std::string(label) + "_multiinput";
	
	// Initialize buffer if it doesn't exist
	if (input_buffers.find(key) == input_buffers.end()) {
		input_buffers[key] = std::string(initial_text);
	}
	
	// Resize buffer to accommodate input
	std::string& buffer = input_buffers[key];
	buffer.resize(1024);
	
	if (ImGui::InputTextMultiline(label, &buffer[0], buffer.size())) {
		buffer.resize(strlen(buffer.c_str())); // Trim to actual length
	}
	
	lua_pushstring(L, buffer.c_str());
	return 1;
}

static int lua_sameline(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
	
	ImGui::SameLine();
	return 0;
}

static int lua_swindow(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1 && argc != 2) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	
	ImGuiWindowFlags flags = FLAG_NONE;
	if (argc == 2) {
		flags = luaL_checkinteger(L, 2);
	}
	
	ImGui::Begin(label, nullptr, flags);
	
	return 0;
}

static int lua_ewindow(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
	
	ImGui::End();
	return 0;
}

static int lua_winpos(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 3) return luaL_error(L, "wrong number of arguments");
#endif
	
	float x = luaL_checknumber(L, 1);
	float y = luaL_checknumber(L, 2);
	int mode = luaL_checkinteger(L, 3);
	
	ImGuiCond flags;
	switch (mode) {
	case SET_ONCE:
		flags = ImGuiCond_Once;
		break;
	default:
		flags = ImGuiCond_Always;
		break;
	}
	
	ImGui::SetNextWindowPos(ImVec2(x, y), flags);
	return 0;
}

static int lua_winsize(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 3) return luaL_error(L, "wrong number of arguments");
#endif
	
	float x = luaL_checknumber(L, 1);
	float y = luaL_checknumber(L, 2);
	int mode = luaL_checkinteger(L, 3);
	
	ImGuiCond flags;
	switch (mode) {
	case SET_ONCE:
		flags = ImGuiCond_Once;
		break;
	default:
		flags = ImGuiCond_Always;
		break;
	}
	
	ImGui::SetNextWindowSize(ImVec2(x, y), flags);
	return 0;
}

static int lua_separator(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
	
	ImGui::Separator();
	return 0;
}

static int lua_slider(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc < 4 || argc > 7) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	float v_min = luaL_checknumber(L, 2);
	float v_max = luaL_checknumber(L, 3);
	
	float vals[4];
	vals[0] = luaL_checknumber(L, 4);
	
	switch (argc) {
	case 4:
		ImGui::SliderFloat(label, vals, v_min, v_max);
		lua_pushnumber(L, vals[0]);
		break;
	case 5:
		vals[1] = luaL_checknumber(L, 5);
		ImGui::SliderFloat2(label, vals, v_min, v_max);
		lua_pushnumber(L, vals[0]);
		lua_pushnumber(L, vals[1]);
		break;
	case 6:
		vals[1] = luaL_checknumber(L, 5);
		vals[2] = luaL_checknumber(L, 6);
		ImGui::SliderFloat3(label, vals, v_min, v_max);
		lua_pushnumber(L, vals[0]);
		lua_pushnumber(L, vals[1]);
		lua_pushnumber(L, vals[2]);
		break;
	default:
		vals[1] = luaL_checknumber(L, 5);
		vals[2] = luaL_checknumber(L, 6);
		vals[3] = luaL_checknumber(L, 7);
		ImGui::SliderFloat4(label, vals, v_min, v_max);
		lua_pushnumber(L, vals[0]);
		lua_pushnumber(L, vals[1]);
		lua_pushnumber(L, vals[2]);
		lua_pushnumber(L, vals[3]);
		break;
	}
	
	return argc - 3;
}

static int lua_islider(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc < 4 || argc > 7) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	int v_min = luaL_checkinteger(L, 2);
	int v_max = luaL_checkinteger(L, 3);
	
	int vals[4];
	vals[0] = luaL_checkinteger(L, 4);
	
	switch (argc) {
	case 4:
		ImGui::SliderInt(label, vals, v_min, v_max);
		lua_pushinteger(L, vals[0]);
		break;
	case 5:
		vals[1] = luaL_checkinteger(L, 5);
		ImGui::SliderInt2(label, vals, v_min, v_max);
		lua_pushinteger(L, vals[0]);
		lua_pushinteger(L, vals[1]);
		break;
	case 6:
		vals[1] = luaL_checkinteger(L, 5);
		vals[2] = luaL_checkinteger(L, 6);
		ImGui::SliderInt3(label, vals, v_min, v_max);
		lua_pushinteger(L, vals[0]);
		lua_pushinteger(L, vals[1]);
		lua_pushinteger(L, vals[2]);
		break;
	default:
		vals[1] = luaL_checkinteger(L, 5);
		vals[2] = luaL_checkinteger(L, 6);
		vals[3] = luaL_checkinteger(L, 7);
		ImGui::SliderInt4(label, vals, v_min, v_max);
		lua_pushinteger(L, vals[0]);
		lua_pushinteger(L, vals[1]);
		lua_pushinteger(L, vals[2]);
		lua_pushinteger(L, vals[3]);
		break;
	}
	
	return argc - 3;
}

static int lua_mitem(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1 && argc != 2 && argc != 3) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	bool selected = false;
	bool enabled = true;
	if (argc > 1) {
		selected = lua_toboolean(L, 2);
		if (argc == 3) enabled = lua_toboolean(L, 3);
	}
	
	lua_pushboolean(L, ImGui::MenuItem(label, nullptr, selected, enabled));
	return 1;
}

static int lua_tooltip(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	if (ImGui::IsItemHovered())
		ImGui::SetTooltip("%s", label);
	
	return 0;
}

static int lua_combobox(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 3) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	int idx = luaL_checkinteger(L, 2);
	
	lua_rawgeti(L, 3, idx);
	if (ImGui::BeginCombo(label, lua_tostring(L, -1))) {
		int len = lua_objlen(L, 3);
		for (int i = 1; i <= len; i++) {
			bool is_selected = i == idx;
			lua_rawgeti(L, 3, i);
			if (ImGui::Selectable(lua_tostring(L, -1), is_selected))
				idx = i;
			if (is_selected)
				ImGui::SetItemDefaultFocus();
		}
		ImGui::EndCombo();
	}
	
	lua_pushinteger(L, idx);
	return 1;
}

static int lua_cursorpos(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 2) return luaL_error(L, "wrong number of arguments");
#endif
	
	float x = luaL_checknumber(L, 1);
	float y = luaL_checknumber(L, 2);
	ImGui::SetCursorPos(ImVec2(x, y));
	return 0;
}

static int lua_textsize(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	ImVec2 size = ImGui::CalcTextSize(label);
	lua_pushnumber(L, size.x);
	lua_pushnumber(L, size.y);
	return 2;
}

static int lua_progressbar(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1 && argc != 3) return luaL_error(L, "wrong number of arguments");
#endif
	
	float status = luaL_checknumber(L, 1);
	ImVec2 size;
	if (argc == 1) {
		size = ImVec2(-1, 0);
	} else {
		float w = luaL_checknumber(L, 2);
		float h = luaL_checknumber(L, 3);
		size = ImVec2(w, h);
	}
	
	ImGui::ProgressBar(status, size);
	return 0;
}

static int lua_colorpicker(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 2 && argc != 3) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	uint32_t color = luaL_checkinteger(L, 2);
	bool alpha = false;
	
	if (argc == 3) {
		alpha = lua_toboolean(L, 3);
	}
	
	float clr[4];
	clr[0] = (float)(color & 0xFF) / 255.0f;
	clr[1] = (float)((color >> 8) & 0xFF) / 255.0f;
	clr[2] = (float)((color >> 16) & 0xFF) / 255.0f;
	clr[3] = (float)((color >> 24) & 0xFF) / 255.0f;
	
	if (alpha) {
		ImGui::ColorPicker4(label, clr);
	} else {
		ImGui::ColorPicker3(label, clr);
	}
	
	uint32_t result = (uint32_t)(clr[0] * 255.0f) | 
	                  ((uint32_t)(clr[1] * 255.0f) << 8) | 
	                  ((uint32_t)(clr[2] * 255.0f) << 16) | 
	                  ((uint32_t)(clr[3] * 255.0f) << 24);
	
	lua_pushinteger(L, result);
	return 1;
}

static int lua_widgetwidth(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 1) return luaL_error(L, "wrong number of arguments");
#endif
	
	float w = luaL_checknumber(L, 1);
	ImGui::PushItemWidth(w);
	return 0;
}

static int lua_widgetwidthr(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 0) return luaL_error(L, "wrong number of arguments");
#endif
	
	ImGui::PopItemWidth();
	return 0;
}

static int lua_listbox(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc != 3) return luaL_error(L, "wrong number of arguments");
#endif
	
	const char *label = luaL_checkstring(L, 1);
	int idx = luaL_checkinteger(L, 2);
	int len = lua_objlen(L, 3);
	
	if (ImGui::BeginListBox(label)) {
		for (int i = 1; i <= len; i++) {
			bool is_selected = i == idx;
			lua_rawgeti(L, 3, i);
			if (ImGui::Selectable(lua_tostring(L, -1), is_selected))
				idx = i;
			if (is_selected)
				ImGui::SetItemDefaultFocus();
		}
		ImGui::EndListBox();
	}
	
	lua_pushinteger(L, idx);
	return 1;
}

static int lua_gimg(lua_State *L) {
	int argc = lua_gettop(L);
#ifndef SKIP_ERROR_HANDLING
	if (argc < 1) return luaL_error(L, "wrong number of arguments");
#endif
	
	// For now, image drawing is not implemented in SDL port
	// This would require texture handling and conversion from lpp_texture to OpenGL texture
	// TODO: Implement image drawing support
	
	return 0;
}

// Register our Gui Functions
static const luaL_Reg Gui_functions[] = {
	{"init",                lua_init},
	{"term",                lua_term},
	{"initBlend",           lua_initblend},
	{"termBlend",           lua_termblend},
	{"setTheme",            lua_settheme},
	{"initMainMenubar",     lua_smmenubar},
	{"termMainMenubar",     lua_emmenubar},
	{"initMenu",            lua_smenu},
	{"termMenu",            lua_emenu},
	{"drawText",            lua_text},
	{"drawDisabledText",    lua_distext},
	{"drawWrappedText",     lua_wraptext},
	{"drawButton",          lua_button},
	{"drawSmallButton",     lua_sbutton},
	{"drawCheckbox",        lua_checkbox},
	{"drawRadioButton",     lua_radiobutton},
	{"drawTextInput",       lua_input},
	{"drawMultilineTextInput", lua_multiinput},
	{"resetLine",           lua_sameline},
	{"initWindow",          lua_swindow},
	{"termWindow",          lua_ewindow},
	{"setWindowPos",        lua_winpos},
	{"setWindowSize",       lua_winsize},
	{"drawSeparator",       lua_separator},
	{"drawSlider",          lua_slider},
	{"drawIntSlider",       lua_islider},
	{"drawMenuItem",        lua_mitem},
	{"drawTooltip",         lua_tooltip},
	{"setInputMode",        lua_config},
	{"drawComboBox",        lua_combobox},
	{"setWidgetPos",        lua_cursorpos},
	{"getTextSize",         lua_textsize},
	{"drawProgressbar",     lua_progressbar},
	{"drawColorPicker",     lua_colorpicker},
	{"setWidgetWidth",      lua_widgetwidth},
	{"resetWidgetWidth",    lua_widgetwidthr},
	{"drawListBox",         lua_listbox},
	{"drawImage",           lua_gimg},
	{0, 0}
};

void luaGui_init(lua_State *L) {
	lua_newtable(L);
	luaL_setfuncs(L, Gui_functions, 0);
	lua_setglobal(L, "Gui");
	
	// Register constants
	VariableRegister(L, DARK_THEME);
	VariableRegister(L, LIGHT_THEME);
	VariableRegister(L, CLASSIC_THEME);
	VariableRegister(L, SET_ONCE);
	VariableRegister(L, SET_ALWAYS);
	VariableRegister(L, FLAG_NONE);
	VariableRegister(L, FLAG_NO_COLLAPSE);
	VariableRegister(L, FLAG_NO_MOVE);
	VariableRegister(L, FLAG_NO_RESIZE);
	VariableRegister(L, FLAG_NO_SCROLLBAR);
	VariableRegister(L, FLAG_NO_TITLEBAR);
	VariableRegister(L, FLAG_HORIZONTAL_SCROLLBAR);
}