---
title: ðª´ ãããHex
enableToc: false
---

# ayame library

# ããã¯ãªã«ï¼

CTFã®ã©ã¤ãã©ãª/ç¥è­éãããã§ãã(ç¾å¨ã¯LYTã«è¿ãææ³ã§æ¸ãã¦ã)

ç«¶ãã­ã¯ã©ã¤ãã©ãªåããããã®ãããåºåã£ã¦ããã©ãCTFã®æ¹ã¯ã»ã¨ãã©éããå ´æã§ããå±æããã¦ãªãããªï½ã¨æã£ãã®ã§ããã(å°æ¥çã«traPã®CTFç­)ãCTFã«é¢ããã©ã¤ãã©ãªãCTFã«å¿è¦ãªç¥è­ãã¾ã¨ãããã®ã§ããç·¨éãããæ¹ã¯å¤§æ­è¿ã§ãï¼æ°è»½ã«ãã«ãªã¯æãã¦ãã ããï½

ãããã¯CC0ã©ã¤ã»ã³ã¹ã¨ãã¾ããèªç±ã«ã³ãããã¦OKã§ãï¼

## ãã¼ã¿æ§é 

- [UnionFind](./data_structure/unionfind/unionfind.md)
  - [ããã³ã·ã£ã«ä»ãUnionFind](./data_structure/unionfind/potential_unionfind.md)
  - [æ°¸ç¶UnionFind](./data_structure/unionfind/persist_unionfind.md)
- [BIT (Binary-Indexed-Tree) / Fenwick Tree](./data_structure/bit/bit.md)
- [ã»ã°ã¡ã³ãæ¨](./data_structure/segtree/segtree.md)
  - [éå»¶ã»ã°ã¡ã³ãæ¨](./data_structure/segtree/lazysegtree.md)
  - [Segment Tree Beats](./data_structure/segtree/segtreebeats.md)
- å¹³è¡¡äºåæ¢ç´¢æ¨
  - èµ¤é»æ¨
  - AVLæ¨
  - Splayæ¨
  - Treap
- Wavelet Matrix
- åº§æ¨å§ç¸®
- [slope trick](./data_structure/slope_trick.md)

## ã°ã©ã

- æç­è·¯
  - [åä¸å§ç¹æç­è·¯ $O(E\log V)$ (Dijkstra)](./graph/shortest_path/dijkstra.md)
  - [åä¸å§ç¹æç­è·¯ $O(EV)$ (Bellman-Ford)](./graph/shortest_path/bellman_ford.md)
  - k-æç­è·¯
  - [å¨ç¹å¯¾éæç­è·¯ $O(V^3)$ (Floyd Warshall)](./graph/shortest_path/floyd_warshall.md)
  - å¨ç¹å¯¾éæç­è·¯ $O((V + E)V\log V)$ (Johnson)
- å¨åæ¨
  - æå°å¨åæ£® (Kruskal)
  - è¡åæ¨å®ç
- ãã­ã¼
  - [æå¤§æµ (Dinic)](./graph/flow/dinic.md)
  - [æå¤§æµ (Ford Fulkerson)](./graph/flow/ford_fulkerson.md)
- ãããã³ã°
  - äºé¨ã°ã©ãå¤å®
  - æå¤§ãããã³ã°
- ããªã¼
  - [æ¨ã®ç´å¾](./graph/tree/diameter.md)
  - æå°å±éç¥å
- Functional Graph
- æå¤§ã¯ãªã¼ã¯
- [å¼·é£çµæååè§£](./graph/scc.md)

## ç®æ°

- modulo
  - [Modint](./arithmetic/modulo/modint.md)
  - [ä»»æModint](./arithmetic/modulo/arbitrary_modint.md)
  - sqrt (Tonelli Shanks)
- é²æ°å¤æ
- [gcd / lcm / æ¡å¼µ Euclid ã®äºé¤æ³](./arithmetic/gcd.md)
- [ä¸­å½å°ä½å®ç](./arithmetic/crt.md)
- ã¹ã©ã¤ãæå°å¤
- floor sum
- è¡åæ¼ç®
  - [è¡å](./arithmetic/matrix/matrix.md)
  - LUåè§£
  - åºæå¤ã»åºæãã¯ãã«
- ç´ æ°
  - [ç´ å æ°åè§£](./arithmetic/primes/factorize.md)
  - [é«éç´ å æ°åè§£ (Pollard-$\rho$æ³/Millar-Rabin)](./arithmetic/primes/fast_factorize.md)
  - ç´ æ°å¤å®
  - [ç´ æ°åæ (ã¨ã©ãã¹ããã¹ã®ç¯©)](./arithmetic/primes/primes.md)
- [é«éã¼ã¼ã¿å¤æ/é«éã¡ãã¦ã¹å¤æ](./arithmetic/zeta.md)
- [é«éãã¼ãªã¨å¤æ(FFT)](./arithmetic/fft.md)
- [æ°è«å¤æ(NTT)](./arithmetic/ntt.md)
- å¤é å¼GCD
- å½¢å¼çåªç´æ°
- ä»»æmodç³ã¿è¾¼ã¿
- æ°è«çé¢æ°
  - ãªã¤ã©ã¼ã®$\phi$é¢æ°
  - ã¡ãã¦ã¹ã®$\mu$é¢æ°
  - ã«ã¼ãã¤ã±ã«ã®$\lambda$é¢æ°

## å¹¾ä½

- [å¹¾ä½ã©ã¤ãã©ãª](./geometry/geometry.md)
- åè§ã½ã¼ã

## æå­å

- Z algorithm
- Rabin-Karp æ³
- æé·å¢å é¨åå
- ã­ã¼ãªã³ã°ããã·ã¥
- Boyer-Moore
- LL(1) parser

## ãã¥ã¼ãªã¹ãã£ãã¯

- [å±±ç»ãæ³](./heuristic/hill_climbing.md)
- [ç¼ããªã¾ãæ³](./heuristic/simulated_annealing.md)
- [ãã¼ã ãµã¼ã](./heuristic/beam_search.md)
- [chokudai ãµã¼ã](./heuristic/chokudai_search.md)

## Pwn

ä½¿ç¨è¨èªã¯Pythonã¾ãã¯Cè¨èªã§ãã

- Format String Attack
- Stack Exploit
  - ret2xxx
    - ret2libc
  - ROP: Return Oriented Programming
- GOT overwrite
- glibc
  - [malloc](./pwn/malloc.md)
- Heap Exploit
  - tcache poisoning
  - tcache double free
  - fastbin attack
  - House of XXX
    - [House of botcake](./pwn/HouseOfXXX/House_of_botcake.md)
    - House of Orange
    - House of Spirit
    - House of Lore
    - House of Storm
    - House of Force
  - overlapping chunks
  - mmap overlapping chunks
- Kernel Code Reading
- [Kernel Exploit](./pwn/kernel_exploit.md)
  - Heap Spray
  - Dirty Pipe
- [Automatic Exploit Generation](./pwn/AEG.md)

## Crypto

ä½¿ç¨è¨èªã¯Pythonã¾ãã¯SageMathã§ããããããã®æå·èªä½ãåãæ±ãã®ã§ã¯ãªããCryptoã®èæ¯ã«ããçè«ãåãæ±ã£ã¦ããã¾ãã

- æå·æ§æåºç¤
  - [Diffie-Hellman éµäº¤æ](./crypto/cryptography/Diffie-Hellman.md)
  - Fiat-Shamir å¤æ
    - [Schnorr ç½²å](./crypto/cryptography/Schnorr.md)
    - Frozen Heart
  - Lamport ç½²å
  - [ã¼ã­ç¥è­è¨¼æ](./crypto/cryptography/ZeroKnowledgeProof.md)
  - [Fujisaki-Okamoto Transformation](./crypto/cryptography/Fujisaki-Okamoto_Transformation.md)
  - [æºååæå·](./crypto/cryptography/homomorphism.md)
- [æ ¼å­](./crypto/Lattice/tour_of_Lattice.md)
  - [Gram-Schmidt](./crypto/Lattice/GSO.md)
  - SVP (Shortest Vector Problem)
    - [Lagrange åºåºç°¡ç´ (Gauss åºåºç°¡ç´)](./crypto/Lattice/Lagrange.md)
    - [ãµã¤ãºåºåºç°¡ç´](./crypto/Lattice/size_reduction.md)
    - [LLL åºåºç°¡ç´](./crypto/Lattice/LLL.md)
    - BKZ åºåºç°¡ç´ / HKZ åºåºç°¡ç´
    - Kannanâs embedding method
  - CVP (Closest Vector Problem)
    - Babaiâs Algorithm
  - Merkle-Hellmanããããµãã¯æå·
    - LOæ³
    - CLOSæ³
  - LWE (Learning with Errors) æå·
    - LWE
      - BDD (Bounded Distance Decoding) Attack
      - SIS (Short Integer Solution) Attack
      - BKW Attack
      - Arora-Ge Attack
    - Ring-LWE
    - Module-LWE
      - CRYSTALS
    - LWR
  - [TFHE (Torus Fully Homomorphic Encryption)](./crypto/Lattice/TFHE.md)
- å¤é å¼
  - [Coppersmith Method](./crypto/coppersmith.md)
  - ã°ã¬ããã¼åºåº
  - çµçµå¼
  - MQ åé¡
  - Matsumoto-Imai æå· / HFE æå·
  - NTRU æå·
  - Rainbow ç½²å
  - UOV ç½²å / QR-UOV ç½²å
- æ°è«
  - ãã£ãªãã¡ã³ãã¹æ¹ç¨å¼
    - äºå¹³æ¹å
    - ãã«æ¹ç¨å¼
  - [é¢æ£å¯¾æ°åé¡ (DLP)](./crypto/DLP/DLP.md)
    - [Baby-step Giant-step](./crypto/DLP/BSGS.md)
    - [Pollard's rho æ³](./crypto/DLP/Pollard_rho.md)
    - ææ°è¨ç®æ³ (Index Calculus Algorithm)
    - æ°ä½ãµããæ³
    - [Pohlig-Hellman](./crypto/DLP/Pohlig_Hellman.md)
- [RSAæå·](./crypto/RSA/RSA.md)
  - [Wiener's Attack](./crypto/RSA/WienersAttack.md)
  - [Boneh-Durfee Attack](./crypto/RSA/Boneh-DurfeeAttack.md)
  - [Common Modulus Attack](./crypto/RSA/CommonModulus.md)
  - [HÃ¥stad's Broadcast Attack](./crypto/RSA/HÃ¥stadsBroadcastAttack.md)
  - [Small Common Private Exponent Attack](./crypto/RSA/SmallCommonPrivateExponentAttack.md)
  - [é©å¿çé¸ææå·ææ»æ](./crypto/RSA/RSA-CCA.md)
  - [LSB Decryption Oracle Attack](./crypto/RSA/LSB-DecryptionOracleAttack.md)
  - [RSA-CRT Fault Attack](./crypto/RSA/RSA-CRT-FaultAttack.md)
  - [Franklin-Reiter Related Message Attack](./crypto/RSA/Franklin-ReiterRelatedMessageAttack.md)
  - [Partial Key Exposure Attack](./crypto/RSA/PartialKeyExposureAttack.md)
  - [éåãå­å¨ããªãã¨ã](./crypto/RSA/NoInverse.md)
  - ROCA Attack
- [æ¥åæ²ç·æå·](./crypto/ECC/ECC.md)
  - æ¥åæ²ç·
    - Millar ã®ã¢ã«ã´ãªãºã 
    - Schoof ã®ã¢ã«ã´ãªãºã 
    - Tate pairing / Weil pairing
    - [ECFFT](./crypto/ECC/ECFFT.md)
    - è¶æ¥åæ²ç·
  - æ»æ
    - [Pohlig-Hellman Attack](./crypto/ECC/Pohlig-Hellman.md)
    - [MOV/FR Reduction](./crypto/ECC/MOV-FR-Reduction.md)
    - [SSSA Attack](./crypto/ECC/SSSA-Attack.md)
    - [Invalid Curve Attack](./crypto/ECC/Invalid-Curve-Attack.md)
    - [GHS Attack](./crypto/ECC/GHS-Attack.md)
    - Dual EC DRBG
- [AES](./crypto/AES/AES.md)
  - Padding Oracle Attack
  - BEAST Attack
  - Lucky Thirteen Attack
  - POODLE Attack
  - ghash
  - Integral Cryptanalysis
- [ãã®ä»ã®æå·](./crypto/cryptography/other.md)
- [Hash](./crypto/Hash/hash.md)
  - èªçæ¥æ»æ
  - Differencial cryptanalysis
- çä¼¼ä¹±æ°çæå¨ (PRNG)
  - Xorshift
  - [Mersenne twister](./crypto/PRNG/MersenneTwister.md)
- ãã­ãã¯ãã§ã¼ã³
  - Flash Loan Attack
- [åèæç®](./crypto/books.md)

## Web

Webã«é¢ãã¦ã¯ãããããªã®ã§èª­ã¿è¾¼ãã¨è¯ããããããªãè³æãªã¹ããéãã¦ãã¾ãã(ããèª­ãã¨ãããã¿ãããªã®ããã£ããæãã¦ãã ããã¨å©ããã¾ãï¼)

- [Prototype Pollution](./web/PrototypePollution.md)
- [CTFã«ãããWebã»ã­ã¥ãªãã£å¥éã¨ã¾ã¨ã](https://blog.hamayanhamayan.com/entry/2021/12/01/194114)
- å¸¸è¨­Webå
  - [Web Security Academy](https://portswigger.net/web-security/all-labs)
  - [KENRO](https://kenro.flatt.tech)
  - [wargame.kr](http://wargame.kr)
  - [XSS Game](https://xss-game.appspot.com)
  - [The Lord of the SQLI](https://los.rubiya.kr)
- [SQL Injection list](https://github.com/payloadbox/sql-injection-payload-list)

## Misc

- [Pyjail](./misc/Pyjail.md)
- [forensics](./misc/forensics/forensics.md)
  - [Windows](./misc/forensics/windows.md)
- [osint](./misc/osint/tools.md)

## éå­ã¢ã«ã´ãªãºã 

- åã²ã¼ãã®ç´¹ä»ã¨éå­è¨ç®ã®æ¹æ³
- Shor ã®ã¢ã«ã´ãªãºã 
- éå­æå·éä¿¡
- éå­ä¸­ç¶ãããã¯ã¼ã¯

## é»å­åè·¯

- SDR
- SPI
- JTAG

## èå¼±æ§é

- [CVEs for the Rust standard library](https://rustrepo.com/repo/Qwaz-rust-cve-rust-security-tools)
  - [Rustã®unsound hole issue #25860ãçè§£ãã](https://speakerdeck.com/moratorium08/rustfalseunsound-hole-issue-number-25860woli-jie-suru)
  - [str::repeat - stable wildcopy exploit](https://saaramar.github.io/str_repeat_exploit/)

## éå­¦

- ããã­ã³ã°
- Tamper Evident
- Social Engineering
- Car Hacking
- èªç©ºæè¡
- æ§é æ¢æ¤é
  - [ELF](./other/Application/Structure/ZIP.md)
  - JPEG
  - [FAT32](./other/Application/Structure/FAT32.md)
  - [ZIP](./other/Application/Structure/ZIP.md)
- [CPU / GPU](./other/Application/Processor.md)
  - Spectre / Meltdown
  - [TEE](./other/Circuit/TEE.md)
- [rootkit](./other/Circuit/Rootkit.md)
- ä»®æ³åæè¡
  - [ã³ã³ããä»®æ³åæè¡](./other/Application/Container.md)
  - [ãã¤ãã¼ãã¤ã¶ã®ä½ãæ¹](https://syuu1228.github.io/howto_implement_hypervisor/)
- bit trick
  - XOR swap
- [ãã­ã°ã©ãã³ã°è¨èª](./other/Application/Programming.md)
  - [åæ¨è«](./other/Application/Type.md)
- æªå®ç¾©åä½
- [ãããã¬](./pwn/Debugger.md)
- [OS](./other/Application/OS.md)
- ãµã¼ãã¼
  - [ãã¼ã¿ãã¼ã¹](./other/Application/Server/RDBMS.md)
  - [ãªãã¼ã¹ãã­ã­ã·](other/Application/Server/ReverseProxy.md)
  - [é«éå](./other/Application/Server/fast.md)
- [ãããã¯ã¼ã¯æ§æ](./other/Application/Network/network.md)
  - [SDR](./other/Application/Network/SDR.md)
- [SAT/SMT](./other/Application/SAT-SMT/SAT-SMT.md)
  - [ã·ã³ããªãã¯å®è¡ã¨ã³ã¸ã³](./other/Application/SAT-SMT/symbolic_execution.md)
  - [å®çè¨¼ææ¯æ´ç³»](./other/Application/SAT-SMT/proof_assistant.md)
- [ã¬ã³ããªã³ã°](./other/Application/Rendering/Rendering.md)
  - [ã¬ã¤ãã¬ã¼ã·ã³ã°](./other/Application/Rendering/RayTracing.md)
  - [ã·ã§ã¼ãã¼](./other/Application/Rendering/Shader.md)
- [ãã­ãã¯ãã§ã¼ã³](other/Application/Blockchain.md)
- [Deep Learning](./other/Application/DeepLearning.md)
- [ãç»åå¦çå¥éãã¢ã«ã´ãªãºã ï¼ãã­ã°ã©ãã³ã°](https://algorithm.joho.info/programming/image-processing/)
- è¶è§£å
- [é«éå](./other/fast.md)

## ãã³ãã¬ã¼ã

- [ç«¶ãã­](template.md)
- [ãã¥ã¼ãªã¹ãã£ãã¯](./heuristic/heuristic.md)
- [pwn](./pwn/pwn.md)
- [Kernel exploit](./pwn/kernel_exploit.md)
- [SageMathãã¼ãã·ã¼ã](./crypto/sagemath.md)
