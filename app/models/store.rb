class Store < ActiveRecord::Base
  include PgSearch
  extend FriendlyId

  ratyrate_rateable 'rate'

  has_many :offers
  has_many :comments
  belongs_to :user
  belongs_to :owner
  
  pg_search_scope :search_by_name, :against => [:name], :associated_against => {
    :offers => [:name]}, :using => {:tsearch => {:prefix => true}}

  geocoded_by :address

  after_validation :geocode, :if => :address_changed?

  after_validation :reverse_geocode


  mount_uploader :image, ImageUploader

  friendly_id :name, use: [:slugged, :finders]

end
