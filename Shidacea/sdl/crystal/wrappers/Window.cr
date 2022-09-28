module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Window
    SDCHelper.wrap_type(LibSDL::Window)

    getter renderer : SDC::Renderer = SDC::Renderer.new

    def initialize(title : String, w : Int, h : Int, x : Int = LibSDL::WINDOWPOS_UNDEFINED, y : Int = LibSDL::WINDOWPOS_UNDEFINED, fullscreen : Bool = false)
      window_flags = fullscreen ? LibSDL::WindowFlags::WINDOW_SHOWN | LibSDL::WindowFlags::WINDOW_FULLSCREEN : LibSDL::WindowFlags::WINDOW_SHOWN
      @data = LibSDL.create_window(title, x, y, w, h, window_flags)
      SDC.error "Could not create window with title \"#{title}\"" unless @data

      renderer_flags = LibSDL::RendererFlags::RENDERER_ACCELERATED | LibSDL::RendererFlags::RENDERER_PRESENTVSYNC
      @renderer.create!(self, renderer_flags)
      SDC.error "Could not create renderer" unless @renderer.data?
    end

    def open?
      data?
    end

    def draw(obj : SDC::Drawable)
      # TODO: Replace this with a render queue
      obj.draw_directly
    end

    @[Anyolite::AddBlockArg(1, Nil)]
    def draw_routine
      LibSDL.set_render_draw_color(@renderer.data, 0xFF, 0xFF, 0xFF, 0xFF)
      LibSDL.render_clear(@renderer.data)
      yield nil
      LibSDL.render_present(@renderer.data)
    end

    def close
      @renderer.free
      LibSDL.destroy_window(data)
      @data = nil
    end

    def finalize
      close
    end
  end
end
