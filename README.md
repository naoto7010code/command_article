# アプリケーション名

CommandArticle

# アプリケーション概要

スマートフォンやパソコンの便利なコマンド（ショートカットキー等）を投稿し情報を共有できる。

# URL

https://command-article.onrender.com/

# テスト用アカウント

・Basic認証ID：admin

・Basic認証パスワード：2222
  
・ユーザー名：a

・メールアドレス：a@a

・パスワード：aaaaaa

# 利用方法

## 投稿

1.トップページの新規登録からユーザー登録を行う

2.投稿ボタンから共有したい情報を投稿する


https://user-images.githubusercontent.com/108635842/214105607-edf9a594-39b1-4806-b53e-1a73d0c63da1.mov


## コメント

1.投稿の詳細画面に移動する

2.使い方や疑問点等についてコメントする


https://user-images.githubusercontent.com/108635842/214107622-aef21085-7202-4bce-8f90-0d2e746dd2d3.mov


# アプリケーションを作成した背景

スマートフォン等の電子端末が普及している中で、使い方や便利な操作を知るための掲示板があるとよいと考え開発することにした。インターネットでの検索では欲しい情報をこちらから探さなければならないため、そもそも、便利な機能が使えるということを知っていないといけない。そのため、掲示板のような多くのユーザーがリアルタイムで情報を投稿することで、掲示板を閲覧するだけで有益な情報を得られる。

# 要件

https://docs.google.com/spreadsheets/u/0/d/134xzFRrH9MiHPwxDCdIpge9oMOTQVenv3ViSKr9VXcg/edit

# 実装した機能について

・一覧表示機能

・投稿機能

https://user-images.githubusercontent.com/108635842/214105607-edf9a594-39b1-4806-b53e-1a73d0c63da1.mov

・削除機能


https://user-images.githubusercontent.com/108635842/214108003-8bd8b355-3925-4f0c-ad6b-a9e6c307b23f.mov


・編集機能


https://user-images.githubusercontent.com/108635842/214108435-f4a5e8a8-e747-4583-bbca-3591498b3d54.mov


・詳細表示機能


https://user-images.githubusercontent.com/108635842/214109105-c5360b60-5793-4aca-9cb5-ad82d683e5d9.mov


・ユーザー新規登録機能/ログイン機能


https://user-images.githubusercontent.com/108635842/214109503-b068fc70-74c5-46ee-bfbb-8551e762480d.mov


・コメント機能

https://user-images.githubusercontent.com/108635842/214107622-aef21085-7202-4bce-8f90-0d2e746dd2d3.mov

・検索機能


https://user-images.githubusercontent.com/108635842/214108663-b86e5acc-1c9b-4ba0-92d2-faac287220ec.mov


# 実装予定の機能

・画像添付機能

・お気に入り機能

# データベース設計

[![Image from Gyazo](https://i.gyazo.com/4e507f3097ec9d57035ee65cc4b7d431.png)](https://gyazo.com/4e507f3097ec9d57035ee65cc4b7d431)

# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| username           | string | null: false               |
| email              | string | null: false               |
| encrypted_password | string | null: false               |

### Association

- has_many :articles
- has_many :comments

## articles テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| title       | string     | null: false                    |
| text        | text       | null: false                    |

### Association

- belongs_to :user
- has_many   :comments

## comments テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| article     | references | null: false                    |
| text        | text       | null: false                    |

### Association

- belongs_to :user
- belongs_to :article

# 画面遷移図

[![Image from Gyazo](https://i.gyazo.com/00fae1f14642480e8c77f0102bc212c1.png)](https://gyazo.com/00fae1f14642480e8c77f0102bc212c1)

# 開発環境

・フロントエンド

・バックエンド

・テキストエディタ

## 工夫した点

サーバーサイドとして必要なMVC・データベースといった基礎の理解を成果物としてアウトプットできるか取り組みました。