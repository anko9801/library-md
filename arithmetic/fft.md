---
title: "高速フーリエ変換 (FFT)"
permalink: /snippets/fft
writer: anko9801
layout: library
---

## 説明

FFTはDFTを高速にしたもの。

## 計算量

$O(N\log{N})$

## 実装

```cpp
#include <complex>
#include <vector>

using namespace std;
using ll = long long;
using ld = long double;
using Complex = complex<ld>;
const ld PI = 3.1415926535897932;

vector<Complex> FFT(vector<Complex> &A) {
  const int N = A.size();
  vector<Complex> even(N / 2), odd(N / 2);
  for (int i = 0; i < N / 2; i++) {
    even[i] = A[2 * i];
    odd[i] = A[2 * i + 1];
  }
  even = FFT(even);
  odd = FFT(odd);
  for (int i = 0; i < N / 2; i++) {
    odd[i] *= polar(1.0L, 2 * PI * i / N);
    A[i] = even[i] + odd[i];
    A[N / 2 + i] = even[i] - odd[i];
  }
  return A;
}
```

## 使用例
