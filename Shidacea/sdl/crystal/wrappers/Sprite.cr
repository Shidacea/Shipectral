module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Sprite < SDC::Drawable
    @texture : SDC::Texture?
    
    property position : SDC::Coords = SDC.xy
    property source_rect : SDC::Rect?
    property render_rect : SDC::Rect?
    property angle : Float32 = 0.0f32
    property center : SDC::Coords?

    def initialize(from_texture : SDC::Texture? = nil, source_rect : SDC::Rect? = nil)
      super()
      @source_rect = source_rect
      @texture = from_texture
    end

    def link_texture(texture : SDC::Texture)
      @texture = texture
    end

    def draw_directly
      if tex = @texture
        final_source_rect = (source_rect = @source_rect) ? source_rect.int_data : tex.raw_int_boundary_rect
        final_render_rect = (render_rect = @render_rect) ? (render_rect + @position).data : tex.raw_boundary_rect(shifted_by: @position)
        flip_flag = LibSDL::RendererFlip::FLIP_NONE
        if center = @center
          final_center_point = center.data
          LibSDL.render_copy_ex_f(tex.renderer_data, tex.data, pointerof(final_source_rect), pointerof(final_render_rect), @angle, pointerof(final_center_point), flip_flag)
        else
          LibSDL.render_copy_ex_f(tex.renderer_data, tex.data, pointerof(final_source_rect), pointerof(final_render_rect), @angle, nil, flip_flag)
        end
      else
        SDC.warning "Sprite has no texture"
      end
    end
  end
end