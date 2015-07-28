class StoreProduct < ActiveRecord::Base
  belongs_to :store
  belongs_to :product
  has_many :offer_products
end
