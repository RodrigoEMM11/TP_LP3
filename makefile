# Forzar compiladores GCC/MinGW
override CC=gcc
override CXX=g++

CFLAGS=-Wall -g
CXXFLAGS=-Wall -g

SRC_DIR=src
BIN_DIR=bin

# Detectar extensión del ejecutable automáticamente
EXEEXT := $(shell $(CC) -dumpmachine 2>/dev/null | grep -qi mingw && echo .exe)

# Comandos compatibles con MSYS2 y Linux
RM=rm -rf
MKDIR=mkdir -p

# === Directivas principales ===
all: listing-1.1 listing-1.2 listing-1.3

clean:
	$(RM) $(BIN_DIR)/capitulo_1/1.1/*$(EXEEXT) \
	      $(BIN_DIR)/capitulo_1/1.2/*$(EXEEXT) \
	      $(BIN_DIR)/capitulo_1/1.3/*$(EXEEXT)

# === Listing 1.1 ===
listing-1.1: $(BIN_DIR)/capitulo_1/1.1/main.o $(BIN_DIR)/capitulo_1/1.2/reciprocal.o
	$(CXX) -o $(BIN_DIR)/capitulo_1/1.1/listing-1.1$(EXEEXT) $^

$(BIN_DIR)/capitulo_1/1.1/main.o: $(SRC_DIR)/capitulo_1/1.1/main.c $(SRC_DIR)/capitulo_1/1.3/reciprocal.hpp
	@$(MKDIR) $(BIN_DIR)/capitulo_1/1.1
	$(CC) $(CFLAGS) -I$(SRC_DIR)/capitulo_1/1.3 -c $< -o $@

$(BIN_DIR)/capitulo_1/1.2/reciprocal.o: $(SRC_DIR)/capitulo_1/1.2/reciprocal.cpp $(SRC_DIR)/capitulo_1/1.3/reciprocal.hpp
	@$(MKDIR) $(BIN_DIR)/capitulo_1/1.2
	$(CXX) $(CXXFLAGS) -I$(SRC_DIR)/capitulo_1/1.3 -c $< -o $@

# === Listing 1.2 ===
listing-1.2: $(BIN_DIR)/capitulo_1/1.2/main-1.2.o $(BIN_DIR)/capitulo_1/1.2/reciprocal.o
	$(CXX) -o $(BIN_DIR)/capitulo_1/1.2/listing-1.2$(EXEEXT) $^

$(BIN_DIR)/capitulo_1/1.2/main-1.2.o: $(SRC_DIR)/capitulo_1/1.2/main-1.2.c $(SRC_DIR)/capitulo_1/1.3/reciprocal.hpp
	@$(MKDIR) $(BIN_DIR)/capitulo_1/1.2
	$(CC) $(CFLAGS) -I$(SRC_DIR)/capitulo_1/1.3 -c $< -o $@

# === Listing 1.3 ===
listing-1.3: $(BIN_DIR)/capitulo_1/1.3/main-1.3.o $(BIN_DIR)/capitulo_1/1.2/reciprocal.o
	$(CXX) -o $(BIN_DIR)/capitulo_1/1.3/listing-1.3$(EXEEXT) $^

$(BIN_DIR)/capitulo_1/1.3/main-1.3.o: $(SRC_DIR)/capitulo_1/1.3/main-1.3.c $(SRC_DIR)/capitulo_1/1.3/reciprocal.hpp
	@$(MKDIR) $(BIN_DIR)/capitulo_1/1.3
	$(CC) $(CFLAGS) -I$(SRC_DIR)/capitulo_1/1.3 -c $< -o $@

# === Regla genérica para listings simples ===
# Esto compila un solo archivo .c o .cpp a ejecutable
define SIMPLE_LISTING
$(BIN_DIR)/$(1)/listing-$(1)$(EXEEXT): $(SRC_DIR)/$(1)/$(2).c
	@$(MKDIR) $(BIN_DIR)/$(1)
	$(CC) $(CFLAGS) -o $$@ $$<

$(BIN_DIR)/$(1)/listing-$(1)$(EXEEXT): $(SRC_DIR)/$(1)/$(2).cpp
	@$(MKDIR) $(BIN_DIR)/$(1)
	$(CXX) $(CXXFLAGS) -o $$@ $$<
endef