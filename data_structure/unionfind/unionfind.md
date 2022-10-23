---
title: "UnionFind"
---

## 説明

素集合を管理するデータ構造。内部的には森となっていて同じルートを持つ木の要素は同じ素集合にあると解釈して併合/比較を行う。

以下の工夫により高速化できる。

- 経路圧縮 (path compression)
  再帰的に根を調べる際に根に直接つなぎ直す
- 併合の工夫
  併合時に木の高さ/大きさが小さい方を大きい方へ繋げる
  union by rank: 木の高さ
  union by size: 木の大きさ

## 計算量

経路圧縮のみ $O(\log{N})$
併合の工夫のみ $O(\log{N})$
両方 $O(\alpha(N))$

## 実装

```cpp
#include <vector>

struct UnionFind {
  std::vector<int> rank, parents;

  UnionFind() {}
  UnionFind(int n) {
    rank.resize(n + 1, 0);
    parents.resize(n + 1, 0);
    for (int i = 0; i < n + 1; i++) makeTree(i);
  }

  void makeTree(int x) {
    parents[x] = x;
    rank[x] = 0;
  }

  bool isSame(int x, int y) { return findRoot(x) == findRoot(y); }

  bool unite(int x, int y) {
    x = findRoot(x);
    y = findRoot(y);
    if (x == y) return false;
    if (rank[x] > rank[y]) {
      parents[y] = x;
    } else {
      parents[x] = y;
      if (rank[x] == rank[y]) rank[y]++;
    }
    return true;
  }

  int findRoot(int x) {
    if (x != parents[x]) parents[x] = findRoot(parents[x]);
    return parents[x];
  }
};
```

## 使用例

