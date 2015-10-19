// Copyright (C) 2015 Mars Saxman. All rights reserved.
// Permission is granted to use at your own risk and distribute this software
// in source and binary forms provided all source code distributions retain
// this paragraph and the above copyright notice. THIS SOFTWARE IS PROVIDED "AS
// IS" WITH NO EXPRESS OR IMPLIED WARRANTY.

#ifndef _STDALIGN_H
#define _STDALIGN_H

#ifndef __cplusplus

// this whole header only works in C11 or with compiler extensions
#if __STDC_VERSION__ < 201112L && defined( __GNUC__)
#define _Alignas(t) __attribute__((__aligned__(t)))
#define _Alignof(t) __alignof__(t)
#endif

#define alignas _Alignas
#define alignof _Alignof

#endif

#define __alignas_is_defined 1
#define __alignof_is_defined 1

#endif //_STDALIGN_H

