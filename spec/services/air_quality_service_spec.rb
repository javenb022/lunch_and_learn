require "rails_helper"

RSpec.describe AirQualityService, :vcr do
  describe "can make a successful request" do
    it "returns air quality data for a given country's capital" do
      data = AirQualityService.new.get_air_quality_data("lagos")

      expect(data).to be_a(Hash)
      expect(data).to have_key(:overall_aqi)
      expect(data[:overall_aqi]).to be_an(Integer)
      expect(data).to have_key(:"PM2.5")
      expect(data[:"PM2.5"]).to be_a(Hash)
      expect(data[:"PM2.5"]).to have_key(:concentration)
      expect(data[:"PM2.5"][:concentration]).to be_a(Float)
      expect(data).to have_key(:CO)
      expect(data[:CO]).to be_a(Hash)
      expect(data[:CO]).to have_key(:concentration)
      expect(data[:CO][:concentration]).to be_a(Float)
    end
  end
end