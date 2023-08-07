class LearningResource
  attr_reader :id, :country, :video, :images
  def initialize(resource, country, images)
    @id = nil
    @country = country
    @video = attributes(resource)
    @images = images
  end

  def attributes(resource)
    if resource == {}
      {}
    else
      {title: resource[:snippet][:title], youtube_video_id: resource[:id][:videoId]}
    end
  end
end