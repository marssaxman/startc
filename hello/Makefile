SRC = $(wildcard src/*.c)
OBJ = $(patsubst src/%.c,obj/%.o,$(SRC))
BIN = hello.bin
CCFLAGS = -ffreestanding -nostdlib -nostdinc -m32 -std=c99 -march=i686
LDFLAGS = -static -nostdlib --library-path=../ --library=startc

all: $(BIN)
.PHONY: all clean

$(BIN): $(OBJ)
	ld $(LDFLAGS) -T linker.ld -o $@ $(OBJ)

obj/%.o: src/%.c
	@mkdir -p obj
	cc $(CCFLAGS) -I../include -Isrc -c $< -o $@

clean:
	-rm -f $(BIN) $(OBJ)

