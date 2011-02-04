module UnitMethods

  def bounding_points(units)
    units = units.map { |unit| [unit.x, unit.y] }

    min_x, min_y, max_x, max_y = nil, nil, nil, nil

    units.each do |x, y|
      min_x = x if min_x.nil? || x < min_x
      min_y = y if min_y.nil? || y < min_y
      max_x = x if max_x.nil? || x > max_x
      max_y = y if max_y.nil? || y > max_y
    end

    return { :min_x => min_x,
             :max_x => max_x,
             :min_y => min_y,
             :max_y => max_y }
  end

  def inside_bounding_box?(bounding_points, x, y)
    bounding_points.each { |key, value| return false if value.nil? }

    temp = x <= bounding_points[:max_x]
    temp = temp && x >= bounding_points[:min_x]
    temp = temp && y <= bounding_points[:max_y]
    temp = temp && y >= bounding_points[:min_y]

    return temp
  end

  def y_in_bounding_box?(bounding_points, y)
    y > bounding_points[:min_y] && y < bounding_points[:max_y]
  end

  def x_in_bounding_box?(bounding_points, x)
    x > bounding_points[:min_y] && x < bounding_points[:max_y]
  end

  def move_towards_bounding_box(bounding_points, x, y)
    return nil, nil if bounding_points.values.include?(nil)
    return 0, 0 if inside_bounding_box?(bounding_points, x, y)

    return 1, 0 if x < bounding_points[:min_x] && y_in_bounding_box?(bounding_points, y)
    return -1, 0 if x > bounding_points[:max_x] && y_in_bounding_box?(bounding_points, y)
    return 0, 1 if y < bounding_points[:min_y] && x_in_bounding_box?(bounding_points, x)
    return 0, -1 if y < bounding_points[:max_y] && x_in_bounding_box?(bounding_points, x)

    return nil, nil
  end

  def get_random_coordinates
    @available_coordinates.delete_at(rand(@available_coordinates.size))
  end

  def visible_enemies(unit)
    visible_units(unit).select { |i| unit.army_name != i.army_name }
  end

  def visible_teammates(unit)
    visible_units(unit).select { |i| unit.army_name == i.army_name }
  end

  def visible_units(unit)
    @field_objects.select do |object|
      temp = object.class == Unit && (object.x - unit.x).abs <= unit.vision && (object.y - unit.y).abs <= unit.vision
      temp && (not object.x == unit.x && object.y == unit.y)
    end
  end

  def closest_visible_teammate(visible_teammates, unit)
    return nil if visible_teammates.empty?

    distances = visible_teammates.map { |teammate| [distance(unit.x, unit.y, teammate.x, teammate.y), teammate] }
    distances.min { |a, b| a.first <=> b.first }.last
  end

end
