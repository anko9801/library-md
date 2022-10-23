---
title: "サイズ基底簡約"
permalink: /snippets/size-reduction
writer: anko9801
layout: library
---

## 説明

$n$ 次元格子 $L$ の基底 $\\{\mathbf{b_1},\ldots,\mathbf{b_n}\\}$ を GSO 係数 $\mu_{i,j}$ が

$$
|\mu_{i,j}| \leq \frac{1}{2} \quad (1 \leq \forall j < \forall i \leq n)
$$

を満たすとき、基底 $\\{\mathbf{b_1},\ldots,\mathbf{b_n}\\}$ はサイズ簡約されているという。

## 計算量


## 実装

```python
def size_reduction(B):
    n = len(B)
    B = matrix(B)
    G, mu = B.gram_schmidt()
    for i in range(n):
        for j in range(i - 1, -1, -1):
            if mu[i][j].abs() > 1 / 2:
                q = mu[i][j].round()
                B[i] -= q * B[j]
                mu[i] -= q * mu[j]
    return B
```

## 使用例

```python
B = [vector([5, -3, -7]), vector([2, -7, -7]), vector([3, -10, 0])]
print(size_reduction(B))
```

## 参考

