class Post < ApplicationRecord
  belongs_to :author, foreign_key: :user_id
  belongs_to :receiver, foreign_key: :receiver_id

  has_many :comments, as: :content
end
