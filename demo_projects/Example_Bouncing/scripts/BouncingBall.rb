class BouncingBall < SDC::Entity
  add_shape(index: 0, type: SDC::CollisionShapeCircle, radius: 25.0)
  add_box(index: 0, size: SDC.xy(50.0, 50.0), offset: SDC.xy(0.0, 0.0), origin: SDC.xy(25, 25))

  def at_init
    @position = SDC.xy(SDC.window.width * rand, SDC.window.height * rand)

    rx = (0.5 - rand) * 10.0
    ry = (0.5 - rand) * 10.0
    @new_velocity_diff = SDC.xy(rx, ry)

    @draw_shape = SDC::Graphics::Shapes::Circle.new
    @draw_shape.get_from(@shapes[0])
    @draw_shape.fill_color = SDC.color(255 * rand, 255 * rand, 255 * rand)
  end

  def custom_pre_physics
    @velocity += @new_velocity_diff
    @new_velocity_diff = SDC.xy
  end

  def custom_update
    if @position.x < 0 + 25
      @position.x = 0 + 25
      @velocity.x *= -1.0
    elsif @position.x > SDC.window.width - 25
      @position.x = SDC.window.width - 25
      @velocity.x *= -1.0
    end
    if @position.y < 0 + 25
      @position.y = 0 + 25
      @velocity.y *= -1.0
    elsif @position.y > SDC.window.height - 25
      @position.y = SDC.window.height - 25
      @velocity.y *= -1.0
    end
  end

  def custom_draw(window)
    window.draw_translated(@draw_shape, z: 1, at: @position)
  end
end