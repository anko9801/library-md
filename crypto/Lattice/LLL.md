---
title: "LLL 基底簡約"
---

## 説明

$n$ 次元格子 $L$ の基底 $\lbrace\mathbf{b_1},\ldots,\mathbf{b_n}\rbrace$ について以下の条件を満たすとき、その基底は LLL 簡約されている (Lenstra-Lenstra-Lovasz(LLL)-reduced)と呼ぶ。

1. 基底 $\lbrace\mathbf{b_1},\ldots,\mathbf{b_n}\rbrace$ がサイズ簡約されている。
2. Lovasz条件: 任意の $2 \leq k \leq n$ に対して
   $$
   \delta\|\mathbf{b}_{k-1}^*\| \leq \|\pi_{k-1}(\mathbf{b}_{k-1})\|
   $$
   を満たす。ただし、各 $1 \leq l \leq n$ に対して、$\pi_l$ は $\mathbb{R}$-ベクトル空間 $\langle\mathbf{b} _1,\ldots,\mathbf{b} _{l-1}\rangle _\mathbb{R}$ の直交補空間への直交射影とする。

これに対し、LLL 基底簡約アルゴリズムは次のように行う。

1. サイズ簡約する。
2. Lovasz条件を満たすように隣り合う基底ベクトルを交換する。

基底ベクトルを交換した際に GSO ベクトルも更新しなければならない。高速化出来る。

さらに LLL について精度を上げたり、機能を拡張することができ、DeepLLLやMLLLなどの手法がある。

- LLL は隣り合う基底ベクトルのみを比較するが、DeepLLL は全ての基底ベクトルを比較する。
- MLLL は一次従属なベクトルでも適用できる。

## 計算量


## 実装

```
def LLL(B, delta):
    n = len(B)
    assert 1 / 4 < delta < 1
    B = matrix(B)
    i = 1
    G, mu = B.gram_schmidt()
    while i < n:
        for j in range(i - 1, -1, -1):
            print(i, j)
            if mu[i][j].abs() > 1 / 2:
                q = mu[i][j].round()
                B[i] -= q * B[j]
                mu[i] -= q * mu[j]
        if B[i].norm() >= (delta - mu[i][i - 1] ^ 2) * B[i - 1].norm():
            i += 1
        else:
            B[i - 1], B[i] = B[i], B[i - 1]
            mu = GSOUpdate(B, mu, i)
            i = max(i - 1, 1)
    return B


def GSOUpdate(B, mu, i):
    n = B.nrows()
    nu = mu[i][i - 1]
    b = B[i] + nu ^ 2 * B[i - 1]
    print(nu, B[i - 1], b)
    mu[i][i - 1] = nu * B[i - 1] / b
    B[i] = B[i] * B[i - 1] / b
    B[i - 1] = b
    for j in range(i - 1):
        mu[i - 1][j], mu[i][j] = mu[i][j], mu[i - 1][j]
    for k in range(i + 1, n):
        t = mu[k][i]
        mu[k][i] = mu[k][i - 1] - nu * t
        mu[k][i - 1] = t + mu[i][i - 1] * mu[k][i]
    return mu
```

## 使用例

```python
B = [vector([5, -3, -7]), vector([2, -7, -7]), vector([3, -10, 0])]
print(LLL(B, 0.8))
```

## 参考

