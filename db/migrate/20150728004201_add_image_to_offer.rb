class AddImageToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :image, :string
  end
end
