---
title: "Return Of Coppersmith Attack"
permalink: /snippets/return-of-coppersmith-attack.md
writer: anko9801
layout: library
---

## 説明

主要な暗号ハードウェアメーカで使われているライブラリ RSALib の鍵生成アルゴリズムの欠陥。

$$
\begin{aligned}
p &= kM + (e^a \bmod M) \\
q &= lM + (e^b \bmod M) \\
N &= pq = e^{a + b} \pmod M
\end{aligned}
$$

M の素因数分解して中国剰余定理からのDLPを適用
$P_n = 2\cdot 3\cdot\ldots\cdot p_n$
512bit RSA $M = P_{39}$, $k$ 37bit, $a$ 62bit
1024bit RSA $M = P_{71}$
2048bit RSA $M = P_{126}$

## 実装


## 使用例


## 参考

[The Return of Coppersmith's Attack:Practical Factorization of Widely Used RSA Moduli (acmccs.github.io)](https://acmccs.github.io/papers/p1631-nemecA.pdf)

