# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation



## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique:true|
|email|string|null: false, unique:true|
|password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|profile|text|
|birthday|string|null: false|
|image|string|

### Association
- has_many :addresses
  has_many :cards
  has_many :comments
- has_many :items



# itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index:true|
|price|integer|null: false, index:true|
|size|integer|enum|
|condition|integer|enum, ull: false|
|shipping_date|integer|enum, null: false|
|shipping_price|integer|enum, null: false|
|shipping_area|integer|enum, null: false|
|shipping_method|integer|enum, null: false|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- has_many :group_users
  has_many :users, through: :group_users
  has_many :images
  has_many :comments
  belongs_to :brand
  belongs_to :category



## addressesテーブル

|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|prefectuer|string|null: false|
|city|string|null: false|
|street|string|null: false|
|building|string|
|phone|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|card_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user



## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
  belongs_to :item


## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|null: false, foreign_key: true|

### Association
  belongs_to :item



## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|

### Association
  has_many :items
  has_many :categories,through: :brands_categories



## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|ancestry|integer|index: true|

### Association
  has_many :items
  has_many :brands,through: :brands_categories



## brands_categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|brand_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|

### Association
  belongs_to :brand
  belongs_to :category
  
* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
