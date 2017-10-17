require 'rails_helper'

describe Photo, type: :model do
  context 'initialized with associations' do
    let(:post) { build(:post) }
    let(:photo) { build(:photo, post: post) }

    it 'belongs to a post' do
      expect(photo.post).to eq post
    end
  end
end
