# まとめ
各単元を下の階層で証明する. ここでは重要な定義と本質をまとめる.

## 数学基礎論

## 集合論
- 全順序集合
- 同値類
- 濃度

## 群論
- 群・正規部分群
**群**: 単位元, 逆元のある結合的な演算を持つ集合
**ラグランジュの定理** $|G_1|=|G_2|(G_1:G_2)$
準同型
**準同型定理** $G/\Ker(\phi)\cong\Image(\phi)$
- 群の作用
**Sylow の定理** p-Sylow 部分群の数 $s=|G|/|N_G(H)|=1\pmod{p}$
**有限アーベル群の構造定理** $G\cong\ZZ/a_1\ZZ\times\ldots\times\ZZ/a_n\ZZ$

## 環・加群
- 環・イデアル
**環準同型定理** $A/\Ker(\phi)\cong\Image(\phi)$
- 多項式環
- 素イデアル・極大イデアル
**中国剰余定理**
- 局所化
- 一意分解環, 単項イデアル整域, ユークリッド環
環$\impliedby$可換環$\impliedby$整域$\impliedby$正規環$\impliedby$UFD(一意分解環)$\impliedby$PID(単項イデアル整域)$\impliedby$ユークリッド環$\impliedby$体
- 加群

## 体論
- 代数拡大・超越拡大
有限次拡大$\iff$有限生成の代数拡大
- 代数閉包
**Steinitz の定理**
- 分離拡大・正規拡大
既約な非分離多項式 $f(x)\in K[x]$ $\iff$$\ch K=p>0$ であり, 既約な分離多項式 $g(x)\in K[x]$ と $n>0$ があり, $f(x)=g(x^{p^n})$ となる.
- Galois 理論
**Galois の基本定理**

## 代数的整数論

## 代数幾何学

## 圏論
- 圏論の基本
**米田の補題** 
```tikz
\usepackage{tikz-cd}

\begin{document}
\begin{tikzcd}
    F(y) \arrow[r, "\phi(y)"] \arrow[d, "F(f)"] & G(y)=Hom_{Sets^{C^{op}}}(h_y,F) \arrow[d, "G(f)"] \\
    F(x) \arrow[r, "\phi(x)"] & G(x)=Hom_{Sets^{C^{op}}}(h_x,F)
\end{tikzcd}
\end{document}
```

## 楕円曲線
- pairing
