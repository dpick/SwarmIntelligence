class Path
  attr_accessor :cities, :ants

  def initialize(config_file)
    @cities = {}

    File.open(config_file) do |infile|
      while (line = infile.gets)
        city_a, city_b, distance = line.split(" ")

        @cities[city_a] = City.new(city_a) unless city_created?(city_a)
        @cities[city_b] = City.new(city_b) unless city_created?(city_b)

        @cities[city_a].add_neighbor(@cities[city_b], distance)
        @cities[city_b].add_neighbor(@cities[city_a], distance)
      end
    end
  end


  def city_created?(city_id)
    @cities.keys.each { |city| return true if city == city_id}
    return false
  end
end
