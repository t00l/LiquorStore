class AddOwnerToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :owner, index: true, foreign_key: true
  end
end
