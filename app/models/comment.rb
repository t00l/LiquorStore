class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :store
  belongs_to :owner
end
