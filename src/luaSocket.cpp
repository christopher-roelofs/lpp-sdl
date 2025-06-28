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
#- SDL Port: Socket Implementation for TCP connections -----------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------*/

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>
#include <stdint.h>
#ifdef _WIN32
#include <winsock2.h>
#include <ws2tcpip.h>
#pragma comment(lib, "ws2_32.lib")
#else
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>
#include <fcntl.h>
#endif

#include "luaplayer.h"

#ifdef _WIN32
#include <windows.h>
#else
#include <unistd.h>
#endif

#define stringify(str) #str
#define VariableRegister(lua, value) do { lua_pushinteger(lua, value); lua_setglobal (lua, stringify(value)); } while(0)

// Socket state
static bool socket_initialized = false;

typedef struct {
    uint32_t magic;
    int sock;
    bool serverSocket;
} Socket;

#define SOCKET_MAGIC 0xDEADDEAD

#ifdef _WIN32
#define SOCKET_ERROR_WOULD_BLOCK WSAEWOULDBLOCK
#define GET_SOCKET_ERROR() WSAGetLastError()
#define CLOSE_SOCKET(s) closesocket(s)
#else
#define SOCKET_ERROR_WOULD_BLOCK EAGAIN
#define GET_SOCKET_ERROR() errno
#define CLOSE_SOCKET(s) close(s)
#endif

// Socket.init - Initialize socket system
static int lua_init(lua_State *L) {
    printf("Socket.init() called\n");
    fflush(stdout);
    if (socket_initialized) {
        printf("Socket system already initialized\n");
        fflush(stdout);
        return 0; // Already initialized
    }
    
#ifdef _WIN32
    WSADATA wsaData;
    int result = WSAStartup(MAKEWORD(2, 2), &wsaData);
    if (result != 0) {
        return luaL_error(L, "WSAStartup failed: %d", result);
    }
#endif
    
    socket_initialized = true;
    printf("Socket system initialized successfully\n");
    return 0;
}

// Socket.term - Terminate socket system
static int lua_term(lua_State *L) {
    if (!socket_initialized) {
        return 0;
    }
    
#ifdef _WIN32
    WSACleanup();
#endif
    
    socket_initialized = false;
    return 0;
}

// Socket.connect - Connect to a TCP server
static int lua_connect(lua_State *L) {
    if (!socket_initialized) {
        return luaL_error(L, "Socket system not initialized");
    }
    
    const char* hostname = luaL_checkstring(L, 1);
    int port = luaL_checkinteger(L, 2);
    
    printf("Socket.connect() called: %s:%d\n", hostname, port);
    fflush(stdout);
    
    // Resolve hostname
    struct addrinfo hints, *result;
    memset(&hints, 0, sizeof(hints));
    hints.ai_family = AF_INET; // IPv4
    hints.ai_socktype = SOCK_STREAM; // TCP
    
    char port_str[16];
    snprintf(port_str, sizeof(port_str), "%d", port);
    
    int status = getaddrinfo(hostname, port_str, &hints, &result);
    if (status != 0) {
        return luaL_error(L, "Failed to resolve hostname: %s", hostname);
    }
    
    // Create socket
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        freeaddrinfo(result);
        return luaL_error(L, "Failed to create socket");
    }
    
    // Connect to server
    if (connect(sockfd, result->ai_addr, result->ai_addrlen) < 0) {
        CLOSE_SOCKET(sockfd);
        freeaddrinfo(result);
        return luaL_error(L, "Failed to connect to %s:%d", hostname, port);
    }
    
    freeaddrinfo(result);
    
    // Set socket to non-blocking mode to prevent GUI freeze
#ifdef _WIN32
    u_long mode = 1;
    ioctlsocket(sockfd, FIONBIO, &mode);
#else
    int flags = fcntl(sockfd, F_GETFL, 0);
    fcntl(sockfd, F_SETFL, flags | O_NONBLOCK);
#endif
    
    // Create Socket struct and return pointer as integer
    Socket* sock = (Socket*)malloc(sizeof(Socket));
    if (!sock) {
        CLOSE_SOCKET(sockfd);
        return luaL_error(L, "Failed to allocate socket structure");
    }
    
    sock->magic = SOCKET_MAGIC;
    sock->sock = sockfd;
    sock->serverSocket = false;
    
    printf("Socket connected successfully, ptr: %p\n", (void*)sock);
    fflush(stdout);
    lua_pushinteger(L, (lua_Integer)(uintptr_t)sock);
    return 1;
}

// Socket.send - Send data to socket
static int lua_send(lua_State *L) {
    if (!socket_initialized) {
        return luaL_error(L, "Socket system not initialized");
    }
    
    lua_Integer sock_int = luaL_checkinteger(L, 1);
    Socket* sock = (Socket*)(uintptr_t)sock_int;
    const char* data = luaL_checkstring(L, 2);
    
    if (!sock || sock->magic != SOCKET_MAGIC) {
        return luaL_error(L, "Invalid socket");
    }
    
    size_t data_len = strlen(data);
    
    ssize_t bytes_sent = send(sock->sock, data, data_len, 0);
    if (bytes_sent < 0) {
        int error = GET_SOCKET_ERROR();
        if (error != SOCKET_ERROR_WOULD_BLOCK) {
            return luaL_error(L, "Send failed: %d", error);
        }
        bytes_sent = 0; // Would block, no data sent
    }
    
    lua_pushinteger(L, bytes_sent);
    return 1;
}

// Socket.receive - Receive data from socket
static int lua_receive(lua_State *L) {
    printf("lua_receive called\n");
    if (!socket_initialized) {
        return luaL_error(L, "Socket system not initialized");
    }
    
    lua_Integer sock_int = luaL_checkinteger(L, 1);
    printf("Got socket int: %ld\n", (long)sock_int);
    Socket* sock = (Socket*)(uintptr_t)sock_int;
    printf("Cast to pointer: %p\n", (void*)sock);
    int max_size = luaL_checkinteger(L, 2);
    printf("Max size: %d\n", max_size);
    
    if (!sock) {
        printf("Socket is null\n");
        return luaL_error(L, "Socket is null");
    }
    
    printf("Checking magic: 0x%x (expected: 0x%x)\n", sock->magic, SOCKET_MAGIC);
    if (sock->magic != SOCKET_MAGIC) {
        printf("Invalid magic number\n");
        return luaL_error(L, "Invalid socket magic");
    }
    printf("Magic check passed\n");
    
    // Allocate buffer
    char* buffer = (char*)malloc(max_size + 1);
    if (!buffer) {
        return luaL_error(L, "Failed to allocate buffer");
    }
    
    ssize_t bytes_received = recv(sock->sock, buffer, max_size, 0);
    if (bytes_received < 0) {
        int error = GET_SOCKET_ERROR();
        // Handle non-blocking socket would-block condition
        if (error == SOCKET_ERROR_WOULD_BLOCK || error == EWOULDBLOCK) {
            free(buffer);
            // Add small delay to prevent CPU spinning in tight loops
#ifdef _WIN32
            Sleep(10); // 10ms delay on Windows
#else
            usleep(10000); // 10ms delay on Unix (10,000 microseconds)
#endif
            lua_pushstring(L, ""); // Return empty string when no data available
            return 1;
        } else {
            printf("Socket receive error: %d\n", error);
            free(buffer);
            lua_pushstring(L, ""); // Return empty string on error for IRC compatibility
            return 1;
        }
    } else if (bytes_received == 0) {
        // Connection closed
        printf("Socket connection closed\n");
        free(buffer);
        lua_pushstring(L, "");
        return 1;
    } else {
        // Null terminate and return string
        buffer[bytes_received] = '\0';
        printf("Socket received %zd bytes: %s\n", bytes_received, buffer);
        lua_pushstring(L, buffer);
    }
    
    free(buffer);
    return 1;
}

// Socket.close - Close a socket
static int lua_socket_close(lua_State *L) {
    if (!socket_initialized) {
        return luaL_error(L, "Socket system not initialized");
    }
    
    lua_Integer sock_int = luaL_checkinteger(L, 1);
    Socket* sock = (Socket*)(uintptr_t)sock_int;
    
    if (!sock || sock->magic != SOCKET_MAGIC) {
        return luaL_error(L, "Invalid socket");
    }
    
    CLOSE_SOCKET(sock->sock);
    sock->magic = 0; // Clear magic to prevent reuse
    free(sock);
    
    return 0;
}

//Register our Socket Functions
static const luaL_Reg Socket_functions[] = {
    {"init",    lua_init},
    {"term",    lua_term}, 
    {"connect", lua_connect},
    {"send",    lua_send},
    {"receive", lua_receive},
    {"close",   lua_socket_close},
    {0, 0}
};

void luaSocket_init(lua_State *L) {
    lua_newtable(L);
    luaL_setfuncs(L, Socket_functions, 0);
    lua_setglobal(L, "Socket");
}