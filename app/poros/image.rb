class Image
  attr_reader :id, :alt_tag, :url
  def initialize(data)
    @id = nil
    @alt_tag = data[:alt_description]
    @url = data[:urls][:regular]
  end
end