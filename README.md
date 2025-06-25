<p align="center">
	<img src="https://github.com/christopher-roelofs/lpp-sdl/blob/main/banner.png?raw=true"/>
</p>

# lpp-sdl: Lua Player Plus for Desktop

**lpp-sdl** is a cross-platform port of the popular PS Vita homebrew interpreter, [Lua Player Plus Vita](https://github.com/Rinnegatamante/lpp-vita), to desktop platforms using the SDL2 library. This project maintains full compatibility with the original lpp-vita API, allowing developers to run and test their Lua homebrew applications seamlessly across multiple platforms.

The interpreter runs on LuaJIT 2.1, providing high-performance execution of Lua scripts.

## Supported Platforms

- **Linux** (x86_64, ARM64)
- **macOS** (Intel x86_64, Apple Silicon ARM64)
- **Windows** (with SDL2 dependencies)

### Platform-Specific Optimizations

**macOS Apple Silicon (ARM64)**:
- Uses OpenGL renderer for optimal compatibility
- Includes graphics buffer synchronization fixes
- Disables render batching to prevent visual artifacts

**macOS Intel (x86_64)**:
- Uses Metal renderer for best performance
- Enables render batching optimizations
- Standard macOS graphics pipeline

**Linux (all architectures)**:
- Uses default SDL2 renderer selection
- No platform-specific workarounds needed

# Features

##### Graphics

*   2D Graphics Rendering with hardware acceleration.
*   Font support:
    *   **TTF** (TrueType Font) files
    *   **OTF** (OpenType Font) files
*   Image format support:
    *   **BMP** (Bitmap) images
    *   **PNG** (Portable Network Graphics) with transparency
    *   **JPG/JPEG** (Joint Photographic Experts Group) images

##### Multimedia

*   Complete sound system with support for:
    *   **WAV** (WAVEform audio files)
        *   **PCM** (Pulse Code Modulation) - uncompressed audio
        *   **GSM 6.10** - compressed voice codec
    *   **OGG** (Ogg Vorbis audio files)
    *   **MP3** (MPEG Audio Layer III) via SDL2_mixer
*   Video playback system via FFmpeg:
    *   **MP4**, **AVI**, **MKV**, **MOV** video containers
    *   **H.264**, **H.265**, **VP8**, **VP9** video codecs
    *   **AAC**, **MP3**, **Vorbis** audio codecs
*   Subtitle support:
    *   **SRT** (SubRip Text) subtitle files
    *   **VTT** (WebVTT) subtitle files
    *   Automatic subtitle synchronization
    *   Customizable subtitle styling

##### Controls

*   Generic controls system with support for keyboards and gamepads via SDL2.

##### Network

*   Complete sockets system support.
*   Native support to HTTP/HTTPS requests via cURL.

##### System

*   I/O access for the local filesystem.
*   Native support to SQLite databases.

##### Utilities

*   Timer system.
*   Advanced arithmetical functions support (math library).

# Compatibility Modes

`lpp-sdl` includes compatibility modes to run homebrew applications originally designed for different handheld consoles. These modes provide full API compatibility while adapting screen resolutions and input systems for desktop platforms.

## Command Line Usage

```bash
# Vita compatibility mode
./lpp-sdl -vitacompat your_game.lua

# 3DS compatibility mode  
./lpp-sdl -3dscompat your_game.lua                # Horizontal layout (default)
./lpp-sdl -3dscompat-horizontal your_game.lua     # Side-by-side layout (explicit)  
./lpp-sdl -3dscompat-vertical your_game.lua       # Top/bottom layout (authentic)

# Native SDL mode (default)
./lpp-sdl your_game.lua              # Native mode is default

# Legacy flag support (deprecated)
./lpp-sdl -vitascale your_game.lua   # Same as -vitacompat
./lpp-sdl -3dsscale your_game.lua    # Same as -3dscompat

# Help
./lpp-sdl --help                     # Show all options
```

## Control Compatibility

All compatibility modes provide seamless backward compatibility:

- **Vita Games**: Use `SCE_CTRL_*` constants (e.g., `SCE_CTRL_CROSS`, `SCE_CTRL_CIRCLE`)
- **3DS Games**: Use `KEY_*` constants (e.g., `KEY_A`, `KEY_B`, `KEY_X`, `KEY_Y`, `KEY_TOUCH`)
- **Desktop Games**: Full access to both console aliases and native SDL2 input

These control aliases work **regardless of which compatibility mode is active**, ensuring games written for specific consoles run without modification on desktop platforms.

## Vita Compatibility Mode

Simulates the PS Vita's screen resolution and API for running Vita homebrew applications.

### Features
- **Adaptive Resolution**: 
  - **Normal screens**: 960x544 logical resolution (full Vita resolution)
  - **Small screens (≤640x480)**: 640x360 logical resolution (scaled down, maintains 16:9 aspect)
- **API Compatibility**: Full lpp-vita function support
- **Controls**: `SCE_CTRL_*` constants and Vita-specific functions  
- **Graphics**: Vita2D-compatible rendering pipeline
- **Small Screen Support**: Automatically scales for devices as small as 640x480

### Usage

```bash
./lpp-sdl -vitacompat your_game.lua
```

The system automatically detects your screen size and uses the most appropriate Vita resolution for optimal usability.

## 3DS Compatibility Mode

Emulates the Nintendo 3DS dual-screen environment with adaptive screen handling for different display sizes.

### Features
- **Orientation Options**:
  - **Horizontal layout** (`-3dscompat` or `-3dscompat-horizontal`): Side-by-side screens (720x240)
  - **Vertical layout** (`-3dscompat-vertical`): Top/bottom screens (400x480) - more authentic 3DS feel
- **Adaptive Screen Modes**:
  - **Large screens**: Dual-screen layout in chosen orientation
  - **Small screens**: Single-screen mode with TAB key switching
- **Horizontal Layout** (side-by-side):
  - **Combined resolution**: 720x240 (400+320 width, 240 height)
  - **Top screen**: 400x240 resolution (left side)
  - **Bottom screen**: 320x240 resolution (right side)
- **Vertical Layout** (top/bottom):
  - **Combined resolution**: 400x480 (400 width, 240+240 height)
  - **Top screen**: 400x240 resolution (upper area)
  - **Bottom screen**: 320x240 resolution (lower area, centered)
- **Single-Screen Mode** (small displays):
  - **Active screen**: Shows one screen at a time (400x240 or 320x240)
  - **Screen switching**: Press TAB to toggle between top and bottom screens
  - **Visual indicator**: Console output shows which screen is active
- **Touch simulation**: Mouse input mapped to bottom screen touch
- **API Compatibility**: 3DS-specific functions and constants

### Usage

```bash
# Default horizontal layout (side-by-side)
./lpp-sdl -3dscompat your_game.lua

# Explicit horizontal layout
./lpp-sdl -3dscompat-horizontal your_game.lua

# Vertical layout (top/bottom) - more authentic 3DS experience
./lpp-sdl -3dscompat-vertical your_game.lua
```

**On large screens**: Displays both screens in the chosen orientation (horizontal side-by-side or vertical top/bottom).
**On small screens**: Automatically enables single-screen mode - use TAB key to switch between top and bottom screens.

## Native SDL Mode

For modern desktop development, provides adaptive high-resolution rendering without console constraints.

### Features
- **Adaptive Resolution**: Automatically scales logical resolution based on screen size
  - **640x480 and below**: 640x480 logical resolution (VGA)
  - **800x600 range**: 800x600 logical resolution (SVGA) 
  - **1024x768 range**: 1024x768 logical resolution (XGA)
  - **Above 1024x768**: 1280x720 logical resolution (HD)
- **Performance**: No compatibility overhead
- **Input**: Full SDL2 input system access
- **Graphics**: Native SDL2 rendering capabilities
- **Small Screen Support**: Optimized for devices as small as 640x480

### Usage

```bash
./lpp-sdl your_game.lua              # Native mode is default (no flag needed)
```

The system automatically detects your screen size and chooses the most appropriate logical resolution for optimal usability.

### 3DS Screen Layout

```
┌─────────────────┬─────────────┐
│                 │             │
│   Top Screen    │   Bottom    │
│   (400x240)     │   Screen    │
│                 │  (320x240)  │
│                 │             │
└─────────────────┴─────────────┘
```

Games designed for 3DS can use `Screen.init(TOP_SCREEN)` and `Screen.init(BOTTOM_SCREEN)` to target specific screens. The 3DS mode automatically calculates optimal scaling factors for both screens while maintaining their aspect ratios.

## Built-in File Browser

When no Lua file is specified and no `index.lua` file is found in the current directory, `lpp-sdl` automatically launches an integrated file browser:

```bash
./lpp-sdl                    # Launches file browser if no index.lua found
./lpp-sdl -vitacompat        # File browser with Vita compatibility
./lpp-sdl -3dscompat         # File browser with 3DS compatibility
```

### File Browser Features

- **Keyboard Navigation**: Use arrow keys to navigate, Enter to select, Escape to exit
- **Directory Traversal**: Navigate through folders using ".." parent directory entries
- **Lua File Filtering**: Only displays `.lua` files and directories for easy selection
- **Real-time Display**: Shows current path and file information
- **Cross-platform**: Works consistently across all supported platforms

The file browser provides a convenient way to launch Lua games without command-line arguments, making `lpp-sdl` more user-friendly for casual use.

## Control Mappings

`lpp-sdl` provides universal keyboard mappings that work in all modes. The compatibility mode flags only affect screen resolution and graphics - controls remain consistent:

| Physical Control | Keyboard Key | Vita Alias | 3DS Alias |
| :--- | :--- | :--- | :--- |
| D-Pad Up | Arrow Up | `SCE_CTRL_UP` | `KEY_DUP` |
| D-Pad Down | Arrow Down | `SCE_CTRL_DOWN` | `KEY_DDOWN` |
| D-Pad Left | Arrow Left | `SCE_CTRL_LEFT` | `KEY_DLEFT` |
| D-Pad Right | Arrow Right | `SCE_CTRL_RIGHT` | `KEY_DRIGHT` |
| A Button | Spacebar | `SCE_CTRL_CROSS` | `KEY_X` |
| B Button | Backspace | `SCE_CTRL_CIRCLE` | `KEY_B` |
| X Button | Z | `SCE_CTRL_SQUARE` | - |
| Y Button | Left Shift | `SCE_CTRL_TRIANGLE` | `KEY_Y` |
| A Button (3DS) | Enter | - | `KEY_A` |
| L Trigger | Q / Page Up | `SCE_CTRL_LTRIGGER` | `KEY_L` |
| R Trigger | E / Page Down | `SCE_CTRL_RTRIGGER` | `KEY_R` |
| Start | Enter / Tab | `SCE_CTRL_START` | `KEY_START` |
| Select | Tab / Left Ctrl | `SCE_CTRL_SELECT` | `KEY_SELECT` |
| Home/PS Button | H | `SCE_CTRL_PSBUTTON` | - |
| Touch Screen | Mouse Click | - | `KEY_TOUCH` |
| Volume Up | Page Up | `SCE_CTRL_VOLUP` | - |
| Volume Down | Page Down | `SCE_CTRL_VOLDOWN` | - |

**Note**: Both `SCE_CTRL_*` and `KEY_*` constants are available in all modes for backward compatibility with existing console scripts.

### 3DS-Specific Controls

In 3DS compatibility mode:
- **Touch Screen**: Mouse input on bottom screen area
- **Dual Screen Switching**: Games can programmatically switch between screens using `Screen.init()`
- **3D Functions**: API compatibility for `Screen.get3DLevel()`, `Screen.enable3D()`, `Screen.disable3D()` (always returns 2D mode)

# Building from Source

## Linux

To compile `lpp-sdl` on a Debian-based Linux distribution (like Ubuntu), install the following dependencies:

```bash
sudo apt-get update
sudo apt-get install build-essential pkg-config libluajit-5.1-dev libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev libsdl2-mixer-dev libopencv-dev libavformat-dev libavcodec-dev libswscale-dev libsqlite3-dev libcurl4-openssl-dev libgsm1-dev
```

For other Linux distributions, install equivalent packages using your distribution's package manager.

## macOS

Install dependencies using Homebrew:

```bash
brew install luajit sdl2 sdl2_ttf sdl2_image sdl2_mixer opencv ffmpeg sqlite curl
```

## Windows

Use vcpkg or manually install SDL2 development libraries.

## Compilation

Once dependencies are installed, compile the project:

```bash
make
```

The executable will be created in the project directory. Platform-specific optimizations are automatically applied during compilation based on the target architecture.

# Known Issues & Platform Notes

## macOS ARM64 Graphics Glitches

If you encounter graphics glitches (colored noise, artifacts) on macOS Apple Silicon, the project includes automatic fixes that:
- Switch to OpenGL renderer instead of Metal
- Disable render batching to prevent buffer synchronization issues
- Add frame-by-frame buffer clearing for letterbox areas

These fixes are automatically applied when building on macOS ARM64.

## Performance Notes

- **macOS Intel**: Best performance with Metal renderer
- **macOS ARM64**: Stable rendering with OpenGL (slight performance trade-off for compatibility)
- **Linux**: Optimal performance across all architectures

# Showcase

The following homebrews were originally developed for the PS Vita using Lua Player Plus. They can be run with `lpp-sdl` across all supported platforms thanks to its compatibility layer.

##### Games
* [VitaSudoku](http://wololo.net/talk/viewtopic.php?f=116&t=46423)
* [4Rows](http://wololo.net/talk/viewtopic.php?f=116&t=46253)
* [Flppy Bird](http://wololo.net/talk/viewtopic.php?f=116&t=46593)
* [Deathrun to Vita](http://wololo.net/talk/viewtopic.php?f=116&t=46567)
* [Super Hero Chronicles](http://wololo.net/talk/viewtopic.php?f=116&t=46677)
* [vitaWanted](http://wololo.net/talk/viewtopic.php?f=116&t=46726)
* [Labyrinth 3D](http://wololo.net/talk/viewtopic.php?f=116&t=46845)
* [Resident Evil CODE:Vita](http://wololo.net/talk/viewtopic.php?f=52&t=47380)
* [Lua Game of Life](https://github.com/domis4/lua-gameoflife/)
* [Galactic Federation](http://vitadb.rinnegatamante.it/#/info/206)
* [Starfield Vita](http://vitadb.rinnegatamante.it/#/info/128)
* [EUCLIOD](http://vitadb.rinnegatamante.it/#/info/263)
* [Crazy Traffic Jam 3D](http://wololo.net/talk/viewtopic.php?f=116&t=48358)
* [Zombiebound](http://wololo.net/talk/viewtopic.php?f=116&t=48583)
* [vita-tetromino](https://github.com/svennd/vita-tetromino)
* [VitaHangman](https://vitadb.rinnegatamante.it/#/info/306)
* [Tetromino: Touhou Edition](https://vitadb.rinnegatamante.it/#/info/376)
* [Vita Hangman: Touhou Edition](https://vitadb.rinnegatamante.it/#/info/379)
* [Cookie Clicker](https://vitadb.rinnegatamante.it/#/info/351)
* [Vitamon GO](https://vitadb.rinnegatamante.it/#/info/353)
* [vita-chain](https://vitadb.rinnegatamante.it/#/info/339)
* [ViTanks](https://vitadb.rinnegatamante.it/#/info/472)


##### Emulators
* [MicroCHIP](http://wololo.net/talk/viewtopic.php?f=116&t=48620)

##### Engines & Interpreters
* [RayCast3D Engine](http://wololo.net/talk/viewtopic.php?f=116&t=46379)
* [March22](http://wololo.net/talk/viewtopic.php?f=116&t=47068)

# Credits

This project is a port and would not be possible without the original work of the lpp-vita team.

*   **Rinnegatamante** for creating lpp-vita.
*   vitasdk contributors.
*   **xerpi** for vita2d and debug FTP code.
*   **gnmmarechal** for testing the interpreter.
*   **hyln9** for vita-luajit.
*   **frangarcj** for the help during 3D rendering feature addition.
*   **TheFloW** for some snippets and ideas.
*   **Misledz** for the Lua Player Plus logo.
*   **Arkanite** for providing a sample for sceAvPlayer.
*   **EasyRPG Team** for the Audio Decoder.
*   **lecram** for gifdec.
