#ifndef _STDDEF_H
#define _STDDEF_H

#ifdef __cplusplus
#define NULL 0L
#else
#define NULL ((void*)0)
#endif

typedef int ptrdiff_t;
typedef unsigned size_t;
#ifndef __cplusplus
typedef __WCHAR_TYPE__ wchar_t;
#endif

#define offsetof(type, member) __builtin_offsetof(type, member)

#endif //_STDDEF_H

