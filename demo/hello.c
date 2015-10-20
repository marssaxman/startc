// Copyright (C) 2015 Mars Saxman. All rights reserved.
// Permission is granted to use at your own risk and distribute this software
// in source and binary forms provided all source code distributions retain
// this paragraph and the above copyright notice. THIS SOFTWARE IS PROVIDED "AS
// IS" WITH NO EXPRESS OR IMPLIED WARRANTY.

#include <startc/i386.h>
#include <stdint.h>

static void debug_write(const char *msg)
{
	// Use the port E9 hack to write data to the emulator's debug console.
	while (*msg) {
		__asm__("outb %%al,%%dx;": :"d"(0xE9), "a"(*msg++));
	}
}

void _startc()
{
	debug_write("Hello, world!\n");
	while (1);
}

