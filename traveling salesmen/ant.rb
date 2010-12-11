require 'pp'

class Ant
  attr_accessor :cities, :current_city, :path, :id

  def initialize(id, current_city, alpha, beta)
    @id = id
    @current_city = current_city
    @path = [current_city]
    @alpha, @beta = alpha, beta
  end

  def visit
    if city_to_visit = path_with_strongest_phermones

      city_to_visit = city_to_visit.city_b

      puts "Ant #{id} is visiting city #{city_to_visit.city_id}"

      @current_city = city_to_visit
      @path << city_to_visit
    else
      puts 'done'
    end
  end

  def path_with_strongest_phermones
    max_value = 0
    max_neighbor = nil

    @current_city.unvisited(@path).each do |neighbor|
      temp = transition_rule(neighbor)
      max_value, max_neighbor = temp, neighbor if temp >= max_value
    end

    return max_neighbor
  end

  def transition_rule(connection)
    path = connection

    temp = path.phermone_level ** @alpha * path.visibility ** @beta

    temp2 = @current_city.neighbors.inject(0) do |sum, neighbor|
      sum + neighbor.phermone_level ** @alpha * neighbor.visibility ** @beta
    end

    return temp / temp2
  end
end
