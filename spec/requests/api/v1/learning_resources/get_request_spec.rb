require "rails_helper"

RSpec.describe "GET /api/v1/learning_resources", :vcr do
  describe "happy path" do
    it "returns a list of learning resources" do
      get("/api/v1/learning_resources", headers: {"CONTENT_TYPE" => "application/json"}, params: {country: "japan"})

      expect(response).to be_successful
      expect(response.status).to eq(200)

      resources = JSON.parse(response.body, symbolize_names: true)

      expect(resources).to be_a(Hash)
      expect(resources).to have_key(:data)
      expect(resources[:data]).to be_an(Array)
      expect(resources[:data].count).to eq(1)
      expect(resources[:data][0]).to be_a(Hash)
      expect(resources[:data][0]).to have_key(:id)
      expect(resources[:data][0][:id]).to be(nil)
      expect(resources[:data][0]).to have_key(:type)
      expect(resources[:data][0][:type]).to eq("learning_resource")
      expect(resources[:data][0]).to have_key(:attributes)
      expect(resources[:data][0][:attributes]).to be_a(Hash)
      expect(resources[:data][0][:attributes]).to have_key(:country)
      expect(resources[:data][0][:attributes][:country]).to be_a(String)
      expect(resources[:data][0][:attributes]).to have_key(:video)
      expect(resources[:data][0][:attributes][:video]).to be_a(Hash)
      expect(resources[:data][0][:attributes][:video]).to have_key(:title)
      expect(resources[:data][0][:attributes][:video][:title]).to be_a(String)
      expect(resources[:data][0][:attributes][:video]).to have_key(:youtube_video_id)
      expect(resources[:data][0][:attributes][:video][:youtube_video_id]).to be_a(String)
      expect(resources[:data][0][:attributes]).to have_key(:images)
      expect(resources[:data][0][:attributes][:images]).to be_an(Array)
      expect(resources[:data][0][:attributes][:images].count).to be <= 10
      expect(resources[:data][0][:attributes][:images][0]).to be_a(Hash)
      expect(resources[:data][0][:attributes][:images][0]).to have_key(:url)
      expect(resources[:data][0][:attributes][:images][0][:url]).to be_a(String)
      expect(resources[:data][0][:attributes][:images][0]).to have_key(:alt_tag)
      expect(resources[:data][0][:attributes][:images][0][:alt_tag]).to be_a(String)
    end
  end

  describe "sad path" do
    it "returns empty arrays for video and images if none are found" do
      get("/api/v1/learning_resources", headers: {"CONTENT_TYPE" => "application/json"}, params: {country: "asdf"})

      expect(response).to be_successful
      expect(response.status).to eq(200)

      sad_path = JSON.parse(response.body, symbolize_names: true)

      expect(sad_path).to be_a(Hash)
      expect(sad_path).to have_key(:data)
      expect(sad_path[:data]).to be_a(Hash)
      expect(sad_path[:data]).to have_key(:id)
      expect(sad_path[:data][:id]).to be(nil)
      expect(sad_path[:data]).to have_key(:type)
      expect(sad_path[:data][:type]).to eq("learning_resource")
      expect(sad_path[:data]).to have_key(:attributes)
      expect(sad_path[:data][:attributes]).to be_a(Hash)
      expect(sad_path[:data][:attributes]).to have_key(:country)
      expect(sad_path[:data][:attributes][:country]).to be_a(String)
      expect(sad_path[:data][:attributes]).to have_key(:video)
      expect(sad_path[:data][:attributes][:video]).to eq({})
      expect(sad_path[:data][:attributes]).to have_key(:images)
      expect(sad_path[:data][:attributes][:images]).to eq([])
    end
  end
end