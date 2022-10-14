module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Window
    SDCHelper.wrap_type(Pointer(LibSDL::Window))

    property z_offset : UInt8 = 0

    getter renderer : SDC::Renderer = SDC::Renderer.new
    getter render_queue : SDC::RenderQueue = SDC::RenderQueue.new

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

    def position
      LibSDL.get_window_position(data, out x, out y)
      SDC::Coords.new(x, y)
    end

    def position=(coords : SDC::Coords)
      LibSDL.set_window_position(data, coords.x, coords.y)
    end

    def clear
      LibSDL.set_render_draw_color(@renderer.data, 0xFF, 0xFF, 0xFF, 0xFF)
      LibSDL.render_clear(@renderer.data)
    end

    @[Anyolite::ReturnNil]
    def draw(obj : SDC::Drawable)
      @render_queue.add(obj, @z_offset + obj.z)
    end

    @[Anyolite::ReturnNil]
    def pin(obj : SDC::Drawable)
      @render_queue.add_static(obj, @z_offset + obj.z)
    end

    def unpin(obj : SDC::Drawable)
      @render_queue.delete_static(obj, @z_offset + obj.z)
    end

    def unpin_all
      @render_queue.delete_static_content
    end

    @[Anyolite::AddBlockArg(1, Nil)]
    def with_z_offset(z_offset : UInt8)
      @z_offset += z_offset
      yield nil
      @z_offset -= z_offset
    end

    def render_and_display
      @render_queue.draw
      LibSDL.render_present(@renderer.data)
    end

    def close
      SDC.current_window = nil if SDC.current_window == self
      @renderer.free
      LibSDL.destroy_window(data)
      @data = nil
    end

    def finalize
      unpin_all
      close
    end
  end
end
