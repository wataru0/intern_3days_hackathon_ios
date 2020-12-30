# iOS 3daysサマーインターン本番課題🏄
<img src="https://github.com/ikawashima-cq/Resource/blob/master/caraquri_logo_hz_cmyk%20(2).png" width="90%">

## 目次

<!-- TOC -->
- [完成品](#完成品)
- [課題について](#課題について)
- [プロジェクト概要](#プロジェクト概要)
- [予備知識](#予備知識)
<!-- /TOC -->

## 完成品

概要
---
- wantedlyのアプリを参考にし，検索バーを追加してインクリメンタル検索にした．
- ブックマーク機能を実装した．
- タブの切り替えにより，記事検索画面，ブックマークした記事画面を移動できるようにした．
- ブックマーク記事はUserDefaultsを用いて，端末に保存するようにした．

動作確認
---
<img src="https://user-images.githubusercontent.com/44032125/92884260-a28c0a80-f44c-11ea-8942-78aa3a91adb3.gif" width="300" />

工夫したところ
---
- 検索画面と表示画面という構成ではなく，検索バー付きのテーブルビューにしたところ．
- Parchmentライブラリを使用して，tabでメインの記事画面とブックマークした記事一覧画面を移動できるようにしたところ．
- 画像は提供されているAPIでは取得が難しかったが，画像も表示できるようにしたところ．
- インクリメンタル検索であるところ．

やりたかったこと
---
- ブックマーク記事の情報を格納する構造体を要素にもつ配列をデータベースやUserDefaultsに保存して，ブックマーク画面で無駄にAPIを叩かないようにすること
- キーワードを登録して，複数のキーワードで記事を検索することができる機能．
    - 例
    <img src="https://user-images.githubusercontent.com/44032125/92892749-0108b700-f454-11ea-9fdb-c44c65e07871.PNG" width="300" />

今後気をつけること，勉強になったこと
---
- キーチェーン
    - [iOSのキーチェーンについて](https://qiita.com/sachiko-kame/items/261d42c57207e4b7002a)
- Notificationの活用
    - NotificationCenterを使うと，VC間通信を行うことができ，それと同時にデータも送信できる．
- リソース管理ライブラリによる文字列管理
    - ハードコーディングによるスペルミスや、画像、ストーリーボード、セル、UserDefaultsなどのリソースを呼び出す時に、コード補完で作業の生産性を向上させてくれるもの
    - [R.swiftとSwiftGenの導入方法とどちらを採用した方がいいのか](https://qiita.com/ostk0069/items/aa07ac55be075a50326c)


---

## 課題について

### 課題内容
Connpassが提供するAPIを使用して，記事を検索するアプリを作成してください．
独自の機能を追加して使いやすくしてください．

### 課題概要
からくり株式会社 iOS 3dayサマーインターン(ハッカソン)の本番課題です。
下記の概要を詳しく読んだ上で課題を取り組んでください。

### 課題の取り組み方
- Githubにて`Use this template`を使用し、個人のリポジトリにコピー(publicにして下さい)して課題に取り組んでください。
コーディング規約:
- 標準的なコーディング規約であればどれに準じても良いですが、例として[参考リンク](
https://github.com/eure/swift-style-guide/blob/master/README_jp.md)を載せます。

## プロジェクト概要

### アプリ概要
Connpassの記事を検索するアプリです。

### ビルド環境
- Xcode: 11.6
- Swift: Swift5系
- Target iOS Version: 12.0以上

### 導入ライブラリ
- [R.swift](https://github.com/mac-cain13/R.swift)
- [Nuke](https://github.com/kean/Nuke)

※パッケージ管理ツールは[Carthage](https://github.com/Carthage/Carthage)、Lintツールは[SwiftLint](https://github.com/realm/SwiftLintb)を導入しています。

### 動作確認機種
- iPhone 8、 iPhoneX系、 iPhone11系のシミュレーター、もしくは実機での確認を推奨しています。 (iPadやiPhone SEなどの画面サイズには基本対応しなくて構いません)

### ビルド方法
- Xcodeのコマンドラインツールのバージョンを設定して下さい。
`error: unable to find utility "xcodebuild", not a developer tool or in PATH`というエラーが出た場合は[こちら](https://qiita.com/Atsushi_/items/40b204d6ff576eef86b9)を参考にして下さい。

install.shをつかうことでビルド環境を作成できます。
```
cd [自身の作業ディレクトリ]/intern_homework_ios
sh install.sh

~~~~~~(内容を確認したら)~~~~~~
open intern_homework_ios.xcodeproj/

~~~~~~(xcodeを開いたら)~~~~~~
xcode上で command+R でビルド
```

※install.shで`SwiftLint`と`carthage`のアップデート(インストール)を行っている。

### PRを作成する上での注意点
- ローカルでビルドできている
- 動作確認までしている
- SwiftLintで出力されている警告はなるべく削除する

## 予備知識

### GitFlow

- master
  - プロダクトとしてリリースするためのブランチ。リリースしたらタグ付けする。
- develop
  - 開発ブランチ。コードが安定し、リリース準備ができたら master へマージする。リリース前はこのブランチが最新バージョンとなる。
- feature
  - 機能の追加。 develop から分岐し、 develop にマージする。
- release
  - プロダクトリリースの準備。develop ブランチにリリース予定の機能やバグフィックスがほぼ反映した状態で develop から分岐する。 リリース準備が整ったら, master にマージし、タグをつける。次に develop にマージする。
- hotfix
  - リリース後のクリティカルなバグフィックスなど、 現在のプロダクトのバージョンに対する変更用。 master から分岐し、 master にマージし、タグをつける。次に develop にマージする。

<img src="https://user-images.githubusercontent.com/46508203/77295789-e4ec4e80-6d29-11ea-8608-1f24618d6b0f.png" width="500px">

- [git初心者への道 - お仕事で困らないレベルまでググっとします。 · GitHub](https://gist.github.com/yatemmma/6486028)
- [ Branchについて](https://havelog.ayumusato.com/develop/git/e513-git_branch_model.html)

### 開発をする上で知っておいてほしい基礎知識
- [http通信について](https://qiita.com/AkiyoshiOkano/items/ae4258c1caef3d9e70a2)
- [うまくメソッド名を付けるための参考情報](https://qiita.com/KeithYokoma/items/2193cf79ba76563e3db6)
- [英語のコメントや issue で頻出する略語の意味 (FYI, AFAIK, ...)](https://qiita.com/uasi/items/86c3a09d17792ab62dfe)
- [マークダウン記法 一覧表・チートシート](https://qiita.com/kamorits/items/6f342da395ad57468ae3)

### 開発で使うと便利なツール
項目 | ツール名
--- | ---
APIクライアント | Postman, Pawなど
HTTP通信キャプチャ | Charles
Gitクライアント |  Source Treeなど

### 参考資料
- [Appleの公式ドキュメント](https://swift.org/documentation/api-design-guidelines/)
- [connpass API リファレンス](https://connpass.com/about/api/)
- [リーダブルコード要約](https://qiita.com/AKB428/items/20e81ccc8d9998b5535d)


