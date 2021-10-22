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

  def self.collision_line_box(x1 : Float, y1 : Float, dx1 : Float, dy1 : Float, x2 : Float, y2 : Float, w2 : Float, h2 : Float)
    return true if collision_point_box(x1, y1, x2, y2, w2, h2)
	  return true if collision_point_box(x1 + dx1, y1 + dy1, x2, y2, w2, h2)

		nominator_x_neg = x2 - x1
		nominator_x_pos = x2 + w2 - x1
		nominator_y_neg = y2 - y1
		nominator_y_pos = y2 + h2 - y1

		nom_x_neg_dy = nominator_x_neg * dy1
		nom_x_pos_dy = nominator_x_pos * dy1
		nom_y_neg_dx = nominator_y_neg * dx1
		nom_y_pos_dx = nominator_y_pos * dx1

		if (nom_x_neg_dy >= nom_y_neg_dx) && (nom_x_neg_dy <= nom_y_pos_dx)
			return true if fraction_between_zero_and_one(nominator_x_neg, dx1)
    end

		if (nom_x_pos_dy >= nom_y_neg_dx) && (nom_x_pos_dy <= nom_y_pos_dx)
			return true if fraction_between_zero_and_one(nominator_x_pos, dx1)
    end

		if (nom_y_neg_dx >= nom_x_neg_dy) && (nom_y_neg_dx <= nom_x_pos_dy)
			return true if fraction_between_zero_and_one(nominator_y_neg, dy1)
    end

		if (nom_y_pos_dx >= nom_x_neg_dy) && (nom_y_pos_dx <= nom_x_pos_dy)
			return true if fraction_between_zero_and_one(nominator_y_pos, dy1)
    end

		return false
  end

  def self.collision_line_triangle(x1 : Float, y1 : Float, dx1 : Float, dy1 : Float, x2 : Float, y2 : Float, sxa2 : Float, sya2 : Float, sxb2 : Float, syb2 : Float)
    x21 = x2 - x1
		y21 = y2 - y1

		xa1 = x21 + sxa2
		ya1 = y21 + sya2

		xb1 = x21 + sxb2
		yb1 = y21 + syb2

		projection_2_on_n1 = y21 * dx1 - x21 * dy1
		projection_a_on_n1 = ya1 * dx1 - xa1 * dy1
		projection_b_on_n1 = yb1 * dx1 - xb1 * dy1

		p2_n1_negative = (projection_2_on_n1 < 0.0 ? 1 : 0)
		pa_n1_negative = (projection_a_on_n1 < 0.0 ? 1 : 0)
		pb_n1_negative = (projection_b_on_n1 < 0.0 ? 1 : 0)

		return false if p2_n1_negative + pa_n1_negative + pb_n1_negative == 3

		projection_1_on_na = x21 * sya2 - y21 * sxa2
		projection_d_on_na = dy1 * sxa2 - dx1 * sya2
		projection_b_on_na = syb2 * sxa2 - sxb2 * sya2

		return false if !overlap({ projection_1_on_na, projection_1_on_na + projection_d_on_na }, { 0.0, projection_b_on_na })

		projection_1_on_nb = x21 * syb2 - y21 * sxb2
		projection_d_on_nb = dy1 * sxb2 - dx1 * syb2
		projection_a_on_nb = -projection_b_on_na

		return false if !overlap({ projection_1_on_nb, projection_1_on_nb + projection_d_on_nb }, { 0.0, projection_a_on_nb })

		sxc2 = sxb2 - sxa2
		syc2 = syb2 - sya2

		projection_1_on_nc = xa1 * syc2 - ya1 * sxc2
		projection_d_on_nc = dy1 * sxc2 - dx1 * syc2
		projection_2_on_nc = projection_b_on_na

		return false if !overlap({ projection_1_on_nc, projection_1_on_nc + projection_d_on_nc }, { 0.0, projection_2_on_nc })

		return true
  end

  def self.collision_circle_circle(x1 : Float, y1 : Float, r1 : Float, x2 : Float, y2 : Float, r2 : Float)
    dx = x1 - x2
		dy = y1 - y2

		combined_radius = r1 + r2

		return false if dx * dx + dy * dy > combined_radius* combined_radius

		return true
  end

  def self.collision_circle_box(x1 : Float, y1 : Float, r1 : Float, x2 : Float, y2 : Float, w2 : Float, h2 : Float)
    dxp = (x2 + w2 - x1)
		dyp = (y2 + h2 - y1)
		dxm = (x2 - x1)
		dym = (y2 - y1)

		return false if !overlap({ dxm, dxp }, { -r1, r1 })
		return false if !overlap({ dym, dyp }, { -r1, r1 })

		dxp2 = dxp * dxp
		dxm2 = dxm * dxm
		dyp2 = dyp * dyp
		dym2 = dym * dym

		dxp2yp2 = dxp2 + dyp2
		dyp2xm2 = dyp2 + dxm2
		dxm2ym2 = dxm2 + dym2
		dym2xp2 = dym2 + dxp2

		min_dist = dxp2yp2
		vx = dxp
		vy = dyp

		if dyp2xm2 < min_dist
			min_dist = dyp2xm2
			vx = dxm
			vy = dyp
    end

		if dxm2ym2 < min_dist
			min_dist = dxm2ym2
			vx = dxm
			vy = dym
		end

		if dym2xp2 < min_dist
			min_dist = dym2xp2
			vx = dxp
			vy = dym
		end

		proj_v_pp = sign_square(dxp * vx + dyp * vy)
		proj_v_pm = sign_square(dxp * vx + dym * vy)
		proj_v_mp = sign_square(dxm * vx + dyp * vy)
		proj_v_mm = sign_square(dxm * vx + dym * vy)

		proj_r1_squared = r1 * r1 * (vx * vx + vy * vy)

		return false if !overlap({ proj_v_pp, proj_v_pm, proj_v_mp, proj_v_mm }, { -proj_r1_squared, proj_r1_squared })

		return true
  end

  def self.collision_circle_triangle(x1 : Float, y1 : Float, r1 : Float, x2 : Float, y2 : Float, sxa2 : Float, sya2 : Float, sxb2 : Float, syb2 : Float)
    dx = x1 - x2
		dy = y1 - y2

		r1_squared = r1 * r1
		cross_term = sxa2 * syb2 - sxb2 * sya2

		proj_x1_a = dy * sxa2 - dx * sya2
		proj_r1_a_squared = r1_squared * (sxa2 * sxa2 + sya2 * sya2)

		return false if !overlap({ sign_square(-proj_x1_a), sign_square(cross_term - proj_x1_a) }, { -proj_r1_a_squared, proj_r1_a_squared })

		proj_x1_b = dy * sxb2 - dx * syb2
		proj_r1_b_squared = r1_squared * (sxb2 * sxb2 + syb2 * syb2)

		return false if !overlap({ sign_square(-proj_x1_b), sign_square(-cross_term - proj_x1_b) }, { -proj_r1_b_squared, proj_r1_b_squared })

		sxc2 = sxb2 - sxa2
		syc2 = syb2 - sya2

		proj_x1_c = dy * sxc2 - dx * syc2
		proj_r1_c_squared = r1_squared * (sxc2 * sxc2 + syc2 * syc2)

		return false if !overlap({ sign_square(-proj_x1_c), sign_square(-cross_term - proj_x1_c) }, { -proj_r1_c_squared, proj_r1_c_squared })

		min_dist = dx * dx + dy * dy
		vx = -dx
		vy = -dy

		dxa = dx - sxa2
		dya = dy - sya2

		dxb = dx - sxb2
		dyb = dy - syb2

		da_norm = dxa * dxa + dya * dya
		db_norm = dxb * dxb + dyb * dyb

		if da_norm < min_dist
			min_dist = da_norm
			vx = -dxa
			vy = -dya
    end

		if db_norm < min_dist
			min_dist = db_norm
			vx = -dxb
			vy = -dyb
    end

		proj_2_0_v = sign_square(-dx * vx - dy * vy)
		proj_2_a_v = sign_square(-dxa * vx - dya * vy)
		proj_2_b_v = sign_square(-dxb * vx - dyb * vy)

		proj_r_v_squared = r1_squared * min_dist

		return false if !overlap({ proj_2_0_v, proj_2_a_v, proj_2_b_v }, { -proj_r_v_squared, proj_r_v_squared })

		return true
  end

  def self.collision_box_box(x1 : Float, y1 : Float, w1 : Float, h1 : Float, x2 : Float, y2 : Float, w2 : Float, h2 : Float)
    return false if x1 + w1 < x2
		return false if y1 + h1 < y2
		return false if x2 + w2 < x1
		return false if y2 + h2 < y1

		return true
  end

  def self.collision_box_triangle(x1 : Float, y1 : Float, w1 : Float, h1 : Float, x2 : Float, y2 : Float, sxa2 : Float, sya2 : Float, sxb2 : Float, syb2 : Float)
    x21 = x2 - x1
		y21 = y2 - y1

		return false if !overlap({ 0.0, w1 }, { x21, x21 + sxa2, x21 + sxb2 })
		return false if !overlap({ 0.0, h1 }, { y21, y21 + sya2, y21 + syb2 })

		x21_sya2 = x21 * sya2
		y21_sxa2 = y21 * sxa2

		h1_sxa2 = h1 * sxa2
		w1_sya2 = w1 * sya2

		proj_x1_on_a = x21_sya2 - y21_sxa2
		proj_b_on_a = syb2 * sxa2 - sxb2 * sya2

		return false if !overlap({ 0.0, h1_sxa2, -w1_sya2, h1_sxa2 - w1_sya2 }, { -proj_x1_on_a, proj_b_on_a - proj_x1_on_a })

		x21_syb2 = x21 * syb2
		y21_sxb2 = y21 * sxb2

		h1_sxb2 = h1 * sxb2
		w1_syb2 = w1 * syb2

		proj_x1_on_b = x21_syb2 - y21_sxb2
		proj_a_on_b = -proj_b_on_a

		return false if !overlap({ 0.0, h1_sxb2, -w1_syb2, h1_sxb2 - w1_syb2 }, { -proj_x1_on_b, proj_a_on_b - proj_x1_on_b })

		proj_x1_on_c = -x21_sya2 + x21_syb2 - y21_sxb2 + y21_sxa2 - sxa2 * sya2 + proj_b_on_a + sya2 * sxa2
		proj_2_on_c = proj_b_on_a

		diff_h1_projections = h1_sxb2 - h1_sxa2
		diff_w1_projections = w1_sya2 - w1_syb2

		return false if !overlap({ 0.0, diff_h1_projections, diff_w1_projections, diff_w1_projections + diff_h1_projections }, { -proj_x1_on_c, proj_2_on_c - proj_x1_on_c })

		return true
  end

  def self.collision_triangle_triangle(x1 : Float, y1 : Float, sxa1 : Float, sya1 : Float, sxb1 : Float, syb1 : Float, x2 : Float, y2 : Float, sxa2 : Float, sya2 : Float, sxb2 : Float, syb2 : Float)
    x21 = x2 - x1
		y21 = y2 - y1

		x21_sya1 = x21 * sya1
		y21_sxa1 = y21 * sxa1

		sxa2_sya1 = sxa2 * sya1
		sxb2_sya1 = sxb2 * sya1
		sya2_sxa1 = sya2 * sxa1
		syb2_sxa1 = syb2 * sxa1
		
		proj_x2_on_a1 = y21_sxa1 - x21_sya1
		proj_a2_on_a1 = sya2_sxa1 - sxa2_sya1
		proj_b2_on_a1 = syb2_sxa1 - sxb2_sya1
		proj_b1_on_a1 = sxb1 * (-sya1) + syb1 * sxa1

    return false if !overlap({ -proj_x2_on_a1, proj_b1_on_a1 - proj_x2_on_a1 }, { 0.0, proj_a2_on_a1, proj_b2_on_a1 })

		x21_syb1 = x21 * syb1
		y21_sxb1 = y21 * sxb1

		sxa2_syb1 = sxa2 * syb1
		sxb2_syb1 = sxb2 * syb1
		sya2_sxb1 = sya2 * sxb1
		syb2_sxb1 = syb2 * sxb1

		proj_x2_on_b1 = y21_sxb1 - x21_syb1
		proj_a2_on_b1 = sya2_sxb1 - sxa2_syb1
		proj_b2_on_b1 = syb2_sxb1 - sxb2_syb1
		proj_a1_on_b1 = -proj_b1_on_a1

		return false if !overlap({ -proj_x2_on_b1, proj_a1_on_b1 - proj_x2_on_b1 }, { 0.0, proj_a2_on_b1, proj_b2_on_b1 })

		x21_sya2 = x21 * sya2
		y21_sxa2 = y21 * sxa2

		proj_x1_on_a2 = x21_sya2 - y21_sxa2
		proj_a1_on_a2 = sxa2_sya1 - sya2_sxa1
		proj_b1_on_a2 = sxa2_syb1 - sya2_sxb1
		proj_b2_on_a2 = sxb2 * (-sya2) + syb2 * sxa2

		return false if !overlap({ -proj_x1_on_a2, proj_b2_on_a2 - proj_x1_on_a2 }, { 0.0, proj_a1_on_a2, proj_b1_on_a2 })

		x21_syb2 = x21 * syb2
		y21_sxb2 = y21 * sxb2

		proj_x1_on_b2 = x21_syb2 - y21_sxb2
		proj_a1_on_b2 = sxb2_sya1 - syb2_sxa1
		proj_b1_on_b2 = sxb2_syb1 - syb2_sxb1
		proj_a2_on_b2 = -proj_b2_on_a2

		return false if !overlap({ -proj_x1_on_b2, proj_a2_on_b2 - proj_x1_on_b2 }, { 0.0, proj_a1_on_b2, proj_b1_on_b2 })

		proj_x2_on_c1 = x21_sya1 - x21_syb1 + proj_b1_on_a1 + y21_sxb1 - y21_sxa1
		proj_a2_on_c1 = sxa2_sya1 - sxa2_syb1 + sya2_sxb1 - sya2_sxa1
		proj_b2_on_c1 = sxb2_sya1 - sxb2_syb1 + syb2_sxb1 - syb2_sxa1
		proj_x1_on_c1 = proj_b1_on_a1

		return false if !overlap({ -proj_x2_on_c1, proj_x1_on_c1 - proj_x2_on_c1 }, { 0.0, proj_a2_on_c1, proj_b2_on_c1 })

		proj_x1_on_c2 = -x21_sya2 + x21_syb2 + proj_b2_on_a2 - y21_sxb2 + y21_sxa2
		proj_a1_on_c2 = sya2_sxa1 - syb2_sxa1 + sxb2_sya1 - sxa2_sya1
		proj_b1_on_c2 = sya2_sxb1 - syb2_sxb1 + sxb2_syb1 - sxa2_syb1
		proj_x2_on_c2 = proj_b2_on_a2

		return false if !overlap({ -proj_x1_on_c2, proj_x2_on_c2 - proj_x1_on_c2 }, { 0.0, proj_a1_on_c2, proj_b1_on_c2 })

		return true
  end
end
