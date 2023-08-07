class ImageFacade
  def get_images(search)
    json = ImageService.new.get_image(search)
    json[:results].map do |result|
      Image.new(result)
    end
  end
end