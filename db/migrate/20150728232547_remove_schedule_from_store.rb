class RemoveScheduleFromStore < ActiveRecord::Migration
  def change
    remove_column :stores, :schedule, :string
  end
end
