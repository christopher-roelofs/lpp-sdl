# Console/Headless Mode Samples

This directory contains sample scripts that demonstrate LPP-SDL's headless mode functionality. These scripts run completely without a GUI window, making them perfect for:

- **Server environments** - Run on headless servers without display
- **Automation scripts** - Integrate into automated workflows
- **Command-line tools** - Create CLI utilities with Lua
- **Data processing** - Process files and data without graphics
- **Testing environments** - Run tests in CI/CD pipelines

## How to Run Console Mode

Use either the `-headless` or `-console` flag:

```bash
# Run a specific script
./lpp_sdl -headless samples/sdl/Console/index.lua
./lpp_sdl -console samples/sdl/Console/index.lua

# Launch interactive console REPL (no script specified)
./lpp_sdl -headless
./lpp_sdl -console
```

## Interactive Console REPL

When no Lua file is specified in console mode, an interactive REPL (Read-Eval-Print Loop) is launched, providing a command-line interface for exploring and running scripts:

```bash
$ ./lpp_sdl -headless

=== LPP-SDL Console REPL ===
Type 'help' for available commands.

lpp-sdl> help
Available commands:
  help                 - Show this help message
  list, ls, dir        - List files and directories in current directory
  cd <directory>       - Change to directory (use .. for parent)
  run, load <file.lua> - Run a Lua script
  cat <file>           - Display file contents
  pwd                  - Show current directory
  info                 - Show system information
  clear                - Clear the screen
  lua <code>           - Execute Lua code directly
  exit                 - Exit the REPL
  quit                 - Exit the REPL

Examples:
  run samples/sdl/Console/index.lua
  cat samples/sdl/Console/README.md
  cd samples/sdl/Console
  dir
  info
  clear
  lua print('Hello from Lua!')
  lua local name = System.input('Name: '); print('Hi ' .. name)
  lua for i=1,3 do print('Line ' .. i) end

lpp-sdl> cd samples/sdl/Console
Changed to directory: ./samples/sdl/Console

lpp-sdl> list
Current directory: ./samples/sdl/Console

Contents:
   [DIR]  ..
   [FILE] README.md (5401 bytes)
   [FILE] data_converter.lua (10518 bytes)
   [FILE] file_processor.lua (6004 bytes)
   [FILE] index.lua (4356 bytes)
   [FILE] run_demos.lua (2760 bytes)

lpp-sdl> run index.lua
Running: ./samples/sdl/Console/index.lua
[Script executes...]

lpp-sdl> exit
Exiting console REPL...
```

### REPL Features
- **File navigation**: `cd`, `pwd`, `list` (aliases: `ls`, `dir`) commands for exploring directories
- **File viewing**: `cat <file>` command to display file contents with line numbers
- **Script execution**: `run` (alias: `load`) command to execute Lua scripts from any location
- **Direct Lua execution**: `lua <code>` command to execute Lua code directly in the REPL
- **System information**: `info` command shows platform details and available features
- **Screen management**: `clear` command to clear the console screen
- **Command aliases**: Familiar shell aliases (`ls`/`dir` for `list`, `load` for `run`)
- **Help system**: Built-in `help` command with examples and command reference
- **Tab completion**: Commands and paths with readline support
- **Command history**: Persistent history with up/down arrow navigation

## Sample Scripts

### 1. **index.lua** - Basic Console Demo
```bash
./lpp_sdl -headless samples/sdl/Console/index.lua
```

A comprehensive demonstration of console mode features:
- System information gathering
- File operations (create, read, write, delete)
- Directory listing with metadata
- Path compatibility testing
- Timer operations
- Log file generation

**Use Cases:**
- Learning console mode basics
- System diagnostics
- Quick file system tests

### 2. **file_processor.lua** - File Analysis Utility
```bash
./lpp_sdl -headless samples/sdl/Console/file_processor.lua
```

A practical file processing utility that:
- Scans directories and analyzes files
- Generates detailed reports with statistics
- Tracks file sizes, types, and modification dates
- Creates formatted output reports
- Demonstrates real-world automation

**Generated Output:**
- `file_report.txt` - Detailed analysis report

**Use Cases:**
- File system auditing
- Directory analysis
- Automated reporting
- File management scripts

### 3. **data_converter.lua** - Multi-Format Data Converter
```bash
./lpp_sdl -headless samples/sdl/Console/data_converter.lua
```

Advanced data processing demonstration:
- Converts between CSV, JSON, and XML formats
- Parses and validates data structures
- Generates statistical summaries
- Creates multiple output formats
- Shows complex data transformation

**Generated Output:**
- `players.csv` - Source CSV data
- `players.json` - JSON formatted data
- `players.xml` - XML formatted data  
- `summary.txt` - Statistical analysis report

**Use Cases:**
- Data migration scripts
- Format conversion utilities
- ETL (Extract, Transform, Load) processes
- Data analysis pipelines

### 4. **input_demo.lua** - Interactive Input Demonstration
```bash
./lpp_sdl -headless samples/sdl/Console/input_demo.lua
```

A comprehensive demonstration of user input capabilities:
- Python-style `System.input()` function with prompts
- Input validation and error handling
- Menu systems and user interaction
- Multi-line input collection
- Interactive applications (calculator)
- Integration with readline for enhanced editing

**Features Demonstrated:**
- Basic input: `local name = System.input("Name: ")`
- Input validation loops
- Menu-driven interfaces
- File operations based on user input
- Real-time interactive applications

**Use Cases:**
- Interactive configuration scripts
- Data collection utilities
- Menu-driven automation tools
- User-friendly command-line applications

### 5. **lua_repl_demo.lua** - Direct Lua Execution Demo
```bash
./lpp_sdl -headless samples/sdl/Console/lua_repl_demo.lua
```

Demonstrates the powerful `lua` command for executing Lua code directly in the REPL:
- Direct access to all System.* functions from the command line
- Interactive programming and testing
- Quick calculations and data processing
- File operations and system calls
- Integration with readline for enhanced editing

**Example Usage:**
```bash
lpp-sdl> lua print('Hello from Lua!')
lpp-sdl> lua local name = System.input('Name: '); print('Hi ' .. name)
lpp-sdl> lua for i=1,5 do print('Count:', i) end
lpp-sdl> lua local files = System.listDirectory('.'); print('Files:', #files)
```

**Use Cases:**
- Testing Lua code snippets before scripting
- Quick file system operations
- Interactive data processing
- Real-time calculations and utilities
- Debugging and development workflow

## Features Demonstrated

### ✅ File System Operations
- File creation, reading, writing, deletion
- Directory listing with metadata (size, type, modification time)
- Path existence checking
- Cross-platform path handling

### ✅ Data Processing
- CSV parsing and generation
- JSON formatting and output
- XML document creation
- Statistical analysis and reporting

### ✅ System Integration
- Working directory management
- Platform-compatible file operations
- Error handling and validation
- Clean resource management

### ✅ User Interaction
- Python-style input with `System.input(prompt)`
- Enhanced line editing with readline support
- Input validation and error handling
- Interactive menu systems and workflows

### ✅ Automation-Friendly
- Command-line execution
- No GUI dependencies
- Scriptable workflows
- Batch processing capabilities

## Console Mode vs GUI Mode

| Feature | Console Mode | GUI Mode |
|---------|-------------|----------|
| Window Creation | ❌ No | ✅ Yes |
| SDL Video | ❌ Disabled | ✅ Enabled |
| Graphics Functions | ❌ Not available | ✅ Full support |
| File Operations | ✅ Full support | ✅ Full support |
| System Functions | ✅ Full support | ✅ Full support |
| Timer Operations | ✅ Full support | ✅ Full support |
| Network Functions | ✅ Full support | ✅ Full support |
| Memory Usage | ✅ Lower | ❌ Higher |
| Server Compatible | ✅ Yes | ❌ No |

## Practical Applications

### 🖥️ Server Automation
```bash
# Run data processing on a headless server
./lpp_sdl -headless samples/sdl/Console/data_converter.lua
```

### 📊 Automated Reporting
```bash
# Generate file system reports
./lpp_sdl -console samples/sdl/Console/file_processor.lua
```

### 🔄 Data Migration
```bash
# Convert data formats in batch
for file in *.csv; do
    ./lpp_sdl -headless convert_data.lua "$file"
done
```

### 🧪 CI/CD Testing
```yaml
# Example GitHub Actions step
- name: Run LPP-SDL Tests
  run: ./lpp_sdl -headless test_suite.lua
```

## Error Handling

Console mode includes proper error handling:
- Graceful SDL cleanup without graphics
- File operation error checking
- Resource management
- Exit status codes

## Performance Benefits

Running in console mode provides:
- **Faster startup** - No graphics initialization
- **Lower memory usage** - No graphics buffers
- **Better resource efficiency** - No GPU usage
- **Server compatibility** - No display requirements

## Tips for Console Scripts

1. **Always call `System.exit()`** to ensure clean shutdown
2. **Check file operations** for errors and handle gracefully
3. **Use descriptive output** since there's no visual feedback
4. **Validate inputs** early in the script
5. **Clean up temporary files** before exiting

## Getting Started

1. Copy one of the sample scripts as a template
2. Modify for your specific use case
3. Test with the `-headless` flag
4. Deploy to your automation environment

These samples demonstrate the power of LPP-SDL for server-side scripting and automation tasks, showing how Lua can be used for serious system administration and data processing work without requiring a GUI.