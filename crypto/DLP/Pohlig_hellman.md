---
title: "Pohlig-Hellman"
---

## 説明

中国剰余定理を用いて大きな群を複数の小さな群の直積に分割する。

## 実装

```python
fact = factor(G.order())
ord = int(G.order())
dlogs = []
for p, e in fact:
    t = ord // p ^ e
    dlog = discrete_log(t * Q, t * G, operation="+")
    dlogs += [dlog]

print(crt(dlogs, primes))
```

## 使用例

## 参考
