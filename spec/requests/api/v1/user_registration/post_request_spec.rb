require "rails_helper"

RSpec.describe "Post: /api/v1/users", :vcr do
  describe "happy path" do
    it "registers a new user with payload" do
      user_params = {
        name: "Bob",
        email: "bob@gmail.com",
        password: "password",
        password_confirmation: "password"
      }

      post "/api/v1/users", headers: { 'Content-Type': 'application/json' }, params: user_params.to_json

      expect(response).to be_successful
      expect(response.status).to eq(201)

      user = JSON.parse(response.body, symbolize_names: true)

      expect(user).to be_a(Hash)
      expect(user).to have_key(:data)
      expect(user[:data]).to be_a(Hash)
      expect(user[:data]).to have_key(:id)
      expect(user[:data][:id]).to be_a(String)
      expect(user[:data]).to have_key(:type)
      expect(user[:data][:type]).to eq("user")
      expect(user[:data]).to have_key(:attributes)
      expect(user[:data][:attributes]).to be_a(Hash)
      expect(user[:data][:attributes]).to have_key(:name)
      expect(user[:data][:attributes][:name]).to eq(user_params[:name])
      expect(user[:data][:attributes]).to have_key(:email)
      expect(user[:data][:attributes][:email]).to eq(user_params[:email])
      expect(user[:data][:attributes]).to have_key(:api_key)
      expect(user[:data][:attributes][:api_key]).to be_a(String)

      expect(user[:data][:attributes]).to_not have_key(:password)
      expect(user[:data][:attributes]).to_not have_key(:password_confirmation)
    end
  end

  describe "sad path" do
    it "returns an error if passwords don't match" do
      payload = {
        name: "Javen",
        email: "javen@gmail.com",
        password: "password",
        password_confirmation: "password1"
      }

      post "/api/v1/users", headers: { 'Content-Type': 'application/json' }, params: payload.to_json

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq("Password confirmation doesn't match Password")
    end

    it "returns an error if email is already taken" do
      user = User.create!(name: "Bill", email: "javen@gmail.com", password: "password", password_confirmation: "password")
      payload = {
        name: "Javen",
        email: "javen@gmail.com",
        password: "password",
        password_confirmation: "password"
      }

      post "/api/v1/users", headers: { 'Content-Type': 'application/json' }, params: payload.to_json

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq("Email has already been taken")
    end
  end
end