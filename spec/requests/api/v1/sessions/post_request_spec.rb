require "rails_helper"

RSpec.describe "POST /api/v1/sessions" do
  describe "happy path" do
    it "can login a user" do
      user = User.create!(name: "Bob", email: "bob@gmail.com", password: "password", password_confirmation: "password")
      user.api_keys.create!(token: SecureRandom.hex(16))
      user_params = {
        email: "bob@gmail.com",
        password: "password"
      }

      post "/api/v1/sessions", headers: { 'Content-Type': 'application/json' }, params: JSON.generate(user_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Hash)
      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_a(String)
      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq("user")
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes]).to have_key(:name)
      expect(json[:data][:attributes][:name]).to eq(user.name)
      expect(json[:data][:attributes]).to have_key(:email)
      expect(json[:data][:attributes][:email]).to eq(user.email)
      expect(json[:data][:attributes]).to have_key(:api_key)
    end
  end

  describe "sad path" do
    it "returns an error if email is incorrect" do
      user = User.create!(name: "Bob", email: "bob@gmail.com", password: "password", password_confirmation: "password")
      user.api_keys.create!(token: SecureRandom.hex(16))
      user_params = {
        email: "bademail@gmail.com",
        password: "password"
      }

      post "/api/v1/sessions", headers: { 'Content-Type': 'application/json' }, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json).to have_key(:error)
      expect(json[:error]).to eq("Invalid credentials")

      expect(json).to_not have_key(:data)
      expect(json).to_not have_key(:id)
      expect(json).to_not have_key(:type)
      expect(json).to_not have_key(:attributes)
      expect(json).to_not have_key(:name)
      expect(json).to_not have_key(:email)
      expect(json).to_not have_key(:api_key)
    end

    it "returns an error if password is incorrect" do
      user = User.create!(name: "Bob", email: "bob@gmail.com", password: "password", password_confirmation: "password")
      user.api_keys.create!(token: SecureRandom.hex(16))
      user_params = {
        email: "bob@gmail.com",
        password: "badpassword"
      }

      post "/api/v1/sessions", headers: { 'Content-Type': 'application/json' }, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json).to have_key(:error)
      expect(json[:error]).to eq("Invalid credentials")

      expect(json).to_not have_key(:data)
      expect(json).to_not have_key(:id)
      expect(json).to_not have_key(:type)
      expect(json).to_not have_key(:attributes)
      expect(json).to_not have_key(:name)
      expect(json).to_not have_key(:email)
      expect(json).to_not have_key(:api_key)
    end
  end
end