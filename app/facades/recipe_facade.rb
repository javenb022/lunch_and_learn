class RecipeFacade

  def get_recipes(country)
    recipes = RecipeService.new.recipes(country)
    recipes[:hits].map do |recipe|
      Recipe.new(recipe, country)
    end
  end
end