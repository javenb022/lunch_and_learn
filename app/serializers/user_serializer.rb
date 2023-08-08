class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email
  
  attribute :api_key do |user|
    user.api_keys.first.token
  end
end