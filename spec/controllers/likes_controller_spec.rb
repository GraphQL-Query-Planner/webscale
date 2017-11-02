require 'rails_helper'

describe LikesController, type: :controller do
  describe "GET index" do
    context 'initialized with content type post' do
      let(:user) { create(:user) }
      let(:post) { create(:post) }
      let(:like) { create(:post_like, user: user, content: post) }

      it "renders the likes index" do
        get :index
        expect(response.status).to eq 200
      end
    end
  end

  describe "POST create" do
    context 'with existing user and post' do
      let(:user) { create(:user) }
      let(:like_post) { create(:post) }

      it "responds with the commment when create is successful" do
        post :create, params: {
          user_id: user.id,
          content_id: like_post.id,
          content_type: 'Post'
        }
        expect(response.status).to eq 201
      end

      it "responds with 422 when the content does not exist" do
        post :create, params: {
          user_id: user.id,
          content_id: 0,
          content_type: 'Post'
        }
        expect(response.status).to eq 422
      end

      it "responds with 422 when the content does not exist" do
        post :create, params: {
          user_id: user.id,
          content_id: like_post.id,
          content_type: 'Something'
        }
        expect(response.status).to eq 422
      end
    end
  end

  describe "DELETE destroy" do
    context 'with existing like' do
      let(:user) { create(:user) }
      let(:post) { create(:post) }
      let(:like) { create(:post_like, user: user, content: post) }

      it "responds with ok when destroy is successful" do
        delete :destroy, params: {
          id: like.id
        }
        expect(response.status).to eq 200
      end
    end
  end
end
