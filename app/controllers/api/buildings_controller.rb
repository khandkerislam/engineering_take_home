module Api
  class BuildingsController < ApplicationController
    before_action :set_building, only: [ :show, :update ]

    def index
      return render json: { error: "No client_id provided" }, status: :bad_request if params[:client_id].blank?

      @buildings = Building.includes(:building_custom_values, :client)
                        .where(client_id: params[:client_id])
                        .page(params[:page])
                        .per(params[:per_page] || 5)

      render json: {
        buildings: @buildings.map { |building|
          {
            id: building.id,
            client_name: building.client.name,
            address: building.full_address,
            **building.building_custom_values.to_h { |cv| [ cv.custom_field.name, cv.value ] }
          }
        },
        meta: {
          current_page: @buildings.current_page,
          total_pages: @buildings.total_pages,
          total_count: @buildings.total_count,
          per_page: @buildings.limit_value
        }
      }
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Client not found" }, status: :not_found
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
      if @building.update(building_params.except(:custom_values))
        @building.update_custom_values(building_params[:custom_values])
        render json: @building, status: :ok
      else
        render json: { errors: @building.errors }, status: :unprocessable_entity
      end
    end

    private

    def building_params
      params.require(:building).permit(
        :id,
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
      render json: { error: "Building not found" }, status: :not_found
    end
  end
end
