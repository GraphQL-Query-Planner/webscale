require 'faker/base'

module Faker
  class Likes < Base
    private

    def build_record
      num_posts = Post.count
      num_photos = Photo.count
      num_comments = Comment.count
      num_total = num_posts + num_photos + num_comments
      random = rand
      case
      when random < num_posts.to_f / num_total
        content_type = 'Post'
        num_content = num_posts
      when random < (num_posts + num_photos).to_f / num_total
        content_type = 'Photo'
        num_content = num_photos
      else
        content_type = 'Comment'
        num_content = num_comments
      end

      Like.new(
        user_id: (rand * User.count).ceil,
        content_id: (rand * num_content).ceil,
        content_type: content_type
      )
    end
  end
end
