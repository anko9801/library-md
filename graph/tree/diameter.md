---
title: "木の直径"
permalink: /snippets/tree-diameter
writer: anko9801
layout: library
---

## 説明

木の直径とはある2点間が最大となる距離である。

どの頂点から始めても、そこから最も遠い頂点は直径の端点の1つになる。端点から最も遠い頂点はもう1つの端点になる。その2点の距離が木の直径となる。

## 計算量

$O(V + E)$

## 実装

{% include cpp.html code="graph/tree/diameter.hpp" %}

## 使用例


