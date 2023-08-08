class FavoriteSerializer
  include JSONAPI::Serializer
  attributes :recipe_title, :recipe_link, :country

  attribute :created_at do |object|
    object.created_at.strftime("%Y-%m-%d %H:%M:%S.%L %z")
  end
end