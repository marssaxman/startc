STARTC_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CRT_LIBS := $(STARTC_DIR)/libstartc.a
BUILD_DIR := $(STARTC_DIR)/build
LIB_MK := $(BUILD_DIR)/lib.mk
BIN_MK := $(BUILD_DIR)/bin.mk

ASFLAGS += -march=i686 --32 --strip-local-absolute
CCFLAGS += -ffreestanding -nostdlib -nostdinc
CCFLAGS += -march=i686 -m32
CCFLAGS += -std=c99
CCFLAGS += -isystem $(STARTC_DIR)/include
LDFLAGS += -static -nostdlib -melf_i386
LDFLAGS += --library-path=$(STARTC_DIR)
LDFLAGS += --library=startc
LDFLAGS += -T $(BUILD_DIR)/linker.ld

