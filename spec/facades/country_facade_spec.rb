require "rails_helper"

RSpec.describe CountryFacade, :vcr do
  describe "can generate a random country" do
    it "random_country" do
      country = CountryFacade.random_country

      expect(country).to be_a(String)
      expect(country).to_not be_a(Hash)
      expect(country).to_not be_a(Array)
      expect(country).to_not be_empty
    end
  end
end