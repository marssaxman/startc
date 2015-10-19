include flags.mk
include $(LIB_MK)

hello:
	$(MAKE) -C hello

demo: hello
	hello/demo.sh hello/hello.bin

