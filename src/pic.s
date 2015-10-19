# Copyright (C) 2015 Mars Saxman. All rights reserved.
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
.type _pic_init, @function
_pic_init:
	// Start initialization and enable ICW4
	movl $0x11, %eax
	movl $PIC1_CMD, %edx
	outb %al, %dx
	movl $PIC2_CMD, %edx
	outb %al, %dx

	// Set up the vector table offsets
	movl $0x20, %eax
	movl $PIC1_DATA, %edx
	outb %al, %dx
	movl $0x28, %eax
	movl $PIC2_DATA, %edx
	outb %al, %dx

	// Configure the master/slave wiring
	movl $0x04, %eax
	movl $PIC1_DATA, %edx
	outb %al, %dx
	movl $0x02, %eax
	movl $PIC2_DATA, %edx
	outb %al, %dx

	// Use 8086 mode and other typical settings
	movl $0x01, %eax
	movl $PIC1_DATA, %edx
	outb %al, %dx
	movl $PIC2_DATA, %edx
	outb %al, %dx

	// Disable all IRQs to start with
	movl $0xFF, %eax
	movl $PIC1_DATA, %edx
	outb %al, %dx
	movl $PIC2_DATA, %edx
	outb %al, %dx
	ret

