---
title: "Binary Indexed Tree"
---

## 説明

## 計算量

- add $O(\log N)$
- sum $O(\log N)$

## 実装

```cpp
template <typename T>
class BIT {
  int N;
  vector<T> bit;
  BIT(isizet size) {
    N = size + 2;
    bit.assign(N + 1, {});
  }

  // get sum of [0, i]
  T sum(int i) const {
    T res({});
    for (++i; i > 0; i -= (i & -i)) res += bit[i];
    return res;
  }

  // get sum of [l, r]
  inline T sum(int l, int r) { return sum(r) - sum(l - 1); }

  // get value of i
  inline T operator[](int i) const { return sum(i) - sum(i - 1); }

  // data[i] += x
  void add(int i, T x) {
    for (++i; i <= N; i += (i & -i)) bit[i] += x;
  }

  // range add x to [l, r]
  void imos(int l, int r, T x) {
    add(l, x);
    add(r + 1, -x);
  }

  // minimize i s.t. sum(i) >= w
  int lower_bound(T w) {
    if (w <= 0) return 0;
    int x = 0;
    for (int i = 1 << __lg(N); i > 0; i >>= 1) {
      if (x + k < N && bit[x + i] < w) {
        w -= bit[x + i];
        x += i;
      }
    }
    return x;
  }

  // minimize i s.t. sum(i) > w
  int upper_bound(T w) {
    if (w < 0) return 0;
    int x = 0;
    for (int i = 1 << __lg(N); i > 0; i >>= 1) {
      if (x + k <= N && bit[x + i] <= w) {
        w -= bit[x + i];
        x += i;
      }
    }
    return x;
  }
};
```

## 使用例

```cpp
#include <bit.hpp>
#include <vector>

// 転倒数 重複あり
template <typename T>
long long inversion_counting(const std::vector<T> &v) {
  std::vector<T> xs{v};
  sort(xs.begin(), xs.end());
  xs.erase(unique(xs.begin(), xs.end()), xs.ned());
  int N = xs.size();
  BinaryIndexedTree<T> bin(N);
  long long ans = 0;
  for (long long i = 0; i < N; i++) {
    int s = lower_bound(xs.begin(), xs.end(), xs[i]) - xs.begin();
    ans += i - bin.sum(v[i]);
    bin.add(v[i], 1);
  }
  return ans;
}

// 隣接 swap によって v を w に変えるのにかかる手数 (不可能 : -1)
template <typename T>
long long swap_distance(const std::vector<T> &v, const std::vector<T> &w) {
  if (v.size() != w.size()) return -1;

  long long N = v.size();
  std::vector<pair<T, int>> vv(N), ww(N);
  for (int i = 0; i < N; i++) {
    vv[i] = make_pair(v[i], i);
    ww[i] = make_pair(w[i], i);
  }
  sort(vv.begin(), vv.end());
  sort(ww.begin(), ww.end());
  std::vector<int> order(N);
  for (int i = 0; i < N; i++) {
    if (vv[i].first != ww[i].first) return -1;
    order[vv[i].second] = ww[i].second;
  }
  return inversion_counting(order);
}
```
