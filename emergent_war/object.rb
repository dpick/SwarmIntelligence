class Object
  attr_accessor :x, :y, :shape

  def initialize(x = 0, y = 0, rules = [])
    @x = x
    @y = y
    @shape = nil
    @rules = rules
  end
end
