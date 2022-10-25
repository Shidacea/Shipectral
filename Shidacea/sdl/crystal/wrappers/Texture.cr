module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Texture < SDC::Drawable
    SDCHelper.wrap_type(Pointer(LibSDL::Texture))

    @renderer : SDC::Renderer

    getter width : Int32 = 0
    getter height : Int32 = 0

    property offset : SDC::Coords = SDC.xy

    def initialize(@renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super()
    end

    def self.load_from_file(filename : String, renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
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

    def load_text_from_font!(text : String, font : SDC::Font, color : SDC::Color = SDC::Color::BLACK)
      free

      text_surface = LibSDL.ttf_render_text_solid(font.data, text, color.data)
      SDC.error "Could not create texture from rendered text" unless text_surface

      @data = LibSDL.create_texture_from_surface(@renderer.data, text_surface)
      raise "Could not create texture from rendered text surface" unless @data

      @width = text_surface.value.w
      @height = text_surface.value.h

      LibSDL.free_surface(text_surface)
    end

    @[Anyolite::Exclude]
    def raw_boundary_rect(shifted_by : SDC::Coords = SDC.xy)
      LibSDL::FRect.new(x: @offset.x + shifted_by.x, y: @offset.y + shifted_by.y, w: @width, h: @height)
    end

    @[Anyolite::Exclude]
    def raw_int_boundary_rect(shifted_by : SDC::Coords = SDC.xy)
      LibSDL::Rect.new(x: @offset.x + shifted_by.x, y: @offset.y + shifted_by.y, w: @width, h: @height)
    end

    @[Anyolite::Exclude]
    def renderer_data
      @renderer.data
    end

    def draw_directly
      render_rect = raw_boundary_rect
      LibSDL.render_copy_ex_f(@renderer.data, data, nil, pointerof(render_rect), 0.0, nil, LibSDL::RendererFlip::FLIP_NONE)
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
