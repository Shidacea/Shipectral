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

    def demo_run
      LibRaylib.begin_drawing
      LibRaylib.clear_background(LibRaylib::RAYWHITE)

      text = SDC::Text.new(content: "Basic Shapes", position: SDC::Vector2.new(20, 20), font_size: 20, color: LibRaylib::DARKGRAY)
      text.draw

      LibRaylib.draw_circle(@width/5, 120, 35, LibRaylib::DARKBLUE);
      LibRaylib.draw_circle_gradient(@width/5, 220, 60, LibRaylib::GREEN, LibRaylib::SKYBLUE);
      LibRaylib.draw_circle_lines(@width/5, 340, 80, LibRaylib::DARKBLUE);

      SDC::Rectangle.new(width: 120, height: 60, origin: SDC::Vector2.new(@width/4*2 - 60, 100)).draw(LibRaylib::RED)

      LibRaylib.draw_rectangle_gradient_h(@width/4*2 - 90, 170, 180, 130, LibRaylib::MAROON, LibRaylib::GOLD);
      LibRaylib.draw_rectangle_lines(@width/4*2 - 40, 320, 80, 60, LibRaylib::ORANGE); 

      a = SDC::Vector2.new(@width / 4.0 * 3.0, 80.0)
      b = SDC::Vector2.new(@width / 4.0 * 3.0 - 60.0, 150.0)
      c = SDC::Vector2.new(@width / 4.0 * 3.0 + 60.0, 150.0)

      LibRaylib.draw_triangle(a, b, c, LibRaylib::VIOLET);

      a.x = @width / 4.0 * 3.0
      a.y = 160.0

      b.x = @width / 4.0 * 3.0 - 20.0
      b.y = 230.0

      c.x = @width / 4.0 * 3.0 + 20.0
      c.y = 230.0

      LibRaylib.draw_triangle_lines(a, b, c, LibRaylib::DARKBLUE)

      a.x = @width / 4.0 * 3.0
      a.y = 320.0

      LibRaylib.draw_poly(a, 6, 80, 0, LibRaylib::BROWN)
      LibRaylib.draw_poly_lines_ex(a, 6, 80, 0, 6, LibRaylib::BEIGE)

      LibRaylib.draw_line(17, 42, @width - 18, 42, LibRaylib::BLACK)
      LibRaylib.end_drawing
    end

    def resize(new_width : Int32, new_height : Int32)
      @width = new_width
      @height = new_height

      Rl.set_window_size(@width, @height)
    end
  end
end