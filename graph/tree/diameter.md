---
title: "木の直径"
---

## 説明

木の直径とはある2点間が最大となる距離である。

どの頂点から始めても、そこから最も遠い頂点は直径の端点の1つになる。端点から最も遠い頂点はもう1つの端点になる。その2点の距離が木の直径となる。

## 計算量

$O(V + E)$

## 実装

```cpp
#include <vector>

template <typename T>
struct Edge {
  int to;
  T cost;
};

using Graph = std::vector<std::vector<Edge<long long>>>;

template <typename T>
std::pair<T, int> dfs(const Graph &G, int u, int par) {
  auto ret = {0, u};
  for (auto &e : G) {
    if (e.to == par) continue;
    auto next = dfs<T>(G, e.to, u);
    next.first += e.cost;
    ret = std::max(ret, next);
  }
  return ret;
}

template <typename T>
T tree_diameter(const Graph &G) {
  auto p = dfs(G, 0, -1);
  auto q = dfs(G, p.second, -1);
  return q.first;
}
```

## 使用例


