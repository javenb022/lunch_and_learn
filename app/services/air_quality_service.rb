class AirQualityService
  def conn
    Faraday.new(url: 'https://api.api-ninjas.com') do |f|
      f.headers['X-API-KEY'] = ENV['AIR_QUALITY_API_KEY']
    end
  end

  def get_air_quality_data(city)
    get_url("/v1/airquality?city=#{city}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end