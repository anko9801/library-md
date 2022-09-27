Hugo

browser
[d0iasm/vulbr: Toy browser on single process / thread (github.com)](https://github.com/d0iasm/vulbr)

WAF

PHP の `file_get_contents` はローカルファイルもウェブ上も取ってくる。
正規表現の `.` は改行にマッチしない。

- React
- Preact
- MobX
- Solid: React + MobX feat. Svelte
- Svelte


## Web Performance
lighthouse

## 先読み/遅延読み込み
[Resource Hints](https://www.w3.org/TR/resource-hints/)
[Priority Hints](https://chromestatus.com/feature/5273474901737472)
リソースの優先度をブラウザに認識させ、読み込み順序を最適化できます。初期画面に必要なリソースの読み込みが後方にある場合、その分LCPやFIDが遅延することになります。
link `rel=preload`
script `async/defer`
img/iframe `loading="lazy"`

## 配信削減
### 圧縮
gzip
brotli圧縮

画像のリサイズ・クリッピング
JPEG -> Webp -> AVIF
GIF -> WebM(VP9) -> WebM(AV1)

webpack: production
WebpackPlugin
minifier
- css-minimizer-webpack-plugin

### CSS/JSのバンドルサイズを削る
計測方法
- [You might Not Need Lodash](https://youmightnotneed.com/lodash/)
tailwind cssのpurge
不要なwebfontのcssの削除

## Cache
`Cache-Control: public, max-age=604800, immutable`
ついでに動的な部分でも`Cache-Control`から`no-transform`を取り除きました。それと、`Connection: close`を取り除きました。

## 配信距離
CloudFlare
キャッシュ

TCP/IP スロースタート時のパケット数10
ステータスコード 1kB
1.5kB * 10回 - 1kB = 14kB
14kB以下なら高速
[ウェブサイトのファイルサイズは14kB以下にすべきという指摘、その理由とは？ - GIGAZINE](https://gigazine.net/news/20220828-website-should-be-under-14kb/)