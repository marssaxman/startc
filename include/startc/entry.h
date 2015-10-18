#ifndef _STARTC_ENTRY_H
#define _STARTC_ENTRY_H

// The application should define these entrypoint functions.

// Program entry
extern void _startc();

// CPU exception interrupt
struct _cpu_state;
extern void _isr_cpu(unsigned code, struct _cpu_state*);

// External device requested interrupt
extern void _isr_irq(unsigned irq, struct _cpu_state*);

// Startup stub will store the multiboot header address here.
extern struct multiboot_info *_multiboot;

#endif //_STARTC_ENTRY_H

