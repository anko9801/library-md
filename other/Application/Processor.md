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

Read
Write

big.LITTLE processing

Deep Learning を用いた回路設計も行われている.
[Designing Arithmetic Circuits with Deep Reinforcement Learning | NVIDIA Technical Blog](https://developer.nvidia.com/blog/designing-arithmetic-circuits-with-deep-reinforcement-learning/)

## Intel SGX
[Intel SGX入門 - SGX基礎知識編 - Qiita](https://qiita.com/Cliffford/items/2f155f40a1c3eec288cf)


## 脆弱性
[Project Circuit Breaker](https://www.projectcircuitbreaker.com/)

### AEPIC Leak
最初のアーキテクチャ由来のCPUのバグ. インテル製10~12世代のCPUの脆弱性を利用して, プロセッサ本体から機密情報を漏洩させる。APIC MMIOでの未定義範囲のアクセスによりキャッシュ階層から古いデータを参照できる。APIC MMIOのアクセスには管理者権限が必要であるから安全であるが, Intel SGXのような管理者権限を持つ攻撃者からデータを守るようなシステムはリスクとなる。
未初期化メモリの読み取りのようなもの

[元論文](https://aepicleak.com/aepicleak.pdf)
https://github.com/IAIK/AEPIC
## Spectre

### Description
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

## MDS/Zombieload
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html

## TSX Asynchronous Abort
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html

## iTLB multihit

[ARM immediate value encoding (mcdiarmid.org)](https://alisdair.mcdiarmid.org/arm-immediate-value-encoding/)

RTDSC 命令
[How to Benchmark Code Execution Times on Intel IA-32 and IA-64 Instruction Set Architectures White Paper](https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/ia-32-ia-64-benchmark-code-execution-paper.pdf)

ABI
System V AMD64
[x86_64-abi-0.99.pdf (linuxbase.org)](https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf)

## ディスク
CrystalDisk
CrystalDiskMark
## スクリーン
ブラウン管
ニキシー管
液晶

GPGPU

Qualcomm Snapdragon 6 Gen 1
富岳
OS IHK/McKernel

## アーキテクチャ
RISC-V

## Bit

Integer Overflow ([CWE-190](https://cwe.mitre.org/data/definitions/190.html)) 整数の上限値を超えると下限値付近になる
Integer Underflow ([CWE-191](https://cwe.mitre.org/data/definitions/191.html)) 整数の下限値を下回ると上限値付近になる
Floating Point Underflow   [x + 0.25 - 0.25 = xが成り立たないxとは何か｜Rui Ueyama｜note](https://note.com/ruiu/n/ndd60f403e8f2)
Stack Overflow
Stack Underflow

