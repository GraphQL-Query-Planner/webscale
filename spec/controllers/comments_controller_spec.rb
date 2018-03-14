require 'rails_helper'

describe CommentsController, type: :controller, elasticsearch: true do
  describe "GET index" do
    context 'initialized with content type post' do
      let(:user) { create(:user) }
      let(:post) { create(:post) }
      let(:comment) { create(:post_comment, author: user, content: post) }

      it "renders the comments index" do
        get :index
        expect(response.status).to eq 200
      end
    end
  end

  describe "GET show" do
    context 'initialized with content type post' do
      let(:user) { create(:user) }
      let(:post) { create(:post) }
      let(:comment) { create(:post_comment, author: user, content: post) }

      it "renders the comment" do
        get :show, params: { id: comment.id }
        expect(response.status).to eq 200
      end
    end
  end

  describe "POST create" do
    context 'with existing user and post' do
      let(:user) { create(:user) }
      let(:comment_post) { create(:post) }

      it "responds with the commment when create is successful" do
        post :create, params: {
          body: 'test',
          author_id: user.id,
          content_id: comment_post.id,
          content_type: 'Post'
        }
        expect(response.status).to eq 201
      end

      it "responds with 422 when the content does not exist" do
        post :create, params: {
          body: 'test',
          author_id: user.id,
          content_id: 0,
          content_type: 'Post'
        }
        expect(response.status).to eq 422
      end

      it "responds with 422 when the content does not exist" do
        post :create, params: {
          body: 'test',
          author_id: user.id,
          content_id: comment_post.id,
          content_type: 'Something'
        }
        expect(response.status).to eq 422
      end
    end
  end

  describe "PUT update" do
    context 'with existing comment' do
      let(:user) { create(:user) }
      let(:post) { create(:post) }
      let(:comment) { create(:post_comment, author: user, content: post) }

      it "responds with updated comment when update is successful" do
        put :update, params: {
          id: comment.id,
          body: 'test',
        }
        expect(response.status).to eq 200
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['body']).to eq 'test'
      end
    end
  end

  describe "DELETE destroy" do
    context 'with existing comment' do
      let(:user) { create(:user) }
      let(:post) { create(:post) }
      let(:comment) { create(:post_comment, author: user, content: post) }

      it "responds with ok when destroy is successful" do
        delete :destroy, params: {
          id: comment.id
        }
        expect(response.status).to eq 200
      end
    end
  end
end
