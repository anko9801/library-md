ファイルシステム VFS
- File Allocation Table (FAT)

FAT とは Microsoft によって開発されたいくつかのファイルシステム(FAT12, FAT16, FAT32, VFAT, exFAT)の総称です。

ここでは実装より仕組みの理解を優先した書き方をするので実装する方は規格などを読んでください。TODO: 規格のURL
えるむさんの記事など
[FATファイルシステムのしくみと操作法 (elm-chan.org)](http://elm-chan.org/docs/fat.html)
それでも仕様は追うので脆弱性を見つけたい方には有効です。

クラスタ番号は2から始まります.

```
Reserved sectors
- Boot Sector
- FS Information Sector (FAT32 only)
- More reserved sectors (optional)
FAT Region
- File Allocation Table 1
- File Allocation Table 2 (optional)
Root Directory Region (FAT12, FAT16 only)
- Root Directory Table
Data Region
- Cluster 2
- Cluster 3
...
- Cluster N
```

File Allocation Table は片方向連結リストです。FATエントリはエントリ番号と同じクラスタ番号のクラスタを保持し、次のエントリを指すことでリスト構造となります。終端には番兵が配置されています。

```
File Allocation Table
 entry2 -> entry7 -> ... -> entry23 -> entry (sentinel)
   |         |                |
cluster2  cluster7         cluster23
```

FAT32では32ビット

Boot Sectorには BIOS Parameter Block BPB や MBR や GPT が配置されます。

ファイルアクセスの方法

ext4 fourth exteneded filesystem
