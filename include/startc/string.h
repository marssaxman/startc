#ifndef _STARTC_STRING_H
#define _STARTC_STRING_H

// GCC requires a freestanding runtime library implementation to provide these
// four string functions. They are exposed here so you can use them if you
// like, but they are declared as weak symbols so you can override them with
// your own implementations instead.

#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

int memcmp(const void*, const void*, size_t);
void *memcpy(void *dest, const void *src, size_t len);
void *memmove(void *dest, const void *src, size_t len);
void *memset(void*, int, size_t);

#ifdef __cplusplus
}
#endif

#endif // _STARTC_STRING_H

