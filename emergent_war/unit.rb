require 'war_object'
require 'pp'
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
    @previous_rule = Hash.new
    @rules[4].shuffle! unless @rules[4].nil?
  end

  def fire_rule(field)
    @rules.each do |priority, rules|
      rules.each do |rule|
        if @production_system.send(rule, self, field)
          @previous_rule[priority] = rule
          move_rule_to_end(priority) if @previous_rule[priority] != rules.first

          return true
        end
      end
    end
  end

  def direction_towards(toward_x, toward_y)
    x, y = toward_x - @x, toward_y - @y

    max = [x, y].map { |i| i.abs }.max
    max += 1 if max == 0
    x, y = x / max, y / max

    return x, y
  end

  def move_rule_to_end(priority)
    temp_rule = @rules[priority].shift
    @rules[priority] << temp_rule
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
    @shape.move(y * 10, x * 10) unless @shape.nil?
  end
end
