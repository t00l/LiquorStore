class Product < ActiveRecord::Base
  has_many :store_products
end
