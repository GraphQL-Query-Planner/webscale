require 'faker/user'
require 'faker/post'
require 'faker/photo'
require 'faker/comment'
require 'faker/like'

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

  desc "Create comments with data from ffaker."
  task comments: :environment do
    abort('Please add at least one post and/or photo before running this task') if Post.count == 0

    faker = Faker::Comments.new(count(:comments))
    faker.create!
  end

  desc "Create likes."
  task likes: :environment do
    abort('Please add at least one post, photo, or comment before running this task') if Post.count == 0

    faker = Faker::Likes.new(count(:likes))
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
  when :comments
    ENV.fetch("NUM_COMMENTS", 500).to_i
  when :likes
    ENV.fetch("NUM_LIKES", 2000).to_i
  else
    10
  end
end
