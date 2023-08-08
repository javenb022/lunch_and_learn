require "rails_helper"

RSpec.describe "GET /api/v1/favorites" do
  describe "happy path" do
    it "returns a list of a users favorites" do
      user = User.create!(name: "Bob", email: "bob@gmail.com", password: "password", password_confirmation: "password")
      user1 = User.create!(name: "Javen", email: "javen@gmail.com", password: "password", password_confirmation: "password")
      api_key = user.api_keys.create!(token: SecureRandom.hex(16))
      favorite1 = user.favorites.create!(country: "Japan", recipe_link: "https://www.allrecipes.com/recipe/246628/japanese-restaurant-style-ginger-dressing/", recipe_title: "Japanese Restaurant-Style Ginger Dressing")
      favorite2 = user.favorites.create!(country: "China", recipe_link: "link_to_china_recipe", recipe_title: "Dumplings")
      favorite3 = user1.favorites.create!(country: "Mexico", recipe_link: "link_to_mexico_recipe", recipe_title: "Tacos")

      get "/api/v1/favorites", headers: { 'Content-Type': 'application/json' }, params: { api_key: api_key.token }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      list = JSON.parse(response.body, symbolize_names: true)

      expect(list).to be_a(Hash)
      expect(list).to have_key(:data)
      expect(list[:data].count).to eq(2)
      expect(list[:data][0]).to have_key(:id)
      expect(list[:data][0][:id]).to be_a(String)
      expect(list[:data][0]).to have_key(:type)
      expect(list[:data][0][:type]).to eq("favorite")
      expect(list[:data][0]).to have_key(:attributes)
      expect(list[:data][0][:attributes]).to be_a(Hash)
      expect(list[:data][0][:attributes]).to have_key(:recipe_title)
      expect(list[:data][0][:attributes][:recipe_title]).to be_a(String)
      expect(list[:data][0][:attributes]).to have_key(:recipe_link)
      expect(list[:data][0][:attributes][:recipe_link]).to be_a(String)
      expect(list[:data][0][:attributes]).to have_key(:country)
      expect(list[:data][0][:attributes][:country]).to be_a(String)
      expect(list[:data][0][:attributes]).to have_key(:created_at)
      expect(list[:data][0][:attributes][:created_at]).to be_a(String)

      expect(list[:data][0][:attributes][:recipe_title]).to eq(favorite1.recipe_title)
      expect(list[:data][0][:attributes][:recipe_link]).to eq(favorite1.recipe_link)
      expect(list[:data][0][:attributes][:country]).to eq(favorite1.country)
      expect(list[:data][0][:attributes][:created_at]).to eq(favorite1.created_at.strftime("%Y-%m-%d %H:%M:%S.%L %z"))

      expect(list[:data][1][:attributes][:recipe_title]).to eq(favorite2.recipe_title)
      expect(list[:data][1][:attributes][:recipe_link]).to eq(favorite2.recipe_link)
      expect(list[:data][1][:attributes][:country]).to eq(favorite2.country)
      expect(list[:data][1][:attributes][:created_at]).to eq(favorite2.created_at.strftime("%Y-%m-%d %H:%M:%S.%L %z"))

      expect(list[:data][0][:attributes][:recipe_title]).to_not eq(favorite3.recipe_title)
      expect(list[:data][0][:attributes][:recipe_link]).to_not eq(favorite3.recipe_link)
      expect(list[:data][0][:attributes][:country]).to_not eq(favorite3.country)
      expect(list[:data][0][:attributes][:created_at]).to_not eq(favorite3.created_at.strftime("%Y-%m-%d %H:%M:%S.%L %z"))

      expect(list[:data][1][:attributes][:recipe_title]).to_not eq(favorite3.recipe_title)
      expect(list[:data][1][:attributes][:recipe_link]).to_not eq(favorite3.recipe_link)
      expect(list[:data][1][:attributes][:country]).to_not eq(favorite3.country)
      expect(list[:data][1][:attributes][:created_at]).to_not eq(favorite3.created_at.strftime("%Y-%m-%d %H:%M:%S.%L %z"))
    end
  end

  describe "sad path" do
    it "returns an error if the api key is invalid" do
      get "/api/v1/favorites", headers: { 'Content-Type': 'application/json' }, params: { api_key: "summalumma" }

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq("Invalid API key")
    end

    it "returns an empty array if the user has no favorites" do
      user = User.create!(name: "Bob", email: "bob@gmail.com", password: "password", password_confirmation: "password")
      api_key = user.api_keys.create!(token: SecureRandom.hex(16))

      get "/api/v1/favorites", headers: { 'Content-Type': 'application/json' }, params: { api_key: api_key.token }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Array)
      expect(json[:data].count).to eq(0)
    end
  end
end