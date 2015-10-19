#!/usr/bin/env bash
# see http://qemu.weilnetz.de/qemu-doc.html

qemu-system-i386 -kernel $1 -monitor stdio -nographic -debugcon stdio

