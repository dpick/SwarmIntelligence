require 'connection'

class City
  attr_accessor :neighbors, :city_id

  def initialize(city_id, alpha, beta, neighbors = [])
    @city_id = city_id
    @neighbors = neighbors
    @alpha, @beta = alpha, beta
  end

  def visibility(city)
    1 / distance(city)
  end

  def distance(city)
    @neighbors.each do |connection|
      return connection.distance if connected_to?(city)
    end

    return 0
  end

  def connected_to?(city)
    return false if city.city_id == @city_id

    @neighbors.each do |connection|
      return true if connection.contains?(city)
    end

    return false
  end

  def add_neighbor(city, distance)
    @neighbors << Connection.new(self, city, distance)
  end

  def unvisited(path)
    to_return = []
    @neighbors.each do |neighbor|
      if not path.include?(neighbor.city_b)
        to_return << neighbor
      end
    end

    return to_return
  end
end
