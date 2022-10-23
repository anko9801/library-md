---
title: "ZIP"
---



```
[local file header 1]
[file data 1]
[data descriptor 1]
.
.
.
[local file header n]
[file data n]
[data descriptor n]
[archive decryption header]
[archive extra data record]
[central directory header 1]
.
.
.
[central directory header n]
[zip64 end of central directory record]
[zip64 end of central directory locator]
[end of central directory record]
```

### Local file header
```
      local file header signature     4 bytes  (0x04034b50)
      version needed to extract       2 bytes
      general purpose bit flag        2 bytes
      compression method              2 bytes
      last mod file time              2 bytes
      last mod file date              2 bytes
      crc-32                          4 bytes
      compressed size                 4 bytes
      uncompressed size               4 bytes
      file name length                2 bytes
      extra field length              2 bytes

      file name (variable size)
      extra field (variable size)
```





ZIPはディレクトリの階層構造は関係せずファイルを順に並べる。

```
\ hoge
 |- foo
 |-
bar
```

ならば`/`のついたファイル名をZIP化したらどうなるか


ZIPローカルファイルヘッダ
シグネチャ `50 4b 03 04`
バージョン `14 00` 2.0
`00 00`
圧縮方法 `08 00` deflate
最終変更日時 `45 97 90 53`
CRC-32 `f7 45 3e aa`
圧縮サイズ `16 00 00 00` 20 byte
非圧縮サイズ `42 00 00 00` 68 byte
ファイル名の長さ `04 00` 4 byte
拡張フィールドの長さ `1c 00` 28 byte
ファイル名(文字列) `74 65 73 74` test
拡張フィールド
ファイルエントリ
55 54 09 00 03 b1 0d bb 61 b4 0d bb 61 75
78 0b 00 01 04 e8 03 00 00 04 e8 03 00 00 f3 48
cd c9 c9 d7 51 88 f2 0c 50 08 cf 2f ca 49 51 24
15 70 01 00 50 4b 01 02 1e 03 14 00 00 00 08 00
45 97 90 53 f7 45 3e aa 16 00 00 00 42 00 00 00
04 00 18 00 00 00 00 00 01 00 00 00 a4 81 00 00
00 00 74 65 73 74 55 54 05 00 03 b1 0d bb 61 75
78 0b 00 01 04 e8 03 00 00 04 e8 03 00 00 50 4b
05 06 00 00 00 00 01 00 01 00 4a 00 00 00 54 00
00 00 00 00

ZIPセントラルディレクトリファイルヘッダ
シグネチャ 02 01 4B 50
作成されたバージョン
展開に必要なバージョン
汎用目的のビットフラグ
圧縮メソッド　（0:無圧縮、8:deflate）
ファイルの最終変更時間
ファイルの最終変更日付
CRC-32
圧縮サイズ byte
非圧縮サイズ byte
ファイル名の長さ byte
拡張フィールドの長さ byte
ファイルコメントの長さ byte
ファイルが開始するディスク番号 byte
内部ファイル属性
外部ファイル属性
ローカルファイルヘッダの相対オフセット byte
ファイル名(文字列)
拡張フィールド
ファイルコメント(文字列)

ZIPセントラルディレクトリ終端レコード
シグネチャ 06 05 4B 50
ディスクの数 枚
セントラルディレクトリが開始するディスク番号 枚目
このディスク上のセントラルディレクトリレコードの数 個
セントラルディレクトリレコードの合計数 個
セントラルディレクトリのサイズ byte
セントラルディレクトリの開始位置のオフセット byte
ZIPファイルコメントの長さ byte
ZIPファイルコメント(文字列)
