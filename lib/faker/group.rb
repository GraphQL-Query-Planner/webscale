require 'faker/base'

module Faker
  class Groups < Base
    private

    def build_record
      Group.new(
        name: FFaker::Name.last_name
      )
    end
  end
end
