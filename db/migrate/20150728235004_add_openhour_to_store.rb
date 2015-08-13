class AddOpenhourToStore < ActiveRecord::Migration
  def change
    add_column :stores, :openhour, :string
  end
end
