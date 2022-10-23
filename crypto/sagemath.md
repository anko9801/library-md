---
title: "SageMath チートシート"
permalink: /snippets/sagemath
writer: anko9801
layout: library
---

## 説明

SageMathのプログラムを書くときに参照したいと思うチートシートを作成したい。

## 実装

```python
# import
load('coppersmith.sage')

# 整数環, 剰余環, 有限体
ZZ, Zmod(N), GF(q)

R = GF(2 ^ m)
R.fetch_int(12)
# 多項式
R = Zmod(N)
P. < x, y > = PolynomialRing(R)
f = x ^ 2 + 3*x + 3
f.small_roots()
p /= p.leading_coefficient()  # 最高次項 モニック化
p = p.monic()
ideal(f).groebner_basis()

# 行列
M = matrix(QQ, [[1, 2], [3, 4]])
M.LLL()

A = matrix(Zn, [
    [_a, _b, _c, _d, _e],
    [1, 0, 0, 0, 0],
    [0, 1, 0, 0, 0],
    [0, 0, 1, 0, 0],
    [0, 0, 0, 1, 0],
])

b11, b12, b13, b14, b15 = map(int, (A ^ e)[4])

D, P = m.eigenmatrix_left()
P ^ (-1)*D*P == m

Q = diagonal_matrix(weights)

B *= Q
B = B.LLL()
B /= Q

# 素因数分解
set(factor(n))

# 楕円曲線
EllipticCurve()
```

## 参考
- [quickref](https://wiki.sagemath.org/quickref?action=AttachFile&do=get&target=quickref.pdf)
- [quickref-linalg.pdf (shinshu-u.ac.jp)](http://math.shinshu-u.ac.jp/~nu/nora/sage/doc/refcard/quickref-linalg/200905/ja-utf8/quickref-linalg.pdf)
