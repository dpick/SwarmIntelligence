class Connection
  attr_accessor :phermone_level, :distance, :city_a, :city_b, :is_part_of_shortest_path, :delta_p

  def initialize(city_a, city_b, distance, q)
    @city_a = city_a
    @city_b = city_b
    @phermone_level = 0
    @distance = distance
    @delta_p = {}
    @q = q
    @is_part_of_shortest_path = false
  end

  def update_phermone_level(level)
    @phermone_level += level
  end

  def contains?(city)
    return @city_a.city_id == city.city_id || @city_b.city_id == city.city_id
  end

  def visibility
    1.0 / @distance
  end

  def ant_go_through_edge?(ant_id)
    return @delta_p[ant_id] unless @delta_p[ant_id].nil?
    return 0
  end

  def add_ant_to_tour(ant_id, tour_length)
    @delta_p[ant_id] = @q / tour_length
  end
end
