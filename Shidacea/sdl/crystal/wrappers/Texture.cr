module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Texture < SDC::Drawable
    SDCHelper.wrap_type(Pointer(LibSDL::Texture))

    @renderer : SDC::Renderer

    getter width : Int32 = 0
    getter height : Int32 = 0

    property position : SDC::Coords = SDC.xy

    def initialize(@renderer : SDC::Renderer = SDC.current_window.renderer)
    end

    def self.load_from_file(filename : String, renderer : SDC::Renderer = SDC.current_window.renderer)
      texture = SDC::Texture.new(renderer)
      texture.load_from_file!(filename)

      return texture
    end

    @[Anyolite::ReturnNil]
    def load_from_file!(filename : String)
      free

      loaded_surface = LibSDL.img_load(filename)
      SDC.error "Could not load image from file #{filename}" unless loaded_surface

      @data = LibSDL.create_texture_from_surface(@renderer.data, loaded_surface)
      SDC.error "Could not create texture from file #{filename}" unless @data

      @width = loaded_surface.value.w
      @height = loaded_surface.value.h

      LibSDL.free_surface(loaded_surface)
    end

    def draw_directly
      # TODO: Add more attributes here
      render_quad = LibSDL::Rect.new(x: @position.x, y: @position.y, w: @width, h: @height)

      LibSDL.render_copy_ex(@renderer.data, data, nil, pointerof(render_quad), 0.0, nil, LibSDL::RendererFlip::FLIP_NONE)
    end

    def free
      if @data
        LibSDL.destroy_texture(data)
        @data = nil
        @width = 0
        @height = 0
      end
    end

    def finalize 
      super
      free
    end
  end
end
