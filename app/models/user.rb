class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :default_values

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :stores
  has_many :comments
  
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  enum role: [:guest, :moderator]

  def default_values
    self.role ||= 0
  end


end
