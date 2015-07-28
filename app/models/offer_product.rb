class OfferProduct < ActiveRecord::Base
  belongs_to :store_product
  belongs_to :offer
end
