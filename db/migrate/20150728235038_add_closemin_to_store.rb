class AddCloseminToStore < ActiveRecord::Migration
  def change
    add_column :stores, :closemin, :string
  end
end
