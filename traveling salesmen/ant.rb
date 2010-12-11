class Ant
  attr_accessor :cities, :current_city, :path, :id

  def initialize(id, current_city, alpha, beta)
    @id = id
    @current_city = current_city
    @path = [current_city]
    @alpha, @beta = alpha, beta
  end

  def visit
    if city_to_visit = @current_city.unvisited(@path)
      city_to_visit = city_to_visit.city_b
      puts "Ant #{id} is visiting city #{city_to_visit.city_id}"
      @current_city = city_to_visit
      @path << city_to_visit
    else
      puts 'done'
    end
  end

  def transition_rule
    path = @current_city.connections.first

    temp = path.phermone_level ** @alpha * path.visibility ** @beta

    temp2 = @current_city.neighbors.inject(0) do |sum, neighbor|
      sum + neighbor.phermone_level ** @alpha * neighbor.visibility ** @beta
    end

    return temp / temp2
  end
end
