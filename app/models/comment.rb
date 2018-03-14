class Comment < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :author, class_name: 'User'
  belongs_to :content, polymorphic: true

  has_many :likes, as: :content
end
