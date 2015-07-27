class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :name
      t.string :price
      t.references :store, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
