# 型理論

Martin-Lof 型理論
Homotopy 型理論
Cubical 型理論

### 論理
最小述語論理+矛盾律 = 直観主義論理
直観主義論理+排中律 = 古典論理: ゲンツェンの自然演繹(NK)

### Curry-Howard 同型対応
|論理|プログラム|
|---|---|
|証明|型を構成するプログラム|
|論理式|型|
|ならば$\implies$|型 $P\to Q$|
|かつ $\land$|型 $P\times Q$|
|または $\lor$|型 $P+Q$|
|否定 $\lnot$|型 $P\to\bot$|
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

今はあんまり興味がなくなってHoTTについて勉強できてない
