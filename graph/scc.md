---
title: "強連結成分分解"
permalink: /snippets/scc
writer: anko9801
layout: library
---

## 説明

有向グラフにおいて、ある部分グラフが強連結であるとは任意の2点が互いに行き来可能であること。

深さ優先探索の帰りがけ順(トポロジカルソート順)に逆グラフを探索したときそれらが通る点は強連結成分となる。

## 計算量

$O(V + E)$

## 実装

{% include cpp.html code="graph/SCC.hpp" %}

## 使用例


