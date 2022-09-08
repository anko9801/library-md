
Hasse-Weil 定理より

$$
q+1-2\sqrt{q}\leq\#E(\mathbb{F}_q)\leq q+1+2\sqrt{q}
$$

$\#E(\mathbb{F}_q)=q+1+t$ とおける。$\mathbb{F}_q$ のフロベニウス写像 $\sigma$ のトレース $t$ を計算できれば位数が求まる。しかし $t$ は $2\sqrt{q}$ のオーダーであるため、直接計算できない。そこで素数 $l$ を剰余にとってそれぞれの $t$ の値を求め、中国剰余定理によって $t$ を求める。

具体的には特性多項式の $t$ に $0,\ldots,\frac{l-1}{2}$ の値を代入して確かめる。

$$
\begin{aligned}
\sigma_q^2-t\sigma_q+q &= 0 \\
\pm[t_l]\circ\sigma_q &= \sigma_q^2+[q_l]
\end{aligned}
$$

1つの $l$ 等分点 $P$ に対して成り立てばすべての $l$ 等分点に対して成り立つ。
