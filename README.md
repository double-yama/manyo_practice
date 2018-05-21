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

* 緑　gitの管理下ではない, 赤 無視リスト, 黒 変更なし, 青　変更あり

* capybaraについて

* database cleanerを入れること

* spec traitについて勉強する

* 説明は、onClickで表示するtooltip

* 期限をカレンダーに

* 


Specの注意点

* 全画面の見ログイン時の制限てすと

* ログインしていないときのテスト

* 間違えやすいところのテストをすること

* SPecの注意

* 抜け漏れのところ、ベーシックな流れのテストの二点が大事

* デグレードが発生しないようにする

* 削除されるテストと、削除されないテストなど、両方やること


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

select{|a| a.present?}
覚える

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


