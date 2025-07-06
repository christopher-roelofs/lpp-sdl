#!/bin/bash

# Script to collect all shared library dependencies for lpp-sdl
# This will copy all required .so files to a libs directory for distribution

# Set the binary name
BINARY="lpp_sdl"

# Create libs directory if it doesn't exist
mkdir -p libs

# Function to copy a library and its symlinks
copy_lib() {
    local lib_path="$1"
    local lib_name=$(basename "$lib_path")
    
    # Skip if already copied
    if [ -f "libs/$lib_name" ]; then
        return
    fi
    
    # Copy the actual library file
    if [ -f "$lib_path" ]; then
        echo "Copying $lib_path"
        cp -L "$lib_path" "libs/"
        
        # Also copy any symlinks in the same directory
        local lib_dir=$(dirname "$lib_path")
        local lib_base=$(echo "$lib_name" | sed 's/\.so\.[0-9.]*$//')
        
        # Find and copy related symlinks
        for symlink in "$lib_dir"/"$lib_base".so*; do
            if [ -L "$symlink" ] && [ ! -f "libs/$(basename "$symlink")" ]; then
                echo "  Copying symlink $(basename "$symlink")"
                cp -P "$symlink" "libs/"
            fi
        done
    else
        echo "Warning: $lib_path not found"
    fi
}

# Get all dependencies using ldd
echo "Collecting dependencies for $BINARY..."
echo

# Parse ldd output and copy each dependency
ldd "$BINARY" | grep "=>" | awk '{print $3}' | while read -r lib; do
    if [ -n "$lib" ] && [ "$lib" != "not" ]; then
        copy_lib "$lib"
    fi
done

# Also handle libraries without => (like linux-vdso.so.1)
ldd "$BINARY" | grep -v "=>" | awk '{print $1}' | while read -r lib; do
    if [[ "$lib" == /* ]] && [ -f "$lib" ]; then
        copy_lib "$lib"
    fi
done

echo
echo "Dependencies collected in ./libs/"
echo "Total files: $(ls -1 libs/ | wc -l)"
echo

# Create a summary file
echo "Creating dependency summary..."
{
    echo "LPP-SDL Runtime Dependencies"
    echo "==========================="
    echo
    echo "Generated on: $(date)"
    echo "System: $(uname -a)"
    echo
    echo "Direct dependencies from Makefile:"
    echo "- SDL2 and extensions (SDL2, SDL2_ttf, SDL2_image, SDL2_mixer)"
    echo "- LuaJIT 2.1"
    echo "- OpenCV 4"
    echo "- FFmpeg libraries (libavformat, libavcodec, libavutil, libswscale)"
    echo "- SQLite3"
    echo "- cURL"
    echo "- libgsm"
    echo "- libmpg123"
    echo "- zlib"
    echo "- libpng"
    echo "- OpenGL"
    echo "- libarchive (if enabled)"
    echo "- readline (if enabled)"
    echo
    echo "All collected .so files:"
    echo "------------------------"
    ls -1 libs/ | sort
} > libs/DEPENDENCIES.txt

echo "Summary written to libs/DEPENDENCIES.txt"

# Create a run script for the distributed version
cat > run_lpp_sdl.sh << 'EOF'
#!/bin/bash
# Run script for distributed lpp-sdl
# This sets up the library path to use bundled libraries

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LD_LIBRARY_PATH="$SCRIPT_DIR/libs:$LD_LIBRARY_PATH"

"$SCRIPT_DIR/lpp_sdl" "$@"
EOF

chmod +x run_lpp_sdl.sh

echo
echo "Created run_lpp_sdl.sh launcher script"
echo
echo "To distribute lpp-sdl, include:"
echo "  - lpp_sdl (the binary)"
echo "  - libs/ (directory with all .so files)"
echo "  - run_lpp_sdl.sh (launcher script)"