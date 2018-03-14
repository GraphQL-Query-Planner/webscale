require 'faker/base'

module Faker
  class Photos < Base
    private

    def build_record
      Photo.new(
        post_id: rand_id,
        photo_url: FFaker::Internet.http_url
      )
    end

    def rand_id
      post_ids[(rand * post_ids.size).floor]
    end

    def post_ids
      @post_ids ||= Post.all.pluck(:id)
    end
  end
end
