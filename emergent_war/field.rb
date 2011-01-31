require 'unit'
require 'pp'
require 'wall'
require 'yaml'

class Field
  attr_accessor :height, :width, :field_objects, :available_coordinates, :config

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

  def generate_units(army_name, num = 20, rules = @config["unit_rules"])
    1.upto(num).each do |unit_num|
      x, y = get_random_coordinates
      rules = Marshal::load(Marshal.dump(rules))
      @field_objects << Unit.new(army_name, x, y, rand(9) + 1, 100, 5, rules)
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

  def get_random_coordinates
    @available_coordinates.delete_at(rand(@available_coordinates.size))
  end

  def visible_enemies(unit)
    visible_units(unit).delete_if { |i| unit.army_name == i.army_name }
  end

  def visible_teammates(unit)
    visible_units(unit).delete_if { |i| unit.army_name != i.army_name }
  end

  def visible_units(unit)
    units_in_sight = []

    @field_objects.each do |object|
      if object.class == Unit && (object.x - unit.x).abs <= unit.vision && (object.y - unit.y).abs <= unit.vision
        units_in_sight << object unless (object.x == unit.x && object.y == unit.y)
      end
    end

    return units_in_sight
  end

  def closest_visible_teammate(visible_teammates, unit)
    min_distance = height * width
    closest_teammate = nil

    visible_teammates.each do |teammate|
      if distance(unit.x, unit.y, teammate.x, teammate.y) < min_distance
        closest_teammate = teammate
        min_distance = distance(unit.x, unit.y, teammate.x, teammate.y)
      end
    end

    return closest_teammate
  end

  def distance(x1, y1, x2, y2)
    x = (x2 - x1) ** 2
    y = (y2 - y1) ** 2

    return Math.sqrt(x + y)
  end
end
