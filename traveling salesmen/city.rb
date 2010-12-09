require 'connection'

class City
  attr_accessor :neighbors, :id

  def initialize(id, neighbors = [])
    @id = id
    @neighbors = neighbors
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
    return false if city.id == @id

    @neighbors.each do |connection|
      return true if connection.contains?(city)
    end

    return false
  end

  def add_neighbor(city, distance)
    @neighbors << Connection.new(self, city, distance)
  end
end
