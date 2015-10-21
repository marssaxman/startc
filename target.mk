# Configure the build target
ARCHFLAGS = -march=i686 -m32
ASFLAGS += $(ARCHFLAGS) --strip-local-absolute
CFLAGS += $(ARCHFLAGS) -std=c99 -ffreestanding -nostdlib -nostdinc
LDFLAGS += -static -nostdlib -melf_i386

