class Faker
  attr_reader :default_count
  def initialize(default_count = 5)
    @default_count = default_count
  end

  def create_users(count = default_count)
    build_users.each { |user| user.save! }
  end

  def build_users(count = default_count)
    count.times.map do
      first_name = FFaker::Name.first_name
      User.new(
        first_name: first_name,
        last_name: FFaker::Name.last_name,
        email: FFaker::Internet.email(first_name)
      )
    end
  end
end
