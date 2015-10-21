# Configure the build target
ARCH := i686
BITS := 32
ASFLAGS += -march=$(ARCH) --$(BITS) --strip-local-absolute
CFLAGS += -march=$(ARCH) -m$(BITS) -std=c99 -ffreestanding -nostdlib -nostdinc
LDFLAGS += -static -nostdlib -melf_i386

