# LPP Function Comparison: Vita vs. 3DS

This document lists the functions exposed to Lua in lpp-vita and lpp-3ds to help identify what is implemented or missing in lpp-sdl.

## lpp-vita

### Camera (`luaCamera.cpp`)
- `init`
- `getOutput`
- `setBrightness`
- `setSaturation`
- `setSharpness`
- `setContrast`
- `setReverse`
- `setEffect`
- `setExposure`
- `setZoom`
- `setAntiFlicker`
- `setISO`
- `setGain`
- `setWhiteBalance`
- `setBacklight`
- `setNightmode`
- `getBrightness`
- `getSaturation`
- `getSharpness`
- `getContrast`
- `getReverse`
- `getEffect`
- `getExposure`
- `getZoom`
- `getAntiFlicker`
- `getISO`
- `getGain`
- `getWhiteBalance`
- `getBacklight`
- `getNightmode`
- `term`

### Controls (`luaControls.cpp`)
- `read`
- `readLeftAnalog`
- `readRightAnalog`
- `rumble`
- `setLightbar`
- `check`
- `readTouch`
- `readRetroTouch`
- `lockHomeButton`
- `unlockHomeButton`
- `getDeviceInfo`
- `headsetStatus`
- `readAccel`
- `readGyro`
- `enableGyro`
- `enableAccel`
- `disableGyro`
- `disableAccel`
- `getEnterButton`

### Database (`luaDatabase.cpp`)
- `open`
- `close`
- `execQuery`

### Graphics (`luaGraphics.cpp`)
- `createImage`
- `debugPrint`
- `drawImage`
- `drawImageExtended`
- `drawLine`
- `drawPartialImage`
- `drawPixel`
- `drawRotateImage`
- `drawScaleImage`
- `fillCircle`
- `fillEmptyRect`
- `fillRect`
- `freeImage`
- `getImageFramesNum`
- `getImageHeight`
- `getImageWidth`
- `getPixel`
- `initBlend`
- `initRescaler`
- `loadAnimatedImage`
- `loadImage`
- `loadImageAsync`
- `overloadImage`
- `saveImage`
- `setImageFilters`
- `setImageFrame`
- `termBlend`
- `termRescaler`

### Font (`luaGraphics.cpp`)
- `getTextHeight`
- `getTextWidth`
- `load`
- `print`
- `setPixelSizes`
- `unload`

### Gui (`luaGui.cpp`)
- `init`
- `initBlend`
- `termBlend`
- `setTheme`
- `initMainMenubar`
- `termMainMenubar`
- `initMenu`
- `termMenu`
- `drawText`
- `drawDisabledText`
- `drawWrappedText`
- `drawButton`
- `drawSmallButton`
- `drawCheckbox`
- `drawRadioButton`
- `resetLine`
- `initWindow`
- `termWindow`
- `setWindowPos`
- `setWindowSize`
- `drawSeparator`
- `drawSlider`
- `drawIntSlider`
- `drawMenuItem`
- `drawTooltip`
- `setInputMode`
- `drawComboBox`
- `setWidgetPos`
- `getTextSize`
- `drawProgressbar`
- `drawColorPicker`
- `setWidgetWidth`
- `resetWidgetWidth`
- `drawListBox`
- `drawImage`

### Keyboard (`luaKeyboard.cpp`)
- `start`
- `getState`
- `getInput`
- `clear`

### Mic (`luaMic.cpp`)
- `start`
- `isRecording`
- `stop`
- `pause`
- `resume`

### Network (`luaNetwork.cpp`)
- `init`
- `term`
- `initFTP`
- `termFTP`
- `getIPAddress`
- `getMacAddress`
- `isWifiEnabled`
- `getWifiLevel`
- `downloadFile`
- `downloadFileAsync`
- `requestString`
- `requestStringAsync`

### Socket (`luaNetwork.cpp`)
- `createServerSocket`
- `send`
- `receive`
- `accept`
- `close`
- `connect`

### Registry (`luaRegistry.cpp`)
- `getKey`
- `setKey`
- `getSysKey`

### Render (`luaRender.cpp`)
- `createVertex`
- `destroyVertex`
- `loadModel`
- `loadObject`
- `unloadModel`
- `drawModel`
- `useTexture`
- `setCamera`

### Color (`luaScreen.cpp`)
- `new`
- `getR`
- `getG`
- `getB`
- `getA`

### Screen (`luaScreen.cpp`)
- `clear`
- `flip`
- `getPixel`
- `waitVblankStart`

### Sound (`luaSound.cpp`)
- `init`
- `term`
- `open`
- `play`
- `playShutter`
- `setVolume`
- `getVolume`
- `getTitle`
- `getAuthor`
- `pause`
- `resume`
- `isPlaying`
- `close`

### System (`luaSystem.cpp`)
- `openFile`
- `readFile`
- `writeFile`
- `closeFile`
- `seekFile`
- `sizeFile`
- `statFile`
- `statOpenedFile`
- `doesFileExist`
- `doesDirExist`
- `exit`
- `rename`
- `copyFile`
- `deleteFile`
- `deleteDirectory`
- `createDirectory`
- `listDirectory`
- `wait`
- `isBatteryCharging`
- `getBatteryPercentage`
- `getBatteryLife`
- `getBatteryCapacity`
- `getBatteryFullCapacity`
- `getBatteryTemp`
- `getBatteryVolt`
- `getBatteryHealth`
- `getBatteryCycles`
- `disableTimer`
- `enableTimer`
- `resetTimer`
- `setCpuSpeed`
- `getCpuSpeed`
- `setBusSpeed`
- `getBusSpeed`
- `setGpuSpeed`
- `getGpuSpeed`
- `setGpuXbarSpeed`
- `getGpuXbarSpeed`
- `launchEboot`
- `launchApp`
- `getTime`
- `getDate`
- `getUsername`
- `getLanguage`
- `getModel`
- `getTitle`
- `getTitleID`
- `extractSfo`
- `extractPbp`
- `extractZip`
- `compressZip`
- `addToZip`
- `extractZipAsync`
- `extractFromZip`
- `extractFromZipAsync`
- `takeScreenshot`
- `executeUri`
- `reboot`
- `shutdown`
- `standby`
- `isSafeMode`
- `setMessage`
- `getMessageState`
- `setMessageProgress`
- `setMessageProgMsg`
- `closeMessage`
- `getAsyncState`
- `getAsyncResult`
- `getPsId`
- `getFreeSpace`
- `getTotalSpace`
- `getFirmware`
- `getSpoofedFirmware`
- `getFactoryFirmware`
- `unmountPartition`
- `mountPartition`
- `installApp`
- `uninstallApp`
- `doesAppExist`
- `getBootParams`
- `loadUserPlugin`
- `loadKernelPlugin`
- `unloadUserPlugin`
- `unloadKernelPlugin`
- `unmountMountpoint`
- `consolePrint`

### Timer (`luaTimer.cpp`)
- `new`
- `getTime`
- `setTime`
- `destroy`
- `pause`
- `resume`
- `reset`
- `isPlaying`

## lpp-3ds

### Camera (`luaCamera.cpp`)
- `init`
- `getOutput`
- `takePhoto`
- `takeImage`
- `term`

### Controls (`luaControls.cpp`)
- `read`
- `check`
- `enableGyro`
- `enableAccel`
- `disableGyro`
- `disableAccel`
- `readCirclePad`
- `readTouch`
- `readGyro`
- `readAccel`
- `readCstickPad`
- `getVolume`
- `headsetStatus`
- `shellStatus`
- `enableScreen`
- `disableScreen`

### Core (`luaCore.cpp`)
- `checkService`
- `execCall`
- `getHandle`
- `getRawData`
- `readWord`
- `storeWord`
- `free`
- `alloc`
- `linearFree`
- `linearAlloc`

### Graphics (`luaGraphics.cpp`)
- `init`
- `term`
- `initBlend`
- `loadImage`
- `drawImage`
- `drawPartialImage`
- `drawRotateImage`
- `drawScaleImage`
- `drawImageExtended`
- `fillRect`
- `fillEmptyRect`
- `drawCircle`
- `drawLine`
- `termBlend`
- `flip`
- `freeImage`
- `getImageWidth`
- `getImageHeight`
- `setViewport`
- `getPixel`
- `convertFrom`

### Keyboard (`luaKeyboard.cpp`)
- `setText`
- `show`
- `getState`
- `getInput`
- `clear`

### Mic (`luaMic.cpp`)

#### DSP Functions
- `start`
- `isRecording`
- `stop`
- `pause`
- `resume`

#### CSND Functions
- `start`
- `isRecording`
- `stop`
- `pause`
- `resume`

### Network (`luaNetwork.cpp`)
- `updateFTP`
- `isWifiEnabled`
- `getWifiLevel`
- `getMacAddress`
- `getIPAddress`
- `downloadFile`
- `requestString`
- `sendMail`
- `addCertificate`

### Socket (in `luaNetwork.cpp`)
- `init`
- `term`
- `createServerSocket`
- `connect`
- `receive`
- `send`
- `accept`
- `close`

### Render (`luaRender.cpp`)
- `createVertex`
- `loadModel`
- `loadObject`
- `unloadModel`
- `init`
- `drawModel`
- `initBlend`
- `useTexture`
- `useMaterial`
- `termBlend`
- `setLightColor`
- `setLightSource`
- `createColor`
- `convertColorFrom`
- `term`

### Console (in `luaScreen.cpp`)
- `new`
- `clear`
- `show`
- `append`
- `destroy`

### Color (in `luaScreen.cpp`)
- `new`
- `getR`
- `getG`
- `getB`
- `getA`
- `convertFrom`

### Screen (`luaScreen.cpp`)
- `debugPrint`
- `waitVblankStart`
- `flip`
- `refresh`
- `clear`
- `fillRect`
- `fillEmptyRect`
- `drawPixel`
- `getPixel`
- `enable3D`
- `get3DLevel`
- `disable3D`
- `loadImage`
- `drawImage`
- `freeImage`
- `flipImage`
- `createImage`
- `saveImage`
- `getImageWidth`
- `getImageHeight`
- `drawPartialImage`
- `drawLine`

### Font (in `luaScreen.cpp`)
- `load`
- `print`
- `setPixelSizes`
- `unload`
- `measureText`

### Sound (`luaSound.cpp`)

#### DSP Functions
- `openOgg`
- `openWav`
- `openAiff`
- `close`
- `play`
- `init`
- `term`
- `pause`
- `getSrate`
- `getTime`
- `getTitle`
- `getAuthor`
- `getType`
- `getTotalTime`
- `resume`
- `isPlaying`
- `updateStream`
- `saveWav`
- `getService`

#### CSND Functions
- `openMp3`
- `openOgg`
- `openWav`
- `openAiff`
- `close`
- `play`
- `init`
- `term`
- `pause`
- `getSrate`
- `getTime`
- `getTitle`
- `getAuthor`
- `getType`
- `getTotalTime`
- `resume`
- `isPlaying`
- `updateStream`
- `saveWav`
- `getService`

### System (`luaSystem.cpp`)
- `exit`
- `getFirmware`
- `getGWRomID`
- `getKernel`
- `takeScreenshot`
- `currentDirectory`
- `checkBuild`
- `renameDirectory`
- `createDirectory`
- `deleteDirectory`
- `renameFile`
- `deleteFile`
- `doesFileExist`
- `listDirectory`
- `getBatteryLife`
- `isBatteryCharging`
- `getLanguage`
- `launch3DSX`
- `launchCIA`
- `launchPayload`
- `extractSMDH`
- `scanExtdata`
- `listExtdataDir`
- `installCIA`
- `listCIA`
- `uninstallCIA`
- `extractCIA`
- `getRegion`
- `extractZIP`
- `getModel`
- `showHomeMenu`
- `checkStatus`
- `reboot`
- `launchGamecard`
- `getFreeSpace`
- `getTime`
- `getDate`
- `getUsername`
- `getBirthday`
- `addNews`
- `listNews`
- `getNews`
- `eraseNews`
- `setCpuSpeed`
- `getCpuSpeed`
- `extractFromZIP`
- `checkSDMC`
- `fork`
- `openFile`
- `getFileSize`
- `closeFile`
- `readFile`
- `writeFile`
- `dofile`

### Timer (`luaTimer.cpp`)
- `new`
- `getTime`
- `setTime`
- `destroy`
- `pause`
- `resume`
- `reset`
- `isPlaying`

