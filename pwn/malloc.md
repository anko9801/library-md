---
title: "glibc malloc"
---

## 説明

環境
64bit

ヒープ領域にmalloc_state
glibcのデータ領域にmain_arena
binには沢山の種類がある
- tcache
- fastbins
- unsorted bins
- small bins
- large bins

libc 2.29
tcacheでdouble freeはできない

## 参考
[malloc(3)のメモリ管理構造](https://www.valinux.co.jp/technologylibrary/document/linux/malloc0001/)
[MallocInternals - glibc wiki (sourceware.org)](https://sourceware.org/glibc/wiki/MallocInternals)
