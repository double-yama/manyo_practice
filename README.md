# README

Pull Request (Step is completed without hroku)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

##### できてないステップ
* ステップ13(デプロイしよう)

画像アップロード機能が邪魔してherokuにデプロイできず

* OP2(ユーザの間でタスクを共有できるようにしたい)以降ほぼ全て

###### やること

* ja.ymlファイルのリファクタリング

* 編集画面で現在のプロフィール画像を表示する

* ユーザー名検索を作る

* 検索語はフォームに残す

* タスクに画像、詳細にて表示

* jsのみのファイルを作成すること

* 緑　gitの管理下ではない

* 赤 無視リスト

* 黒 変更なし

* 青　変更あり

* capybaraについて

* database cleanerを入れること

* spec traitについて勉強する

* タスク一覧は廃止すること、各々のタスク一覧はマイタスクで見れるし

* rootは、期限切れとか三日以内と検索や新規タスク作成だけにする

* ラベル一覧画面について、ボタンが横に出すぎている

* 

###### メモ

* jsでうまう行かなかったら検証→コンソールを見ること
* capybara　=> test時クリックしたりするやつ
* メソッドを書く際は事前条件・事後条件を考える
* 事前条件 => 引数
* 事後条件 => 返り値

form_forとform_tagの違い

一つのモデルにのみ対応するときform_for
色々自由にできるのはform_tag

カラム名について、
on => 日付
at => 時刻

A server is already running. check server.pidの対処法

パスをコピーし、cat パスで表示

ps aux => プロセス一覧表示
ps aux | grep puma
プロセスidを指定し、kill -9 プロセスidで、死ぬ

契約による設計 調べること

検索はスコープにしたほうがいい

bundle installはbundleだけでいける

pryにて、オブジェクト.public_methodsでそのオブジェクトの持つメソッドがわかる

例) user = User.find()
    user.public_methods
    
    
localでメール送信したい場合は、mailcatcherというGEMを用いる
   
Timecop.freeze(Time.now - 6.months)

specにおいて、時間を固定する

controller spec は事実上非推奨

TDDのほうがいいけどどっちでもいい

複雑なロジックがあるときはTDDのほうがいい

model => TDD

feature => 後から

traitは便利

* let と before の違い

let! と before はほぼ同じ

active Recordを扱う際は、SQL文をちゃんと確認すること

active recordゆえ、whereをつなげたりすることができる

active recordの返り値自体がactive record



4/27

リポジトリについて

コミットの粒度

なんのためのコミットなのかを意識する

あんまり細かすぎるのもダメ

なんのコミットなのかがわかるように


