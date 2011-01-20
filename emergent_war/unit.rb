require 'object'
require 'production_system'

class Unit < Object
  attr_accessor :army_name, :damage, :health, :vision

  def initialize(army_name, x = 0, y = 0, damage = 5, health = 100, vision = 5, rules = [])
    super(x, y, rules)
    @army_name = army_name
    @damage = damage
    @health = health
    @vision = vision
    @production_system = ProductionSystem.new
  end

  def fire_rule(field)
    @rules.each do |rule|
      return true if @production_system.send(rule, self, field)
    end
  end

  def take_hit(damage)
    @health > damage ? @health -= damage : @health = 0
  end

  def move_up
    move(@x - 1, @y)
  end

  def move_down
    move(@x + 1, @y)
  end

  def move_left
    move(@x, @y - 1)
  end

  def move_right
    move(@x, @y + 1)
  end

  def move(x, y)
    @x, @y = x, y
    @shape.move(y * 10, x * 10)
  end
end
