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

{% include cpp.html code="graph/shortest_path/dijkstra.hpp" %}

## 使用例


