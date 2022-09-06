---
title: "pwn"
permalink: /snippets/pwn
writer: anko9801
layout: library
---

## 説明

CTFのpwn分野で使うテンプレート。pwntoolsパッケージを使用する。

## 実装

{% include python.html code="pwn/solve.py" %}

## 使用例

```shell
$ python3 solve.py
$ python3 solve.py localhost 3000
```

## 参考文献
[shellphish/how2heap: A repository for learning various heap exploitation techniques. (github.com)](https://github.com/shellphish/how2heap)
[Exploiting Intel Graphics Kernel Extensions on macOS | RET2 Systems Blog](https://blog.ret2.io/2022/06/29/pwn2own-2021-safari-sandbox-intel-graphics-exploit/)