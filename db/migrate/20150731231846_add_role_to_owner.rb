class AddRoleToOwner < ActiveRecord::Migration
  def change
    add_column :owners, :role, :integer
  end
end
