class RemoveRoleFromOwner < ActiveRecord::Migration
  def change
    remove_column :owners, :role, :string
  end
end
