---
title: "Pohlig-Hellman Attack"
---

## 説明

中国剰余定理を用いて大きな群を複数の小さな群の直積に分ける。

楕円曲線暗号の楕円曲線の位数は細かく素因数分解できることが多い。

楕円曲線の位数 $\#E = p_1^{e_1}p_2^{e_2}\ldots p_k^{e_k}$ と素因数分解できる。$Q = dP$ となるとき次のように $d_i$ を置く。

$$
\begin{aligned}
d_1 &= d \pmod{p_1^{e_1}} \\
d_2 &= d \pmod{p_2^{e_2}} \\
&\vdots \\
d_k &= d \pmod{p_k^{e_k}} \\
\end{aligned}
$$

それぞれの $d_i$ について次のように書ける。

$$
d_i=z_0+z_1p_i+z_2p_i^2+\ldots+z_{e_i−1}p_i^{e_i−1} \pmod{p_i^{e_i}} \quad (∀k:z_k \in [0,p_i))
$$

ここで $P_{i,j}=\frac{\#E}{p_i^j}P, Q_i=\frac{\#E}{p_i^j}Q$ とおくと

$$
Q_{i,1} = d_{i,1}P_{i,1} = (z_0+z_1p_i+z_2p_i^2+\ldots+z_{e_i−1}p_i^{e_i−1})P_{i,1} = z_0P_i
$$

となり, $z_0 < p_i$ である $Q_i = z_0P_i$ についてDLPを解けば良い。

他については $Q_i' = (Q_i - z_0P_i) / p_i$ とおいて同様に解けると思っていたけど除算は ECC の DDH 問題から不可能っぽいので $p_i^{e_i}$ 全探索するしかないかも。

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
