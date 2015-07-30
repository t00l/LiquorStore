class AddRoleToOwner < ActiveRecord::Migration
  def change
    add_column :owners, :role, :string
  end
end
