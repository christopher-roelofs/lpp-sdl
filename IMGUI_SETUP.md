# ImGui Support for LPP-SDL

This document explains how to set up and use ImGui (Dear ImGui) support in LPP-SDL for creating immediate mode GUIs in native SDL games.

## Prerequisites

- OpenGL development headers (`libgl1-mesa-dev` on Ubuntu/Debian)
- Git (for downloading ImGui)
- All standard LPP-SDL build dependencies

Install OpenGL headers:
```bash
# Ubuntu/Debian
sudo apt install libgl1-mesa-dev

# Fedora/RHEL
sudo dnf install mesa-libGL-devel

# macOS (via Homebrew)
# OpenGL is included with Xcode Command Line Tools
```

## Setup Instructions

### 1. Download ImGui

Use the provided Makefile to automatically download ImGui:

```bash
make -f Makefile.imgui setup-imgui
```

This will clone the ImGui repository to `src/include/imgui/`.

### 2. Build with ImGui Support

Build using the ImGui-enabled Makefile:

```bash
make -f Makefile.imgui
```

Or to force ImGui support (will fail if ImGui isn't available):
```bash
make -f Makefile.imgui USE_IMGUI=1
```

To build without ImGui support (uses stub):
```bash
make -f Makefile.imgui USE_IMGUI=0
```

### 3. Update Main Application (for Developers)

If you're modifying the main application source, you need to:

1. Add ImGui globals to `main_sdl.cpp`:
```cpp
#ifdef USE_IMGUI
#include <GL/gl.h>
#include "imgui.h"
#include "imgui_impl_sdl2.h"
#include "imgui_impl_opengl3.h"

SDL_GLContext g_gl_context = NULL;
bool g_imgui_initialized = false;
#endif
```

2. Create OpenGL context after SDL window creation:
```cpp
#ifdef USE_IMGUI
if (!headless_mode) {
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, 0);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 0);
    
    g_gl_context = SDL_GL_CreateContext(g_window);
    if (g_gl_context) {
        SDL_GL_MakeCurrent(g_window, g_gl_context);
        SDL_GL_SetSwapInterval(1);
    }
}
#endif
```

3. Handle ImGui events in the main loop:
```cpp
while (SDL_PollEvent(&event)) {
#ifdef USE_IMGUI
    if (handle_imgui_event(&event)) {
        continue; // ImGui consumed the event
    }
#endif
    // ... existing event handling ...
}
```

4. Cleanup ImGui on exit:
```cpp
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
```

## Using ImGui in Lua Scripts

### Basic Usage

```lua
-- Initialize ImGui
Gui.init()
Gui.setTheme(DARK_THEME)  -- DARK_THEME, LIGHT_THEME, or CLASSIC_THEME

-- Main loop
while true do
    -- Start ImGui frame
    Gui.initBlend()
    
    -- Create a window
    if Gui.initWindow("My Window") then
        Gui.drawText("Hello, ImGui!")
        
        if Gui.drawButton("Click me!") then
            print("Button clicked!")
        end
    end
    Gui.termWindow()
    
    -- Regular graphics rendering
    Graphics.initBlend()
    Screen.clear()
    -- ... your graphics code ...
    Graphics.termBlend()
    
    -- Finish ImGui frame
    Gui.termBlend()
    
    Screen.flip()
end

-- Cleanup
Gui.term()
```

### Available Functions

#### Window Management
- `Gui.initWindow(title, [flags])` - Begin window, returns true if open
- `Gui.termWindow()` - End window
- `Gui.setWindowPos(x, y, mode)` - Set window position
- `Gui.setWindowSize(w, h, mode)` - Set window size

#### Text and Labels
- `Gui.drawText(text, [color])` - Draw text
- `Gui.drawDisabledText(text)` - Draw grayed-out text
- `Gui.drawWrappedText(text)` - Draw text with word wrapping

#### Buttons
- `Gui.drawButton(label, [width, height])` - Regular button, returns true if clicked
- `Gui.drawSmallButton(label)` - Small button

#### Input Widgets
- `Gui.drawCheckbox(label, value)` - Checkbox, returns new value
- `Gui.drawRadioButton(label, active)` - Radio button, returns true if clicked
- `Gui.drawTextInput(label, text)` - Single-line text input, returns new text
- `Gui.drawMultilineTextInput(label, text)` - Multi-line text input

#### Sliders
- `Gui.drawSlider(label, min, max, value[, value2, value3, value4])` - Float slider(s)
- `Gui.drawIntSlider(label, min, max, value[, value2, value3, value4])` - Integer slider(s)

#### Selection Widgets
- `Gui.drawComboBox(label, current_index, items_table)` - Dropdown combo box
- `Gui.drawListBox(label, current_index, items_table)` - List box

#### Other Widgets
- `Gui.drawProgressbar(fraction, [width, height])` - Progress bar (0.0 to 1.0)
- `Gui.drawColorPicker(label, color_value, [include_alpha])` - Color picker
- `Gui.drawSeparator()` - Horizontal separator line
- `Gui.drawTooltip(text)` - Tooltip for previous item

#### Menu System
- `Gui.initMainMenubar()` - Begin main menu bar, returns true if open
- `Gui.termMainMenubar()` - End main menu bar
- `Gui.initMenu(label, [enabled])` - Begin menu, returns true if open
- `Gui.termMenu()` - End menu
- `Gui.drawMenuItem(label, [selected, enabled])` - Menu item, returns true if clicked

#### Layout and Positioning
- `Gui.resetLine()` - Put next widget on same line
- `Gui.setWidgetPos(x, y)` - Set cursor position for next widget
- `Gui.setWidgetWidth(width)` - Set width for next widgets
- `Gui.resetWidgetWidth()` - Reset widget width to default
- `Gui.getTextSize(text)` - Get text dimensions, returns width, height

#### Configuration
- `Gui.setTheme(theme)` - Set UI theme (DARK_THEME, LIGHT_THEME, CLASSIC_THEME)
- `Gui.setInputMode(touch, rearpad, buttons, indirect)` - Configure input methods

### Constants

#### Themes
- `DARK_THEME` - Dark theme (default)
- `LIGHT_THEME` - Light theme
- `CLASSIC_THEME` - Classic ImGui theme

#### Window Flags
- `FLAG_NONE` - No special flags
- `FLAG_NO_TITLEBAR` - No title bar
- `FLAG_NO_RESIZE` - Cannot resize
- `FLAG_NO_MOVE` - Cannot move
- `FLAG_NO_SCROLLBAR` - No scrollbars
- `FLAG_NO_COLLAPSE` - Cannot collapse
- `FLAG_HORIZONTAL_SCROLLBAR` - Enable horizontal scrollbar

#### Set Modes
- `SET_ONCE` - Set value only once
- `SET_ALWAYS` - Set value every frame

## Examples

See `samples/sdl/imgui_example.lua` for a comprehensive demonstration of all ImGui features.

## Multi-Backend Support

LPP-SDL automatically detects and selects the best available ImGui backend for your system:

### Supported Backends

1. **OpenGL 3.0+ Backend** (Best performance)
   - Modern desktop systems (OpenGL 3.3+)
   - Modern embedded systems (OpenGL ES 3.0+)
   - Full feature set and hardware acceleration

2. **OpenGL 2.x Backend** (Maximum compatibility)
   - Legacy desktop systems (OpenGL 2.x)
   - Embedded systems (OpenGL ES 2.0)
   - gl4es compatibility layer systems
   - Broader driver support

### Automatic Detection

The system automatically:
- Detects your OpenGL version and type (desktop vs ES)
- Selects the best available backend
- Chooses appropriate GLSL shader versions
- Provides console output showing selected backend

Example output:
```bash
# Modern system
Detected OpenGL 4.6
Using OpenGL 3.0+ backend with GLSL #version 330

# Embedded system with gl4es
Detected OpenGL 2.1
Using OpenGL 2.x backend for compatibility
```

## Troubleshooting

### "OpenGL context could not be created"
- Ensure OpenGL development headers are installed (`libgl1-mesa-dev`)
- Try running with different graphics drivers
- **Note**: OpenGL 2.0+ is sufficient (auto-detected)

### ImGui functions return "attempt to call field 'X' (a nil value)"
- Make sure you built with ImGui support (`make`)
- Verify ImGui was downloaded (`make setup-imgui`)
- Check that `USE_IMGUI=1` during build

### Performance Issues
- **OpenGL 3.0+ backend**: Hardware-accelerated, best performance
- **OpenGL 2.x backend**: Software-accelerated, good compatibility
- Consider reducing widgets or update frequency for complex UIs
- Use `Screen.flip()` less frequently if needed

### Text Input Not Working
- Ensure SDL2 text input is properly initialized
- Check if keyboard focus is on the ImGui window
- Some text input features may require specific SDL2 versions

### Embedded System Issues
- **gl4es systems**: Should automatically use OpenGL 2.x backend
- **ARM drivers**: May need OpenGL 2.x backend for stability
- **Raspberry Pi**: Works with both Mesa and proprietary drivers

## Building Without ImGui

If you want to build without ImGui support (using the stub), either:

1. Use the regular Makefile: `make`
2. Use the ImGui Makefile with ImGui disabled: `make -f Makefile.imgui USE_IMGUI=0`
3. Remove the ImGui directory: `make -f Makefile.imgui clean-imgui`

The stub implementation ensures that scripts using Gui functions won't crash, but the functions will return default values and not render anything.

## Performance Considerations

- ImGui is an immediate mode GUI, meaning it rebuilds the UI every frame
- This makes it very flexible but can be more expensive than retained mode GUIs
- For best performance:
  - Minimize the number of widgets rendered each frame
  - Use conditional rendering (`if` statements) to hide unused UI
  - Consider using a custom UI library (like the ones in the samples) for high-performance scenarios
  - ImGui is ideal for debug UIs, tools, and moderate-complexity game interfaces

## Compatibility

### Platform Support
- **Desktop**: Windows, macOS, Linux (all OpenGL versions 2.0+)
- **Embedded Linux**: ARM handhelds, Raspberry Pi, SBCs
- **Mobile**: OpenGL ES 2.0+ systems
- **Compatibility layers**: gl4es (ES 2.0 → GL 2.x)

### OpenGL Requirements
- **Minimum**: OpenGL 2.0 or OpenGL ES 2.0
- **Recommended**: OpenGL 3.3+ or OpenGL ES 3.0+
- **Automatic detection**: Best backend selected at runtime

### Limitations
- Only available in native SDL mode (not Vita/3DS compatibility modes)
- Not available in headless mode
- Requires OpenGL context (hardware or software)

### Vita Sample Compatibility Note

Existing Vita ImGui samples may require a rendering order change due to different backends:

- **Issue:** Original Vita samples call `Graphics.termBlend()` after `Gui.termBlend()`, which overwrites ImGui in SDL
- **Fix:** Move `Gui.initBlend()` before `Graphics.initBlend()` and `Gui.termBlend()` after `Graphics.termBlend()`
- **Reason:** SDL uses separate OpenGL (ImGui) + SDL renderer (Graphics) contexts

See README_IMGUI.md for detailed examples.