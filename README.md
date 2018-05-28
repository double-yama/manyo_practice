# README

Pull Request (Step is completed without hroku)

This README would normally document whatever steps are necessary to get the
application up and running.

##### できてないステップ
* ステップ13(デプロイしよう)

###### やること

*　コンピテンシークラウドみたいにadminとuserでわける

* カレンダーにて前後の月を表示する

* ja.ymlファイルのリファクタリング

* 説明は、onClickで表示するtooltip

* 

Specの注意点

* 全画面のみログイン時の制限テスト

* 間違えやすいところのテストをすること

* SPecの注意

* 抜け漏れのところ、ベーシックな流れのテストの二点が大事

* デグレードが発生しないようにする

* 削除されるテストと、削除されないテストなど、両方やること

* 

* spec traitについて勉強する


* 緑　gitの管理下ではない, 赤 無視リスト, 黒 変更なし, 青　変更あり

* control shift dでRSpecデバッグ


###### メモ

* jsでうまう行かなかったら検証→コンソールを見ること
* メソッドを書く際は事前条件・事後条件を考える
* 事前条件 => 引数
* 事後条件 => 返り値

* 管理者フラグよりも、UserとAdminUserというように、モデルを複数作成する方が望ましい

* ログインフォームだけでなく、タスク一覧なども両方作るのが望ましい

* タスクモデルとかはさすがに共通化すること

* 管理者かどうかでviewを作成するのはまずい

* rails g controller Admin::Tasks

* マージして破棄したら、downしないとDBになにか及ぼす
>  namespaceもやってくれる

* なんでもコンソールで実験すること

text.split(",").each do |label_name|
  TaskLabel.create(task_id : 3, Label.create(label_name))
end

admin::tasks_controller
layout admin

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


4/27

リポジトリについて

コミットの粒度

なんのためのコミットなのかを意識する

あんまり細かすぎるのもダメ

なんのコミットなのかがわかるように


BUNDLED WITH
   1.16.1
