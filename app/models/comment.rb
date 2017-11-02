class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :content, polymorphic: true

  has_many :likes, as: :content
end
