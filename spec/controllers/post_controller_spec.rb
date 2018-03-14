require 'rails_helper'

describe PostsController, type: :controller, elasticsearch: true do
  describe "GET index" do
    let(:posts) { Faker::Posts.new(3).create }

    it "returns HTTP status 200" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'GET show' do
    let(:post) { create(:post) }

    it 'returns HTTP status 200' do
      get :index
      expect(response.status).to eq 200
    end

    it 'returns a post' do
      get :show, params: { id: post.id }
      body = JSON.parse(response.body)
      expect(body['body']).to eq(post.body)
      expect(body['author_id']).to eq(post.author_id)
      expect(body['receiver_id']).to eq(post.receiver_id)
    end
  end

  describe 'POST create' do
    let(:post) { create(:post) }

    skip "returns 201 when create is successful" do
      post :create, params: {
        body: post.body,
        author_id: post.author_id,
        receiver_id: post.receiver_id
      }
      expect(response.status).to eq 201
    end
  end

  describe "PUT update" do
    context 'with existing post' do
      let(:post) { create(:post) }

      it "responds with updated post when update is successful" do
        put :update, params: {
          id: post.id,
          body: 'body test'
        }
        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body['body']).to eq 'body test'
      end
    end
  end

  describe "DELETE destroy" do
    context 'with an existing post' do
      let(:post) { create(:post) }

      it "responds with ok when destroy is successful" do
        delete :destroy, params: {
          id: post.id
        }
        expect(response.status).to eq 200
      end
    end
  end
end
