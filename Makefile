CXX := g++
CXXFLAGS := -std=c++17 -Wall $(shell sdl2-config --cflags) $(shell pkg-config --cflags luajit) $(shell pkg-config --cflags opencv4) $(shell pkg-config --cflags libavformat libavcodec libavutil libswscale) $(shell pkg-config --cflags mpg123) -I./src/include -I/opt/homebrew/include -DWANT_FASTWAV -DWANT_FMMIDI
LDFLAGS := $(shell sdl2-config --libs) -lSDL2_ttf -lSDL2_image -lSDL2_mixer $(shell pkg-config --libs luajit) $(shell pkg-config --libs opencv4) $(shell pkg-config --libs libavformat libavcodec libavutil libswscale) -lsqlite3 -lcurl -lgsm -lmpg123 -lz -lpng

TARGET := lpp_sdl
SOURCES := main_sdl.cpp \
           src/luaCamera.cpp \
           src/luaControls.cpp \
           src/luaDatabase.cpp \
           src/luaGraphics.cpp \
           src/luaGui_stub.cpp \
           src/luaKeyboard_onscreen.cpp \
           src/luaMic_stub.cpp \
           src/luaNetwork_stub.cpp \
           src/luaSocket.cpp \
           src/luaRegistry_stub.cpp \
           src/luaRender.cpp \
           src/luaScreen.cpp \
           src/luaSound.cpp \
           src/luaSystem.cpp \
           src/luaTimer.cpp \
           src/luaVideo.cpp \
           src/path_utils.cpp \
           src/include/audiodec/audio_decoder.cpp \
           src/include/audiodec/decoder_gsm.cpp \
           src/include/audiodec/decoder_wav.cpp \
           src/include/audiodec/decoder_fmmidi.cpp \
           src/include/audiodec/midisequencer.cpp \
           src/include/audiodec/midisynth.cpp \
           src/include/audiodec/utils.cpp \
           src/include/zip.c \
           src/include/unzip.c \
           src/include/ioapi.c
OBJECTS := $(SOURCES:.cpp=.o)
OBJECTS := $(OBJECTS:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

%.o: %.c
	gcc -Wall -I./src/include -I/opt/homebrew/include -c -o $@ $<

clean:
	rm -f $(TARGET) $(OBJECTS)
