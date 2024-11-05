require 'rails_helper'

RSpec.describe Api::BuildingsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
        get :index, params: { client_id: Client.first.id }
        expect(response).to be_successful
    end
  end
end
