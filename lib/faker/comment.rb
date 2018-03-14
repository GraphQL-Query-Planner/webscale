require 'faker/base'

module Faker
  class Comments < Base
    private

    def build_record
      num_posts = Post.count
      num_photos = Photo.count
      content_type = rand < (num_posts.to_f / (num_posts + num_photos)) ? 'Post' : 'Photo'
      content_id = content_type == 'Post' ? rand_id(post_ids) : rand_id(photo_ids)

      Comment.new(
        body: FFaker::DizzleIpsum.sentence,
        author_id: rand_id(user_ids),
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

    def post_ids
      @post_ids ||= Post.all.pluck(:id)
    end

    def user_ids
      @user_ids ||= User.all.pluck(:id)
    end
  end
end
