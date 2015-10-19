# Copyright (C) 2015 Mars Saxman. All rights reserved.
# Permission is granted to use at your own risk and distribute this software
# in source and binary forms provided all source code distributions retain
# this paragraph and the above copyright notice. THIS SOFTWARE IS PROVIDED "AS
# IS" WITH NO EXPRESS OR IMPLIED WARRANTY.

# Set up a GDT which will instruct the processor to map in the full 32-bit
# address space, since we're not going to use segmentation.

.section .data
.align 8
.global _gdt
_gdt:
gdt_entry_null:
	.hword 0, 0
	.byte 0, 0, 0, 0
gdt_entry_sys_code:
	.hword 0xFFFF	# limit_low
	.hword 0x0000	# base_low
	.byte 0x00		# base_middle
	.byte 0x9A		# access
	.byte 0xCF		# granularity
	.byte 0x00		# base_high
gdt_entry_sys_data:
	.hword 0xFFFF	# limit_low
	.hword 0x0000	# base_low
	.byte 0x00		# base_middle
	.byte 0x92		# access
	.byte 0xCF		# granularity
	.byte 0x00		# base_high
gdt_entry_user_code:
	.hword 0xFFFF	# limit_low
	.hword 0x0000	# base_low
	.byte 0x00		# base_middle
	.byte 0xFA		# access
	.byte 0xCF		# granularity
	.byte 0x00		# base_high
gdt_entry_user_data:
	.hword 0xFFFF	# limit_low
	.hword 0x0000	# base_low
	.byte 0x00		# base_middle
	.byte 0xF2		# access
	.byte 0xCF		# granularity
	.byte 0x00		# base_high

.global _gdtr
_gdtr:
	.hword 39	# limit: size of table in bytes, minus one
	.long _gdt	# base: address of table

# Tell the cpu where our GDT lives, then reload the segment registers.
.section .text
.global _gdt_init
.type _gdt_init, @function
_gdt_init:
	lgdtl (_gdtr)
	mov $0x10, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %fs
	mov %ax, %gs
	mov %ax, %ss
	ljmp $0x8, $reload_cs
reload_cs:
	ret

