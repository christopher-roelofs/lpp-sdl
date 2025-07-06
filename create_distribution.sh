#!/bin/bash

# Script to create a minimal distribution package for lpp-sdl
# This focuses on copying only the essential non-system libraries

BINARY="lpp_sdl"
DIST_DIR="lpp-sdl-dist"

echo "Creating lpp-sdl distribution package..."
echo

# Create distribution directory structure
rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR/libs"

# Copy the binary
cp "$BINARY" "$DIST_DIR/"

# List of essential libraries that are typically not installed by default
# These are the libraries we should bundle for distribution
ESSENTIAL_LIBS=(
    # SDL2 libraries
    "libSDL2-2.0.so"
    "libSDL2_ttf-2.0.so"
    "libSDL2_image-2.0.so"
    "libSDL2_mixer-2.0.so"
    
    # LuaJIT
    "libluajit-5.1.so"
    
    # OpenCV libraries
    "libopencv_core.so"
    "libopencv_imgproc.so"
    "libopencv_videoio.so"
    "libopencv_imgcodecs.so"
    
    # FFmpeg libraries
    "libavformat.so"
    "libavcodec.so"
    "libavutil.so"
    "libswscale.so"
    "libswresample.so"
    
    # Audio codecs
    "libgsm.so"
    "libmpg123.so"
    
    # Optional but useful
    "libarchive.so"
    "libreadline.so"
    
    # Some additional codec libraries that might not be standard
    "libx264.so"
    "libx265.so"
    "libvpx.so"
    "libopus.so"
    "libvorbis.so"
    "libvorbisenc.so"
    "libvorbisfile.so"
)

# Function to find and copy a library
copy_essential_lib() {
    local lib_pattern="$1"
    local found=0
    
    # Get all library paths from ldd
    ldd "$BINARY" | grep "=>" | while read -r line; do
        local lib_path=$(echo "$line" | awk '{print $3}')
        if [[ "$(basename "$lib_path")" =~ ^${lib_pattern} ]]; then
            if [ -f "$lib_path" ]; then
                echo "  Copying: $(basename "$lib_path")"
                cp -L "$lib_path" "$DIST_DIR/libs/"
                found=1
                
                # Also copy symlinks
                local lib_dir=$(dirname "$lib_path")
                local lib_name=$(basename "$lib_path" | sed 's/\.so\.[0-9.]*$//')
                for symlink in "$lib_dir"/"$lib_name".so*; do
                    if [ -L "$symlink" ]; then
                        cp -P "$symlink" "$DIST_DIR/libs/" 2>/dev/null
                    fi
                done
            fi
        fi
    done
}

echo "Copying essential libraries..."
for lib in "${ESSENTIAL_LIBS[@]}"; do
    copy_essential_lib "$lib"
done

# Create the launcher script
cat > "$DIST_DIR/lpp-sdl" << 'EOF'
#!/bin/bash
# Launcher script for lpp-sdl with bundled libraries

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Set library path to use bundled libraries first, then system libraries
export LD_LIBRARY_PATH="$SCRIPT_DIR/libs:$LD_LIBRARY_PATH"

# Run the actual binary
exec "$SCRIPT_DIR/lpp_sdl" "$@"
EOF

chmod +x "$DIST_DIR/lpp-sdl"

# Create an installer script
cat > "$DIST_DIR/install_dependencies.sh" << 'EOF'
#!/bin/bash
# Script to install system dependencies for lpp-sdl
# Run this if you prefer to use system libraries instead of bundled ones

echo "Installing lpp-sdl system dependencies..."

if command -v apt-get &> /dev/null; then
    # Debian/Ubuntu
    sudo apt-get update
    sudo apt-get install -y \
        libsdl2-2.0-0 libsdl2-ttf-2.0-0 libsdl2-image-2.0-0 libsdl2-mixer-2.0-0 \
        libluajit-5.1-2 \
        libopencv-core4.6 libopencv-videoio4.6 libopencv-imgproc4.6 \
        libavformat60 libavcodec60 libavutil58 libswscale7 \
        libsqlite3-0 libcurl4 libgsm1 libmpg123-0 \
        libgl1 libpng16-16 zlib1g \
        libarchive13 libreadline8
elif command -v dnf &> /dev/null; then
    # Fedora
    sudo dnf install -y \
        SDL2 SDL2_ttf SDL2_image SDL2_mixer \
        luajit \
        opencv-core opencv \
        ffmpeg-libs \
        sqlite curl gsm mpg123 \
        mesa-libGL libpng zlib \
        libarchive readline
elif command -v pacman &> /dev/null; then
    # Arch Linux
    sudo pacman -S --noconfirm \
        sdl2 sdl2_ttf sdl2_image sdl2_mixer \
        luajit \
        opencv \
        ffmpeg \
        sqlite curl gsm libmpg123 \
        mesa libpng zlib \
        libarchive readline
else
    echo "Unsupported distribution. Please install the dependencies manually."
    echo "Required packages:"
    echo "  - SDL2, SDL2_ttf, SDL2_image, SDL2_mixer"
    echo "  - LuaJIT 2.1"
    echo "  - OpenCV 4"
    echo "  - FFmpeg libraries"
    echo "  - SQLite3, cURL, GSM, MPG123"
    echo "  - OpenGL, libpng, zlib"
    echo "  - libarchive, readline (optional)"
fi
EOF

chmod +x "$DIST_DIR/install_dependencies.sh"

# Create README
cat > "$DIST_DIR/README.txt" << 'EOF'
LPP-SDL Distribution Package
============================

This package contains lpp-sdl and its essential runtime dependencies.

Running lpp-sdl:
----------------
./lpp-sdl <your_script.lua>

The launcher script automatically configures the library path to use
the bundled libraries in the libs/ directory.

System Dependencies:
--------------------
If you prefer to use system libraries instead of the bundled ones,
you can run:

./install_dependencies.sh

This will install all required packages from your distribution's
package manager.

Bundled Libraries:
------------------
This package includes essential libraries that may not be present
on all systems:
- SDL2 libraries (core, ttf, image, mixer)
- LuaJIT 2.1
- OpenCV 4 core libraries
- FFmpeg libraries
- Various audio/video codecs

System libraries (libc, libm, libGL, etc.) are not bundled and
will use the system versions.

Troubleshooting:
----------------
If you encounter missing library errors:
1. Run ./install_dependencies.sh to install system packages
2. Check that your system has basic libraries (glibc, OpenGL)
3. Use 'ldd lpp_sdl' to check for missing dependencies

For more information, visit the lpp-sdl project page.
EOF

# Count libraries
lib_count=$(ls -1 "$DIST_DIR/libs/" 2>/dev/null | wc -l)

echo
echo "Distribution package created in: $DIST_DIR/"
echo "Contents:"
echo "  - lpp-sdl (launcher script)"
echo "  - lpp_sdl (binary)"
echo "  - libs/ ($lib_count essential libraries)"
echo "  - install_dependencies.sh"
echo "  - README.txt"
echo
echo "Package size: $(du -sh "$DIST_DIR" | cut -f1)"
echo
echo "To create a tarball for distribution:"
echo "  tar -czf lpp-sdl-dist.tar.gz $DIST_DIR/"