# 型理論

型はグロタンディーク宇宙の中であることを断っておく。

### 論理
最小述語論理+矛盾律 = 直観主義論理
直観主義論理+排中律 = 古典論理: ゲンツェンの自然演繹(NK)


### 型無しラムダ計算
α-変換 : 束縛変数の名前は重要ではない
β-簡約 : 関数適用
η-変換 : 2つの関数について任意の引数を関数適用した値が等しいならば、2つの関数は等しい

領域理論

[SKIコンビネータで遊んでみよう - Qiita](https://qiita.com/Anko_9801/items/74af196cce123550001a)

### 型付きラムダ計算
型チェックが実行前に一度だけ行うこと

#### ラムダ・キューブ

![[Pasted image 20220925021333.png]]

- $\lambda\to$: 単純型付きラムダ計算
- $\lambda 2$: 二階命題論理 (System F)
パラメトリック多相, 全称型
- $\lambda\underline{\omega}$: 弱性高階命題論理
型演算子
直積型や多相カインドは型演算子の1つ
- $\lambda P$: 一階述語論理
依存型
依存型はせいぜいarray bound checkくらいにしか使えないだろう
- $F_{<:}$: 
サブタイプ
- $\lambda C$: Culculus of Constructions

### Curry-Howard 同型対応
|論理|プログラム|
|---|---|
|証明|型を構成するプログラム|
|論理式|型|
|ならば$\implies$|型 $P\to Q$|
|否定 $\lnot$|型 $P\to\bot$|
|かつ $\land$|型 $P\times Q$|
|または $\lor$|型 $P+Q$|
|モーダスポネンス|関数適用 $(a \to b) \to a \to b$|
|三段論法|関数合成 $(a \to b) \to (b \to c) \to (a \to c)$ |
|対偶|$(a\to b)\to(b\to\bot)\to(a\to\bot)$|
|直観主義論理|Calculus of Constructions|
|二階直観主義論理|System F|
|ゲンツェンの自然演繹(NK)|型付きラムダ計算|
|パースの法則$((P→Q)→P)→P$|call/cc|
|否定翻訳|CPS変換|

GATsはデータコンストラクタによって型を柔軟に指定出来る機能です。
call/cc

## 型理論
Martin-Lof 型理論
Homotopy 型理論
Cubical 型理論