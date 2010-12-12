require 'connection'

class City
  attr_accessor :neighbors, :city_id

  def initialize(city_id, alpha, beta, neighbors = [])
    @city_id = city_id
    @neighbors = neighbors
    @alpha, @beta = alpha, beta
  end

  def connected_to?(city)
    return false if city.city_id == @city_id

    @neighbors.each do |connection|
      return connection if connection.contains?(city)
    end

    return false
  end

  def add_neighbor(city, distance)
    @neighbors << Connection.new(self, city, distance)
  end

  def unvisited_neighbors(path)
    to_return = []
    @neighbors.each do |neighbor|
      if not path.include?(neighbor.city_b)
        to_return << neighbor
      end
    end

    return to_return
  end
end
