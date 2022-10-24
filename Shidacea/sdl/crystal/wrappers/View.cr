module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class View < SDC::Drawable
    @data : LibSDL::Rect
    @renderer : SDC::Renderer?

    def initialize(rect : SDC::Rect, @renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super()
      @data = LibSDL::Rect.new(x: rect.x, y: rect.y, w: rect.width, h: rect.height)
    end

    def x
      @data.x
    end

    def x=(value : Number)
      @data.x = value
    end

    def y
      @data.y
    end

    def y=(value : Number)
      @data.y = value
    end
    
    def width
      @data.w
    end

    def width=(value : Number)
      @data.w = value
    end

    def height
      @data.h
    end

    def height=(value : Number)
      @data.h = value
    end

    @[Anyolite::Exclude]
    def initialize
      @data = LibSDL::Rect.new
    end

    @[Anyolite::Exclude]
    def initialize(raw_rect : LibSDL::Rect, @renderer : SDC::Renderer)
      super()
      @data = raw_rect
    end

    def draw_directly
      @renderer.not_nil!.view = self
    end

    @[Anyolite::Exclude]
    def raw_data_ptr
      pointerof(@data)
    end
  end
end