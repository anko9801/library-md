---
title: "MOV/FR Reduction"
---

## MOV Reduction
$R=dP$ となるECDLPを解く

Weil pairing $e_n: E[n]\times E[n]\to \mu_n\subseteq \mathbb{F}_{p^k}^*$

1. $E[n]\subseteq E(\mathbb{F}_{p^k})$ となる最小の $k$ を持ってくる
2. 位数 $n$ の $\alpha=e_n(P, Q)$ となるように $Q \in E[n]$ を取ってくる
3. $\beta = e_n(dP, Q)$
4. $\mathbb{F}_{p^k}^*$ 上のDLPを $\alpha, \beta$ を用いて解く

$k$ は多くとも6まで
$E(\mathbb{F}_{p^k}^*)\cong\mathbb{Z}_{c_1n_1}\oplus\mathbb{Z}_{c_2n_1}$

