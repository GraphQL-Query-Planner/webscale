class Comment < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks unless Rails.env.test?

  belongs_to :author, class_name: 'User'
  belongs_to :content, polymorphic: true

  has_many :likes, as: :content
end
