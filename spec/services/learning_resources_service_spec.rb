require "rails_helper"

RSpec.describe LearningResourcesService, :vcr do
  describe "can make a connection to the API" do
    it "returns a learning resources" do
      resource = LearningResourcesService.new.get_resources("japan")

      expect(resource).to be_a(Hash)
      expect(resource).to have_key(:kind)
      expect(resource[:kind]).to be_a(String)
      expect(resource).to have_key(:pageInfo)
      expect(resource[:pageInfo]).to be_a(Hash)
      expect(resource[:pageInfo]).to have_key(:totalResults)
      expect(resource[:pageInfo][:totalResults]).to be_a(Integer)
      expect(resource[:pageInfo]).to have_key(:resultsPerPage)
      expect(resource[:pageInfo][:resultsPerPage]).to be_a(Integer)
      expect(resource[:pageInfo][:resultsPerPage]).to eq(1)
      expect(resource).to have_key(:items)
      expect(resource[:items]).to be_an(Array)
      expect(resource[:items][0]).to have_key(:id)
      expect(resource[:items][0][:id]).to be_a(Hash)
      expect(resource[:items][0][:id]).to have_key(:kind)
      expect(resource[:items][0][:id][:kind]).to be_a(String)
      expect(resource[:items][0][:id]).to have_key(:videoId)
      expect(resource[:items][0][:id][:videoId]).to be_a(String)
      expect(resource[:items][0]).to have_key(:snippet)
      expect(resource[:items][0][:snippet]).to be_a(Hash)
      expect(resource[:items][0][:snippet]).to have_key(:title)
      expect(resource[:items][0][:snippet][:title]).to be_a(String)
      expect(resource[:items][0][:snippet]).to have_key(:description)
    end
  end
end