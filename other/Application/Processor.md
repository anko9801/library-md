# CPU

## 概要
CPU
- LGA
- BGA
- QFP
GPU
- iGPU(internal) CPU内にあるグラボ
- dGPU(discrete) NVMe/SATA/PCIeなどで接続する外付けのグラボ
- eGPU(external) Thunderbolt 3/4などで接続する外付けのグラボ
TPU 行列積演算
FPU

GPGPU

Qualcomm Snapdragon 6 Gen 1
富岳
OS IHK/McKernel

Read/Write
big.LITTLE processing

## CPU機能
[ARM immediate value encoding (mcdiarmid.org)](https://alisdair.mcdiarmid.org/arm-immediate-value-encoding/)

RTDSC 命令
[How to Benchmark Code Execution Times on Intel IA-32 and IA-64 Instruction Set Architectures White Paper](https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/ia-32-ia-64-benchmark-code-execution-paper.pdf)

ABI
System V AMD64
[x86_64-abi-0.99.pdf (linuxbase.org)](https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf)

## アーキテクチャ
RISC-V

## 回路
全加算器
Deep Learning を用いた回路設計も行われている.
[Designing Arithmetic Circuits with Deep Reinforcement Learning | NVIDIA Technical Blog](https://developer.nvidia.com/blog/designing-arithmetic-circuits-with-deep-reinforcement-learning/)

## ビット演算
Integer Overflow ([CWE-190](https://cwe.mitre.org/data/definitions/190.html)) 整数の上限値を超えると下限値付近になる
Integer Underflow ([CWE-191](https://cwe.mitre.org/data/definitions/191.html)) 整数の下限値を下回ると上限値付近になる
Floating Point Underflow   [x + 0.25 - 0.25 = xが成り立たないxとは何か｜Rui Ueyama｜note](https://note.com/ruiu/n/ndd60f403e8f2)
Stack Overflow
Stack Underflow

## 脆弱性
[Project Circuit Breaker](https://www.projectcircuitbreaker.com/)

### PACMAN
Apple M1 CPUのポインター
[PACMAN (pacmanattack.com)](https://pacmanattack.com/)

### Spectre
Branch Target Buffer: BPB
危険性

### Mitigation
#### Spectre-v1 SWAPGS
kernel parameter `nospectre_v1`
#### Spectre-v2 Retpoline
LFENCE/JMP
kernel parameter `nospectre_v2`
#### Spectre-v3 KPTI
kernel parameter
- `pti=off`
- `nopti`

-   `noibrs`
-   `noibpb`
-   `nospec_store_bypass_disable`
[KB4073119: Windows client guidance for IT Pros to protect against silicon-based microarchitectural and speculative execution side-channel vulnerabilities (microsoft.com)](https://support.microsoft.com/en-us/topic/kb4073119-windows-client-guidance-for-it-pros-to-protect-against-silicon-based-microarchitectural-and-speculative-execution-side-channel-vulnerabilities-35820a8a-ae13-1299-88cc-357f104f5b11)

### MDS/Zombieload
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html

### TSX Asynchronous Abort
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html

### iTLB multihit

## TEE
Trusted Execution Environment: TEE とはプロセッサ上に隔離された実行環境を用意することでセキュリティを高める技術です。
より広義にHIEE: Hardware-assisted Isolated Execution Environment
Normal Mode Secure Mode
- OSやアプリケーションの改竄を検知
- 公開鍵証明書による端末識別，認証
- ストレージデータの安全な暗号化
- ほぼほぼ暗号化処理をするため, 秘密鍵をそこにppm

Trusted Platform Module: TPM ハードウェアとして開発
[規格](https://trustedcomputinggroup.org/resource/tpm-library-specification/)
- Windows BitLocker
- [A Bad Dream](https://www.usenix.org/system/files/conference/usenixsecurity18/sec18-han.pdf)

須崎先生
Spectre見つけたProject Zero
android をdecrypt TEEを介さずに FBIでもできなかった
[Bits, Please!: Extracting Qualcomm's KeyMaster Keys - Breaking Android Full Disk Encryption (bits-please.blogspot.com)](http://bits-please.blogspot.com/2016/06/extracting-qualcomms-keymaster-keys.html)

### Intel SGX
本質とは？なぜ
Enclaveを持つ
Enclave では Ring 3 でしか動作しない, つまり syscall が使えない

![[Pasted image 20220927024448.png]]
[Intel SGX入門 - SGX基礎知識編 - Qiita](https://qiita.com/Cliffford/items/2f155f40a1c3eec288cf)
[Graphene-SGX](https://www.usenix.org/system/files/conference/atc17/atc17-tsai.pdf)

#### Remote Attestation
Remote AttestationはECDH上でCPU
[Intel SGX - Remote Attestation概説 - Qiita](https://qiita.com/Cliffford/items/095b1df450583b4803f2)

#### Foreshadow
CVE-2018-3615 - L1 Terminal Fault: SGX
CVE-2018-3620 - L1 Terminal Fault: OS/SMM、CVE-2018-3646 - L1 Terminal Fault: VMM
L1データキャッシュに存在するデータならなんでも読み取ることが可能

#### AEPIC Leak
最初のアーキテクチャ由来のCPUのバグ. インテル製10~12世代のCPUの脆弱性を利用して, プロセッサ本体から機密情報を漏洩させる。APIC MMIOでの未定義範囲のアクセスによりキャッシュ階層から古いデータを参照できる。APIC MMIOのアクセスには管理者権限が必要であるから安全であるが, Intel SGXのような管理者権限を持つ攻撃者からデータを守るようなシステムはリスクとなる。
未初期化メモリの読み取りのようなもの

[元論文](https://aepicleak.com/aepicleak.pdf)
https://github.com/IAIK/AEPIC

### ARM TrustZone
Cortex-A シリーズの拡張機能
ノーマルワールドとセキュアワールドそれぞれに特権/非特権モード
- [Boomerang](https://github.com/ucsb-seclab/boomerang/)
- [TrustZone Rootkit](https://security.inso.tuwien.ac.at/pdfs/woot22-preprint.pdf)
- [ARM TrustZone エクスプロイト入門 - Speaker Deck](https://speakerdeck.com/rkx1209/arm-trustzone-ekusupuroitoru-men)
- [Project Zero: Trust Issues: Exploiting TrustZone TEEs (googleprojectzero.blogspot.com)](https://googleprojectzero.blogspot.com/2017/07/trust-issues-exploiting-trustzone-tees.html)
- [SoK: Understanding the Prevailing Security Vulnerabilities in TrustZone-assisted TEE Systems | IEEE Conference Publication | IEEE Xplore](https://ieeexplore.ieee.org/document/9152801)

### RISC-V Keystone
- BOOM
- Speculative Attack

### Apple iOS E

### Android KeyMaster

