# Variables
INCLUDES = functions.h
SOURCES = functions.s main.c
OBJFILES = functions.s main.o
EXEC = exec_prog

# Suffix rules
.SUFFIXES : .c .o

# How to build an object .o from a code file .c ; $< -- file name
.c.o:
		gcc -g -Wall -Wextra -fanalyzer -c $<

# How to build the executable from object files
${EXEC}: ${OBJFILES}
		gcc ${OBJFILES} -o ${EXEC}

# Run the program
run: ${EXEC}
		./${EXEC}

# Clean up generated files
clean:
		rm -f ${OBJFILES} ${EXEC
