require 'unit'
require 'pp'
require 'wall'

class Field
  attr_accessor :height, :width, :field_objects, :available_coordinates

  def initialize(height = 50, width = 50)
    @height = height
    @width = width
    @field_objects = []
    @available_coordinates = []

    0.upto(height - 1).each do |row|
      0.upto(width - 1).each do |col|
        @available_coordinates << [row, col]
      end
    end
  end

  def generate_units(army_name, num = 5)
    1.upto(num).each do |unit_num|
      x, y = get_random_coordinates
      rules = [:move_left, :move_right, :move_up, :move_down]
      @field_objects << Unit.new(army_name, x, y, 10, 100, 5, rules)
    end
  end

  def generate_obstacles(num = 30)
    1.upto(num).each do |obstacle_num|
      x, y = get_random_coordinates
      @field_objects << Wall.new(x, y, [])
    end
  end

  def position_available(x, y)
    return false if x < 0 || y < 0 || x > height - 1 || y > width - 1

    pp @field_objects

    @field_objects.each do |object|
      return false if object.x == x && object.y == y
    end

    return true
  end

  def get_random_coordinates
    @available_coordinates.delete_at(rand(@available_coordinates.size))
  end
end
