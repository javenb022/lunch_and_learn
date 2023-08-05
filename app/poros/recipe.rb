class Recipe
  attr_reader :title, :image, :url, :country, :id
  def initialize(recipe_data, country)
    @title = recipe_data[:recipe][:label]
    @image = recipe_data[:recipe][:image]
    @url = recipe_data[:recipe][:url]
    @country = country
    @id = "null"
  end
end