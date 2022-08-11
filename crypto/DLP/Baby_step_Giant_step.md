---
title: "Baby-step Giant-step"
permalink: /snippets/bsgs
writer: anko9801
layout: library
---

## 説明

半分全列挙を用いて $O(\sqrt{N}\log{N})$ でDLPが解ける。

位数 $N$ の巡回群 $G$ について $a, b\in G$ が与えられるので $a^n = b$ となる最小の $n\in \mathbb{N}$ を求める問題を考える。このとき $m = \lceil\sqrt{N}\rceil$ とおき、$n$ を $m$ で割ると $n = qm + r \ (q, r\in[0, \lceil\sqrt{N}\rceil)\ )$ と表せられる。すると $r$ に対して $ba^{-r}$ を全列挙し、そのリストに対して $a^{qm}$ が含まれているような $q$ を探索すると高速に解が求まる。

例えば、有限体 $\mathbb{F}_p$ 上なら乗法群の位数 $p-1$ から

楕円曲線 $E$ 上であれば加法群の位数 $\#E$ から

## 計算量
$O(\sqrt{N}\log N)$

## 実装

## 使用例

## 参考
