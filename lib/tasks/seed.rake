require 'faker/user'

namespace :seed do
  desc "Create users with data from ffaker."
  task users: :environment do
    faker = Faker::Users.new(count(:users))
    faker.create!
  end
end

def count(task_name)
  case task_name
  when :users
    ENV.fetch("NUM_USERS", 50)
  else
    10
  end
end
