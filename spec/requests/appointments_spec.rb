require 'rails_helper'

RSpec.describe 'Appointments API', type: :request do
  let!(:user) { create(:user) }
  let!(:appointments) { create_list(:appointment, 3, user: user) }
  let(:appointment_id) { appointments.first.id }

  describe 'GET /appointments/:id' do
    before { get "/appointments/#{appointment_id}?user_id=#{user.id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(appointment_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:appointment_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end
  end
end
