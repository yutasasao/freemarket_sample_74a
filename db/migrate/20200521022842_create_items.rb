class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false, index: true
      t.integer :price, null: false, index: true
      t.integer :condition_id, null: false
      t.text :explanation, null: false
      t.integer :shipping_date, null: false
      t.integer :shipping_price, null: false
      t.integer :shipping_area_id, null: false
      t.integer :shipping_method_id, null: false
      t.integer  :buyer_id
      t.integer  :saler_id, null: false
      t.integer :category_id, null: false, foreign_key: true
      #  ※integer型に！
      t.integer :brand_id, null: false, foreign_key: true
      t.integer :user_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
