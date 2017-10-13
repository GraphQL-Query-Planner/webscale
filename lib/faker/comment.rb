require 'faker/base'

module Faker
  class Comments < Base
    private

    def build_record
      num_posts = Post.count
      num_photos = Photo.count
      content_type = rand < (num_posts.to_f / (num_posts + num_photos)) ? 'Post' : 'Photo'
      num_content = content_type == 'Post' ? num_posts : num_photos

      Comment.new(
        body: FFaker::DizzleIpsum.sentence,
        user_id: (rand * User.count).ceil,
        content_id: (rand * num_content).ceil,
        content_type: content_type
      )
    end
  end
end
