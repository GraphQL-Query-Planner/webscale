require 'rails_helper'

describe UsersController, type: :controller do
  describe "GET index" do
    let(:users) { Faker::Users.new(3).create }

    it "returns HTTP status 200" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'GET show' do
    let(:user) { create(:user) }

    it 'returns HTTP status 200' do
      get :index
      expect(response.status).to eq 200
    end

    it 'returns the user with id=3' do
      get :show, params: { id: user.id }
      body = JSON.parse(response.body)
      expect(body['id']).to eq(user.id)
      expect(body['email']).to eq(user.email)
    end
  end

  describe 'POST create' do
    let(:user) { create(:user) }

    it "returns 201 when create is successful" do
      post :create, params: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email
      }
      expect(response.status).to eq 201
    end
  end

  describe "PUT update" do
    context 'with existing user' do
      let(:user) { create(:user) }

      it "responds with updated user when update is successful" do
        put :update, params: {
          id: user.id,
          email: 'test@test.com'
        }
        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body['email']).to eq 'test@test.com'
      end
    end
  end

  describe "DELETE destroy" do
    context 'with an existing user ' do
      let(:user) { create(:user) }

      it "responds with ok when destroy is successful" do
        delete :destroy, params: {
          id: user.id
        }
        expect(response.status).to eq 200
      end
    end
  end
end
