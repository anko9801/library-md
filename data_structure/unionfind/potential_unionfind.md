---
title: "ポテンシャル付きUnionFind"
permalink: /snippets/potential-unionfind
writer: anko9801
layout: library
---

## 説明

各頂点はポテンシャルを管理する。ポテンシャルの差がインターフェースとなる。重み付きUnionFindとも言う。

## 計算量

$O(\alpha(N))$

## 実装

```cpp
struct PotentialUnionFindTree {
  vec<ll> par, diff;

  PotentialUnionFindTree(ll n) {
    par.resize(n);
    diff.resize(n);
  }

  ll find(ll x) {
    if (par[x] == x) return x;
    ll r = find(par[x]);
    diff[x] += diff[par[x]];
    return par[x] = r;
  }

  ll weight(ll x) {
    find(x);
    return diff[x];
  }

  void unite(ll x, ll y, ll w) {
    w += weight(x);
    w += weight(y);
    x = find(x);
    y = find(y);
    par[y] = x;
    diff[y] = w;
  }
};
```

## 使用例

