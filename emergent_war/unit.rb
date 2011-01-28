require 'war_object'
require 'production_system'

class Unit < WarObject
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
    #@rules.delete(:attack_opponent)
    #@rules.shuffle!
    #@rules.insert(0, :attack_opponent)
    @rules.each do |rule|
      if @production_system.send(rule, self, field)
        return true
      end
    end
  end

  def destroy
    @shape.remove unless @shape.nil?
  end

  def take_hit(damage)
    @health > damage ? @health -= damage : @health = 0
    destroy if @health == 0
    return @health
  end

  def move(x, y)
    @x, @y = x, y
    #Shoes does things backwards :(
    @shape.move(y * 10, x * 10) unless @shape.nil?
  end
end
