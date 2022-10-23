---
title: "Network"
---

# ネットワーク

1990年 10BASE-T

## Ethernet
米Xerox のパロアルト研究所(PARC)に所属していたロバート・メカトーフ氏によって発明された。
初期実験は3Mbps 現在は最大400Gbpsの規格がある
フレーム構造の規格 IEEE 802.3

## TCP/IP
### TCP BBR

## Network Interface Card: NIC

## Data Plane Development Kit: DPDK
ユーザー空間で NIC を操作するフレームワーク。
カーネルでの処理がオーバーヘッド。具体的には NIC へデータが到達したときの割り込みなど
Pull Mode Driver: PMD と呼ばれるポーリングベースの受信機構
ただしカーネルを通さない為、パケットキャプチャーが不可能
DPDK Nginx は Nginx に比べ約3倍高速[2]

1. [Linux Kernel vs DPDK: HTTP Performance Showdown | talawah.io](https://talawah.io/blog/linux-kernel-vs-dpdk-http-performance-showdown/)
2. [DPDK-NGINX vs NGINX: Tech Overview and Performance Testing - PLVision](https://plvision.eu/rd-lab/blog/sdn/dpdk-nginx-vs-nginx-tech-overview-and-performance-testing)
3. [Note, Accelerated Network Application | by dsugisawa | mixi developers](https://mixi-developers.mixi.co.jp/note-accelerated-network-application-2187939f05dd)

## kTLS
カーネルにTLS (Transport Layer Security)を実装し, カーネル空間とユーザー空間のコピーの必要性を大幅に減らし, パフォーマンス向上させる。

VPoE

Rougue Access Point

## 輻輳制御アルゴリズム

sessionはどういう仕組みなのか
