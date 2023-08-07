class Api::V1::AirQualityController < ApplicationController
  def index
    response = AirQualityFacade.get_air_quality_data(params[:country])
    render json: AirQualitySerializer.new(response)
    require 'pry'; binding.pry
  end
end