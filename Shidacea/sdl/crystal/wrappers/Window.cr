module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Window
    @data : LibSDL::Window*?

    def initialize(title : String)
      #@data = LibSDL.create_window(title, x, y, w, h, flags)
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