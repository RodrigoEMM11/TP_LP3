# Forzar compiladores GCC/MinGW
override CC=gcc
override CXX=g++

CFLAGS=-Wall -g
CXXFLAGS=-Wall -g

SRC_DIR=src
BIN_DIR=bin

# Detectar extensión del ejecutable automáticamente (Windows vs Linux)
EXEEXT := $(shell $(CC) -dumpmachine 2>/dev/null | grep -qi mingw && echo .exe)

# Comandos compatibles con MSYS2 y Linux
RM=rm -rf
MKDIR=mkdir -p

# ============================================================
# Directivas principales
# ============================================================
all: capitulo_1 capitulo_2

clean:
	$(RM) $(BIN_DIR)/capitulo_1 $(BIN_DIR)/capitulo_2

# ============================================================
# CAPITULO 1
# ============================================================
capitulo_1: listing-1.1 listing-1.2 listing-1.3

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

# ============================================================
# CAPITULO 2
# ============================================================
capitulo_2: listing-2.1 listing-2.2 listing-2.3 listing-2.4 listing-2.5 listing-2.6 listing-2.7 listing-2.8 listing-2.9

# === Listings (mapa exacto del capitulo 2) ===
listing-2.1: $(BIN_DIR)/capitulo_2/2.1/listing-2.1$(EXEEXT)
listing-2.2: $(BIN_DIR)/capitulo_2/2.2/listing-2.2$(EXEEXT)
listing-2.3: $(BIN_DIR)/capitulo_2/2.3/listing-2.3$(EXEEXT)
listing-2.4: $(BIN_DIR)/capitulo_2/2.4/listing-2.4$(EXEEXT)
listing-2.5: $(BIN_DIR)/capitulo_2/2.5/listing-2.5$(EXEEXT)
listing-2.6: $(BIN_DIR)/capitulo_2/2.6/listing-2.6$(EXEEXT)
listing-2.7: $(BIN_DIR)/capitulo_2/2.7/listing-2.7$(EXEEXT)
listing-2.8: $(BIN_DIR)/capitulo_2/2.8/listing-2.8$(EXEEXT)
listing-2.9: $(BIN_DIR)/capitulo_2/2.9/listing-2.9$(EXEEXT)

# === Reglas de compilación ===
$(BIN_DIR)/capitulo_2/2.1/listing-2.1$(EXEEXT): $(SRC_DIR)/capitulo_2/2.1/arglist.c
	@$(MKDIR) $(BIN_DIR)/capitulo_2/2.1
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/capitulo_2/2.2/listing-2.2$(EXEEXT): $(SRC_DIR)/capitulo_2/2.2/getopt_long.c
	@$(MKDIR) $(BIN_DIR)/capitulo_2/2.2
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/capitulo_2/2.3/listing-2.3$(EXEEXT): $(SRC_DIR)/capitulo_2/2.3/print-env.c
	@$(MKDIR) $(BIN_DIR)/capitulo_2/2.3
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/capitulo_2/2.4/listing-2.4$(EXEEXT): $(SRC_DIR)/capitulo_2/2.4/client.c
	@$(MKDIR) $(BIN_DIR)/capitulo_2/2.4
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/capitulo_2/2.5/listing-2.5$(EXEEXT): $(SRC_DIR)/capitulo_2/2.5/temp_file.c
	@$(MKDIR) $(BIN_DIR)/capitulo_2/2.5
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/capitulo_2/2.6/listing-2.6$(EXEEXT): $(SRC_DIR)/capitulo_2/2.6/readfile.c
	@$(MKDIR) $(BIN_DIR)/capitulo_2/2.6
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/capitulo_2/2.7/listing-2.7$(EXEEXT): $(SRC_DIR)/capitulo_2/2.7/test.c
	@$(MKDIR) $(BIN_DIR)/capitulo_2/2.7
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/capitulo_2/2.8/listing-2.8$(EXEEXT): $(SRC_DIR)/capitulo_2/2.8/app.c $(BIN_DIR)/capitulo_2/2.7/test.o
	@$(MKDIR) $(BIN_DIR)/capitulo_2/2.8
	$(CC) $(CFLAGS) -L$(BIN_DIR)/capitulo_2/2.7 -ltest $< -o $@

$(BIN_DIR)/capitulo_2/2.9/listing-2.9$(EXEEXT): $(SRC_DIR)/capitulo_2/2.9/tifftest.c
	@$(MKDIR) $(BIN_DIR)/capitulo_2/2.9
	$(CC) $(CFLAGS) -static $< -ltiff -ljpeg -lz -lm -o $@
