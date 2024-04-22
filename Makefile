# Makefile for Lox interpreter

# Compiler
JAVAC = javac
# Compiler flags
JFLAGS = -g

# Source directory
SRC_DIR = src
# Output directory
OUT_DIR = out
# Main class
MAIN_CLASS = com.craftinginterpreters.lox.Lox

# Java source files
SRCS := $(wildcard $(SRC_DIR)/**/**/**/*.java)
# Compiled class files
CLASSES := $(patsubst $(SRC_DIR)/%.java,$(OUT_DIR)/%.class,$(SRCS))

# Default target
.PHONY: all
all: $(OUT_DIR) $(CLASSES)

# Compile Java source files
$(OUT_DIR)/%.class: $(SRC_DIR)/%.java
	$(JAVAC) $(JFLAGS) -d $(OUT_DIR) $(filter %.java,$^)

# Create output directory if it doesn't exist
$(OUT_DIR):
	mkdir -p $(OUT_DIR)

# Run the Lox interpreter
.PHONY: run
run: all
	java -cp $(OUT_DIR) $(MAIN_CLASS)

# Clean up
.PHONY: clean
clean:
	rm -rf $(OUT_DIR)

