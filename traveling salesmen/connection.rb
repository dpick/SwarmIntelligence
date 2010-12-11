class Connection
  attr_accessor :phermone_level, :distance, :city_a, :city_b

  def initialize(city_a, city_b, distance)
    @city_a = city_a
    @city_b = city_b
    @phermone_level = 0
    @distance = distance
  end

  def update_phermone_level(level)
    @phermone_level += level
  end

  def contains?(city)
    return @city_a.city_id == city.city_id || @city_b.city_id == city.city_id
  end

  def visibility
    1 / @distance
  end
end
