module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Texture < SDC::Drawable
    @data : LibSDL::Texture*?
    @window : SDC::Window

    getter width : Int32 = 0
    getter height : Int32 = 0

    def initialize(@window : SDC::Window)
    end

    def self.load_from_file(filename : String, window : SDC::Window)
      texture = SDC::Texture.new(window)
      texture.load_from_file!(filename)

      return texture
    end

    @[Anyolite::ReturnNil]
    def load_from_file!(filename : String)
      free

      loaded_surface = LibSDL.img_load(filename)
      SDC.error "Could not load image from file #{filename}" unless loaded_surface

      @data = LibSDL.create_texture_from_surface(@window.renderer, loaded_surface)
      SDC.error "Could not create texture from file #{filename}" unless @data

      @width = loaded_surface.value.w
      @height = loaded_surface.value.h

      LibSDL.free_surface(loaded_surface)
    end

    def draw_directly
      # TODO: Add more attributes here
      render_quad = LibSDL::Rect.new(x: 0, y: 0, w: @width, h: @height)

      LibSDL.render_copy_ex(@window.renderer, data, nil, pointerof(render_quad), 0.0, nil, LibSDL::RendererFlip::FLIP_NONE)
    end

    @[Anyolite::Exclude]
    def data
      @data.not_nil! 
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
      free
    end
  end
end