# Include this file to link your executable against startc and configure it for
# startc's target platform.
STARTC := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
include $(STARTC)/target.mk
CFLAGS += -isystem $(STARTC)/include
LDLIBS += -lstartc
LDFLAGS += -L$(STARTC)
LDFLAGS += -T $(STARTC)/linker.ld

