require 'faker/base'

module Faker
  class Photos < Base
    private

    def build_record
      num_posts = Post.count
      Photo.new(
        post_id: (rand * num_posts).ceil,
        photo_url: FFaker::Internet.http_url
      )
    end
  end
end
