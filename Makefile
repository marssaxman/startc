# Identify our input components and our output file
LIB := libstartc.a
SRCS := $(wildcard src/*.s)
OBJS := $(addsuffix .o, $(basename $(SRCS:src/%=obj/%)))
HELLO := demo/hello.bin

include target.mk

all: lib hello

lib: $(LIB)

$(LIB): $(OBJS)
	ar rcs $@ $^

obj/%.o: src/%.s
	@mkdir -p obj
	as $(ASFLAGS) -o $@ $<

hello: $(HELLO)

$(HELLO):
	cd demo && $(MAKE) -s

demo:
	cd demo && $(MAKE) -s -f Makefile run

clean:
	-@rm -f $(LIB) $(OBJS)
	cd demo && $(MAKE) -s -f Makefile clean

.PHONY: all clean demo

