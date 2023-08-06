require "rails_helper"

RSpec.describe "GET /api/v1/recipes", :vcr do
  describe "happy path" do
    it "returns a list of recipes" do
      get("/api/v1/recipes", headers: {"CONTENT_TYPE" => "application/json"}, params: {q: "japan"})

      expect(response).to be_successful
      expect(response.status).to eq(200)

      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(recipes[:data].count).to eq(20)
      expect(recipes).to be_a(Hash)
      expect(recipes).to have_key(:data)
      expect(recipes[:data]).to be_an(Array)
      expect(recipes[:data][0]).to have_key(:id)
      expect(recipes[:data][0][:id]).to be_a(String)
      expect(recipes[:data][0]).to have_key(:type)
      expect(recipes[:data][0][:type]).to be_a(String)
      expect(recipes[:data][0]).to have_key(:attributes)
      expect(recipes[:data][0][:attributes]).to be_a(Hash)
      expect(recipes[:data][0][:attributes]).to have_key(:title)
      expect(recipes[:data][0][:attributes][:title]).to be_a(String)
      expect(recipes[:data][0][:attributes]).to have_key(:image)
      expect(recipes[:data][0][:attributes][:image]).to be_a(String)
      expect(recipes[:data][0][:attributes]).to have_key(:url)
      expect(recipes[:data][0][:attributes][:url]).to be_a(String)
      expect(recipes[:data][0][:attributes]).to have_key(:country)
      expect(recipes[:data][0][:attributes][:country]).to be_a(String)

      expect(recipes[:data][0]).to_not have_key(:ingredients)
      expect(recipes[:data][0]).to_not have_key(:calories)
      expect(recipes[:data][0]).to_not have_key(:dietLabels)
      expect(recipes[:data][0]).to_not have_key(:healthLabels)
      expect(recipes[:data][0]).to_not have_key(:cautions)
      expect(recipes[:data][0]).to_not have_key(:cuisineType)
    end

    it "sad path: selects a random country if no input is given" do
      get "/api/v1/recipes", headers: {"CONTENT_TYPE" => "application/json"}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(recipes).to be_a(Hash)
      expect(recipes).to have_key(:data)
      expect(recipes[:data]).to be_an(Array)
      expect(recipes[:data][0]).to have_key(:id)
      expect(recipes[:data][0][:id]).to be_a(String)
      expect(recipes[:data][0]).to have_key(:type)
      expect(recipes[:data][0][:type]).to be_a(String)
      expect(recipes[:data][0]).to have_key(:attributes)
      expect(recipes[:data][0][:attributes]).to be_a(Hash)
      expect(recipes[:data][0][:attributes]).to have_key(:title)
      expect(recipes[:data][0][:attributes][:title]).to be_a(String)
      expect(recipes[:data][0][:attributes]).to have_key(:image)
      expect(recipes[:data][0][:attributes][:image]).to be_a(String)
      expect(recipes[:data][0][:attributes]).to have_key(:url)
      expect(recipes[:data][0][:attributes][:url]).to be_a(String)
      expect(recipes[:data][0][:attributes]).to have_key(:country)
      expect(recipes[:data][0][:attributes][:country]).to be_a(String)

      expect(recipes[:data][0]).to_not have_key(:ingredients)
      expect(recipes[:data][0]).to_not have_key(:calories)
      expect(recipes[:data][0]).to_not have_key(:dietLabels)
      expect(recipes[:data][0]).to_not have_key(:healthLabels)
      expect(recipes[:data][0]).to_not have_key(:cautions)
      expect(recipes[:data][0]).to_not have_key(:cuisineType)
    end

    it "sad path: returns empty array if no recipes are found" do
      get "/api/v1/recipes", headers: {"CONTENT_TYPE" => "application/json"}, params: {q: "asdf"}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(recipes).to be_a(Hash)
      expect(recipes).to have_key(:data)
      expect(recipes[:data]).to be_an(Array)
      expect(recipes[:data]).to be_empty

      expect(recipes).to_not have_key(:id)
      expect(recipes).to_not have_key(:type)
      expect(recipes).to_not have_key(:attributes)
    end
  end
end