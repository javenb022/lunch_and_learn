class CountryFacade
  def self.random_country
    country = CountryService.new.all_countries
    num = rand(1..country.count)
    country[num][:name][:common]
  end

  def get_city(country)
    CountryService.new.get_country(country)[0][:capital][0]
  end
end