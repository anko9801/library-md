---
title: "行列"
---

## 説明


## 計算量


## 実装

```cpp
#include <bits/stdc++.h>
#include <gcd.hpp>
using namespace std;

using ll = long long;
using ull = uint_fast64_t;
using pll = pair<ll, ll>;
using i64 = int_fast64_t;
using u64 = uint_fast64_t;

const ll MOD = 1e9 + 7;
const ll MODD = 998244353;

ll invmod(ll a, ll mod) {
  ll x, y;
  extgcd(a, mod, x, y);
  x %= mod;
  if (x < 0)
    x += mod;
  return x;
}

constexpr ll mx = 4;
class Matrix {
public:
  using T = ll;
  T m[mx][mx];
  // コンストラクタ
  constexpr Matrix() noexcept {}
  // アクセス
  const T *operator[](const ll i) const { return m[i]; } // read
  T *operator[](const ll i) { return m[i]; }             // write
  // 演算
  inline constexpr Matrix &operator+=(const Matrix &x) noexcept {
    for (ll i = 0; i < mx; i++)
      for (ll j = 0; j < mx; j++)
        m[i][j] += x[i][j];
    return *this;
  }
  inline constexpr Matrix operator+(const Matrix x) const noexcept {
    return Matrix(*this) += x;
  }
  inline constexpr Matrix &operator-=(const Matrix &x) noexcept {
    for (ll i = 0; i < mx; i++)
      for (ll j = 0; j < mx; j++)
        m[i][j] -= x[i][j];
    return *this;
  }
  inline constexpr Matrix operator-(const Matrix &x) noexcept {
    return Matrix(*this) -= x;
  }
  // O(N^3)
  inline constexpr Matrix &operator*=(Matrix &x) noexcept {
    *this = *this * x;
    return *this;
  }
  inline constexpr Matrix operator*(Matrix &x) {
    Matrix c;
    for (ll i = 0; i < mx; i++)
      for (ll j = 0; j < mx; j++)
        for (ll k = 0; k < mx; k++) {
          T a = m[i][j] * x[j][k];
          c[i][k] += a;
        }
    return c;
  }
  // E^M O(N^3logM)
  inline constexpr Matrix pow(ll b) const noexcept {
    Matrix a = *this, c = E();
    while (b) {
      if (b & 1)
        c *= a;
      if (b >>= 1)
        a *= a;
    }
    return c;
  }
  inline constexpr Matrix static E() noexcept {
    Matrix a;
    for (ll i = 0; i < mx; i++)
      a[i][i] = 1;
    return a;
  }
  inline constexpr bool operator==(const Matrix &a) {
    bool flg = true;
    for (ll i = 0; i < mx; i++)
      for (ll j = 0; j < mx; j++)
        if (m[i][j] != a[i][j])
          flg = false;
    return flg;
  }
  // 行列とスカラの演算
  inline constexpr Matrix &operator+=(const T &a) {
    for (ll i = 0; i < mx; i++)
      for (ll j = 0; j < mx; j++)
        m[i][j] += a;
    return *this;
  }
  inline constexpr Matrix &operator-=(const T &a) {
    for (ll i = 0; i < mx; i++)
      for (ll j = 0; j < mx; j++)
        m[i][j] -= a;
    return *this;
  }
  inline constexpr Matrix &operator*=(const T &a) {
    for (ll i = 0; i < mx; i++)
      for (ll j = 0; j < mx; j++)
        m[i][j] *= a;
    return *this;
  }
  inline constexpr Matrix &operator/=(const T &a) {
    for (ll i = 0; i < mx; i++)
      for (ll j = 0; j < mx; j++)
        m[i][j] /= a;
    return *this;
  }
  inline constexpr Matrix operator+(const T &a) const {
    return Matrix(*this) += a;
  }
  inline constexpr Matrix operator-(const T &a) const {
    return Matrix(*this) -= a;
  }
  inline constexpr Matrix operator*(const T &a) const {
    return Matrix(*this) *= a;
  }
  inline constexpr Matrix operator/(const T &a) const {
    return Matrix(*this) /= a;
  }
  // 転置行列
  inline constexpr Matrix t() {
    Matrix m2;
    for (ll i = 0; i < mx; i++)
      for (ll j = 0; j < mx; j++)
        m2[i][j] = m[j][i];
    return m2;
  }

  inline constexpr void show() {
    for (ll i = 0; i < mx; i++) {
      for (ll j = 0; j < mx; j++) {
        if (j != 0)
          cout << " ";
        cout << m[i][j];
      }
      cout << endl;
    }
    return;
  }
};
```
```cpp

using D = double;
const D EPS = 1e-10;

// matrix
template<class T> struct Matrix {
    vector<vector<T> > val;
    Matrix(int n, int m, T x = 0) : val(n, vector<T>(m, x)) {}
    void init(int n, int m, T x = 0) {val.assign(n, vector<T>(m, x));}
    size_t size() const {return val.size();}
    inline vector<T>& operator [] (int i) {return val[i];}
};

template<class T> int GaussJordan(Matrix<T> &A, bool is_extended = false) {
    int m = A.size(), n = A[0].size();
    int rank = 0;
    for (int col = 0; col < n; ++col) {
        // 拡大係数行列の場合は最後の列は掃き出ししない
        if (is_extended && col == n-1) break;

        // ピボットを探す
        int pivot = -1;
        T ma = EPS;
        for (int row = rank; row < m; ++row) {
            if (abs(A[row][col]) > ma) {
                ma = abs(A[row][col]);
                pivot = row;
            }
        }
        // ピボットがなかったら次の列へ
        if (pivot == -1) continue;

        // まずは行を swap
        swap(A[pivot], A[rank]);

        // ピボットの値を 1 にする
        auto fac = A[rank][col];
        for (int col2 = 0; col2 < n; ++col2) A[rank][col2] /= fac;

        // ピボットのある列の値がすべて 0 になるように掃き出す
        for (int row = 0; row < m; ++row) {
            if (row != rank && abs(A[row][col]) > EPS) {
                auto fac = A[row][col];
                for (int col2 = 0; col2 < n; ++col2) {
                    A[row][col2] -= A[rank][col2] * fac;
                }
            }
        }
        ++rank;
    }
    return rank;
}

const int MAX_ROW = 510; // to be set appropriately
const int MAX_COL = 510; // to be set appropriately
struct BitMatrix {
    int H, W;
    bitset<MAX_COL> val[MAX_ROW];
    BitMatrix(int m = 1, int n = 1) : H(m), W(n) {}
    inline bitset<MAX_COL>& operator [] (int i) {return val[i];}
};

int GaussJordan(BitMatrix &A, bool is_extended = false) {
    int rank = 0;
    for (int col = 0; col < A.W; ++col) {
        if (is_extended && col == A.W - 1) break;
        int pivot = -1;
        for (int row = rank; row < A.H; ++row) {
            if (A[row][col]) {
                pivot = row;
                break;
            }
        }
        if (pivot == -1) continue;
        swap(A[pivot], A[rank]);
        for (int row = 0; row < A.H; ++row) {
            if (row != rank && A[row][col]) A[row] ^= A[rank];
        }
        ++rank;
    }
    return rank;
}

int linear_equation(BitMatrix A, vector<int> b, vector<int> &res) {
    int m = A.H, n = A.W;
    BitMatrix M(m, n + 1);
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) M[i][j] = A[i][j];
        M[i][n] = b[i];
    }
    int rank = GaussJordan(M, true);

    // check if it has no solution
    for (int row = rank; row < m; ++row) if (M[row][n]) return -1;

    // answer
    res.assign(n, 0);
    for (int i = 0; i < rank; ++i) res[i] = M[i][n];
    return rank;
}
```

## 使用例

