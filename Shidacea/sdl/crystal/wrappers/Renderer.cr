module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Renderer
    SDCHelper.wrap_type(LibSDL::Renderer)

    def initialize
    end

    # TODO: Put flags in SDC module
    def create!(from : SDC::Window, flags : LibSDL::RendererFlags = LibSDL::RendererFlags::RENDERER_ACCELERATED)
      free
      @data = LibSDL.create_renderer(from.data, -1, flags)
    end

    def free
      if @data
        LibSDL.destroy_renderer(data)
        @data = nil
      end
    end

    def finalize
      free
    end
  end
end
