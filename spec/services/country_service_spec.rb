require "rails_helper"

RSpec.describe CountryService, :vcr do
  describe "can get all countries" do
    it "all_countries" do
      countries = CountryService.new.all_countries

      expect(countries).to be_an(Array)
      expect(countries.count).to eq(250)
      expect(countries[0]).to be_a(Hash)
      expect(countries[0]).to have_key(:name)
      expect(countries[0][:name]).to be_a(Hash)
      expect(countries[0][:name]).to have_key(:common)
      expect(countries[0][:name][:common]).to be_a(String)
    end
  end
end