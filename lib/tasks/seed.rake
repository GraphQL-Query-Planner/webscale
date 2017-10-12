require 'faker/user'
require 'faker/post'
require 'faker/photo'

namespace :seed do
  desc "Create users with data from ffaker."
  task users: :environment do
    faker = Faker::Users.new(count(:users))
    faker.create!
  end

  desc "Create posts with data from ffaker."
  task posts: :environment do
    abort('Please add at least one user before running this task') if User.count == 0
    faker = Faker::Posts.new(count(:posts))
    faker.create!
  end

  desc "Create photos with data from ffaker."
  task photos: :environment do
    abort('Please add at least one post before running this task') if Post.count == 0
    faker = Faker::Photos.new(count(:photos))
    faker.create!
  end
end

def count(task_name)
  case task_name
  when :users
    ENV.fetch("NUM_USERS", 50).to_i
  when :posts
    ENV.fetch("NUM_POSTS", 1000).to_i
  when :photos
    ENV.fetch("NUM_PHOTOS", 200).to_i
  else
    10
  end
end
