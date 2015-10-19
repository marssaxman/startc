// Copyright (C) 2015 Mars Saxman. All rights reserved.
// Permission is granted to use at your own risk and distribute this software
// in source and binary forms provided all source code distributions retain
// this paragraph and the above copyright notice. THIS SOFTWARE IS PROVIDED "AS
// IS" WITH NO EXPRESS OR IMPLIED WARRANTY.

#ifndef _STARTC_ENTRY_H
#define _STARTC_ENTRY_H

// The application must define this main entrypoint function.
extern void _startc();

// The application must provide these interrupt handler functions, one handling
// CPU exceptions and the other handling external device interrupts.
struct _cpu_state;
extern void _isr_cpu(unsigned code, struct _cpu_state*);
extern void _isr_irq(unsigned irq, struct _cpu_state*);

// The startup stub will store the multiboot header address here.
extern struct multiboot_info *_multiboot;

#endif //_STARTC_ENTRY_H

