---
title: "fast"
---


Cache

Copy on Write
[An Overview of Query Optimization in Relational Systems 論文紹介 - Google スライド](https://docs.google.com/presentation/d/1ruGYLRLeagkfv1gQBlmh_di7AviaSx0MJih4oH24AsY/edit#slide=id.p)

O/R Mapper

# ISUCONメモ

https://github.com/FujishigeTemma/isucon9-qualify/blob/master/go/main.go
https://github.com/tohutohu/isucon9/blob/master/webapp/go/main.go

https://www.youtube.com/watch?v=0DhBLswwcRs

https://gist.github.com/941/8c64842b71995a2d448315e2594f62c2
https://gist.github.com/south37/d4a5a8158f49e067237c17d13ecab12a
https://isucon.net/archives/54822761.html

## 事前講習

工事中
:::spoiler
ssh接続
ssh鍵
githubで公開リポジトリに置くと失格
マニュアルを全員読む(情報をまとめることが得意な人がいたら)
初期ベンチ
ベンチの振れ幅、挙動を調べる
1コミット1ベンチ
コミットコメントにログとか載せると良き
キャッシュが必要以上に残るとフェイル
タイムアウトか間違ったキャッシュならタイムアウトを取る

変更するファイル
webapp/go
webapp/sql
各種設定ファイル
nginxやmysqlの設定などはgit内に移して元の場所にシンボリックリンクを貼る



### 開始直後

マニュアルを全員で読む
- 点数に関わる記述が重要情報
- キャッシュの許され方
    - 「N秒キャッシュしてもよい」と書いてある

不要なデーモンを止める
```
cat /proc/cpuinfo
free -h
systemctl list-units --type=service --state=running
```

ssh configの設定
ベンチ1回目
リポジトリ内にシンボリックリンクを置く
git init git remote git add . git commit -m "Initial commit"
お昼食べる
利用するサイトの動作確認
忘れて無ければ全ページのスクショを撮る
ラストのチェックのときにCSSとかをざっと見る
使いそうなファイル群を固めてローカルに持ってくる
tar xvcf webapp
scp user@ip:~/webapp.tar .
更新箇所のチェック
エンドポイントの数
更新があるエンドポイント
mysqlとnginxのログ設定
解析ツールのインストール
ベンチ2回目
秘伝のタレ
ベンチ3回目

```
INDEX idx_category_id_created_at (category_id,created_at),
INDEX idx_created_at (created_at),
INDEX idx_buyer_id (buyer_id),
INDEX mul_idx_seller_id_created_at (seller_id, created_at)
```
https://github.com/reyu0722/piscon2021
- ItemとかUserとかで取れる部分はキャッシュする -> 71500
- Item以外をメモリだけで管理するようにした (他にもいくつか) -> 87840
    - 超大変だった
:::

## 各種解析ツール 推測するな計測せよ

### パフォーマンスモニタリング
CPU占有率の高いプロセスを特定します
htop dstat
dstat -tlamp

### メトリクス
高級なパフォーマンスモニタリングツール
[netdata](https://github.com/netdata/netdata) NewRelic Splunk
https://dev.classmethod.jp/articles/netdata/

### アクセス解析
パスパラメータ/クエリパラメータ別のアクセス数を表示してくれます
主に見るべきはavg 次にcount
kataribe **[alp](https://github.com/tkuchiki/alp)**

### プロファイリング
**pprof** fgprof

### スロークエリ
mysqldumpslow **pt-query-digest**

### SQL全般
**[percona tool kit](https://www.s-style.co.jp/products/percona/toolkit)**
[mysqltuner](https://github.com/major/MySQLTuner-perl)

### Makefile
TODO: 秘伝のMakefileを作る
https://gist.github.com/azonti/dee0547cb561dfdec4a90e093a418bdc
https://github.com/FujishigeTemma/isucon10-final/blob/master/Makefile
https://github.com/tohutohu/isucon9/blob/master/Makefile
https://git.trap.jp/eiya/202008piscon/src/branch/master/go/Makefile

## アプリ

- クエリ最適化
- 変更の少ないデータのキャッシュ化
- やらなくてよい処理を省く
- 強いセキュリティを弱くして高速化(gorilla/sessions->自前実装 net/http->fasthttp bcrypt->SHA256など)
- APIの並列化
- FOR UPDATEアプリケーションで排他制御
- gollira/sessionはセキュアなセッションをcookieだけで実現しているので、暗号化のコストが結構かかる -> ランダムな値とmapを使った実装に差し替え
- jsonのエンコード/デコードをgo-json

### プロファイラの設定

#### pprof https://github.com/google/pprof
標準で入っているプロファイラです。デファクトスタンダードという感じ。
```go
import _ 'net/http/pprof'

func main() {
    go func() {
        http.ListenAndServe(":6060")
    }()

    // <code to profile>
}
```
プロファイリングした画像をdiscordやslackに届けるシェルです。
```shell
go tool pprof -png -output pprof.png http://localhost:6060/debug/pprof/profile?seconds=60
curl -X POST -F img=@pprof.png $(DISCORD_WEBHOOK_URL)
slackcat --channel general pprof.png
```

#### fgprof https://github.com/felixge/fgprof
一部適切な表示とならないことがある
```go
import (
    "net/http"
    _ "net/http/pprof"
    "github.com/felixge/fgprof"
)

func main() {
    http.DefaultServeMux.Handle("/debug/fgprof", fgprof.Handler())
    go func() {
        log.Println(http.ListenAndServe(":6060", nil))
    }()

    // <code to profile>
}
```

`http://localhost:6060/debug/fgprof`

## MySQL チューニング

### データベースとは
- [B-Tree/B+Tree](https://qiita.com/kiyodori/items/f66a545a47dc59dd8839)LSMツリーと呼ばれる平衡N分木で構築されたデータの集合。メモリ/実行時間最適化、排他制御をよしなにやってくれます。
- やり取りに人間がわかりやすい言葉`DDL(Data Definition Language) DML(Data Manipulation Language) DCL(Data Control Language)`を使ってDBを操作します。例えば`Structured Query Language(SQL)`などがあります。
- データベースシステムとSQLはごっちゃにして言われやすいので注意。例えば、MariaDBはMySQLから派生した`Relational Database Management System(RDBMS)`の一種だとか、`Not only SQL(NoSQL)`はクラウドのDBに対してネットワーク伝送コストを避けて最適化された非RDBMSで、MongoDBやAWSのDynamoDB, Redisがそれに含まるなど。


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

### ORM O/Rマッパー
開発効率を上げる為のSQLのラッパー(クエリービルダー)
ex.) gorm

### MySQL設定

別のサーバーからDBへアクセスできるようにする
`/etc/mysql/mysql.conf.d/mysqld.cnf`
`bind-address = 127.0.0.1`をコメントアウト
`bind-address = 0.0.0.0`

http://dsas.blog.klab.org/archives/50860867.html
- グローバルバッファ mysqld全体でそのバッファが1つだけ確保されるもの
- スレッドバッファ スレッド(コネクション)ごとに確保されるもの
チューニングの際にはグローバル/スレッドの違いを意識するようにしましょう。 なぜなら、スレッドバッファに多くのメモリを割り当てると、コネクションが増えたとたんにアッという間にメモリ不足になってしまうからです。

```
max_connections=1024
query_cache_type=ON
# innoDB全体で一つ生成されるグローバルバッファ(別鯖なら搭載メモリの80%)
innodb_buffer_pool_size = 1GB
# InnoDBの内部データなどを保持する足りないとエラーログが出るからその時増やす
#innodb_additional_mem_pool_size = 30MB ←これあるとダメ
# innoDBの更新ログを保持するメモリ
innodb_log_buffer_size = 16MB
# innodb_log_fileがいっぱいになると、メモリ上のinnodb_buffer_poolの中の更新された部分のデータを、ディスク上のInnoDBのデータファイルに書き出すしくみになっているから
innodb_log_file_size = 128MB
# ORDER BYやGROUP BYのときに使われるメモリ上の領域
innodb_sort_buffer_size = 4MB
read_rnd_buffer_size = 2MB #
key_buffer_size = 256MB
# 1に設定するとトランザクション単位でログを出力するが 2 を指定すると1秒間に1回ログを吐く。0だとログも1秒に1回。TODO違いをみる
innodb_flush_log_at_trx_commit = 0
innodb_flush_log_at_trx_commit = 2
# データファイル、ログファイルの読み書き方式を指定する(実験する価値はある)
innodb_flush_method = O_DIRECT
# 再起動試験対策
innodb_buffer_pool_dump_at_shutdown = ON
innodb_buffer_pool_load_at_startup = ON
```

```
$ mysql -u isucari -p
pass: isucari
$ sudo journalctl -u isucari.golang
sudo rm /var/log/mysql/mysql-slow.log
sudo systemctl restart mysql
sudo rm /var/log/nginx/access.log
sudo nginx -t
sudo systemctl reload nginx
cd ~/isucari/webapp/go
make
cd -
sudo systemctl restart isucari.golang
```

### スロークエリ

`/etc/mysql/mysql.conf.d/mysqld.cnf`
```bash
slow_query_log=1
slow_query_log_file=/var/log/mysql/mysql-slow.log
long_query_time=0 # 全てのクエリを書き込んで解析ツールに渡す
log_queries_not_using_indexes=1 # インデックスを使っていないクエリも出力する
```
`sudo mysqldumpslow -s t -t 10 /path/to/slow.log`
`pt-query-digest /path/to/slow.log`

複数のSQLクエリをIN、JOIN、LIMIT句、外部キーでまとめる(N+1問題など)
不要なカラムやクエリを削除する
転送量を減らす。取得するカラムを減らす、特にでかいもの(`VARCHAR(4096)`など)が入っているのは削るべき
https://qiita.com/ikenji/items/b868877492fee60d85ce

**INDEX**
B+ツリーのインデックスを適切に設定することで検索速度を高める。二分探索ができるものなら速くなる。
更に言えば上記のBツリーインデックスとハッシュインデックスが存在し、ハッシュインデックスの方が速いが、等価比較しかできない。MySQLは自動的にそれらの選択をしている。
これが多すぎるとINSERTでくそおもになるので注意

ここで役立つコマンド
`mysql -uユーザ名 -pパスワード DB名 -e'EXPLAIN ~~;'`

LIKEも最初の方がワイルドカードではなければ使える
- 速くなるもの WHERE, ORDER BY, JOIN句
- 効かないもの LIKE, OR, 演算, 関数処理, IS NULL, 否定形
- NOT NULLを出来る限りつける
- ORをUNION/UNION ALLに変換する
- ORDER BYでDESCとASCの混合->MySQL 8.0では[降順インデックス](https://dev.mysql.com/doc/refman/8.0/ja/descending-indexes.html)で適用できる
- [空間インデックス](https://dev.mysql.com/doc/refman/8.0/ja/creating-spatial-indexes.html) `SRID 0`を付ける https://matsuu.hatenablog.com/entry/2020/09/13/131145

プレフィックスインデックス
非常に長い文字列にインデックスを付ける必要がある場合、値全体ではなく最初の数文字にインデックスを付けることで、記憶域を節約し、パフォーマンスを改善することができます。
- プレフィックスインデックスでは、選択性も低下するため、十分な選択性が得られる長さを持ち、記憶域を節約するくらい短いプレフィックスを選択すること
- 欠点として、ORDER BY 句や GROUP BY 句を使用するクエリにプレフィックスインデックスを使用できない
- 適切なサイズは、下記クエリで選択性を計測し、収束する値を見ることで発見できる。選択性とは、インデックス付けされた値の数と、テーブル内の行の合計数の比率のこと

マルチインデックス
[クエリ文がINDEX作成時のカラム順に基づいていないと、INDEXが使えない](https://qiita.com/rm-rf-slant/items/8023500788352646b6c2)
- 等しい (=)、より大きい (>)、より小さい (<)、BETWEENなどの検索条件のWHERE句で使用されるか、結合に含まれる列を、先頭に配置する
- クエリによるカラム順序の制限がない場合、最も選択的な列をインデックスの先頭に配置する。カラム毎の選択性は下記クエリで計測する
- ちゃんと出来てないとEXPLAIN type=index:フルインデックススキャンと言われる
1種類の値に対し多くのデータが存在するようなカラムを先に置く
重複の多いものを先に置く
それに伴うようにクエリのカラムを先に置く

https://lukesilvia.hatenablog.com/entry/20080315/1205583930
Using filesort
レコードをソートして取り出す方法を決定するには、MySQL はパスを余分に実行しなくてはならないことを示す。 join type に従ってすべてのレコードをスキャンし、WHERE 条件に一致する全てのレコードに、ソートキー + 行ポインタを格納して、ソートは実行される。 その後キーがソートされる。 最後に、ソートされた順にレコードが取り出される。

Using temporary
クエリの解決に MySQL で結果を保持するテンポラリテーブルの作成が必要であることを示す。これは一般に、GROUP BY を実行したカラムセットと異なるカラムセットに対して ORDER BY を実行した場合に発生する。
UNIONとかも...？

https://qiita.com/katsukii/items/3409e3c3c96580d37c2b
https://nishinatoshiharu.com/overview-multicolumn-indexes/

インデックスオンリースキャン
SELECTするカラムが少ないときINDEXにそのカラムを置くとそれを取ってくるだけでよい

### クエリーキャッシュ Qcache
※注意 [MySQL 8.0以降には存在しない](https://yakst.com/ja/posts/4612)
メモリ上にクエリのバイト列とその結果を保存して再度同じ(大文字・小文字を区別する)クエリが来たらDBを探さずそれを返す。更新がかかるとキャッシュがフラッシュされる。
ディスクI/Oの多発の解決
INSERT,UPDATEが少なくSELECTが多いアプリに有効

[MySQL クエリーキャッシュ 【チューニング方法とかも】](https://qiita.com/ryurock/items/9f561e486bfba4221747)

***

SQLで画像を入れるとAXと呼ばれるやつが入るらしい
https://stackoverflow.com/questions/52426874/how-do-i-extract-microsoft-sql-varbinarymax-field-to-image-using-golang

`キーキャッシュのヒット率 = 100 - ( key_reads / key_read_requests × 100 )`
mysqlをmariadbに変える? (あまり必要はない)

```shell
$ curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
$ sudo apt install mariadb-server
$ #このあと/etc/mysql/mysql.conf.d/mysqld.cnfに書いてたやつを/etc/mysql/mariadb.conf.d/50-server.cnfに書く
```

~~proxysqlを利用する？~~ ~~mariadbなら~~そのままquery cache使えばよさそう

http://dsas.blog.klab.org/archives/50860867.html

### 再起試験対策
1台目サーバと2台目サーバの再起動タイミングがずれるとアプリからのDB接続に失敗
`/etc/systemd/system/isuumo.go.service`
```
[Service]
StartLimitBurst=999 # 失敗して再起動するのを何回行うか デフォルトは5
```

再起動試験用DB待ち
```go
package main

import (
	"database/sql"
	"log"
	"time"
)

// main関数内に置く
waitDB(db)
go pollDB(db)

func waitDB(db *sql.DB) {
	for {
		err := db.Ping()
		if err == nil {
			return
		}

		log.Printf("Failed to ping DB: %s", err)
		log.Println("Retrying...")
		time.Sleep(time.Second)
	}
}

func pollDB(db *sql.DB) {
	for {
		err := db.Ping()
		if err != nil {
			log.Printf("Failed to ping DB: %s", err)
		}

		time.Sleep(time.Second)
	}
}
```
***

#### golang
```golang
dbx.SetMaxIdleConns(1024) // デフォルトだと2
dbx.SetConnMaxLifetime(0) // 一応セット
dbx.SetConnMaxIdleTime(0) // 一応セット go1.15以上

// goroutineを生やしすぎてもタイムアウトする https://www.sambaiz.net/article/61/
// Keep-AliveするとTCPコネクションを使い回し、名前解決やコネクション(3 way handshake)を毎回行わなくてよくなる
http.DefaultTransport.(*http.Transport).MaxIdleConns = 0 // 無制限 デフォルトだと100
http.DefaultTransport.(*http.Transport).MaxIdleConnsPerHost = 1024 // 0にすると2になっちゃう
http.DefaultTransport.(*http.Transport).ForceAttemptHTTP2 = true // go1.13以上
http.DefaultClient.Timeout = 5 * time.Second // 問題の切り分け用
```

https://qiita.com/go_sagawa/items/11929cd0883608a6888d

- redis
```
sudo add-apt-repository ppa:chris-lea/redis-server
sudo apt update
sudo apt install redis
```
`sudo nano /etc/redis/redis.conf`
`bind 127.0.0.1 ::1`のコメントアウト
`protected-mode yes`→`protected-mode no`
`requirepass hogehoge`に
```
sudo systemctl unmask redis-server
sudo systemctl enable redis-server
sudo systemctl restart redis-server
```
`sudo echo never > /sys/kernel/mm/transparent_hugepage/enabled`
`sudo nano rc.local`→追記: `echo never > /sys/kernel/mm/transparent_hugepage/enabled`

### JSON
https://github.com/json-iterator/go を試してみる
```golang
var json = jsoniter.Config{
    EscapeHTML:                    false,
    ObjectFieldMustBeSimpleString: true,
}.Froze()
```
https://github.com/francoispqt/gojay
https://github.com/goccy/go-json
https://github.com/minio/simdjson-go
Marshal / Encoder: goccy/go-json > francoispqt/gojay
Unmarshal: francoispqt/gojay > goccy/go-json
Decoder: francoispqt/gojay >> goccy/go-json

- メモリ上にキャッシュ
    - `map`
        - 読み込み書き込みともに多く行う -> `sync.Map`
        - 読み込み多く行う -> `sync.RWMutex` + `map`
        - ロックが気になるならシャーディングをするとよい
            - https://github.com/orcaman/concurrent-map
            - https://github.com/FujishigeTemma/isucon9-qualify/compare/6eaa28f77cb8bac674c0b8cfbf9794d91999d026...49cede08c6fcf59afa29857559d146abb1e96165
            - 15～20個ずつになるくらいがよさそう？
    - sessionメモリに持つ
        - `gorilla/sessions`はコピーのために`encoding/gob`が無駄に呼び出される
- singleflight
    - `x/sync/singleflight`
    - `sync.Map` + `sync.Cond`
        - https://github.com/FujishigeTemma/isucon9-qualify/compare/2fb8ff382ce2f7b083ae9f343e5ae5d543bc5e65...6d3f1ab77bd377be00fdf6d5735ffe14b8f5afd6
    - `go-chi/httpcoala`
        - https://github.com/FujishigeTemma/isucon9-qualify/commit/495ae7ba4732b3bcb9c4a6795bea86dfac060c6c
- メモリ効率化
    - `sync.Pool`
        - https://github.com/FujishigeTemma/isucon9-qualify/commit/4e7a9be6cbee699dc11db96c2134836dfd207def
- 挿入後の結果をとらずに返す
    - timeはミリ秒を四捨五入すること`.Round`
        - デフォルトが秒までだけど、`DATETIME`のあとに数字がある場合は異なるので要確認
        - https://dev.mysql.com/doc/refman/5.6/ja/fractional-seconds.html
- session
    - 自前の`interface`の変換なしの実装
        - https://github.com/FujishigeTemma/isucon9-qualify/commit/64d095a6400bbde6df4ed62d6ad9bd12dbc8a964
- `pat.Param`
    - 自前の`interface`の変換なしの実装
        - https://github.com/FujishigeTemma/isucon9-qualify/compare/b87747c27f305927b40b86285b1642cbe52e1c55...68c236f9782f041bca64f185ae0a3fbec9122ee2
- misc
    - キーが100個程度までならmapよりarrayを線形探索したほうがよいらしい
    - sliceもmapもcapacityを指定する
    - `i, item := range items`をすると`item`にコピーが走るので`items[i]`を使う
    - 画像を返してる箇所はキャッシュのヘッダーを設定する
    - GOGC `400`～`1200`とか
        - 有効にしたときは**毎回再起動すること**

- [MySQL のパーティショニングで速くなる？ならない？問題、あらためて実験してみた](https://qiita.com/hmatsu47/items/354f979cde6ad91bcc6b)
- カバリングインデックス

http://akouryy.hatenablog.jp/entry/2020/09/13/130415

- https://dev.mysql.com/doc/refman/5.6/ja/optimizing-innodb-bulk-data-loading.html

#### MySQL8
- NOWAIT, SKIP LOCKED: https://qiita.com/hmatsu47/items/7675b026e65762d2445f
- HASH JOIN: https://qiita.com/hmatsu47/items/e473a3e566b910d61f5b
- Multi-valued index(jsonカラム用): https://qiita.com/hmatsu47/items/3e49a473bc36aeefc706
- GROUP BYをLATERALにする？: https://qiita.com/hmatsu47/items/040d65d118d0ecec6381


パーティショニングとは

## HTTP チューニング

https://qiita.com/yumin/items/5de33b068ead564ebcbf

[martini](https://github.com/go-martini/martini)
[gin](https://github.com/gin-gonic/gin)

fasthttp
https://medium.com/eureka-engineering/net-http%E3%82%88%E3%82%8A10%E5%80%8D%E9%80%9F%E3%81%84valyala-fasthttp%E3%81%8C%E9%9D%A2%E7%99%BD%E3%81%9D%E3%81%86%E3%81%AA%E3%81%AE%E3%81%A7%E8%AA%BF%E6%9F%BB%E3%81%97%E3%81%A6%E3%81%BF%E3%81%9F%E4%BB%B6-a608fe197f1d

## カーネルパラメータ チューニング

[【Linux】カーネルパラメータのパフォーマンスチューニングについて](https://ac-as.net/kernel-parameter-performance-tuning/)

### ファイルディスクリプタの上限

`ulimit -l 10000`

sshだとulimitできない
https://yohei-a.hatenablog.jp/entry/20090310/1236706236

http://ramblog.blog129.fc2.com/blog-category-4.html

```
# /etc/systemd/system/*.service
[Service]
LimitNOFILE=65535
```

### カーネルパラメータ

上ほど優先順位高い(同じ名前のfileをoverrideする)
`/etc/sysctl.d/*.conf`
`/run/sysctl.d/*.conf`
`/usr/lib/sysctl.d/*.conf`
すべての設定ファイルは、どのディレクトリにあるかに関わらず、ファイル名の並び順で辞書順にソートされます。複数のファイルが同じオプションを指定している場合は、辞書的に最新の名前を持つファイルのエントリが優先されます。ファイルの順序を簡単にするために、すべてのファイル名の前に 2 桁の数字とダッシュを付けることをお勧めします。

```
# /etc/sysctl.d/100-isucon.conf
# maxconnection を増やす
net.core.somaxconn = 32768                  # 32768 (2^15) くらいまで大きくしても良いかも。
net.ipv4.ip_local_port_range = 10000 60999  # port の範囲を広げる

# tcp connection の再利用を有効化
net.ipv4.tcp_tw_reuse = 1

# tcp connection が FIN-WAIT2 から TIME_WAIT に状態が変化するまでの時間
net.ipv4.tcp_fin_timeout = 10               # デフォルト 60。CPU 負荷を減らせるが、短すぎると危ういかも？

# TIME_WAIT状態にある tcp connection 数の上限
net.ipv4.tcp_max_tw_buckets = 2000000       # デフォルトは 32768(=2^15) くらい

# パケット受信時にキューにつなぐことのできるパケットの最大数
net.core.netdev_max_backlog = 8192          # デフォルトは 1000 くらい

# 新規コネクション開始時のSYNパケットを受信した際の処理待ちキューの上限値
net.ipv4.tcp_max_syn_backlog = 1024         # デフォルトは 128 くらい

# window size scalingの有効化(ネットワークの帯域幅とメモリ使用量のトレードオフ)
net.ipv4.tcp_window_scaling = 1             # デフォルトで1になっているはず
# すべての種類のsocketに基本設定されているbufferのsize デフォルトは 212992(=13*2^14) くらい
net.core.rmem_default = 253952
net.core.wmem_default = 253952
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
# TCP socket buffer sizeの変更 デフォルトは 212992(=13*2^14) くらい
net.ipv4.tcp_rmem = 253952 253952 16777216  # min / default / max
net.ipv4.tcp_wmem = 253952 253952 16777216  # min / default / max
# TCP用に使用できる合計メモリサイズを指定
net.ipv4.tcp_mem = 185688 247584 371376     # min / pressure / max; pressureの値を超えるとTCP memory pressureの状態になり、以降ソケットは指定されたmin値のメモリバッファのサイズを持つようになる

# カーネルレベルでのファイルディスクリプタ上限数変更
# プロセス単位のチューニングをやったけど、こっちもやっておく
fs.file-max=65535

# 3-way-handshakeの簡略化
# 相手側のサーバーがONにしていないとデータが2回送られてオーバーヘッドになるので一回やってみてスコアが上がらなかったら切る
net.ipv4.tcp_fastopen = 3

# 輻輳制御アルゴリズム TCP BBR の有効化
# `uname -r`が4.9以上で`sysctl net.ipv4.tcp_available_congestion_control`にbbrが含まれている場合　
# net.ipv4.tcp_congestion_control = bbr # 輻輳制御アルゴリズムをbbrに
# net.core.default_qdisc = fq # キューイングアルゴリズムをfqに
```

https://html5experts.jp/jxck/3529/
https://ac-as.net/kernel-parameter-performance-tuning/
φ(.. )ﾒﾓｼﾃｵｺｳ /proc/sys/net/ipv4/tcp_fastopenに設定する内容とか実装
https://kernhack.hatenablog.com/entry/2013/05/25/115634


## Nginx (リバースプロキシ)チューニング


### サーバー分割
**DB分ける**
**リクエストのロードバランス**
ロードバランサー
セッションパーシステンス

worker_processesにそれぞれ均等にworker_connectionsが分配される訳ではないので余裕をもって設定すべき
https://nrok81.hatenablog.com/entry/2014/11/12/191240

```conf
worker_processes  auto;  # コア数と同じ数まで増やすと良いかも

# nginx worker の設定
worker_rlimit_nofile  4096;
events {
    worker_connections  1024;  # 128より大きくするなら、 5_os にしたがって max connection 数を増やす必要あり（デフォルトで`net.core.somaxconn` が 128 くらいで制限かけられてるので）。さらに大きくするなら worker_rlimit_nofile も大きくする（file descriptor数の制限を緩める)
    # multi_accept on;         # error が出るリスクあり。defaultはoff。
    # accept_mutex_delay 100ms;
}

http {
    log_format main '$remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" $request_time';   # kataribe 用の log format
    access_log  /var/log/nginx/access.log  main;   # これはしばらく on にして、最後に off にすると良さそう。
    # access_log  off;

    # 基本設定
    sendfile    on;
    tcp_nopush  on;
    tcp_nodelay on;
    types_hash_max_size 2048;
    server_tokens    off;
    open_file_cache max=100 inactive=65s; # file descriptor のキャッシュ。入れた方が良い。 20s->65s

    # proxy buffer の設定。白金動物園が設定してた。
    proxy_buffers 100 32k;
    proxy_buffer_size 8k;

    # mime.type の設定
    include       /etc/nginx/mime.types;

    # Keepalive 設定
    # ベンチマークとの相性次第ではkeepalive off;にしたほうがいい
    # keepalive off;
    # ベンチは1分しか回らない
    keepalive_timeout 65;
    keepalive_requests 500;

    # Proxy cache 設定。使いどころがあれば。1mでkey8,000個。1gまでcache。
    proxy_cache_path /var/cache/nginx/cache levels=1:2 keys_zone=zone1:1m max_size=1g inactive=1h;
    proxy_temp_path  /var/cache/nginx/tmp;
    # オリジンから来るCache-Controlを無視する必要があるなら。。。
    #proxy_ignore_headers Cache-Control;


    # unix domain socket 設定1
    upstream app {
        server unix:/run/unicorn.sock;  # systemd を使ってると `/tmp` 以下が使えない。appのディレクトリに`tmp`ディレクトリ作って配置する方がpermissionでハマらずに済んで良いかも。
    }

    # 複数serverへ proxy
    upstream app {
        server 192.100.0.1:5000 weight=2;  # weight をつけるとproxyする量を変更可能。defaultは1。多いほどたくさんrequestを振り分ける。
        server 192.100.0.2:5000;
        server 192.100.0.3:5000;
        # keepalive 60;  # app server への connection を keepalive する。app が対応できるならした方が良い。
    }

    server {
        # reverse proxy の 設定
        location / {
            proxy_pass http://localhost:3000;
            # proxy_http_version 1.1;          # app server との connection を keepalive するなら追加
            # proxy_set_header Connection "";  # app server との connection を keepalive するなら追加
        }

        # Unix domain socket の設定2。設定1と組み合わせて。
        location / {
            proxy_pass http://app;
        }

        # 簡易静的ファイルをNginx配信
        location / {
            root /home/user/app/public/;
            try_files $uri $uri/ @app;
        }
        location @app {
            proxy_pass http://app;
        }

        # For Server Sent Event
        location /api/stream/rooms {
            # "magic trio" making EventSource working through Nginx
            proxy_http_version 1.1;
            proxy_set_header Connection '';
            chunked_transfer_encoding off;
            # These are not an official way
            # proxy_buffering off;
            # proxy_cache off;
            proxy_pass http://localhost:8080;
        }

        # For websocket
        location /wsapp/ {
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_pass http://wsbackend;
        }

        # Proxy cache
        location /cached/ {
            proxy_cache zone1;
            # proxy_set_header X-Real-IP $remote_addr;
            # proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            # proxy_set_header Host $http_host;
            proxy_pass http://localhost:9292/;
            # デフォルトでは 200, 301, 302 だけキャッシュされる。proxy_cache_valid で増やせる。
            # proxy_cache_valid 200 301 302 3s;
            # cookie を key に含めることもできる。デフォルトは $scheme$proxy_host$request_uri;
            # proxy_cache_key $proxy_host$request_uri$cookie_jessionid;
            # レスポンスヘッダにキャッシュヒットしたかどうかを含める
            add_header X-Nginx-Cache $upstream_cache_status;
        }

        # static file の配信用の root
        root /home/isucon/webapp/public/;

        location ~ .*\.(htm|html|css|js|jpg|png|gif|ico) {
            expires 24h;
            add_header Cache-Control public;

            open_file_cache max=100;  # file descriptor などを cache

            gzip on;  # cpu 使うのでメリット・デメリット見極める必要あり。gzip_static 使えるなら事前にgzip圧縮した上でそちらを使う。
            gzip_types text/html text/css application/javascript application/json font/woff font/ttf image/gif image/png image/jpeg image/svg+xml image/x-icon application/octet-stream;
            gzip_disable "msie6";
            gzip_static on;  # nginx configure時に --with-http_gzip_static_module 必要
        }
    }
}
```

```
user www-data;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;
worker_rlimit_nofile 100000;

error_log  /var/log/nginx/error.log error;

http {
    default_type  application/octet-stream;

    client_max_body_size 10m;

    # TLS configuration
    ssl_protocols TLSv1.2;
    ssl_prefer_server_ciphers on;
    ssl_ciphers 'ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384';

	server {
	    listen 443 ssl http2;
	    server_name isucon9.catatsuy.org;

	    ssl_certificate /etc/nginx/ssl/fullchain.pem;
	    ssl_certificate_key /etc/nginx/ssl/privkey.pem;

		root /home/isucon/isucari/webapp/public;
		location /static/ {
			add_header Cache-Control "public max-age=86400";
		}
		location /upload/ {
			add_header Cache-Control "public max-age=86400";
		}

	    location / {
		proxy_pass http://app;
		proxy_set_header Host $host;
	    }
	    location /login {
		proxy_pass http://login_app;
		proxy_set_header Host $host;
	    }
	}
}
```

### 初期設定
https://wiki.trap.jp/user/to-hutohu/memo/ISUCON%E3%83%81%E3%83%BC%E3%83%88%E3%82%B7%E3%83%BC%E3%83%88
#### OS
設定したら`sudo sysctl -p {{filename}}`で反映する
実行中のプロセスには反映されないからプロセスの再起動が必要

備考: `net.ipv4.ip_, net.ipv4.ip_local_portrange, net.ipv4.tcp, net.ipv4.icmp_*`はipv6にも適用される

#### nginx
`$ sudo cp *.conf *.conf.bk`
`/etc/nginx/nginx.conf`
`/etc/nginx/sites-enabled/*.conf` (ここでは`http`ブロック内しか変更できない)
`/etc/nginx/sites-available/*.conf`に書いて↑ではエイリアスを貼るのが正解
https://wiki.trap.jp/user/to-hutohu/memo/ISUCON%E3%83%81%E3%83%BC%E3%83%88%E3%82%B7%E3%83%BC%E3%83%88#head10

nginxとアプリケーションの間をunix domain socket
`Unix domain socket`は後回し
https://qiita.com/ihsiek/items/11106ce7a13e09b61547#web%E3%82%B5%E3%83%BC%E3%83%90
`index.html`を配信してるところをnginxで返すようにする
```
    # index.htmlの配信
    location ~ ^/(?:login|register|timeline|categories|sell|items|buy/complete|transactions|users)(?!.*.(?:json|png)) {
        try_files $uri /index.html;
    }
```

```
server {
    listen       80 default_server;
    server_name  _;

    location / {
         root /home/isucon/torb/webapp/static/;
         try_files $uri $uri/ @app;
    }

    location @app {
        proxy_set_header Host $host;
        proxy_pass   http://127.0.0.1:8080;
    }
}
```
```
    proxy_buffer_size 128k;
    proxy_buffers 32 128k;
    proxy_busy_buffers_size 128k;
```

h2cの有効化(意味なさそうなのでhttpsを使ってhttp2を使うべき)
```
server {
    listen 80 http2;
```

#####
設定
```
worker_processes auto;
worker_rlimit_nofile 4096;
events {
    worker_connections 1024; # net.core.somaxconnとworker_rlimit_nofileも大きくする
    #multi_accept on; # error が出るリスクあり。defaultはoff
    #accept_mutex_delay 100ms;
}
```

nginx の worker_connections は worker 当たりの同時接続数だと思ってたけどどうも違うっぽい
https://nrok81.hatenablog.com/entry/2014/11/12/191240

##### ログ設定 httpディレクティブの中
```
log_format main '$remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" $request_time';
access_log /tmp/access.log main;
#access_log off;
```

##### 基本設定 httpディレクティブの中
```
sendfile on;
tcp_nopush on;
tcp_nodelay on;
types_hash_max_size 2048;
server_tokens off;
open_file_cache max=100 inactive=20s; # file descriptorのキャッシュ

# proxy bufferの設定
proxy_buffers 100 32k;
proxy_buffer_size 8k;

# keepaliveの設定
#keepalive off; # ベンチマークとの相性次第ではoffにしたほうがいい
keepalive_timeout 120;
keepalive_requests 1048576;

# proxy cacheの設定
proxy_cache_path /var/cache/nginx/cache levels=1:2 keys_zone=zone1:1m max_size=1g inactive=1h;
proxy_temp_path  /var/cache/nginx/tmp;
#proxy_ignore_headers Cache-Control; # upstreamから来るCache-Controlを無視する必要があるなら
```

##### upstream設定 httpディレクティブの中
```
upstream app {
    server 127.0.0.1:8000;

    keepalive 256;
}
```

##### reverse proxy設定 serverディレクティブの中
```
location /initialize {
    proxy_http_version 1.1;
    proxy_set_header Connection "";

    proxy_read_timeout 120;

    #proxy_cache zone1;

    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    proxy_pass http://app;
}
```

##### 静的配信設定 serverディレクティブの中
```
# static file の配信用の root
root /home/isucon/webapp/public/;

location ~ .*\.(htm|html|css|js|eot|svg|ttf|woff|woff2|gif|jpg|png|ico) {
    expires 24h;

    gzip off;
    #gzip on; # CPUを使うのでメリット・デメリット見極める必要あり。gzip_staticが使えるなら事前にgzip圧縮した上でそちらを使う
    #gzip_types *;
    #gzip_disable "msie6";
    #gzip_static on;
}
```

##### gzip
- できればgzip_staticを使う
    - 圧縮コマンド `find ./* | xargs -I {}  sh -c 'gzip -9 -v -N -c {} > {}.gz'`
        - 元のファイルを残して圧縮する
***

### メモ
https://github.com/cs3238-tsuzu/sqlx-selector

http://nginx.org/en/docs/http/ngx_http_rewrite_module.html#if
https://stackoverflow.com/questions/8591600/nginx-proxy-pass-based-on-whether-request-method-is-post-put-or-delete

得点につながるエンドポイントの確認
大量アクセスかつ同じものが使える→singleflight

lockfree map