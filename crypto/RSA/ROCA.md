---
title: "Return Of Coppersmith Attack"
permalink: /snippets/return-of-coppersmith-attack.md
writer: anko9801
layout: library
---

## 説明

主要な暗号ハードウェアメーカで使われているライブラリ RSALib の鍵生成アルゴリズムの欠陥。が生成する素数に

$$
\begin{aligned}
p &= kM + (e^a \bmod M) \\
q &= lM + (e^b \bmod M) \\
N &= pq = e^{a + b} \pmod M
\end{aligned}
$$

M の素因数分解して中国剰余定理からのDLPを適用

## 実装


## 使用例


## 参考

[The Return of Coppersmith's Attack:Practical Factorization of Widely Used RSA Moduli (acmccs.github.io)](https://acmccs.github.io/papers/p1631-nemecA.pdf)

