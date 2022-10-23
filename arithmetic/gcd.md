---
title: "最大公約数・最小公倍数"
---

## 説明

ユークリッドの互除法

## 計算量

$O(\log{N})$

## 実装

```cpp
template <typename T>
T gcd(T a, T b) {
  T r;
  while (b > 0) {
    r = a % b;
    a = b;
    b = r;
  }
  return a;
}

template <typename T>
T lcm(T a, T b) {
  return a / gcd(a, b) * b;
}

template <typename T>
T extgcd(T a, T b, T &x, T &y) {
  T g = a;
  x = 1;
  y = 0;
  if (b) {
    g = extgcd(b, a % b, y, x);
    y -= a / b * x;
  }
  return g;
}
```

## 使用例