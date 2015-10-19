# Copyright (C) 2015 Mars Saxman. All rights reserved.
# Permission is granted to use at your own risk and distribute this software
# in source and binary forms provided all source code distributions retain
# this paragraph and the above copyright notice. THIS SOFTWARE IS PROVIDED "AS
# IS" WITH NO EXPRESS OR IMPLIED WARRANTY.

# GCC requires a freestanding environment to provide implementations of
# memcpy, memmove, memset and memcmp, and these are those implementations.
# libstart does not include a copy of <string.h>, so we don't need to provide
# all of its other string functions, but we can't link without these.

.text
.global memmove
.type memmove, @function
.weak memmove
#	void *memmove(void *dest, const void *src, size_t len);
# Copy 'len' bytes from 'src' to 'dest', coping with the likelihood that the
# source and destination memory regions overlap.
memmove:
	pushl %esi
	pushl %edi
	# load parameter values off the stack and prepare the return value
	movl 12(%esp), %edi		# dest
	movl 16(%esp), %esi		# src
	movl 20(%esp), %ecx		# len
	movl %edi, %eax
	# put the processor in backwards mode
	std
	# move to the end of each buffer
	addl %ecx, %edi
	addl %ecx, %esi
	# copy single bytes until we reach 4-byte alignment
	andl $3, %ecx
	decl %edi
	decl %esi
	rep
	movsb
	# copy the remaining data in 4-byte chunks
	movl 20(%esp), %ecx
	shrl $2, %ecx
	subl $3, %esi
	subl $3, %edi
	rep
	movsl
	# clean up and go home
	cld
	popl %edi
	popl %esi
	ret

.global memcpy
.type memcpy, @function
.weak memcpy
#	void *memcpy(void *dest, const void *src, size_t len);
# Copy 'len' bytes from 'src' to 'dest', assuming that we don't have to worry
# about overlap.
memcpy:
	# save the nonvolatile registers we will use for the string copy
	pushl %esi
	pushl %edi
	# load parameter values off the stack and prepare the return value
	movl 12(%esp), %edi		# dest
	movl 16(%esp), %esi		# src
	movl 20(%esp), %ecx		# len
	movl %edi, %eax
	# copy 4 bytes at a time, using rep to make the microcode do the work
	shrl $2,%ecx
	rep
	movsl
	# copy any remaining bytes at the end, one at a time
	movl 20(%esp), %ecx
	andl $3, %ecx
	rep
	movsb
	# restore registers and return
	popl %edi
	popl %esi
	ret

.global memset
.type memset, @function
.weak memset
#	void *memset(void *ptr, int value, size_t num);
# Fill the first 'num' bytes of the buffer pointed at by 'ptr' to 'value'.
# This is a bytewise operation despite the value's type being int.
memset:
	pushl %edi
	pushl %ebx
	# load parameters and set up for the loop
	movl 12(%esp), %edi
	movzbl 16(%esp), %eax
	movl 20(%esp), %ecx
	# hey cpu, mind doing all the work for us?
	rep
	stosb
	# thanks
	movl 12(%esp), %eax
	popl %ebx
	popl %edi
	ret

.global memcmp
.type memcmp, @function
.weak memcmp
#	int memcmp(const void *ptr1, const void *ptr2, size_t num);
# Compare the first 'num' bytes of the block 'ptr1' points at to the first
# 'num' bytes of the block 'ptr2' points at, returning zero if they all match
# or some <0, >0 value indicating which is greater if they do not match.
memcmp:
	pushl %edi
	pushl %esi
	# load parameters into the good ol' string rep registers
	movl 12(%esp), %edi
	movl 16(%esp), %esi
	movl 20(%esp), %ecx
	# Compare 4 bytes at a time. If we make it to the end and all bytes are
	# equal, continue on and check the remaining bytes individually.
	shrl $2, %ecx
	repe
	cmpsl
	jne recheck
	movl 20(%esp), %ecx
	andl $3, %ecx
	jmp comparebytes
recheck:
	# One or more pairs of bytes in the last word did not match. Back up
	# and try it again, bytewise.
	movl $4, %ecx
	subl %ecx, %edi
	subl %ecx, %esi
comparebytes:
	repe
	cmpsb
	movzbl -1(%edi), %eax
	movzbl -1(%esi), %edx
	subl %edx, %eax
	popl %esi
	popl %edi
	ret

