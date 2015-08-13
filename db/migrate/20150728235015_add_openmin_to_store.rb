class AddOpenminToStore < ActiveRecord::Migration
  def change
    add_column :stores, :openmin, :string
  end
end
