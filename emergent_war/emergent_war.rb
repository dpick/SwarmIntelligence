require 'field'

class EmergentWar
  attr_accessor :field

  def initialize(height, width)
    @field = Field.new(height, width)
    @field.generate_units("army_1", 20)
    @field.generate_units("army_2", 20)
    @field.generate_obstacles(30)
  end

  def objects
    @field.field_objects
  end

  def move_units
    @field.field_objects.each do |unit|
      unit.fire_rule(@field)
    end
  end
end
