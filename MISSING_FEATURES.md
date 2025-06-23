# lpp-sdl Missing Features Comparison

Based on analysis comparing SDL port with original Vita version, the SDL port is missing **56 out of 86 functions** (65% of functionality).

**UPDATE: 7 file operation functions have been implemented! ✅**
**UPDATE: Graphics API `drawImageExtended()` texture parameter bug fixed! ✅**

## **Critical Missing Features**

### **File Operations** (0 missing) ✅
- [x] `statFile()` - File metadata/statistics
- [x] `statOpenedFile()` - Get statistics for open file handles
- [x] `copyFile()` - File copying functionality  
- [x] `rename()` - File/directory renaming
- [x] `deleteDirectory()` - Directory removal
- [x] `getFreeSpace()` - Get available storage space
- [x] `getTotalSpace()` - Get total storage capacity

### **System Information** (8 missing)
- [ ] `getDate()` - Get current date (day of week, day, month, year)
- [ ] `getUsername()` - System user nickname
- [ ] `getLanguage()` - System language setting
- [ ] `getModel()` - Hardware model information
- [ ] `getTitle()` - Get current application title
- [ ] `getTitleID()` - Get current application title ID
- [ ] `getPsId()` - Get PlayStation ID
- [ ] `getBootParams()` - Get boot parameters

### **Firmware & System State** (4 missing)
- [ ] `getFirmware()` - Get current firmware version
- [ ] `getSpoofedFirmware()` - Get spoofed firmware version
- [ ] `getFactoryFirmware()` - Get factory firmware version
- [ ] `isSafeMode()` - Check if system is in safe mode

### **Archive/Compression** (7 missing)
- [ ] `extractZip()` - Extract ZIP archives
- [ ] `extractZipAsync()` - Asynchronous ZIP extraction
- [ ] `compressZip()` - Create ZIP archives
- [ ] `addToZip()` - Add files to ZIP archives
- [ ] `extractFromZip()` - Extract specific files from ZIP
- [ ] `extractFromZipAsync()` - Async extract from ZIP
- [ ] `extractSfo()` - Extract SFO parameter files
- [ ] `extractPbp()` - Extract PBP homebrew packages

### **Advanced Battery Management** (7 missing)
- [ ] `getBatteryLife()` - Remaining battery life in minutes
- [ ] `getBatteryCapacity()` - Current battery capacity in mAh
- [ ] `getBatteryFullCapacity()` - Maximum battery capacity in mAh
- [ ] `getBatteryTemp()` - Battery temperature
- [ ] `getBatteryVolt()` - Battery voltage
- [ ] `getBatteryHealth()` - Battery health percentage
- [ ] `getBatteryCycles()` - Battery charge cycles count

### **System UI & Messaging** (6 missing)
- [ ] `setMessage()` - Display system message dialogs
- [ ] `getMessageState()` - Get message dialog state
- [ ] `setMessageProgress()` - Set progress bar in dialogs
- [ ] `setMessageProgMsg()` - Set progress message text
- [ ] `closeMessage()` - Close message dialogs
- [ ] `takeScreenshot()` - Capture screenshots to files

### **Application Management** (6 missing)
- [ ] `launchEboot()` - Launch homebrew applications
- [ ] `launchApp()` - Launch official applications
- [ ] `installApp()` - Install application packages
- [ ] `uninstallApp()` - Uninstall applications
- [ ] `doesAppExist()` - Check if application exists
- [ ] `executeUri()` - Execute system URIs

### **Power Management & Timers** (4 missing)
- [ ] `disableTimer()` - Disable auto-suspend/screen timers
- [ ] `enableTimer()` - Enable timers
- [ ] `resetTimer()` - Reset power timers
- [ ] Clock speed queries: `getCpuSpeed()`, `getBusSpeed()`, `getGpuSpeed()`, `getGpuXbarSpeed()`

### **Storage & Mounting** (4 missing)
- [ ] `mountPartition()` - Mount storage partitions
- [ ] `unmountPartition()` - Unmount partitions  
- [ ] `unmountMountpoint()` - Unmount virtual mount points

### **Plugin System** (4 missing)
- [ ] `loadUserPlugin()` - Load user-space plugins
- [ ] `loadKernelPlugin()` - Load kernel plugins
- [ ] `unloadUserPlugin()` - Unload user plugins
- [ ] `unloadKernelPlugin()` - Unload kernel plugins

### **System Control** (3 missing)
- [ ] `reboot()` - Restart the system
- [ ] `shutdown()` - Power off the system
- [ ] `standby()` - Enter standby mode

### **Async Operations** (2 missing)
- [ ] `getAsyncState()` - Check async operation status
- [ ] `getAsyncResult()` - Get async operation results

### **Debugging** (1 missing)
- [ ] `consolePrint()` - Print to debug console

## **Missing Constants**

### **Message Dialog Constants**
- [ ] `BUTTON_OK`, `BUTTON_YES_NO`, `BUTTON_NONE`, `BUTTON_OK_CANCEL`, `BUTTON_CANCEL`

### **Power Timer Constants**
- [ ] `AUTO_SUSPEND_TIMER`, `SCREEN_OFF_TIMER`, `SCREEN_DIMMING_TIMER`

### **File Access Modes**
- [ ] `READ_ONLY`, `READ_WRITE`

### **Screenshot Formats**  
- [ ] `FORMAT_BMP`, `FORMAT_PNG`, `FORMAT_JPG`

## **Other Module Gaps**

### **High Priority Missing Modules**
- [ ] **Color Module** - Dedicated color management utilities
- [ ] **Font Module** - Extended font format support (PGF/PVF/OTF)
- [ ] **GUI Module** - ImGui integration (33+ stubbed functions)
- [ ] **Keyboard Module** - On-screen keyboard implementation

### **Medium Priority Missing Modules**
- [ ] **Microphone Module** - Audio recording capabilities
- [ ] **Registry Module** - System settings/configuration storage
- [ ] **Network Module** - FTP server functionality

### **Input System Gaps**
- [ ] Touch screen simulation (mouse-to-touch mapping)
- [ ] Analog stick full simulation
- [ ] Gyroscope/accelerometer simulation
- [ ] Rumble/vibration support

### **Audio System Limitations**
- [ ] MP3 support (currently only WAV/OGG)
- [ ] MIDI support
- [ ] Opus/AIFF support
- [ ] Audio metadata extraction

### **Graphics API Gaps** (11 missing)
- [ ] `createImage()` - Create blank textures/images in memory
- [ ] `getPixel()` - Read pixel color values from images  
- [ ] `initBlend()` - Initialize rendering/blending state
- [ ] `termBlend()` - Terminate rendering state
- [ ] `loadImageAsync()` - Asynchronous image loading
- [ ] `loadAnimatedImage()` - Load animated/multi-frame images
- [ ] `getImageFramesNum()` - Get frame count for animated images
- [ ] `setImageFrame()` - Set current frame for animated images
- [ ] `setImageFilters()` - Configure texture filtering modes
- [ ] `initRescaler()` - Initialize image scaling system (partial implementation)
- [ ] `termRescaler()` - Terminate scaling system

### **Graphics Limitations**
- [ ] Animated GIF support
- [ ] Extended font formats (PGF/PVF/OTF)
- [ ] Advanced alpha blending features

## **Implementation Priority**

### **High Priority** (Essential for basic functionality)
1. ~~File operations: `statFile()`, `copyFile()`, `rename()`, `deleteDirectory()`~~ ✅ **COMPLETED**
2. Graphics functions: `createImage()`, `getPixel()`, `initBlend()`, `termBlend()`
3. Archive support: `extractZip()`, `compressZip()`
4. GUI Module implementation
5. Touch simulation system
6. System information: `getDate()`, `getTitleID()`

### **Medium Priority** (Enhanced compatibility)
1. Animated image support: `loadAnimatedImage()`, `getImageFramesNum()`, `setImageFrame()`
2. Advanced battery info functions
3. Message dialog system
4. Screenshot capture
5. Audio format extensions (MP3, MIDI)
6. Font system improvements

### **Low Priority** (Vita-specific features)
1. Application management functions
2. Plugin system
3. System control (reboot/shutdown)
4. Power management timers
5. Storage mounting

## **Impact Assessment**

**Current Status**: SDL port handles core functionality (graphics, basic audio, controls) well for games and simple applications.

**Missing Functionality Impact**:
- **System utilities** - File managers, system monitors will fail
- **Advanced homebrew** - Apps using GUI, archives, or system info will fail  
- **Power management tools** - Battery monitors, overclock utilities won't work
- **Installation utilities** - Package managers, homebrew installers won't work

**Compatibility**: Basic 2D/3D games and simple applications should work fine. Complex system utilities and advanced homebrew will require significant missing functionality.