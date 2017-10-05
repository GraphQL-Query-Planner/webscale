class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true

  scope :posts, -> { where(content_type: 'Post') }
  scope :photos, -> { where(content_type: 'Photo') }
end
