class Owner < ActiveRecord::Base

  before_save :default_values_owner
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stores
  has_many :comments

  # enum role: [:guest, :owner, :moderator]
    enum role: [:owner]

  def default_values_owner
    self.role ||= 0
  end

end
