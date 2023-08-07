class LearningResourcesFacade
  def resources(search)
    json = LearningResourcesService.new.get_resources(search)
    if json[:items].empty?
      LearningResource.new({}, search, images_parsed(search))
    else
      json[:items].map do |resource|
        LearningResource.new(resource, search, images_parsed(search))
      end
    end
  end

  def images_parsed(search)
    images = ImageFacade.new.get_images(search)
    if images.empty?
      []
    else
      images_json = ImageSerializer.new(images).to_json
      response = JSON.parse(images_json, symbolize_names: true)
      parsed = []
      response[:data].each do |image|
        parsed << image[:attributes]
      end
      parsed
    end
  end
end