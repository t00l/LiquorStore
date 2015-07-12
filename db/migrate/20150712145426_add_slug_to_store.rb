class AddSlugToStore < ActiveRecord::Migration
  def change
    add_column :stores, :slug, :string
    add_index :stores, :slug, unique: true
  end
end
