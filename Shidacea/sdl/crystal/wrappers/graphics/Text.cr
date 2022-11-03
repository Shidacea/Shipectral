module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Text < SDC::Drawable
    @texture : SDC::Texture

    getter text : String
    getter font : SDC::Font
    getter color : SDC::Color

    property position : SDC::Coords = SDC.xy
    property render_rect : SDC::Rect?
    property angle : Float32 = 0.0f32
    property center : SDC::Coords?

    def initialize(@text : String, @font : SDC::Font, @color : SDC::Color = SDC::Color.black)
      super()
      @texture = SDC::Texture.new
      update!
    end

    def text=(new_value : String)
      @text = new_value
      update!
    end

    def font=(new_value : SDC::Font)
      @font = new_value
      update!
    end

    def color=(new_value : SDC::Color)
      @color = new_value
      update!
    end

    def update!
      @texture.load_text_from_font!(@text, @font, color: @color)
    end

    def draw_directly
      final_source_rect = @texture.raw_int_boundary_rect
      final_render_rect = (render_rect = @render_rect) ? (render_rect + @position).data : @texture.raw_boundary_rect(shifted_by: @position)
      flip_flag = LibSDL::RendererFlip::FLIP_NONE
      if center = @center
        final_center_point = center.data
        LibSDL.render_copy_ex_f(@texture.renderer_data, @texture.data, pointerof(final_source_rect), pointerof(final_render_rect), @angle, pointerof(final_center_point), flip_flag)
      else
        LibSDL.render_copy_ex_f(@texture.renderer_data, @texture.data, pointerof(final_source_rect), pointerof(final_render_rect), @angle, nil, flip_flag)
      end
    end
  end
end