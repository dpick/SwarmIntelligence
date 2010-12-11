require 'city'
require 'connection'
require 'ant'

class Path
  attr_accessor :cities, :ants

  def initialize(config_file)
    @cities = {}
    @num_ants = 1
    @shortest = 0
    @ants = []
    alpha = 0
    beta = 0

    File.open(config_file) do |infile|
      while (line = infile.gets)
        city_a, city_b, distance = line.split(" ")

        @cities[city_a] = City.new(city_a, alpha, beta) unless city_created?(city_a)
        @cities[city_b] = City.new(city_b, alpha, beta) unless city_created?(city_b)

        @cities[city_a].add_neighbor(@cities[city_b], distance)
        @cities[city_b].add_neighbor(@cities[city_a], distance)

        @shortest += distance.to_i
      end
    end

    0.upto(@num_ants).each do |i|
      @ants << Ant.new(i, @cities.values, alpha, beta)
      current = @ants.last
      puts "#{current.id} current city is #{current.current_city.city_id}"
    end
  end

  def search
    num_iterations = 10

    #0.upto(num_iterations).each do |iteration|
    0.upto(@cities.size - 1).each do |i|
      @ants.each do |ant|
        ant.visit(ant.current_city.neighbors.first.city_b)
      end
    end
    #end
  end

  def city_created?(city_id)
    @cities.keys.each { |city| return true if city == city_id}
    return false
  end
end
