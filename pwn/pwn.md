---
title: "pwn"
---

## 説明

CTFのpwn分野で使うテンプレート。pwntoolsパッケージを使用する。

## 実装

```python
from pwn import *
import sys

binary_path = './chall'

if len(sys.argv) == 3:
    io = remote(sys.argv[1], int(sys.argv[2]))
else:
    io = process(binary_path)
elf = ELF(binary_path)
# libc = ELF("./libc.so.6")
context(arch='amd64', os='linux')

def wait_for_attach():
    print('attach?')
    raw_input()

# str   -> bytes: text.encode('utf-8')
# bytes -> str  : text.decode('utf-8')
# long  -> bytes(big)   : long_to_bytes(num)
# long  -> bytes(little): p64(num)
# bytes -> long(big)    : bytes_to_long(data)
# bytes -> long(little) : int.from_bytes(data, 'little')
# bytes -> int          : int(data, 16)

payload = b''
io.sendlineafter(b'> ', payload)
io.recvline()
io.interactive()
```

## 使用例

```shell
$ python3 solve.py
$ python3 solve.py localhost 3000
```

## 参考文献
[shellphish/how2heap: A repository for learning various heap exploitation techniques. (github.com)](https://github.com/shellphish/how2heap)
[Exploiting Intel Graphics Kernel Extensions on macOS | RET2 Systems Blog](https://blog.ret2.io/2022/06/29/pwn2own-2021-safari-sandbox-intel-graphics-exploit/)