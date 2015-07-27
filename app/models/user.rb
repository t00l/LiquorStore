class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :stores

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  enum role: [:guest, :moderator]

end
