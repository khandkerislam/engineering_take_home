module Api
  class ClientsController < ApplicationController
    def index
      @clients = Client.includes(:buildings, :custom_fields).all
      render json: @clients, include: [:buildings, :custom_fields]
    rescue StandardError => e
      render json: { error: 'Failed to load clients' }, status: :internal_server_error
    end
  end
end 