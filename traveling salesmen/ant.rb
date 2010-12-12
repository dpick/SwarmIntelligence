require 'pp'

class Ant
  attr_accessor :current_city, :path, :id

  def initialize(id, current_city, alpha, beta, q, num_ants)
    @id = id
    @current_city = current_city
    @starting_city = current_city
    @previous_cities = [current_city]
    @path = []
    #woot random constants the book gave me
    @alpha, @beta, @q, @num_ants = alpha, beta, q, num_ants
  end

  def update_path_phermones
    @path.each do |connection|
      value = row * connection.phermone_level
      #value += @num_ants.each
      connection.update_phermone_level()
    end
  end

  def path_distance
    @path.inject(0) do |sum, connection|
      sum + connection.distance
    end
  end

  def visit
    if connection = path_with_strongest_phermones

      @path << connection

      city_to_visit = connection.city_b

      puts "Ant #{id} is visiting city #{city_to_visit.city_id}"

      @current_city = city_to_visit
      @previous_cities << city_to_visit
    else
      @path << @current_city.connected_to?(@starting_city)
    end
  end

  def path_with_strongest_phermones
    max_value = 0
    max_neighbor = nil

    @current_city.unvisited_neighbors(@previous_cities).each do |neighbor|
      temp = transition_rule(neighbor)
      max_value, max_neighbor = temp, neighbor if temp >= max_value
    end

    return max_neighbor
  end

  def transition_rule(connection)
    path = connection

    numerator = path.phermone_level ** @alpha * path.visibility ** @beta

    denominator = @current_city.neighbors.inject(0) do |sum, neighbor|
      sum + neighbor.phermone_level ** @alpha * neighbor.visibility ** @beta
    end

    return numerator / denominator if denominator > 0
    return 0
  end
end
