---
title: "TEE"
permalink: /snippets/tee
writer: anko9801
layout: library
---

Trusted Execution Environment: TEE とはプロセッサ上に隔離された実行環境を用意することでセキュリティを高める技術です。
Normal Mode Secure Mode

- Intel SGX
- ARM TrustZone
- RISC-V Keystone

Trusted Platform Module: TPM
[規格](https://trustedcomputinggroup.org/resource/tpm-library-specification/)

- OSやアプリケーションの改竄を検知
- 公開鍵証明書による端末識別，認証
- ストレージデータの安全な暗号化

TEE CPUの機能
- Intel SGX
	- Remote Attestation
	- ForeShadow
- ARM TrustZone
	- [Boomerang](https://github.com/ucsb-seclab/boomerang/)
- RISC-V Keystone
	- BOOM
	- Speculative Attack
TPM (Trust) ハードウェアとして開発
- Windows BitLocker
- [A Bad Dream](https://www.usenix.org/system/files/conference/usenixsecurity18/sec18-han.pdf)

ほぼほぼ暗号化処理をするため秘密鍵をそこにppm

須崎先生

- [woot22-preprint.pdf (tuwien.ac.at)](https://security.inso.tuwien.ac.at/pdfs/woot22-preprint.pdf)
- [IAIK/AEPIC (github.com)](https://github.com/IAIK/AEPIC)
- [SoK: Understanding the Prevailing Security Vulnerabilities in TrustZone-assisted TEE Systems | IEEE Conference Publication | IEEE Xplore](https://ieeexplore.ieee.org/document/9152801)

Project Zero
Spectre見つけた
android をdecrypt TEEを介さずに FBIでもできなかった
[Project Zero: Trust Issues: Exploiting TrustZone TEEs (googleprojectzero.blogspot.com)](https://googleprojectzero.blogspot.com/2017/07/trust-issues-exploiting-trustzone-tees.html)
[Bits, Please!: Extracting Qualcomm's KeyMaster Keys - Breaking Android Full Disk Encryption (bits-please.blogspot.com)](http://bits-please.blogspot.com/2016/06/extracting-qualcomms-keymaster-keys.html)

NSA

[ARM TrustZone エクスプロイト入門 - Speaker Deck](https://speakerdeck.com/rkx1209/arm-trustzone-ekusupuroitoru-men)