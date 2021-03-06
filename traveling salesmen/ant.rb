require 'pp'

class Ant
  attr_accessor :current_city, :path, :id

  def initialize(id, current_city, alpha, beta, q, e, row, num_ants)
    @id = id
    @current_city = current_city
    @starting_city = current_city
    @previous_cities = [current_city]
    @path = []
    #woot random constants the book gave me
    @alpha, @beta, @q, @e, @row, @num_ants = alpha, beta, q, e, row, num_ants
  end

  def update_path_phermones(shortest_path_distance)
    @path.each do |connection|
      value = (1 - @row) * connection.phermone_level
      value += @num_ants * @q / path_distance
      value += @e * (@q / shortest_path_distance)

      connection.phermone_level = value
    end
  end

  def reset_path(starting_city)
    @path = []
    @previous_cities = [starting_city]
    @current_city = starting_city
    @starting_city = starting_city
  end

  def print_path
    print "#{@path.first.city_a.city_id} -> "
    @path.each do |connection|
      print "#{connection.city_b.city_id} -> "
    end
  end

  def path_distance
    @path.inject(0) { |sum, conn| sum + conn.distance }
  end

  def visit_next_city
    if connection = path_with_strongest_phermones

      @path << connection

      city_to_visit = connection.city_b

      @current_city = city_to_visit
      @previous_cities << city_to_visit
    else
      @path << @current_city.connected_to?(@starting_city)
      @path.each do |connection|
        connection.add_ant_to_tour(@id, path_distance)
      end
    end
  end

  def path_with_strongest_phermones
    neighbors = @current_city.unvisited_neighbors(@previous_cities)

    neighbors.each do |neighbor|
      return neighbor if rand < transition_rule(neighbor)
    end

    return neighbors[rand(neighbors.size)]
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
