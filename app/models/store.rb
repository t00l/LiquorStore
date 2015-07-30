class Store < ActiveRecord::Base
  include PgSearch
  extend FriendlyId

  has_many :comments

  pg_search_scope :search_by_name, :against => [:name], :associated_against => {
    :offers => [:name]}, :using => {:tsearch => {:prefix => true}}

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  belongs_to :user
  belongs_to :owner
  has_many :offers
  mount_uploader :image, ImageUploader

  friendly_id :name, use: [:slugged, :finders]

end
