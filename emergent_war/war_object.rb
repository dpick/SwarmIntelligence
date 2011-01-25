class WarObject
  attr_accessor :x, :y, :shape, :rules

  def initialize(x = 0, y = 0, rules = [])
    @x = x
    @y = y
    @shape = nil
    @rules = rules
  end

  def reorder_rules
    @rules = @rules.shuffle
  end

  def move_rule_to_end
    temp_rule = @rules.shift
    @rules << temp_rule
  end
end
