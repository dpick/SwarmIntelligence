class EmergentWar
  attr_accessor :field

  def initialize(height, width)
    @field = Field.new(height, width)
    @field.generate_units("army 1")
    @field.generate_obstacles
  end
end
