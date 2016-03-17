# Copyright (C) 2015 Mars Saxman. All rights reserved.
# Permission is granted to use at your own risk and distribute this software
# in source and binary forms provided all source code distributions retain
# this paragraph and the above copyright notice. THIS SOFTWARE IS PROVIDED "AS
# IS" WITH NO EXPRESS OR IMPLIED WARRANTY.

# Create a multiboot header so grub knows it can load this executable.
.set FLAGS, 0x00000003 # use page alignment and provide memory map
.set MAGIC, 0x1BADB002 # bootloader looks for this magic number
.set CHECKSUM, -(MAGIC + FLAGS) # no, the magic number was not accidental
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

# Variable to hold the multiboot header address.
.section .data
.align 4
.global _multiboot
_multiboot:
.long 0

# Allocate a section which will hold a call stack.
.section .bootstrap_stack, "aw", @nobits
stack_bottom:
.skip 16384 # 16 KiB
stack_top:

# Configure the processor, save the multiboot header, set up a call stack, and
# jump into the C world.
.section .text
.global _startc
.global _start
.type _start, @function
_start:
	movl $stack_top, %esp
	# Did we get the multiboot header we were looking for?
	cmp $0x2BADB002, %eax
	jne init
	movl %ebx, _multiboot
init:
	call _gdt_init
	call _idt_init
	call _pic_init
	call _startc
	cli
.Lhang:
	hlt
	jmp .Lhang
.size _start, . - _start

