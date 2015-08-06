class Store < ActiveRecord::Base
  include PgSearch
  extend FriendlyId

  pg_search_scope :search_by_name, :against => [:name], :associated_against => {
    :offers => [:name]}, :using => {:tsearch => {:prefix => true}}

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  after_validation :reverse_geocode
  belongs_to :user
  has_many :offers
  mount_uploader :image, ImageUploader

  friendly_id :name, use: [:slugged, :finders]

end
