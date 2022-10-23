---
title: "RDBMS"
---

### isolation level
複数のトランザクションが1つのテーブルを操作するときの不整合についてどの程度許容するか
1. READ UNCOMMITTED ... COMMIT されてないトランザクションの変更を参照できる
2. READ COMMITTED ... COMMIT されたトランザクションの変更を参照できる
3. REPEATABLE READ ... COMMIT されたトランザクションの追加を参照できる
4. SERIALIZE ... 参照不可

2以降を実現する為には `SELECT` で共有ロック, `UPDATE` `INSERT` で専有ロックを取得すればよい. ロックの取得はパフォーマンスを下げるのでなるべくしたくない. そこでMVCC .

### MultiVersion Concurrency Controll: MVCC

- `DB_ROW_ID` ... 行ID
- `DB_TRX_ID` ... 最後にupdateしたトランザクションID
- `DB_ROLL_PTR` ... レコードの過去の値を持つundo log recordへのポインタ

参照トランザクションIDが `DB_TRX_ID` より大きいなら変更後の値を参照, 小さいなら undo log record から探して参照, 追加したトランザクションIDより小さいなら参照できない.

[MySQLのMVCC - Qiita](https://qiita.com/nkriskeeic/items/24b7714b749d38bba87b)


### 具体的にどんな処理がされているのか

工事中
:::spoiler
https://zenn.dev/tzkoba/articles/bb6d31d46be8b3


コネクションプール
クエリパーサ
クエリーキャッシュ
クエリプランナー
クエリエクスキュータ
アクセスメソッド
バッファプールマネージャ = ストレージエンジン?
ディスクマネージャ

[実行順序](https://qiita.com/k_0120/items/a27ea1fc3b9bddc77fa1)
FROM句
JOIN句
WHERE句
GROUP BY句
HAVING句
SELECT句
ORDER BY句
LIMIT句


アクセスメソッドCRUD

memcached
Redis

レプリケーション

テンポラリーテーブル

クラッシュリカバリ
Redundant Array of Independent Disks
RAID 0・RAID 1・RAID 5、およびこれら3方式の組み合わせが用いられている。後にRAID 5を拡張したRAID 6が定義され、RAID 5より耐障害性が必要な場面で利用されている。
二重書き込みバッファー
トランザクションログ

クラスタデータベース
セカンダリインデックス
キー　セカンダリキー　バリュー　プライマリーキー
クラスタードインデックス
テーブルをB+Treeに入れる

Memcomparable format

[ProxySQL](https://qiita.com/yoan/items/ba62dd65b24ac1b6a458)

シリアル　数字の羅列
シーケンス　順番に並ぶ数字列

負荷分散技術
水平分割(シャーディング)　レコード単位で分割
垂直分割　カラム単位で分割

ワークラウンド　回避策
ワークロード　仕事量

ストレージエンジン
データ変換
インデックス
メモリ利用
トランザクション
同時実行性(排他制御)
ユニークファンクション（MyISAMの空間情報インデックスなど）
innoDB : MySQLでもっとも汎用のストレージエンジン

ACID
A: 原子性
C: 一貫性
I: 分離性
D: 持続性

MySQL InnoDB memcached Plugin
https://qiita.com/hypermkt/items/ccfb47e69c4a6a3ce09a
プラグインって何のプラグイン？
これってmemcachedと何が違うの


MEMORY ストレージエンジン
https://dev.mysql.com/doc/refman/5.6/ja/memory-storage-engine.html
ストレージエンジンをMEMORYにするのはかなり注意が必要(NaruseJunがそれでメモリ使い果たして鯖爆破していたはず)

INVISIBLE COLUMNS \*でとりだされない
INSERT RETURNING
FOREIGN KEY https://www.dbonline.jp/mysql/table/index11.html
:::

### Collation(照合順序)
文字列をどうエンコーディングしてB+ツリーにどうソートして突っ込むかを設定できます。DB単位、テーブル単位、カラム単位で設定可能。

```
CREATE TABLE `utf8mb4_test`.`utf8mb4_test` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `str` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `str` (`str`(767))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
```
`文字コード_言語名_比較法`

#### 文字コード(Character Set)
utf8とかeucとかが入ります。
cp932やbig5などは危険なエンコーディングらしい(しらんけど)

conoHaがこれでやらかしていたらしい
traP SysAd TechBook より
データベースメンテナンスで⼤わらわ！

2019年8⽉6⽇夜 ConoHaのマネージドDBでメンテナンスがありました。SysAd班で
はメンテナンスの存在を知らず、急にtraQなどが機能しなくなったため⼀瞬混乱が起き
ました。しかしその後すぐ、@takashi_trapがメンテナンスであることをアナウンスし混乱
は収束しました。
しかし、本当の混乱はメンテナンス後に発⽣したのです。traQの復旧によりメンバー
がtraQに戻ってきたのですが、下のような投稿がいろんなチャンネルで出始めたので
す。
図2.6: 表⽰名が壊れたメンバーの投稿（修正後スクリーンショットを撮った）
その後すべてのサービスのデータを確認してみると、すべてのサービスで⼀部の絵⽂
字データが破損していることが確認されました。班内で検討したところ、おそらく「寿司ビ
ール問題」として有名な、utf8mb4のデータをutf8として扱ってしまったことによる4バイト
⽂字の破損であるだろうという結論に⾄りました。
ConoHaに問い合わせてみましたが、私達の推測通りメンテナンスではマシンの⼊れ
替えのためにデータのバックアップを⾏なっており、その際にutf8でバックアップを取っ
たとのこと。ConoHa側が持っている完全なバックアップは2⽉時点のものでそれ以降の
データを復旧することは不可能であると回答がありました*3。外部に公開されている
Blogサービスのみ、たまたま2週間ほど前にBlogサービスのバージョンアップ検証を⾏
うために取っていたバックアップから差分を復旧することで対処しました。
まさかこんなことってあるんですねぇ……となった事件でした

#### 言語名
japaneseやthaiやgeneral、unicodeなどが入ります。
generalやunicodeはマルチリンガルの事(utf8にjapaneseはない)。

#### 比較法
`_ci _cs _bin`のいずれか(で終わる)

\_ci: 大文字と小文字が区別されない
\_cs: 大文字と小文字が区別される
\_bin: バイナリ

#### utf8_general_ciとutf8_unicode_ciの使い分け
unicode の方はあいまいな照合が可能です。全角、半角、大文字、小文字を無視して一致するものを検索できます。

たとえば、検索文字に`MySQL`を指定した時と、`ｍｙｓｑｌ`を指定した時の検索結果は同じになります。

general の方はその逆で、厳密に違いとして認識され先の例の検索結果は異なります。

どちらも項目の用途によって使い分けるのが、あるべき姿なのでは無いかと思います。

`utf8mb4_bin`のが`utf8mb4_general_ci`より少しはやいらしい https://yakst.com/ja/posts/5431
MySQL8なら`utf8mb4_0900_bin`を試してみる https://qiita.com/hmatsu47/items/d66830c8a00c21f5edad


### トランザクション
INSERT, UPDATE文を複数送るとき、その一部だけがデータベースに反映されると、一時的にせよ、データベース全体としてデータが不整合な状態となります。トランザクションを使うことでそれらを同時に実行させられます。

BEGINから始まりCOMMIT/ROLLBACKで終わる。

WAL(Write Ahead Logging)

TODO: FOR UPDATEとの違い
FOR UPDATE（先行して行ロックを獲得したトランザクションがロックを開放する/ロックがタイムアウトするまで待たされる）
NOWAIT（ロックが獲得できなかったときは即時にエラーを返す）
SKIP LOCKED（即時に獲得可能なロックのみ獲得して結果を返す）
https://www.informit.com/articles/article.aspx?p=29312
- [ネストさせたいときはSAVEPOINT](https://qiita.com/_natsu_no_yuki_/items/e1db2a132cbff740896d)

| BEGIN文  | SAVEPOINT文                |
| -------- | -------------------------- |
| BEGIN    | SAVEPOINT hoge             |
| COMMIT   | RELEASE SAVEPOINT hoge     |
| ROLLBACK | ROLLBACK TO SAVEPOINT hoge |

```go
tx, err := db.Begin()
if err != nil {
	log.Println(err)
}

_, err = tx.Exec("INSERT INTO test_user(name) VALUES(?)", "TRANS")
if err != nil {
	log.Println(err)
}

// run something

if err != nil {
    // もとの状態に戻す
    err = tx.Rollback()
	if err != nil {
		log.Println(err)
	}
} else {
    // クエリを実行する
    err = tx.Commit()
	if err != nil {
		log.Println(err)
	}
}
```

### PreparedStatement
INSERT文など値は違えど同じクエリを大量に実行したいとき毎回クエリを解析せず最初に1回解析すれば後はそれを使い回して高速化しようという機能です。(多分パースしてクエリプランナーに突っ込んだ状態にしてあるだけ)

- Go標準のSQLパッケージはプレースホルダを用いたクエリは暗黙的にPreparedStatementを使っている
- 同じクエリではないとき段階を踏む上でコストが掛かり遅くなる(ADMIN PREPAREが多くなる)
そこで`interpolateParams=true`を使ってPreparedStatementを減らせる
http://dsas.blog.klab.org/archives/52191467.html
- トランザクション中にPreparedStatementするときは先にCloseしてCommitしないと不整合が起こる
- クエリのプレースホルダーはSQLインジェクション対策にもなる。fmt.Sprintf()で作らないようにする。
```go
// interpolateParams=true
db, err := sql.Open("mysql", "root:password@tcp(localhost:3306)/test?interpolateParams=true&collation=utf8mb4_bin")
// SQL文を受け取って解析し、値があればいつでも実行できる状態にする
stmt, err := db.Prepare(query)
if err != nil {
    return
}
// PreparedStatementを関数の終わりで終了させる
defer stmt.Close()
// SQL文に必要な値をセットして実行
stmt.Exec(value)
```

### 生成カラム(generated column)

https://qiita.com/hmatsu47/items/128ece7276e4deac1477
他のカラムのデータを使って新しいカラムを作る
- VIRTUAL トランザクションが入ったときにデータを生成する
- STORED INSERTしたときにデータを生成する

NOT NULLを用いれば制約に合わないものがきたらエラーを吐かせて、データに制約を作ることができる
CHECKでやれって話
https://yakst.com/ja/posts/2834
VIRTUALのとき仮想列と呼びそれを使ったINDEXを仮想インデックスと呼ぶ
この設計において、仮想列は簡単に追加して削除することができ、かつテーブル全体をリビルドする必要もない。これにより関連するテーブルのスキーマ変更がとても簡単かつ高速になる。

高速な仮想列の管理
`mysql> ALTER TABLE t ADD new_col INT GENERATED ALWAYS AS (a - b) VIRTUAL;`

### メモリ最適化

https://dev.mysql.com/doc/refman/5.6/ja/data-size.html
`MEDIUMINT` `INT`の25%削減
`NOT NULL` null確認の処理がなくなる

できるだけ少なく
https://phpjavascriptroom.com/?t=mysql&p=columntype

### キーキャッシュ
MyISAM
https://dev.mysql.com/doc/refman/5.6/ja/myisam-key-cache.html
テーブルブロックとは？

ページングに注意すべきキャッシュ
InnoDB バッファプール
MyISAM キーキャッシュ
MySQL クエリーキャッシュ

頻繁な更新を実行するアプリケーションでは、多くの場合に少数のカラムのある多数のテーブルを使用し、大量のデータを解析するアプリケーションでは、多くの場合に多数のカラムのある少数のテーブルを使用します。

正規形

InnoDB は、ほとんどのデータまたはすべてのデータをメモリーに保持する汎用的で永続的な方法を提供

tmpfs
セッションとは？
