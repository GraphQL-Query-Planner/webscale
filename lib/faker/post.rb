require 'faker/base'

module Faker
  class Posts < Base
    private

    def build_record
      Post.new(
        body: FFaker::DizzleIpsum.paragraph,
        author_id: rand_id,
        receiver_id: rand_id
      )
    end

    def rand_id
      user_ids[(rand * user_ids.size).floor]
    end

    def user_ids
      @user_ids ||= User.all.pluck(:id)
    end
  end
end
