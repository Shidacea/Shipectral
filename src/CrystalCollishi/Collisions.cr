module Collishi
  def self.fraction_less_than_zero(nominator, denominator)
    if nominator == 0
      return false
    elsif (nominator < 0) != (denominator < 0)
      return true
    else
      return false
    end
  end

  def self.fraction_between_zero_and_one(nominator, denominator)
    if fraction_less_than_zero(nominator, denominator)
      return false
    elsif nominator.abs > denominator.abs
      return false
    else
      return true
    end
  end

  def self.between(value, border_1, border_2)
    interval = {border_1, border_2}.minmax
    if value < interval[0]
      return false
    elsif value > interval[1]
      return false
    else
      return true
    end
  end

  def self.overlap(tuple_1, tuple_2)
    minmax_1 = tuple_1.minmax
    minmax_2 = tuple_2.minmax

    if minmax_2[1] < minmax_1[0]
      return false
    elsif minmax_1[0] < minmax_2[1]
      return false
    else
      return true
    end
  end

  def self.sign_square(x)
    return (x < 0.0 ? -x * x : x * x)
  end

  def self.collision_point_point(x1, y1, x2, y2)
    return (x1 == x2 && y1 == y2)
  end

  def self.collision_point_line(x1, y1, x2, y2, dx2, dy2)
    dx12 = x1 - x2
    dy12 = y1 - y2

    return false if dx12 * dy2 != dy12 * dx2

    projection = dx12 * dx2 + dy12 * dy2

    return false if !between(projection, 0.0, dx2 * dx2 + dy2 * dy2)

    return true
  end

  def self.collision_point_circle(x1, y1, x2, y2, r2)
    dx = x1 - x2
    dy = y1 - y2

    return false if dx * dx + dy * dy > r2 * r2

    return true
  end

  def self.collision_point_box(x1, y1, x2, y2, w2, h2)
    return false if x1 < x2
    return false if y1 < y2
    return false if x2 + w2 < x1
    return false if y2 + h2 < y1

    return true
  end

  def self.collision_point_triangle(x1, y1, x2, y2, sxa2, sya2, sxb2, syb2)
    dx12 = x1 - x2
    dy12 = y1 - y2

    nominator_u = dx12 * syb2 - dy12 * sxb2
    denominator_u = sxa2 * syb2 - sxb2 * sya2

    return false if !fraction_between_zero_and_one(nominator_u, denominator_u)

    nominator_v = dx12 * sya2 - dy12 * sxa2
    denominator_v = -denominator_u

    return false if !fraction_between_zero_and_one(nominator_v, denominator_v)

    nominator_u_v = nominator_u - nominator_v

    return false if !fraction_between_zero_and_one(nominator_u_v, denominator_u)

    return true
  end

  # TODO: Other shapes

end
