# README

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


###### メモ

* jsでうまう行かなかったら検証→コンソールを見ること
* capybara　=> test時クリックしたりするやつ
* 

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



