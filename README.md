# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| username           | string | null: false               |
| email              | string | null: false               |
| encrypted_password | string | null: false               |

### Association

- has_many :articles

## articles テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| title       | string     | null: false                    |
| text        | text       | null: false                    |

### Association

- belongs_to :user

