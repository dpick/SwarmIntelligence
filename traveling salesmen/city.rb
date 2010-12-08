require 'connection'

class City
  attr_accessor :neighbors, :id, :x, :y

  def initialize(id, neighbors = [], x = 0, y = 0)
    @id = id
    @neighbors = neighbors
    @x = x
    @y = y
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

  def add_neighbor(city)
    @neighbors << Connection.new(self, city)
  end
end
