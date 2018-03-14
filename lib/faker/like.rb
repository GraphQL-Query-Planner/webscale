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
        content_id = rand_id(post_ids)
      when random < (num_posts + num_photos).to_f / num_total
        content_type = 'Photo'
        content_id = rand_id(photo_ids)
      else
        content_type = 'Comment'
        content_id = rand_id(comment_ids)
      end

      Like.new(
        user_id: rand_id(user_ids),
        content_id: content_id,
        content_type: content_type
      )
    end

    def rand_id(record_ids)
      record_ids[(rand * record_ids.size).floor]
    end

    def photo_ids
      @photo_ids ||= Photo.all.pluck(:id)
    end

    def comment_ids
      @comment_ids ||= Comment.all.pluck(:id)
    end

    def post_ids
      @post_ids ||= Post.all.pluck(:id)
    end

    def user_ids
      @user_ids ||= User.all.pluck(:id)
    end
  end
end
