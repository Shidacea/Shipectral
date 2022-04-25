module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Window
    def initialize(@title : String, @width : Int32, @height : Int32)
      Rl.init_window(width, height, title)
    end

    def close
      Rl.close_window
    end

    def target_fps=(fps : Int32)
      LibRaylib.set_target_fps(fps)
    end

    def width
      @width
    end

    def height
      @height
    end

    def close?
      LibRaylib.close_window?
    end

    def clear(color : Rl::Color = Rl::Color::BLACK)
      LibRaylib.clear_background(color)
    end

    @[Anyolite::AddBlockArg(1, Nil)]
    def draw_routine
      LibRaylib.begin_drawing
      yield nil
      LibRaylib.end_drawing
    end

    def demo_run
      draw_routine do
        clear(SDC::Color::RAYWHITE)

        text = SDC::Text.new(content: "Basic Shapes", position: SDC::Vector2.new(20, 20), font_size: 20, color: SDC::Color::DARKGRAY)
        text.draw

        LibRaylib.draw_circle(@width/5, 120, 35, SDC::Color::DARKBLUE)
        LibRaylib.draw_circle_gradient(@width/5, 220, 60, SDC::Color::GREEN, SDC::Color::SKYBLUE)
        LibRaylib.draw_circle_lines(@width/5, 340, 80, SDC::Color::DARKBLUE)

        test_rectangle = SDC::ShapeBox.new(SDC::Vector2.new(120, 60), origin: SDC::Vector2.new(@width/4*2 - 60, 100))
        test_rectangle.color = SDC::Color::RED
        test_rectangle.draw

        LibRaylib.draw_rectangle_gradient_h(@width/4*2 - 90, 170, 180, 130, SDC::Color::MAROON, SDC::Color::GOLD)
        LibRaylib.draw_rectangle_lines(@width/4*2 - 40, 320, 80, 60, SDC::Color::ORANGE);

        a = SDC::Vector2.new(@width / 4.0 * 3.0, 80.0)
        b = SDC::Vector2.new(@width / 4.0 * 3.0 - 60.0, 150.0)
        c = SDC::Vector2.new(@width / 4.0 * 3.0 + 60.0, 150.0)

        LibRaylib.draw_triangle(a, b, c, SDC::Color::VIOLET)

        a.x = @width / 4.0 * 3.0
        a.y = 160.0

        b.x = @width / 4.0 * 3.0 - 20.0
        b.y = 230.0

        c.x = @width / 4.0 * 3.0 + 20.0
        c.y = 230.0

        LibRaylib.draw_triangle_lines(a, b, c, SDC::Color::DARKBLUE)

        a.x = @width / 4.0 * 3.0
        a.y = 320.0

        LibRaylib.draw_poly(a, 6, 80, 0, SDC::Color::BROWN)
        LibRaylib.draw_poly_lines_ex(a, 6, 80, 0, 6, SDC::Color::BEIGE)

        LibRaylib.draw_line(17, 42, @width - 18, 42, SDC::Color::BLACK)
      end
    end

    def resize(new_width : Int32, new_height : Int32)
      @width = new_width
      @height = new_height

      Rl.set_window_size(@width, @height)
    end
  end
end