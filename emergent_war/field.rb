require 'unit'
require 'pp'
require 'wall'
require 'yaml'

class Field
  attr_accessor :height, :width, :field_objects, :available_coordinates

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

  def generate_units(army_name, num = 20)
    1.upto(num).each do |unit_num|
      x, y = get_random_coordinates
      @field_objects << Unit.new(army_name, x, y, rand(9) + 1, 100, rand(2) + 1, @config["unit_rules"].clone)
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
    enemies_in_sight = []

    @field_objects.each do |object|
      if object.class == Unit && (object.x - unit.x).abs <= unit.vision && (object.y - unit.y).abs <= unit.vision && object.army_name != unit.army_name
        enemies_in_sight << object unless (object.x == unit.x && object.y == unit.y)
      end
    end

    return enemies_in_sight
  end

  def visible_teammates(unit)
    teammates_in_sight = []

    @field_objects.each do |object|
      if object.class == Unit && (object.x - unit.x).abs <= unit.vision && (object.y - unit.y).abs <= unit.vision && object.army_name == unit.army_name
        teammates_in_sight << object unless (object.x == unit.x && object.y == unit.y)
      end
    end

    return teammates_in_sight
  end

  def closest_visible_teammate(visible_teammates, unit)
    min_distance = 100000
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
