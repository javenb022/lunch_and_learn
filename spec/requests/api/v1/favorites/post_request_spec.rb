require "rails_helper"

RSpec.describe "POST /api/v1/favorites" do
  describe "happy path" do
    it "creates a favorite" do
      user = User.create!(name: "Bob", email: "bob@gmail.com", password: "password", password_confirmation: "password")
      api_key = user.api_keys.create!(token: SecureRandom.hex(16))
      favorite_params = {
        api_key: api_key.token,
        country: "Japan",
        recipe_link: "https://www.allrecipes.com/recipe/246628/japanese-restaurant-style-ginger-dressing/",
        recipe_title: "Japanese Restaurant-Style Ginger Dressing"
      }

      expect(user.favorites.count).to eq(0)

      post "/api/v1/favorites", headers: { 'Content-Type': 'application/json' }, params: JSON.generate(favorite_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json).to have_key(:success)
      expect(json[:success]).to eq("Favorite added successfully")
      expect(user.favorites.count).to eq(1)

      expect(json).to_not have_key(:error)
      expect(json).to_not have_key(:data)
      expect(json).to_not have_key(:id)
      expect(json).to_not have_key(:type)
      expect(json).to_not have_key(:attributes)
      expect(json).to_not have_key(:api_key)
      expect(json).to_not have_key(:country)
      expect(json).to_not have_key(:recipe_link)
      expect(json).to_not have_key(:recipe_title)
    end
  end

  describe "sad path" do
    it "returns an error if the api key is invalid" do
      favorite_params = {
        api_key: "summalumma",
        country: "Japan",
        recipe_link: "https://www.allrecipes.com/recipe/246628/japanese-restaurant-style-ginger-dressing/",
        recipe_title: "Japanese Restaurant-Style Ginger Dressing"
      }

      post "/api/v1/favorites", headers: { 'Content-Type': 'application/json' }, params: JSON.generate(favorite_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq("Invalid API key")

      expect(error).to_not have_key(:success)
      expect(error).to_not have_key(:data)
      expect(error).to_not have_key(:id)
      expect(error).to_not have_key(:type)
      expect(error).to_not have_key(:attributes)
      expect(error).to_not have_key(:api_key)
      expect(error).to_not have_key(:country)
      expect(error).to_not have_key(:recipe_link)
      expect(error).to_not have_key(:recipe_title)
    end

    it "returns an error if missing params" do
      user = User.create!(name: "Bob", email: "bob@gmail.com", password: "password", password_confirmation: "password")
      api_key = user.api_keys.create!(token: SecureRandom.hex(16))
      favorite_params = {
        api_key: api_key.token,
        # country: "Japan",
        recipe_link: "https://www.allrecipes.com/recipe/246628/japanese-restaurant-style-ginger-dressing/",
        recipe_title: "Japanese Restaurant-Style Ginger Dressing"
      }

      post "/api/v1/favorites", headers: { 'Content-Type': 'application/json' }, params: JSON.generate(favorite_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to eq(["Country can't be blank"])
      expect(user.favorites.count).to eq(0)

      expect(error).to_not have_key(:success)
      expect(error).to_not have_key(:data)
      expect(error).to_not have_key(:id)
      expect(error).to_not have_key(:type)
      expect(error).to_not have_key(:attributes)
      expect(error).to_not have_key(:api_key)
      expect(error).to_not have_key(:country)
      expect(error).to_not have_key(:recipe_link)
      expect(error).to_not have_key(:recipe_title)
    end
  end
end