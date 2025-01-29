# Specify the compiler and flags
TARGET = +zxn -subtype=nex
VERBOSITY = -vn   # -v for verbose, -vn for not verbose
CRT = 0	# CRT=31 is the most minimalistic option, CRT=0 to use stdio

C_OPT_FLAGS=-SO3 --max-allocs-per-node200000 --opt-code-size
CFLAGS = $(TARGET) $(VERBOSITY) --list -m --c-code-in-asm -clib=sdcc_iy -Cz"--clean" -startup=$(CRT)
LIBS = 

# Specify the source files
SRCS = $(wildcard *.c) $(wildcard *.asm)

# Specify the output file
OUTPUT_DIR = ../build
OUTPUT = $(OUTPUT_DIR)/main.nex

# Rules
$(OUTPUT): $(SRCS)
	zcc $(CFLAGS) $(LIBS) $^ -create-app -o $@


# Clean rule
clean:
	rm -f $(OUTPUT_DIR)/*
	rm -f *.o *.bin *.lis *.sym *.nex *.map

.PHONY: all clean

