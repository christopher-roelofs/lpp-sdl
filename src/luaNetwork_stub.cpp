/*----------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#------  This File is Part Of : ----------------------------------------------------------------------------------------#
#------- _  -------------------  ______   _   --------------------------------------------------------------------------#
#------ | | ------------------- (_____ \ | |  --------------------------------------------------------------------------#
#------ | | ---  _   _   ____    _____) )| |  ____  _   _   ____   ____   ----------------------------------------------#
#------ | | --- | | | | / _  |  |  ____/ | | / _  || | | | / _  ) / ___)  ----------------------------------------------#
#------ | |_____| |_| |( ( | |  | |      | |( ( | || |_| |( (/ / | |  --------------------------------------------------#
#------ |_______)\____| \_||_|  |_|      |_| \_||_| \__  | \____)|_|  --------------------------------------------------#
#------------------------------------------------- (____/  -------------------------------------------------------------#
#------------------------   ______   _   -------------------------------------------------------------------------------#
#------------------------  (_____ \ | |  -------------------------------------------------------------------------------#
#------------------------   _____) )| | _   _   ___   ------------------------------------------------------------------#
#------------------------  |  ____/ | || | | | /___)  ------------------------------------------------------------------#
#------------------------  | |      | || |_| ||___ |  ------------------------------------------------------------------#
#------------------------  |_|      |_| \____|(___/   ------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#- Licensed under the GPL License --------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#- Copyright (c) Nanni <lpp.nanni@gmail.com> ---------------------------------------------------------------------------#
#- Copyright (c) Rinnegatamante <rinnegatamante@gmail.com> -------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------#
#- SDL Port: Network Module Implementation -----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------*/

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <curl/curl.h>
#include <map>
#include <thread>
#include <fstream>
#include <ifaddrs.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>
#ifdef _WIN32
#include <winsock2.h>
#include <ws2tcpip.h>
#include <iphlpapi.h>
#pragma comment(lib, "ws2_32.lib")
#pragma comment(lib, "iphlpapi.lib")
#endif
#ifdef __APPLE__
#include <sys/types.h>
#include <sys/socket.h>
#include <ifaddrs.h>
#include <net/if_dl.h>
#endif

#include "luaplayer.h"

#define stringify(str) #str
#define VariableRegister(lua, value) do { lua_pushinteger(lua, value); lua_setglobal (lua, stringify(value)); } while(0)

// HTTP method constants
enum {
	GET_METHOD = 0,
	POST_METHOD = 1,
	HEAD_METHOD = 2
};

// Network state
static bool network_initialized = false;
static CURL* curl_handle = nullptr;

// String download structure
struct NetString {
    char* ptr;
    size_t length;
    
    NetString() {
        ptr = (char*)malloc(1);
        length = 0;
        ptr[0] = '\0';
    }
    
    ~NetString() {
        if (ptr) free(ptr);
    }
    
    void append(const char* data, size_t size) {
        ptr = (char*)realloc(ptr, length + size + 1);
        memcpy(ptr + length, data, size);
        length += size;
        ptr[length] = '\0';
    }
};

// Callback for writing data to string
static size_t WriteStringCallback(void* contents, size_t size, size_t nmemb, NetString* userp) {
    size_t realsize = size * nmemb;
    userp->append((char*)contents, realsize);
    return realsize;
}

// Callback for writing data to file
static size_t WriteFileCallback(void* contents, size_t size, size_t nmemb, FILE* fp) {
    size_t written = fwrite(contents, size, nmemb, fp);
    return written;
}

// Network.init - Initialize networking
static int lua_init(lua_State *L) {
    if (network_initialized) {
        return 0; // Already initialized
    }
    
#ifdef _WIN32
    WSADATA wsaData;
    int result = WSAStartup(MAKEWORD(2, 2), &wsaData);
    if (result != 0) {
        return luaL_error(L, "WSAStartup failed");
    }
#endif
    
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl_handle = curl_easy_init();
    
    if (!curl_handle) {
        return luaL_error(L, "Failed to initialize curl");
    }
    
    network_initialized = true;
    return 0;
}

// Network.term - Terminate networking
static int lua_term(lua_State *L) {
    if (!network_initialized) {
        return 0;
    }
    
    if (curl_handle) {
        curl_easy_cleanup(curl_handle);
        curl_handle = nullptr;
    }
    
    curl_global_cleanup();
    
#ifdef _WIN32
    WSACleanup();
#endif
    
    network_initialized = false;
    return 0;
}

// Network.getIPAddress - Get local IP address
static int lua_getip(lua_State *L) {
#ifdef _WIN32
    char hostname[256];
    if (gethostname(hostname, sizeof(hostname)) == 0) {
        struct addrinfo hints, *info;
        memset(&hints, 0, sizeof(hints));
        hints.ai_family = AF_INET;
        hints.ai_socktype = SOCK_STREAM;
        
        if (getaddrinfo(hostname, nullptr, &hints, &info) == 0) {
            struct sockaddr_in* addr = (struct sockaddr_in*)info->ai_addr;
            lua_pushstring(L, inet_ntoa(addr->sin_addr));
            freeaddrinfo(info);
            return 1;
        }
    }
#else
    struct ifaddrs* ifAddrStruct = nullptr;
    struct ifaddrs* ifa = nullptr;
    void* tmpAddrPtr = nullptr;
    
    getifaddrs(&ifAddrStruct);
    
    for (ifa = ifAddrStruct; ifa != nullptr; ifa = ifa->ifa_next) {
        if (!ifa->ifa_addr) continue;
        
        if (ifa->ifa_addr->sa_family == AF_INET) {
            tmpAddrPtr = &((struct sockaddr_in*)ifa->ifa_addr)->sin_addr;
            char addressBuffer[INET_ADDRSTRLEN];
            inet_ntop(AF_INET, tmpAddrPtr, addressBuffer, INET_ADDRSTRLEN);
            
            // Skip loopback
            if (strcmp(addressBuffer, "127.0.0.1") != 0) {
                lua_pushstring(L, addressBuffer);
                if (ifAddrStruct != nullptr) freeifaddrs(ifAddrStruct);
                return 1;
            }
        }
    }
    
    if (ifAddrStruct != nullptr) freeifaddrs(ifAddrStruct);
#endif
    
    // Fallback
    lua_pushstring(L, "127.0.0.1");
    return 1;
}

// Network.getMacAddress - Get MAC address
static int lua_getmac(lua_State *L) {
#ifdef _WIN32
    PIP_ADAPTER_ADDRESSES pAddresses = nullptr;
    ULONG outBufLen = 0;
    
    // Get required buffer size
    GetAdaptersAddresses(AF_UNSPEC, GAA_FLAG_INCLUDE_PREFIX, nullptr, pAddresses, &outBufLen);
    pAddresses = (IP_ADAPTER_ADDRESSES*)malloc(outBufLen);
    
    if (GetAdaptersAddresses(AF_UNSPEC, GAA_FLAG_INCLUDE_PREFIX, nullptr, pAddresses, &outBufLen) == NO_ERROR) {
        PIP_ADAPTER_ADDRESSES pCurrAddresses = pAddresses;
        while (pCurrAddresses) {
            if (pCurrAddresses->PhysicalAddressLength == 6 && pCurrAddresses->OperStatus == IfOperStatusUp) {
                char macStr[32];
                snprintf(macStr, sizeof(macStr), "%02X:%02X:%02X:%02X:%02X:%02X",
                    pCurrAddresses->PhysicalAddress[0],
                    pCurrAddresses->PhysicalAddress[1], 
                    pCurrAddresses->PhysicalAddress[2],
                    pCurrAddresses->PhysicalAddress[3],
                    pCurrAddresses->PhysicalAddress[4],
                    pCurrAddresses->PhysicalAddress[5]);
                lua_pushstring(L, macStr);
                free(pAddresses);
                return 1;
            }
            pCurrAddresses = pCurrAddresses->Next;
        }
    }
    
    if (pAddresses) free(pAddresses);
#elif defined(__APPLE__)
    struct ifaddrs* ifap = nullptr;
    if (getifaddrs(&ifap) == 0) {
        struct ifaddrs* p;
        for (p = ifap; p; p = p->ifa_next) {
            if (p->ifa_addr && p->ifa_addr->sa_family == AF_LINK) {
                struct sockaddr_dl* sdp = (struct sockaddr_dl*)p->ifa_addr;
                if (sdp->sdl_alen == 6) {
                    unsigned char* mac = (unsigned char*)LLADDR(sdp);
                    char macStr[32];
                    snprintf(macStr, sizeof(macStr), "%02X:%02X:%02X:%02X:%02X:%02X",
                        mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
                    lua_pushstring(L, macStr);
                    freeifaddrs(ifap);
                    return 1;
                }
            }
        }
        freeifaddrs(ifap);
    }
#elif defined(__linux__)
    // Try to read MAC from /sys/class/net/*/address
    system("find /sys/class/net -name address -exec head -1 {} \\; 2>/dev/null | grep -v 00:00:00:00:00:00 | head -1 > /tmp/mac_addr");
    FILE* fp = fopen("/tmp/mac_addr", "r");
    if (fp) {
        char mac[32];
        if (fgets(mac, sizeof(mac), fp)) {
            // Remove newline
            mac[strcspn(mac, "\n")] = 0;
            lua_pushstring(L, mac);
            fclose(fp);
            unlink("/tmp/mac_addr");
            return 1;
        }
        fclose(fp);
        unlink("/tmp/mac_addr");
    }
#endif
    
    // Fallback
    lua_pushstring(L, "00:00:00:00:00:00");
    return 1;
}

// Network.requestString - Download string from URL
static int lua_requestString(lua_State *L) {
    if (!network_initialized) {
        return luaL_error(L, "Network not initialized");
    }
    
    const char* url = luaL_checkstring(L, 1);
    const char* useragent = lua_gettop(L) >= 2 ? luaL_optstring(L, 2, "lpp-vita") : "lpp-vita";
    int method = lua_gettop(L) >= 3 ? luaL_optinteger(L, 3, GET_METHOD) : GET_METHOD;
    const char* postdata = lua_gettop(L) >= 4 ? luaL_optstring(L, 4, nullptr) : nullptr;
    
    NetString response;
    
    curl_easy_reset(curl_handle);
    curl_easy_setopt(curl_handle, CURLOPT_URL, url);
    curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteStringCallback);
    curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, &response);
    curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, useragent);
    curl_easy_setopt(curl_handle, CURLOPT_FOLLOWLOCATION, 1L);
    curl_easy_setopt(curl_handle, CURLOPT_SSL_VERIFYPEER, 0L);
    curl_easy_setopt(curl_handle, CURLOPT_SSL_VERIFYHOST, 0L);
    curl_easy_setopt(curl_handle, CURLOPT_TIMEOUT, 30L);
    
    switch (method) {
        case POST_METHOD:
            curl_easy_setopt(curl_handle, CURLOPT_POST, 1L);
            if (postdata) {
                curl_easy_setopt(curl_handle, CURLOPT_POSTFIELDS, postdata);
                curl_easy_setopt(curl_handle, CURLOPT_POSTFIELDSIZE, strlen(postdata));
            }
            break;
        case HEAD_METHOD:
            curl_easy_setopt(curl_handle, CURLOPT_NOBODY, 1L);
            break;
        default: // GET_METHOD
            curl_easy_setopt(curl_handle, CURLOPT_HTTPGET, 1L);
            break;
    }
    
    CURLcode res = curl_easy_perform(curl_handle);
    
    if (res != CURLE_OK) {
        lua_pushstring(L, "");
        return 1;
    }
    
    lua_pushstring(L, response.ptr);
    return 1;
}

// Network.requestFile - Download file from URL
static int lua_requestFile(lua_State *L) {
    if (!network_initialized) {
        return luaL_error(L, "Network not initialized");
    }
    
    const char* url = luaL_checkstring(L, 1);
    const char* filepath = luaL_checkstring(L, 2);
    const char* useragent = lua_gettop(L) >= 3 ? luaL_optstring(L, 3, "lpp-vita") : "lpp-vita";
    int method = lua_gettop(L) >= 4 ? luaL_optinteger(L, 4, GET_METHOD) : GET_METHOD;
    const char* postdata = lua_gettop(L) >= 5 ? luaL_optstring(L, 5, nullptr) : nullptr;
    
    FILE* fp = fopen(filepath, "wb");
    if (!fp) {
        return luaL_error(L, "Cannot open file for writing");
    }
    
    curl_easy_reset(curl_handle);
    curl_easy_setopt(curl_handle, CURLOPT_URL, url);
    curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteFileCallback);
    curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, fp);
    curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, useragent);
    curl_easy_setopt(curl_handle, CURLOPT_FOLLOWLOCATION, 1L);
    curl_easy_setopt(curl_handle, CURLOPT_SSL_VERIFYPEER, 0L);
    curl_easy_setopt(curl_handle, CURLOPT_SSL_VERIFYHOST, 0L);
    curl_easy_setopt(curl_handle, CURLOPT_TIMEOUT, 30L);
    
    switch (method) {
        case POST_METHOD:
            curl_easy_setopt(curl_handle, CURLOPT_POST, 1L);
            if (postdata) {
                curl_easy_setopt(curl_handle, CURLOPT_POSTFIELDS, postdata);
                curl_easy_setopt(curl_handle, CURLOPT_POSTFIELDSIZE, strlen(postdata));
            }
            break;
        case HEAD_METHOD:
            curl_easy_setopt(curl_handle, CURLOPT_NOBODY, 1L);
            break;
        default: // GET_METHOD
            curl_easy_setopt(curl_handle, CURLOPT_HTTPGET, 1L);
            break;
    }
    
    CURLcode res = curl_easy_perform(curl_handle);
    fclose(fp);
    
    if (res != CURLE_OK) {
        unlink(filepath); // Delete failed download
        return luaL_error(L, "Download failed");
    }
    
    return 0;
}

// Network.isWifiEnabled - Check if network is available
static int lua_isConnected(lua_State *L) {
    if (!network_initialized) {
        lua_pushboolean(L, 0);
        return 1;
    }
    
    // Simple connectivity test - try to resolve google.com
    struct addrinfo hints, *result;
    memset(&hints, 0, sizeof(hints));
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    
    int status = getaddrinfo("google.com", "80", &hints, &result);
    if (status == 0) {
        freeaddrinfo(result);
        lua_pushboolean(L, 1);
    } else {
        lua_pushboolean(L, 0);
    }
    
    return 1;
}

// Stub functions for FTP (not implemented in SDL port)
static int lua_startFTP(lua_State *L) {
    return luaL_error(L, "FTP server not supported in SDL port");
}

static int lua_stopFTP(lua_State *L) {
    return luaL_error(L, "FTP server not supported in SDL port");
}

//Register our Network Functions
static const luaL_Reg Network_functions[] = {
  {"init",          lua_init},
  {"term",          lua_term},
  {"requestString", lua_requestString},
  {"requestFile",   lua_requestFile}, 
  {"getIPAddress",  lua_getip},
  {"getMacAddress", lua_getmac},
  {"isWifiEnabled", lua_isConnected},
  {"startFTP",      lua_startFTP},
  {"stopFTP",       lua_stopFTP},
  {0, 0}
};

void luaNetwork_init(lua_State *L) {
	lua_newtable(L);
	luaL_setfuncs(L, Network_functions, 0);
	lua_setglobal(L, "Network");
	VariableRegister(L, GET_METHOD);
	VariableRegister(L, POST_METHOD);
	VariableRegister(L, HEAD_METHOD);
}