# README

This README would normally document whatever steps are necessary to get the
application up and running.

ER図構成

Users
 |---------------|-----------|
 |Columns        |Description|
 |---------------|-----------|
 |name           |string     |
 |---------------|-----------|
 |email          |string     |
 |---------------|-----------|
 |password_digest|string     |
 |---------------|-----------|

Tasks
 |---------------|-----------|
 |user_id        |brignt     |
 |---------------|-----------|
 |title          |string     |
 |---------------|-----------|
 |content        |text       |
 |---------------|-----------|

Labels-Tasks
 |---------------|-----------|
 |task_id        |brignt     |
 |---------------|-----------|
 |user_id        |brignt     |
 |---------------|-----------|

Labels 
 |---------------|-----------|
 |name           |string     |
 |---------------|-----------| 
 


 [Heroku Deploy Flow]

 GemfileにGemを追加する（Ruby３系を使用している場合）

 gem 'net-smtp'
 gem 'net-imap'
 gem 'net-pop'

 作成しているアプリのディレクトリに行き - heroku create git commitコマンドを使用して、コミット

[1]git add 
   git commit 
   Heroku buildpackを追加する
[2]heroku buildpacks:set heroku/ruby 
   heroku buildpacks:add --index 1 heroku/nodejs
   heroku stack:set heroku- を行いバージョンを変更する
[3]heroku stack:set heroku-20
   heroku stack で現在使われているstackを確認
[4]heroku stack
   package.json に追加記述
[5]"engines": { "node": "16.x" }
   Herokuにデプロイ
[6]git push heroku step2:master
   データベースの移行
[7]heroku run rails db:migrate
