class LearningResourceSerializer
  include JSONAPI::Serializer

  attributes :country, :video, :images
  set_type :learning_resource

  def self.sad_path(country)
    {
      data: {
        id: nil,
        type: "learning_resource",
        attributes: {
          country: country,
          video: {},
          images: []
        }
      }
    }
  end
end