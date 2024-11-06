module Api
  class ClientsController < ApplicationController
    def index
      @clients = Client.includes(:buildings, :custom_fields)
                        .page(params[:page])
                        .per(params[:per_page] || 1)    
      
      render json: {
        clients: @clients.map { |client| client_json(client) },
        meta: pagination_meta(@clients)
      }
    rescue StandardError => e
      render json: { error: "Failed to load clients" }, 
             status: :internal_server_error
    end

    private

    def client_json(client)
      {
        id: client.id,
        name: client.name,
        buildings: client.buildings,
        custom_fields: client.custom_fields
      }
    end

    def pagination_meta(collection)
      {
        current_page: collection.current_page,
        total_pages: collection.total_pages,
        total_count: collection.total_count,
        per_page: collection.limit_value
      }
    end
  end
end
