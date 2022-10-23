---
title: "Wiener's Attack"
permalink: /snippets/wieners-attack
writer: anko9801
layout: library
---

## 説明

$3d < N^{\frac{1}{4}}$ のとき ( $d$ が小さすぎるか $e$ が大きすぎるとき)、$e/N$ に対し主近似分数を並べると $k/d$ がある。

$$
\begin{aligned}
ed &≡ 1 = k\phi(N) + 1 = k(N - p - q + 1) + 1 \\
\frac{e}{N} &= \frac{k}{d}\left(1-\frac{p + q - 1 - \frac{1}{k}}{N}\right) \approx \frac{k}{d} \\
\frac{e}{N} &\approx q_0 + \cfrac{1}{q_1 + \cfrac{1}{q_2 + \cfrac{1}{\ddots \cfrac{}{q_{m-1} + \cfrac{1}{q_m}}}}} = \frac{k_m}{d_m} \\
\end{aligned}
$$

次の漸化式を用いて主近似分数は求まる。

$$
\begin{aligned}
r_{-2} &= e & k_{-2} &= 0 &d_{-2} &= 1 \\
r_{-1} &= N & k_{-1} &= 1 &d_{-1} &= 0 \\
r_{i-2} \div r_{i-1} &= q_{i} \cdots r_{i} & k_i &= q_i k_{i−1} + k_{i−2} &d_i &= q_i d_{i−1}+d_{i−2} \\
\end{aligned}
$$

## 実装

```python
import gmpy2

def convergents(a, b):
    r0, r1 = a, b
    a0, a1 = 0, 1
    b0, b1 = 1, 0

    i = 0
    while r1 != 0:
        i += 1
        q = r0 // r1
        r0, r1 = r1, r0 % r1
        a0, a1 = a1, q*a1 + a0
        b0, b1 = b1, q*b1 + b0

        if i % 2 == 0:
            a = a1 + a0
            b = b1 + b0
        else:
            a = a1
            b = b1

        yield a, b

def has_integer_roots(a, b, c):
    D = b*b - 4*a*c
    if D > 0:
        sD = gmpy2.isqrt(D)
        if sD * sD == D and (-b + sD) % (2*a) == 0:
            return 2
    elif D == 0 and b % (2*a) == 0:
        return 1
    return 0

def WienersAttack(n, e):
    for d, k in convergents(n, e):
        if k == 0 or (e * d - 1) % k != 0:
            continue
        phi = (e * d - 1) // k
        if has_integer_roots(1, phi - n - 1, n) > 0:
            return d
    return -1
```

## 使用例
