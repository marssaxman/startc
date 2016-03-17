# Copyright (C) 2015-2016 Mars Saxman. All rights reserved.
# Permission is granted to use at your own risk and distribute this software
# in source and binary forms provided all source code distributions retain
# this paragraph and the above copyright notice. THIS SOFTWARE IS PROVIDED "AS
# IS" WITH NO EXPRESS OR IMPLIED WARRANTY.

# Reconfigure the PICs to raise IRQs on interrupts 0x20-0x2F instead of
# overlapping them on the CPU exception interrupts.

.set PIC1_CMD, 0x0020
.set PIC1_DATA, 0x0021
.set PIC2_CMD, 0x00a0
.set PIC2_DATA, 0x00a1

.section .text
.global _pic_init
_pic_init:
	# Start initialization and enable ICW4
	movb $0x11, %al
	outb %al, $PIC1_CMD
	outb %al, $PIC2_CMD

	# Set up the vector table offsets
	movb $0x20, %al
	outb %al, $PIC1_DATA
	movb $0x28, %al
	outb %al, $PIC2_DATA

	# Configure the master/slave wiring
	movb $0x04, %al
	outb %al, $PIC1_DATA
	movb $0x02, %al
	outb %al, $PIC2_DATA

	# Use 8086 mode and other typical settings
	movl $0x01, %eax
	outb %al, $PIC1_DATA
	outb %al, $PIC2_DATA

	# Disable all IRQs to start with
	movl $0xFF, %eax
	outb %al, $PIC1_DATA
	outb %al, $PIC2_DATA
	ret

