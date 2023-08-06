require "rails_helper"

RSpec.describe RecipeService, :vcr do
  describe "can create a connection to the Edamam API" do
    it "recipes(search)" do
      recipes = RecipeService.new.recipes("japan")

      expect(recipes).to be_a(Hash)
      expect(recipes).to have_key(:from)
      expect(recipes[:from]).to be_a(Integer)
      expect(recipes).to have_key(:to)
      expect(recipes[:to]).to be_a(Integer)
      expect(recipes).to have_key(:count)
      expect(recipes[:count]).to be_a(Integer)
      expect(recipes).to have_key(:_links)
      expect(recipes[:_links]).to be_a(Hash)
      expect(recipes).to have_key(:hits)
      expect(recipes[:hits]).to be_an(Array)
    end
  end
end