class User < ApplicationRecord
  has_many :posts, foreign_key: :user_id
  has_many :wall_posts, foreign_key: :receiver_id

  has_many :comments
  has_many :likes
end
