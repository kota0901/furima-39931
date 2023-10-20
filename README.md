## データベース設計
ER図はer.dioに記載

## users テーブル


|Column               |Type  |Options                  |
|---------------------|------|-------------------------|
|nickname            |string|null:false               |
|email                |string|null:false, unique: true |
|encrypted_password   |string|null:false               |
|last_name            |string|null:false               |
|first_name           |string|null:false               |
|last_name_kana       |string|null:false               |
|first_name_kana      |string|null:false               | 
|birthday                |date  |null:false               |


### Association

* has_many :items
* has_many :orders

## items テーブル


|Column                  |Type      |Options                       |
|------------------------|----------|------------------------------|
|item_name               |string    |null:false                    |
|category_id             |integer   |null:false                    |
|condition_id            |integer   |null:false                    |
|delivery_fee_payment_id |integer   |null:false                    |
|region_id               |integer   |null:false                    |
|deadline_id             |integer   |null:false                    |
|price                   |integer   |null:false                    |
|item_text               |text      |null:false                    |
|user                    |references|null:false,  foreign_key: true|



### Association

* belongs_to :user
* has_one :order

## orders テーブル


|Column|Type      |Options                      |
|------|----------|-----------------------------|
|user  |references|null:false, foreign_key: true|
|item  |references|null:false, foreign_key: true|


### Association

* belongs_to :user
* belongs_to :item
* has_one :address

## addresses テーブル

|Column        |Type      |Options                      |
|--------------|----------|-----------------------------|
|post_code     |string    |null:false                   |
|region_id     |integer   |null:false                   |
|municipalities|string    |null:false                   |
|banchi        |string    |null:false                   |
|building_name |string    |                             |
|number        |string    |null:false                   |
|order         |references|null:false, foreign_key: true|

### Association

* belongs_to :order