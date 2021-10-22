@[Anyolite::NoKeywordArgs]
module Collishi
  def self.fraction_less_than_zero(nominator : Float, denominator : Float)
    if nominator == 0
      return false
    elsif (nominator < 0) != (denominator < 0)
      return true
    else
      return false
    end
  end

  def self.fraction_between_zero_and_one(nominator : Float, denominator : Float)
    if fraction_less_than_zero(nominator, denominator)
      return false
    elsif nominator.abs > denominator.abs
      return false
    else
      return true
    end
  end

  def self.between(value : Float, border_1 : Float, border_2 : Float)
    interval = {border_1, border_2}.minmax
    if value < interval[0]
      return false
    elsif value > interval[1]
      return false
    else
      return true
    end
  end

  def self.overlap(tuple_1 : Tuple, tuple_2 : Tuple)
    minmax_1 = tuple_1.minmax
    minmax_2 = tuple_2.minmax

    if minmax_2[1] < minmax_1[0]
      return false
    elsif minmax_1[1] < minmax_2[0]
      return false
    else
      return true
    end
  end

  def self.sign_square(x : Float)
    return (x < 0.0 ? -x * x : x * x)
  end

  def self.collision_point_point(x1 : Float, y1 : Float, x2 : Float, y2 : Float)
    return (x1 == x2 && y1 == y2)
  end

  def self.collision_point_line(x1 : Float, y1 : Float, x2 : Float, y2 : Float, dx2 : Float, dy2 : Float)
    dx12 = x1 - x2
    dy12 = y1 - y2

    return false if dx12 * dy2 != dy12 * dx2

    projection = dx12 * dx2 + dy12 * dy2

    return false if !between(projection, 0.0, dx2 * dx2 + dy2 * dy2)

    return true
  end

  def self.collision_point_circle(x1 : Float, y1 : Float, x2 : Float, y2 : Float, r2 : Float)
    dx = x1 - x2
    dy = y1 - y2

    return false if dx * dx + dy * dy > r2 * r2

    return true
  end

  def self.collision_point_box(x1 : Float, y1 : Float, x2 : Float, y2 : Float, w2 : Float, h2 : Float)
    return false if x1 < x2
    return false if y1 < y2
    return false if x2 + w2 < x1
    return false if y2 + h2 < y1

    return true
  end

  def self.collision_point_triangle(x1 : Float, y1 : Float, x2 : Float, y2 : Float, sxa2 : Float, sya2 : Float, sxb2 : Float, syb2 : Float)
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

  def self.collision_line_line(x1 : Float, y1 : Float, dx1 : Float, dy1 : Float, x2 : Float, y2 : Float, dx2 : Float, dy2 : Float)
    cross_term = dx2 * dy1 - dy2 * dx1

		if cross_term == 0.0
			return true if collision_point_line(x1, y1, x2, y2, dx2, dy2)
			return true if collision_point_line(x2, y2, x1, y1, dx1, dy1)
    end

		y21 = y2 - y1
		x21 = x2 - x1

		projection_2_on_n1 = y21 * dx1 - x21 * dy1

    return false if (projection_2_on_n1 < 0.0) == (projection_2_on_n1 < cross_term)

		projection_1_on_n2 = x21 * dy2 - y21 * dx2

    return false if (projection_1_on_n2 < 0.0) == (projection_1_on_n2 < -cross_term)

		return true
  end

  def self.collision_line_circle(x1 : Float, y1 : Float, dx1 : Float, dy1 : Float, x2 : Float, y2 : Float, r2 : Float)
    x21 = x2 - x1
		y21 = y2 - y1

		r2_squared = r2 * r2

		proj_circle_normal = y21 * dx1 - x21 * dy1
		proj_circle_normal_max = r2_squared * (dx1 * dx1 + dy1 * dy1)

    return false if !between(sign_square(proj_circle_normal), -proj_circle_normal_max, proj_circle_normal_max)

		x2d1 = x21 - dx1
		y2d1 = y21 - dy1

		distance_1_2 = x21 * x21 + y21 * y21
		distance_d_2 = x2d1 * x2d1 + y2d1 * y2d1

		if distance_1_2 < distance_d_2
			p1 = sign_square(distance_1_2)
			p2 = sign_square(distance_1_2 - dx1 * x21 - dy1 * y21)

			proj_r2_squared = r2_squared * (x21 * x21 + y21 * y21)

			return false if !overlap({ p1, p2 }, { -proj_r2_squared, proj_r2_squared })
    else
			p1 = sign_square(distance_d_2)
			p2 = sign_square(distance_1_2 - dx1 * x21 - dy1 * y21)

			proj_r2_squared = r2_squared * (x2d1 * x2d1 + y2d1 * y2d1)

			return false if !overlap({ p1, p2 }, { -proj_r2_squared, proj_r2_squared })
		end

		return true
  end

  def self.collision_line_box
  end

  def self.collision_line_triangle
  end

  def self.collision_circle_circle
  end

  def self.collision_circle_box
  end

  def self.collision_circle_triangle
  end

  def self.collision_box_box
  end

  def self.collision_box_triangle
  end

  def self.collision_triangle_triangle
  end
end
