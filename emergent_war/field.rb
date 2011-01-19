class Field
  attr_accessor :height, :width, :units

  def initialize(height = 50, width = 50)
    @height = height
    @width = width
    @units = []
  end

  def generate_units(army_name, num = 10)
    0.upto(num).each do |unit_num|
      @units << Unit.new(army_name)
    end
  end

  def generate_obstacles(num = 20)

  end
end
