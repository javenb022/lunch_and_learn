class Api::V1::RecipesController < ApplicationController
  def index
    if params[:q]
      recipes = RecipeFacade.new.get_recipes(params[:q])
      render json: RecipeSerializer.new(recipes)
    else
      country = CountryFacade.random_country
      recipes = RecipeFacade.new.get_recipes(country)
      render json: RecipeSerializer.new(recipes)
    end
  end
end