SRC = $(wildcard src/*.c)
OBJ = $(patsubst src/%.c,obj/%.o,$(SRC))
BIN = hello.bin

include ../flags.mk

all: $(BIN)
.PHONY: all clean

$(BIN): $(OBJ)
	ld $(LDFLAGS) -o $@ $(OBJ)

obj/%.o: src/%.c
	@mkdir -p obj
	cc $(CCFLAGS) -c $< -o $@

clean:
	-rm -f $(BIN) $(OBJ)

