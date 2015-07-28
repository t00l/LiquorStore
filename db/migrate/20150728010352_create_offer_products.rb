class CreateOfferProducts < ActiveRecord::Migration
  def change
    create_table :offer_products do |t|
      t.references :store_product, index: true, foreign_key: true
      t.references :offer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
