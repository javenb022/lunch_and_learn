class AirQualityFacade
  def self.get_air_quality_data(country)
    city = CountryService.new.get_country(country)[0][:capital][0]
    data = AirQualityService.new.get_air_quality_data(city)
    # AirQuality.new(data)
  end
end