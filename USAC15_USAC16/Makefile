# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -g -fanalyzer
ASMFLAGS = -g

# Executable name
EXEC = main

# Source files (including the correct UI file name)
SRCS = main.c operations.c machine_status.c UI.c

# Object files (generated from source files)
OBJS = $(SRCS:.c=.o) asm.o

# Assembly file
ASM = asm.s

# Default target: build the executable
all: $(EXEC)

# Link object files into the executable
$(EXEC): $(OBJS)
	$(CC) $(OBJS) -o $(EXEC)

# Compile C source files into object files
%.o: %.c
	@echo "Compiling $< ..."
	$(CC) $(CFLAGS) -c $< -o $@

# Compile assembly file into object file
asm.o: $(ASM)
	@echo "Assembling $< ..."
	$(CC) $(ASMFLAGS) -c $(ASM) -o asm.o

# Run the program
run: $(EXEC)
	./$(EXEC)

# Clean up object files and executable
clean:
	@echo "Cleaning up..."
	del /Q *.o $(EXEC)

.PHONY: all run clean
