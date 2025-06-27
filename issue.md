# Issues

## VitaSudoku Text Alignment Issue

### Problem Description
In the VitaSudoku game (`tests/games/vita/VitaSudoku/index.lua`), certain numbers in the grid appear misaligned. Specifically, the digits 2, 3, 5, 6, 8, and 9 look "too far left" in their grid cells, while digits 1, 4, and 7 appear correctly positioned.

### Technical Details
- **Affected Function**: `Graphics.debugPrint()` (implemented as `lua_print` in `src/luaGraphics.cpp`)
- **Game Code**: Line 264 in VitaSudoku - `Graphics.debugPrint(433+(i-1)*56,20+(j-1)*56,my_matrix[i][j][1],color, 1.5)`
- **Grid Layout**: 9x9 Sudoku grid with 56-pixel cell spacing
- **Font Scaling**: 1.5x scale factor applied

### Root Cause Analysis
This appears to be a font metric difference between:
- **Original Vita font system**: Character positioning and advance widths
- **SDL TTF rendering**: Different character metrics for certain glyphs

The issue affects specific characters (2,3,5,6,8,9) but not others (1,4,7), suggesting it's related to individual character glyph metrics rather than general text positioning.

### Current Status
- Core functionality is working (game is playable, numbers are readable)
- Issue is cosmetic - affects visual alignment but not gameplay
- Text positioning system is otherwise correct for other games
- Touch input and other graphics functions working properly

### Investigation Attempts
1. **Horizontal centering**: Tried centering text at coordinates - affected all numbers
2. **Character-specific offsets**: Attempted targeted adjustments - made alignment worse
3. **General positioning**: Reverted to original SDL TTF positioning

### Potential Solutions (Future)
1. **Font replacement**: Use a different TTF font with better character metrics
2. **Character-specific adjustments**: Fine-tune offsets for problematic characters
3. **Font metrics analysis**: Compare advance widths between Vita and SDL fonts
4. **Custom text rendering**: Implement character-by-character positioning
5. **Grid layout adjustment**: Modify game code to center numbers in cells

### Files Involved
- `src/luaGraphics.cpp` - `lua_print` function (Graphics.debugPrint implementation)
- `tests/games/vita/VitaSudoku/index.lua` - Game logic and grid rendering

### Priority
Low - Cosmetic issue that doesn't affect functionality