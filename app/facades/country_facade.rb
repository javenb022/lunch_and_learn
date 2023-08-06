class CountryFacade
  def self.random_country
    country = CountryService.new.all_countries
    num = rand(1..country.count)
    country[num][:name][:common]
  end
end