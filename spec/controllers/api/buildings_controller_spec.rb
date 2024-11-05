require 'rails_helper'

RSpec.describe Api::BuildingsController, type: :controller do
  describe 'GET #index' do
    let(:client) { create(:client, :with_buildings_and_custom_values) }

    it 'returns a successful response' do
        get :index, params: { client_id: client.id }
        expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:client) { create(:client, :with_custom_fields) }
    let(:zip_code) { create(:zip_code) }
    
    context 'with valid attributes' do
      let(:valid_attributes) do
        {
          client_id: client.id,
          address: "Test Address",
          zip_code_id: zip_code.id,
          custom_values: {
            client.custom_fields.first.name => "Value 1",
            client.custom_fields.second.name => "Value 2",
            client.custom_fields.third.name => "Value 3"
          }
        }
      end

      it 'creates a building with custom values and returns success' do
        expect { 
          post :create, params: { building: valid_attributes } 
        }.to change(Building, :count).by(1)
          .and change(BuildingCustomValue, :count).by(3)

        expect(response).to be_successful
        expect(response).to have_http_status(:created)
        
        building = Building.last
        expect(building.client).to eq(client)
        expect(building.zip_code).to eq(zip_code)
        expect(building.address).to eq("Test Address")
        expect(building.building_custom_values.first.value).to eq("Value 1")
        expect(building.building_custom_values.second.value).to eq("Value 2")
        expect(building.building_custom_values.third.value).to eq("Value 3")
      end
    end
  end
end
