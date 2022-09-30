---
title: "焼きなまし法"
permalink: /snippets/simulated-annealing
writer: anko9801
layout: library
---

## 説明

[山登り法](../snippets/hill-climbing)は常にスコアが最大のものを採用するが、焼きなまし法では遷移確率関数を用いてスコアに応じて確率的に遷移させるようにする。

温度関数は最初は大きく、時間が経つにつれて小さくなるような関数で、温度が高いほど発散し、低いほど収束するように遷移確率関数を調整する。

## 実装

{% include cpp.html code="template/heuristic.cpp" %}

## 使用例


## 参考


