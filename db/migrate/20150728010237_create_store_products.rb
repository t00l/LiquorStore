class CreateStoreProducts < ActiveRecord::Migration
  def change
    create_table :store_products do |t|
      t.float :price
      t.references :store, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
