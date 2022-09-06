---
title: "SSSA Attack"
permalink: /snippets/sssa
writer: anko9801
layout: library
---

## 説明

$\mathbb{Q}_p$, $\mathbb{Z}_p$ はそれぞれp進体、p進整数環とする。

次の同型写像 $\lambda_E$ を用いて楕円曲線 $\tilde{E}(\mathbb{F}_p)$ 上が $\mathbb{F}_p$ 上の DLP、つまり $\bmod p$ の割り算に帰結する。

$$
\lambda_E \colon \tilde{E}(\mathbb{F}_p) \overset{u}{\to} E(\mathbb{Q}_p)\xrightarrow{p倍}\ker\pi \xrightarrow{\mathscr{L}} p\mathbb{Z}_p\xrightarrow{\bmod p^2}p\mathbb{Z}_p/p^2 \mathbb{Z}_p\simeq \mathbb{F}_p
$$



## 参考

[Fermat Quotient と Anomalous 楕円曲線の離散対数の多項式時間解法アルゴリズムについて(代数的整数論とその周辺)](https://repository.kulib.kyoto-u.ac.jp/dspace/bitstream/2433/61761/1/1026-15.pdf)
