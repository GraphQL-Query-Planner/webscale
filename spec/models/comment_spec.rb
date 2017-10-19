require 'rails_helper'

describe Comment, type: :model do
  context 'initialized with content type post' do
    let(:user) { build(:user) }
    let(:post) { build(:post) }
    let(:comment) { build(:comment, author: user, content: post) }

    it 'has an author' do
      expect(comment.author).to eq user
    end

    it 'has is associated to a post' do
      expect(comment.content).to eq post
    end
  end

  context 'initialized with content type photo' do
    let(:user) { build(:user) }
    let(:photo) { build(:photo) }
    let(:comment) { build(:comment, author: user, content: photo) }

    it 'has is associated to a photo' do
      expect(comment.content).to eq photo
    end
  end
end
