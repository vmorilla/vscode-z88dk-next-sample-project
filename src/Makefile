# Specify the compiler and flags
TARGET = +zxn -subtype=nex
VERBOSITY = -v  # -v for verbose, -vn for not verbose
# CRT=31 is the most minimalistic option
# CRT=0 to use stdio
# CRT=1 to use stdio with control codes
CRT = 1	

C_OPT_FLAGS=-SO3 --opt-code-size
CFLAGS = $(TARGET) $(VERBOSITY) $(C_OPT_FLAGS) --list -m --c-code-in-asm -clib=sdcc_iy -Cz"--clean" -startup=$(CRT) -pragma-include:zpragma.inc
LDFLAGS= -startup=$(CRT) -pragma-include:zpragma.inc --list

# Specify the source files
SRCS = $(wildcard *.c) $(wildcard *.asm)

# Specify the output file
OUTPUT_DIR = ../build
OUTPUT = $(OUTPUT_DIR)/main.nex

# Rules
$(OUTPUT): $(SRCS)
	mkdir -p $(OUTPUT_DIR)
	zcc $(CFLAGS) $(LDFLAGS) $^ -create-app -o $@


# Clean rule
clean:
	rm -f $(OUTPUT_DIR)/*
	rm -f *.o *.bin *.lis *.sym *.nex *.map

.PHONY: all clean

