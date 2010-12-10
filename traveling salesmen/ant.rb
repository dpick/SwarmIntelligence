class Ant
  attr_accessor :cities, :current_city

  def initialize(cities)
    @cities = cities.sort { rand }
    @current_city = cities.first
  end

  def visit(visited_city)
    @cities.delete_if { |city| city.id == visited_city.id }
    @current_city = visited_city
  end

  def visited?(place)
    @cities.each { |city| return false if place.id == city.id }
    return true
  end
end
