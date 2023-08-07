class Api::V1::LearningResourcesController < ApplicationController
  def index
    json = LearningResourcesService.new.get_resources(params[:q])
    images = ImageFacade.new.get_images(params[:q])
    resources = LearningResourcesFacade.new.resources(params[:q])
    if !images.empty? || !json[:items].empty?
      render json: LearningResourceSerializer.new(resources)
    else
      render json: LearningResourceSerializer.sad_path(params[:q])
    end
  end
end