require 'field'
require 'yaml'
require 'pp'

class EmergentWar
  attr_accessor :field

  def initialize(height, width)
    @field = Field.new(height, width)
    @config = YAML::load_file("config.yml")
    @field.generate_units("army_1", @config["num_units"])
    @field.generate_units("army_2", @config["num_units"])
    @field.generate_obstacles(@config["num_walls"])
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
