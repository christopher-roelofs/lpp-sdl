<p align="center">
	<img src="https://github.com/christopher-roelofs/lpp-sdl/blob/main/banner.png?raw=true"/>
</p>

# lpp-sdl: Lua Player Plus for Desktop

**lpp-sdl** is a port of the popular PS Vita homebrew interpreter, [Lua Player Plus Vita](https://github.com/Rinnegatamante/lpp-vita), to desktop platforms using the SDL2 library. This project aims to maintain compatibility with the original lpp-vita API, allowing developers to run and test their Lua homebrew applications on Linux, and potentially other desktop systems.

The interpreter runs on LuaJIT 2.1, providing high-performance execution of Lua scripts.

# Features

##### Graphics

*   2D Graphics Rendering .
*   Native support for TTF.
*   Native support for BMP/PNG/JPG images.

##### Multimedia

*   Complete sound system with support for:
    *   WAVEform audio files (**.wav**)
    *   Ogg Media audio files (**.ogg**)
*   Native support for video playback via FFmpeg.

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

# Compiling the Source (Linux)

To compile `lpp-sdl` on a Debian-based Linux distribution (like Ubuntu), you'll need to install the following dependencies:

```bash
sudo apt-get update
sudo apt-get install build-essential pkg-config libluajit-5.1-dev libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev libsdl2-mixer-dev libopencv-dev libavformat-dev libavcodec-dev libswscale-dev libsqlite3-dev libcurl4-openssl-dev libgsm1-dev
```

Once the dependencies are installed, you can compile the project by running `make` in the root directory:

```bash
make
```

# Showcase

The following homebrews were originally developed for the PS Vita using Lua Player Plus. Many of them can be run with `lpp-sdl` thanks to its compatibility layer.

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

##### Utilities
* [Moon Whitelister](https://github.com/gnmmarechal/moon-whitelister)
* [luaIrc](http://wololo.net/talk/viewtopic.php?f=116&t=47107)
* [Simple Text Editor](http://wololo.net/talk/viewtopic.php?f=116&t=47018)
* [Vita Object Loader](http://wololo.net/talk/viewtopic.php?f=116&t=47982)
* [Voice Recorder Vita](http://wololo.net/talk/viewtopic.php?f=116&t=48444)
* [Pro Camera Vita](http://wololo.net/talk/viewtopic.php?f=116&t=48379)
* [Notepad Vita](http://wololo.net/talk/viewtopic.php?f=116&t=48500)
* [Video Bubbles Creator](http://wololo.net/talk/viewtopic.php?f=116&t=48581)
* [VitaGraphs](https://vitadb.rinnegatamante.it/#/info/363)
* [SwitchView UI](https://vitadb.rinnegatamante.it/#/info/338)

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
