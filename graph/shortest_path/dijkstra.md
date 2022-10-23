---
title: "単一始点最短路 (Dijkstra)"
permalink: /snippets/dijkstra
writer: anko9801
layout: library
---

## 説明

有向グラフに負の辺が存在しないとき次の事がいえる。
「まだ最短距離が確定していない点の中で、始点からの距離が最小 $\iff$ 最短距離として確定」

## 計算量

疎グラフ ヒープを用いる $O(E\log{V})$
密グラフ 単純に探索 $O(V^2)$

## 実装

```cpp
#include <queue>
#include <vector>

using ll = long long;
using pll = std::pair<ll, ll>;
template <class T>
using pq = std::priority_queue<T, std::vector<T>, std::greater<T>>;

const long long LINF = 0x1fffffffffffffff;

struct Edge {
  int to, cost;
};

int V;
std::vector<ll> d;
std::vector<std::vector<Edge>> G;

void dijkstra(int s) {
  pq<pll> q;
  for (int i = 0; i < V; i++) d[i] = LINF;
  d[s] = 0;
  q.push({d[s], s});

  while (!q.empty()) {
    auto [dist, p] = q.top();
    q.pop();
    if (d[p] < dist) continue;
    for (auto &e : G[p]) {
      if (d[e.to] > d[p] + e.cost) {
        d[e.to] = d[p] + e.cost;
        q.push({d[e.to], e.to});
      }
    }
  }
}
```

## 使用例


