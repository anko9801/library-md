# プログラミング言語入門

任意の実行はデータとアクションで構成されている。
それを人間にとってわかりやすく書きやすい形にするがプログラミング言語が必要とされる理由であり、データとアクションの関係性における多様なデザインがプログラミング言語の多様性の理由である。

データとアクションの関係性はロジックや階層構造によって表現される。
そして計算モデルに意味を与える意味論的な解釈を取り込みつつ解説する。

最初は抽象的で簡単なところから始まり、具体的で難しい問題に立ち向かう。
対象者
- 任意の言語を素早く習得したい方
- 基礎から理解して安心したい方
- 新しい言語を実装したい方

情報に踊らされずちゃんと軸を持つには論理で情報を作り出さないといけない。

## 第一章 型

TODO: なぜここで型を説明するのか
馴染み深いから？前提知識として持っていないと抽象論を展開できないから？あいまいな定義や同義な言葉が各言語にあるのでまとめて扱う為に一回必要

ここでは公理的に計算するところはつまらんので省いて、なるべく実践的、アイデアが得られる点を紹介する。何故かというと私は現実に絡まない計算をつまらなく感じて、現実に絡む抽象論をするのが好きだからです。不足分については型理論の方で説明します。($\lambda, \pi, \mu$ 計算, 線形型, Boehm-Berarducci encodingなど)

### データの表現方法
- 直積型 $A_1\times A_2$
ex.) 構造体, メソッドのないクラス, 配列, Vectorなど
- 直和型 $A_1+A_2$
ex.) Rustのenum
- ユニオン型 $A_1\cup A_2$
直和型とほぼ同じであるが、反例としてすべての型に null や undefined などがある TypeScript は直和型と同値ではない。
ex.) Cのunion
- 篩型 (refinement types) $\{x\in A\mid P(x)\}$
データに制約を持たせることができる。
実装を篩型に分け与えてシンプルに出来る
ex.) Liquid Haskell

### ロジックの表現方法
- 関数型 $f\colon A_1\to A_2 \to\ldots\to A_n \to R$
カリー化
- クラス $(A, f_1,\ldots,f_n)\,\mbox{s.t.}\,f_i\colon A\to\ldots\to R$

### 型の順序
順序、数でいう不等号を型に与えます。

- 関数と型の集合の部分集合として定義できる
部分型
$A_1 \subset A_1\cup A_2$
$A_1 \subset A_1\times A_2$
$(f_1, f_2) \subset (f_1)$

- 共変性 $A_1 \subset A_2 \implies I[A_1] \subset I[A_2]$
- 反変性 $A_1 \subset A_2 \implies I[A_1] \supset I[A_2]$
関数の引数
Goの継承とかが分かりやすいかな
$A_1\to R \supset A_2\to R$
`type X interface {F()}`
`type Y interface {F();G()}`
YがXのサブタイプ
- 双対性 共変かつ反変
- 非変性 どれでもない

### 型の構成と分類
- 依存型 $\Pi_{x\colon A}B(x)$
カインドのこと
- 依存和型 $\sum_{x\colon A}B(x)$
- Existential Type
- 型クラス trait $\{A\in\mathcal{U}\mid f_1,\ldots,f_n \in A\}$
- Row Type

### 型の意味を捉える
- モナド
自己関手の圏におけるモノイド対象
`(>>=) :: m a -> (a -> m b) -> m b`
`(>=>) :: (a -> m b) -> (b -> m c) -> (a -> m c)`
`f >=> g = \x -> f x >>= g`
`f :: a -> m a`
Effモナド
Affモナド
Free モナド
- コモナド

型レベル○○
型を用いてある代数と同値な型を定義すること
型レベル自然数
例えば $A_0 = A$, $A_{n+1}=A_0\times \ldots\times A_n$ と定義すると加算、減算、乗算、順序などを埋め込むことができ、自然数と同型な代数となる。
型レベル文字列
TypeScript にはもともとある。この依存型

### 継続
#### Continuation-Passing Style: CPS変換
#### call/cc

## 第二章 内部実装
コード解析などで解決する問題はよくNP完全な問題であることが多い。
内部実装を理解すれば、よりよい言語というのが分かってくるだろう。

### Stack & Heap

### 関数の実装

### 多相性 (polymorphism)
具体的に依存型を実装する多相性を紹介する。
アドホック多相 (ad hoc polymorphism)
オーバーロード
パラメータ多相 (parametric polymorphism)
静的に呼び出された関数の引数の型を解析して自動で実装する
サブタイピング多相 (subtyping polymorphism)
クラスの継承 オーバーライド

これらの実装にはディスパッチを用いる
静的ディスパッチ
動的ディスパッチ

### JIT

### 最適化
現代の主要なコンパイラの最適化は巨大となっているが最もクリティカルな8つの最適化を実装すれば最大80%の性能まで向上する。

SSA形式に落とし込むとCFGと単純な同値関係になり、グラフ理論を持ち込んでより深い最適化を考えられる。

#### インライン展開
#### ループ展開, ベクトル化
#### 共通部分式除去 (CSE; Common Subexpression Elimination)
#### デッドコード除去 (DCE; Dead Code Elimination)
#### コード移動
#### 定数畳み込み (Constant Fold)
#### Peephole最適化

[CompilerTalkFinal (venge.net)](http://venge.net/graydon/talks/CompilerTalk-2019.pdf)

### toolchain リンカ・ローダ
toolchainで紹介する。

### 動的ライブラリ


## 第三章 わかりやすいとミスカバー
思想が混じりやすい話題なので極力様々な意見を取り込むべき

わかりやすい 階層構造と情報隠蔽
ミスカバー コンパイルエラー

階層構造 import classの継承
情報隠蔽 カプセル化 private public

abstraction leak
うまく抽象化したつもりでも、どこかに必ず漏れが出てきてしまう

Result<Vec<>>
Vec<Result<>>

### オブジェクト指向

カプセル化 getter/setter
本来は、値引き判定のロジックをどのオブジェクトに配するかを決めるにあたって、どのような知識を隠蔽すべきか、あるいは裏返して言えば、どのような知識は開示して構わないかという点に思いをめぐらすべきでした。
解決策は、「データとロジックを一体に」という、どちらかというとゲームのルールのような具体的で単純なルールから視点を引き上げ、「情報隠蔽（＝知識隠蔽）」のような、より本質的な、目的志向的な設計原則に立ち帰って考えることです。
何を隠蔽して何を表に出すのかという設計判断
引数に関数を入れることもできる。このような特性を持つ言語を関数型言語と呼ぶ。
Visitorパターン

### 関数型言語

2階で十分なぜか

編集距離
幾何的

デバッグ

## 第四章 Immutable, Lifetime, Concurrency
機能
並列プログラミングは
ErlangVM

Concurrency
- coroutine
- async/await 並行
	- 裏でnode.jsが並列をしているから
	- node.js が single thread は本当だが嘘
	- event loop 1process
	- Golang event loop 複数のprocess
- Actor

async/await
async goroutine作ってchannel渡して
await channel待つ
channel の queue はeventloop のqueueと同じ感じ

async iterator
- Arc/Rc

意味論
happens-before 実行順序
data race free
sequentially consistent atomics(素直なatomics)
- Javaのvolatile, C++のdefault atomics, Goのsync/atomic, JavaScript

## 第五章 
