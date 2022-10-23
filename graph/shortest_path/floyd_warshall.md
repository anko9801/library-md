---
title: "全点対最短路 (Floyd-Warshall)"
---

## 説明

不安なら3回やればいい

## 計算量

$O(V^3)$

## 実装

```cpp
#include <vector>

std::vector<std::vector<int>> d;
int V;

void floyd_warshall() {
  for (int k = 0; k < V; k++)
    for (int i = 0; i < V; i++)
      for (int j = 0; j < V; j++) d[i][j] = std::min(d[i][j], d[i][k] + d[k][j]);
}
```

## 使用例


