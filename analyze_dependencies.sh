#!/bin/bash

# Script to analyze and categorize lpp-sdl dependencies

BINARY="lpp_sdl"

echo "=== LPP-SDL Dependency Analysis ==="
echo

# Function to get library info
get_lib_info() {
    local lib="$1"
    local pkg=$(dpkg -S "$lib" 2>/dev/null | cut -d: -f1 | head -1)
    if [ -z "$pkg" ]; then
        pkg="(unknown package)"
    fi
    echo "$lib|$pkg"
}

# Collect all dependencies
echo "Analyzing dependencies..."
deps=$(ldd "$BINARY" | grep "=>" | awk '{print $3}' | grep -v "not found" | sort -u)

# Categorize libraries
declare -A categories
categories["SDL"]=""
categories["Audio"]=""
categories["Video"]=""
categories["Graphics"]=""
categories["System"]=""
categories["Network"]=""
categories["Compression"]=""
categories["Database"]=""
categories["Lua"]=""
categories["OpenCV"]=""
categories["Other"]=""

# Process each dependency
while IFS= read -r lib; do
    if [ -z "$lib" ]; then continue; fi
    
    lib_name=$(basename "$lib")
    
    # Categorize based on library name
    if [[ "$lib_name" =~ SDL ]]; then
        categories["SDL"]+="$lib\n"
    elif [[ "$lib_name" =~ (alsa|pulse|jack|snd|audio|mpg123|vorbis|ogg|opus|flac|modplug|fluid|gsm) ]]; then
        categories["Audio"]+="$lib\n"
    elif [[ "$lib_name" =~ (avformat|avcodec|avutil|swscale|swresample|x264|x265|vpx|theora|xvid|aom|dav1d|rav1e) ]]; then
        categories["Video"]+="$lib\n"
    elif [[ "$lib_name" =~ (GL|gl|X11|xcb|wayland|drm|gbm|EGL|cairo|pixman|png|jpeg|tiff|webp) ]]; then
        categories["Graphics"]+="$lib\n"
    elif [[ "$lib_name" =~ (opencv) ]]; then
        categories["OpenCV"]+="$lib\n"
    elif [[ "$lib_name" =~ (luajit) ]]; then
        categories["Lua"]+="$lib\n"
    elif [[ "$lib_name" =~ (curl|ssh|ssl|crypto|nghttp|rtmp|gnutls|nettle) ]]; then
        categories["Network"]+="$lib\n"
    elif [[ "$lib_name" =~ (z\.|bz2|lzma|zstd|archive|brotli|lz4) ]]; then
        categories["Compression"]+="$lib\n"
    elif [[ "$lib_name" =~ (sqlite|odbc|mysql|pq\.) ]]; then
        categories["Database"]+="$lib\n"
    elif [[ "$lib_name" =~ (libc\.|libm\.|libdl\.|libpthread|libgcc|libstdc\+\+|libgomp|ld-) ]]; then
        categories["System"]+="$lib\n"
    else
        categories["Other"]+="$lib\n"
    fi
done <<< "$deps"

# Generate report
{
    echo "LPP-SDL Dependency Analysis Report"
    echo "=================================="
    echo
    echo "Generated on: $(date)"
    echo "Binary: $BINARY"
    echo
    
    # Count total dependencies
    total_deps=$(echo "$deps" | wc -l)
    echo "Total shared library dependencies: $total_deps"
    echo
    
    # Print categorized dependencies
    for category in "SDL" "Lua" "Audio" "Video" "Graphics" "OpenCV" "Network" "Database" "Compression" "System" "Other"; do
        if [ -n "${categories[$category]}" ]; then
            echo "### $category Libraries ###"
            echo -e "${categories[$category]}" | grep -v "^$" | while read -r lib; do
                echo "  - $(basename "$lib")"
            done
            echo
        fi
    done
    
    echo "### Core Dependencies (from Makefile) ###"
    echo "These are the libraries directly linked in the Makefile:"
    echo
    echo "SDL2 Stack:"
    echo "  - libSDL2-2.0.so.0 - Core SDL2 library"
    echo "  - libSDL2_ttf-2.0.so.0 - TrueType font support"
    echo "  - libSDL2_image-2.0.so.0 - Image loading support"
    echo "  - libSDL2_mixer-2.0.so.0 - Audio mixing support"
    echo
    echo "Lua:"
    echo "  - libluajit-5.1.so.2 - LuaJIT 2.1 interpreter"
    echo
    echo "Computer Vision:"
    echo "  - libopencv_*.so.406 - OpenCV 4 libraries"
    echo
    echo "Video/Audio Processing:"
    echo "  - libavformat.so.60 - FFmpeg format library"
    echo "  - libavcodec.so.60 - FFmpeg codec library"
    echo "  - libavutil.so.58 - FFmpeg utility library"
    echo "  - libswscale.so.7 - FFmpeg scaling library"
    echo
    echo "Other Core Libraries:"
    echo "  - libsqlite3.so.0 - SQLite database"
    echo "  - libcurl.so.4 - URL transfer library"
    echo "  - libgsm.so.1 - GSM audio codec"
    echo "  - libmpg123.so.0 - MP3 decoder"
    echo "  - libz.so.1 - zlib compression"
    echo "  - libpng16.so.16 - PNG image support"
    echo "  - libGL.so.1 - OpenGL graphics"
    echo
    echo "Optional Libraries (if enabled):"
    echo "  - libarchive.so.13 - Archive support (tar, zip, etc.)"
    echo "  - libreadline.so.8 - Command line editing"
    echo
    echo "### Package Recommendations ###"
    echo "For Ubuntu/Debian users, install these packages:"
    echo "  sudo apt-get install libsdl2-2.0-0 libsdl2-ttf-2.0-0 libsdl2-image-2.0-0 libsdl2-mixer-2.0-0"
    echo "  sudo apt-get install libluajit-5.1-2 libopencv-core406 libopencv-videoio406 libopencv-imgproc406"
    echo "  sudo apt-get install libavformat60 libavcodec60 libavutil58 libswscale7"
    echo "  sudo apt-get install libsqlite3-0 libcurl4 libgsm1 libmpg123-0"
    echo "  sudo apt-get install libarchive13 libreadline8"
    
} > dependency_analysis.txt

echo "Analysis complete! See dependency_analysis.txt for details."
echo

# Quick summary
echo "Summary by category:"
for category in "SDL" "Lua" "Audio" "Video" "Graphics" "OpenCV" "Network" "Database" "Compression" "System" "Other"; do
    count=$(echo -e "${categories[$category]}" | grep -v "^$" | wc -l)
    if [ $count -gt 0 ]; then
        printf "  %-12s: %d libraries\n" "$category" "$count"
    fi
done