class Api::V1::FavoritesController < ApplicationController
  def create
    if api = ApiKey.find_by(token: params[:api_key])
      favorite = api.user.favorites.new(recipe_title: params[:recipe_title], recipe_link: params[:recipe_link], country: params[:country])
      if favorite.save
        render json: { success: "Favorite added successfully" }, status: :created
      else
        render json: { errors: favorite.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Invalid API key" }, status: :unauthorized
    end
  end
end