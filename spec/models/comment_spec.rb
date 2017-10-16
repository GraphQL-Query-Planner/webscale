require 'rails_helper'

describe Comment, type: :model do
  context 'initialized with content type post' do
    before :each do
      @user = Faker::Users.new(1).create!.first
      @post = Faker::Posts.new(1).create!.first
      @comment = Faker::Comments.new(1).build.first
    end

    it 'has an author' do
      expect(@comment.author).to eq @user
    end

    it 'has is associated to a post' do
      expect(@comment.content).to eq @post
    end
  end

  context 'initialized with content type photo' do
    before :each do
      user = Faker::Users.new(1).create!.first
      post = Faker::Posts.new(1).create!.first
      @photo = Faker::Photos.new(1).create!.first
      @comment = Comment.new(author: @user, content: @photo)
    end

    it 'has is associated to a photo' do
      expect(@comment.content).to eq @photo
    end
  end
end
