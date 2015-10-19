# Copyright (C) 2015 Mars Saxman. All rights reserved.
# Permission is granted to use at your own risk and distribute this software
# in source and binary forms provided all source code distributions retain
# this paragraph and the above copyright notice. THIS SOFTWARE IS PROVIDED "AS
# IS" WITH NO EXPRESS OR IMPLIED WARRANTY.

# Set up an IDT and configure its selectors.
# We will configure the interrupts corresponding to CPU exceptions and to IRQs,
# after reconfiguring the PICs to move them up to 0x20. Other interrupts will
# be left blank. We will use segment 0x08 as defined in the GDT and gates will
# be configured as interrupts, not traps.

.macro idt_entry selector, flags
	.hword 0x0000	# offset_low
	.hword \selector
	.byte 0x00		# zero
	.byte \flags
	.hword 0x0000	# offset_high
.endm
.macro active_entries count
	.rept \count
	idt_entry 0x0008, flags=0x8E
	.endr
.endm
.macro blank_entries count
	.rept \count
	idt_entry 0x0000, flags=0x00
	.endr
.endm

.section .data
.align 8
.global _idt
_idt:
	active_entries 0x14	# 0x00..0x13: CPU exceptions
	blank_entries 0x0C  # 0x14..0x1F: reserved but unused
	active_entries 0x10 # 0x20..0x2F: remapped IRQs
	blank_entries 0xD0  # 0x30..0xFF: unused
.global _idtr
_idtr:
	.hword 0x07FF	# size of table - 1
	.long _idt 		# address

.macro setgate index, target
	.set offset, \index << 3	# IDT entry size = 8
	movl $\target, %eax
	movw %ax, _idt + offset + 0
	shrl $16, %eax
	movw %ax, _idt + offset + 6
.endm

.section .text
.global _idt_init
_idt_init:
	setgate 0x00, _isr_cpu00
	setgate 0x01, _isr_cpu01
	setgate 0x02, _isr_cpu02
	setgate 0x03, _isr_cpu03
	setgate 0x04, _isr_cpu04
	setgate 0x05, _isr_cpu05
	setgate 0x06, _isr_cpu06
	setgate 0x07, _isr_cpu07
	setgate 0x08, _isr_cpu08
	setgate 0x09, _isr_cpu09
	setgate 0x0A, _isr_cpu0A
	setgate 0x0B, _isr_cpu0B
	setgate 0x0C, _isr_cpu0C
	setgate 0x0D, _isr_cpu0D
	setgate 0x0E, _isr_cpu0E
	setgate 0x0F, _isr_cpu0F
	setgate 0x10, _isr_cpu10
	setgate 0x11, _isr_cpu11
	setgate 0x12, _isr_cpu12
	setgate 0x13, _isr_cpu13
	setgate 0x20, _isr_irq00
	setgate 0x21, _isr_irq01
	setgate 0x22, _isr_irq02
	setgate 0x23, _isr_irq03
	setgate 0x24, _isr_irq04
	setgate 0x25, _isr_irq05
	setgate 0x26, _isr_irq06
	setgate 0x27, _isr_irq07
	setgate 0x28, _isr_irq08
	setgate 0x29, _isr_irq09
	setgate 0x2A, _isr_irq0A
	setgate 0x2B, _isr_irq0B
	setgate 0x2C, _isr_irq0C
	setgate 0x2D, _isr_irq0D
	setgate 0x2E, _isr_irq0E
	setgate 0x2F, _isr_irq0F
	lidtl _idtr
	ret

# CPU exception handler: we cannot recover, so we'll halt.
# The application should override this weak symbol with its own implementation.
.global _isr_cpu
.type _isr_cpu, @function
.weak _isr_cpu
_isr_cpu:
	hlt
	jmp _isr_cpu

# External interrupt request handler: ignore the interrupt and return.
# The application should override this weak symbol with its own handler if it
# wants to respond to IRQs.
.global _isr_irq
.type _isr_irq, @function
.weak _isr_irq
_isr_irq:
	ret

.macro isr_cpu id
	pushal
	push $\id
	jmp common_exception
.endm

.macro push0_isr_cpu id
	push $0
	isr_cpu \id
.endm

.macro isr_irq_pic1 id
	push $0
	pushal
	movb $\id, %al
	jmp common_irq_pic1
.endm

.macro isr_irq_pic2 id
	push $0
	pushal
	movb $\id, %al
	jmp common_irq_pic2
.endm

# ISR stubs for the IDT gates we'll use
_isr_cpu00: push0_isr_cpu 0x00
_isr_cpu01: push0_isr_cpu 0x01
_isr_cpu02: push0_isr_cpu 0x02
_isr_cpu03: push0_isr_cpu 0x03
_isr_cpu04: push0_isr_cpu 0x04
_isr_cpu05: push0_isr_cpu 0x05
_isr_cpu06: push0_isr_cpu 0x06
_isr_cpu07: push0_isr_cpu 0x07
_isr_cpu08:       isr_cpu 0x08
_isr_cpu09: push0_isr_cpu 0x09
_isr_cpu0A:       isr_cpu 0x0A
_isr_cpu0B:       isr_cpu 0x0B
_isr_cpu0C:       isr_cpu 0x0C
_isr_cpu0D:       isr_cpu 0x0D
_isr_cpu0E:       isr_cpu 0x0E
_isr_cpu0F: push0_isr_cpu 0x0F
_isr_cpu10: push0_isr_cpu 0x10
_isr_cpu11:       isr_cpu 0x11
_isr_cpu12: push0_isr_cpu 0x12
_isr_cpu13: push0_isr_cpu 0x13
_isr_irq00:  isr_irq_pic1 0x00
_isr_irq01:  isr_irq_pic1 0x01
_isr_irq02:  isr_irq_pic1 0x02
_isr_irq03:  isr_irq_pic1 0x03
_isr_irq04:  isr_irq_pic1 0x04
_isr_irq05:  isr_irq_pic1 0x05
_isr_irq06:  isr_irq_pic1 0x06
_isr_irq07:  isr_irq_pic1 0x07
_isr_irq08:  isr_irq_pic2 0x08
_isr_irq09:  isr_irq_pic2 0x09
_isr_irq0A:  isr_irq_pic2 0x0A
_isr_irq0B:  isr_irq_pic2 0x0B
_isr_irq0C:  isr_irq_pic2 0x0C
_isr_irq0D:  isr_irq_pic2 0x0D
_isr_irq0E:  isr_irq_pic2 0x0E
_isr_irq0F:  isr_irq_pic2 0x0F

common_exception:
	cld					# make sure we're not in backward string mode
	popl %eax			# retrieve the exception number
	pushl %esp			# parameter: address of saved state
	pushl %eax			# parameter: exception number
	call _isr_cpu		# let the C world handle things
	addl $0x08, %esp	# remove parameters
	popal				# restore register state
	addl $0x04, %esp	# remove error code
	iret				# return from interrupt state

common_irq_pic1:
	cld
	# pass IRQ and address of register state as args
	push %esp
	and $0x0F, %eax
	push %eax
	call _isr_irq
	# clear parameters
	add $0x08, %esp
	# issue EOI command to PIC1
	movl $0x20, %eax # EOI command
	movl $0x0020, %edx # PIC1 CMD port
	outb %al, %dx
	popal
	add $0x04, %esp
	iret

common_irq_pic2:
	cld
	# pass IRQ and address of register state as args
	push %esp
	and $0x0F, %eax
	push %eax
	call _isr_irq
	# clear parameters
	add $0x08, %esp
	# issue EOI to PIC2, then PIC1
	movl $0x20, %eax # EOI command
	movl $0x00A0, %edx # PIC2 CMD port
	outb %al, %dx
	movl $0x0020, %edx # PIC1 CMD port
	outb %al, %dx
	popal
	add $0x04, %esp
	iret

