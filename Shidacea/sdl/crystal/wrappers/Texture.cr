module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Texture < SDC::Drawable
    SDCHelper.wrap_type(Pointer(LibSDL::Texture))

    @renderer : SDC::Renderer

    getter width : Int32 = 0
    getter height : Int32 = 0

    property offset : SDC::Coords = SDC.xy

    def initialize(@renderer : SDC::Renderer = SDC.current_window.renderer)
      super()
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
      render_rect = LibSDL::Rect.new(x: @offset.x, y: @offset.y, w: @width, h: @height)
      LibSDL.render_copy_ex(@renderer.data, data, nil, pointerof(render_rect), 0.0, nil, LibSDL::RendererFlip::FLIP_NONE)
    end

    # TODO: This could potentially be optimized
    def draw_extended(source_rect : SDC::Rect? = nil, render_rect : SDC::Rect? = nil, angle : Number = 0.0, position : SDC::Coords = SDC.xy)
      final_source_rect = source_rect ? source_rect.data : LibSDL::Rect.new(x: @offset.x, y: @offset.y, w: @width, h: @height)
      final_render_rect = render_rect ? (render_rect + position).data : LibSDL::Rect.new(x: @offset.x + position.x, y: @offset.y + position.y, w: @width, h: @height)
      LibSDL.render_copy_ex(@renderer.data, data, pointerof(final_source_rect), pointerof(final_render_rect), angle, nil, LibSDL::RendererFlip::FLIP_NONE)
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
