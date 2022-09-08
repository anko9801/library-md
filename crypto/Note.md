# Crypto in CTF writeup
[Crypto in CTF :: Mystify (mystiz.hk)](https://mystiz.hk/crypto-in-ctf/) を解いていく。

## Q3 2021

### [Pwn2Win CTF 2021] t00 rare
- ECDSAで署名/検証ができるが、特定のハッシュ値のときは不可
- $q=q_1q_2+1$ として秘密鍵が $x=(7^{q_2})^y$, $s=\frac{h+rx}{k}\iff P=\frac{h+rx}{s}G\iff g^yG=r^{-1}(sP-hG)$ である
- 特定のハッシュ値のとき $kP=G$ を求める

#### 解法
- $h+q$ でバイパス
- BSGSで $g^yG$ の $y$ を求める
- 高速なライブラリfastecdsaを使う

### [Pwn2Win CTF 2021] A2S
- AESのラウンドを10回から2回に変更

#### 解法


### [0CTF 2021 Quals] zer0lfsr-


