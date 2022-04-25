SPT::Features.ensure("rl")

alias Rl = LibRaylib

# NOTE: The classes are wrapped separately in Ruby, but still included as alias in the SDC module in Crystal
# Essentially, this allows for an equivalent syntax, while avoiding path resolution problems with Anyolite

@[Anyolite::DefaultOptionalArgsToKeywordArgs]
@[Anyolite::ExcludeInstanceMethod("transform")]
@[Anyolite::SpecializeInstanceMethod("initialize", [x : Number = 0.0, y : Number = 0.0])]
@[Anyolite::WrapWithoutKeywordsInstanceMethod("initialize")]
@[Anyolite::SpecializeInstanceMethod("x=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("y=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("+", [other : self])]
@[Anyolite::SpecializeInstanceMethod("-", [other : self])]
@[Anyolite::SpecializeInstanceMethod("*", [other : Number])]
@[Anyolite::SpecializeInstanceMethod("/", [other : Number])]
struct Rl::Vector2
  def initialize(x : Number = 0.0, y : Number = 0.0)
    self.x = x
    self.y = y
  end
end

@[Anyolite::DefaultOptionalArgsToKeywordArgs]
@[Anyolite::SpecializeInstanceMethod("initialize", [r : UInt8 = 0, g : UInt8 = 0, b : UInt8 = 0, a : UInt8 = 255])]
@[Anyolite::WrapWithoutKeywordsInstanceMethod("initialize")]
@[Anyolite::SpecializeInstanceMethod("r=", [value], [value : UInt8])]
@[Anyolite::SpecializeInstanceMethod("g=", [value], [value : UInt8])]
@[Anyolite::SpecializeInstanceMethod("b=", [value], [value : UInt8])]
@[Anyolite::SpecializeInstanceMethod("a=", [value], [value : UInt8])]
struct Rl::Color
  def initialize(r : UInt8 = 0, g : UInt8 = 0, b : UInt8 = 0, a : UInt8 = 255)
    self.r = r
    self.g = g
    self.b = b
    self.a = a
  end
end

@[Anyolite::DefaultOptionalArgsToKeywordArgs]
@[Anyolite::SpecializeInstanceMethod("initialize", [width : Number, height : Number, origin : Rl::Vector2 = Rl::Vector2.new])]
@[Anyolite::SpecializeInstanceMethod("x=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("y=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("width=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("height=", [value], [value : Number])]
struct Rl::Rectangle
  def initialize 
  end

  def initialize(width : Number, height : Number, origin : Rl::Vector2 = Rl::Vector2.new)
    self.width = width
    self.height = height
    self.x = origin.x
    self.y = origin.y
  end

  def origin=(value : Rl::Vector2)
    self.x = value.x
    self.y = value.y
  end

  def draw(color : Rl::Color)
    Rl.draw_rectangle_rec(self, color)
  end
end

@[Anyolite::ExcludeConstant("Vector2")]
@[Anyolite::ExcludeConstant("Color")]
@[Anyolite::ExcludeConstant("Rectangle")]
module SDC
  alias Vector2 = Rl::Vector2
  alias Color = Rl::Color
  alias Rectangle = Rl::Rectangle

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
      LibRaylib.draw_text("Basic Shapes", 20, 20, 20, LibRaylib::DARKGRAY)
      LibRaylib.draw_circle(@width/5, 120, 35, LibRaylib::DARKBLUE);
      LibRaylib.draw_circle_gradient(@width/5, 220, 60, LibRaylib::GREEN, LibRaylib::SKYBLUE);
      LibRaylib.draw_circle_lines(@width/5, 340, 80, LibRaylib::DARKBLUE);

      SDC::Rectangle.new(width: 120, height: 60, origin: SDC::Vector2.new(@width/4*2 - 60, 100)).draw(Rl::RED)

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

def load_engine_library(rb)
  Anyolite.wrap(rb, SDC, verbose: true)
  Anyolite.wrap(rb, Rl::Vector2, under: SDC, verbose: true)
  Anyolite.wrap(rb, Rl::Color, under: SDC, verbose: true)
  Anyolite.wrap(rb, Rl::Rectangle, under: SDC, verbose: true)
end