require "rails_helper"

RSpec.describe RecipeFacade, :vcr do
  describe "can create a Recipe poro" do
    it "get_recipes(country)" do
      recipes = RecipeFacade.new.get_recipes("japan")

      expect(recipes).to be_an(Array)
      expect(recipes.count).to eq(20)
      expect(recipes[0]).to be_a(Recipe)
      expect(recipes[0].title).to be_a(String)
      expect(recipes[0].image).to be_a(String)
      expect(recipes[0].url).to be_a(String)
      expect(recipes[0].country).to be_a(String)
    end
  end
end