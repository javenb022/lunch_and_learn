class AirQualitySerializer
  def air_quality_response(data, city)
    {
      data: {
        id: nil,
        type: "air_quality",
        city: city,
        attributes: {
          aqi: data[:overall_aqi],
          pm25_concentration: data[:"PM2.5"][:concentration],
          co_concentration: data[:CO][:concentration]
        }
      }
    }
  end
end