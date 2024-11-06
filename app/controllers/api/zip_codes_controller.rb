class Api::ZipCodesController < ApplicationController
  def index
    @zip_codes = ZipCode.all.includes(:state)
    render json: @zip_codes, include: [ :state ]
  end

  def show
    @zip_code = ZipCode.find(params[:id])
    render json: {
      id: @zip_code.id,
      code: @zip_code.code,
      city: @zip_code.city,
      state: {
        id: @zip_code.state.id,
        name: @zip_code.state.name
      }
    }
  end
end
