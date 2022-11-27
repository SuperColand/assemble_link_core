CC = gcc
CFLAGS = -g -std=c99 -Wall

LIB_FILES = lib/tables.c lib/translate_utils.c lib/translate.c assembler-src/assembler_utils.c
ASSEMBLER_FILES = $(LIB_FILES)
LINKER_FILES = $(LIB_FILES) linker-src/linker_utils.c

all: assembler linker

assembler: clean
	$(CC) $(CFLAGS) -o assembler assembler.c my_assembler_utils.c -L. -lP4

linker: clean
	$(CC) $(CFLAGS) -o linker linker.c my_assembler_utils.c my_linker_utils.c -L. -lP4

clean:
	rm -f *.o linker assembler
