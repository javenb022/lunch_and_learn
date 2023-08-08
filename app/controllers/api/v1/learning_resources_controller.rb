class Api::V1::LearningResourcesController < ApplicationController
  def index
    json = LearningResourcesService.new.get_resources(params[:country])
    images = ImageFacade.new.get_images(params[:country])
    resources = LearningResourcesFacade.new.resources(params[:country])
    if !images.empty? || !json[:items].empty?
      render json: LearningResourceSerializer.new(resources)
    else
      render json: LearningResourceSerializer.sad_path(params[:country])
    end
  end
end