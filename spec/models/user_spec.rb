require 'rails_helper'

describe User, type: :model do
  context 'initialized with empty associations' do
    let(:user) { build(:user) }

    it 'has made no posts' do
      expect(user.posts).to be_empty
    end

    it 'has no posts on its wall' do
      expect(user.wall).to be_empty
    end

    it 'has made no comments' do
      expect(user.comments).to be_empty
    end

    it 'has not liked any content' do
      expect(user.likes).to be_empty
    end
  end
end
