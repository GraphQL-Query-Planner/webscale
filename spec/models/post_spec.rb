require 'rails_helper'

describe Post, type: :model, elasticsearch: true do
  context 'initialized with associations' do
    let(:user) { build(:user) }
    let(:post) { build(:post, author: user, receiver: user) }

    it 'has an author' do
      expect(post.author).to eq user
    end

    it 'has a receiver' do
      expect(post.receiver).to eq user
    end
  end
end
