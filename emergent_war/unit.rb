class Unit
  attr_accessor :army_name, :damage, :health, :vision, :x, :y

  def initialize(army_name, x = 0, y = 0, damage = 5, health = 100, vision = 5)
    @army_name = army_name
    @damage = damage
    @health = health
    @vision = vision
    @x = x
    @y = y
  end

  def take_hit(damage)
    @health > damage ? @health -= damage : @health = 0
  end
end
