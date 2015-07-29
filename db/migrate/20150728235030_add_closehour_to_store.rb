class AddClosehourToStore < ActiveRecord::Migration
  def change
    add_column :stores, :closehour, :string
  end
end
