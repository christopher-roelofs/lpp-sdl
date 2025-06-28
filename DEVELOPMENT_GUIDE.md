# LPP-SDL Development Guide

## Project Goals

The primary goal of lpp-sdl is to **port Lua Player Plus to SDL** while maintaining **backwards compatibility** with existing Vita and 3DS homebrew applications. This allows desktop users to run PlayStation Vita and Nintendo 3DS lua player plus games without modification.

## Core Principles

### 1. Platform Compatibility First
- **Never break existing game compatibility** when adding new features
- **Always test changes against existing games** from all supported platforms
- **Preserve original API behavior** even if it seems suboptimal

### 2. Separation of Concerns
- **Isolate platform-specific code** using compatibility mode checks
- **Use conditional compilation or runtime checks** to handle platform differences
- **Document why each platform difference exists** with comments referencing original source

### 3. Original Source Verification
- **Always check original lpp-vita and lpp-3ds source** before implementing changes
- **Verify API behavior matches the original** before assuming implementation details
- **Document differences between platforms** when they exist in the original code

## Compatibility Modes

The engine supports three primary compatibility modes:

```cpp
typedef enum {
    LPP_COMPAT_NATIVE,  // Desktop/SDL native behavior
    LPP_COMPAT_VITA,    // PlayStation Vita compatibility
    LPP_COMPAT_3DS      // Nintendo 3DS compatibility
} lpp_compat_mode_t;
```

### Mode Selection
- `-vitacompat`: Enable Vita compatibility mode
- `-3dscompat`: Enable 3DS compatibility mode  
- No flag: Native SDL mode

## Platform-Specific Implementation Patterns

### 1. Graphics Rendering Pipeline

**Critical Difference - Frame Presentation:**

```cpp
// Graphics.termBlend() implementation
static int lua_term(lua_State *L) {
    // Common validation code...
    
    // Platform-specific presentation behavior
    if (g_compat_mode == LPP_COMPAT_VITA && g_renderer) {
        // Vita: termBlend() presents the frame
        SDL_RenderPresent(g_renderer);
    }
    // 3DS and Native: termBlend() only finishes rendering
    
    return 0;
}

// Screen.flip() implementation  
static int lua_flip(lua_State *L) {
    // Event handling code...
    
    // Platform-specific presentation behavior
    if (g_compat_mode != LPP_COMPAT_VITA) {
        // 3DS and Native: flip() presents the frame
        SDL_RenderPresent(g_renderer);
    }
    // Vita: flip() skipped to prevent double presentation
    
    return 0;
}
```

**Why this difference exists:**
- **Original lpp-3ds**: `Graphics.termBlend()` → `sf2d_end_frame()` (no presentation), `Screen.flip()` → `sf2d_swapbuffers()` (presents)
- **Original lpp-vita**: `Graphics.termBlend()` → presentation expected, `Screen.flip()` → may be called early
- **Games rely on these different behaviors** and cannot be modified

### 2. API Parameter Compatibility

**Example - Graphics.drawScaleImage() parameter order:**

```cpp
static int lua_drawImageScale(lua_State *L) {
    int argc = lua_gettop(L);
    
    // Auto-detect parameter order based on types
    if (argc >= 5) {
        // Check if 5th parameter is userdata (image) or number (scale)
        if (lua_isuserdata(L, 5)) {
            // Vita-style: (x, y, scale_x, scale_y, image, [color])
            // Handle Vita parameter order
        } else {
            // Standard: (x, y, image, scale_x, scale_y, [color])
            // Handle standard parameter order
        }
    }
    
    return 0;
}
```

### 3. System API Differences

**Example - System.wait() time units:**

```cpp
static int lua_wait(lua_State *L) {
    int time_value = luaL_checkinteger(L, 1);
    
    if (g_compat_mode == LPP_COMPAT_VITA) {
        // Vita expects microseconds, convert to milliseconds
        int ms = time_value / 1000;
        if (ms < 1) ms = 1; // Minimum 1ms delay
        SDL_Delay(ms);
    } else {
        // 3DS and Native expect milliseconds directly
        SDL_Delay(time_value);
    }
    
    return 0;
}
```

## Development Workflow

### Before Making Any Changes

1. **Identify the target platform(s)** for your change
2. **Check original source implementations:**
   - lpp-vita: https://github.com/Rinnegatamante/lpp-vita
   - lpp-3ds: https://github.com/Rinnegatamante/lpp-3ds
   source should be available locally at lpp-vita and lpp-3ds directories above lpp-sdl directory
3. **Document expected behavior** from original implementations
4. **Identify if change affects existing games**

### Implementation Steps

1. **Write platform-agnostic code first** when possible
2. **Add platform-specific branches** only when necessary
3. **Use clear conditional checks:**
   ```cpp
   if (g_compat_mode == LPP_COMPAT_VITA) {
       // Vita-specific implementation
   } else if (g_compat_mode == LPP_COMPAT_3DS) {
       // 3DS-specific implementation  
   } else {
       // Native SDL implementation
   }
   ```
4. **Document why each branch exists** with reference to original source
5. **Test with actual games** from each platform

### Testing Requirements

**For every change, test with:**

1. **Native mode games** (samples/sdl/)
2. **Vita compatibility games** (tests/games/vita/)  
3. **3DS compatibility games** (tests/games/3ds/)

**Minimum test commands:**
```bash
# Native mode
./lpp_sdl samples/sdl/Graphics/index.lua

# Vita compatibility  
./lpp_sdl -vitacompat tests/games/vita/vitaWanted/index.lua
./lpp_sdl -vitacompat tests/games/vita/SuperHeroChronicles-0917/index.lua

# 3DS compatibility
./lpp_sdl -3dscompat tests/games/3ds/pixelroad_1.0/index.lua
```

## Common Pitfalls to Avoid

### 1. Assuming Uniform Behavior
❌ **Wrong:**
```cpp
// This assumes all platforms work the same way
Graphics.termBlend() always calls SDL_RenderPresent()
```

✅ **Correct:**
```cpp
// This respects platform differences
if (g_compat_mode == LPP_COMPAT_VITA) {
    SDL_RenderPresent(g_renderer); // Only Vita expects this
}
```

### 2. Breaking Existing Games
❌ **Wrong:**
```cpp
// This changes behavior for all platforms
Screen.flip() now has different timing
```

✅ **Correct:**
```cpp
// This isolates changes to specific platforms
if (g_compat_mode == LPP_COMPAT_VITA) {
    // New Vita-specific behavior
} else {
    // Preserve original behavior for other platforms
}
```

### 3. Not Checking Original Source
❌ **Wrong:**
```cpp
// Guessing how the original worked
// "I think Graphics.termBlend() should present the frame"
```

✅ **Correct:**
```cpp
// Verified against lpp-vita source:
// Graphics.termBlend() calls vita2d_end_drawing() + vita2d_swap_buffers()
// Therefore: SDL port should call SDL_RenderPresent() in Vita mode
```

## Code Comments Standards

Always include comments explaining platform-specific behavior:

```cpp
// Vita compatibility: Some games expect termBlend to present the frame
// Original lpp-vita: Graphics.termBlend() → vita2d_swap_buffers()
if (g_compat_mode == LPP_COMPAT_VITA && g_renderer) {
    SDL_RenderPresent(g_renderer);
}

// 3DS compatibility: termBlend only finishes rendering, no presentation
// Original lpp-3ds: Graphics.termBlend() → sf2d_end_frame() (no buffer swap)
// Screen.flip() handles presentation via sf2d_swapbuffers()
```

## File Organization

### Platform-Specific Code Sections
- Use `#ifdef` or runtime checks to separate platform code
- Group platform-specific functions together
- Document which platform each section targets

### Compatibility Mode Variables
```cpp
extern lpp_compat_mode_t g_compat_mode;  // Current compatibility mode
extern bool g_vita_compat_mode;          // Deprecated, use g_compat_mode
extern bool g_dual_screen_mode;          // Deprecated, use g_compat_mode
```

## Original Source References

### lpp-vita
- **Repository**: https://github.com/Rinnegatamante/lpp-vita
- **Graphics**: `source/luaGraphics.cpp` 
- **Screen**: `source/luaScreen.cpp`
- **Key APIs**: vita2d library calls

### lpp-3ds  
- **Repository**: https://github.com/Rinnegatamante/lpp-3ds
- **Graphics**: `source/luaGraphics.cpp`
- **Screen**: `source/luaScreen.cpp` 
- **Key APIs**: sf2d library calls

## Debugging Platform Issues

### 1. Identify Which Platform is Affected
```bash
# Test each mode individually
./lpp_sdl game.lua                    # Native mode
./lpp_sdl -vitacompat game.lua        # Vita mode  
./lpp_sdl -3dscompat game.lua         # 3DS mode
```

### 2. Compare with Original Behavior
- Run the same game on original hardware if possible
- Check original source for expected API behavior
- Look for existing compatibility workarounds

### 3. Isolate the Fix
- Only change behavior for the affected platform
- Preserve existing behavior for working platforms
- Test all platforms after changes

## Success Metrics

The SDL port is successful when:

✅ **Vita games run without modification** in `-vitacompat` mode  
✅ **3DS games run without modification** in `-3dscompat` mode  
✅ **Native SDL games** take advantage of desktop features  
✅ **No cross-platform interference** - Vita fixes don't break 3DS games  
✅ **Clear separation** between platform-specific code paths  

---

**Remember**: The goal is not to create the "best" implementation, but to create the **most compatible** implementation that preserves the original gaming experience for vita and 3ds while allowing new development for sdl native games.