class AddOwnerToStore < ActiveRecord::Migration
  def change
    add_reference :stores, :owner, index: true, foreign_key: true
  end
end
