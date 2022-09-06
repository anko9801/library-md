ランダムオラクルモデル

- 選択平文攻撃(Chosen-plaintext attack; CPA)
- 適応的選択平文攻撃(Adaptive chosen-plaintext attack; CPA2)
- 選択暗号文攻撃(Chosen-ciphertext attack; CCA1)
- 適応的選択暗号文攻撃(Adaptive Chosen-ciphertext attack; CCA2)
- Side-channel attack


- 一方向性(Onewayness; OW)
	- 暗号文から平文を求めるのが困難
- 強秘匿性(; SS)
	- 暗号文から平文のどんな部分情報も漏れない
- 識別不可能性(Indistinguishability; IND)
	- 暗号文が平文AとBのどちらのものかを区別できない
- 頑強性(Non-Malleability; NM)
	- 暗号文が与えられた時、ある関係性を持った別の暗号文の生成が不可
