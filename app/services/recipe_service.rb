class RecipeService
  def recipes(search)
    get_url("/api/recipes/v2?type=public&q=#{search}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.edamam.com/") do |f|
      f.headers["Content-Type"] = "application/json"
      f.params["app_id"] = ENV["EDAMAM_ID"]
      f.params["app_key"] = ENV["EDAMAM_KEY"]
    end
  end
end