class Ant
  attr_accessor :cities, :current_city, :path, :id

  def initialize(id, cities, alpha, beta)
    @id = id
    @cities = cities
    @current_city = cities[rand(cities.size)]
    @path = []
    @alpha, @beta = alpha, beta
  end

  def visit(visited_city)
    puts "Ant #{@id} visiting city #{visited_city.city_id}"
    @cities.delete_if { |city| city.city_id == visited_city.city_id }
    @current_city = visited_city
    @path << visited_city
  end

  def visited?(place)
    @cities.each { |city| return false if place.id == city.city_id }
    return true
  end

  def transition_rule
    path = @current_city.connections.first

    temp = path.phermone_level ** @alpha * path.visibility ** @beta

    temp2 = @current_city.neighbors.inject(0) do |sum, neighbor|
      sum + neighbor.phermone_level ** @alpha * neighbor.visibility ** @beta
    end

    return temp / temp2
  end
end
