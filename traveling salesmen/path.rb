require 'city'
require 'connection'
require 'ant'

class Path
  attr_accessor :cities, :ants

  def initialize(config_file, num_ants = 2)
    @cities = {}
    @num_ants = num_ants
    @shortest_path_distance = 0
    @shortest_path = nil
    @ants = []
    @alpha = 1
    @beta = 5
    @edges = []

    parse_file(config_file)

    create_ants
  end

  def create_ants
    city_objects = @cities.values

    1.upto(@num_ants).each do |i|
      ant = Ant.new(i, city_objects[rand(@cities.size)], @alpha, @beta, 100.0, 5.0, 0.5, @num_ants)
      puts "New Ant #{i} at #{ant.current_city.city_id}"
      @ants <<  ant
    end
  end

  def parse_file(config_file)
    File.open(config_file) do |infile|
      while (line = infile.gets)
        city_a, city_b, distance = line.split(" ")

        @cities[city_a] = City.new(city_a, @alpha, @beta) unless city_created?(city_a)
        @cities[city_b] = City.new(city_b, @alpha, @beta) unless city_created?(city_b)

        @edges << @cities[city_a].add_neighbor(@cities[city_b], distance.to_i)
        @edges << @cities[city_b].add_neighbor(@cities[city_a], distance.to_i)

        @shortest_path_distance += distance.to_i
      end
    end
  end

  def search
    num_iterations = 10

    0.upto(num_iterations).each do |iteration|
      visit_cities
      shorter_path?
      update_phermones
    end

    print_finished_info
  end

  def update_phermones
    @ants.each do |ant|
      ant.update_path_phermones(@shortest_path_distance)
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
