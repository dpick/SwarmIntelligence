require 'pp'

class ProductionSystem

  ############################################
  #
  # Rules
  #
  ############################################

  def move_left(unit, field)
    move(unit, field, unit.x, unit.y - 1)
  end

  def move_right(unit, field)
    move(unit, field, unit.x, unit.y + 1)
  end

  def move_up(unit, field)
    move(unit, field, unit.x - 1, unit.y)
  end

  def move_down(unit, field)
    move(unit, field, unit.x + 1, unit.y)
  end


  ############################################
  #
  # Helper Methods
  #
  ############################################

  def move(unit, field, newX, newY)
    conditional = lambda { |unit, field| field.position_available(newX, newY) }
    action = lambda { |unit, field| unit.move(newX, newY) }

    run_rule(conditional, action, unit, field)
  end

  ############################################

  def run_rule(conditional, action, unit, field)
    if conditional.call(unit, field)
      action.call(unit, field)
      return true
    end

    return false
  end
end
