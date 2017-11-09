require 'rails_helper'

describe PhotosController, type: :controller do
  describe "GET index" do
    let(:photos) { Faker::Users.new(3).create! }

    it "returns HTTP status 200" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'GET show' do
    let(:photo) { create(:photo) }

    it 'returns HTTP status 200' do
      get :index
      expect(response.status).to eq 200
    end

    it 'returns a photo' do
      get :show, params: { id: photo.id }
      body = JSON.parse(response.body)
      expect(body['post_id']).to eq(photo.post_id)
      expect(body['photo_url']).to eq(photo.photo_url)
    end
  end

  describe 'POST create' do
    let(:photo) { create(:photo) }

    it "returns 201 when create is successful" do
      post :create, params: {
        post_id: photo.post_id,
        photo_url: photo.photo_url,
      }
      expect(response.status).to eq 201
    end
  end

  describe "PUT update" do
    context 'with existing post' do
      let(:photo) { create(:photo) }

      it "responds with updated photo when update is successful" do
        put :update, params: {
          id: photo.id,
          photo_url: 'someurl.com'
        }
        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body['photo_url']).to eq 'someurl.com'
      end
    end
  end

  describe "DELETE destroy" do
    context 'with an existing photo' do
      let(:photo) { create(:photo) }

      it "responds with ok when destroy is successful" do
        delete :destroy, params: {
          id: photo.id
        }
        expect(response.status).to eq 200
      end
    end
  end
end
