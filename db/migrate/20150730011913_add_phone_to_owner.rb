class AddPhoneToOwner < ActiveRecord::Migration
  def change
    add_column :owners, :phone, :string
    add_column :owners, :rut, :string
    add_column :owners, :name, :string
  end
end
