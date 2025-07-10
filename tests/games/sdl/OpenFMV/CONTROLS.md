# OpenFMV - Controls Reference

The main menu displays a looping background video on the left side with menu options on the right side, similar to the original OpenFMV design.

## Keyboard Controls

### Main Menu Navigation
- **Up/Down Keys** - Navigate menu options
- **Enter** or **Space** - Select menu option
- **Backspace** - Go back
- **Escape** - Exit game (hardcoded in lpp-sdl)

### Video Playback
- **P** or **Space** - Pause/Resume video
- **Backspace** - Return to main menu

### Settings Menu
- **Up/Down Keys** - Navigate settings
- **Left/Right Keys** - Change setting values
- **Enter** or **Space** - Select/Confirm
- **Backspace** - Return to main menu

### Choice Selection (Automatic)
- **Choices appear automatically** at predetermined times during video
- **Left/Right Keys** - Navigate choices horizontally
- **Enter** or **Space** - Select choice
- **Timer automatically selects** current choice when time expires

### Launcher
- **Up/Down Keys** - Select game
- **Enter** or **Space** - Launch selected game
- **Backspace** - Exit launcher
- **Escape** - Exit completely (hardcoded in lpp-sdl)

## Gamepad Controls (Vita/3DS Style)

### Main Menu Navigation
- **D-Pad Up/Down** - Navigate menu options
- **X Button** - Select menu option
- **Triangle** - Exit game

### Video Playback
- **Square** - Pause/Resume video
- **Triangle** - Return to main menu

### Choice Selection
- **D-Pad Left/Right** - Navigate choices horizontally
- **X Button** - Select choice

## Game Features

- **Menu Background Video** - Looping video plays on left side of main menu
- **Auto-save** - Game automatically saves after each choice
- **Resume** - Continue from last choice made
- **Subtitles** - Automatic SRT subtitle support
- **Multiple Languages** - Support for localized text and subtitles
- **Automatic Choice Timing** - Choices appear at exact times from original game
- **Full Subtitle Support** - ZIP-based subtitles with settings menu control
- **Multi-Language Support** - 19 languages available via settings menu
- **Settings Menu** - Comprehensive settings for subtitles, language, audio, and debug info
- **Debug Mode** - Optional display of technical information (time, video file, resolution, etc.)

## File Structure

```
OpenFMV/
├── index.lua          # Game launcher
├── lateshift.lua      # Late Shift game implementation
├── subtitles/         # ZIP-based subtitle system
│   ├── en.zip         # English subtitles
│   ├── fr.zip         # French subtitles
│   ├── de.zip         # German subtitles
│   ├── es.zip         # Spanish subtitles
│   ├── it.zip         # Italian subtitles
│   ├── ru.zip         # Russian subtitles
│   ├── ja.zip         # Japanese subtitles
│   ├── ko.zip         # Korean subtitles
│   └── (15 more)      # 19 languages total
├── lang/              # Language files
│   └── en.str         # English strings (+ 18 more)
├── videos/Converted/  # Video files (.mp4 only)
├── fonts/             # Font files
└── CONTROLS.md        # This file
```