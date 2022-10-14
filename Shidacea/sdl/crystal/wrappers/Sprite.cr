module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Sprite < SDC::Drawable
    @texture : SDC::Texture?
    
    property position : SDC::Coords = SDC.xy
    property source_rect : SDC::Rect?
    property render_rect : SDC::Rect?
    property angle : Float32 = 0.0f32

    def initialize(from_texture : SDC::Texture? = nil)
      super()
      @texture = from_texture
    end

    def link_texture(texture : SDC::Texture)
      @texture = texture
    end

    def draw_directly
      if tex = @texture
        tex.draw_extended(source_rect: @source_rect, render_rect: @render_rect, angle: @angle, position: @position)
      else
        SDC.warning "Sprite has no texture"
      end
    end
  end
end