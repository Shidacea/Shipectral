module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Window
    @data : LibSDL::Window*?
    @renderer : LibSDL::Renderer*

    def initialize(title : String, w : Int, h : Int, x : Int = LibSDL::WINDOWPOS_UNDEFINED, y : Int = LibSDL::WINDOWPOS_UNDEFINED, fullscreen : Bool = false)
      window_flags = fullscreen ? LibSDL::WindowFlags::WINDOW_SHOWN | LibSDL::WindowFlags::WINDOW_FULLSCREEN : LibSDL::WindowFlags::WINDOW_SHOWN
      @data = LibSDL.create_window(title, x, y, w, h, window_flags)
      SDC.error "Could not create window with title \"#{title}\"" unless @data

      renderer_flags = LibSDL::RendererFlags::RENDERER_ACCELERATED | LibSDL::RendererFlags::RENDERER_PRESENTVSYNC
      @renderer = LibSDL.create_renderer(data, -1, renderer_flags)
      SDC.error "Could not create renderer" unless @renderer
    end

    @[Anyolite::Exclude]
    def data
      @data.not_nil!
    end

    @[Anyolite::Exclude]
    def renderer
      @renderer
    end

    @[Anyolite::AddBlockArg(1, Nil)]
    def draw_routine
      LibSDL.set_render_draw_color(renderer, 0xFF, 0xFF, 0xFF, 0xFF)
      LibSDL.render_clear(renderer)
      yield nil
      LibSDL.render_present(renderer)
    end

    def close
      LibSDL.destroy_renderer(renderer)
      LibSDL.destroy_window(data)
      @data = nil
    end

    def finalize
      close
    end
  end
end