require 'city'
require 'connection'
require 'ant'

class Path
  attr_accessor :cities, :ants

  def initialize(config_file, num_ants = 2)
    @cities = {}
    @num_ants = num_ants
    @shortest_path = 0
    @ants = []
    @alpha = 1
    @beta = 5

    parse_file(config_file)

    create_ants
  end

  def create_ants
    city_objects = @cities.values

    1.upto(@num_ants).each do |i|
      ant = Ant.new(i, city_objects[rand(@cities.size)], @alpha, @beta)
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

        @cities[city_a].add_neighbor(@cities[city_b], distance.to_i)
        @cities[city_b].add_neighbor(@cities[city_a], distance.to_i)

        @shortest_path += distance.to_i
      end
    end
  end

  def search
    num_iterations = 10

    #0.upto(num_iterations).each do |iteration|
    1.upto(@cities.size - 1).each do |i|
      @ants.each do |ant|
        ant.visit
      end
    end

    #see if a shorter path was found
    @ants.each do |ant|
      shortest = ant.path_distance if ant.path_distance < @shortest_path
    end

    puts "shortest path was #{@shortest_path}"
    #end
  end

  def city_created?(city_id)
    @cities.keys.include?(city_id)
  end
end
