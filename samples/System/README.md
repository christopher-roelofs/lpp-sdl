# System Module Test Sample

This sample demonstrates and tests all available System module functionality in lpp-sdl.

## Features Tested

### **File Operations**
- ✅ `System.doesFileExist()` - Check file existence
- ✅ `System.doesDirExist()` - Check directory existence
- ✅ `System.openFile()` - Open files with different modes
- ✅ `System.readFile()` - Read file content
- ✅ `System.writeFile()` - Write data to files
- ✅ `System.closeFile()` - Close file handles
- ✅ `System.sizeFile()` - Get file size
- ✅ `System.seekFile()` - Seek in files
- ✅ `System.deleteFile()` - Delete files

### **Advanced File Operations** (Recently Added)
- ✅ `System.statFile()` - Get file metadata and statistics
- ✅ `System.statOpenedFile()` - Get statistics for open file handles
- ✅ `System.copyFile()` - Copy files between locations
- ✅ `System.rename()` - Rename/move files and directories
- ✅ `System.deleteDirectory()` - Remove directories recursively
- ✅ `System.getFreeSpace()` - Get available storage space
- ✅ `System.getTotalSpace()` - Get total storage capacity

### **Directory Operations**
- ✅ `System.createDirectory()` - Create directories
- ✅ `System.listDirectory()` - List directory contents with metadata

### **File Handle Methods**
- ✅ `filehandle:size()` - Get size via handle method
- ✅ `filehandle:seek()` - Seek via handle method
- ✅ `filehandle:read()` - Read via handle method
- ✅ `filehandle:write()` - Write via handle method
- ✅ `filehandle:stat()` - Get statistics via handle method

### **System Information**
- ✅ `System.getTime()` - Get current time (hour, minute, second)
- ✅ `System.shouldExit()` - Check exit conditions

### **Battery Management**
- ✅ `System.getBatteryPercentage()` - Get battery level
- ✅ `System.isBatteryCharging()` - Check charging status
- ✅ `System.getBatteryInfo()` - Get detailed battery information

### **Power Management**
- ✅ `System.setCpuSpeed()` - Set CPU frequency (stub)
- ✅ `System.setGpuSpeed()` - Set GPU frequency (stub)
- ✅ `System.setBusSpeed()` - Set bus frequency (stub)

### **Utility Functions**
- ✅ `System.wait()` - Sleep/delay function
- ✅ `System.exit()` - Exit application

## Usage

```bash
./lpp_sdl samples/System/
```

## What the Test Does

1. **File Operations Test**: Creates, writes, reads, and manipulates test files
2. **Directory Operations Test**: Creates directories and lists contents
3. **Advanced File Operations**: Tests new file stat, copy, rename functions
4. **Storage Information**: Displays free and total disk space
5. **System Information**: Shows current time and system status
6. **Battery Information**: Displays battery status and charging state
7. **File Handle Methods**: Tests object-oriented file operations
8. **Power Management**: Tests hardware control stubs
9. **Cleanup**: Removes all test files and directories
10. **Summary**: Shows test results with pass/fail counts

## Expected Output

The test will display:
- ✅ **PASS/FAIL** status for each function
- **File statistics** (size, timestamps, permissions)
- **Directory contents** with file types and sizes
- **Storage space** information in GB
- **Current time** in HH:MM:SS format
- **Battery information** (percentage, charging status, power state)
- **Test summary** with success rate percentage

## File Constants

The test uses standard file mode constants:
- `FREAD` (0) - Read only
- `FWRITE` (1) - Write only  
- `FCREATE` (2) - Create/write
- `FRDWR` (3) - Read/write

## Seek Constants

For file seeking operations:
- `SET` (0) - Seek from beginning
- `CUR` (1) - Seek from current position
- `END` (2) - Seek from end

## Controls

- **START** or **CROSS** button to exit
- **ESC** key (desktop) to exit

## Compatibility

This sample tests both:
- **Vita path translation** (app0:/, ux0:/ paths)
- **Cross-platform functionality** (Linux, macOS, Windows)

All file operations properly handle Vita-style paths and translate them to appropriate local filesystem paths.