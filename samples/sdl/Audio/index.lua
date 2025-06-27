--[[
Audio Format Test for lpp-sdl
Tests MP3, OGG, WAV, and MIDI audio file support with full metadata extraction

Controls:
- 1: Play MP3 file (with looping)
- 2: Play OGG file (no looping)  
- 3: Play WAV file (with looping)
- 4: Play MIDI file (with looping)
- M: Show detailed metadata for all files
- S: Stop all audio
- ESC: Exit

This sample demonstrates:
- Loading different audio formats (MP3, OGG, WAV, MIDI)
- Automatic metadata extraction (ID3 tags, Vorbis Comments, WAV INFO)
- MIDI playback with FM synthesis
- Playing audio with looping options
- Volume control and playback status
- Real-time metadata display
]]--

-- Initialize graphics and audio
Graphics.initBlend()
Sound.init()

-- Load audio files
local mp3_sound = nil
local ogg_sound = nil
local wav_sound = nil
local midi_sound = nil
local current_sound = nil
local show_metadata = false

-- Store metadata for each loaded file
local mp3_metadata = {title = "", author = "", loaded = false}
local ogg_metadata = {title = "", author = "", loaded = false}
local wav_metadata = {title = "", author = "", loaded = false}
local midi_metadata = {title = "", author = "", loaded = false}

-- Try to load each audio format
local function loadAudioFiles()
    -- Load MP3
    local success, result = pcall(function()
        return Sound.open("sample.mp3")
    end)
    if success then
        mp3_sound = result
        mp3_metadata.title = Sound.getTitle(result)
        mp3_metadata.author = Sound.getAuthor(result)
        mp3_metadata.loaded = true
        print("MP3 loaded: '" .. mp3_metadata.title .. "' by " .. mp3_metadata.author)
    else
        print("Failed to load MP3: " .. tostring(result))
    end
    
    -- Load OGG
    success, result = pcall(function()
        return Sound.open("sample.ogg")
    end)
    if success then
        ogg_sound = result
        ogg_metadata.title = Sound.getTitle(result)
        ogg_metadata.author = Sound.getAuthor(result)
        ogg_metadata.loaded = true
        print("OGG loaded: '" .. ogg_metadata.title .. "' by " .. ogg_metadata.author)
    else
        print("Failed to load OGG: " .. tostring(result))
    end
    
    -- Load WAV
    success, result = pcall(function()
        return Sound.open("sample.wav")
    end)
    if success then
        wav_sound = result
        wav_metadata.title = Sound.getTitle(result)
        wav_metadata.author = Sound.getAuthor(result)
        wav_metadata.loaded = true
        print("WAV loaded: '" .. wav_metadata.title .. "' by " .. wav_metadata.author)
    else
        print("Failed to load WAV: " .. tostring(result))
    end
    
    -- Load MIDI
    success, result = pcall(function()
        return Sound.open("sample.mid")
    end)
    if success then
        midi_sound = result
        midi_metadata.title = Sound.getTitle(result) or "MIDI File"
        midi_metadata.author = Sound.getAuthor(result) or "Unknown"
        midi_metadata.loaded = true
        print("MIDI loaded: '" .. midi_metadata.title .. "' by " .. midi_metadata.author)
    else
        print("Failed to load MIDI: " .. tostring(result))
    end
end

-- Play a sound with optional looping
local function playSound(sound, format_name, loop)
    if sound then
        -- Stop current sound first
        if current_sound and Sound.isPlaying(current_sound) then
            Sound.pause(current_sound)
        end
        
        current_sound = sound
        Sound.play(sound, loop and 1 or 0)
        
        -- Get metadata
        local title = Sound.getTitle(sound)
        local author = Sound.getAuthor(sound)
        
        print(string.format("Playing %s: %s by %s (Loop: %s)", 
              format_name, title, author, loop and "Yes" or "No"))
    else
        print(format_name .. " file not available")
    end
end

-- Stop all audio
local function stopAllAudio()
    if mp3_sound and Sound.isPlaying(mp3_sound) then
        Sound.pause(mp3_sound)
    end
    if ogg_sound and Sound.isPlaying(ogg_sound) then
        Sound.pause(ogg_sound)
    end
    if wav_sound and Sound.isPlaying(wav_sound) then
        Sound.pause(wav_sound)
    end
    if midi_sound and Sound.isPlaying(midi_sound) then
        Sound.pause(midi_sound)
    end
    current_sound = nil
    print("All audio stopped")
end

-- Load audio files
loadAudioFiles()

-- Main loop
local running = true
local prev_pad = 0
while running do
    -- Clear screen and initialize graphics
    Graphics.initBlend()
    Screen.clear()
    Graphics.fillRect(0, 0, 960, 544, Color.new(0, 0, 50))
    
    -- Draw title
    Graphics.debugPrint(10, 10, "Audio Format Test - lpp-sdl", Color.new(255, 255, 255))
    Graphics.debugPrint(10, 30, "Demonstrates MP3, OGG, WAV, and MIDI playback", Color.new(200, 200, 200))
    Graphics.debugPrint(10, 50, "Sample files from: https://github.com/rafaelreis-hotmart/Audio-Sample-files", Color.new(150, 150, 150))
    
    -- Draw instructions
    local y = 80
    Graphics.debugPrint(10, y, "Controls:", Color.new(255, 255, 0))
    y = y + 30
    Graphics.debugPrint(20, y, "1:         Play MP3 (Loop)", Color.new(255, 255, 255))
    y = y + 25
    Graphics.debugPrint(20, y, "2:         Play OGG (No Loop)", Color.new(255, 255, 255))
    y = y + 25
    Graphics.debugPrint(20, y, "3:         Play WAV (Loop)", Color.new(255, 255, 255))
    y = y + 25
    Graphics.debugPrint(20, y, "4:         Play MIDI (Loop)", Color.new(255, 255, 255))
    y = y + 25
    Graphics.debugPrint(20, y, "M:         Toggle Metadata View", Color.new(255, 255, 255))
    y = y + 25
    Graphics.debugPrint(20, y, "S:         Stop All Audio", Color.new(255, 255, 255))
    y = y + 25
    Graphics.debugPrint(20, y, "ESC:       Exit", Color.new(255, 255, 255))
    
    -- Draw file status and metadata
    y = y + 40
    if show_metadata then
        Graphics.debugPrint(10, y, "Detailed Metadata (Press M to hide):", Color.new(255, 255, 0))
        y = y + 30
        
        -- MP3 Metadata
        Graphics.debugPrint(20, y, "MP3 File:", Color.new(100, 255, 100))
        y = y + 20
        if mp3_metadata.loaded then
            Graphics.debugPrint(30, y, "Title: " .. mp3_metadata.title, Color.new(255, 255, 255))
            y = y + 18
            Graphics.debugPrint(30, y, "Artist: " .. mp3_metadata.author, Color.new(255, 255, 255))
            y = y + 18
            Graphics.debugPrint(30, y, "Format: MPEG-1 Audio Layer 3 (ID3 tags)", Color.new(200, 200, 200))
        else
            Graphics.debugPrint(30, y, "Not loaded", Color.new(255, 100, 100))
        end
        y = y + 30
        
        -- OGG Metadata  
        Graphics.debugPrint(20, y, "OGG File:", Color.new(100, 255, 100))
        y = y + 20
        if ogg_metadata.loaded then
            Graphics.debugPrint(30, y, "Title: " .. ogg_metadata.title, Color.new(255, 255, 255))
            y = y + 18
            Graphics.debugPrint(30, y, "Artist: " .. ogg_metadata.author, Color.new(255, 255, 255))
            y = y + 18
            Graphics.debugPrint(30, y, "Format: Ogg Vorbis (Vorbis Comments)", Color.new(200, 200, 200))
        else
            Graphics.debugPrint(30, y, "Not loaded", Color.new(255, 100, 100))
        end
        y = y + 30
        
        -- WAV Metadata
        Graphics.debugPrint(20, y, "WAV File:", Color.new(100, 255, 100))
        y = y + 20
        if wav_metadata.loaded then
            Graphics.debugPrint(30, y, "Title: " .. wav_metadata.title, Color.new(255, 255, 255))
            y = y + 18
            Graphics.debugPrint(30, y, "Artist: " .. wav_metadata.author, Color.new(255, 255, 255))
            y = y + 18
            Graphics.debugPrint(30, y, "Format: WAV (LIST INFO chunks)", Color.new(200, 200, 200))
        else
            Graphics.debugPrint(30, y, "Not loaded", Color.new(255, 100, 100))
        end
        y = y + 30
        
        -- MIDI Metadata
        Graphics.debugPrint(20, y, "MIDI File:", Color.new(100, 255, 100))
        y = y + 20
        if midi_metadata.loaded then
            Graphics.debugPrint(30, y, "Title: " .. midi_metadata.title, Color.new(255, 255, 255))
            y = y + 18
            Graphics.debugPrint(30, y, "Artist: " .. midi_metadata.author, Color.new(255, 255, 255))
            y = y + 18
            Graphics.debugPrint(30, y, "Format: MIDI (FM Synthesis)", Color.new(200, 200, 200))
        else
            Graphics.debugPrint(30, y, "Not loaded", Color.new(255, 100, 100))
        end
        y = y + 40
    else
        Graphics.debugPrint(10, y, "Audio Files Status (Press M for metadata):", Color.new(255, 255, 0))
        y = y + 30
        Graphics.debugPrint(20, y, "MP3: " .. (mp3_sound and "Loaded" or "Failed"), 
                           mp3_sound and Color.new(0, 255, 0) or Color.new(255, 0, 0))
        if mp3_sound then
            Graphics.debugPrint(120, y, "'" .. mp3_metadata.title .. "'", Color.new(150, 150, 255))
        end
        y = y + 25
        Graphics.debugPrint(20, y, "OGG: " .. (ogg_sound and "Loaded" or "Failed"), 
                           ogg_sound and Color.new(0, 255, 0) or Color.new(255, 0, 0))
        if ogg_sound then
            Graphics.debugPrint(120, y, "'" .. ogg_metadata.title .. "'", Color.new(150, 150, 255))
        end
        y = y + 25
        Graphics.debugPrint(20, y, "WAV: " .. (wav_sound and "Loaded" or "Failed"), 
                           wav_sound and Color.new(0, 255, 0) or Color.new(255, 0, 0))
        if wav_sound then
            Graphics.debugPrint(120, y, "'" .. wav_metadata.title .. "'", Color.new(150, 150, 255))
        end
        y = y + 25
        Graphics.debugPrint(20, y, "MIDI: " .. (midi_sound and "Loaded" or "Failed"), 
                           midi_sound and Color.new(0, 255, 0) or Color.new(255, 0, 0))
        if midi_sound then
            Graphics.debugPrint(120, y, "'" .. midi_metadata.title .. "'", Color.new(150, 150, 255))
        end
        y = y + 40
    end
    
    -- Draw current playback status
    y = y + 50
    Graphics.debugPrint(10, y, "Playback Status:", Color.new(255, 255, 0))
    y = y + 30
    
    if current_sound then
        local playing = Sound.isPlaying(current_sound)
        local volume = Sound.getVolume(current_sound)
        local title = Sound.getTitle(current_sound)
        
        Graphics.debugPrint(20, y, "Currently: " .. (playing and "Playing" or "Stopped"), 
                           playing and Color.new(0, 255, 0) or Color.new(255, 100, 100))
        y = y + 25
        Graphics.debugPrint(20, y, "Track: " .. title, Color.new(255, 255, 255))
        y = y + 25
        Graphics.debugPrint(20, y, "Volume: " .. tostring(volume), Color.new(255, 255, 255))
        y = y + 25
    else
        Graphics.debugPrint(20, y, "No audio playing", Color.new(200, 200, 200))
        y = y + 25
    end
    
    -- Draw metadata extraction info
    y = y + 30
    Graphics.debugPrint(10, y, "Metadata Extraction:", Color.new(255, 255, 0))
    y = y + 25
    Graphics.debugPrint(20, y, "MP3: ID3v1/ID3v2 tags (mpg123)", Color.new(255, 255, 255))
    y = y + 20
    Graphics.debugPrint(20, y, "OGG: Vorbis Comments (FFmpeg)", Color.new(255, 255, 255))
    y = y + 20
    Graphics.debugPrint(20, y, "WAV: LIST INFO chunks (native)", Color.new(255, 255, 255))
    y = y + 20
    Graphics.debugPrint(20, y, "MIDI: FM Synthesis (EasyRPG)", Color.new(255, 255, 255))
    y = y + 20
    Graphics.debugPrint(20, y, "Also supports: FLAC, MP4, M4A", Color.new(200, 200, 200))
    
    -- Handle input
    local pad = Controls.read()
    
    -- Edge detection using previous frame input
    
    if Controls.check(pad, SDLK_1) and not Controls.check(prev_pad, SDLK_1) then
        playSound(mp3_sound, "MP3", true)  -- Play MP3 with looping
    elseif Controls.check(pad, SDLK_2) and not Controls.check(prev_pad, SDLK_2) then
        playSound(ogg_sound, "OGG", false)  -- Play OGG without looping
    elseif Controls.check(pad, SDLK_3) and not Controls.check(prev_pad, SDLK_3) then
        playSound(wav_sound, "WAV", true)  -- Play WAV with looping
    elseif Controls.check(pad, SDLK_4) and not Controls.check(prev_pad, SDLK_4) then
        playSound(midi_sound, "MIDI", true)  -- Play MIDI with looping
    elseif Controls.check(pad, SDLK_M) and not Controls.check(prev_pad, SDLK_M) then
        show_metadata = not show_metadata
        print("Metadata view: " .. (show_metadata and "ON" or "OFF"))
    elseif Controls.check(pad, SDLK_S) and not Controls.check(prev_pad, SDLK_S) then
        stopAllAudio()
    elseif Controls.check(pad, SDLK_ESCAPE) and not Controls.check(prev_pad, SDLK_ESCAPE) then
        running = false
    end
    
    -- Update display
    Graphics.termBlend()
    Screen.flip()
    System.wait(16)  -- ~60 FPS
    
    -- Store current frame as previous for next iteration (at end of loop like Vita Tetris)
    prev_pad = pad
end

-- Cleanup
stopAllAudio()

if mp3_sound then Sound.close(mp3_sound) end
if ogg_sound then Sound.close(ogg_sound) end
if wav_sound then Sound.close(wav_sound) end
if midi_sound then Sound.close(midi_sound) end

Sound.term()
Graphics.termBlend()