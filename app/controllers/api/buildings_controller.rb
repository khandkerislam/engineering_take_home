module Api
  class BuildingsController < ApplicationController
    before_action :set_building, only: [:show, :update]

    def index
      return render json: { error: 'No client_id provided' }, status: :bad_request if params[:client_id].blank?
      client = Client.find(params[:client_id])      
      @buildings = client.buildings
      render json: @buildings
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Client not found' }, status: :not_found
    end

    def show
    end

    def create
      @building = Building.new(building_params.except(:custom_values))
      
      if @building.save
        @building.create_custom_values(building_params[:custom_values])
        render json: @building, status: :created
      else
        render json: { errors: @building.errors }, status: :unprocessable_entity
      end
    end

    def update
    end

    private

    def building_params
      params.require(:building).permit(
        :client_id,
        :address,
        :zip_code_id,
        custom_values: permitted_custom_fields
      )
    end

    def permitted_custom_fields
      return [] unless params.dig(:building, :client_id).present?
    
      @permitted_fields ||= begin
        Client.find(params[:building][:client_id])
              .custom_fields
              .pluck(:name)
      rescue ActiveRecord::RecordNotFound
        []
      end
    end

    def set_building
      @building = Building.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Building not found' }, status: :not_found
    end
  end
end 