---
title: "中国剰余定理"
permalink: /snippets/crt
writer: anko9801
layout: library
---

## 説明

Garnerのアルゴリズム

## 計算量

$O(n^2 + n\log(\max p_i))$

## 実装

```cpp
#include <vector>

// x % m[i] = r[i] % m[i] を満たす正で最小の x を返す
// mは互いに素であると仮定
// とりあえず解の存在判定は保留
template <typename T>
T CRT(std::vector<T> r, std::vector<T> m) {
  ll n = r.size();
  ll m_prod = 1;
  ll x = r[0] % m[0];
  for (ll i = 1; i < n; i++) {
    m_prod *= m[i - 1];
    ll t = ((r[i] - x) * invmod(m_prod, m[i])) % m[i];
    if (t < 0)
      t += m[i];
    x += t * m_prod;
  }
  return x;
}
```

## 使用例
