include flags.mk
include $(STARTC_DIR)/build-lib.mk

hello:
	$(MAKE) -C hello

demo: hello
	hello/demo.sh hello/hello.bin

