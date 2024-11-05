module Api
  class BuildingsController < ApplicationController
    before_action :set_building, only: [:show, :update, :destroy]

    def index
      return render json: { error: 'No client_id provided' }, status: :bad_request if params[:client_id].blank?
      client = Client.find(params[:client_id])      
      @buildings = client.buildings
      render json: @buildings
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Client not found' }, status: :not_found
    end

    private

    def building_params
      params.require(:building).permit(
        :client_id
      )
    end
  end
end 