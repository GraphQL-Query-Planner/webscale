require 'faker'

namespace :seed do
  desc "Create users with data from ffaker."
  task users: :environment do
    faker = Faker.new(count)
    faker.create_users
  end
end

def count
  ENV.fetch('NUM', 5).to_i
end
