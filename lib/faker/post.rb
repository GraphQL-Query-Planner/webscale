require 'faker/base'

module Faker
  class Posts < Base
    private

    def build_record
      num_users = User.count
      Post.new(
        body: FFaker::DizzleIpsum.paragraph,
        user_id: (rand * num_users).ceil,
        receiver_id: (rand * num_users).ceil
      )
    end
  end
end
