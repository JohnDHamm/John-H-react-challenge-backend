# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'GET /users/:id/appointments' do
    let!(:user) { create(:user) }
    let!(:appointments) { create_list(:appointment, 3, user: user) }
    let(:appointment_id) { appointments.first.id }

    context 'when user id exists' do
      context 'and user has appointments' do
        before { get "/users/#{user.id}/appointments" }

        it "returns user's appointments" do
          expect(json).not_to be_empty

          expect(json).to eq(JSON.parse(appointments.to_json))
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'and user has no appointments' do
        let!(:appointments) { [] }

        before { get "/users/#{user.id}/appointments" }

        it 'returns an empty array' do
          expect(json).to be_empty
          expect(json).to eq []
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end
    end

    context 'when user id does not exist' do
      before { get "/users/#{user.id + 100}/appointments" }

      it "returns a couldn't find user message" do
        expect(response.body).to match(/Couldn't find User/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /users/sign-in' do
    let!(:user) { create(:user) }

    context 'when the credentials are correct' do
      before { get "/users/sign-in?username=#{user.username}&password=#{user.password}" }

      it "returns user's id" do
        expect(json).not_to be_empty

        expect(json['id']).to eq(user.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "when the user's username doesn't exist" do
      before { get "/users/sign-in?username=shouldntexist&password=#{user.password}" }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context "when the user's password doesn't match" do
      before { get "/users/sign-in?username=#{user.username}&password=shouldntexist" }

      it 'returns an incorrect password message' do
        expect(response.body).to match(/Incorrect password/)
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /users/sign-up' do
    let(:username) { 'test1' }
    let(:password) { 'test1' }

    context 'when a username and password are provided' do
      before { get "/users/sign-up?username=#{username}&password=#{password}" }

      it "returns the created user's id" do
        expect(json['id']).to eq(User.last.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when no username is provided' do
      before { get "/users/sign-up?password=#{password}" }

      it "returns a username can't be blank message" do
        expect(response.body).to match(/Username can't be blank/)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when no password is provided' do
      before { get "/users/sign-up?username=#{username}" }

      it "returns a password can't be blank message" do
        expect(response.body).to match(/Password can't be blank/)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
