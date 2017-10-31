class Photo < ApplicationRecord
  belongs_to :post

  has_many :comments, as: :content
end
