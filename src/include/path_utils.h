#ifndef PATH_UTILS_H
#define PATH_UTILS_H

#include <string>
#include <filesystem>

namespace PathUtils {
    // Join two path components using the correct platform separator
    std::string join(const std::string& base, const std::string& relative);
    
    // Normalize a path to use correct platform separators
    std::string normalize(const std::string& path);
    
    // Convert Unix-style path separators to platform-specific
    std::string unix_to_platform(const std::string& path);
    
    // Get the platform-specific path separator
    char get_separator();
    
    // Check if a path is absolute
    bool is_absolute(const std::string& path);
    
    // Get directory part of a path
    std::string get_directory(const std::string& path);
    
    // Get filename part of a path
    std::string get_filename(const std::string& path);
}

#endif // PATH_UTILS_H