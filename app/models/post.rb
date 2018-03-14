class Post < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks unless Rails.env.test?

  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  has_many :comments, as: :content
  has_many :likes, as: :content
end
