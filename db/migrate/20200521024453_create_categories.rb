class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
        t.string :name
        # ↑事前にデータを登録しておくのでnull false制約は外しておく
        t.string :ancestry
        t.timestamps
    end
  end
end
