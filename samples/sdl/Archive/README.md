# Archive/Zip Testing Suite for LPP-SDL

This folder contains comprehensive testing tools for zip/archive operations in LPP-SDL, featuring both console and UI-based testing approaches.

## Available Tests

### 1. `zip_test_console.lua` ⭐ **RECOMMENDED FOR VERIFICATION**
**Pure Console Test - No UI Dependencies**

- Comprehensive automated test of all 8 zip functions
- No graphics or UI components - pure functional testing
- Reliable for verifying core zip functionality
- Detailed test results with pass/fail status
- Performance timing for each operation

**Test Coverage:**
- ✅ Test environment setup
- ✅ Single file compression  
- ✅ Directory compression
- ✅ Full archive extraction
- ✅ Specific file extraction
- ✅ Add files to existing archives
- ✅ Async zip operations
- ✅ Async specific file extraction

### 2. `zip_test_ui.lua`
**Interactive UI Test - Non-Blocking Interface**

- User-friendly graphical interface for zip operations
- Timer-based operation scheduling to prevent UI blocking
- Real-time status updates and operation results
- Manual control over test sequence
- Visual feedback with color-coded results

**Features:**
- 🎮 Navigate with UP/DOWN arrows, SPACE to execute
- 📊 Real-time operation status and timing
- 🚫 Non-blocking UI - interface remains responsive
- 📝 Detailed logging for debugging
- 🧹 Automatic cleanup functionality

## Usage Instructions

### Quick Verification Workflow:

1. **Verify core functionality** with the console test:
   ```bash
   ./lpp_sdl samples/Archive/zip_test_console.lua
   ```

2. **Interactive testing** with the UI test:
   ```bash
   ./lpp_sdl samples/Archive/zip_test_ui.lua
   ```

### Console Test Details

The console test runs automatically and provides a comprehensive report:
- Tests complete in milliseconds
- Clear PASS/FAIL indicators  
- Detailed error messages for failures
- Automatic cleanup after completion
- 100% reliable for core functionality verification

**Expected Output:**
```
=== LPP-SDL Zip Operations Console Test ===
Running: 1. Setup test environment
  ✓ PASS (0ms): Test environment setup completed successfully
Running: 2. Compress single file  
  ✓ PASS (0ms): Single file compressed successfully
[... all 8 tests ...]
🎉 ALL TESTS PASSED! Zip functionality is working correctly.
```

### UI Test Controls

**Navigation:**
- `UP/DOWN` arrows: Navigate menu options
- `SPACE` bar: Execute selected operation  
- `ESC`: Exit test

**Operation Sequence:**
1. **Create Test Files** - Sets up test environment
2. **Compress Single File** - Creates `output/single.zip`
3. **Compress Directory** - Creates `output/directory.zip`
4. **Extract Archive** - Tests full extraction
5. **Extract Specific File** - Tests selective extraction
6. **Add to Existing Zip** - Tests adding files to existing archives
7. **Test Async Operations** - Tests asynchronous functionality
8. **Clean Up Files** - Removes all test files

## Technical Implementation

### Console Test Features
- **Zero UI Dependencies**: Pure command-line operation
- **Comprehensive Coverage**: Tests all zip API functions
- **Error Isolation**: Clearly identifies which operations fail
- **Performance Metrics**: Timing data for each operation
- **Automated Execution**: No user interaction required

### UI Test Features  
- **Non-Blocking Architecture**: Timer-based operation scheduling
- **Responsive Interface**: UI updates during operations
- **Visual Feedback**: Color-coded status messages
- **Manual Control**: User-driven test execution
- **Debug Logging**: Detailed operation logs

### Zip Operations Tested
Both tests verify these core operations:
- **File Compression**: `System.compressZip()`
- **Directory Compression**: `System.compressZip()` on folders
- **Archive Extraction**: `System.extractZip()`
- **Selective Extraction**: `System.extractFromZip()`
- **Archive Modification**: `System.addToZip()`
- **Async Operations**: `System.extractZipAsync()` and `System.getAsyncState()`

## Troubleshooting

### If Tests Fail:

1. **Check Console Output**: Console test provides detailed error messages
2. **Verify Dependencies**: Ensure minizip library is properly compiled
3. **File Permissions**: Check write permissions for test directories
4. **SDL Integration**: Verify SDL file I/O is working correctly

### Common Issues:

- **Permission Errors**: Run from a directory with write access
- **Missing Files**: Some operations depend on previous test steps
- **UI Hanging**: Use console test to isolate core functionality issues

## Performance Expectations

- **Console Test**: All operations typically complete in 0-2ms
- **UI Test**: Operations complete quickly with responsive interface
- **Memory Usage**: Minimal overhead from test frameworks
- **File I/O**: Fast compression/decompression with minizip

## Development Notes

These tests serve as:
- **Regression Testing**: Verify zip functionality after code changes
- **Platform Verification**: Ensure zip operations work across different systems  
- **Performance Benchmarking**: Monitor operation timing
- **API Documentation**: Examples of proper zip function usage

The console test is ideal for automated testing and CI/CD pipelines, while the UI test provides an interactive way to manually verify functionality and user experience.