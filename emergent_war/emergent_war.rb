require 'field'

class EmergentWar
  attr_accessor :field

  def initialize(height, width)
    @field = Field.new(height, width)
    @field.generate_units("army 1")
    @field.generate_obstacles
  end

  def objects
    @field.field_objects
  end

  def move_units
    @field.field_objects.first.fire_rule(@field)
  end
end
