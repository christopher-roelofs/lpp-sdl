# 3DS Single-Screen Mode Implementation

## Overview

This document describes the implementation of single-screen mode for 3DS compatibility in lpp-sdl. The solution provides clean screen switching for small displays where showing both 3DS screens simultaneously isn't practical.

## Final Solution Summary

- ✅ **Clean single-screen switching** with TAB key
- ✅ **Blackjack works perfectly** - no bottom screen bleeding  
- ✅ **Professional appearance** - proper screen isolation
- ✅ **No flashing** - stable black padding approach
- ✅ **Proper scaling** - each screen fills the window correctly

## Key Features

### Activation
- **Automatic activation** on small displays (≤600px height for vertical, ≤800px width OR ≤600px height for horizontal)
- **Manual activation** via `-3dscompat-1screen` command line flag
- **TAB key switching** between top and bottom screens

### Technical Implementation
- **Uniform logical sizing** (400x240) prevents size-change artifacts
- **Per-screen clipping** provides clean isolation between screens
- **Bottom screen centering** (X=40 offset) with black padding for professional appearance
- **Both 3DS orientations supported** in dual-screen mode

## Implementation Details

### Core Components

#### 1. Screen Switching Logic (`luaScreen.cpp:115-130`)
```cpp
// TAB key to switch between screens in 3DS single-screen mode
if (e.type == SDL_KEYDOWN && e.key.keysym.sym == SDLK_TAB && g_3ds_single_screen_mode) {
    // Switch active screen
    g_3ds_active_screen = (g_3ds_active_screen == 0) ? 1 : 0;
    
    // Use uniform logical size to prevent artifacts
    int logical_width = DS_TOP_SCREEN_WIDTH;  // Always use 400px width
    int logical_height = DS_TOP_SCREEN_HEIGHT; // Always use 240px height
    
    if (SDL_RenderSetLogicalSize(g_renderer, logical_width, logical_height) == 0) {
        const char* screen_name = (g_3ds_active_screen == 0) ? "top" : "bottom";
        printf("Switched to %s screen (%dx%d logical, scaled to fill window)\n", screen_name, logical_width, logical_height);
    }
}
```

#### 2. Screen Positioning (`luaGraphics.cpp:88-95`)
```cpp
// In single-screen mode, position screens appropriately
if (g_3ds_single_screen_mode) {
    if (screen_id == 1) {
        // Bottom screen: center it in the 400px logical width
        return (DS_TOP_SCREEN_WIDTH - DS_BOTTOM_SCREEN_WIDTH) / 2; // 40px offset to center 320px in 400px
    }
    return 0; // Top screen at 0,0
}
```

#### 3. Per-Screen Clipping (`luaGraphics.cpp:158-169`)
```cpp
// In single-screen mode, only clip if this screen is not the active one
if (g_3ds_single_screen_mode) {
    if (screen_id != g_3ds_active_screen) {
        // Inactive screen: clip to nothing (hide it)
        SDL_Rect clip_rect = {0, 0, 0, 0}; // Empty clip rect hides everything
        SDL_RenderSetClipRect(g_renderer, &clip_rect);
    } else {
        // Active screen: no clipping (full visibility)
        SDL_RenderSetClipRect(g_renderer, NULL);
    }
    return;
}
```

#### 4. Black Padding (`luaScreen.cpp:245-256`)
```cpp
// Add black padding for bottom screen in single-screen mode
if (g_3ds_single_screen_mode && g_3ds_active_screen == 1) {
    SDL_SetRenderDrawColor(g_renderer, 0, 0, 0, 255);
    
    // Draw black padding on left side (0 to 40)
    SDL_Rect left_padding = {0, 0, 40, DS_TOP_SCREEN_HEIGHT};
    SDL_RenderFillRect(g_renderer, &left_padding);
    
    // Draw black padding on right side (360 to 400) 
    SDL_Rect right_padding = {360, 0, 40, DS_TOP_SCREEN_HEIGHT};
    SDL_RenderFillRect(g_renderer, &right_padding);
}
```

## Screen Dimensions

- **Top Screen**: 400x240 pixels
- **Bottom Screen**: 320x240 pixels (centered with 40px padding on each side)
- **Logical Size**: Always 400x240 to prevent artifacts

## How It Works

1. **Initialization**: Single-screen mode is detected and enabled based on display size or command line flag
2. **Uniform Logical Size**: Both screens use 400x240 logical coordinates to prevent size-change artifacts
3. **Screen Positioning**: 
   - Top screen renders at (0,0) filling full 400x240 space
   - Bottom screen renders at (40,0) centered in 400x240 space
4. **Clipping**: Only the active screen is visible; inactive screen is clipped to nothing
5. **Black Padding**: When bottom screen is active, black rectangles cover the sides (0-40px and 360-400px)
6. **Switching**: TAB key toggles active screen and updates clipping

## Design Decisions

### Approach Selection
After extensive testing, we chose the **clipping approach** over alternatives:

#### Option 1: Dynamic Logical Sizing
- ✅ Both screens update properly
- ❌ Screen overlap issues (bottom screen visible behind top screen)
- ❌ Breaks games like blackjack

#### Option 2: Clipping Approach (Selected)
- ✅ Clean visual appearance
- ✅ Perfect isolation between screens
- ✅ Professional user experience
- ❌ Some screens may need interaction to refresh after switching

#### Option 3: Complex Isolation Systems
- ❌ Various visual artifacts
- ❌ Update timing issues
- ❌ Implementation complexity

### Trade-offs Accepted
- **Update delays**: Some games may need user interaction to refresh inactive screens
- **Static content**: Top screen static content may not redraw until next interaction
- **Performance**: Per-screen clipping adds minimal rendering overhead

## Game Compatibility

### Games That Work Well
- **Blackjack**: ✅ Works perfectly with clean display and proper screen isolation
- **Games with primarily dynamic content**: ✅ Generally work well since content redraws frequently

### Games with Known Issues
- **Sudoku**: ❌ Does not work well with this implementation
  - **Issue**: Bottom screen doesn't update until user clicks/touches
  - **Root cause**: Sudoku appears to render content once and then not redraw until explicit user interaction
  - **Clipping impact**: The clipping system prevents the inactive screen from rendering, which breaks the update flow
  - **Manifestation**: When switching to bottom screen, content appears stale until user provides input

- **Games with static content**: ❌ May have similar update issues
  - **Issue**: Content that renders once and doesn't redraw regularly will appear stale after screen switches
  - **Examples**: Menu screens, static displays, games with infrequent redraw cycles

### Why Some Games Don't Work Well

The clipping approach has a fundamental limitation with games that:

1. **Render content infrequently**: Games that draw content once and don't continuously redraw
2. **Rely on continuous rendering**: Games expecting both screens to always be visible
3. **Have conditional update logic**: Games that only redraw when they detect the screen is "visible"

#### Technical Explanation
- **Clipping prevents rendering**: When a screen is clipped to (0,0,0,0), no rendering occurs for that screen
- **Game logic unaware**: The game doesn't know its rendering is being clipped, so it may not trigger redraws
- **Update cycles broken**: Games may only redraw when they detect changes or user interaction
- **State desync**: The game's internal state advances but the visual representation doesn't update

## Benefits

### For Users
- **Small display support**: Makes 3DS games playable on small screens
- **Clean interface**: Professional single-screen experience for compatible games
- **Easy switching**: Simple TAB key navigation
- **Game compatibility**: Works well with games that have frequent redraw cycles

### For Developers
- **Backward compatibility**: Existing dual-screen code works unchanged
- **Automatic activation**: No user configuration required for small displays
- **Clean implementation**: Minimal changes to existing rendering pipeline

## Known Limitations

1. **Game-specific compatibility**: Some games like Sudoku don't work well due to rendering patterns
2. **Static Content**: Games with static top screen content may require interaction to refresh
3. **Update Timing**: Games with infrequent redraw cycles may show stale content after switching
4. **Clipping side effects**: Games that rely on continuous rendering for both screens may have issues
5. **No fallback mechanism**: No automatic detection of problematic games or alternative rendering mode

## Alternative Solutions Considered

### Dynamic Logical Sizing (Rejected)
- **Approach**: Change logical resolution when switching screens (400x240 ↔ 320x240)
- **Benefits**: Both screens render continuously, maintaining update cycles
- **Issues**: Screen overlap problems, bottom screen content visible behind top screen
- **Games affected**: Broke blackjack and other games requiring clean screen isolation

### Render Texture Isolation (Not Implemented)
- **Approach**: Each screen renders to separate textures, display appropriate texture
- **Benefits**: Complete isolation, both screens stay current
- **Issues**: Implementation complexity, memory overhead, potential performance impact
- **Status**: Considered but not implemented due to complexity

## Future Improvements

Potential enhancements that could be implemented:

1. **Game Detection**: Automatic detection of games that work poorly with clipping
2. **Dual Mode Support**: Command line flags to choose between clipping and dynamic sizing approaches
3. **Forced Refresh**: Mechanism to trigger screen redraws when switching for problematic games
4. **Render Textures**: Complete screen isolation using separate render targets
5. **Smart Switching**: Game-specific handling for known rendering patterns
6. **Hybrid Approach**: Combination of methods based on game behavior detection

## Conclusion

The implemented single-screen mode provides a solid foundation for 3DS compatibility on small displays, but with important caveats about game compatibility. The clipping approach works excellently for games with frequent redraw cycles (like blackjack) but has significant limitations with games that render infrequently or rely on continuous dual-screen rendering (like Sudoku).

**Recommendation**: This implementation is suitable for games that:
- Have frequent content updates
- Don't rely heavily on static content
- Have dynamic rendering patterns

For games with known compatibility issues, users may need to use dual-screen mode or alternative solutions may need to be implemented in the future.

The trade-off prioritizes visual quality and clean display for compatible games over universal compatibility, making it suitable for production use with the understanding that some games may not work optimally.