// Copyright (C) 2015 Mars Saxman. All rights reserved.
// Permission is granted to use at your own risk and distribute this software
// in source and binary forms provided all source code distributions retain
// this paragraph and the above copyright notice. THIS SOFTWARE IS PROVIDED "AS
// IS" WITH NO EXPRESS OR IMPLIED WARRANTY.

#ifndef _STARTC_I386_H
#define _STARTC_I386_H

#include <stdint.h>

struct _cpu_state
{
	uint32_t edi, esi, ebp, esp;
	uint32_t ebx, edx, ecx, eax;
	uint32_t error, eip, cs, eflags;
};

struct _gdt_entry
{
	uint16_t limit;
	uint16_t base0_15;
	uint8_t base16_23;
	uint8_t attrs0_7;
	uint8_t attrs8_15;
	uint8_t base24_31;
} __attribute__ ((packed));

struct _gdt_register
{
	uint16_t limit;
	uint32_t base;
} __attribute__ ((packed));

extern struct _gdt_register _gdtr;
extern struct _gdt_entry _gdt[5];

struct _idt_entry
{
	uint16_t offset0_15;
	uint16_t selector;
	uint8_t zero;
	uint8_t flags;
	uint16_t offset16_31;
} __attribute__((packed));

struct _idt_register
{
	uint16_t limit;
	uint32_t base;
} __attribute__ ((packed));

extern struct _idt_register _idtr;
extern struct _idt_entry _idt[256];

#endif //_STARTC_I386_H

