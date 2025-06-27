#include "include/path_utils.h"
#include <algorithm>

namespace PathUtils {
    
    std::string join(const std::string& base, const std::string& relative) {
        if (base.empty()) return relative;
        if (relative.empty()) return base;
        
        // Use std::filesystem for proper path joining
        std::filesystem::path base_path(base);
        std::filesystem::path rel_path(relative);
        std::filesystem::path result = base_path / rel_path;
        
        return result.string();
    }
    
    std::string normalize(const std::string& path) {
        if (path.empty()) return path;
        
        // Use std::filesystem to normalize the path
        std::filesystem::path fs_path(path);
        return fs_path.lexically_normal().string();
    }
    
    std::string unix_to_platform(const std::string& path) {
        if (path.empty()) return path;
        
        std::string result = path;
        
        // Replace forward slashes with platform separator on Windows
        #ifdef _WIN32
        std::replace(result.begin(), result.end(), '/', '\\');
        #endif
        
        return result;
    }
    
    char get_separator() {
        #ifdef _WIN32
        return '\\';
        #else
        return '/';
        #endif
    }
    
    bool is_absolute(const std::string& path) {
        if (path.empty()) return false;
        
        std::filesystem::path fs_path(path);
        return fs_path.is_absolute();
    }
    
    std::string get_directory(const std::string& path) {
        if (path.empty()) return "";
        
        std::filesystem::path fs_path(path);
        return fs_path.parent_path().string();
    }
    
    std::string get_filename(const std::string& path) {
        if (path.empty()) return "";
        
        std::filesystem::path fs_path(path);
        return fs_path.filename().string();
    }
}