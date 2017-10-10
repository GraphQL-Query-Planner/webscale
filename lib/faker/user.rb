require 'faker/base'

module Faker
  class Users < Base
    private

    def build_record
      first_name = FFaker::Name.first_name
      User.new(
        first_name: first_name,
        last_name: FFaker::Name.last_name,
        email: FFaker::Internet.email(first_name)
      )
    end
  end
end
