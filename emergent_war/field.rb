require 'unit'
require 'pp'
require 'wall'
require 'yaml'
require 'unit_filter_methods'

class Field
  attr_accessor :height, :width, :field_objects, :available_coordinates, :config

  include UnitMethods

  def initialize(height = 50, width = 50)
    @height = height
    @width = width
    @field_objects = []
    @available_coordinates = []
    @config = YAML::load_file("config.yml")

    0.upto(height - 1).each do |row|
      0.upto(width - 1).each do |col|
        @available_coordinates << [row, col]
      end
    end
  end

  def generate_units(army_name, num, rules)
    1.upto(num).each do |unit_num|
      x, y = get_random_coordinates
      rules = Marshal::load(Marshal.dump(rules))
      @field_objects << Unit.new(army_name, x, y, rand(5) + 1, 100, @config['vision'], rules)
    end
  end

  def generate_obstacles(num = 40)
    1.upto(num).each do |obstacle_num|
      x, y = get_random_coordinates
      @field_objects << Wall.new(x, y, @config["wall_rules"])
    end
  end

  def position_available(x, y)
    return false if x < 0 || y < 0 || x > height - 1 || y > width - 1

    @field_objects.each do |object|
      return false if object.x == x && object.y == y
    end

    return true
  end

  

  def distance(x1, y1, x2, y2)
    x = (x2 - x1) ** 2
    y = (y2 - y1) ** 2

    return Math.sqrt(x + y)
  end
end
