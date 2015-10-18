SRC = $(wildcard src/*.s)
OBJ = $(patsubst src/%.s,obj/%.o,$(SRC))
LIB = libstartc.a
OPT = -march=i686 --32 --strip-local-absolute

all: $(LIB)

$(LIB): $(OBJ)
	ar rcs $(LIB) $(OBJ)

obj/%.o: src/%.s
	@mkdir -p obj
	as $(OPT) -o $@ $<

clean:
	-rm -f $(LIB) $(OBJ)


