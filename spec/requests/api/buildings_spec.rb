require 'rails_helper'

RSpec.describe "Api::Buildings", type: :request do
  let(:client) { create(:client, :with_buildings_and_custom_values) }
  
  describe "GET /api/buildings" do
    context "with valid client_id" do
      before do
        get "/api/buildings", params: { client_id: client.id }
      end
      let(:json_response) { JSON.parse(response.body) }

      it "returns success status" do
        expect(response).to have_http_status(:success)
      end

      it "returns all buildings for the client" do
        expect(json_response.size).to eq(client.buildings.size)
      end

      it "returns buildings with correct attributes" do
        expect(json_response.first).to include(
          'id' => client.buildings.first.id,
          'address' => client.buildings.first.address
        )
      end
    end

    context "with invalid client_id" do
      it "returns not found status" do
        get "/api/buildings", params: { client_id: 'invalid' }
        expect(response).to have_http_status(:not_found)
      end
    end

    context "without client_id" do
      it "returns bad request status" do
        get "/api/buildings"
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end 