SRC = $(wildcard src/*.s)
OBJ = $(patsubst src/%.s,obj/%.o,$(SRC))
LIB = libstartc.a

include flags.mk

all: $(LIB)
.PHONY: all clean hello demo

$(LIB): $(OBJ)
	ar rcs $(LIB) $(OBJ)

obj/%.o: src/%.s
	@mkdir -p obj
	as $(ASFLAGS) -o $@ $<

clean:
	-rm -f $(LIB) $(OBJ)

hello:
	$(MAKE) -C hello

demo: hello
	hello/demo.sh hello/hello.bin

