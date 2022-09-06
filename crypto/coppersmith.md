---
title: "Coppersmith Method"
permalink: /snippets/coppersmith
writer: anko9801
layout: library
---

## 説明

#### Thm. Howgrave-Grahamの補題
$N$ を法、 $g(x) \in \mathbb{Z}[x]$ を整数多項式とし、含まれる単項式の数を $\omega$ とする。$g(x)$ に対してある $X$ が存在し、$g(x_0) = 0 \pmod{N}$ なる $x_0 \in \mathbb{Z}$ について $|x_0| \leq X$ であると仮定する。このとき

$$
\|g(xX)\| < \frac{N}{\sqrt{\omega}}
$$

が成立するならば $g(x_0) = 0$ が整数方程式として成立する。ただし

$$
\|g(x)\| = \left\|\sum_{i=0}^{\deg g(x)}g_i\right\| = \sqrt{\sum_{i=0}^{\deg g(x)}g_i^2}
$$

であり、 $\deg g(x)$ は $g(x)$ の次数である。

証明

$$
\begin{aligned}
|g(x_0)| &= \left|\sum_{i=0}^{\deg g(x_0)}g_ix_0^i\right| \\
&\leq \sum_{i}|g_ix_0^i| \\
&\leq \sum_{i}|g_i|X^i \\
&= \sum_{i}(1\cdot|g_i|X^i) \\
&\leq \sqrt{\sum_{i, g_i \neq 0}1} \sqrt{\sum_{i}(|g_i|X^i)^2} && \left(\because \text{コーシー＝シュワルツの不等式}\right) \\
&= \sqrt{\omega}\|g(xX)\| < N && \left(\because \|g(xX)\| < \frac{N}{\sqrt{\omega}}\right)
\end{aligned}
$$

$g(x_0) = 0 \pmod N$ より $g(x_0) = 0$ となる。

-----

つまり、「剰余の方程式は係数がある程度小さければそのまま整数方程式となるよ」と言っています。ここで勘のいい人はLLLを用いて係数を小さくすれば整数方程式に変換できて解けるのでは...！？と気付くでしょう。実際に考えてみましょう。

とりあえず状況を整理すると、LLLに入れる値は各係数として、LLLを使う為には複数の方程式が必要になってきます。そしてそれらの方程式は同じ解を持つ必要があります。現在、その解が分からないのですが、どうしたらそんな方程式が作れるでしょうか。

実は $\bmod {N}$ では難しいので、$\bmod {N^m}$ に持ち上げることで同じ解の方程式を増やすことができます。

-----

#### Lemma
$N$ を法、$f(x)$ を多項式とする。自然数 $m, l$ について

$$
g_{i,j}(x) := N^{m−i}x^j f^i(x) \ (0 \leq i \leq m, 0 \leq j\leq l)
$$

とおく。このとき、 $f(x_0) = 0 \pmod N$ をみたす $x_0 \in \mathbb{Z}$ について、 $g_{i,j}(x_0) = 0 \pmod{N^m}$ となる。

証明

$f(x_0) = 0 \pmod N$ なので $f(x_0) = kN$ とおける。

$$
\begin{aligned}
g_{i,j}(x_0) &= N^{m−i}x_0^j f^i(x_0) \\
&= N^{m−i}x_0^j (kN)^i \\
&= k^ix_0^j N^m \\
g_{i,j}(x_0) &= 0 \pmod{N^m} \\
\end{aligned}
$$

-----

これで方程式を増やすことができました！ちゃんとLLLで動くかちょっと不安ですがとりあえずやってみます。

小さくしたい方程式は $g_{i,j}(xX)$ であることに注意して。
$g_{i,j}(x)$ の $k$ 次の係数のことを $g_{i,j}^{(k)}$ と表すことにします。

$$
\begin{pmatrix}
g_{0,0}^{(0)} & g_{0,0}^{(1)}X & g_{0,0}^{(2)}X^2 & g_{0,0}^{(3)}X^3 & g_{0,0}^{(4)}X^4 & g_{0,0}^{(5)}X^5 \\
g_{0,1}^{(0)} & g_{0,1}^{(1)}X & g_{0,1}^{(2)}X^2 & g_{0,1}^{(3)}X^3 & g_{0,1}^{(4)}X^4 & g_{0,1}^{(5)}X^5 \\
g_{1,0}^{(0)} & g_{1,0}^{(1)}X & g_{1,0}^{(2)}X^2 & g_{1,0}^{(3)}X^3 & g_{1,0}^{(4)}X^4 & g_{1,0}^{(5)}X^5 \\
g_{1,1}^{(0)} & g_{1,1}^{(1)}X & g_{1,1}^{(2)}X^2 & g_{1,1}^{(3)}X^3 & g_{1,1}^{(4)}X^4 & g_{1,1}^{(5)}X^5 \\
g_{2,0}^{(0)} & g_{2,0}^{(1)}X & g_{2,0}^{(2)}X^2 & g_{2,0}^{(3)}X^3 & g_{2,0}^{(4)}X^4 & g_{2,0}^{(5)}X^5 \\
g_{2,1}^{(0)} & g_{2,1}^{(1)}X & g_{2,1}^{(2)}X^2 & g_{2,1}^{(3)}X^3 & g_{2,1}^{(4)}X^4 & g_{2,1}^{(5)}X^5 \\
\end{pmatrix}
$$

これをLLLに通してあげると無事小さな値の方程式が返ってきます。これがHowgrave-Grahamの補題を満たしていれば整数方程式となります。後は増減表書いたりして探索すれば解けます。

これらの操作はCoppersmithの定理と呼ばれています。

---

#### Thm. Coppersmithの定理
$N$ を法とし $f(x)$ をモニックな 1変数 $\delta$ 多項式とする。このとき $f(x_0) = 0 \pmod{N}$ と次の条件を満たすような $x_0$ を効率よく求めることができる

$$
|x_0| \leq N^{\frac{1}{\delta}}
$$

---

さらにCoppersmithの定理には拡張できることが2つあります。

- 未知の法について解ける。素因数分解が出来ないほど大きな数を法としたときに既知の法の約数を法とする式の解を求められます。法が小さいほど方程式に対する制約がゆるくなります。
- 多変数の方程式も解ける。これは変数が1つだけでしたが、複数の変数でもできます。変数の数が多いほど方程式に対する制約がキツくなります。

これらは Howgrave-Grahamの補題 などを見直すことで簡単に拡張できます。興味ある方は考えてみてください。

これらをまとめてCoppersmith Methodと呼びます。

Berlekamp-Zassenhause法

## 実装

## 使用例

## 参考
- [元論文](https://static.aminer.org/pdf/PDF/000/192/854/finding_a_small_root_of_a_univariate_modular_equation.pdf)
- [katagaitai workshop 2018 winter](http://elliptic-shiho.github.io/slide/katagaitai_winter_2018.pdf)
