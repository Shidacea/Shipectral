# TODO: For now, this is just a simple example based on https://github.com/ysbaddaden/sdl.cr/blob/master/samples/08_geometry.cr

SPT::Features.ensure("sdl")

module SDC
  def self.start
    SDL.init(SDL::Init::VIDEO)
  end

  @[Extern]
  struct Color
    property r : UInt8
    property g : UInt8
    property b : UInt8
    property a : UInt8

    def initialize(@r : UInt8, @g : UInt8, @b : UInt8, @a : UInt8 = 255.to_u8)
    end
  end

  class Window
    @window : Pointer(LibSDL::Window)
    @renderer : Pointer(LibSDL::Renderer)

    getter width : Int32
    getter height : Int32

    def initialize(title : String, @width : Int32, @height : Int32)
      x = LibSDL::WindowPosition::UNDEFINED
      y = LibSDL::WindowPosition::UNDEFINED
      flags = LibSDL::WindowFlags::SHOWN

      @window = LibSDL.create_window(title, x, y, @width, @height, flags)
      @renderer = LibSDL.create_renderer(@window, -1, LibSDL::RendererFlags::ACCELERATED)
    end

    def finalize
      LibSDL.destroy_window(@window)
    end

    def to_unsafe
      @window
    end

    def clear
      LibSDL.set_render_draw_color(@renderer, 0, 0, 0, 0)
      LibSDL.render_clear(@renderer)
    end

    def display
      LibSDL.render_present(@renderer)
    end

    # DEBUG

    def demo
      LibSDL.set_render_draw_color(@renderer, 0, 0, 255, 255)
      LibSDL.render_draw_line(@renderer, 0, @height // 2, @width, @height // 2)

      LibSDL.set_render_draw_color(@renderer, 255, 255, 0, 255)
      0.step(by: 4, to: height) do |i|
        LibSDL.render_draw_point(@renderer, width // 2, i)
      end
    end
  end
end

SPT::Features.add("shidacea")

def load_engine_library(rb)
  Anyolite.wrap(rb, SDC, verbose: true)
  SDC.start

  window = SDC::Window.new("Shipectral with SDL - Proof of concept", 640, 480)
  width, height = window.width, window.height

  loop do
    case event = SDL::Event.wait
    when SDL::Event::Quit
      break
    end

    window.clear
    window.demo

    # centered red rectangle
    #renderer.draw_color = SDL::Color[255, 0, 0, 255]
    #renderer.fill_rect(width // 4, height // 4, width // 2, height // 2)

    # outlined green rectangle
    #renderer.draw_color = SDL::Color[0, 255, 0, 255]
    #renderer.draw_rect(width // 6, height // 6, width * 2 // 3, height * 2 // 3)

    # blue horizontal line
    #renderer.draw_color = SDL::Color[0, 0, 255, 255]
    #renderer.draw_line(0, height // 2, width, height // 2)

    # vertical line of yellow dots
    #renderer.draw_color = SDL::Color[255, 255, 0, 255]
    #0.step(by: 4, to: height) do |i|
    #  renderer.draw_point(width // 2, i)
    #end

    window.display
  end
end