---
title: "Tour of Lattice"
---

# 格子暗号を極める！

無限工事編

## はじめに

// TODO 説明
耐量子暗号です！あとはセキュキャンで話題のTFHEとか紹介したいな

これは大学1年で習う線形代数を前提知識として扱います。

- 量子アルゴリズムはどこで解説すべき？
	- 暗号関連で解説すべきなのはGroverとShorのアルゴリズムの2つだけやが量子コンピューター上の演算や量子フーリエが前提知識無しやとキツイかもしれん。
	- 量子コンピュータという題材で分けた方が良さそう？本に頼ればいいは一理あるが論文以外の文献は未だ少なく暗号専門の解説がほしいところ
	- 自分の文章力と時間に要相談ということで

## 格子 (Lattice)

図でイメージ掴むのが速い

線形独立な $n$ 個のベクトル $\mathbf{b}_1, \mathbf{b}_2, \ldots , \mathbf{b}_n \in \mathbb{R}^m$ について整数係数の線形結合によって生成されるベクトルの集合を格子 $L$ と定義します。

$$
L = \left\{ \sum_{i=0}^{n} a_i\mathbf{b}_i \ \middle| \ a_i \in \mathbb{Z} \right\}
$$

化学の格子っぽいもの

格子 $L$ に囲まれた空間を1つ
具体例

### 困難な問題

今回のキーとなる問題です

SVP
CVP

near SVP
near CVP

### LWE格子暗号

機械学習理論から派生した求解困難な問題で、有限体 $\mathbb{F}_q$ 上の秘密ベクトル $\mathbf{s} \in \mathbb{F}_q^n$ に関するランダムな連立線形「近似」方程式が与えられたとき、その秘密ベクトルを復元する問題である。




### Gram-Schmidt の直交化 (GSO: Gram-Schmidt Orthonormalization)

任意の $R$ ベクトル空間直交化
ベクトルをGSO化させることで任意の2つのベクトルの内積が0となる、つまり直交化できます。イメージは[Wikipedia](https://ja.wikipedia.org/wiki/%E3%82%B0%E3%83%A9%E3%83%A0%E3%83%BB%E3%82%B7%E3%83%A5%E3%83%9F%E3%83%83%E3%83%88%E3%81%AE%E6%AD%A3%E8%A6%8F%E7%9B%B4%E4%BA%A4%E5%8C%96%E6%B3%95)のgifがわかりやすいです。$\mathbf{b}_n$ の直交化は $\mathbf{b}_{1},\ldots, \mathbf{b}_{n-1}$ までと直行するように高さを保持しながら移動させる。

$$
\begin{aligned}
\begin{dcases}
\mathbf{b}_1^* = \mathbf{b}_1 \\
\mathbf{b}_i^* = \mathbf{b}_i - \sum\limits_{j=1}^{i-1} \mu_{i, j}\mathbf{b}_j^* \qquad \left( \mu_{i, j} = \frac{\langle \mathbf{b}_i, \mathbf{b}_j^* \rangle}{\| \mathbf{b}_j^* \|^2} \right) \\
\end{dcases}
\end{aligned}
$$

$$
\begin{aligned}
B &=
\begin{pmatrix}
\mathbf{b}_1 \\
\mathbf{b}_2 \\
\mathbf{b}_3 \\
\mathbf{b}_4 \\
\end{pmatrix}
& U &=
\begin{pmatrix}
1 & 0 & 0 & 0 \\
\mu_{2,1} & 1 & 0 & 0 \\
\mu_{3,1} & \mu_{3,2} & 1 & 0 \\
\mu_{4,1} & \mu_{4,2} & \mu_{4,3} & 1 \\
\end{pmatrix}
& B^* &=
\begin{pmatrix}
\mathbf{b}_1^* \\
\mathbf{b}_2^* \\
\mathbf{b}_3^* \\
\mathbf{b}_4^* \\
\end{pmatrix} \\
\end{aligned}
$$

$$
B = UB^*
$$

これらをGSOベクトル $\mathbf{b}_i^*$ , GSO係数 $\mu_{i, j}$ と呼びます。

具体例
### Shortest Vector Problem(SVP)

格子上の非零なベクトルの中で最もノルムが小さなベクトルを見つけ出す問題です。
そのベクトルを $\mathbf{v}$ とおくと次のように表せられます。

$$
\mathbf{v} = v_1\mathbf{b}_1 + \ldots + v_n\mathbf{b}_n \qquad (\exists v_1, \ldots , v_n \in \mathbb{Z}) \\
$$

この問題はNP困難

#### 最短ベクトルの数え上げ

まずは全探索してみます。
考えてみると帰納的に求めるのでは正確な最短ベクトルは求められないでしょう。
考えてみるとある基底 $\mathbf{b}_i$ に対し、それ以下の基底 $\mathbf{b}_1, \ldots \mathbf{b}_{i-1}$ で組み立てられたベクトル $\mathbf{v}$ に対し、$\mathbf{b}_i$ を用いて短くする

効率的に数え上げる為には基底簡約すると良いということが知られています。

#### Lagrange 基底簡約 (Gaussian Reduction)

サイズ基底簡約
GSO ベクトルを簡約 -> 基底ベクトルを簡約
GSO 係数 $μ_{i,j}$ について

$$
\|μ_{i,j}\| \leq \frac{1}{2} \qquad (\forall 0 \leq i < j < n)
$$

Euclid の互除法を用いて基底の簡約化をする。
具体例

#### LLL(Lenstra-Lenstra-Lovasz) 基底簡約

Lagrange 基底簡約に Lovasz 条件を追加した基底簡約を LLL 基底簡約と呼びます。
Lovasz条件 $\frac{1}{4} < \delta < 1$ として

$$
\delta \|b_{k-1}^*\|^2 \leq \|\pi_{k-1}(b_k)\|^2
$$

1. サイズ基底簡約
2. 条件に合うように基底ベクトルの交換

具体例

#### BKZ(Block Korkine-Zolotareff) 基底簡約

HKZ(Hermite-Korkine-Zolotareff) 基底簡約

1. サイズ基底簡約
2. 条件に合うように基底ベクトルの交換

具体例

### Closest Vector Problem(CVP)

#### Babai’s Algorithm

#### Kannan’s embedding method
