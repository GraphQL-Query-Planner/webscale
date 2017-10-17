require 'rails_helper'

describe Like, type: :model do
  context 'initialized with content type post' do
    let(:user) { build(:user) }
    let(:post) { build(:post) }
    let(:like) { build(:like, user: user, content: post) }

    it 'has an user' do
      expect(like.user).to eq user
    end

    it 'has is associated to a post' do
      expect(like.content).to eq post
    end
  end

  context 'initialized with content type photo' do
    let(:photo) { build(:photo) }
    let(:like) { build(:like, content: photo) }

    it 'has is associated to a photo' do
      expect(like.content).to eq photo
    end
  end

  context 'initialized with content type comment' do
    let(:comment) { build(:comment) }
    let(:like) { build(:like, content: comment) }

    it 'has is associated to a photo' do
      expect(like.content).to eq comment
    end
  end
end
