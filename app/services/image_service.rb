class ImageService
  def get_image(country)
    get_url("search/photos?query=#{country}")
  end

  private

  def conn
    Faraday.new(url: 'https://api.unsplash.com/') do |f|
      f.params['client_id'] = ENV['UNSPLASH_API_KEY']
      f.headers['X-Total'] = '10'
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end