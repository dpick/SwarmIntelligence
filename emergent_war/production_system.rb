class ProductionSystem

  ############################################
  # Rules
  ############################################

  def move_towards_teammate(unit, field)
    closest = field.closest_visible_teammate(field.visible_teammates(unit), unit)

    conditional = lambda { |unit, field| (not closest.nil?) && rand < 0.9 }

    action = lambda do |unit, field|
      newX, newY = unit.direction_towards(closest)
      move(unit, field, unit.x + newX, unit.y + newY)
    end

    run_rule(conditional, action, unit, field)
  end

  def attack_opponent(unit, field)
    conditional = lambda { |unit, field| not field.visible_enemies(unit).empty? }

    action = lambda do |unit, field|
      unit_to_attack = field.visible_enemies(unit).first
      health = unit_to_attack.take_hit(unit.damage)
      field.field_objects.delete(unit_to_attack) if health == 0
    end

    run_rule(conditional, action, unit, field)
  end

  def move_left(unit, field)
    move(unit, field, unit.x - 1, unit.y)
  end

  def move_right(unit, field)
    move(unit, field, unit.x + 1, unit.y)
  end

  def move_up(unit, field)
    move(unit, field, unit.x, unit.y + 1)
  end

  def move_down(unit, field)
    move(unit, field, unit.x, unit.y - 1)
  end

  ############################################
  # Helper Methods
  ############################################

  def move(unit, field, newX, newY)
    conditional = lambda { |unit, field| field.position_available(newX, newY) }
    action = lambda { |unit, field| unit.move(newX, newY) }

    run_rule(conditional, action, unit, field)
  end

  ############################################

  def run_rule(conditional, action, unit, field)
    if conditional.call(unit, field)
      return action.call(unit, field)
    end

    return false
  end
end
