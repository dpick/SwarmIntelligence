class ProductionSystem

  MOVEMENTS = [["left",      -1,   0],
               ["right",      1,   0],
               ["up",         0,   1],
               ["down",       0,  -1],
               ["upright",    1,   1],
               ["upleft",    -1,   1],
               ["downleft",  -1,  -1],
               ["downright",  1,  -1]]


  def initialize
    MOVEMENTS.each do |direction, dx, dy|
      self.class.send(:define_method, "move_#{direction}") do |unit, field| 
        move(unit, field, unit.x + dx, unit.y + dy)
      end
    end
  end

  def avoid_enemy_group(unit, field)
    conditional = lambda { |unit, field| field.visible_enemies(unit).size > field.visible_teammates(unit).size }

    action = lambda do |unit, field|
      move_away_from_enemies(unit, field)
    end
  end

  def attack_opponent(unit, field)
    conditional = lambda { |unit, field| not field.attackable_units(unit).empty? }

    action = lambda do |unit, field|
      unit_to_attack = field.attackable_units(unit).first
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

  def move_away_from_enemies(unit, field)
    move_away_from_unit(unit, field, field.visible_enemies(unit))
  end

  def move_away_from_teammates(unit, field)
    move_away_from_unit(unit, field, field.visible_teammates(unit))
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

  def move_away_from_unit(unit, field, visible_units)
    aveX, aveY = ave_position(visible_units)
    return false if aveX.nil? || aveY.nil?
    newX, newY = unit.direction_towards(aveX, aveY).map! { |i| i * -1 }

    move_direction(unit, field, newX, newY)
  end

  def move_towards_unit(unit, field, visible_units)
    aveX, aveY = ave_position(visible_units)
    return false if aveX.nil? || aveY.nil?
    newX, newY = unit.direction_towards(aveX, aveY)

    move_direction(unit, field, newX, newY)
  end

  def move_direction(unit, field, newX, newY)
    conditional = lambda { |unit, field| rand < 0.95 }

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
