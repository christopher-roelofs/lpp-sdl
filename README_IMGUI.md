# ImGui Support in LPP-SDL

LPP-SDL now includes ImGui (Dear ImGui) support by default for creating immediate mode GUIs in native SDL games.

## Quick Start

### 1. Download ImGui
```bash
make setup-imgui
```

### 2. Build (ImGui enabled by default)
```bash
make
```

### 3. Run the example
```bash
./lpp_sdl samples/sdl/imgui_example.lua
```

**That's it!** ImGui is now enabled by default in lpp-sdl.

## Build Options

**Build with ImGui (default):**
```bash
make                    # ImGui enabled if available
make USE_IMGUI=1        # Force ImGui (fails if not available)
```

**Build without ImGui:**
```bash
make USE_IMGUI=0        # Use stub implementation
```

**Download ImGui:**
```bash
make setup-imgui        # Downloads ImGui to src/include/imgui/
```

**Clean ImGui:**
```bash
make clean-imgui        # Removes ImGui directory
```

## Build Requirements

- **OpenGL 3.0+** headers (`libgl1-mesa-dev` on Ubuntu/Debian)
- **Git** (for ImGui download)
- All standard LPP-SDL dependencies

Install OpenGL headers:
```bash
# Ubuntu/Debian
sudo apt install libgl1-mesa-dev

# Fedora/RHEL  
sudo dnf install mesa-libGL-devel

# macOS
# OpenGL included with Xcode Command Line Tools
```

## Usage in Lua

```lua
-- Initialize ImGui
Gui.init()

-- Main loop
while true do
    Gui.initBlend()  -- Start ImGui frame
    
    if Gui.initWindow("My Window") then
        Gui.drawText("Hello, ImGui!")
        if Gui.drawButton("Click me!") then
            print("Button clicked!")
        end
    end
    Gui.termWindow()
    
    -- Regular graphics
    Graphics.initBlend()
    Screen.clear()
    Graphics.termBlend()
    
    Gui.termBlend()  -- End ImGui frame
    Screen.flip()
end

Gui.term()  -- Cleanup
```

## Available Functions

### Core
- `Gui.init()` / `Gui.term()` - Initialize/cleanup
- `Gui.initBlend()` / `Gui.termBlend()` - Frame start/end
- `Gui.setTheme(theme)` - Set UI theme

### Windows
- `Gui.initWindow(title, [flags])` - Begin window
- `Gui.termWindow()` - End window
- `Gui.setWindowPos(x, y, mode)` - Position window
- `Gui.setWindowSize(w, h, mode)` - Size window

### Widgets
- `Gui.drawText(text, [color])` - Draw text
- `Gui.drawButton(label, [w, h])` - Button
- `Gui.drawCheckbox(label, value)` - Checkbox
- `Gui.drawTextInput(label, text)` - Text input
- `Gui.drawSlider(label, min, max, value)` - Slider
- `Gui.drawComboBox(label, index, items)` - Dropdown
- And many more...

### Constants
- `DARK_THEME`, `LIGHT_THEME`, `CLASSIC_THEME`
- `FLAG_NO_TITLEBAR`, `FLAG_NO_RESIZE`, etc.
- `SET_ONCE`, `SET_ALWAYS`

## Examples

See `samples/sdl/imgui_example.lua` for a comprehensive demonstration.

## Troubleshooting

**"OpenGL context could not be created"**
- Install OpenGL development headers
- Check hardware OpenGL 3.0+ support

**"ImGui directory not found"**
- Run `make setup-imgui` to download ImGui
- Verify `src/include/imgui/` directory exists

**Functions return nil/error**
- Ensure built with `USE_IMGUI=1`
- Check ImGui was downloaded successfully
- Verify OpenGL context creation succeeded

## Performance Notes

- ImGui rebuilds UI every frame (immediate mode)
- Great for debug UIs, tools, moderate game interfaces  
- For high-performance UIs, consider the custom UI libraries in samples
- Only available in native SDL mode (not Vita/3DS compatibility modes)

## Migration from Stub

Existing code using `Gui` functions will work automatically - if ImGui is available, you get full functionality; if not, you get safe stub implementations that return default values.

## Vita Sample Compatibility

**API Compatibility:** The SDL implementation maintains full API compatibility with the original lpp-vita ImGui module.

**Rendering Order Difference:** Due to different rendering backends (SDL + OpenGL vs Vita2D), existing Vita ImGui samples may require a small rendering order change:

**Original Vita Order (may not display correctly):**
```lua
Graphics.initBlend()
Screen.clear()
Gui.initBlend()
-- ImGui calls --
Gui.termBlend()
Graphics.termBlend()  -- This overwrites ImGui in SDL
Screen.flip()
```

**SDL Compatible Order:**
```lua
Gui.initBlend()
-- ImGui calls --
Graphics.initBlend()
Screen.clear()
-- Graphics calls --
Graphics.termBlend()
Gui.termBlend()  -- ImGui renders on top
Screen.flip()
```

**Why:** In SDL, ImGui uses OpenGL while Graphics uses SDL renderer. ImGui must render after Graphics to appear on top.

**Solution:** Move `Gui.initBlend()` before `Graphics.initBlend()` and `Gui.termBlend()` after `Graphics.termBlend()` in existing Vita samples.

## Multi-Backend Support

LPP-SDL automatically detects your system's OpenGL capabilities and selects the best available ImGui backend:

### Automatic Backend Selection

| Platform Type | OpenGL Support | Backend Used | GLSL Version | Features |
|---------------|----------------|--------------|--------------|----------|
| **Modern Desktop** | OpenGL 3.3+ | OpenGL 3.0+ | #version 330 | Full performance & features |
| **Legacy Desktop** | OpenGL 2.x | OpenGL 2.x | #version 110 | Maximum compatibility |
| **Modern Embedded** | OpenGL ES 3.0+ | OpenGL 3.0+ | #version 300 es | Full performance & features |
| **Legacy Embedded** | OpenGL ES 2.0 | OpenGL 2.x | #version 100 | Maximum compatibility |
| **gl4es Systems** | ES 2.0 → GL 2.x | OpenGL 2.x | Auto-detected | Compatible with gl4es |

### Console Output Examples

**Modern system:**
```
Detected OpenGL 4.6
Using OpenGL 3.0+ backend with GLSL #version 330
```

**Embedded system with gl4es:**
```
Detected OpenGL 2.1
Using OpenGL 2.x backend for compatibility
```

**OpenGL ES device:**
```
Detected OpenGL ES 2.0
Using OpenGL 2.x backend for compatibility
```

### Embedded Linux Compatibility

Perfect for handheld gaming devices and embedded systems:

- **ARM-based handhelds** (RG351, Anbernic, etc.)
- **Raspberry Pi** and similar SBCs  
- **gl4es compatibility layer** (OpenGL ES 2.0 → OpenGL 2.x translation)
- **Legacy embedded drivers**

### Performance Characteristics

- **OpenGL 3.0+ backend**: Hardware-accelerated, modern shader pipeline
- **OpenGL 2.x backend**: Broader compatibility, slightly lower performance
- **Automatic selection**: Best performance available on each system

## Technical Details

- **Multi-backend rendering**: OpenGL 3.0+, OpenGL 2.x, future SDL renderer support
- **SDL2 backend**: Cross-platform input/windowing
- **Mixed rendering**: Compatible with existing SDL renderer
- **Thread-safe**: Initialization and cleanup
- **Automatic event handling**: Integrated with lpp-sdl event system
- **Runtime detection**: No compile-time backend selection needed

For complete documentation, see `IMGUI_SETUP.md`.