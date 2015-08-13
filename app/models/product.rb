class Product < ActiveRecord::Base
  has_many :stores, through: :store_products
end
