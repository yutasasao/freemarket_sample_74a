class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.integer :size
      t.integer :condition
      t.integer :shipping_date
      t.integer :shipping_price
      t.integer :shipping_area
      t.integer :shipping_method
      t.integer :seller_id
      t.integer :buyer_id
      t.references :category,foreign_key: true
      t.references :brand,foreign_key: true
      t.references :user,foreign_key: true
      t.timestamps
    end
  end
end
