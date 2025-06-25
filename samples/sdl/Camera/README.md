# LPP-Vita SDL Camera Support

The LPP-Vita SDL port now includes full camera support using OpenCV for cross-platform camera access.

## Features

### Camera Initialization
- Multiple camera devices (front/back camera support)
- Various resolutions (VGA, QVGA, QQVGA, CIF, QCIF, PSP, NGP)
- Configurable frame rates
- Automatic fallback to available cameras

### Real-time Effects
- **Normal** - No effect applied
- **Negative** - Inverts colors
- **Black & White** - Grayscale conversion
- **Sepia** - Vintage sepia tone
- **Color Tints** - Blue, Red, or Green color filters

### Camera Controls
- **Brightness** adjustment (0-255)
- **Contrast** adjustment (0-255) 
- **Saturation** adjustment (0.0-10.0)
- **Exposure** control
- **Zoom** functionality
- **Mirror/Flip** effects (horizontal, vertical, both)

### Live Preview
- Real-time camera feed as SDL textures
- Compatible with Graphics.drawImage() for display
- Automatic frame capture and processing

## API Reference

### Camera Module Functions

#### Initialization
```lua
Camera.init(device, resolution, framerate)
```
- `device` - Camera device (OUTER_CAM or INNER_CAM)
- `resolution` - Resolution constant (VGA_RES, QVGA_RES, etc.)
- `framerate` - Target framerate (3, 5, 7, 10, 15, 20, 30, 60, 120)

#### Frame Capture
```lua
local texture = Camera.getOutput()
```
Returns an SDL texture that can be used with Graphics.drawImage()

#### Device Management
```lua
Camera.switchDevice(device)      -- Switch camera device (preserves settings)
```

#### Camera Settings
```lua
Camera.setBrightness(value)      -- 0-255
Camera.setContrast(value)        -- 0-255
Camera.setSaturation(value)      -- 0.0-10.0
Camera.setEffect(effect)         -- EFFECT_* constants
Camera.setReverse(mode)          -- REVERSE_* constants
Camera.setExposure(value)        -- Camera exposure
Camera.setZoom(level)            -- Zoom level
```

#### Get Settings
```lua
local brightness = Camera.getBrightness()
local contrast = Camera.getContrast()
local saturation = Camera.getSaturation()
local effect = Camera.getEffect()
local reverse = Camera.getReverse()
```

#### Cleanup
```lua
Camera.term()
```

### Constants

#### Camera Devices
- `OUTER_CAM` - Back/main camera (value: 1)
- `INNER_CAM` - Front camera (value: 0)

#### Resolutions
- `VGA_RES` - 640x480 (value: 0)
- `QVGA_RES` - 320x240 (value: 1)
- `QQVGA_RES` - 160x120 (value: 2)
- `CIF_RES` - 352x288 (value: 3)
- `QCIF_RES` - 176x144 (value: 4)
- `PSP_RES` - 480x272 (value: 5)
- `NGP_RES` - 640x360 (value: 6)

#### Effects
- `EFFECT_NONE` - No effect (value: 0)
- `EFFECT_NEGATIVE` - Color inversion (value: 1)
- `EFFECT_BLACKWHITE` - Grayscale (value: 2)
- `EFFECT_SEPIA` - Sepia tone (value: 3)
- `EFFECT_BLUE` - Blue tint (value: 4)
- `EFFECT_RED` - Red tint (value: 5)
- `EFFECT_GREEN` - Green tint (value: 6)

#### Reverse/Mirror
- `REVERSE_OFF` - No mirroring (value: 0)
- `REVERSE_MIRROR` - Horizontal flip (value: 1)
- `REVERSE_FLIP` - Vertical flip (value: 2)
- `REVERSE_BOTH` - Both horizontal and vertical flip (value: 3)

## Usage Examples

### Basic Camera Usage
```lua
-- Initialize camera
Camera.init(OUTER_CAM, VGA_RES, 30)

-- Main loop
while true do
    -- Get camera frame
    local texture = Camera.getOutput()
    
    if texture then
        -- Clear screen and draw camera feed
        Screen.clear(Color.new(0, 0, 0))
        Graphics.drawImage(0, 0, texture)
        Screen.flip()
    end
    
    -- Handle input for exit
    local pad = Controls.read()
    if Controls.check(pad, SCE_CTRL_CIRCLE) then
        break
    end
end

-- Cleanup
Camera.term()
```

### Camera with Effects
```lua
-- Initialize camera
Camera.init(OUTER_CAM, VGA_RES, 30)

-- Apply sepia effect
Camera.setEffect(EFFECT_SEPIA)

-- Adjust brightness
Camera.setBrightness(180)

-- Mirror horizontally (selfie mode)
Camera.setReverse(REVERSE_MIRROR)

-- Get frame with effects applied
local texture = Camera.getOutput()

-- Draw to screen
Graphics.drawImage(100, 100, texture)

-- Cleanup
Camera.term()
```

### Device Switching
```lua
-- Initialize with back camera
Camera.init(OUTER_CAM, VGA_RES, 30)
Camera.setBrightness(200)
Camera.setEffect(EFFECT_SEPIA)

-- Switch to front camera (settings preserved)
Camera.switchDevice(INNER_CAM)

-- Settings are maintained: brightness=200, effect=sepia
local texture = Camera.getOutput()
Graphics.drawImage(0, 0, texture)

-- Switch back to back camera
Camera.switchDevice(OUTER_CAM)

Camera.term()
```

### Multiple Resolution Support
```lua
local resolutions = {
    {name = "VGA", value = VGA_RES, width = 640, height = 480},
    {name = "QVGA", value = QVGA_RES, width = 320, height = 240},
    {name = "QQVGA", value = QQVGA_RES, width = 160, height = 120}
}

for i, res in ipairs(resolutions) do
    print("Testing " .. res.name .. " (" .. res.width .. "x" .. res.height .. ")")
    
    Camera.init(OUTER_CAM, res.value, 30)
    local texture = Camera.getOutput()
    
    if texture then
        print("✓ " .. res.name .. " working")
    else
        print("✗ " .. res.name .. " failed")
    end
    
    Camera.term()
end
```

## System Requirements

### Dependencies
- **OpenCV 4.x** - For camera access and image processing
- **SDL2** - For texture creation and display
- **Compatible camera device** - Webcam, built-in camera, etc.

### Platform Support
- **Linux** - V4L2 cameras, USB webcams
- **macOS** - Built-in cameras, USB webcams
- **Windows** - DirectShow cameras, USB webcams

### Performance Notes
- **VGA (640x480)** - Best quality, moderate performance impact
- **QVGA (320x240)** - Good balance of quality and performance
- **QQVGA (160x120)** - Fastest performance, lower quality
- Effects are applied in real-time using OpenCV image processing

## Error Handling

### Common Issues
1. **"Failed to initialize camera"** - No camera available or permission denied
2. **"Camera has not been initialized"** - Call Camera.init() first
3. **"Cannot start two camera instances"** - Call Camera.term() before reinitializing

### Troubleshooting
- Ensure camera is not being used by another application
- Check camera permissions on your system
- Try different camera devices (OUTER_CAM vs INNER_CAM)
- Verify OpenCV installation and camera support

## Examples

The following example files demonstrate camera functionality:
- `simple_camera_test.lua` - Basic camera initialization test
- `camera_example.lua` - Interactive camera demo with effects (when Graphics.print is available)

Run examples with:
```bash
./lpp_sdl samples/simple_camera_test.lua
```