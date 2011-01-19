require 'unit'
require 'wall'

class Field
  attr_accessor :height, :width, :field_objects, :available_coordinates

  def initialize(height = 50, width = 50)
    @height = height
    @width = width
    @field_objects = []
    @available_coordinates = { :x => Array.new(height) { |i| i },
                               :y => Array.new(width)  { |i| i } }
  end

  def generate_units(army_name, num = 10)
    0.upto(num).each do |unit_num|
      x, y = get_random_coordinates
      @field_objects << Unit.new(army_name, x, y)
    end
  end

  def generate_obstacles(num = 20)
    0.upto(num).each do |obstacle_num|
      x, y = get_random_coordinates
      @field_objects << Wall.new(x, y)
    end
  end

  def get_random_coordinates
    x = @available_coordinates[:x][rand(@available_coordinates[:x].size - 1)]
    y = @available_coordinates[:y][rand(@available_coordinates[:y].size - 1)]

    @available_coordinates[:x].delete_if { |i| i == x }
    @available_coordinates[:y].delete_if { |i| i == y }

    return x, y
  end
end
