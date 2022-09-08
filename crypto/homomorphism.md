
# 準同型暗号

加法準同型 ex. 岡本・内山, Paillier, Lifted-ElGamal
- 
乗法準同型 ex. RSA, ElGamal
- 
レベル準同型
- 乗算回数に制約がある完全準同型
- レベルnはn次方程式を計算できる
- レベル2準同型なら乗算が1度だけ可能
完全準同型 ex. Gentry, 格子ベース


## レベル2準同型暗号の構成
### Lifted-ElGamal暗号
位数 $p$ の楕円曲線 $E$, と生成元 $P\in E$
秘密鍵 $s\in\mathbb{F}_p$ と公開鍵 $sP$
平文 $m$ に対して乱数 $r$ をとり $c=(mP+rsP, rP)$
$c = (S, T)$ に対して $S-sT = (mP+rsP)-s(rP)=mP$ としDLPを解いて $m$ を得る

加法準同型性

$$
\begin{aligned}
\mathrm{Enc}(m_1)+\mathrm{Enc}(m_2) &= (m_1P+r_1sP,r_1P)+(m_2P+r_2sP,r_2P) \\
&= ((m_1+m_2)P, (r_1+r_2)sP, (r_1+r_2)P) \\
&= Enc(m_1+m_2)
\end{aligned}
$$

乗法準同型性

$\mathrm{Enc}(m_1)\times\mathrm{Enc}(m_2) := (e(S_1, S_2), e(S_1, T_2), e(T_1, S_2), e(T_1, T_2))$

$$
\begin{aligned}
\mathrm{Dec}(c_1,c_2,c_3,c_4) &= \frac{c_1c_4^{s_1s_2}}{c_2^{s_2}c_3^{s_1}} = \frac{e(S_1,s_2)e(s_1T_1,s_2T_2)}{e(S_1,s_2T_2)e(s_1T_1,S_2)} \\
&=e(S_1-s_1T_1,S_2-s_2T_2) \\
&=e(mP_1,m'P_2)=e(P_1,P_2)^{mm'}
\end{aligned}
$$

[ペアリングベースの効率的なレベル2準同型暗号（SCIS2018） (slideshare.net)](https://www.slideshare.net/herumi/2scis2018?next_slideshow=86572957)


$a, b$ から $g^a$ と $g^b$ という関係である 可解 $g^{ab}$
$g^a$ と $g^b$ から $g^{ab}$ を求める DH問題
