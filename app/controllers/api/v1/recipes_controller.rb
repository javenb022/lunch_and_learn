class Api::V1::RecipesController < ApplicationController
  def index
    recipes = RecipeFacade.new.get_recipes(params[:q])
    render json: RecipeSerializer.new(recipes)
  end
end