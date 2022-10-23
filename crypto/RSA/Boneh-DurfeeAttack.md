---
title: "Boneh-Durfee Attack"
---

## 説明

$e$ が大きすぎると以下の式に対し Coppersmith Method を用いて攻撃できる。

$$
\begin{aligned}
ed &= 1 & \pmod{\phi} \\
ed &= k \phi + 1 & (\mathrm{over}\ \mathbb{Z}) \\
0 &= k \phi + 1 & \pmod e \\
&= k (N + 1 - p - q) + 1 & \pmod e \\
&= 2k \left(\frac{N + 1}{2} + \frac{-p -q}{2}\right) + 1 & \pmod e \\
\end{aligned}
$$

## 実装

```python
load('coppersmith.sage')

def boneh_durfee(N, e):
    bounds = (floor(N^.25), 2^1024)
    P.<k, s> = PolynomialRing(Zmod(e))
    f = 2*k*((N+1)//2 - s) + 1
    print(small_roots(f, bounds, m=3, d=4))
```

## 使用例
