# Configure the build target
ASFLAGS += -march=i686 --32 --strip-local-absolute
CFLAGS += -march=i686 -m32 -std=c99 -ffreestanding -nostdlib -nostdinc
LDFLAGS += -static -nostdlib -melf_i386

