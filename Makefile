# Set the Java compiler and flags
JC = javac
JFLAGS = -g -d bin -sourcepath src

# Set the Java interpreter and run flags
JVM = java
RFLAGS = -cp bin

# Set the source and target directories
SRCDIR = src
BINDIR = bin

# Set the package and main class name
PACKAGE = com/craftinginterpreters/lox
MAIN_CLASS = Lox

# Define the source files
SOURCES := $(wildcard $(SRCDIR)/$(PACKAGE)/*.java)

# Define the object files
OBJECTS := $(SOURCES:$(SRCDIR)/%.java=$(BINDIR)/%.class)

# Rule for running GenerateAst class
#run_generate_ast:
#		$(JVM) $(RFLAGS) com.craftinginterpreters.tool.GenerateAst $(SRCDIR)/com/craftinginterpreters/lox

# Rule for building Java class files
$(BINDIR)/%.class: $(SRCDIR)/%.java
		@mkdir -p $(@D)
		$(JC) $(JFLAGS) $<

# Compilation step for GenerateAst class
#$(BINDIR)/com/craftinginterpreters/tool/GenerateAst.class: $(SRCDIR)/com/craftinginterpreters/tool/GenerateAst.java
#		@mkdir -p $(@D)
#		$(JC) $(JFLAGS) $<

# Compile target
compile: $(OBJECTS) #$(BINDIR)/com/craftinginterpreters/tool/GenerateAst.class .

# Run target
run: compile
		$(JVM) $(RFLAGS) $(PACKAGE).$(MAIN_CLASS)

# Run inside gdb target
debug: compile
		gdb --args $(JVM) $(RFLAGS) $(PACKAGE).$(MAIN_CLASS)

# Target to print the source files
print_sources:
		@echo $(SOURCES)

# Clean target
clean:
		@rm -rf $(BINDIR)

# PHONY targets
.PHONY: compile run debug print_sources clean
