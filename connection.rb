class Connection
  attr_accessor :phermone_level

  def initialize(city_a, city_b)
    @city_a = city_a
    @city_b = city_b
    @phermone_level = 0
  end

  def update_phermone_level(level)
    @phermone_level += level
  end

  def contains?(city)
    return @city_a.id == city.id || @city_b.id == city.id
  end

  def distance
    x_value = (@city_a.x - @city_b.x) * (@city_a.x - @city_b.x)
    y_value = (@city_a.y - @city_b.y) * (@city_a.y - @city_b.y)

    distance = Math.sqrt(x_value + y_value)

    return distance
  end
end
