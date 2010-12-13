require 'city'
require 'connection'
require 'ant'

class Path
  attr_accessor :cities, :ants

  def initialize(config_file, num_ants = 2, num_iterations = 10)
    @cities = {}
    @num_iterations = num_iterations
    @num_ants = num_ants
    @shortest_path_distance = 0
    @shortest_path = nil
    @ants = []
    @alpha = 1
    @beta = 5
    @q = 100.0
    @edges = []

    parse_file(config_file)

    create_ants
  end

  def create_ants
    city_objects = @cities.values

    1.upto(@num_ants).each do |i|
      ant = Ant.new(i, city_objects[rand(@cities.size)], @alpha, @beta, @q, 5.0, 0.5, @num_ants)
      @ants <<  ant
    end
  end

  def parse_file(config_file)
    File.open(config_file) do |infile|
      while (line = infile.gets)
        city_a, city_b, distance = line.split(" ")

        @cities[city_a] = City.new(city_a, @alpha, @beta) unless city_created?(city_a)
        @cities[city_b] = City.new(city_b, @alpha, @beta) unless city_created?(city_b)

        @edges << @cities[city_a].add_neighbor(@cities[city_b], distance.to_i, @q)
        @edges << @cities[city_b].add_neighbor(@cities[city_a], distance.to_i, @q)

        @shortest_path_distance += distance.to_i
      end
    end
  end

  def search
    0.upto(@num_iterations).each do |iteration|
      visit_cities
      shorter_path?
      update_phermones
    end

    print_finished_info
  end

  def update_phermones
    @edges.each do |edge|
      value = (1 - 0.5) * edge.phermone_level
      @ants.each do |ant|
        value += edge.ant_go_through_edge?(ant.id)
      end
      value += 5.0 * @shortest_path_distance if edge.is_part_of_shortest_path
      edge.delta_p = {}
      edge.phermone_level = value
    end

    @ants.each do |ant|
      ant.reset_path
    end
  end

  def shorter_path?
    @ants.each do |ant|
      distance, path = ant.path_distance, ant.path
      if distance < @shortest_path_distance
        @shortest_path_distance, @shortest_path = distance, path
      end
    end

    @edges.each do |edge|
      edge.is_part_of_shortest_path = false
    end

    @shortest_path.each do |edge|
      edge.is_part_of_shortest_path = true
    end
  end

  def visit_cities
    0.upto(@cities.size - 1).each do |i|
      @ants.each do |ant|
        ant.visit_next_city
      end
    end
  end

  def print_finished_info
    puts "Shortest path was #{@shortest_path_distance}"

    print @shortest_path.first.city_a.city_id + " -> "
    puts @shortest_path.map { |conn| conn.city_b.city_id}.join(" -> ")
  end

  def city_created?(city_id)
    @cities.keys.include?(city_id)
  end
end
