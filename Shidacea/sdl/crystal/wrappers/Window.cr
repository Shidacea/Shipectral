module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Window
    SDCHelper.wrap_type(Pointer(LibSDL::Window))

    getter renderer : SDC::Renderer = SDC::Renderer.new

    def initialize(title : String, w : Int, h : Int, x : Int = LibSDL::WINDOWPOS_UNDEFINED, y : Int = LibSDL::WINDOWPOS_UNDEFINED, fullscreen : Bool = false, set_as_current : Bool = true)
      window_flags = fullscreen ? LibSDL::WindowFlags::WINDOW_SHOWN | LibSDL::WindowFlags::WINDOW_FULLSCREEN : LibSDL::WindowFlags::WINDOW_SHOWN
      @data = LibSDL.create_window(title, x, y, w, h, window_flags)
      SDC.error "Could not create window with title \"#{title}\"" unless @data

      renderer_flags = LibSDL::RendererFlags::RENDERER_ACCELERATED | LibSDL::RendererFlags::RENDERER_PRESENTVSYNC
      @renderer.create!(self, renderer_flags)
      SDC.error "Could not create renderer" unless @renderer.data?

      SDC.current_window = self if set_as_current
    end

    def open?
      data?
    end

    def clear
      LibSDL.set_render_draw_color(@renderer.data, 0xFF, 0xFF, 0xFF, 0xFF)
      LibSDL.render_clear(@renderer.data)
    end

    def draw_obj(obj : SDC::Drawable)
      # TODO: Replace this with a proper render queue
      obj.draw_directly
    end

    def render_and_display
      LibSDL.render_present(@renderer.data)
    end

    def close
      SDC.current_window = nil if SDC.current_window == self
      @renderer.free
      LibSDL.destroy_window(data)
      @data = nil
    end

    def finalize
      close
    end
  end
end
