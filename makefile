SRC_DIR := src
BIN_DIR := bin
CC := gcc
CXX := g++
CFLAGS := -Wall -Wextra -std=c11
CXXFLAGS := -Wall -Wextra -std=c++17

# Compilar un listing individual
listing-%:
	@bash -c '\
	CHAPTER=$$(echo $* | cut -d. -f1); \
	LISTING=$*; \
	SRC=$$(pwd)/$(SRC_DIR); \
	BIN=$$(pwd)/$(BIN_DIR); \
	LISTING_DIR="$$SRC/capitulo_$$CHAPTER/$$LISTING"; \
	if [ ! -d "$$LISTING_DIR" ]; then \
		echo "No se encontró el directorio $$LISTING_DIR"; exit 1; \
	fi; \
	SRC_FILES=$$(find "$$LISTING_DIR" -type f \( -name "*.c" -o -name "*.cpp" \)); \
	if [ -z "$$SRC_FILES" ]; then \
		echo "No se encontraron fuentes en $$LISTING_DIR"; exit 1; \
	fi; \
	CHAPTER_SOURCES=$$(find "$$SRC/capitulo_$$CHAPTER" -mindepth 2 -type f \( -name "*.c" -o -name "*.cpp" \) ! -path "$$LISTING_DIR/*" -exec grep -L "int main" {} \;); \
	INCLUDES=$$(find "$$SRC/capitulo_$$CHAPTER" -type d | sed "s/^/-I/"); \
	DEST_DIR="$$BIN/capitulo_$$CHAPTER/$$LISTING"; \
	mkdir -p "$$DEST_DIR"; \
	EXE="$$DEST_DIR/listing-$$LISTING"; \
	echo "Compilando $$SRC_FILES con dependencias auxiliares -> $$EXE"; \
	if echo "$$SRC_FILES $$CHAPTER_SOURCES" | grep -q "\.cpp$$"; then \
		$(CXX) $(CXXFLAGS) $$INCLUDES -o $$EXE $$SRC_FILES $$CHAPTER_SOURCES; \
	else \
		$(CC) $(CFLAGS) $$INCLUDES -o $$EXE $$SRC_FILES $$CHAPTER_SOURCES; \
	fi; \
	echo "Compilado: $$EXE"; \
	'

# Compilar y ejecutar un listing
run-%: listing-%
	@CHAPTER=$$(echo $* | cut -d. -f1); \
	LISTING=$*; \
	BIN=$$(pwd)/$(BIN_DIR); \
	EXE="$$BIN/capitulo_$$CHAPTER/$$LISTING/listing-$$LISTING"; \
	if [ ! -f "$$EXE" ]; then \
		echo "El ejecutable $$EXE no existe"; exit 1; \
	fi; \
	echo "Ejecutando $$EXE:"; \
	"$$EXE"

# Compilar todos los listings
all:
	@for chapter_dir in $(SRC_DIR)/capitulo_*; do \
		chapter=$$(basename $$chapter_dir | cut -d'_' -f2); \
		for listing_dir in $$chapter_dir/*; do \
			listing=$$(basename $$listing_dir); \
			$(MAKE) listing-$$listing; \
		done; \
	done

# Limpia todo
clean:
	@echo "Eliminando binarios y carpetas de bin..."
	@rm -rf $(BIN_DIR)/capitulo_*
	@echo "Hecho."

# Limpia un listing específico: clean-X.Y
clean-%:
	@CHAPTER=$$(echo $* | cut -d. -f1); \
	LISTING=$*; \
	LISTING_DIR=$(BIN_DIR)/capitulo_$$CHAPTER/$$LISTING; \
	if [ -d "$$LISTING_DIR" ]; then \
		echo "Eliminando $$LISTING_DIR"; \
		rm -rf "$$LISTING_DIR"; \
	else \
		echo "No existe $$LISTING_DIR"; \
	fi

# Limpia un capítulo completo: clean-capitulo_X
clean-capitulo_%:
	@CHAPTER=$*; \
	CAP_DIR=$(BIN_DIR)/capitulo_$$CHAPTER; \
	if [ -d "$$CAP_DIR" ]; then \
		echo "Eliminando $$CAP_DIR"; \
		rm -rf "$$CAP_DIR"; \
	else \
		echo "No existe $$CAP_DIR"; \
	fi
