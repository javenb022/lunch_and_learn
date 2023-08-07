class Api::V1::AirQualityController < ApplicationController
  def index
    city = CountryFacade.new.get_city(params[:country])
    response = AirQualityService.new.get_air_quality_data(city)
    render json: AirQualitySerializer.new.air_quality_response(response, city)
  end
end