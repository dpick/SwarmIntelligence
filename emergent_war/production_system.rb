class ProductionSystem

  def attack_opponent(unit, field)
    conditional = lambda { |unit, field| not field.visible_enemies(unit).empty? }

    action = lambda do |unit, field|
      unit_to_attack = field.visible_enemies(unit).first
      health = unit_to_attack.take_hit(unit.damage)
      field.field_objects.delete(unit_to_attack) if health == 0
    end

    run_rule(conditional, action, unit, field)
  end

  def move_towards_teammate(unit, field)
    move_towards_unit(unit, field, field.visible_teammates(unit))
  end

  def move_towards_enemy(unit, field)
    move_towards_unit(unit, field, field.visible_enemies(unit))
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
    action = lambda { |unit, field| unit.move(newX, newY); return true }

    run_rule(conditional, action, unit, field)
  end

  def ave_position(unit_list)
    return nil, nil if unit_list.empty?

    ave_pos = unit_list.inject([0, 0]) do |pos, unit|
      [ pos[0] += unit.x, pos[1] += unit.y ]
    end

    ave_pos.map! { |coord| coord / unit_list.size }
  end

  def move_towards_unit(unit, field, visible_units)
    bounding_points = field.bounding_points(visible_units)
    newX, newY = field.move_towards_bounding_box(bounding_points, unit.x, unit.y)

    conditional = lambda { |unit, field| rand < 0.98 && !newX.nil? && !newY.nil? }

    action = lambda do |unit, field|
      move(unit, field, unit.x + newX, unit.y + newY)
    end

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
