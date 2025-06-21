# LPP-Vita SDL On-Screen Keyboard

The LPP-Vita SDL port includes a fully functional on-screen keyboard implementation that provides a visual QWERTY keyboard interface for text input using game controller navigation.

## Features

### Visual Keyboard Interface
- **QWERTY Layout** - Standard keyboard layout with numbers, letters, and symbols
- **Shift Support** - Access to uppercase letters and special characters
- **Caps Lock** - Toggle permanent uppercase mode
- **Visual Selection** - Highlighted key selection with controller navigation
- **Special Keys** - Space, Delete, Enter, Clear, Cancel, and OK buttons

### Controller Navigation
- **D-Pad Navigation** - Move cursor around the keyboard layout
- **X Button** - Select/activate the highlighted key
- **Triangle** - Toggle caps lock mode
- **Circle** - Cancel keyboard input
- **Automatic Shift** - Shift mode auto-disables after character input (except caps lock)

### Text Input Features
- **Character Limits** - Configurable maximum text length
- **Password Mode** - Hidden text input support
- **Multiline Support** - Text spanning multiple lines
- **Real-time Display** - See text as you type

## API Reference

### Keyboard Module Functions

The on-screen keyboard maintains full compatibility with the original Vita keyboard API while adding visual functionality.

#### Basic Functions

```lua
Keyboard.start(title, initial_text, max_length, type, mode, options)
```
- `title` - Window title text (string)
- `initial_text` - Pre-filled text content (string)
- `max_length` - Maximum characters allowed (integer, default: 128)
- `type` - Keyboard type constant (default: TYPE_DEFAULT)
- `mode` - Input mode constant (default: MODE_TEXT)
- `options` - Additional options bitmask (default: 0)

```lua
local state = Keyboard.getState()
```
Returns the current keyboard state:
- `RUNNING` - Keyboard is active and waiting for input
- `FINISHED` - User confirmed input (pressed Enter/OK)
- `CANCELED` - User canceled input (pressed Circle/Cancel)

```lua
local text = Keyboard.getInput()
```
Returns the current text content as entered by the user.

```lua
Keyboard.clear()
```
Closes the keyboard and cleans up resources.

#### On-Screen Specific Functions

```lua
Keyboard.draw()
```
Renders the visual keyboard interface. Call this in your main loop when the keyboard is active.

```lua
Keyboard.update(pad)
```
Processes controller input for keyboard navigation and text entry.
- `pad` - Controller input state from `Controls.read()`

```lua
local active = Keyboard.isActive()
```
Returns `true` if the keyboard is currently active and visible.

### Constants

#### Keyboard Types
- `TYPE_DEFAULT` - Standard keyboard (value: 0)
- `TYPE_LATIN` - Latin character set (value: 1)
- `TYPE_NUMBER` - Numeric input only (value: 2)
- `TYPE_EXT_NUMBER` - Extended numeric (value: 3)

#### Input Modes
- `MODE_TEXT` - Normal text input (value: 0)
- `MODE_PASSWORD` - Hidden password input (value: 1)

#### States
- `RUNNING` - Keyboard active (value: 1)
- `FINISHED` - Input completed (value: 2)
- `CANCELED` - Input canceled (value: 3)

#### Options
- `OPT_MULTILINE` - Allow multiline text (value: 1)
- `OPT_NO_AUTOCAP` - Disable auto-capitalization (value: 2)
- `OPT_NO_ASSISTANCE` - Disable input assistance (value: 4)

## Usage Examples

### Basic Text Input

```lua
-- Start keyboard with title and initial text
Keyboard.start("Enter Name", "Player1", 20, TYPE_DEFAULT, MODE_TEXT)

while true do
    Graphics.initBlend()
    Screen.clear()
    
    -- Handle keyboard input
    if Keyboard.isActive() then
        Keyboard.update(Controls.read())
        
        -- Draw the keyboard interface
        Keyboard.draw()
        
        -- Show current input
        local current_text = Keyboard.getInput()
        Graphics.debugPrint(10, 10, "Typing: " .. current_text, Color.new(255,255,255))
    end
    
    -- Check if input is complete
    local state = Keyboard.getState()
    if state == FINISHED then
        local result = Keyboard.getInput()
        print("User entered: " .. result)
        Keyboard.clear()
        break
    elseif state == CANCELED then
        print("User canceled input")
        Keyboard.clear()
        break
    end
    
    Graphics.termBlend()
    Screen.flip()
end
```

### Password Input

```lua
-- Password entry with hidden text
Keyboard.start("Enter Password", "", 50, TYPE_DEFAULT, MODE_PASSWORD)

local password = ""
while Keyboard.getState() == RUNNING do
    Graphics.initBlend()
    Screen.clear()
    
    if Keyboard.isActive() then
        Keyboard.update(Controls.read())
        Keyboard.draw()
        
        -- Show asterisks instead of actual password
        local text_length = string.len(Keyboard.getInput())
        local display = string.rep("*", text_length)
        Graphics.debugPrint(10, 10, "Password: " .. display, Color.new(255,255,255))
    end
    
    Graphics.termBlend()
    Screen.flip()
end

if Keyboard.getState() == FINISHED then
    password = Keyboard.getInput()
    print("Password entered (length: " .. string.len(password) .. ")")
end
Keyboard.clear()
```

### Multi-Input Dialog

```lua
local function getTextInput(title, initial, max_len)
    Keyboard.start(title, initial or "", max_len or 100, TYPE_DEFAULT, MODE_TEXT)
    
    while Keyboard.getState() == RUNNING do
        Graphics.initBlend()
        Screen.clear()
        
        if Keyboard.isActive() then
            Keyboard.update(Controls.read())
            Keyboard.draw()
            
            Graphics.debugPrint(10, 10, title, Color.new(255,255,0))
            Graphics.debugPrint(10, 30, Keyboard.getInput(), Color.new(255,255,255))
        end
        
        Graphics.termBlend()
        Screen.flip()
    end
    
    local result = nil
    if Keyboard.getState() == FINISHED then
        result = Keyboard.getInput()
    end
    Keyboard.clear()
    return result
end

-- Get multiple inputs
local name = getTextInput("Enter Your Name", "Player")
if name then
    local email = getTextInput("Enter Email", "")
    if email then
        print("Name: " .. name .. ", Email: " .. email)
    end
end
```

## Controls Reference

### Navigation
- **Up/Down/Left/Right** - Move selection cursor around keyboard
- **X (Cross)** - Select highlighted key or special action
- **Triangle** - Toggle caps lock (permanent uppercase)
- **Circle** - Cancel keyboard input
- **Square** - (Not used by keyboard, available for your app)

### Special Keys
- **SPACE** - Insert space character
- **DEL** - Delete last character (backspace)
- **ENTER/OK** - Confirm input and finish
- **CANCEL** - Cancel input without saving
- **CLEAR** - Clear all entered text
- **SHIFT** - Toggle shift mode (temporary uppercase/symbols)

### Keyboard Layouts

#### Normal Layout
```
1 2 3 4 5 6 7 8 9 0 - = DEL
q w e r t y u i o p [ ] \
a s d f g h j k l ; ' ENTER
SHIFT z x c v b n m , . / SHIFT
SPACE CLEAR CANCEL OK
```

#### Shift Layout
```
! @ # $ % ^ & * ( ) _ + DEL
Q W E R T Y U I O P { } |
A S D F G H J K L : " ENTER
SHIFT Z X C V B N M < > ? SHIFT
SPACE CLEAR CANCEL OK
```

## System Requirements

### Dependencies
- **SDL2** - For rendering and input handling
- **Compatible controller** - Game controller or keyboard for navigation

### Platform Support
- **Linux** - Full keyboard support
- **macOS** - Full keyboard support  
- **Windows** - Full keyboard support

### Performance
- **Rendering** - Lightweight SDL2 rectangle and text rendering
- **Memory** - Minimal memory footprint (~1KB for keyboard state)
- **Input** - 60fps responsive navigation and text input

## Implementation Notes

### Visual Design
- **Dark Theme** - Dark background with light text for readability
- **Highlight Colors** - Selected keys are highlighted in blue
- **Status Colors** - Special keys (like SHIFT) use different colors when active
- **Responsive Layout** - Keyboard scales to screen size

### Text Handling
- **UTF-8 Support** - Standard string handling for international characters
- **Length Limits** - Configurable maximum text length with visual feedback
- **Real-time Updates** - Text updates immediately as keys are pressed

### Error Handling
- **State Validation** - Prevents multiple keyboard instances
- **Safe Cleanup** - Automatic resource cleanup on exit
- **Input Validation** - Bounds checking for all parameters

## Compatibility

### Vita API Compatibility
The on-screen keyboard maintains full compatibility with the original PlayStation Vita keyboard API:

- All function names and signatures match the Vita API
- All constants have the same values as Vita constants
- Existing Vita code works without modification
- New features are additive and optional

### Differences from Vita
- **Visual Interface** - Shows an on-screen keyboard instead of system dialog
- **Controller Navigation** - Uses game controller instead of touch input
- **Immediate Feedback** - Real-time text display during input
- **Customizable** - More flexible layout and appearance options

## Examples

The following example files demonstrate keyboard functionality:

- `keyboard_onscreen_demo.lua` - Interactive keyboard demo with visual interface
- `simple_keyboard_test.lua` - Basic API test without UI
- `Keyboard/index.lua` - Original Vita-compatible example

Run examples with:
```bash
./lpp_sdl samples/keyboard_onscreen_demo.lua
```