// Copyright (C) 2015 Mars Saxman. All rights reserved.
// Permission is granted to use at your own risk and distribute this software
// in source and binary forms provided all source code distributions retain
// this paragraph and the above copyright notice. THIS SOFTWARE IS PROVIDED "AS
// IS" WITH NO EXPRESS OR IMPLIED WARRANTY.

#ifndef _STDINT_H
#define _STDINT_H

// signed integer types with exact widths
typedef signed char int8_t;
#define INT8_MIN (-1-0x7f)
#define INT8_MAX (0x7f)
#define INT8_C(c) c
typedef short int16_t;
#define INT16_MIN (-1-0x7fff)
#define INT16_MAX (0x7fff)
#define INT16_C(c) c
typedef int int32_t;
#define INT32_MIN (-1-0x7fffffff)
#define INT32_MAX (0x7fffffff)
#define INT32_C(c) c
typedef long long int64_t;
#define INT64_MIN (-1-0x7fffffffffffffff)
#define INT64_MAX (0x7fffffffffffffff)
#define INT64_C(c) c ## LL

// unsigned integer types with exact widths
typedef unsigned char uint8_t;
#define UINT8_MAX (0xff)
#define UINT8_C(c) c
typedef unsigned short uint16_t;
#define UINT16_MAX (0xffff)
#define UINT16_C(c) c
typedef unsigned int uint32_t;
#define UINT32_MAX (0xffffffffu)
#define UINT32_C(c) c ## U
typedef unsigned long long uint64_t;
#define UINT64_MAX (0xffffffffffffffffu)
#define UINT64_C(c) c ## ULL

// the smallest signed type no smaller than each possible width
typedef int8_t int_least8_t;
#define INT_LEAST8_MIN INT8_MIN
#define INT_LEAST8_MAX INT8_MAX
typedef int16_t int_least16_t;
#define INT_LEAST16_MIN INT16_MIN
#define INT_LEAST16_MAX INT16_MAX
typedef int32_t int_least32_t;
#define INT_LEAST32_MIN INT32_MIN
#define INT_LEAST32_MAX INT32_MAX
typedef int64_t int_least64_t;
#define INT_LEAST64_MIN INT64_MIN
#define INT_LEAST64_MAX INT64_MAX

// the smallest unsigned type no smaller than each possible width
typedef uint8_t uint_least8_t;
#define UINT_LEAST8_MAX UINT8_MAX
typedef uint16_t uint_least16_t;
#define UINT_LEAST16_MAX UINT16_MAX
typedef uint32_t uint_least32_t;
#define UINT_LEAST32_MAX UINT32_MAX
typedef uint64_t uint_least64_t;
#define UINT_LEAST64_MAX UINT64_MAX

// the fastest signed type which is no smaller than the specified width
typedef int8_t int_fast8_t;
#define INT_FAST8_MIN INT8_MIN
#define INT_FAST8_MAX INT8_MAX
typedef int32_t int_fast16_t;
#define INT_FAST16_MIN INT32_MIN
#define INT_FAST16_MAX INT32_MAX
typedef int32_t int_fast32_t;
#define INT_FAST32_MIN INT32_MIN
#define INT_FAST32_MAX INT32_MAX
typedef int64_t int_fast64_t;
#define INT_FAST64_MAX INT64_MAX
#define INT_FAST64_MIN INT64_MIN

// the fastest unsigned type which is no smaller than the specified width
typedef uint8_t uint_fast8_t;
#define UINT_FAST8_MAX UINT8_MAX
typedef uint32_t uint_fast16_t;
#define UINT_FAST16_MAX UINT32_MAX
typedef uint32_t uint_fast32_t;
#define UINT_FAST32_MAX UINT32_MAX
typedef uint64_t uint_fast64_t;
#define UINT_FAST64_MAX UINT64_MAX

// the largest signed integer type available
typedef int64_t intmax_t;
#define INTMAX_MIN INT64_MIN
#define INTMAX_MAX INT64_MAX
#define INTMAX_C(c) c ## LL

// the largest unsigned integer type available
typedef uint64_t uintmax_t;
#define UINTMAX_MAX UINT64_MAX
#define UINTMAX_C(c) c ## ULL

// a signed integer type capable of representing the value of a pointer
typedef long intptr_t;
#define INTPTR_MIN INT32_MIN
#define INTPTR_MAX INT32_MAX

// an unsigned integer type capable of representing the value of a pointer
typedef unsigned long uintptr_t;
#define UINTPTR_MAX UINT32_MAX

// sizes of integral types which are defined in other headers
#define SIZE_MAX UINT32_MAX
#define PTRDIFF_MIN INT32_MIN
#define PTRDIFF_MAX INT32_MAX
#define SIG_ATOMIC_MIN INT32_MIN
#define SIG_ATOMIC_MAX INT32_MAX
#define WCHAR_MAX (0xffffffffu+L'\0')
#define WCHAR_MIN (0+L'\0')
#define WINT_MIN 0U
#define WINT_MAX UINT32_MAX

#endif //_STDINT_H

