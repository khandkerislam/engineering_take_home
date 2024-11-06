require 'rails_helper'

RSpec.describe Api::ClientsController, type: :request do
  describe 'GET /api/clients' do
    context 'when the request is successful' do
      let!(:client) { create(:client, :with_buildings_and_custom_fields) }

      before do
        get '/api/clients'
      end

      let(:json_response) { JSON.parse(response.body) }

      it 'returns success status' do
        expect(response).to have_http_status(:success)
      end

      it 'returns all clients' do
        expect(json_response['clients']).to be_an(Array)
        expect(json_response['clients'].size).to eq(1)
      end

      it 'returns all buildings for the client' do
        expect(json_response['clients'].first['buildings'].size).to eq(client.buildings.size)
      end

      it 'returns buildings with correct attributes' do
        expect(json_response['clients'].first['buildings'].first).to include(
          'id' => client.buildings.first.id,
          'address' => client.buildings.first.address
        )
      end

      it 'returns custom fields for the client' do
        expect(json_response['clients'].first['custom_fields'].size).to eq(client.custom_fields.size)
      end
    end

    context 'when an error occurs' do
      before do
        allow(Client).to receive(:all).and_raise(StandardError.new('Failed to fetch clients'))
        get '/api/clients'
      end

      it 'returns error message' do
        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to include('Failed to load clients')
      end
    end
  end
end
