SPT::Features.ensure("rl")

alias Rl = LibRaylib

module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]

  class Window
    def initialize(@title : String, @width : Int32, @height : Int32)
      Rl.init_window(width, height, title)
    end

    def close
      Rl.close_window
    end

    def width
      @width
    end

    def height
      @height
    end

    def resize(new_width : Int32, new_height : Int32)
      @width = new_width
      @height = new_height

      Rl.set_window_size(@width, @height)
    end
  end
end

def load_engine_library(rb)
  Anyolite.wrap(rb, SDC, verbose: true)

  window = SDC::Window.new("Shipectral", 800, 450)
  LibRaylib.set_target_fps(60)

  until LibRaylib.close_window?
    LibRaylib.begin_drawing
    LibRaylib.clear_background(LibRaylib::RAYWHITE)
    LibRaylib.draw_text("Basic Shapes", 20, 20, 20, LibRaylib::DARKGRAY)
    LibRaylib.draw_circle(window.width/5, 120, 35, LibRaylib::DARKBLUE);
    LibRaylib.draw_circle_gradient(window.width/5, 220, 60, LibRaylib::GREEN, LibRaylib::SKYBLUE);
    LibRaylib.draw_circle_lines(window.width/5, 340, 80, LibRaylib::DARKBLUE);

    LibRaylib.draw_rectangle(window.width/4*2 - 60, 100, 120, 60, LibRaylib::RED);
    LibRaylib.draw_rectangle_gradient_h(window.width/4*2 - 90, 170, 180, 130, LibRaylib::MAROON, LibRaylib::GOLD);
    LibRaylib.draw_rectangle_lines(window.width/4*2 - 40, 320, 80, 60, LibRaylib::ORANGE); 

    a = LibRaylib::Vector2.new
    a.x = window.width / 4.0 * 3.0
    a.y = 80.0

    b = LibRaylib::Vector2.new
    b.x = window.width / 4.0 * 3.0 - 60.0
    b.y = 150.0

    c = LibRaylib::Vector2.new
    c.x = window.width / 4.0 * 3.0 + 60.0
    c.y = 150.0
    LibRaylib.draw_triangle(a, b, c, LibRaylib::VIOLET);

    a.x = window.width / 4.0 * 3.0
    a.y = 160.0

    b.x = window.width / 4.0 * 3.0 - 20.0
    b.y = 230.0

    c.x = window.width / 4.0 * 3.0 + 20.0
    c.y = 230.0
    LibRaylib.draw_triangle_lines(a, b, c, LibRaylib::DARKBLUE)

    a.x = window.width / 4.0 * 3.0
    a.y = 320.0

    LibRaylib.draw_poly(a, 6, 80, 0, LibRaylib::BROWN)
    LibRaylib.draw_poly_lines_ex(a, 6, 80, 0, 6, LibRaylib::BEIGE)

    LibRaylib.draw_line(17, 42, window.width - 18, 42, LibRaylib::BLACK)
    LibRaylib.end_drawing
  end

  window.close
end