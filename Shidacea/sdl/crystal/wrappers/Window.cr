module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Window
    @data : LibSDL::Window*?

    def initialize(title : String, w : Int, h : Int, x : Int = LibSDL::WINDOWPOS_UNDEFINED, y : Int = LibSDL::WINDOWPOS_UNDEFINED, fullscreen : Bool = false)
      window_flags = fullscreen ? LibSDL::WindowFlags::WINDOW_SHOWN | LibSDL::WindowFlags::WINDOW_FULLSCREEN : LibSDL::WindowFlags::WINDOW_SHOWN
      @data = LibSDL.create_window(title, x, y, w, h, window_flags)
      SDC.error "Could not create window with title \"#{title}\"" unless @data
    end

    @[Anyolite::Exclude]
    def data
      @data.not_nil!
    end

    def close
      LibSDL.destroy_window(data)
      @data = nil
    end

    def finalize
      close
    end
  end
end