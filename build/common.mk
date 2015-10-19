# a home for common build rules so we don't have to repeat them everywhere
# you must also link against the flags.mk for the target C runtime.

# source files live under src/ and object files live under obj/
SRC = $(wildcard src/*.c src/*.s)
OBJ = $(addsuffix .o, $(basename $(SRC:src/%=obj/%)))

# the compiler will generate dependency files which also live under obj/
# these dependency files are themselves makefiles; include them to add rules
DEP := $(wildcard obj/*.d)
CCFLAGS += -MD -MP
-include $(OBJ:%.o=%.d)

# rule to compile C source files into object files. we'll squelch the display
# of CCFLAGS since it tends to get extremely verbose
obj/%.o: src/%.c
	@mkdir -p obj
	@echo "cc \$$(CCFLAGS) -c $< -o $@"
	@cc $(CCFLAGS) -c $< -o $@

# rule to assemble .s files into .o files
obj/%.o: src/%.s
	@mkdir -p obj
	@echo "as \$$(ASFLAGS) -o $@ $<"
	@as $(ASFLAGS) -o $@ $<

# extract the project name from the directory path
# this can be used to construct the name of the output file
NAME := $(notdir $(patsubst %/, %, $(abspath $(CURDIR))))

# link object files into a static library
LIB := lib$(NAME).a
lib: $(LIB)
$(LIB): $(OBJ)
	ar rcs $(LIB) $(OBJ)
test: $(LIB)
	cd test && $(MAKE) run

# link object libraries into an executable
BIN := $(NAME).bin
bin: $(BIN)
$(BIN): $(OBJ)
	ld $(OBJ) $(LDFLAGS) -o $(BIN)
run: $(BIN)
	@$(BUILD_DIR)/run.sh $(BIN)

# remove object files and build products
clean:
	-rm -f $(BIN) $(LIB) $(OBJ) $(DEP)

.PHONY: all clean run test lib bin

